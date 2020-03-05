Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
 by mx.groups.io with SMTP id smtpd.web10.11626.1583410560891560242
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Mar 2020 04:16:01 -0800
Received: by mail-il1-f194.google.com with SMTP id q13so4819634ile.8
        for <u-boot-amlogic@groups.io>; Thu, 05 Mar 2020 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAtTx0i/vh9NXbEVpZo5/0mvmgVeDSL/vEXCnp10mik=;
        b=goYt+QzsVdJB9Op3lJlMBd0PElKswiIPK8/JkuoRSbmIL+4OnyJ80IeMSgkkUBtbo7
         Pp9602Hq7NYtyfsj3e7eRrrKoBNQNwuEcbeolO8pF5gDJFcdgrwO28QOy6lf+9SNBCry
         9KSgGZPYgbWPtAacKH/vPzvHOIskUwb7ZVkBt6gNL3KmQc3ETP7ApG2EUOyIOlt2+Kp7
         Q1cuYKTxg7HH5a90LzpnNJ2R0Fe9uw7lEGnDsOwAmMprSJ8ccgoyJcrkEUwFelE+qsWT
         6gE8TRblm5tnz/0EElFHq09r7GtBVXIEOIRbHoU9sy7ix7BtOQ9eFmbMZSFZuMaW1ldi
         4hUg==
MIME-Version: 1.0
References: <20200305111240.129010-1-jbrunet@baylibre.com> <20200305111240.129010-3-jbrunet@baylibre.com>
In-Reply-To: <20200305111240.129010-3-jbrunet@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 5 Mar 2020 17:45:48 +0530
Message-ID: <CANAwSgTsmi_868V-LY3HbCQEa2xfVY5kGMmteh_d2xsAt6sozA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mmc: meson-gx: enable input clocks
Content-Type: text/plain; charset="UTF-8"
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Jerome,

On Thu, 5 Mar 2020 at 16:43, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Until now, the mmc clock was left in a good enough state by the ROM
> code to be used by the controller. However on some SoC, if the ROM
> code finds a bootloader on USB or SPI, it might leave the MMC clock
> in state the controller cannot work with.
>
> Enable the input clocks provided to the mmc controller. While the
> u-boot mmc controller driver is not doing fancy settings like the Linux,
> it at least needs to make these clocks are running.
>

Please add my
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

-Anand

> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index b5f5122b1b7b..86c1a7164a93 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <common.h>
> +#include <clk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <fdtdec.h>
> @@ -241,12 +242,23 @@ static int meson_mmc_probe(struct udevice *dev)
>         struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
>         struct mmc *mmc = &pdata->mmc;
>         struct mmc_config *cfg = &pdata->cfg;
> +       struct clk_bulk clocks;
>         uint32_t val;
> +       int ret;
> +
>  #ifdef CONFIG_PWRSEQ
>         struct udevice *pwr_dev;
> -       int ret;
>  #endif
>
> +       /* Enable the clocks feeding the MMC controller */
> +       ret = clk_get_bulk(dev, &clocks);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_enable_bulk(&clocks);
> +       if (ret)
> +               return ret;
> +
>         cfg->voltages = MMC_VDD_33_34 | MMC_VDD_32_33 |
>                         MMC_VDD_31_32 | MMC_VDD_165_195;
>         cfg->host_caps = MMC_MODE_8BIT | MMC_MODE_4BIT |
> --
> 2.24.1
>
