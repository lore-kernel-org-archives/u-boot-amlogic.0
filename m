Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2C610F284F
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 16:57:38 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18999.1774432673531367552
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Mar 2026 02:57:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VqHhGKhq;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: clamor95@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59de8155501so6248278e87.3
        for <u-boot-amlogic@groups.io>; Wed, 25 Mar 2026 02:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774432672; cv=none;
        d=google.com; s=arc-20240605;
        b=M30zW4yuRewl58ASg+CshfwcmXXzhRUsqBpy2kPXxDrnbf0J5xhIRW5Ol274pomDm9
         INMM52nqbpEx9zh3z39dSqhm647/YiBeyGoAgOBoQemrR8rtRhd38nq5OnEItc35DfDH
         QaCdYw6t27LpZWO+6j1Zb4Cy/PXf5sip5LwgoLn4D7oinOEcIXzKh/2E+GTuOPtw/S2S
         GNpsk+AYmqggwF+0pIgCecIfgPRLAbdUtyPy1qzxIiFui8+jTtlofXVfnSTlbvaOLK1k
         pFudCYpjDK/oLx4Vt1eJelFNTYLNo7EFCFrWOpaW/NpVv366SstDO4S6zBC3E5hL7rJE
         WEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
        fh=EYeFkGBdtWYBkKHPZSEffrza6BbDLsxx6npIIdekORk=;
        b=JfQ1J36UzL2hdpufWQOZGpxP/zmRWBwlDWBzKp0p/4XQYswHD1vzSPdfRQCm7WMCKG
         mqUDEVxtsS+wZWERUjMhfSL/Nj5GYQis1dPAx27ouuW3krVmETgES7eQh3rsFDzVAOgA
         zdB4a7mNpSwhGmIVv/GEMjPi13XitBqGIjbQvq9pJo8cH3wTS1TYATtXSAD0FBAuk0pq
         wFums8YrrjGGNJ0lAABjaehf3s2g6JBUNMZbVaBZpSH2dFYXvgR5qQjRkszxHcAFUlPa
         ok5m0eIsToOOIlReVG7QKqMeJriuzp65vc2Q8ODZVXG4amR2n+c1NYbg67eUJ3b8eaL1
         oIkA==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774432672; x=1775037472; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
        b=VqHhGKhqS5P/mo5ELobRH0kw3FW1fiZWAroaueIJ9fSA7/AxmBk3zcpGpYZmh/Hopd
         Jf2nR/EfOv51Qs9b2h12RilUKMcuqLhYKzSVGDq08kbNZ7B7e/sxfCVHfVrLE1Y0q2l8
         fZIp5N8VbC6Dzky+2cfdn3tsFUz43pewVDSpxUnkKb1byQC7sdojKtsum+U8M8Cq/y2z
         wMeG/af+2maDNO/0MliBmzeB1VBWK+bx+YIGA2NyOhABrkyzW9t93eSxQ4xbKdoL0mU+
         sv/aG77SziHAehGGhMRFImIICTAtHlyukYJEJVdUm+IDdeYuF7LCyWmMZkPYti32TBqA
         yKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432672; x=1775037472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCRTV9uyRbWISy7+ySM7xkoMVHIkgikoUlESWsDeYR4=;
        b=F8RNAms63yBhvHVPwqUJtRcLIwizYeQJ1mcX0j9MHXoYLSPArNcXGht6v/CVjttfIV
         e8i7G1nCmR5QzVDMpcUFsFjZtehHW2nxlpmM5R9VXy2pDn7R2jBENI1X92eIgtUaIUTy
         IG5MFRjFYIcnaSgMxi4pAyJBiM1cjDGYnLnTFflrSLeanpoJlMRU3WuXExgEucvX+eQI
         YV7aeFTdi/8ASHhjE/SBfanC02FtKfalwGi+yODninCHSLfrGkoywRlv3C3eCY5CxUND
         SSPbb7N1HH9guUmgrb7GJnJzGyPfUG8wpFd2IVHqHn/PnLhwYgIs438PWs0e7HbLi6GX
         /JVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGLvA/NEaZVBCKHryH2GxKPS/CQQ/5ykvDoV3sTNP5D587B0/D/vAC41APt0ieBoTzIgkvPs44ZyQ/rkNfow==@groups.io
X-Gm-Message-State: AOJu0Yw76jOTFLZCAuUwKHRAqryesbQ6y+eQIIBRS7gr6d82/0OI7s8z
	k0y0EPGxre+zFv4E2gQFAGvg8DJTbuABbHnMXpjV08sr7+/4k2jLEB0ZMaiUAcUUYBc78dTTd0e
	eSwvY9yS+VxPI7PqU+52bl07SHmMAylvsgh/Q
X-Gm-Gg: ATEYQzynjVMXkLcbltLKnY2h7DAyDeWWQqrj+RdBmEqqwWziXDAAYisDpStMdShoLGV
	BjeFat9tdul6cyD8aCLZs7t5zCsAe3Ali8OVHyWfT1Vx+VxGnMKerw7COkwc7CjE8AF0MMAp/To
	Za+e0zskyLvfIzzEtW2XzhqOWdv82pBucz4Ak9c7GX0b28N3EUHHQEZf99hfFxehpJ1B5e7Gw5P
	IbJ3iLYzzeqzLMXcmyHVndwnbOsqOo0E4SgjSOS575dfzP0Y0umqy93yTp9ncNQheGAfiNqegYh
	RslQaF2w
X-Received: by 2002:a05:6000:1842:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-43b88a4137fmr3967651f8f.50.1774432199428; Wed, 25 Mar 2026
 02:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260323225537.896180-1-trini@konsulko.com>
In-Reply-To: <20260323225537.896180-1-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Mar 2026 11:49:47 +0200
X-Gm-Features: AQROBzABhbC9_ktNUl2POzJ2hLo8YRR3441-TE89-tLolwsGaucqFxVrU2ci73w
Message-ID: <CAPVz0n3z1MOWOUMJZQpw-vs8oC7eMo9gXdPMpVT62R9-fLSeBA@mail.gmail.com>
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
	Peter Robinson <pbrobinson@gmail.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Simon Glass <sjg@chromium.org>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
	Stefan Roese <stefan.roese@mailbox.org>, Thierry Reding <treding@nvidia.com>, 
	Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-amlogic@groups.io, 
	uboot-stm32@st-md-mailman.stormreply.com, u-boot-qcom@groups.io, 
	linux@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 27 Mar 2026 16:57:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2939

=D0=B2=D1=82, 24 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 00:55 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
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

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra

