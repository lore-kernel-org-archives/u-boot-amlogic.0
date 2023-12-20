Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BDC4706C
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 13:23:57 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web11.20365.1703076047124313705
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 04:40:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fUSXgTjc;
 spf=pass (domain: linaro.org, ip: 209.85.167.182, mailfrom: sumit.garg@linaro.org)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b9db318839so3814549b6e.3
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 04:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703076046; x=1703680846; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBrrCWePQAAD7Q3oqlwg8m/71Pl/MlCGxudnEaZw85E=;
        b=fUSXgTjcNaTya1hl3jntAImRYb7bPk/R+a1UZMTNomVnsYMJj3qg5JA94K8+QxELfY
         5BI52FHS3sCKo2z/1QtD0Bdh4jFNBjU3xgJy/OWzs0qK1PgaocHUYdrHW987CBYsXkvU
         Vtb6nSKwmTl2WQ0rc3TXYHwgLrm/06hK8USij1Usfq6CWUZjRH15yySJOT0mF5UTKeoC
         nuJ7Do/cun5yeO7FROM0Jr//4JU6c24z+duoNhYEqjsVth9gZF/rLKhl2p2DP9WKc8iU
         fUogChIctZ4r8XtOZy4k7+Vjt4eU13xfMWQHF7L0NOWL+LazM/dQQUwUDB/4FRhBYAek
         4cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076046; x=1703680846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBrrCWePQAAD7Q3oqlwg8m/71Pl/MlCGxudnEaZw85E=;
        b=OraSDTzcXxWKM9gK44wxn235CdvuObuxrK7w2WSFvWkxiEDMIvP1RuPu+5GSVK9XsP
         AgndphBK8rQthP1KeqKAXS5p981U/wFtSJwkfxAe5f/IWmvy+OicztaMHbZRq32Em4Zm
         H2XVuM7dRg/iGFUhkMjETRcP5i0T71c1Sm54p68pgJY9KfbZjVM6qk5s57p8aFnRT6Zv
         LmXJdnzEwfRK7tchNCt06o4ezqWb/R7Ph8mkZAGm33xh177uyXFYj9uqxjGDCfLV8kg7
         RK+ghlhRJbXxq38OWCMwTi2mgLZKOWtZW0xB1ip/3C+dkXzznPBFCX0xCpm3041+y23C
         cpGg==
X-Gm-Message-State: AOJu0Yzj56S1gbcTiQNLvWNWiBAn/m9+bdo98aqe6B/NjLJym6dB10IG
	mpEGl2IbCzraVS1euZznsX5/5fTCxKnl6Y+lWcytTg==
X-Google-Smtp-Source: AGHT+IELQcbcpPduvUikYLZhzVlcKq9WqdHdIdKdI531hzEqJe3xEH/YJEoBREwRg5EwEHFU1hKEXwzPJG6FfVBeQkg=
X-Received: by 2002:a05:6808:399b:b0:3b9:ede4:524d with SMTP id
 gq27-20020a056808399b00b003b9ede4524dmr23233672oib.116.1703076046355; Wed, 20
 Dec 2023 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-8-sumit.garg@linaro.org> <a269fb79-8374-443a-a077-6477a97d6aba@linaro.org>
In-Reply-To: <a269fb79-8374-443a-a077-6477a97d6aba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Dec 2023 18:10:35 +0530
Message-ID: <CAFA6WYNykzMeYzZqa+UJ_ouewRB_juQ71BDPd=THcBdaHJJtZA@mail.gmail.com>
Subject: Re: [PATCH 7/8] dts: meson-gxbb: Switch to using upstream DT
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
	dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 13:23:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1960

