Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CCDC54E71
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.104456.1709571125429344427
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Mar 2024 08:52:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=RA1MsP0Q;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412e84e87e6so4237635e9.2
        for <u-boot-amlogic@groups.io>; Mon, 04 Mar 2024 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709571124; x=1710175924; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pCWnqR2w3MK2Z9hkofhscjBJ0Hj19Lc+xpshC15mCg=;
        b=RA1MsP0QClxdqoO3o+CG7y5TXrvGIKsy5dYW912Y8GfMSUPje4ZFC6nEJaZDWSBLTL
         82sBTaZGKO9zzecwcByji3x5r2cM1hcLyhZrgdN/l7ypsTMpFTQwPxitLOUFJsLHea5x
         R+MWeeiTiJkBDTqQ8ltZQBU49kD1jmshNPCq+NHUcv6LIIlv8ZqvMNqcu2cnRY2Pm/XO
         HTXw05vVfJnzFQjWD8EaUPDtGuWtUwhXdmGtpxIe8FKA17QTU9uQwGopIYsKilrUU+X+
         t8TypJdlIBbkuoAFhckCqMZSmvr6rdcjRBeIFxsRy8oKJo5A4lOoNWP09FXmou4qihpv
         YcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571124; x=1710175924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pCWnqR2w3MK2Z9hkofhscjBJ0Hj19Lc+xpshC15mCg=;
        b=ox6TNm+UqRvOxug+4qZa3YMY+VBFS6Onbly6wapS1sL7Y1Tzvt7V0eoj9A6NUJBNMj
         GEkOzltwoZJv7/Ka99vcvAs2Slsdr27SXnlV0XvhQ0YbsWYCCXfDJj6iTlx6q7gBObcz
         U3Da6f5yJm4vHfKuLsOOivYTAoaqvy4/+J2oT56F4/1xM3VDs/KqUWs2JuT59ZnGPfI6
         AoW4ry6Z9+EhOnw/yQW4QgeTnk/nAv2L9EGbhbsDr3bsGTGpjo0d93oEdSM0/HpIrEsm
         NSvNHeuYUjTTW7+W4ErHU8ApOI71uvuogCJzFZXhe4SBzLMavxG+kFwki+y8BN3uJsPy
         38xA==
X-Forwarded-Encrypted: i=1; AJvYcCWWoGxDtjkFtuAhnpz0JBZzi7VxEpInt7T4WWp21jDQ9T5b/DeMDFtIWumC2yc2Culzjz/JzS5TwENSeSfxIDKPRE16tlRZ+nE=
X-Gm-Message-State: AOJu0YyUGCJo5MnEx2SoRjWxa6z7YdHM3/g6lgbdHgCkdbvdGP7QOx41
	s3EmE8k2NhPR1alrsM9xTECxTyMhRCEd22bFY8m1HggjkyLE+B5SAJYvyhpBgaU=
X-Google-Smtp-Source: AGHT+IEjhPNnOmvxE//lUchMMMtq5k9u+YYlSzW/hTU5ohirwvcPfzQHUgu607vQs5iIsLuuIPMRVQ==
X-Received: by 2002:a05:600c:1c9c:b0:412:e580:2dbc with SMTP id k28-20020a05600c1c9c00b00412e5802dbcmr1575430wms.19.1709571123950;
        Mon, 04 Mar 2024 08:52:03 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b00412cb0961fasm10598517wmq.6.2024.03.04.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:52:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 04 Mar 2024 16:51:34 +0000
Subject: [PATCH RFC 26/26] dts: support building all dtb files for a specific vendor
MIME-Version: 1.0
Message-Id: <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
In-Reply-To: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, uboot-snps-arc@synopsys.com, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2654;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EI2CDzUz7yZMpQs2UznMDgZqFxlWcF+fQMMDPec6VAA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSnfzjZbFzqomcFzWZeWP/p0l6fZTdzdJim2HT2/J9QI
 97Z+Syvo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk0TJGhoXmeT1fj8vPurep
 9Q7bLMMl2cdYfhQcNPokvMWK8dNF0X5GhmluS6/N3bfIY5Kaq0mF0cmI6Iyp/PNehy++Fn40UJb
 P6CAA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2182

This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
all the devicetree files for a given vendor to be compiled. This is
useful for Qualcomm in particular as most boards are supported by a
single U-Boot build just provided with a different DT.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 dts/Kconfig          | 24 ++++++++++++++++++++++++
 scripts/Makefile.dts | 17 ++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index b9b6367154ef..67d9dc489856 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -100,8 +100,32 @@ config OF_UPSTREAM
 	  However, newer boards whose devicetree source files haven't landed in
 	  the dts/upstream subtree, they can override this option to have the
 	  DT build from existing U-Boot tree location instead.
 
+config OF_UPSTREAM_BUILD_VENDOR
+	bool "Build all devicetree files for a particular vendor"
+	depends on OF_UPSTREAM
+	help
+	  Enable building all devicetree files for a particular vendor. This
+	  is useful for generic U-Boot configurations where many boards can
+	  be supported with a single binary.
+
+	  This is only available for platforms using upstream devicetree.
+
+config OF_UPSTREAM_VENDOR
+	string "Vendor to build all upstream devicetree files for"
+	depends on OF_UPSTREAM_BUILD_VENDOR
+	default "qcom" if ARCH_SNAPDRAGON
+	default "rockchip" if ARCH_ROCKCHIP
+	default "amlogic" if ARCH_MESON
+	default "allwinner" if ARCH_SUNXI
+	default "mediatek" if ARCH_MEDIATEK
+	default "marvell" if ARCH_MVEBU
+	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
+	default "nvidia" if ARCH_TEGRA
+	help
+	  Select the vendor to build all devicetree files for.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 5e2429c6170c..8005527f3df7 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,3 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtb,\
+	$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+
+ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := $(srctree)/dts/upstream/src/arm64
+else
+dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
+endif
+
+dtb-vendor_dts := $(patsubst %.dts,%.dtb, \
+	$(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
+
+dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
+
+endif

-- 
2.44.0


