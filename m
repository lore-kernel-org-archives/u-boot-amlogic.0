Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E538DCD1280
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:20:51 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.8939.1711055064282944292
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Mar 2024 14:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=sxhlfVS1;
 spf=pass (domain: linaro.org, ip: 209.85.208.182, mailfrom: caleb.connolly@linaro.org)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso18386561fa.1
        for <u-boot-amlogic@groups.io>; Thu, 21 Mar 2024 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711055062; x=1711659862; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87zIsJl3W/GELloZ6APqKPYV4z/pYzEdvS5LalYfWnA=;
        b=sxhlfVS1aODW+Co1ke/uOnx3RAwN76F0xH38Tv8Qi5xhfgLfD2BKr6Iffj1UAuVhUJ
         hBZ4UvKwY7Sawz35poNMFLcMtRlELGhPlXF8gAhdCj4I8SDDH46xM3BvDPG3mlRA0ou1
         EL7aPg74nmEMvRVn2fNgc7qCGcrPeIeqwbs8CN5/n6E2d2yxK+EIr8YVmzPIhPEj7rl5
         r6AY02g/+DZMHk+OMzHIfnLoGGj98fYcG8E98DpU5P3JD+9Pdo8d9naqlGNkzThl1ni0
         hsIKQ5TSsyZ3GCulHhdr+BpLkCX3GK0nIrcpZCJ/6kze9FS0gjooLu6mD0a/S1HQ4ldF
         hePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055062; x=1711659862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87zIsJl3W/GELloZ6APqKPYV4z/pYzEdvS5LalYfWnA=;
        b=ZjLo4gVqkTUfd05o8WGWWbzpnYeofqJF3+GaoLAwv9pe3iQh3koDFRBy+niNwkMNli
         7n/nBAUrp97x5VAZMcVIBiyi9eO7w9YC5X5Djy/fJUQNNFRfkpA9ggTERWO0esZrfoJQ
         fMabddf76W7evs7zT0xuQWGD7HOo95Hk8Gg8xI8D7qRpavpx/6+xOAbiEb4zuDZ70ekz
         8wPNFFulMDZcEBdibjiH2i4ESe7VKhxINQztUJWStqgUqVY8nVh27rhSX+eUJy4R6Q3S
         kRUbdf3CcMKrCQPx0Xkm4zmTGU++E5Xf79H3WpWCquT4eYZQVqS3JjF3mEX4yv263Kdi
         FtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/pQrGSar+WPaDR7HrH7/NNLWddL5BR4DM7EIw9dhu1IddhnHvYInhp8ViLedOlGJKS319y8EAthYdjZIYZUllGt332xZ+9Jo=
X-Gm-Message-State: AOJu0YxfePZNA16iVKbjDOSgOjSYmsUUfp03q0mgPxxSy/3to4fMtYw5
	SCZlQWMKQ8GSkXgTfuxdtyIjNNXhzidguhxAbu8vyf1iZkiFghRIx/cHUBcbY37eBZziahdchU3
	b
X-Google-Smtp-Source: AGHT+IE0NHspFDINUzcehLpG3ysLFPTMyRRYXk+NB4AbRJSFMixfLjT4O4V4p7PI6u2bM6PMsMuDAw==
X-Received: by 2002:a2e:9d98:0:b0:2d5:9b15:8064 with SMTP id c24-20020a2e9d98000000b002d59b158064mr441942ljj.14.1711055061997;
        Thu, 21 Mar 2024 14:04:21 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004146f728906sm925462wmb.7.2024.03.21.14.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:04:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 21:03:55 +0000
Subject: [PATCH v2 12/24] bcm: drop dt-binding headers
MIME-Version: 1.0
Message-Id: <20240321-b4-upstream-dt-headers-v2-12-1eac0df875fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22436;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=p2kQlLlmG+uZoQ7cbK+KtCThsdXUbN1+sfAF6FEk0VM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ/C/YcZ2gSYn52f0b2v5sGRTwL50osZp6qm8zawHh/8
 WrpfxlsHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiegEM/zNf71aoTJzouF5x
 fl4I57X+Uz3nTOsEvnzOfJQso2L2KoPhN4v0y9cnT2+9eTz0/JSn3XEcTH4t8pr93tNLl13Mb9m
 +chYA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:20:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2224

Drop in favour of dts/upstream

