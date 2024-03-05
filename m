Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D0C54E6A
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
 by mx.groups.io with SMTP id smtpd.web10.21454.1709642164591392727
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Mar 2024 04:36:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=noGNmu3G;
 spf=pass (domain: linaro.org, ip: 209.85.217.41, mailfrom: sumit.garg@linaro.org)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47299367f78so128728137.0
        for <u-boot-amlogic@groups.io>; Tue, 05 Mar 2024 04:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709642163; x=1710246963; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+8zuP3MJOUgNNdP4KHvSrZTKRgDcPIgl7A75TCaYSM=;
        b=noGNmu3GE6AYXv0ObbcLttS6I2oHFzrqRIOmYyftvuSFIvyP+COpgS2ToZxKiDb/qO
         K8rFzyTTDWChVtQz4AlykTPMX34A0QhEElT78O2l5d05UAF2rA+NRciV1fW480+Pdl6G
         h+PnSsc14HRxYDipDLN9pUlc/sIeadlYMxKdeP0VtxjWHIx6/cMGHYdcYYHg+A0pTYp8
         XHVoCCXv/Al+5Xc/5WVOjAXKNh4ckvirF7jYp/dr800Mp4qE8gdk69a6jwm/+DN1JQGK
         NEdox8ZI/AIoaH2WowL4KPYp3Iv6B4csa6T8mjBBlkajvOzy9POYq02d67YL12p8PSBp
         Ow2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642163; x=1710246963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+8zuP3MJOUgNNdP4KHvSrZTKRgDcPIgl7A75TCaYSM=;
        b=a6ZzqscJFIJsnBQk6x7kL1sec4QmnjUP0vzKTXzft8DpcSp8/hKGDTA2XSmsb5dI5L
         4p9s3NBqLZ9/YpnSUlLVu2vHat/fdGTaS/D5NvFudGIdsbk5sc+gNWpDCZD12RtYQ8pH
         ay1bc4vfITY5GTrzbNRTVL/na2Koa9DfdBE9FXW8nLapVFjt0mtoEmkfIC6CV4eP5r3s
         enC/QkshWG2hPXPRATVNHF9wUeMPZFCoVV3jL7rl1Sy7FmvY8G/kRDoELaI/FSf26XTO
         +bPeqAsxIRFJdAaFYm6OVt134lq+kb4jTxW8nwWYE9OjsuH7lIC3qCX/WPlMu81L1YJR
         Q1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUbbx1/IAr58ZCmukudopx4nhLe3IlmowP0NOC+Fg3vqjiEnnymUkianDzrHaSpZoHxyBbrcE0zYtusk5hcqd/waN5PHDO/7UI=
X-Gm-Message-State: AOJu0Yy3JlKyEBM1wwFrvmrUbIbLtKyacJLRyBHSn0BoD8c0ysD4IeIO
	ick1iRlUVQMqoe+miC9rBtXXn/Spwe2uwmvJ70vhg7Lwj7eIRYtXMICW7c+PiEbkxDWHVNqX1cE
	YSlMnL5y72A/mMa0hgSbZWrVI7jz/xcDI7ufKLw==
X-Google-Smtp-Source: AGHT+IEwMDMMamjJ87TRwA/Z5ITzuuzQra31/JT775CsgmZ3IqQ4Wso6CDXn3XaKxI0La0T2Rnw7aEBpJ2oUyzIWrgk=
X-Received: by 2002:a05:6102:1608:b0:471:fc99:519f with SMTP id
 cu8-20020a056102160800b00471fc99519fmr1835998vsb.2.1709642163569; Tue, 05 Mar
 2024 04:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org> <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 18:05:52 +0530
Message-ID: <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
	Sean Anderson <seanga2@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
	Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
	Weijie Gao <weijie.gao@mediatek.com>, 
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Dai Okamura <okamura.dai@socionext.com>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
	uboot-snps-arc@synopsys.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2185

Hi Caleb,

On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> all the devicetree files for a given vendor to be compiled. This is
> useful for Qualcomm in particular as most boards are supported by a
> single U-Boot build just provided with a different DT.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  dts/Kconfig          | 24 ++++++++++++++++++++++++
>  scripts/Makefile.dts | 17 ++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/dts/Kconfig b/dts/Kconfig
> index b9b6367154ef..67d9dc489856 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>           However, newer boards whose devicetree source files haven't landed in
>           the dts/upstream subtree, they can override this option to have the
>           DT build from existing U-Boot tree location instead.
>
> +config OF_UPSTREAM_BUILD_VENDOR
> +       bool "Build all devicetree files for a particular vendor"
> +       depends on OF_UPSTREAM
> +       help
> +         Enable building all devicetree files for a particular vendor. This

Do we really want to build all the DTBs even if many of those aren't
supported by U-Boot at all? I would have rather added Makefile targets
for boards which really supports a single defconfig eg.
qcom_defconfig.

-Sumit

> +         is useful for generic U-Boot configurations where many boards can
> +         be supported with a single binary.
> +
> +         This is only available for platforms using upstream devicetree.
> +
> +config OF_UPSTREAM_VENDOR
> +       string "Vendor to build all upstream devicetree files for"
> +       depends on OF_UPSTREAM_BUILD_VENDOR
> +       default "qcom" if ARCH_SNAPDRAGON
> +       default "rockchip" if ARCH_ROCKCHIP
> +       default "amlogic" if ARCH_MESON
> +       default "allwinner" if ARCH_SUNXI
> +       default "mediatek" if ARCH_MEDIATEK
> +       default "marvell" if ARCH_MVEBU
> +       default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
> +       default "nvidia" if ARCH_TEGRA
> +       help
> +         Select the vendor to build all devicetree files for.
> +
>  choice
>         prompt "Provider of DTB for DT control"
>         depends on OF_CONTROL
>
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 5e2429c6170c..8005527f3df7 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,3 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
> -dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y += $(patsubst %,%.dtb,\
> +       $(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +
> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := $(srctree)/dts/upstream/src/arm64
> +else
> +dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
> +endif
> +
> +dtb-vendor_dts := $(patsubst %.dts,%.dtb, \
> +       $(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
> +
> +dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
> +
> +endif
>
> --
> 2.44.0
>

