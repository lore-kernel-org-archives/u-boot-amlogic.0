Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3787CD1283
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:21:02 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.8711.1711055083769069616
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Mar 2024 14:04:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Y7NzYCmu;
 spf=pass (domain: linaro.org, ip: 209.85.208.182, mailfrom: caleb.connolly@linaro.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68651e253so23983731fa.0
        for <u-boot-amlogic@groups.io>; Thu, 21 Mar 2024 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711055082; x=1711659882; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
        b=Y7NzYCmu5SB578TiyVKbXwXvTCyZalNOaaYrUaRQ34kbIh8qJhnsI2nFmZUgd7Ur9k
         nNy6C2xqhdSDk+Cf9+LBTJ94xUWFuAU4/E1rL5gQfvwActjRYVZmtpHJIJmdn17+LHiz
         i3yIsgChn2KQ4N7hIiEGycXQoOgaoa4NSi0aUnDC4YSQ4gb8gOIa4o2db7qK9Q5WXAh0
         glNp0Hbvc/S5+pXU+bB5q3bgE3Vm1rMvp+xJztUm/hU27yHPFzDUSQLEzv0bQ5Xxb+N7
         yjq/DGdvF7MrLCZIay9/Na/KnSRrXfy5/IyLOpMoAM5VMNaEEtwC3bgXaHKucv4nEnLT
         i9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055082; x=1711659882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKs4JT+m2KCkJOqgG6C5kt9r4QRZhsfdeXlX04Y/UsA=;
        b=xF28mlNTVlytBDawtjm8ouZiZf7RFDe6M/cWf4SFHN+AcGoGb/T8j3yHtZwbsY0jmQ
         pB+gZBHF0IehI6YmFzM/OonS9qkJa90B7i2Gr9yN7vat54mN77VXtT95ZMhM6GYolSG2
         aZ/Trtl5MzSNyQlONdx54vzRK7km/iShO1dUg2Dq1wcDOLXq52BsXYC/i84Azz+H154A
         fMMd3vGhmLLl111Yhk0hp/CH8RODkU2daJmCL+nBFmqJusQAAc+jUL5x5w/epBACo6lG
         TnRXBbG0Lp2LFIuxDoZmuTITRttSa0Tx8JKFcY4x9zvHDMKTiQgK6pIesvWXeOwKK/mI
         lRbg==
X-Forwarded-Encrypted: i=1; AJvYcCVxsBcMBGLACQfY/WTBApYcW5u5ED656Tff9fccw/CZCwZwoQwQm1gnyGTfWRPZE9xzjP2rR3yl884HARSmJ4W/LIjN7SEMf6Y=
X-Gm-Message-State: AOJu0YyzpXCKeN4byvCK39m1/yJrvhxLAs55ySrs14G9R6aT3Di1y4eo
	Fh1rlX5qSKCp/uh+rFHRBMRUy6jbh2wRNtW7ymBCapFN0WLn0Zp7EUz6lRRnVB51VXhVWD2p3vA
	h
X-Google-Smtp-Source: AGHT+IFFuvGX1KeE0xUnbwTd6d6Uw1dPsPNmpoGg9We3tzgWW/Q7FxS2QdQR61+vqdh3E1i/uipa9Q==
X-Received: by 2002:a2e:9582:0:b0:2d4:6814:7c98 with SMTP id w2-20020a2e9582000000b002d468147c98mr413187ljh.43.1711055081771;
        Thu, 21 Mar 2024 14:04:41 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004146f728906sm925462wmb.7.2024.03.21.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:04:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 21:04:07 +0000
Subject: [PATCH v2 24/24] dts: support building all dtb files for a specific vendor
MIME-Version: 1.0
Message-Id: <20240321-b4-upstream-dt-headers-v2-24-1eac0df875fe@linaro.org>
References: <20240321-b4-upstream-dt-headers-v2-0-1eac0df875fe@linaro.org>
In-Reply-To: <20240321-b4-upstream-dt-headers-v2-0-1eac0df875fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lFINIkt3mPUDg930k4h55ttVmUyWegfEw9o+thWATTw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ/C/ZqBxVkeS9oVp1n6Lqgdkngu4YNyp9k1v/acWpTz
 c6ZgTuaOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEousY/inx+2//rjnNqe7L
 /+1/Wsrz2EvdLZpT7r+a9q4qLfrqQQmGPzxZnnNDHkjNeeKrO+fhLJWnd9/M2a30pFlC9vSLFdy
 BXx4DAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:21:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2236

This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
all the devicetree files for a given vendor to be compiled. This is
useful for Qualcomm in particular as most boards are supported by a
single U-Boot build just provided with a different DT.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 dts/Kconfig          | 24 ++++++++++++++++++++++++
 scripts/Makefile.dts | 13 +++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index b9b6367154ef..6883a000a052 100644
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
+	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
+	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
+	default "nvidia" if ARCH_TEGRA
+	help
+	  Select the vendor to build all devicetree files for.
+
 choice
 	prompt "Provider of DTB for DT control"
 	depends on OF_CONTROL
 
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 5e2429c6170c..790f3c508f19 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,3 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+
+ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := $(srctree)/dts/upstream/src/arm64
+else
+dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
+endif
+
+dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
+
+dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
+
+endif

-- 
2.44.0