Fix bcm6318 USB clock name

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/mips/dts/brcm,bcm6318.dtsi            |  2 +-
 include/dt-bindings/clock/bcm-nsp.h        | 51 ------------------------
 include/dt-bindings/clock/bcm2835-aux.h    |  9 -----
 include/dt-bindings/clock/bcm2835.h        | 62 ------------------------------
 include/dt-bindings/clock/bcm6318-clock.h  | 47 ----------------------
 include/dt-bindings/clock/bcm63268-clock.h | 51 ------------------------
 include/dt-bindings/clock/bcm6328-clock.h  | 24 ------------
 include/dt-bindings/clock/bcm6358-clock.h  | 23 -----------
 include/dt-bindings/clock/bcm6362-clock.h  | 32 ---------------
 include/dt-bindings/clock/bcm6368-clock.h  | 30 ---------------
 include/dt-bindings/pinctrl/bcm2835.h      | 26 -------------
 include/dt-bindings/reset/bcm6318-reset.h  | 25 ------------
 include/dt-bindings/reset/bcm63268-reset.h | 31 ---------------
 include/dt-bindings/reset/bcm6328-reset.h  | 23 -----------
 include/dt-bindings/reset/bcm6358-reset.h  | 20 ----------
 include/dt-bindings/reset/bcm6362-reset.h  | 27 -------------
 include/dt-bindings/reset/bcm6368-reset.h  | 21 ----------
 include/dt-bindings/soc/bcm2835-pm.h       | 28 --------------
 18 files changed, 1 insertion(+), 531 deletions(-)

diff --git a/arch/mips/dts/brcm,bcm6318.dtsi b/arch/mips/dts/brcm,bcm6318.dtsi
index 5813de7bf6b9..b9cc0712f8bc 100644
--- a/arch/mips/dts/brcm,bcm6318.dtsi
+++ b/arch/mips/dts/brcm,bcm6318.dtsi
@@ -181,9 +181,9 @@
 		usbh: usb-phy@10005200 {
 			compatible = "brcm,bcm6318-usbh";
 			reg = <0x10005200 0x30>;
 			#phy-cells = <0>;
-			clocks = <&periph_clk BCM6318_CLK_USB>;
+			clocks = <&periph_clk BCM6318_CLK_USBD>;
 			clock-names = "usbh";
 			power-domains = <&periph_pwr BCM6318_PWR_USB>;
 			resets = <&periph_rst BCM6318_RST_USBH>;
 
diff --git a/include/dt-bindings/clock/bcm-nsp.h b/include/dt-bindings/clock/bcm-nsp.h
deleted file mode 100644
index ad5827cde782..000000000000
--- a/include/dt-bindings/clock/bcm-nsp.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- *  BSD LICENSE
- *
- *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *
- *	* Redistributions of source code must retain the above copyright
- *	  notice, this list of conditions and the following disclaimer.
- *	* Redistributions in binary form must reproduce the above copyright
- *	  notice, this list of conditions and the following disclaimer in
- *	  the documentation and/or other materials provided with the
- *	  distribution.
- *	* Neither the name of Broadcom Corporation nor the names of its
- *	  contributors may be used to endorse or promote products derived
- *	  from this software without specific prior written permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef _CLOCK_BCM_NSP_H
-#define _CLOCK_BCM_NSP_H
-
-/* GENPLL clock channel ID */
-#define BCM_NSP_GENPLL			0
-#define BCM_NSP_GENPLL_PHY_CLK		1
-#define BCM_NSP_GENPLL_ENET_SW_CLK	2
-#define BCM_NSP_GENPLL_USB_PHY_REF_CLK	3
-#define BCM_NSP_GENPLL_IPROCFAST_CLK	4
-#define BCM_NSP_GENPLL_SATA1_CLK	5
-#define BCM_NSP_GENPLL_SATA2_CLK	6
-
-/* LCPLL0 clock channel ID */
-#define BCM_NSP_LCPLL0			0
-#define BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK	1
-#define BCM_NSP_LCPLL0_SDIO_CLK		2
-#define BCM_NSP_LCPLL0_DDR_PHY_CLK	3
-
-#endif /* _CLOCK_BCM_NSP_H */
diff --git a/include/dt-bindings/clock/bcm2835-aux.h b/include/dt-bindings/clock/bcm2835-aux.h
deleted file mode 100644
index bb79de383a3b..000000000000
--- a/include/dt-bindings/clock/bcm2835-aux.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2015 Broadcom Corporation
- */
-
-#define BCM2835_AUX_CLOCK_UART		0
-#define BCM2835_AUX_CLOCK_SPI1		1
-#define BCM2835_AUX_CLOCK_SPI2		2
-#define BCM2835_AUX_CLOCK_COUNT		3
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
deleted file mode 100644
index b60c03430cf1..000000000000
--- a/include/dt-bindings/clock/bcm2835.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2015 Broadcom Corporation
- */
-
-#define BCM2835_PLLA			0
-#define BCM2835_PLLB			1
-#define BCM2835_PLLC			2
-#define BCM2835_PLLD			3
-#define BCM2835_PLLH			4
-
-#define BCM2835_PLLA_CORE		5
-#define BCM2835_PLLA_PER		6
-#define BCM2835_PLLB_ARM		7
-#define BCM2835_PLLC_CORE0		8
-#define BCM2835_PLLC_CORE1		9
-#define BCM2835_PLLC_CORE2		10
-#define BCM2835_PLLC_PER		11
-#define BCM2835_PLLD_CORE		12
-#define BCM2835_PLLD_PER		13
-#define BCM2835_PLLH_RCAL		14
-#define BCM2835_PLLH_AUX		15
-#define BCM2835_PLLH_PIX		16
-
-#define BCM2835_CLOCK_TIMER		17
-#define BCM2835_CLOCK_OTP		18
-#define BCM2835_CLOCK_UART		19
-#define BCM2835_CLOCK_VPU		20
-#define BCM2835_CLOCK_V3D		21
-#define BCM2835_CLOCK_ISP		22
-#define BCM2835_CLOCK_H264		23
-#define BCM2835_CLOCK_VEC		24
-#define BCM2835_CLOCK_HSM		25
-#define BCM2835_CLOCK_SDRAM		26
-#define BCM2835_CLOCK_TSENS		27
-#define BCM2835_CLOCK_EMMC		28
-#define BCM2835_CLOCK_PERI_IMAGE	29
-#define BCM2835_CLOCK_PWM		30
-#define BCM2835_CLOCK_PCM		31
-
-#define BCM2835_PLLA_DSI0		32
-#define BCM2835_PLLA_CCP2		33
-#define BCM2835_PLLD_DSI0		34
-#define BCM2835_PLLD_DSI1		35
-
-#define BCM2835_CLOCK_AVEO		36
-#define BCM2835_CLOCK_DFT		37
-#define BCM2835_CLOCK_GP0		38
-#define BCM2835_CLOCK_GP1		39
-#define BCM2835_CLOCK_GP2		40
-#define BCM2835_CLOCK_SLIM		41
-#define BCM2835_CLOCK_SMI		42
-#define BCM2835_CLOCK_TEC		43
-#define BCM2835_CLOCK_DPI		44
-#define BCM2835_CLOCK_CAM0		45
-#define BCM2835_CLOCK_CAM1		46
-#define BCM2835_CLOCK_DSI0E		47
-#define BCM2835_CLOCK_DSI1E		48
-#define BCM2835_CLOCK_DSI0P		49
-#define BCM2835_CLOCK_DSI1P		50
-
-#define BCM2711_CLOCK_EMMC2		51
diff --git a/include/dt-bindings/clock/bcm6318-clock.h b/include/dt-bindings/clock/bcm6318-clock.h
deleted file mode 100644
index 3f10448cef11..000000000000
--- a/include/dt-bindings/clock/bcm6318-clock.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6318_H
-#define __DT_BINDINGS_CLOCK_BCM6318_H
-
-#define BCM6318_CLK_ADSL_ASB	0
-#define BCM6318_CLK_USB_ASB	1
-#define BCM6318_CLK_MIPS_ASB	2
-#define BCM6318_CLK_PCIE_ASB	3
-#define BCM6318_CLK_PHYMIPS_ASB	4
-#define BCM6318_CLK_ROBOSW_ASB	5
-#define BCM6318_CLK_SAR_ASB	6
-#define BCM6318_CLK_SDR_ASB	7
-#define BCM6318_CLK_SWREG_ASB	8
-#define BCM6318_CLK_PERIPH_ASB	9
-#define BCM6318_CLK_CPUBUS160	10
-#define BCM6318_CLK_ADSL	11
-#define BCM6318_CLK_SAR125	12
-#define BCM6318_CLK_MIPS	13
-#define BCM6318_CLK_PCIE	14
-#define BCM6318_CLK_ROBOSW250	16
-#define BCM6318_CLK_ROBOSW025	17
-#define BCM6318_CLK_SDR		19
-#define BCM6318_CLK_USB		20
-#define BCM6318_CLK_HSSPI	25
-#define BCM6318_CLK_PCIE25	27
-#define BCM6318_CLK_PHYMIPS	28
-#define BCM6318_CLK_AFE		29
-#define BCM6318_CLK_QPROC	30
-
-#define BCM6318_UCLK_ADSL	0
-#define BCM6318_UCLK_ARB	1
-#define BCM6318_UCLK_MIPS	2
-#define BCM6318_UCLK_PCIE	3
-#define BCM6318_UCLK_PERIPH	4
-#define BCM6318_UCLK_PHYMIPS	5
-#define BCM6318_UCLK_ROBOSW	6
-#define BCM6318_UCLK_SAR	7
-#define BCM6318_UCLK_SDR	8
-#define BCM6318_UCLK_USB	9
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6318_H */
diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
deleted file mode 100644
index 2725dcd06bcc..000000000000
--- a/include/dt-bindings/clock/bcm63268-clock.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM63268_H
-#define __DT_BINDINGS_CLOCK_BCM63268_H
-
-#define BCM63268_CLK_GLESS	0
-#define BCM63268_CLK_VDSL_QPROC	1
-#define BCM63268_CLK_VDSL_AFE	2
-#define BCM63268_CLK_VDSL	3
-#define BCM63268_CLK_MIPS	4
-#define BCM63268_CLK_WLAN_OCP	5
-#define BCM63268_CLK_DECT	6
-#define BCM63268_CLK_FAP0	7
-#define BCM63268_CLK_FAP1	8
-#define BCM63268_CLK_SAR	9
-#define BCM63268_CLK_ROBOSW	10
-#define BCM63268_CLK_PCM	11
-#define BCM63268_CLK_USBD	12
-#define BCM63268_CLK_USBH	13
-#define BCM63268_CLK_IPSEC	14
-#define BCM63268_CLK_SPI	15
-#define BCM63268_CLK_HSSPI	16
-#define BCM63268_CLK_PCIE	17
-#define BCM63268_CLK_PHYMIPS	18
-#define BCM63268_CLK_GMAC	19
-#define BCM63268_CLK_NAND	20
-#define BCM63268_CLK_TBUS	27
-#define BCM63268_CLK_ROBOSW250	31
-
-#define BCM63268_TCLK_EPHY1	0
-#define BCM63268_TCLK_EPHY2	1
-#define BCM63268_TCLK_EPHY3	2
-#define BCM63268_TCLK_GPHY	3
-#define BCM63268_TCLK_DSL	4
-#define BCM63268_TCLK_WO_EPHY	5
-#define BCM63268_TCLK_WO_DSL	6
-#define BCM63268_TCLK_FAP1	11
-#define BCM63268_TCLK_FAP2	15
-#define BCM63268_TCLK_UTO_50	16
-#define BCM63268_TCLK_UTO_EXT	17
-#define BCM63268_TCLK_USB_REF	18
-#define BCM63268_TCLK_SW_RST	29
-#define BCM63268_TCLK_HW_RST	30
-#define BCM63268_TCLK_POR_RST	31
-
-#endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
diff --git a/include/dt-bindings/clock/bcm6328-clock.h b/include/dt-bindings/clock/bcm6328-clock.h
deleted file mode 100644
index 6f1e018a74bb..000000000000
--- a/include/dt-bindings/clock/bcm6328-clock.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6328_H
-#define __DT_BINDINGS_CLOCK_BCM6328_H
-
-#define BCM6328_CLK_PHYMIPS	0
-#define BCM6328_CLK_ADSL_QPROC	1
-#define BCM6328_CLK_ADSL_AFE	2
-#define BCM6328_CLK_ADSL	3
-#define BCM6328_CLK_MIPS	4
-#define BCM6328_CLK_SAR		5
-#define BCM6328_CLK_PCM		6
-#define BCM6328_CLK_USBD	7
-#define BCM6328_CLK_USBH	8
-#define BCM6328_CLK_HSSPI	9
-#define BCM6328_CLK_PCIE	10
-#define BCM6328_CLK_ROBOSW	11
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6328_H */
diff --git a/include/dt-bindings/clock/bcm6358-clock.h b/include/dt-bindings/clock/bcm6358-clock.h
deleted file mode 100644
index a7529bcc0303..000000000000
--- a/include/dt-bindings/clock/bcm6358-clock.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6358_H
-#define __DT_BINDINGS_CLOCK_BCM6358_H
-
-#define BCM6358_CLK_ENET	4
-#define BCM6358_CLK_ADSL	5
-#define BCM6358_CLK_PCM		8
-#define BCM6358_CLK_SPI		9
-#define BCM6358_CLK_USBS	10
-#define BCM6358_CLK_SAR		11
-#define BCM6358_CLK_EMUSB	17
-#define BCM6358_CLK_ENET0	18
-#define BCM6358_CLK_ENET1	19
-#define BCM6358_CLK_USBSU	20
-#define BCM6358_CLK_EPHY	21
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6358_H */
diff --git a/include/dt-bindings/clock/bcm6362-clock.h b/include/dt-bindings/clock/bcm6362-clock.h
deleted file mode 100644
index d3770c504909..000000000000
--- a/include/dt-bindings/clock/bcm6362-clock.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6362_H
-#define __DT_BINDINGS_CLOCK_BCM6362_H
-
-#define BCM6362_CLK_GLESS	0
-#define BCM6362_CLK_ADSL_QPROC	1
-#define BCM6362_CLK_ADSL_AFE	2
-#define BCM6362_CLK_ADSL	3
-#define BCM6362_CLK_MIPS	4
-#define BCM6362_CLK_WLAN_OCP	5
-#define BCM6362_CLK_SWPKT_USB	7
-#define BCM6362_CLK_SWPKT_SAR	8
-#define BCM6362_CLK_SAR		9
-#define BCM6362_CLK_ROBOSW	10
-#define BCM6362_CLK_PCM		11
-#define BCM6362_CLK_USBD	12
-#define BCM6362_CLK_USBH	13
-#define BCM6362_CLK_IPSEC	14
-#define BCM6362_CLK_SPI		15
-#define BCM6362_CLK_HSSPI	16
-#define BCM6362_CLK_PCIE	17
-#define BCM6362_CLK_FAP		18
-#define BCM6362_CLK_PHYMIPS	19
-#define BCM6362_CLK_NAND	20
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6362_H */
diff --git a/include/dt-bindings/clock/bcm6368-clock.h b/include/dt-bindings/clock/bcm6368-clock.h
deleted file mode 100644
index 0c857826329a..000000000000
--- a/include/dt-bindings/clock/bcm6368-clock.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_CLOCK_BCM6368_H
-#define __DT_BINDINGS_CLOCK_BCM6368_H
-
-#define BCM6368_CLK_VDSL_QPROC		2
-#define BCM6368_CLK_VDSL_AFE		3
-#define BCM6368_CLK_VDSL_BONDING	4
-#define BCM6368_CLK_VDSL		5
-#define BCM6368_CLK_PHYMIPS		6
-#define BCM6368_CLK_SWPKT_USB		7
-#define BCM6368_CLK_SWPKT_SAR		8
-#define BCM6368_CLK_SPI			9
-#define BCM6368_CLK_USBD		10
-#define BCM6368_CLK_SAR			11
-#define BCM6368_CLK_ROBOSW		12
-#define BCM6368_CLK_UTOPIA		13
-#define BCM6368_CLK_PCM			14
-#define BCM6368_CLK_USBH		15
-#define BCM6368_CLK_GLESS		16
-#define BCM6368_CLK_NAND		17
-#define BCM6368_CLK_IPSEC		18
-#define BCM6368_CLK_USBH_IDDQ		19
-
-#endif /* __DT_BINDINGS_CLOCK_BCM6368_H */
diff --git a/include/dt-bindings/pinctrl/bcm2835.h b/include/dt-bindings/pinctrl/bcm2835.h
deleted file mode 100644
index b5b2654a0e4d..000000000000
--- a/include/dt-bindings/pinctrl/bcm2835.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Header providing constants for bcm2835 pinctrl bindings.
- *
- * Copyright (C) 2015 Stefan Wahren <stefan.wahren@i2se.com>
- */
-
-#ifndef __DT_BINDINGS_PINCTRL_BCM2835_H__
-#define __DT_BINDINGS_PINCTRL_BCM2835_H__
-
-/* brcm,function property */
-#define BCM2835_FSEL_GPIO_IN	0
-#define BCM2835_FSEL_GPIO_OUT	1
-#define BCM2835_FSEL_ALT5	2
-#define BCM2835_FSEL_ALT4	3
-#define BCM2835_FSEL_ALT0	4
-#define BCM2835_FSEL_ALT1	5
-#define BCM2835_FSEL_ALT2	6
-#define BCM2835_FSEL_ALT3	7
-
-/* brcm,pull property */
-#define BCM2835_PUD_OFF		0
-#define BCM2835_PUD_DOWN	1
-#define BCM2835_PUD_UP		2
-
-#endif /* __DT_BINDINGS_PINCTRL_BCM2835_H__ */
diff --git a/include/dt-bindings/reset/bcm6318-reset.h b/include/dt-bindings/reset/bcm6318-reset.h
deleted file mode 100644
index 1422500f8f52..000000000000
--- a/include/dt-bindings/reset/bcm6318-reset.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6318_H
-#define __DT_BINDINGS_RESET_BCM6318_H
-
-#define BCM6318_RST_SPI		0
-#define BCM6318_RST_EPHY	1
-#define BCM6318_RST_SAR		2
-#define BCM6318_RST_ENETSW	3
-#define BCM6318_RST_USBD	4
-#define BCM6318_RST_USBH	5
-#define BCM6318_RST_PCIE_CORE	6
-#define BCM6318_RST_PCIE	7
-#define BCM6318_RST_PCIE_EXT	8
-#define BCM6318_RST_PCIE_HARD	9
-#define BCM6318_RST_ADSL	10
-#define BCM6318_RST_PHYMIPS	11
-#define BCM6318_RST_HOSTMIPS	11
-
-#endif /* __DT_BINDINGS_RESET_BCM6318_H */
diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
deleted file mode 100644
index a45abed1ceb7..000000000000
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM63268_H
-#define __DT_BINDINGS_RESET_BCM63268_H
-
-#define BCM63268_RST_SPI	0
-#define BCM63268_RST_IPSEC	1
-#define BCM63268_RST_EPHY	2
-#define BCM63268_RST_SAR	3
-#define BCM63268_RST_ENETSW	4
-#define BCM63268_RST_USBS	5
-#define BCM63268_RST_USBH	6
-#define BCM63268_RST_PCM	7
-#define BCM63268_RST_PCIE_CORE	8
-#define BCM63268_RST_PCIE	9
-#define BCM63268_RST_PCIE_EXT	10
-#define BCM63268_RST_WLAN_SHIM	11
-#define BCM63268_RST_DDR_PHY	12
-#define BCM63268_RST_FAP0	13
-#define BCM63268_RST_WLAN_UBUS	14
-#define BCM63268_RST_DECT	15
-#define BCM63268_RST_FAP1	16
-#define BCM63268_RST_PCIE_HARD	17
-#define BCM63268_RST_GPHY	18
-
-#endif /* __DT_BINDINGS_RESET_BCM63268_H */
diff --git a/include/dt-bindings/reset/bcm6328-reset.h b/include/dt-bindings/reset/bcm6328-reset.h
deleted file mode 100644
index f2dd4f79cc61..000000000000
--- a/include/dt-bindings/reset/bcm6328-reset.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6328_H
-#define __DT_BINDINGS_RESET_BCM6328_H
-
-#define BCM6328_RST_SPI		0
-#define BCM6328_RST_EPHY	1
-#define BCM6328_RST_SAR		2
-#define BCM6328_RST_ENETSW	3
-#define BCM6328_RST_USBS	4
-#define BCM6328_RST_USBH	5
-#define BCM6328_RST_PCM		6
-#define BCM6328_RST_PCIE_CORE	7
-#define BCM6328_RST_PCIE	8
-#define BCM6328_RST_PCIE_EXT	9
-#define BCM6328_RST_PCIE_HARD	10
-
-#endif /* __DT_BINDINGS_RESET_BCM6328_H */
diff --git a/include/dt-bindings/reset/bcm6358-reset.h b/include/dt-bindings/reset/bcm6358-reset.h
deleted file mode 100644
index 075706eff7ad..000000000000
--- a/include/dt-bindings/reset/bcm6358-reset.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6358_H
-#define __DT_BINDINGS_RESET_BCM6358_H
-
-#define BCM6358_RST_SPI		0
-#define BCM6358_RST_ENET	2
-#define BCM6358_RST_MPI		3
-#define BCM6358_RST_EPHY	6
-#define BCM6358_RST_SAR		7
-#define BCM6358_RST_USBH	12
-#define BCM6358_RST_PCM		13
-#define BCM6358_RST_ADSL	14
-
-#endif /* __DT_BINDINGS_RESET_BCM6358_H */
diff --git a/include/dt-bindings/reset/bcm6362-reset.h b/include/dt-bindings/reset/bcm6362-reset.h
deleted file mode 100644
index 8202e4991905..000000000000
--- a/include/dt-bindings/reset/bcm6362-reset.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6362_H
-#define __DT_BINDINGS_RESET_BCM6362_H
-
-#define BCM6362_RST_SPI		0
-#define BCM6362_RST_IPSEC	1
-#define BCM6362_RST_EPHY	2
-#define BCM6362_RST_SAR		3
-#define BCM6362_RST_ENETSW	4
-#define BCM6362_RST_USBD	5
-#define BCM6362_RST_USBH	6
-#define BCM6362_RST_PCM		7
-#define BCM6362_RST_PCIE_CORE	8
-#define BCM6362_RST_PCIE	9
-#define BCM6362_RST_PCIE_EXT	10
-#define BCM6362_RST_WLAN_SHIM	11
-#define BCM6362_RST_DDR_PHY	12
-#define BCM6362_RST_FAP		13
-#define BCM6362_RST_WLAN_UBUS	14
-
-#endif /* __DT_BINDINGS_RESET_BCM6362_H */
diff --git a/include/dt-bindings/reset/bcm6368-reset.h b/include/dt-bindings/reset/bcm6368-reset.h
deleted file mode 100644
index 0038a7ccf5c6..000000000000
--- a/include/dt-bindings/reset/bcm6368-reset.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
- *
- * Derived from linux/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
- */
-
-#ifndef __DT_BINDINGS_RESET_BCM6368_H
-#define __DT_BINDINGS_RESET_BCM6368_H
-
-#define BCM6368_RST_SPI		0
-#define BCM6368_RST_MPI		3
-#define BCM6368_RST_IPSEC	4
-#define BCM6368_RST_EPHY	6
-#define BCM6368_RST_SAR		7
-#define BCM6368_RST_SWITCH	10
-#define BCM6368_RST_USBD	11
-#define BCM6368_RST_USBH	12
-#define BCM6368_RST_PCM		13
-
-#endif /* __DT_BINDINGS_RESET_BCM6368_H */
diff --git a/include/dt-bindings/soc/bcm2835-pm.h b/include/dt-bindings/soc/bcm2835-pm.h
deleted file mode 100644
index 153d75b8d99f..000000000000
--- a/include/dt-bindings/soc/bcm2835-pm.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-
-#ifndef _DT_BINDINGS_ARM_BCM2835_PM_H
-#define _DT_BINDINGS_ARM_BCM2835_PM_H
-
-#define BCM2835_POWER_DOMAIN_GRAFX		0
-#define BCM2835_POWER_DOMAIN_GRAFX_V3D		1
-#define BCM2835_POWER_DOMAIN_IMAGE		2
-#define BCM2835_POWER_DOMAIN_IMAGE_PERI		3
-#define BCM2835_POWER_DOMAIN_IMAGE_ISP		4
-#define BCM2835_POWER_DOMAIN_IMAGE_H264		5
-#define BCM2835_POWER_DOMAIN_USB		6
-#define BCM2835_POWER_DOMAIN_DSI0		7
-#define BCM2835_POWER_DOMAIN_DSI1		8
-#define BCM2835_POWER_DOMAIN_CAM0		9
-#define BCM2835_POWER_DOMAIN_CAM1		10
-#define BCM2835_POWER_DOMAIN_CCP2TX		11
-#define BCM2835_POWER_DOMAIN_HDMI		12
-
-#define BCM2835_POWER_DOMAIN_COUNT		13
-
-#define BCM2835_RESET_V3D			0
-#define BCM2835_RESET_ISP			1
-#define BCM2835_RESET_H264			2
-
-#define BCM2835_RESET_COUNT			3
-
-#endif /* _DT_BINDINGS_ARM_BCM2835_PM_H */

-- 
2.44.0


