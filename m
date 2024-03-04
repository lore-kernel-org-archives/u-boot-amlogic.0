Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DEC54E6E
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.7676.1709593353051603085
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Mar 2024 15:02:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hTmJdSEV;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: mibodhi@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6918504a12.1
        for <u-boot-amlogic@groups.io>; Mon, 04 Mar 2024 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709593351; x=1710198151; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfKVvCc8ZYEfB1COmorOeK1mNHbPkMIzSdBUHLdvQJI=;
        b=hTmJdSEVvwHDzgePoOkZUlsQxXPv10GkxfmueivmAby2zZky/qH++FGpwwxdbJCSyF
         l4Aemy74C50xHraZDNeoXTwB2SXIAlgopbqKtRbRLORYN3sXphVsiKPfD6eeiq5eCE7b
         biozP7dc/zwjBZCpdSsUPRbdNVG8bvbWLsy/RA4Pxu51JXBe0A/xOt4dcPyFCNkJ1/6v
         Ifx10S/QUuNv16qNyqAVWuNtsfD8frZCRqwwXJV5ys3w4k4eQZFmrfOXbDS+rSUzcdnh
         HXzthgsGefYV+sMhzZxcA6KFQ7t3mUknJ7435uJQEYAjY26JbmJCyglrxUNJqdwszBrx
         ck/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593351; x=1710198151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfKVvCc8ZYEfB1COmorOeK1mNHbPkMIzSdBUHLdvQJI=;
        b=TibC6T+xzl1DKuf46nrz7duUWS4xDvgetKrFYHSnJOML9bJkdnlvgQTCQF6Wdrrrta
         VN1FuBGzBANwzEXkjO2DIzqC4QHG1ON3M4zbz7qKWAjnHqFDoOU0DMS6ASC/PL5TQ7Lv
         /cHSLAOFAxC313FZzywExQhhlQ8SjmDnLRCTgaHijevfgwhGrdaet+yucwlnePVLuFau
         QrcOH2v5RhHwBAolRq3dK3xYMpXm6xRPaakP8hmjFYc+wMt7kjlmwuOl+zBHvzXnKoo4
         d7e1QnV6rwEF4bNgYyGkjaHMa2eBTGYTRYtV6D9W44oH6KNSoVIV3zgNCVTr/HHrcSVI
         pjEA==
X-Forwarded-Encrypted: i=1; AJvYcCWEOjOOll4YUk29giPrMLMdseoeEMQ9gDYZGCaFq9/2nUxu4Tz8yN2qW/M01qeK3LlnXbB4QE1F1Sk/PJ6N45TC1wY/b3tZ2rw=
X-Gm-Message-State: AOJu0YxxqPB2mBijgGjr6hSDGl1wubLRcjxBJziEx6v2KJ73sa2yzkQf
	BKn4BnM9ioa0YcngqDNny5j5AgHsLRQmW7HIEYTKT/R8WjMkldtsQeRvK9c/UzrSJMYO8BehbGj
	wwKgcVKDNgTK4PA+HD6b2ERmmR+U=
X-Google-Smtp-Source: AGHT+IHrbX0TI1QzY4ITSD9vI9OrADmTTHJvB5pQMV71Lb/GX8KJKjae0afRbrPN2TprSlhSuU8msCqZoppsjaE4sys=
X-Received: by 2002:a50:cdd0:0:b0:566:3f3e:3a23 with SMTP id
 h16-20020a50cdd0000000b005663f3e3a23mr6881548edj.1.1709593351307; Mon, 04 Mar
 2024 15:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org> <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 4 Mar 2024 15:02:12 -0800
Message-ID: <CAJaLiFyXC2-wkwbyvK+bKWhwzV9=rWY445Lz5dFQSWdB0Zb5Bg@mail.gmail.com>
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a specific vendor
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
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
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2184

Hi Caleb,

On Mon, Mar 4, 2024 at 9:24=E2=80=AFAM Caleb Connolly <caleb.connolly@linar=
o.org> wrote:
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
>           However, newer boards whose devicetree source files haven't lan=
ded in
>           the dts/upstream subtree, they can override this option to have=
 the
>           DT build from existing U-Boot tree location instead.
>
> +config OF_UPSTREAM_BUILD_VENDOR
> +       bool "Build all devicetree files for a particular vendor"
> +       depends on OF_UPSTREAM
> +       help
> +         Enable building all devicetree files for a particular vendor. T=
his
> +         is useful for generic U-Boot configurations where many boards c=
an
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

Perhaps here it should be:
default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD

All the best,
Tony

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
> -dtb-y +=3D $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $=
(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +dtb-y +=3D $(patsubst %,%.dtb,\
> +       $(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONF=
IG_SPL_OF_LIST)))
> +
> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir :=3D $(srctree)/dts/upstream/src/arm64
> +else
> +dt_dir :=3D $(srctree)/dts/upstream/src/$(ARCH)
> +endif
> +
> +dtb-vendor_dts :=3D $(patsubst %.dts,%.dtb, \
> +       $(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.d=
ts))
> +
> +dtb-y +=3D $(subst $(dt_dir)/,,$(dtb-vendor_dts))
> +
> +endif
>
> --
> 2.44.0
>

