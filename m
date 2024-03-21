Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455FCD11DF
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:21:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.8703.1711055077396671601
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Mar 2024 14:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=yJqB6Q/U;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41478297f78so3757135e9.3
        for <u-boot-amlogic@groups.io>; Thu, 21 Mar 2024 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711055075; x=1711659875; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9z47gxslMXab03nJVN9Zel/hSMnSwz2OuvyhmVXZIg=;
        b=yJqB6Q/UvIvYu7KD1oOTAiJBuEoWDWMr3WULJnOzidRiNx2BOsT8t3ha7xq5zZIkEM
         HfJOlQowIGEkfVbuo1MNqd2DL51UuYi3oAx3+xGPWLOQaABDpUgv8O/PKM0HcVqxzy0Y
         xV/Fj5vF9jlx3YGGRqb/5xVSnmdhD6np9E5fNTQyezaIQm8iux9sn60eXvTznK1lFpu9
         xouoXWfeBmLojdTsTeBALokRd9HqKKQcRIuroc96OTzC7dx1uz2dhVRuASBYhsRhtZME
         1/z/jt+bE5rUdlM6K2XdKwHBSnAMeia2O7afjieLeXkIbzZiO0iXItgvP5M4F6ikHqe+
         FWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055075; x=1711659875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9z47gxslMXab03nJVN9Zel/hSMnSwz2OuvyhmVXZIg=;
        b=JWr2uX+spQ2FkhvtQwZkJ4AD9sIoIQyvMimCjvlAptifZmnIksHZGQN2AxL0tNb+do
         b7fdnfo77Nk5EJ77HKet3w7VnPMraJE3q2lHXNMqsmpeITOQP6ogKcEA6rfn0K3UpyYG
         LIxDpv5kZvPf0jr6NxNNn0VTEM7Daae77Om+3zVoNNeEqEYKOgabGFPnz0Y20gbfyuxy
         uQJMETpWabAWzSzgV81kdv2M2v6IlH48nmhjAYlE0mtNbAxyHs/PKnM0KifPxK+D2STj
         QGRsnufxU2NpCFQ3MPDZRDqpQmB4s68vaDidgMNDurdZ4+Hv9d6nWfaIDUE98BAaGcWr
         jq9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTWs+JA8+mKxYeYMwueEU/EKROjq6J3QVcTb/uTxGpw9sjwcJ6T4UP6al+zJ86An1l4Mw1N20EzhbMRwaOyvWqjbAY92pkDp0=
X-Gm-Message-State: AOJu0YysYH6RtcEY0cIZjAMB6L2UjkOHDX4hPZzWuJ1Mt4IgYAgJavFc
	59v7ePMqZt0dmUc64asTHlJUvwkiNFDqODlXWWoGV1PnaG6czBn6MszNYzKqwRpdZoquonDyuL2
	E
X-Google-Smtp-Source: AGHT+IHGF9T7yrijm/584t3scgEZ6HnMs/+RrCeeLb6GPjdcZ3J6sfDmRL3vibK1zQMrc+LOwrpS3w==
X-Received: by 2002:a05:600c:1908:b0:414:c63:b9de with SMTP id j8-20020a05600c190800b004140c63b9demr223868wmq.14.1711055075661;
        Thu, 21 Mar 2024 14:04:35 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004146f728906sm925462wmb.7.2024.03.21.14.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:04:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 21:04:03 +0000
Subject: [PATCH v2 20/24] sifive: drop clock headers
MIME-Version: 1.0
Message-Id: <20240321-b4-upstream-dt-headers-v2-20-1eac0df875fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6003;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5lyJpN4afSur7zKXA+gv+xmN5RUoVNSeg8I0uwN7L3A=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ/C/aqzol53nf08O35Pj66byaWsDD6Zt489kflHlOR8
 Yqctm+cHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi0hKMDA0pTMbvEq+GT193
 I62mpVcksOJpcRLfh3f3VUJc3AJ/KDMyzJbjUVH3Cima0x2odDl4689PEwq4JV9wi5qyPrFsya6
 fCgA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:21:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2232

Drop in favour of dts/upstream.

Small driver/dts change to fix compatibility.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/riscv/dts/fu540-c000-u-boot.dtsi         | 26 +++++++++++++-------------
 drivers/clk/sifive/fu540-prci.c               |  8 ++++----
 include/dt-bindings/clock/sifive-fu540-prci.h | 18 ------------------
 include/dt-bindings/clock/sifive-fu740-prci.h | 24 ------------------------
 4 files changed, 17 insertions(+), 59 deletions(-)

