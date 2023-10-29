Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36905C4332F
	for <webhook@archiver.kernel.org>; Sun, 29 Oct 2023 14:34:05 +0000 (UTC)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
 by mx.groups.io with SMTP id smtpd.web11.72624.1698587251759763143
 for <u-boot-amlogic@groups.io>;
 Sun, 29 Oct 2023 06:47:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@protonmail.com header.s=protonmail3 header.b=UQGtkMI9;
 spf=pass (domain: protonmail.com, ip: 185.70.40.132, mailfrom: vitali64pmemail@protonmail.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1698587249; x=1698846449;
	bh=d4Wg48Xany3wSTnnMBeRcCoucbuT39teSIr+ET/WZtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UQGtkMI9ezdbBXr+IMxMmMZjHVPb1HqYQMuuLNnq1si5qoTwX36W6L1AeM9ySaotp
	 oqOp0E5XdNmkLEst1KCrplbtkMoNGOjaLlOoNepH5asMoAub4tlo4KRwaO/Gz/85BO
	 lfmGmiCAyvZzHFPhne3NzQc4qb+ShijNpuvPZNulgzLEWXZeKUYmofvCebUTw37qQV
	 bJVPr03oE0j+rW8T2S8acH+kH44Yivr70Or0H1TwTLxMJktGs+WItPDu4m25pNDo2u
	 A28hBwtysaaTM/2y7wMuAu9CD/6F0G5nq3Y6fcM+Is+HaEZ/jiidjiUNXPUGXtYr4A
	 ouypPImxi5PVw==
Date: Sun, 29 Oct 2023 13:47:11 +0000
To: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: [PATCH] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building SPL
Message-ID: <CWKYWJZD8BHH.JWDZOB308Z3P@protonmail.com>
In-Reply-To: <20230925215516.1528643-1-jonas@kwiboo.se>
References: <20230925215516.1528643-1-jonas@kwiboo.se>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 29 Oct 2023 14:34:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1806

Hi,

On Mon Sep 25, 2023 at 11:55 PM CEST, Jonas Karlman wrote:
> With MMC_PWRSEQ enabled the following link issue may happen when
> building SPL and SPL_PWRSEQ is not enabled.
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meso=
n_mmc_probe':
>   drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_powe=
r'
>
> Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
> pwrseq support in SPL.
>
> Also add depends on DM_GPIO to fix following link issue:
>
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pw=
rseq_set_power':
>   drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_na=
me'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined refere=
nce to `dm_gpio_set_value'
>   aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined refere=
nce to `dm_gpio_set_value'
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/mmc/Kconfig           | 10 +++++++++-
>  drivers/mmc/Makefile          |  2 +-
>  drivers/mmc/meson_gx_mmc.c    |  2 +-
>  drivers/mmc/rockchip_dw_mmc.c |  2 +-
>  include/mmc.h                 |  4 ++--
>  5 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index de01b9687bad..a9931d39412d 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -20,11 +20,19 @@ config MMC_WRITE
>
>  config MMC_PWRSEQ
>  	bool "HW reset support for eMMC"
> -	depends on PWRSEQ
> +	depends on PWRSEQ && DM_GPIO
>  	help
>  	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
>  	  devices.
>
> +config SPL_MMC_PWRSEQ
> +	bool "HW reset support for eMMC in SPL"
> +	depends on SPL_PWRSEQ && SPL_DM_GPIO
> +	default y if MMC_PWRSEQ
> +	help
> +	  Ths select Hardware reset support aka pwrseq-emmc for eMMC

nit: 'Ths'->'This'

Seems to be the same earlier, in MMC_PWRSEQ

> +	  devices in SPL.
> +
>  config MMC_BROKEN_CD
>  	bool "Poll for broken card detection case"
>  	help
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 2c65c4765ab2..0a79dd058bef 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) +=3D mmc_bootdev.o
>  endif
>
>  obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) +=3D mmc_write.o
> -obj-$(CONFIG_MMC_PWRSEQ) +=3D mmc-pwrseq.o
> +obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) +=3D mmc-pwrseq.o
>  obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) +=3D sdhci-adma.o
>
>  ifndef CONFIG_$(SPL_)BLK
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index fcf4f03d1e24..0825c0a2a838 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
>
>  	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
>
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	/* Enable power if needed */
>  	ret =3D mmc_pwrseq_get_power(dev, cfg);
>  	if (!ret) {
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.=
c
> index 72c820ee6330..ad4529d6afa8 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>
>  	host->fifo_mode =3D priv->fifo_mode;
>
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	/* Enable power if needed */
>  	ret =3D mmc_pwrseq_get_power(dev, &plat->cfg);
>  	if (!ret) {
> diff --git a/include/mmc.h b/include/mmc.h
> index 1022db3ffa7c..9aef31ea5deb 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -590,7 +590,7 @@ struct mmc_config {
>  	uint f_max;
>  	uint b_max;
>  	unsigned char part_type;
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  	struct udevice *pwr_dev;
>  #endif
>  };
> @@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
>   */
>  int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
>
> -#ifdef CONFIG_MMC_PWRSEQ
> +#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
>  /**
>   * mmc_pwrseq_get_power() - get a power device from device tree
>   *
> --
> 2.42.0

Otherwise, looks good to me.

Acked-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>


