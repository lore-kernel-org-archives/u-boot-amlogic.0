Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F8910F285A
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:38 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20333.1774438448550852905
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Mar 2026 04:34:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GG5noTCC;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: pbrobinson@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-661d20c9787so3428686a12.0
        for <u-boot-amlogic@groups.io>; Wed, 25 Mar 2026 04:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774438447; cv=none;
        d=google.com; s=arc-20240605;
        b=bdoJRM21w2uF503+XcjkQiSzBeUnk3nLJox0oA0DqqcrpiChzyyS0ri9ymwpVfO/oa
         WI87jzGfmcXRGlaHJUwOe4gZVPKvjNfu9jdi6YMeBRQNPY35AR+156sSnQlbpzY8zlBP
         qrCSaRMewCFkNnGc6Q/QHK4fP3sfNeW+7tro2MX1AEH3WAmcwBHrS4REYvXFVxDVqRet
         OXdFe45rfxVH1iOPWOx+GqdbseuFmw5OmAUZg1E7dhJgkzdscu0hAXqi2LrKyj0pMkud
         tbmnNw3qiWv73nnG9dsv7lPfSp3WurrKHHEK3n0XtE1+F6FKc1R/7oMFiHnoBuikfHtW
         QtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qs5gzlIS+uf8YHXp02MjPeJMEKTOzlO200dgux8Sahc=;
        fh=a+zL9vAXXucuIyA8NYy0E0vF/TB+5Kh7kW3QlI9MCO0=;
        b=Xt89KR1P3KxDISZ2IlZD+mh4TTsBPtHIulup+B3nJm8b4uJL2BASwlYdIV0CtuLLes
         k3ZNtF4VculnBDW5LhTaDx75gA4BPdJqv7R2m8bEW4dIOGxkBy57Dm9FTKBr10ZND+AW
         XOXAApFM1ZQJgHzV+8+ktZmPa9MU5zaJbofeQy9WsUHRmoTKFcWbqCA0FCQXoiRx0Vqi
         MhckDHmTKviHfTKInvrnsrl8IIIfsoq1QYfZyGuVsXfrBbEKFgflSr6HPvlUpBlzwJl5
         paL8TbnMIuLmotZdJiCxRR94WH2H+qdGFcfjk2mgG1hMybYxjqKOLKcYRg3qQnHL9eJi
         Oc9g==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774438447; x=1775043247; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs5gzlIS+uf8YHXp02MjPeJMEKTOzlO200dgux8Sahc=;
        b=GG5noTCCi3qwLqzvDmpboo32yXsn5ZOLw8Czq+BC0B6iD7J7musflSakz5h+57wS1K
         CMgN602MFpXeKFKMMLJGPgb19y+nUcKB9Go5ewXMnlAZSamfdzeJBOOJBMHWsk7+V9q+
         uKjhBMerp8xOWIy3QJAVQpeoyKF64QKixKOOzcLOaCQ7pqfPZIICPIQ+FQnaiQWwhznW
         qpGlUOwcSZQFmHIJC4OkBTsHTpK9ynS2qbwhEafvufd708Guhsq2lCEuLP7MQFwXITZ+
         axAV7oSYCKabv+LisAtuXsx+P/ZAjyPEGhJ1Td47SVv6TkdBk+91j7gVO5hNOt+8Y+4E
         +buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774438447; x=1775043247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qs5gzlIS+uf8YHXp02MjPeJMEKTOzlO200dgux8Sahc=;
        b=jiN6he8WTRk9s9uzOBvCyBah500SczH2RXKXKZJe3wDmS22laImhmLwlC/DrhkhTJe
         zvrizcl251g/5cti1B6mcoxfromUGDmmTOCQ1Yz/2j1KFzRsaXijLvXaHLs13kD0hRtM
         gaTWk7f5EQkgW37AskEFf9StJHAnljZK3uzNwDz10s5YxaQDcEd5X7SWQcl5GIz8W1ae
         PSvcVIY6k3pY4NbHd09xLJJjecUlSFNhrQtKDEpqjTEXXABZWI/ckjSkVHgMBGZRhbPr
         nF6NUPlx70bvWV3bcpuroOzBNIx1xWls+LcZYvXavtXiYwuUil2e+HvCgOhUqvJ23HS8
         NEgA==