diff --git a/arch/riscv/dts/fu540-c000-u-boot.dtsi b/arch/riscv/dts/fu540-c000-u-boot.dtsi
index 360679a1781a..0f8181436410 100644
--- a/arch/riscv/dts/fu540-c000-u-boot.dtsi
+++ b/arch/riscv/dts/fu540-c000-u-boot.dtsi
@@ -6,42 +6,42 @@
 #include <dt-bindings/reset/sifive-fu540-prci.h>
 
 / {
 	cpus {
-		assigned-clocks = <&prci PRCI_CLK_COREPLL>;
+		assigned-clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 		assigned-clock-rates = <1000000000>;
 		bootph-pre-ram;
 		cpu0: cpu@0 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			status = "okay";
 			cpu0_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu1: cpu@1 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu1_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu2: cpu@2 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu2_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu3: cpu@3 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu3_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
 		};
 		cpu4: cpu@4 {
-			clocks = <&prci PRCI_CLK_COREPLL>;
+			clocks = <&prci FU540_PRCI_CLK_COREPLL>;
 			bootph-pre-ram;
 			cpu4_intc: interrupt-controller {
 				bootph-pre-ram;
 			};
@@ -66,22 +66,22 @@
 			bootph-pre-ram;
 		};
 		prci: clock-controller@10000000 {
 			#reset-cells = <1>;
-			resets = <&prci PRCI_RST_DDR_CTRL_N>,
-				 <&prci PRCI_RST_DDR_AXI_N>,
-				 <&prci PRCI_RST_DDR_AHB_N>,
-				 <&prci PRCI_RST_DDR_PHY_N>,
-				 <&prci PRCI_RST_GEMGXL_N>;
+			resets = <&prci FU540_PRCI_RST_DDR_CTRL_N>,
+				 <&prci FU540_PRCI_RST_DDR_AXI_N>,
+				 <&prci FU540_PRCI_RST_DDR_AHB_N>,
+				 <&prci FU540_PRCI_RST_DDR_PHY_N>,
+				 <&prci FU540_PRCI_RST_GEMGXL_N>;
 			reset-names = "ddr_ctrl", "ddr_axi", "ddr_ahb",
 					"ddr_phy", "gemgxl_reset";
 		};
 		dmc: dmc@100b0000 {
 			compatible = "sifive,fu540-c000-ddr";
 			reg = <0x0 0x100b0000 0x0 0x0800
 			       0x0 0x100b2000 0x0 0x2000
 			       0x0 0x100b8000 0x0 0x1000>;
-			clocks = <&prci PRCI_CLK_DDRPLL>;
+			clocks = <&prci FU540_PRCI_CLK_DDRPLL>;
 			clock-frequency = <933333324>;
 			bootph-pre-ram;
 		};
 	};
@@ -99,9 +99,9 @@
 	bootph-pre-ram;
 };
 
 &eth0 {
-	assigned-clocks = <&prci PRCI_CLK_GEMGXLPLL>;
+	assigned-clocks = <&prci FU540_PRCI_CLK_GEMGXLPLL>;
 	assigned-clock-rates = <125000000>;
 };
 
 &l2cache {
diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index ceb2c6fab0da..b019f682ac49 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -58,27 +58,27 @@ static const struct __prci_clock_ops sifive_fu540_prci_tlclksel_clk_ops = {
 };
 
 /* List of clock controls provided by the PRCI */
 struct __prci_clock __prci_init_clocks_fu540[] = {
-	[PRCI_CLK_COREPLL] = {
+	[FU540_PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_corepll_data,
 	},
-	[PRCI_CLK_DDRPLL] = {
+	[FU540_PRCI_CLK_DDRPLL] = {
 		.name = "ddrpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_ddrpll_data,
 	},
-	[PRCI_CLK_GEMGXLPLL] = {
+	[FU540_PRCI_CLK_GEMGXLPLL] = {
 		.name = "gemgxlpll",
 		.parent_name = "hfclk",
 		.ops = &sifive_fu540_prci_wrpll_clk_ops,
 		.pwd = &__prci_gemgxlpll_data,
 	},
-	[PRCI_CLK_TLCLK] = {
+	[FU540_PRCI_CLK_TLCLK] = {
 		.name = "tlclk",
 		.parent_name = "corepll",
 		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
 	},
diff --git a/include/dt-bindings/clock/sifive-fu540-prci.h b/include/dt-bindings/clock/sifive-fu540-prci.h
deleted file mode 100644
index 6a0b70a37d78..000000000000
--- a/include/dt-bindings/clock/sifive-fu540-prci.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018-2019 SiFive, Inc.
- * Wesley Terpstra
- * Paul Walmsley
- */
-
-#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
-#define __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
-
-/* Clock indexes for use by Device Tree data and the PRCI driver */
-
-#define PRCI_CLK_COREPLL	       0
-#define PRCI_CLK_DDRPLL		       1
-#define PRCI_CLK_GEMGXLPLL	       2
-#define PRCI_CLK_TLCLK		       3
-
-#endif
diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
deleted file mode 100644
index 672bdadbf6c0..000000000000
--- a/include/dt-bindings/clock/sifive-fu740-prci.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- * Copyright (C) 2019 SiFive, Inc.
- * Wesley Terpstra
- * Paul Walmsley
- * Zong Li
- */
-
-#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
-#define __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
-
-/* Clock indexes for use by Device Tree data and the PRCI driver */
-
-#define FU740_PRCI_CLK_COREPLL		0
-#define FU740_PRCI_CLK_DDRPLL		1
-#define FU740_PRCI_CLK_GEMGXLPLL	2
-#define FU740_PRCI_CLK_DVFSCOREPLL	3
-#define FU740_PRCI_CLK_HFPCLKPLL	4
-#define FU740_PRCI_CLK_CLTXPLL		5
-#define FU740_PRCI_CLK_TLCLK		6
-#define FU740_PRCI_CLK_PCLK		7
-#define FU740_PRCI_CLK_PCIE_AUX		8
-
-#endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */

-- 
2.44.0


