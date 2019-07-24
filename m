Received: by mail-wr1-f67.google.com with SMTP id z1so45661338wru.13
        for <u-boot-amlogic@groups.io>; Wed, 24 Jul 2019 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=07fNFOGJzmueDGxNhfASoix83V4RSqtQw+uj7KY58lc=;
        b=bVEsHLyVHThbv8YlnxRMMLec5dPGP75Y5Yr6TKvEZccCz/DC1NGpVh9u6YHpLBUKlY
         ptzexWxbqT5DMqI+Lvk6tu0/09PosPK+ZzhTRUTW7Z/MlF60etQqEsXe8Y/ZcT8wkxB4
         ckv08nlmLtOs/vM0+k/J9NdotY332YA/BZiB9urEksNFs9EhTALFSmNkE/beSp/CqQfp
         Ub9vLqRNGCWVTcD6Ie07shZbiELFWOu7nzQRmzRH8NozekId/VVEs6WCL15/u6yAAzqR
         JvJhlTVAwgjM68Lpnzermquipeqk9OVZkn64Kp85YmCAnC1x8TBVtkoMsxgxKkrITkDN
         Sa1w==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/3] edid: add edid_get_timing_validate() variant to filter out edid modes
References: <20190704135208.32104-1-narmstrong@baylibre.com>
 <20190704135208.32104-2-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d8c0590f-7c3b-02ec-502a-03ef1ffaf903@baylibre.com>
Date: Wed, 24 Jul 2019 09:14:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190704135208.32104-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 04/07/2019 15:52, Neil Armstrong wrote:
> The original edid_get_timing() function returns the first valid timing,
> but on some plaforms, we could only supports a subset of the listed
> monitot's navite timing.
> 
> Let's introduce a edid_get_timing_validate() adding a mode_valid callback
> including a private cookie pointer.
> 
> If the callback returns false, the current timing is discared and the next
> one is checked. If no valid & supported timings are found, the function
> would return an error.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  common/edid.c  | 22 +++++++++++++++++++---
>  include/edid.h | 22 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/common/edid.c b/common/edid.c
> index 90d1167f6e..f244d26e04 100644
> --- a/common/edid.c
> +++ b/common/edid.c
> @@ -168,8 +168,12 @@ static bool cea_is_hdmi_vsdb_present(struct edid_cea861_info *info)
>  	return false;
>  }
>  
> -int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
> -		    int *panel_bits_per_colourp)
> +int edid_get_timing_validate(u8 *buf, int buf_size,
> +			     struct display_timing *timing,
> +			     int *panel_bits_per_colourp,
> +			     bool (*mode_valid)(void *priv,
> +					const struct display_timing *timing),
> +			     void *mode_valid_priv)
>  {
>  	struct edid1_info *edid = (struct edid1_info *)buf;
>  	bool timing_done;
> @@ -193,7 +197,11 @@ int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
>  		desc = &edid->monitor_details.descriptor[i];
>  		if (desc->zero_flag_1 != 0) {
>  			decode_timing((u8 *)desc, timing);
> -			timing_done = true;
> +			if (mode_valid)
> +				timing_done = mode_valid(mode_valid_priv,
> +							 timing);
> +			else
> +				timing_done = true;
>  			break;

the break is wrong, it should be :

			if (timing_done)
				break;

I'll send a v2.

Neil

>  		}
>  	}
> @@ -225,6 +233,14 @@ int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
>  	return 0;
>  }
>  
> +int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
> +		    int *panel_bits_per_colourp)
> +{
> +	return edid_get_timing_validate(buf, buf_size, timing,
> +					panel_bits_per_colourp, NULL, NULL);
> +}
> +
> +
>  /**
>   * Snip the tailing whitespace/return of a string.
>   *
> diff --git a/include/edid.h b/include/edid.h
> index f05d2b82f2..2562733061 100644
> --- a/include/edid.h
> +++ b/include/edid.h
> @@ -306,6 +306,28 @@ int edid_get_ranges(struct edid1_info *edid, unsigned int *hmin,
>  
>  struct display_timing;
>  
> +/**
> + * edid_get_timing_validate() - Get basic digital display parameters with
> + * mode selection callback
> + *
> + * @param buf		Buffer containing EDID data
> + * @param buf_size	Size of buffer in bytes
> + * @param timing	Place to put preferring timing information
> + * @param panel_bits_per_colourp	Place to put the number of bits per
> + *			colour supported by the panel. This will be set to
> + *			-1 if not available
> + * @param mode_valid	Callback validating mode, returning true is mode is
> + *			supported, false otherwise.
> + * @parem valid_priv	Pointer to private data for mode_valid callback
> + * @return 0 if timings are OK, -ve on error
> + */
> +int edid_get_timing_validate(u8 *buf, int buf_size,
> +			     struct display_timing *timing,
> +			     int *panel_bits_per_colourp,
> +			     bool (*mode_valid)(void *priv,
> +					const struct display_timing *timing),
> +			     void *mode_valid_priv);
> +
>  /**
>   * edid_get_timing() - Get basic digital display parameters
>   *
> 