X-Forwarded-Encrypted: i=1; AJvYcCWl/ywJNYdMOY+nYgbNlx+DH1dX74u0R+O+VI053LOGycVO4DVGoHn/Vkxczp1H5wcHAR9Ju1GXQEazVL9rtg==@groups.io
X-Gm-Message-State: AOJu0YxnYc4A5pG5zGFF+4viRmd6Zkh/zRyhF1J9faRLI0ZkpLeOzOyW
	EjEw+4Gz322iuDB/GOjSEaMmlpDOdoCFQngj4eJYa//SsOXz3DToo8dzg0XKBMGOAIi6/kkF9p9
	snASYgA9p415h93j25wUlFLdb+OvBMJe0EUBG
X-Gm-Gg: ATEYQzwDcio88o18TaroWThzICB7zpXJIymY5MMNpXnU0RAdnItk4FFRjYKzGYhwntG
	6OQLREgX+kHMs4bkVyKOxRLKeNjic3lxS6a4nOOUUPXW2KJWncJ5ZvoIRHVXAHWEdh0v8Wm0RIM
	pLMq3DgyWLYiORluOsGJvlkeduwfVvsvbYVFJOEkvIgflaC58XKD2GW8B6YpkpfP5l27wRLtyD3
	K5MTQ2Le4OSRrptABCTZJc1uYrH2I2iR+l6UPOOEfUsiT5zHUy6eo3ecuU7CNArR8PJ5OsUaz0y
	FekslbWBfUmATkiDchqTI4NPhiAeNmPL0N/trI0/3/yP8nOrKF4Qvm2yAFocSRp0oD5tmwA+XKY
	d2FV3jeD43uHOLKEaLzYWF9NRGImMuTyXuZ83JBwwAFU7/rrMEDVi9bvVWku8NnJfHTDziDVolc
	BB
X-Received: by 2002:a17:907:3588:b0:b98:28d2:ed6b with SMTP id
 a640c23a62f3a-b9a5429d8a1mr147334466b.47.1774438042358; Wed, 25 Mar 2026
 04:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260323225537.896180-1-trini@konsulko.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 25 Mar 2026 11:27:10 +0000
X-Gm-Features: AQROBzBoXWtEe6BCH-3oJ5ChDCA11HLoQqkOGWeZJkPpz4LEq05lZZquQCsPkV0
Message-ID: <CALeDE9OAFyaonJohEj7Q3EA99ttCPKEevFmWpfiOQNpV5AA-+A@mail.gmail.com>
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
	Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
	Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jerome Forissier <jerome.forissier@arm.com>, Kever Yang <kever.yang@rock-chips.com>, 
	=?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, Matthias Brugger <mbrugger@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
	Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, 
	Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
	uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io, 
	linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 27 Mar 2026 16:57:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2940

On Mon, 23 Mar 2026 at 22:55, Tom Rini <trini@konsulko.com> wrote:
>
> The U_BOOT_DRIVER macro creates a list of drivers used at link time, and
> all entries here must be unique. This in turn means that all entries in
> the code should also be unique in order to not lead to build failures
> later with unexpected build combinations. Typically, the problem we have
> here is when a driver is obviously based on another driver and didn't
> update this particular field and so while the name field reflects
> something unique the linker entry itself is not. In a few places this
> provides a more suitable string name as well, however.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: =C5=81ukasz Majewski <lukma@nabladev.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: u-boot-amlogic@groups.io
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> Cc: u-boot-qcom@groups.io
> Cc: linux@analog.com

