Received: by mail-wr1-f65.google.com with SMTP id z1so68393620wru.13
        for <u-boot-amlogic@groups.io>; Wed, 31 Jul 2019 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D0IeKtprMs2w7jKtp0CQhJJT284eEaE8In3Ae3d7yZo=;
        b=qDhBd+l1bDAn7A3DVapFsREE9t7UqArxla/mcGOFdAFOtEG6/p7A91XQxMMntfxTLN
         +bvmppJ/mE1K3cQ3W47/rAyLCXqQdPTEZify7FJfrWk7OxxpCFku2rNhk+fYvAWOVnTN
         J++MDdTI5QSXDfxg3jjMz+57efcNocKgFIvjVnrKYWlN7HosoKV3etd+pqvSPT9iz1ng
         izARPTsCfKlqjN6q0mL9sUbieTRA2Ql2CC6QIRr0ldDQyBhP+B8LOQCjtMl4lGjmXL9V
         cQyAa1fLucHb2/0wFQkSV5sU6BZfxcDDcNinmJhprBx+3gGNxOwpR/JDJZ7+OTygyAQJ
         1Vig==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/1] clk: meson: remove duplicate logic
References: <20190730210343.24173-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <1e6ffd87-321b-d4af-9c4c-7d236e907243@baylibre.com>
Date: Wed, 31 Jul 2019 09:17:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190730210343.24173-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 30/07/2019 23:03, Heinrich Schuchardt wrote:
> First thing we check in meson_clk_set_rate_by_id() is current_rate == rate.
> There is not need to check it again.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/clk/meson/gxbb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 2cb53fb92d..abb5337e78 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -823,10 +823,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
>  	case CLKID_MPLL1:
>  	case CLKID_MPLL2:
>  	case CLKID_CLK81:
> -		if (current_rate != rate)
> -			return -EINVAL;
> -
> -		return 0;
> +		return -EINVAL;
>  	case CLKID_VPU:
>  		return meson_clk_set_rate_by_id(clk,
>  				meson_mux_get_parent(clk, CLKID_VPU), rate,
> --
> 2.20.1
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied on u-boot-amlogic

Thanks,
Neil
