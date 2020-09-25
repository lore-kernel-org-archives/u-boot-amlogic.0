Received: from azure2.cottsay.net (azure2.cottsay.net [104.41.151.152])
 by mx.groups.io with SMTP id smtpd.web11.7353.1601066477950342135
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2020 13:41:18 -0700
Message-ID: <af66ec1be1832769b8eb84b394b5f6c3b80d7dae.camel@cottsay.net>
Subject: Re: [PATCH] rng: meson: make core clock optional
From: Scott K Logan <logans@cottsay.net>
Date: Fri, 25 Sep 2020 13:41:15 -0700
In-Reply-To: <20200925071920.9211-1-narmstrong@baylibre.com>
References: <20200925071920.9211-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, sughosh.ganu@linaro.org
Cc: u-boot-amlogic@groups.io, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

On Fri, 2020-09-25 at 09:19 +0200, Neil Armstrong wrote:
> This fixes HWRNG support on Amlogic GXL, GXM, G12A, G12B & SM1
> based boards dues to the lack of the core clock in the device tree.
> 
> It was reported breaking EFI boot in the Linux EFI stub, because the
> EFI_RNG_PROTOCOL didn't check for the RNG device presence before
> installing itself.
> 
> The Linux amlogic,meson-rng.yaml doesn't mandate the core clock,
> this the clock should be ignores if not present.
> 
> Nevertheless, the clock should be present and this should be fixed
> on the Linux meson-gxl.dtsi & meson-g12-common.dtsi then synced
> with U-Boot.
> 
> The change has been tested on a Khadas VIM3, which uses the common
> meson-g12-common.dtsi like the Odroid-C4 & Odroid-N2 in Scott's
> report, along with the RNG cmd.
> 
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reported-by: Scott K Logan <logans@cottsay.net>
> Fixes: bc40eb278b ("drivers/rng: add Amlogic hardware RNG driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/rng/meson-rng.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> index 4b81a62353..57a5a702a2 100644
> --- a/drivers/rng/meson-rng.c
> +++ b/drivers/rng/meson-rng.c
> @@ -90,8 +90,9 @@ static int meson_rng_ofdata_to_platdata(struct
> udevice *dev)
>  	if (!pdata->base)
>  		return -ENODEV;
>  
> +	/* Get optional "core" clock */
>  	err = clk_get_by_name(dev, "core", &pdata->clk);
> -	if (err)
> +	if (err && err != -ENODATA)
>  		return err;
>  
>  	return 0;
> -- 
> 2.22.0

Tested-by: Scott K Logan <logans@cottsay.net>