For Raspberry Pi bits
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>  arch/x86/cpu/broadwell/sdram.c             | 2 +-
>  arch/x86/cpu/ivybridge/early_me.c          | 2 +-
>  board/liebherr/btt/btt.c                   | 2 +-
>  board/liebherr/xea/xea.c                   | 2 +-
>  drivers/block/efi_blk.c                    | 2 +-
>  drivers/clk/at91/compat.c                  | 4 ++--
>  drivers/clk/at91/sckc.c                    | 2 +-
>  drivers/clk/meson/a1.c                     | 2 +-
>  drivers/clk/meson/gxbb.c                   | 2 +-
>  drivers/clk/nuvoton/clk_npcm7xx.c          | 2 +-
>  drivers/clk/nuvoton/clk_npcm8xx.c          | 2 +-
>  drivers/clk/stm32/clk-stm32mp13.c          | 2 +-
>  drivers/dma/ti/k3-udma.c                   | 2 +-
>  drivers/i2c/tegra186_bpmp_i2c.c            | 2 +-
>  drivers/mmc/bcm2835_sdhci.c                | 2 +-
>  drivers/mmc/fsl_esdhc_imx.c                | 2 +-
>  drivers/mmc/rockchip_sdhci.c               | 2 +-
>  drivers/net/calxedaxgmac.c                 | 2 +-
>  drivers/net/dwc_eth_xgmac.c                | 2 +-
>  drivers/net/qe/dm_qe_uec_phy.c             | 2 +-
>  drivers/net/sni_netsec.c                   | 2 +-
>  drivers/pinctrl/meson/pinctrl-meson-g12a.c | 2 +-
>  drivers/pinctrl/tegra/pinctrl-tegra20.c    | 4 ++--
>  drivers/reset/stm32/stm32-reset-mp1.c      | 2 +-
>  drivers/spi/kirkwood_spi.c                 | 4 ++--
>  drivers/spi/mvebu_a3700_spi.c              | 4 ++--
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/usb/dwc3/dwc3-meson-g12a.c         | 2 +-
>  drivers/usb/dwc3/dwc3-meson-gxl.c          | 2 +-
>  drivers/usb/host/ehci-exynos.c             | 2 +-
>  drivers/usb/host/ehci-msm.c                | 2 +-
>  drivers/usb/host/ehci-tegra.c              | 2 +-
>  drivers/usb/host/ehci-vf.c                 | 2 +-
>  drivers/usb/host/ohci-da8xx.c              | 2 +-
>  drivers/usb/musb-new/pic32.c               | 2 +-
>  drivers/usb/musb-new/sc5xx.c               | 2 +-
>  drivers/usb/musb-new/sunxi.c               | 2 +-
>  drivers/video/rockchip/rk3288_mipi.c       | 4 ++--
>  drivers/video/rockchip/rk3399_mipi.c       | 4 ++--
>  drivers/watchdog/arm_smc_wdt.c             | 2 +-
>  40 files changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/arch/x86/cpu/broadwell/sdram.c b/arch/x86/cpu/broadwell/sdra=
m.c
> index cd534a17cf15..1ba7f403c8a1 100644
> --- a/arch/x86/cpu/broadwell/sdram.c
> +++ b/arch/x86/cpu/broadwell/sdram.c
> @@ -205,7 +205,7 @@ static const struct udevice_id broadwell_syscon_ids[]=
 =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(syscon_intel_me) =3D {
> +U_BOOT_DRIVER(syscon_intel_me_broadwell) =3D {
>         .name =3D "intel_me_syscon",
>         .id =3D UCLASS_SYSCON,
>         .of_match =3D broadwell_syscon_ids,
> diff --git a/arch/x86/cpu/ivybridge/early_me.c b/arch/x86/cpu/ivybridge/e=
arly_me.c
> index ac868025f8ed..ca73fc21262e 100644
> --- a/arch/x86/cpu/ivybridge/early_me.c
> +++ b/arch/x86/cpu/ivybridge/early_me.c
> @@ -166,7 +166,7 @@ static const struct udevice_id ivybridge_syscon_ids[]=
 =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(syscon_intel_me) =3D {
> +U_BOOT_DRIVER(syscon_intel_me_ivybridge) =3D {
>         .name =3D "intel_me_syscon",
>         .id =3D UCLASS_SYSCON,
>         .of_match =3D ivybridge_syscon_ids,
> diff --git a/board/liebherr/btt/btt.c b/board/liebherr/btt/btt.c
> index dc683bd082ad..e1ff041c54f5 100644
> --- a/board/liebherr/btt/btt.c
> +++ b/board/liebherr/btt/btt.c
> @@ -421,7 +421,7 @@ static const struct udevice_id imx28_clk_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(fsl_imx28_clkctrl) =3D {
> +U_BOOT_DRIVER(btt_dummy_fsl_imx28_clkctrl) =3D {
>         .name           =3D "fsl_imx28_clkctrl",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D imx28_clk_ids,
> diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
> index 9630e7f576b2..a277163683c1 100644
> --- a/board/liebherr/xea/xea.c
> +++ b/board/liebherr/xea/xea.c
> @@ -351,7 +351,7 @@ static const struct udevice_id imx28_clk_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(fsl_imx28_clkctrl) =3D {
> +U_BOOT_DRIVER(xea_dummy_fsl_imx28_clkctrl) =3D {
>         .name           =3D "fsl_imx28_clkctrl",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D imx28_clk_ids,
> diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
> index f3ae70290e7e..a1714c41d00b 100644
> --- a/drivers/block/efi_blk.c
> +++ b/drivers/block/efi_blk.c
> @@ -79,7 +79,7 @@ static const struct blk_ops efi_blk_ops =3D {
>         .write  =3D efi_bl_write,
>  };
>
> -U_BOOT_DRIVER(efi_block) =3D {
> +U_BOOT_DRIVER(efi_media_block) =3D {
>         .name           =3D "efi_block",
>         .id             =3D UCLASS_BLK,
>         .ops            =3D &efi_blk_ops,
> diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
> index 1d738f160b6e..2449ac9fae6e 100644
> --- a/drivers/clk/at91/compat.c
> +++ b/drivers/clk/at91/compat.c
> @@ -136,7 +136,7 @@ static const struct udevice_id at91_sckc_match[] =3D =
{
>         {}
>  };
>
> -U_BOOT_DRIVER(at91_sckc) =3D {
> +U_BOOT_DRIVER(at91sam9x5_sckc) =3D {
>         .name =3D "at91-sckc",
>         .id =3D UCLASS_SIMPLE_BUS,
>         .of_match =3D at91_sckc_match,
> @@ -368,7 +368,7 @@ static const struct udevice_id at91_system_clk_match[=
] =3D {
>         {}
>  };
>
> -U_BOOT_DRIVER(at91_system_clk) =3D {
> +U_BOOT_DRIVER(at91rm9200_system_clk) =3D {
>         .name =3D "at91-system-clk",
>         .id =3D UCLASS_MISC,
>         .of_match =3D at91_system_clk_match,
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index 3fde8ea71382..dcaffd360fdf 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -162,7 +162,7 @@ static const struct udevice_id sam9x60_sckc_ids[] =3D=
 {
>         { /* Sentinel. */ },
>  };
>
> -U_BOOT_DRIVER(at91_sckc) =3D {
> +U_BOOT_DRIVER(sam9x60_sckc) =3D {
>         .name =3D UBOOT_DM_CLK_AT91_SCKC,
>         .id =3D UCLASS_CLK,
>         .of_match =3D sam9x60_sckc_ids,
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index a1b8d7914910..669247a9a09c 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -712,7 +712,7 @@ static struct clk_ops meson_clk_ops =3D {
>  #endif
>  };
>
> -U_BOOT_DRIVER(meson_clk) =3D {
> +U_BOOT_DRIVER(meson_clk_a1) =3D {
>         .name           =3D "meson-clk-a1",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D meson_clk_ids,
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index 51f124869c9c..218be45c2cb9 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -962,7 +962,7 @@ static const struct udevice_id meson_clk_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(meson_clk) =3D {
> +U_BOOT_DRIVER(meson_clk_gxbb) =3D {
>         .name           =3D "meson_clk",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D meson_clk_ids,
> diff --git a/drivers/clk/nuvoton/clk_npcm7xx.c b/drivers/clk/nuvoton/clk_=
npcm7xx.c
> index b23dd37af6c8..4c787823d053 100644
> --- a/drivers/clk/nuvoton/clk_npcm7xx.c
> +++ b/drivers/clk/nuvoton/clk_npcm7xx.c
> @@ -84,7 +84,7 @@ static const struct udevice_id npcm7xx_clk_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(clk_npcm) =3D {
> +U_BOOT_DRIVER(clk_npcm750) =3D {
>         .name           =3D "clk_npcm",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D npcm7xx_clk_ids,
> diff --git a/drivers/clk/nuvoton/clk_npcm8xx.c b/drivers/clk/nuvoton/clk_=
npcm8xx.c
> index d1b32e32371e..c7a510f5c256 100644
> --- a/drivers/clk/nuvoton/clk_npcm8xx.c
> +++ b/drivers/clk/nuvoton/clk_npcm8xx.c
> @@ -87,7 +87,7 @@ static const struct udevice_id npcm8xx_clk_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(clk_npcm) =3D {
> +U_BOOT_DRIVER(clk_npcm845) =3D {
>         .name           =3D "clk_npcm",
>         .id             =3D UCLASS_CLK,
>         .of_match       =3D npcm8xx_clk_ids,
> diff --git a/drivers/clk/stm32/clk-stm32mp13.c b/drivers/clk/stm32/clk-st=
m32mp13.c
> index 39ec06a9556c..5e88cf63e204 100644
> --- a/drivers/clk/stm32/clk-stm32mp13.c
> +++ b/drivers/clk/stm32/clk-stm32mp13.c
> @@ -2193,7 +2193,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
>         return 0;
>  }
>
> -U_BOOT_DRIVER(stm32mp1_clock) =3D {
> +U_BOOT_DRIVER(stm32mp13_clock) =3D {
>         .name =3D "stm32mp13_clk",
>         .id =3D UCLASS_CLK,
>         .ops =3D &stm32_clk_ops,
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 018243109952..5b440bb38b80 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2866,7 +2866,7 @@ static const struct udevice_id udma_ids[] =3D {
>         { /* Sentinel */ },
>  };
>
> -U_BOOT_DRIVER(ti_edma3) =3D {
> +U_BOOT_DRIVER(ti_udma) =3D {
>         .name   =3D "ti-udma",
>         .id     =3D UCLASS_DMA,
>         .of_match =3D udma_ids,
> diff --git a/drivers/i2c/tegra186_bpmp_i2c.c b/drivers/i2c/tegra186_bpmp_=
i2c.c
> index d30eb5231229..b76ef016cda3 100644
> --- a/drivers/i2c/tegra186_bpmp_i2c.c
> +++ b/drivers/i2c/tegra186_bpmp_i2c.c
> @@ -117,7 +117,7 @@ static const struct udevice_id tegra186_bpmp_i2c_ids[=
] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(i2c_gpio) =3D {
> +U_BOOT_DRIVER(tegra186_bpmp_i2c) =3D {
>         .name   =3D "tegra186_bpmp_i2c",
>         .id     =3D UCLASS_I2C,
>         .of_match =3D tegra186_bpmp_i2c_ids,
> diff --git a/drivers/mmc/bcm2835_sdhci.c b/drivers/mmc/bcm2835_sdhci.c
> index 598a51d914a9..655d9902dfa9 100644
> --- a/drivers/mmc/bcm2835_sdhci.c
> +++ b/drivers/mmc/bcm2835_sdhci.c
> @@ -243,7 +243,7 @@ static const struct udevice_id bcm2835_sdhci_match[] =
=3D {
>         { /* sentinel */ }
>  };
>
> -U_BOOT_DRIVER(sdhci_cdns) =3D {
> +U_BOOT_DRIVER(sdhci_bcm2835) =3D {
>         .name =3D "sdhci-bcm2835",
>         .id =3D UCLASS_MMC,
>         .of_match =3D bcm2835_sdhci_match,
> diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
> index 335b44a8a1a0..87125493c0dc 100644
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -1686,7 +1686,7 @@ static int fsl_esdhc_bind(struct udevice *dev)
>         return mmc_bind(dev, &plat->mmc, &plat->cfg);
>  }
>
> -U_BOOT_DRIVER(fsl_esdhc) =3D {
> +U_BOOT_DRIVER(fsl_esdhc_imx) =3D {
>         .name   =3D "fsl_esdhc",
>         .id     =3D UCLASS_MMC,
>         .of_match =3D fsl_esdhc_ids,
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 8116e464278f..b685da8643c3 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -745,7 +745,7 @@ static const struct udevice_id sdhci_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(arasan_sdhci_drv) =3D {
> +U_BOOT_DRIVER(rockchip_sdhci_5_1_drv) =3D {
>         .name           =3D "rockchip_sdhci_5_1",
>         .id             =3D UCLASS_MMC,
>         .of_match       =3D sdhci_ids,
> diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
> index ebb399457fb5..92990fa6d479 100644
> --- a/drivers/net/calxedaxgmac.c
> +++ b/drivers/net/calxedaxgmac.c
> @@ -597,7 +597,7 @@ static const struct udevice_id xgmac_eth_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(eth_xgmac) =3D {
> +U_BOOT_DRIVER(calxeda_hb_xgmac) =3D {
>         .name           =3D "eth_xgmac",
>         .id             =3D UCLASS_ETH,
>         .of_match       =3D xgmac_eth_ids,
> diff --git a/drivers/net/dwc_eth_xgmac.c b/drivers/net/dwc_eth_xgmac.c
> index 458b87af7a27..add1ea2e978f 100644
> --- a/drivers/net/dwc_eth_xgmac.c
> +++ b/drivers/net/dwc_eth_xgmac.c
> @@ -1206,7 +1206,7 @@ static const struct udevice_id xgmac_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(eth_xgmac) =3D {
> +U_BOOT_DRIVER(dwc_eth_xgmac) =3D {
>         .name =3D "eth_xgmac",
>         .id =3D UCLASS_ETH,
>         .of_match =3D of_match_ptr(xgmac_ids),
> diff --git a/drivers/net/qe/dm_qe_uec_phy.c b/drivers/net/qe/dm_qe_uec_ph=
y.c
> index 8c0168be859e..107c7686b3b5 100644
> --- a/drivers/net/qe/dm_qe_uec_phy.c
> +++ b/drivers/net/qe/dm_qe_uec_phy.c
> @@ -152,7 +152,7 @@ static const struct udevice_id qe_uec_mdio_ids[] =3D =
{
>         { }
>  };
>
> -U_BOOT_DRIVER(mvmdio) =3D {
> +U_BOOT_DRIVER(qe_uec_mdio) =3D {
>         .name                   =3D "qe_uec_mdio",
>         .id                     =3D UCLASS_MDIO,
>         .of_match               =3D qe_uec_mdio_ids,
> diff --git a/drivers/net/sni_netsec.c b/drivers/net/sni_netsec.c
> index 71afe78fd28a..b74a5c27cae1 100644
> --- a/drivers/net/sni_netsec.c
> +++ b/drivers/net/sni_netsec.c
> @@ -1138,7 +1138,7 @@ static const struct udevice_id netsec_ids[] =3D {
>         {}
>  };
>
> -U_BOOT_DRIVER(ave) =3D {
> +U_BOOT_DRIVER(synquacer_netsec) =3D {
>         .name     =3D "synquacer_netsec",
>         .id       =3D UCLASS_ETH,
>         .of_match =3D netsec_ids,
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-g12a.c b/drivers/pinctrl=
/meson/pinctrl-meson-g12a.c
> index 67114df6824a..29cfdcaa7f89 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-g12a.c
> @@ -1283,7 +1283,7 @@ static const struct udevice_id meson_g12a_pinctrl_m=
atch[] =3D {
>         { },
>  };
>
> -U_BOOT_DRIVER(meson_axg_pinctrl) =3D {
> +U_BOOT_DRIVER(meson_g12a_pinctrl) =3D {
>         .name =3D "meson-g12a-pinctrl",
>         .id =3D UCLASS_PINCTRL,
>         .of_match =3D of_match_ptr(meson_g12a_pinctrl_match),
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/te=
gra/pinctrl-tegra20.c
> index c32d590a7e0e..b3727b917dc8 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
> @@ -182,8 +182,8 @@ static const struct udevice_id tegra_pinctrl_ids[] =
=3D {
>         { },
>  };
>
> -U_BOOT_DRIVER(tegra_pinctrl) =3D {
> -       .name           =3D "tegra_pinctrl",
> +U_BOOT_DRIVER(tegra20_pinctrl) =3D {
> +       .name           =3D "tegra20_pinctrl",
>         .id             =3D UCLASS_PINCTRL,
>         .of_match       =3D tegra_pinctrl_ids,
>         .bind           =3D tegra_pinctrl_bind,
> diff --git a/drivers/reset/stm32/stm32-reset-mp1.c b/drivers/reset/stm32/=
stm32-reset-mp1.c
> index ce4532561e5e..e7ac2c6f066b 100644
> --- a/drivers/reset/stm32/stm32-reset-mp1.c
> +++ b/drivers/reset/stm32/stm32-reset-mp1.c
> @@ -46,7 +46,7 @@ static int stm32_reset_probe(struct udevice *dev)
>         return stm32_reset_core_probe(dev, &stm32mp1_reset_data);
>  }
>
> -U_BOOT_DRIVER(stm32mp25_rcc_reset) =3D {
> +U_BOOT_DRIVER(stm32mp1_rcc_reset) =3D {
>         .name           =3D "stm32mp1_reset",
>         .id             =3D UCLASS_RESET,
>         .probe          =3D stm32_reset_probe,
> diff --git a/drivers/spi/kirkwood_spi.c b/drivers/spi/kirkwood_spi.c
> index 095cbea0fca9..bb5ab26685c4 100644
> --- a/drivers/spi/kirkwood_spi.c
> +++ b/drivers/spi/kirkwood_spi.c
> @@ -347,8 +347,8 @@ static const struct udevice_id mvebu_spi_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(mvebu_spi) =3D {
> -       .name =3D "mvebu_spi",
> +U_BOOT_DRIVER(kirkwood_spi) =3D {
> +       .name =3D "kirkwood_spi",
>         .id =3D UCLASS_SPI,
>         .of_match =3D mvebu_spi_ids,
>         .ops =3D &mvebu_spi_ops,
> diff --git a/drivers/spi/mvebu_a3700_spi.c b/drivers/spi/mvebu_a3700_spi.=
c
> index 79836d7e2715..370a52a90b3d 100644
> --- a/drivers/spi/mvebu_a3700_spi.c
> +++ b/drivers/spi/mvebu_a3700_spi.c
> @@ -307,8 +307,8 @@ static const struct udevice_id mvebu_spi_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(mvebu_spi) =3D {
> -       .name =3D "mvebu_spi",
> +U_BOOT_DRIVER(mvebu_a3700_spi) =3D {
> +       .name =3D "mvebu_a3700_spi",
>         .id =3D UCLASS_SPI,
>         .of_match =3D mvebu_spi_ids,
>         .ops =3D &mvebu_spi_ops,
> diff --git a/drivers/sysreset/sysreset_socfpga_soc64.c b/drivers/sysreset=
/sysreset_socfpga_soc64.c
> index 6ce30d9eaf0b..e1267ac118ae 100644
> --- a/drivers/sysreset/sysreset_socfpga_soc64.c
> +++ b/drivers/sysreset/sysreset_socfpga_soc64.c
> @@ -80,7 +80,7 @@ static struct sysreset_ops socfpga_sysreset =3D {
>         .request =3D socfpga_sysreset_request,
>  };
>
> -U_BOOT_DRIVER(sysreset_socfpga) =3D {
> +U_BOOT_DRIVER(sysreset_socfpga_soc64) =3D {
>         .id     =3D UCLASS_SYSRESET,
>         .name   =3D "socfpga_sysreset",
>         .ops    =3D &socfpga_sysreset,
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-m=
eson-g12a.c
> index 41d15996e5b2..49e9c3fa0e99 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -533,7 +533,7 @@ static const struct udevice_id dwc3_meson_g12a_ids[] =
=3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(dwc3_generic_wrapper) =3D {
> +U_BOOT_DRIVER(dwc3_meson_g12a) =3D {
>         .name   =3D "dwc3-meson-g12a",
>         .id     =3D UCLASS_SIMPLE_BUS,
>         .of_match =3D dwc3_meson_g12a_ids,
> diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-me=
son-gxl.c
> index 5fb9b477adaf..0edf41a4720a 100644
> --- a/drivers/usb/dwc3/dwc3-meson-gxl.c
> +++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
> @@ -430,7 +430,7 @@ static const struct udevice_id dwc3_meson_gxl_ids[] =
=3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(dwc3_generic_wrapper) =3D {
> +U_BOOT_DRIVER(dwc3_meson_gxl) =3D {
>         .name   =3D "dwc3-meson-gxl",
>         .id     =3D UCLASS_SIMPLE_BUS,
>         .of_match =3D dwc3_meson_gxl_ids,
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exyno=
s.c
> index e1fc04efd2e9..ec21b7c6246c 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -249,7 +249,7 @@ static const struct udevice_id ehci_usb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_ehci) =3D {
> +U_BOOT_DRIVER(ehci_exynos) =3D {
>         .name   =3D "ehci_exynos",
>         .id     =3D UCLASS_USB,
>         .of_match =3D ehci_usb_ids,
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index 8aeb6a915563..a58eff7cb9c8 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -117,7 +117,7 @@ void ci_init_after_reset(struct ehci_ctrl *ctrl)
>  }
>  #endif
>
> -U_BOOT_DRIVER(usb_ehci) =3D {
> +U_BOOT_DRIVER(ehci_msm) =3D {
>         .name   =3D "ehci_msm",
>         .id     =3D UCLASS_USB,
>         .of_to_plat =3D ehci_usb_of_to_plat,
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.=
c
> index 89b87886da18..c1f76752cb1e 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -969,7 +969,7 @@ static const struct udevice_id ehci_usb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_ehci) =3D {
> +U_BOOT_DRIVER(ehci_tegra) =3D {
>         .name   =3D "ehci_tegra",
>         .id     =3D UCLASS_USB,
>         .of_match =3D ehci_usb_ids,
> diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
> index 5afe28ea3033..96d1363a76ea 100644
> --- a/drivers/usb/host/ehci-vf.c
> +++ b/drivers/usb/host/ehci-vf.c
> @@ -344,7 +344,7 @@ static const struct udevice_id vf_usb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_ehci) =3D {
> +U_BOOT_DRIVER(ehci_vf) =3D {
>         .name =3D "ehci_vf",
>         .id =3D UCLASS_USB,
>         .of_match =3D vf_usb_ids,
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.=
c
> index d321d147c2f9..a36950082afb 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -165,7 +165,7 @@ static const struct udevice_id da8xx_ohci_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(ohci_generic) =3D {
> +U_BOOT_DRIVER(ohci_da8xx) =3D {
>         .name   =3D "ohci-da8xx",
>         .id     =3D UCLASS_USB,
>         .of_match =3D da8xx_ohci_ids,
> diff --git a/drivers/usb/musb-new/pic32.c b/drivers/usb/musb-new/pic32.c
> index 0b25e5893b3c..b878e979d93d 100644
> --- a/drivers/usb/musb-new/pic32.c
> +++ b/drivers/usb/musb-new/pic32.c
> @@ -279,7 +279,7 @@ static const struct udevice_id pic32_musb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_musb) =3D {
> +U_BOOT_DRIVER(musb_pic32) =3D {
>         .name           =3D "pic32-musb",
>         .id             =3D UCLASS_USB,
>         .of_match       =3D pic32_musb_ids,
> diff --git a/drivers/usb/musb-new/sc5xx.c b/drivers/usb/musb-new/sc5xx.c
> index 991846818a22..b1765abe8279 100644
> --- a/drivers/usb/musb-new/sc5xx.c
> +++ b/drivers/usb/musb-new/sc5xx.c
> @@ -188,7 +188,7 @@ static const struct udevice_id sc5xx_musb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_musb) =3D {
> +U_BOOT_DRIVER(musb_sc5xx) =3D {
>         .name           =3D "sc5xx-musb",
>         .id             =3D UCLASS_USB,
>         .of_match       =3D sc5xx_musb_ids,
> diff --git a/drivers/usb/musb-new/sunxi.c b/drivers/usb/musb-new/sunxi.c
> index b577ba418780..0747f025f2a1 100644
> --- a/drivers/usb/musb-new/sunxi.c
> +++ b/drivers/usb/musb-new/sunxi.c
> @@ -545,7 +545,7 @@ static const struct udevice_id sunxi_musb_ids[] =3D {
>         { }
>  };
>
> -U_BOOT_DRIVER(usb_musb) =3D {
> +U_BOOT_DRIVER(musb_sunxi) =3D {
>         .name           =3D "sunxi-musb",
>  #ifdef CONFIG_USB_MUSB_HOST
>         .id             =3D UCLASS_USB,
> diff --git a/drivers/video/rockchip/rk3288_mipi.c b/drivers/video/rockchi=
p/rk3288_mipi.c
> index 850fe3107549..574ba8c69573 100644
> --- a/drivers/video/rockchip/rk3288_mipi.c
> +++ b/drivers/video/rockchip/rk3288_mipi.c
> @@ -177,8 +177,8 @@ static const struct udevice_id rk_mipi_dsi_ids[] =3D =
{
>         { }
>  };
>
> -U_BOOT_DRIVER(rk_mipi_dsi) =3D {
> -       .name   =3D "rk_mipi_dsi",
> +U_BOOT_DRIVER(rk3288_mipi_dsi) =3D {
> +       .name   =3D "rk3288_mipi_dsi",
>         .id     =3D UCLASS_DISPLAY,
>         .of_match =3D rk_mipi_dsi_ids,
>         .of_to_plat =3D rk_mipi_of_to_plat,
> diff --git a/drivers/video/rockchip/rk3399_mipi.c b/drivers/video/rockchi=
p/rk3399_mipi.c
> index 57e36eed6a99..68316df871cb 100644
> --- a/drivers/video/rockchip/rk3399_mipi.c
> +++ b/drivers/video/rockchip/rk3399_mipi.c
> @@ -168,8 +168,8 @@ static const struct udevice_id rk_mipi_dsi_ids[] =3D =
{
>         { }
>  };
>
> -U_BOOT_DRIVER(rk_mipi_dsi) =3D {
> -       .name   =3D "rk_mipi_dsi",
> +U_BOOT_DRIVER(rk3399_mipi_dsi) =3D {
> +       .name   =3D "rk3399_mipi_dsi",
>         .id     =3D UCLASS_DISPLAY,
>         .of_match =3D rk_mipi_dsi_ids,
>         .of_to_plat =3D rk_mipi_of_to_plat,
> diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wd=
t.c
> index f6854aa9ac93..151dc42d1164 100644
> --- a/drivers/watchdog/arm_smc_wdt.c
> +++ b/drivers/watchdog/arm_smc_wdt.c
> @@ -130,7 +130,7 @@ static const struct udevice_id smcwd_dt_ids[] =3D {
>         {}
>  };
>
> -U_BOOT_DRIVER(wdt_sandbox) =3D {
> +U_BOOT_DRIVER(arm_smc_wdt) =3D {
>         .name =3D "smcwd",
>         .id =3D UCLASS_WDT,
>         .of_match =3D smcwd_dt_ids,
> --
> 2.43.0
>

