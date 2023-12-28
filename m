Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32723C48288
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web10.122871.1703770664278987731
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 05:37:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=NrqasVtd;
 spf=pass (domain: chromium.org, ip: 209.85.161.54, mailfrom: sjg@chromium.org)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59451ae06c2so3161807eaf.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703770663; x=1704375463; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXIfu2zwGi5PSmS89IaRTH3LaPRA77gIis4zue7UwM4=;
        b=NrqasVtdFOiK4EjSwXbbOROC01BxyfcLl0TGaScCyGQdPDOYDNyOe5wVgDJBNw5gX8
         zbvt98UIIq2fyIv00QnM7NEEPCepNLZO6mGiF+rSBDf4CkQgFcuICkxCYeKv+3jsV8Z5
         xMZDglj5dTcvBVpTBH0376h//sw6Nos4jQMxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703770663; x=1704375463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXIfu2zwGi5PSmS89IaRTH3LaPRA77gIis4zue7UwM4=;
        b=RTvKtdKah2e/eztchT2ABZ+TTX3CAXcp/SKgqsdq3HuPFOWZcxwCmi6cfKLvCfIfoc
         NK1/wN9wqIFbrIhi6ppmSx9HUS9/UUn/feq+8IyE0UjwB/MIc8k2PZuvnsRdNQc2ASqr
         gm9cmEh75q3T/Ev8g9fz8Ruf8EA4Uo988zfHlxUiva9KQX8AaBA5qIJksDD4zb8q1OlM
         vcVUkZkJVXi0RNxIoZ5TowTgwdJ/LGjCy2xrLis9SNszOuU8hPJPPzz3DTq62RhM80uA
         qxWYtcawJGbw7NjwrGwvd5vN/zs41WBjIqWDT3yzpbXFBnzCffXdLqRWVR3xf+WweWaF
         3rfg==
X-Gm-Message-State: AOJu0Yyu4M2LU7vtU70ewpkQe/ho6coxMqo4CZVEYZYdjXPv3FgUHEMp
	hC79v2nJSN9jT6uCVvD/h1jDTPlcD3PhdJLBwpGDVa1opZ03
X-Google-Smtp-Source: AGHT+IGs2yZ1tGr8DO69t5wRi2GMQtl0BbEkfOYnJdI4sRgNR8uqJRhZz+za737p46Z5M3Ig/kUfmiEI/wAKN3g1E4o=
X-Received: by 2002:a05:6359:4c06:b0:172:f31a:6bfb with SMTP id
 kj6-20020a0563594c0600b00172f31a6bfbmr13714110rwc.51.1703770663578; Thu, 28
 Dec 2023 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org> <20231228115804.3626579-8-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-8-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:11 +0000
Message-ID: <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1995

Hi Sumit,

On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Although there were still some variations in board DTS files based on
> meson-gxbb SoC but I think those were minor differences from upstream
> and shouldn't impact boot on these devices.
>
> So switch to upstream DT via mirroring amlogic/ directory from
> devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> building DTB from there including *-u-boot.dtsi files from
> arch/$(ARCH)/dts/ directory.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
>
> Changes in v2:
> --------------
> - Picked up review tag
>
>  arch/arm/mach-meson/Kconfig           | 1 +
>  configs/nanopi-k2_defconfig           | 2 +-
>  configs/odroid-c2_defconfig           | 2 +-
>  configs/p200_defconfig                | 2 +-
>  configs/p201_defconfig                | 2 +-
>  configs/videostrong-kii-pro_defconfig | 2 +-
>  configs/wetek-hub_defconfig           | 2 +-
>  configs/wetek-play2_defconfig         | 2 +-
>  dts/arch/arm64/amlogic                | 1 +
>  9 files changed, 9 insertions(+), 7 deletions(-)
>  create mode 120000 dts/arch/arm64/amlogic
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
> index d6c89058061..8ddb59161a0 100644
> --- a/arch/arm/mach-meson/Kconfig
> +++ b/arch/arm/mach-meson/Kconfig
> @@ -25,6 +25,7 @@ choice
>  config MESON_GXBB
>         bool "GXBB"
>         select MESON_GX
> +       imply OF_UPSTREAM
>         help
>           Select this if your SoC is an S905
>
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 41dbf7981f8..2e1c756bf7a 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
>  CONFIG_ENV_SIZE=3D0x2000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
>  CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_DM_RESET=3Dy
>  CONFIG_DEBUG_UART_BASE=3D0xc81004c0

So now I am wondering if we can (later) have the SoC be implied when
using OF_UPSTREAM so we can do:

CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"

and it will add the 'amlogic/' automatically?

Perhaps that might be a way to bridge the gap in terms of file layout?

[..]

Regards,
Simon