On Wed, 20 Dec 2023 at 16:23, <neil.armstrong@linaro.org> wrote:
>
> On 14/12/2023 14:51, Sumit Garg wrote:
> > Although there were still some variations in board DTS files based on
> > meson-gxbb SoC but I think those were minor differences from upstream
> > and shouldn't impact boot on these devices.
> >
> > So switch to upstream DT via mirroring amlogic/ directory from
> > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > building DTB from there including *-u-boot.dtsi files from
> > arch/$(ARCH)/dts/ directory.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >   configs/nanopi-k2_defconfig           | 3 ++-
> >   configs/odroid-c2_defconfig           | 3 ++-
> >   configs/p200_defconfig                | 3 ++-
> >   configs/p201_defconfig                | 3 ++-
> >   configs/videostrong-kii-pro_defconfig | 3 ++-
> >   configs/wetek-hub_defconfig           | 3 ++-
> >   configs/wetek-play2_defconfig         | 3 ++-
> >   dts/arch/arm64/Makefile               | 9 +++++++++
> >   dts/arch/arm64/amlogic                | 1 +
> >   9 files changed, 24 insertions(+), 7 deletions(-)
> >   create mode 120000 dts/arch/arm64/amlogic
> >
> > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> > index 41dbf7981f8..3db296916e9 100644
> > --- a/configs/nanopi-k2_defconfig
> > +++ b/configs/nanopi-k2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> > index 5f9f323e06e..65857ff478c 100644
> > --- a/configs/odroid-c2_defconfig
> > +++ b/configs/odroid-c2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> > index cd579ef5f14..c1792db51fd 100644
> > --- a/configs/p200_defconfig
> > +++ b/configs/p200_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/p201_defconfig b/configs/p201_defconfig
> > index b2f0a0ccdb4..202e1da5bcc 100644
> > --- a/configs/p201_defconfig
> > +++ b/configs/p201_defconfig
> > @@ -7,7 +7,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
> > index 3eda8f14a21..d09333d3b96 100644
> > --- a/configs/videostrong-kii-pro_defconfig
> > +++ b/configs/videostrong-kii-pro_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> > index fd92b041e73..73f3d4aad5d 100644
> > --- a/configs/wetek-hub_defconfig
> > +++ b/configs/wetek-hub_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> > index b887419a6ba..26f57b4214a 100644
> > --- a/configs/wetek-play2_defconfig
> > +++ b/configs/wetek-play2_defconfig
> > @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> >   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
> >   CONFIG_ENV_SIZE=0x2000
> >   CONFIG_DM_GPIO=y
> > -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
> >   CONFIG_OF_LIBFDT_OVERLAY=y
> >   CONFIG_DM_RESET=y
> >   CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> > index 16e9fea622d..d548584cf5c 100644
> > --- a/dts/arch/arm64/Makefile
> > +++ b/dts/arch/arm64/Makefile
> > @@ -1,5 +1,14 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >
> > +dtb-$(CONFIG_ARCH_MESON) += \
> > +     amlogic/meson-gxbb-kii-pro.dtb \
> > +     amlogic/meson-gxbb-nanopi-k2.dtb \
> > +     amlogic/meson-gxbb-odroidc2.dtb \
> > +     amlogic/meson-gxbb-p200.dtb \
> > +     amlogic/meson-gxbb-p201.dtb \
> > +     amlogic/meson-gxbb-wetek-hub.dtb \
> > +     amlogic/meson-gxbb-wetek-play2.dtb
> > +
> >   include $(srctree)/scripts/Makefile.dts
> >
> >   targets += $(dtb-y)
> > diff --git a/dts/arch/arm64/amlogic b/dts/arch/arm64/amlogic
> > new file mode 120000
> > index 00000000000..73f7c3e7bd0
> > --- /dev/null
> > +++ b/dts/arch/arm64/amlogic
> > @@ -0,0 +1 @@
> > +../../../devicetree-rebasing/src/arm64/amlogic/
> > \ No newline at end of file
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>

Thanks.

> Note: with https://lore.kernel.org/all/8c32e92f-810f-434b-ba77-3074490458bd@linaro.org/ merged it could be be extended to GXL/GXM aswell

Sure, I will convert GXL/GXM too once your PR is merged and this series lands.

-Sumit

>
> Thanks,
> Neil

