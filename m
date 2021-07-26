Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.27192.1627284946340081253
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Jul 2021 00:35:47 -0700
Received: by mail-wr1-f54.google.com with SMTP id c16so7020wrp.13
        for <u-boot-amlogic@groups.io>; Mon, 26 Jul 2021 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hJJq1l93dksRUl+keknM+4ifXjXS3uRAwFm1cXl1DzU=;
        b=Cl9LXBpJM3knTLCR5NVpgSU+vaccL9ECuhMGKfiKAxbgeirXeCis2BWH4l3VhJ6Aq6
         T1r69vJny9+9bzdQf8Dvf669T7xsPtBwCsjuL75M0UkOYfb+Tp0WPHUQgh71Sn7feBIU
         cQiyQ6p5jdde4QkYgE890AdRXfWNHfmIyvCaPKlDLnf17tYPt+6FlE73XR+FDdDFzDeJ
         wisyVNV+uAoT19ZVtzxTtorbSdBGVKDatfi1TNLVi/O18BUr2mAsl7Kjsqzf2hmCC+oD
         wrMLkPRNTvNntRDFMDIIXdlPLjRLJmjYRdWFjiCIjRLVT5U6wN0OQdy81uXFuSSWy4YE
         fZtA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: fix phy-names property setup
References: <20210713064847.2468652-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6e5ee9ea-f787-01a9-083d-c828a933381d@baylibre.com>
Date: Mon, 26 Jul 2021 09:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <20210713064847.2468652-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 13/07/2021 08:48, Artem Lapkin wrote:
> phy-names was improperly implemented resulting in an inoperable USB-OTG
> port.
> 
> - phy-names = "usb2-phy0\0\0usb2-phy1\0";
> + phy-names = "usb2-phy0\0usb2-phy1";
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index c8ebd676..6a67a39c 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -109,8 +109,8 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>  		}
>  
>  		/* Update PHY names (mandatory to disable USB3.0) */
> -		len = strlcpy(data, "usb2-phy0", 32) + 1;
> -		len += strlcpy(&data[len], "usb2-phy1", 32 - len) + 1;
> +		len = strlcpy(data, "usb2-phy0", 32);
> +		len += strlcpy(&data[len], "usb2-phy1", 32 - len);
>  		ret = fdt_setprop(blob, node, "phy-names", data, len);
>  		if (ret < 0) {
>  			printf("vim3: failed to update usb phy names property (%d)\n", ret);
> 

Good catch,

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil
