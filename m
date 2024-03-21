Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA7BCD11DB
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:21:02 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.8951.1711055074798931571
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Mar 2024 14:04:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=E2CJIIvC;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so11880635e9.1
        for <u-boot-amlogic@groups.io>; Thu, 21 Mar 2024 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711055073; x=1711659873; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I2vaGPZZ3gjBTSC5fLRBtWa2TW127+ZHLJWBufbarI=;
        b=E2CJIIvCLIk+RMgQvhUSIc+G1K6naJFPzE7gNQhXVHJP8AG2oKCVxssmG09laynY7t
         7b+4YkA+zW1ieyrz78rU7E67mR3tmwj90CCzhRI5QXk7yNY09gs+dLBw3lCvov+t9hgq
         3ajqdmFP2j9guuD1iu4UR06xeo8HHbccwR7gHwEKxtq0FWCnmPrN6NR2+C2XzTj4Ek+8
         oUgzkgn7SdILr/AjBydvabXwNBbuFpPk3k+vog7iNoXnHirXZtkFJx/3Yl6VLZq1H6zB
         HQENbC8Z2Bh05JgRjEfYC8w4/LhDJeObgssfj83ROUrSkBMo5x3oHx0C/igg6jh7TFh7
         4ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055073; x=1711659873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I2vaGPZZ3gjBTSC5fLRBtWa2TW127+ZHLJWBufbarI=;
        b=DoyFLpWT5L740VaWKoUJmDOrn8h/YM6Urs4CH7fijxr1XUXlOu9GxBaqGx2Q6Z863l
         FSep5sEuejCTq7ddUpLiv+ql0nJhKZCNpJUmItvB6SpxqFUun4TIQMn/SW6pJNtspPI6
         BynRs5Fn7QMRhmxGXqhiiw30HV5zspMqDwLGwIwG11gK3SlkZTu7iHzJuZl6DL/EDueu
         OXY5A6LsJWyCr1NzeO+JnzCPpVP3EVD6Za6BsphnrWFM2kC8WlGsQ9VfgpfjDMHs9fa3
         p56l124Jkdf6714o4pSo34Gnlb+vjjNTF/Z4ZxFl6dpiXbybJFZH7zXUyIbW6H4Zf2m5
         1N8A==
X-Forwarded-Encrypted: i=1; AJvYcCVzjEs4TvYMvJLCIK9pB286EMWGafm9j6GKH6fOqZPSo7NM8rbatMTG8g+cI2eke+FD5YFsfHntkbswLclz0XtPEcvUfxqhfpU=
X-Gm-Message-State: AOJu0YwdUJ1tnHFhGpREntDQ3Ufl97Hcp59WkOja/tWtfwDgUn4/RMPw
	tQ+WFntoVN1Yj9+gTLyhDwnPLDGf7YZ+LxBm59QsV9w12XZV1fyDBMB2prehnbnZZnIAxxCdl1N
	M
X-Google-Smtp-Source: AGHT+IG1D0KirhwTixx0OE1NWwwM56ZABLDMneg9vVTboOBpaNCz6I5lkSUwzSReEJDiVk+hXg7CnQ==
X-Received: by 2002:a05:600c:4ecf:b0:414:61d9:d1f5 with SMTP id g15-20020a05600c4ecf00b0041461d9d1f5mr120513wmq.10.1711055072939;
        Thu, 21 Mar 2024 14:04:32 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004146f728906sm925462wmb.7.2024.03.21.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:04:32 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 21:04:01 +0000
Subject: [PATCH v2 18/24] microchip: drop dt-binding headers
MIME-Version: 1.0
Message-Id: <20240321-b4-upstream-dt-headers-v2-18-1eac0df875fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12736;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HkbSGabfPtjJGIe4yorv0zsrHjzqb6ecFAWLshl7GSU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ/C/ZWhCz52bThiL9B2swm8Xelv97Y/hA87v/p1xTtr
 HIzy+VeHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAibOIM/xTqtm2Yq1G658MN
 V9UKoUKVar06ifLANRKHIub1rV5a5cnwP/QMg5GcoYuFSJL0Zv41d2JXXJ7Te4b3jLZG+bOj7ae
 8VgEA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:21:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2230

Drop in favour of dts/upstream

Adjust header include path naming for mpfs clock.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/riscv/dts/mpfs.dtsi                         |  2 +-
 drivers/clk/microchip/mpfs_clk.c                 |  2 +-
 drivers/clk/microchip/mpfs_clk_cfg.c             |  2 +-
 drivers/clk/microchip/mpfs_clk_msspll.c          |  2 +-
 drivers/clk/microchip/mpfs_clk_periph.c          |  2 +-
 include/dt-bindings/clock/at91.h                 | 23 --------
 include/dt-bindings/clock/microchip-mpfs-clock.h | 71 ------------------------
 include/dt-bindings/dma/at91.h                   | 52 -----------------
 include/dt-bindings/mfd/at91-usart.h             | 17 ------
 include/dt-bindings/net/microchip-lan78xx.h      | 21 -------
 include/dt-bindings/pinctrl/at91.h               | 49 ----------------
 include/dt-bindings/sound/microchip,pdmc.h       | 13 -----
 12 files changed, 5 insertions(+), 251 deletions(-)

diff --git a/arch/riscv/dts/mpfs.dtsi b/arch/riscv/dts/mpfs.dtsi
index 6012a2850703..5827d5c5d19b 100644
--- a/arch/riscv/dts/mpfs.dtsi
+++ b/arch/riscv/dts/mpfs.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
-#include "dt-bindings/clock/microchip-mpfs-clock.h"
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
 
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
diff --git a/drivers/clk/microchip/mpfs_clk.c b/drivers/clk/microchip/mpfs_clk.c
index 08f8bfcecbed..44ac4306eace 100644
--- a/drivers/clk/microchip/mpfs_clk.c
+++ b/drivers/clk/microchip/mpfs_clk.c
@@ -10,9 +10,9 @@
 #include <log.h>
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
-#include <dt-bindings/clock/microchip-mpfs-clock.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <linux/err.h>
 
 #include "mpfs_clk.h"
 
diff --git a/drivers/clk/microchip/mpfs_clk_cfg.c b/drivers/clk/microchip/mpfs_clk_cfg.c
index 5739fd66e8df..953e88e283ed 100644
--- a/drivers/clk/microchip/mpfs_clk_cfg.c
+++ b/drivers/clk/microchip/mpfs_clk_cfg.c
@@ -9,9 +9,9 @@
 #include <asm/io.h>
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
-#include <dt-bindings/clock/microchip-mpfs-clock.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <linux/err.h>
 
 #include "mpfs_clk.h"
 
diff --git a/drivers/clk/microchip/mpfs_clk_msspll.c b/drivers/clk/microchip/mpfs_clk_msspll.c
index f37c0d86047c..7b5020404549 100644
--- a/drivers/clk/microchip/mpfs_clk_msspll.c
+++ b/drivers/clk/microchip/mpfs_clk_msspll.c
@@ -8,9 +8,9 @@
 #include <asm/io.h>
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
-#include <dt-bindings/clock/microchip-mpfs-clock.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <linux/err.h>
 
 #include "mpfs_clk.h"
 
diff --git a/drivers/clk/microchip/mpfs_clk_periph.c b/drivers/clk/microchip/mpfs_clk_periph.c
index ddeccb914575..16823402def3 100644
--- a/drivers/clk/microchip/mpfs_clk_periph.c
+++ b/drivers/clk/microchip/mpfs_clk_periph.c
@@ -9,9 +9,9 @@
 #include <asm/io.h>
 #include <dm/device.h>
 #include <dm/devres.h>
 #include <dm/uclass.h>
-#include <dt-bindings/clock/microchip-mpfs-clock.h>
+#include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <linux/err.h>
 
 #include "mpfs_clk.h"
 
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
deleted file mode 100644
index ab3ee241d10c..000000000000
--- a/include/dt-bindings/clock/at91.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * This header provides constants for AT91 pmc status.
- *
- * The constants defined in this header are being used in dts.
- *
- * Licensed under GPLv2 or later.
- */
-
-#ifndef _DT_BINDINGS_CLK_AT91_H
-#define _DT_BINDINGS_CLK_AT91_H
-
-#define AT91_PMC_MOSCS		0		/* MOSCS Flag */
-#define AT91_PMC_LOCKA		1		/* PLLA Lock */
-#define AT91_PMC_LOCKB		2		/* PLLB Lock */
-#define AT91_PMC_MCKRDY		3		/* Master Clock */
-#define AT91_PMC_LOCKU		6		/* UPLL Lock */
-#define AT91_PMC_PCKRDY(id)	(8 + (id))	/* Programmable Clock */
-#define AT91_PMC_MOSCSELS	16		/* Main Oscillator Selection */
-#define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
-#define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
-#define AT91_PMC_GCKRDY		24		/* Generated Clocks */
-
-#endif
diff --git a/include/dt-bindings/clock/microchip-mpfs-clock.h b/include/dt-bindings/clock/microchip-mpfs-clock.h
deleted file mode 100644
index 79775a5134ca..000000000000
--- a/include/dt-bindings/clock/microchip-mpfs-clock.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Daire McNamara,<daire.mcnamara@microchip.com>
- * Copyright (C) 2020-2022 Microchip Technology Inc.  All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_CLK_MICROCHIP_MPFS_H_
-#define _DT_BINDINGS_CLK_MICROCHIP_MPFS_H_
-
-#define CLK_CPU		0
-#define CLK_AXI		1
-#define CLK_AHB		2
-
-#define CLK_ENVM	3
-#define CLK_MAC0	4
-#define CLK_MAC1	5
-#define CLK_MMC		6
-#define CLK_TIMER	7
-#define CLK_MMUART0	8
-#define CLK_MMUART1	9
-#define CLK_MMUART2	10
-#define CLK_MMUART3	11
-#define CLK_MMUART4	12
-#define CLK_SPI0	13
-#define CLK_SPI1	14
-#define CLK_I2C0	15
-#define CLK_I2C1	16
-#define CLK_CAN0	17
-#define CLK_CAN1	18
-#define CLK_USB		19
-#define CLK_RESERVED	20
-#define CLK_RTC		21
-#define CLK_QSPI	22
-#define CLK_GPIO0	23
-#define CLK_GPIO1	24
-#define CLK_GPIO2	25
-#define CLK_DDRC	26
-#define CLK_FIC0	27
-#define CLK_FIC1	28
-#define CLK_FIC2	29
-#define CLK_FIC3	30
-#define CLK_ATHENA	31
-#define CLK_CFM		32
-
-#define CLK_RTCREF	33
-#define CLK_MSSPLL	34
-
-/* Clock Conditioning Circuitry Clock IDs */
-
-#define CLK_CCC_PLL0		0
-#define CLK_CCC_PLL1		1
-#define CLK_CCC_DLL0		2
-#define CLK_CCC_DLL1		3
-
-#define CLK_CCC_PLL0_OUT0	4
-#define CLK_CCC_PLL0_OUT1	5
-#define CLK_CCC_PLL0_OUT2	6
-#define CLK_CCC_PLL0_OUT3	7
-
-#define CLK_CCC_PLL1_OUT0	8
-#define CLK_CCC_PLL1_OUT1	9
-#define CLK_CCC_PLL1_OUT2	10
-#define CLK_CCC_PLL1_OUT3	11
-
-#define CLK_CCC_DLL0_OUT0	12
-#define CLK_CCC_DLL0_OUT1	13
-
-#define CLK_CCC_DLL1_OUT0	14
-#define CLK_CCC_DLL1_OUT1	15
-
-#endif	/* _DT_BINDINGS_CLK_MICROCHIP_MPFS_H_ */
diff --git a/include/dt-bindings/dma/at91.h b/include/dt-bindings/dma/at91.h
deleted file mode 100644
index ab6cbba45401..000000000000
--- a/include/dt-bindings/dma/at91.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * This header provides macros for at91 dma bindings.
- *
- * Copyright (C) 2013 Ludovic Desroches <ludovic.desroches@atmel.com>
- *
- * GPLv2 only
- */
-
-#ifndef __DT_BINDINGS_AT91_DMA_H__
-#define __DT_BINDINGS_AT91_DMA_H__
-
-/* ---------- HDMAC ---------- */
-
-/*
- * Source and/or destination peripheral ID
- */
-#define AT91_DMA_CFG_PER_ID_MASK	(0xff)
-#define AT91_DMA_CFG_PER_ID(id)		(id & AT91_DMA_CFG_PER_ID_MASK)
-
-/*
- * FIFO configuration: it defines when a request is serviced.
- */
-#define AT91_DMA_CFG_FIFOCFG_OFFSET	(8)
-#define AT91_DMA_CFG_FIFOCFG_MASK	(0xf << AT91_DMA_CFG_FIFOCFG_OFFSET)
-#define AT91_DMA_CFG_FIFOCFG_HALF	(0x0 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* half FIFO (default behavior) */
-#define AT91_DMA_CFG_FIFOCFG_ALAP	(0x1 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* largest defined AHB burst */
-#define AT91_DMA_CFG_FIFOCFG_ASAP	(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
-
-
-/* ---------- XDMAC ---------- */
-#define AT91_XDMAC_DT_MEM_IF_MASK	(0x1)
-#define AT91_XDMAC_DT_MEM_IF_OFFSET	(13)
-#define AT91_XDMAC_DT_MEM_IF(mem_if)	(((mem_if) & AT91_XDMAC_DT_MEM_IF_MASK) \
-					<< AT91_XDMAC_DT_MEM_IF_OFFSET)
-#define AT91_XDMAC_DT_GET_MEM_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_MEM_IF_OFFSET) \
-					& AT91_XDMAC_DT_MEM_IF_MASK)
-
-#define AT91_XDMAC_DT_PER_IF_MASK	(0x1)
-#define AT91_XDMAC_DT_PER_IF_OFFSET	(14)
-#define AT91_XDMAC_DT_PER_IF(per_if)	(((per_if) & AT91_XDMAC_DT_PER_IF_MASK) \
-					<< AT91_XDMAC_DT_PER_IF_OFFSET)
-#define AT91_XDMAC_DT_GET_PER_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_PER_IF_OFFSET) \
-					& AT91_XDMAC_DT_PER_IF_MASK)
-
-#define AT91_XDMAC_DT_PERID_MASK	(0x7f)
-#define AT91_XDMAC_DT_PERID_OFFSET	(24)
-#define AT91_XDMAC_DT_PERID(perid)	(((perid) & AT91_XDMAC_DT_PERID_MASK) \
-					<< AT91_XDMAC_DT_PERID_OFFSET)
-#define AT91_XDMAC_DT_GET_PERID(cfg)	(((cfg) >> AT91_XDMAC_DT_PERID_OFFSET) \
-					& AT91_XDMAC_DT_PERID_MASK)
-
-#endif /* __DT_BINDINGS_AT91_DMA_H__ */
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
deleted file mode 100644
index 2de5bc312e1e..000000000000
--- a/include/dt-bindings/mfd/at91-usart.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides macros for AT91 USART DT bindings.
- *
- * Copyright (C) 2018 Microchip Technology
- *
- * Author: Radu Pirea <radu.pirea@microchip.com>
- *
- */
-
-#ifndef __DT_BINDINGS_AT91_USART_H__
-#define __DT_BINDINGS_AT91_USART_H__
-
-#define AT91_USART_MODE_SERIAL	0
-#define AT91_USART_MODE_SPI	1
-
-#endif /* __DT_BINDINGS_AT91_USART_H__ */
diff --git a/include/dt-bindings/net/microchip-lan78xx.h b/include/dt-bindings/net/microchip-lan78xx.h
deleted file mode 100644
index 0742ff075307..000000000000
--- a/include/dt-bindings/net/microchip-lan78xx.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_MICROCHIP_LAN78XX_H
-#define _DT_BINDINGS_MICROCHIP_LAN78XX_H
-
-/* LED modes for LAN7800/LAN7850 embedded PHY */
-
-#define LAN78XX_LINK_ACTIVITY           0
-#define LAN78XX_LINK_1000_ACTIVITY      1
-#define LAN78XX_LINK_100_ACTIVITY       2
-#define LAN78XX_LINK_10_ACTIVITY        3
-#define LAN78XX_LINK_100_1000_ACTIVITY  4
-#define LAN78XX_LINK_10_1000_ACTIVITY   5
-#define LAN78XX_LINK_10_100_ACTIVITY    6
-#define LAN78XX_DUPLEX_COLLISION        8
-#define LAN78XX_COLLISION               9
-#define LAN78XX_ACTIVITY                10
-#define LAN78XX_AUTONEG_FAULT           12
-#define LAN78XX_FORCE_LED_OFF           14
-#define LAN78XX_FORCE_LED_ON            15
-
-#endif
diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
deleted file mode 100644
index 3831f91fb3ba..000000000000
--- a/include/dt-bindings/pinctrl/at91.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This header provides constants for most at91 pinctrl bindings.
- *
- * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- */
-
-#ifndef __DT_BINDINGS_AT91_PINCTRL_H__
-#define __DT_BINDINGS_AT91_PINCTRL_H__
-
-#define AT91_PINCTRL_NONE		(0 << 0)
-#define AT91_PINCTRL_PULL_UP		(1 << 0)
-#define AT91_PINCTRL_MULTI_DRIVE	(1 << 1)
-#define AT91_PINCTRL_DEGLITCH		(1 << 2)
-#define AT91_PINCTRL_PULL_DOWN		(1 << 3)
-#define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
-#define AT91_PINCTRL_OUTPUT		(1 << 7)
-#define AT91_PINCTRL_OUTPUT_VAL(x)	((x & 0x1) << 8)
-#define AT91_PINCTRL_SLEWRATE		(1 << 9)
-#define AT91_PINCTRL_DEBOUNCE		(1 << 16)
-#define AT91_PINCTRL_DEBOUNCE_VAL(x)	(x << 17)
-
-#define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
-
-#define AT91_PINCTRL_DRIVE_STRENGTH_DEFAULT		(0x0 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_LOW			(0x1 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_MED			(0x2 << 5)
-#define AT91_PINCTRL_DRIVE_STRENGTH_HI			(0x3 << 5)
-
-#define AT91_PINCTRL_SLEWRATE_DIS	(0x0 << 9)
-#define AT91_PINCTRL_SLEWRATE_ENA	(0x1 << 9)
-
-#define AT91_PIOA	0
-#define AT91_PIOB	1
-#define AT91_PIOC	2
-#define AT91_PIOD	3
-#define AT91_PIOE	4
-
-#define AT91_PERIPH_GPIO	0
-#define AT91_PERIPH_A		1
-#define AT91_PERIPH_B		2
-#define AT91_PERIPH_C		3
-#define AT91_PERIPH_D		4
-
-#define ATMEL_PIO_DRVSTR_LO	1
-#define ATMEL_PIO_DRVSTR_ME	2
-#define ATMEL_PIO_DRVSTR_HI	3
-
-#endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
diff --git a/include/dt-bindings/sound/microchip,pdmc.h b/include/dt-bindings/sound/microchip,pdmc.h
deleted file mode 100644
index 96cde94ce74f..000000000000
--- a/include/dt-bindings/sound/microchip,pdmc.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_BINDINGS_MICROCHIP_PDMC_H__
-#define __DT_BINDINGS_MICROCHIP_PDMC_H__
-
-/* PDM microphone's pin placement */
-#define MCHP_PDMC_DS0 0
-#define MCHP_PDMC_DS1 1
-
-/* PDM microphone clock edge sampling */
-#define MCHP_PDMC_CLK_POSITIVE 0
-#define MCHP_PDMC_CLK_NEGATIVE 1
-
-#endif /* __DT_BINDINGS_MICROCHIP_PDMC_H__ */

-- 
2.44.0


