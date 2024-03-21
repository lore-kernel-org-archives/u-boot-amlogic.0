Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1868CD1280
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 15:21:02 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.8706.1711055081066889715
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Mar 2024 14:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=riDRQbO0;
 spf=pass (domain: linaro.org, ip: 209.85.128.47, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414701303f7so13607035e9.2
        for <u-boot-amlogic@groups.io>; Thu, 21 Mar 2024 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711055079; x=1711659879; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffIVDJz1y7OM3JJ24KwM/uzflOAKoEDYymvtlDYXFbg=;
        b=riDRQbO0egSq1u+0cT6el6qofW5gvHvw8iVyV4aSsuuQ19rPJduNgKEaZhS3dyWHDc
         k83kI4fijCjxiumOs9SQu3+A+1VCmIeU1Sd5lHFmpuV2OugESGR9LLXZ7mRFt80+rJiw
         HjpzJM7HWBWUgfKykRzdWCzRXOgXUsqWtSPvZQuzJTqDV3AtWWOKan4KEZ4CGaahIZrx
         /rBwsGLRTkhap2wGeBfNnLMh/pMj/iMziOMUaC5NIEaahp4Fz6Tx4K4ej7gjP6YSDVs1
         gy6vuEmkMhm4JpMITtRf2RQMRuk2wRD4cPUGeLewq505XsKyHpwHDE0FDZ5HMhFYWmeY
         2Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711055079; x=1711659879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffIVDJz1y7OM3JJ24KwM/uzflOAKoEDYymvtlDYXFbg=;
        b=pVWeIKb0E6oi1YnbIipI47oQsZuNJQUd0PLMcyBD6nKnfzdLRGhM8z8iJk6KZ2Ooia
         FugJUlBPcZbCPgjD3VrsVZI3evVLde0GmGrTWlvkr60OBFKW/JQkQtfrONg2Ydw+EUy2
         ELubsxZoik6KUZJJjbU4jdzcM2Ei+pcOeIdX5Au7m7Jaav1rOXtzgZ8JkHzbos3QKi/X
         ZCIf6qpDoGMLrxRDAlZSpFz4JbHIyX4vT0CO2K1M8AGHLP2Rwg0cAh+V1PXu1GRO6JNa
         UXodinpFe+u7nTSQPvnjiTZPQG/jILlVDt+I3joQrgUZu+zDFF25OypUhpIksbLedNqd
         jUZw==
X-Forwarded-Encrypted: i=1; AJvYcCXQGuVMg7Qfqmyjx/6XyNRByaWEMGV4E2cPf09bP5sY3ED2EceaXqTIzPBiEgrnZ602qbUVrKokHCwckbc5c5+qrmhVNhb8ZSM=
X-Gm-Message-State: AOJu0YwLVLstra2MUK2Hi2vxi565MXaFKKVNm5ILZ/KoiUCUcnFqM8T0
	K6UI6DERuNvt62qgwOS1G6dtuBaOmnZtNzv59zRm1xhKeSMO6GN1ozMPGeHB1fFKcV6rHdB20D3
	B
X-Google-Smtp-Source: AGHT+IHYX/CmyVql1nXRAUqP/o/7EjhqU+3UE6rVBmkERf4hiPF4nLc5OitkCupLE60mFM8UKJa2aQ==
X-Received: by 2002:a05:600c:314a:b0:413:271d:8889 with SMTP id h10-20020a05600c314a00b00413271d8889mr278305wmo.11.1711055078653;
        Thu, 21 Mar 2024 14:04:38 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05600c1e0f00b004146f728906sm925462wmb.7.2024.03.21.14.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:04:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 21 Mar 2024 21:04:05 +0000
Subject: [PATCH v2 22/24] dt-bindings: drop remaining device headers
MIME-Version: 1.0
Message-Id: <20240321-b4-upstream-dt-headers-v2-22-1eac0df875fe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=57159;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=+SaR/YUeWm39ABYr58Q5GGX1LKEkWFRSigvbnu2j7NE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ/C/aWzN0cd2aazdyQy9Om7IrkkkgNbpyTp7j7zlWeC
 ZqlLzeqdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ3EhlZJjLfmQi0/siJ36j
 qAuaR8vMN0t9+e1fXbqd/UKyc8XXvg5GhkkzihZoXluvlFXxp1ydpSG31+uCY0FNU5ioOp/b/m3
 3GAE=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 22 Mar 2024 15:21:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2234

Drop in favour of dts/upstream.

Remaining device headers for small vendors

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/arm/coresight-cti-dt.h         |  37 -----
 include/dt-bindings/arm/ux500_pm_domains.h         |  15 --
 include/dt-bindings/bus/moxtet.h                   |  16 --
 include/dt-bindings/display/tda998x.h              |   8 -
 include/dt-bindings/gpio/aspeed-gpio.h             |  51 ------
 include/dt-bindings/gpio/uniphier-gpio.h           |  18 --
 .../dt-bindings/interrupt-controller/apple-aic.h   |  15 --
 include/dt-bindings/interrupt-controller/arm-gic.h |  23 ---
 include/dt-bindings/interrupt-controller/irq-st.h  |  30 ----
 .../dt-bindings/interrupt-controller/irqc-rzg2l.h  |  25 ---
 .../dt-bindings/interrupt-controller/mips-gic.h    |   9 -
 include/dt-bindings/leds/leds-netxbig.h            |  18 --
 include/dt-bindings/leds/leds-ns2.h                |   9 -
 include/dt-bindings/leds/leds-pca9532.h            |  18 --
 include/dt-bindings/media/tda1997x.h               |  74 ---------
 include/dt-bindings/media/video-interfaces.h       |  16 --
 include/dt-bindings/mfd/atmel-flexcom.h            |  15 --
 include/dt-bindings/mfd/dbx500-prcmu.h             |  84 ----------
 include/dt-bindings/net/mscc-phy-vsc8531.h         |  31 ----
 include/dt-bindings/net/qca-ar803x.h               |  13 --
 include/dt-bindings/phy/phy-am654-serdes.h         |  13 --
 include/dt-bindings/phy/phy-cadence.h              |  24 ---
 include/dt-bindings/pinctrl/apple.h                |  13 --
 include/dt-bindings/pinctrl/dra.h                  |  79 ---------
 include/dt-bindings/power/owl-s700-powergate.h     |  19 ---
 include/dt-bindings/power/raspberrypi-power.h      |  41 -----
 .../dt-bindings/regulator/dlg,da9063-regulator.h   |  16 --
 include/dt-bindings/regulator/maxim,max77802.h     |  18 --
 include/dt-bindings/reset/actions,s700-reset.h     |  34 ----
 include/dt-bindings/reset/actions,s900-reset.h     |  65 --------
 include/dt-bindings/reset/altr,rst-mgr-a10.h       | 110 -------------
 include/dt-bindings/reset/altr,rst-mgr-s10.h       |  96 -----------
 include/dt-bindings/reset/altr,rst-mgr.h           |  82 ---------
 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h  |  91 ----------
 .../dt-bindings/reset/raspberrypi,firmware-reset.h |  13 --
 include/dt-bindings/reset/sama7g5-reset.h          |  10 --
 include/dt-bindings/reset/snps,hsdk-reset.h        |  17 --
 include/dt-bindings/reset/starfive,jh7110-crg.h    | 183 ---------------------
 include/dt-bindings/sound/apq8016-lpass.h          |   9 -
 include/dt-bindings/sound/tlv320aic31xx.h          |  14 --
 40 files changed, 1472 deletions(-)

diff --git a/include/dt-bindings/arm/coresight-cti-dt.h b/include/dt-bindings/arm/coresight-cti-dt.h
deleted file mode 100644
index 61e7bdf8ea6e..000000000000
--- a/include/dt-bindings/arm/coresight-cti-dt.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for the defined trigger signal
- * types on CoreSight CTI.
- */
-
-#ifndef _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
-#define _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
-
-#define GEN_IO		0
-#define GEN_INTREQ	1
-#define GEN_INTACK	2
-#define GEN_HALTREQ	3
-#define GEN_RESTARTREQ	4
-#define PE_EDBGREQ	5
-#define PE_DBGRESTART	6
-#define PE_CTIIRQ	7
-#define PE_PMUIRQ	8
-#define PE_DBGTRIGGER	9
-#define ETM_EXTOUT	10
-#define ETM_EXTIN	11
-#define SNK_FULL	12
-#define SNK_ACQCOMP	13
-#define SNK_FLUSHCOMP	14
-#define SNK_FLUSHIN	15
-#define SNK_TRIGIN	16
-#define STM_ASYNCOUT	17
-#define STM_TOUT_SPTE	18
-#define STM_TOUT_SW	19
-#define STM_TOUT_HETE	20
-#define STM_HWEVENT	21
-#define ELA_TSTART	22
-#define ELA_TSTOP	23
-#define ELA_DBGREQ	24
-#define CTI_TRIG_MAX	25
-
-#endif /*_DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H */
diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
deleted file mode 100644
index 9bd764f0c9e6..000000000000
--- a/include/dt-bindings/arm/ux500_pm_domains.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2014 Linaro Ltd.
- *
- * Author: Ulf Hansson <ulf.hansson@linaro.org>
- */
-#ifndef _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
-#define _DT_BINDINGS_ARM_UX500_PM_DOMAINS_H
-
-#define DOMAIN_VAPE		0
-
-/* Number of PM domains. */
-#define NR_DOMAINS		(DOMAIN_VAPE + 1)
-
-#endif
diff --git a/include/dt-bindings/bus/moxtet.h b/include/dt-bindings/bus/moxtet.h
deleted file mode 100644
index 10528de7b3ef..000000000000
--- a/include/dt-bindings/bus/moxtet.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Constant for device tree bindings for Turris Mox module configuration bus
- *
- * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
- */
-
-#ifndef _DT_BINDINGS_BUS_MOXTET_H
-#define _DT_BINDINGS_BUS_MOXTET_H
-
-#define MOXTET_IRQ_PCI		0
-#define MOXTET_IRQ_USB3		4
-#define MOXTET_IRQ_PERIDOT(n)	(8 + (n))
-#define MOXTET_IRQ_TOPAZ	12
-
-#endif /* _DT_BINDINGS_BUS_MOXTET_H */
diff --git a/include/dt-bindings/display/tda998x.h b/include/dt-bindings/display/tda998x.h
deleted file mode 100644
index 746831ff396c..000000000000
--- a/include/dt-bindings/display/tda998x.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_TDA998X_H
-#define _DT_BINDINGS_TDA998X_H
-
-#define TDA998x_SPDIF	1
-#define TDA998x_I2S	2
-
-#endif /*_DT_BINDINGS_TDA998X_H */
diff --git a/include/dt-bindings/gpio/aspeed-gpio.h b/include/dt-bindings/gpio/aspeed-gpio.h
deleted file mode 100644
index a49f5d5b5af0..000000000000
--- a/include/dt-bindings/gpio/aspeed-gpio.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2022 IBM Corp.
- *
- * This header provides constants for binding aspeed,*-gpio.
- *
- * The first cell in Aspeed's GPIO specifier is the GPIO ID. The macros below
- * provide names for this.
- *
- * The second cell contains standard flag values specified in gpio.h.
- */
-
-#ifndef _DT_BINDINGS_GPIO_ASPEED_GPIO_H
-#define _DT_BINDINGS_GPIO_ASPEED_GPIO_H
-
-#include <dt-bindings/gpio/gpio.h>
-
-#define ASPEED_GPIO_PORT_A 0
-#define ASPEED_GPIO_PORT_B 1
-#define ASPEED_GPIO_PORT_C 2
-#define ASPEED_GPIO_PORT_D 3
-#define ASPEED_GPIO_PORT_E 4
-#define ASPEED_GPIO_PORT_F 5
-#define ASPEED_GPIO_PORT_G 6
-#define ASPEED_GPIO_PORT_H 7
-#define ASPEED_GPIO_PORT_I 8
-#define ASPEED_GPIO_PORT_J 9
-#define ASPEED_GPIO_PORT_K 10
-#define ASPEED_GPIO_PORT_L 11
-#define ASPEED_GPIO_PORT_M 12
-#define ASPEED_GPIO_PORT_N 13
-#define ASPEED_GPIO_PORT_O 14
-#define ASPEED_GPIO_PORT_P 15
-#define ASPEED_GPIO_PORT_Q 16
-#define ASPEED_GPIO_PORT_R 17
-#define ASPEED_GPIO_PORT_S 18
-#define ASPEED_GPIO_PORT_T 19
-#define ASPEED_GPIO_PORT_U 20
-#define ASPEED_GPIO_PORT_V 21
-#define ASPEED_GPIO_PORT_W 22
-#define ASPEED_GPIO_PORT_X 23
-#define ASPEED_GPIO_PORT_Y 24
-#define ASPEED_GPIO_PORT_Z 25
-#define ASPEED_GPIO_PORT_AA 26
-#define ASPEED_GPIO_PORT_AB 27
-#define ASPEED_GPIO_PORT_AC 28
-
-#define ASPEED_GPIO(port, offset) \
-	((ASPEED_GPIO_PORT_##port * 8) + (offset))
-
-#endif
diff --git a/include/dt-bindings/gpio/uniphier-gpio.h b/include/dt-bindings/gpio/uniphier-gpio.h
deleted file mode 100644
index 9f0ad174f61c..000000000000
--- a/include/dt-bindings/gpio/uniphier-gpio.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2017 Socionext Inc.
- *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
- */
-
-#ifndef _DT_BINDINGS_GPIO_UNIPHIER_H
-#define _DT_BINDINGS_GPIO_UNIPHIER_H
-
-#define UNIPHIER_GPIO_LINES_PER_BANK	8
-
-#define UNIPHIER_GPIO_IRQ_OFFSET	((UNIPHIER_GPIO_LINES_PER_BANK) * 15)
-
-#define UNIPHIER_GPIO_PORT(bank, line)	\
-			((UNIPHIER_GPIO_LINES_PER_BANK) * (bank) + (line))
-
-#define UNIPHIER_GPIO_IRQ(n)		((UNIPHIER_GPIO_IRQ_OFFSET) + (n))
-
-#endif /* _DT_BINDINGS_GPIO_UNIPHIER_H */
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
deleted file mode 100644
index 9ac56a7e6d3f..000000000000
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_APPLE_AIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-#define AIC_IRQ	0
-#define AIC_FIQ	1
-
-#define AIC_TMR_HV_PHYS		0
-#define AIC_TMR_HV_VIRT		1
-#define AIC_TMR_GUEST_PHYS	2
-#define AIC_TMR_GUEST_VIRT	3
-
-#endif
diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/dt-bindings/interrupt-controller/arm-gic.h
deleted file mode 100644
index 35b6f69b7db6..000000000000
--- a/include/dt-bindings/interrupt-controller/arm-gic.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR MIT */
-/*
- * This header provides constants for the ARM GIC.
- */
-
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ARM_GIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/* interrupt specifier cell 0 */
-
-#define GIC_SPI 0
-#define GIC_PPI 1
-
-/*
- * Interrupt specifier cell 2.
- * The flags in irq.h are valid, plus those below.
- */
-#define GIC_CPU_MASK_RAW(x) ((x) << 8)
-#define GIC_CPU_MASK_SIMPLE(num) GIC_CPU_MASK_RAW((1 << (num)) - 1)
-
-#endif
diff --git a/include/dt-bindings/interrupt-controller/irq-st.h b/include/dt-bindings/interrupt-controller/irq-st.h
deleted file mode 100644
index 6baa9ad2644c..000000000000
--- a/include/dt-bindings/interrupt-controller/irq-st.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *  include/linux/irqchip/irq-st.h
- *
- *  Copyright (C) 2014 STMicroelectronics All Rights Reserved
- *
- *  Author: Lee Jones <lee.jones@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ST_H
-
-#define ST_IRQ_SYSCFG_EXT_0		0
-#define ST_IRQ_SYSCFG_EXT_1		1
-#define ST_IRQ_SYSCFG_EXT_2		2
-#define ST_IRQ_SYSCFG_CTI_0		3
-#define ST_IRQ_SYSCFG_CTI_1		4
-#define ST_IRQ_SYSCFG_PMU_0		5
-#define ST_IRQ_SYSCFG_PMU_1		6
-#define ST_IRQ_SYSCFG_pl310_L2		7
-#define ST_IRQ_SYSCFG_DISABLED		0xFFFFFFFF
-
-#define ST_IRQ_SYSCFG_EXT_1_INV		0x1
-#define ST_IRQ_SYSCFG_EXT_2_INV		0x2
-#define ST_IRQ_SYSCFG_EXT_3_INV		0x4
-
-#endif
diff --git a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
deleted file mode 100644
index 34ce778885a1..000000000000
--- a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * This header provides constants for Renesas RZ/G2L family IRQC bindings.
- *
- * Copyright (C) 2022 Renesas Electronics Corp.
- *
- */
-
-#ifndef __DT_BINDINGS_IRQC_RZG2L_H
-#define __DT_BINDINGS_IRQC_RZG2L_H
-
-/* NMI maps to SPI0 */
-#define RZG2L_NMI	0
-
-/* IRQ0-7 map to SPI1-8 */
-#define RZG2L_IRQ0	1
-#define RZG2L_IRQ1	2
-#define RZG2L_IRQ2	3
-#define RZG2L_IRQ3	4
-#define RZG2L_IRQ4	5
-#define RZG2L_IRQ5	6
-#define RZG2L_IRQ6	7
-#define RZG2L_IRQ7	8
-
-#endif /* __DT_BINDINGS_IRQC_RZG2L_H */
diff --git a/include/dt-bindings/interrupt-controller/mips-gic.h b/include/dt-bindings/interrupt-controller/mips-gic.h
deleted file mode 100644
index cf35a577e371..000000000000
--- a/include/dt-bindings/interrupt-controller/mips-gic.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
-#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MIPS_GIC_H
-
-#include <dt-bindings/interrupt-controller/irq.h>
-
-#define GIC_SHARED 0
-#define GIC_LOCAL 1
-
-#endif
diff --git a/include/dt-bindings/leds/leds-netxbig.h b/include/dt-bindings/leds/leds-netxbig.h
deleted file mode 100644
index 92658b0310b2..000000000000
--- a/include/dt-bindings/leds/leds-netxbig.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This header provides constants for netxbig LED bindings.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef _DT_BINDINGS_LEDS_NETXBIG_H
-#define _DT_BINDINGS_LEDS_NETXBIG_H
-
-#define NETXBIG_LED_OFF		0
-#define NETXBIG_LED_ON		1
-#define NETXBIG_LED_SATA	2
-#define NETXBIG_LED_TIMER1	3
-#define NETXBIG_LED_TIMER2	4
-
-#endif /* _DT_BINDINGS_LEDS_NETXBIG_H */
diff --git a/include/dt-bindings/leds/leds-ns2.h b/include/dt-bindings/leds/leds-ns2.h
deleted file mode 100644
index fd615749e703..000000000000
--- a/include/dt-bindings/leds/leds-ns2.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _DT_BINDINGS_LEDS_NS2_H
-#define _DT_BINDINGS_LEDS_NS2_H
-
-#define NS_V2_LED_OFF	0
-#define NS_V2_LED_ON	1
-#define NS_V2_LED_SATA	2
-
-#endif
diff --git a/include/dt-bindings/leds/leds-pca9532.h b/include/dt-bindings/leds/leds-pca9532.h
deleted file mode 100644
index 4d917aab7e1e..000000000000
--- a/include/dt-bindings/leds/leds-pca9532.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * This header provides constants for pca9532 LED bindings.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef _DT_BINDINGS_LEDS_PCA9532_H
-#define _DT_BINDINGS_LEDS_PCA9532_H
-
-#define PCA9532_TYPE_NONE         0
-#define PCA9532_TYPE_LED          1
-#define PCA9532_TYPE_N2100_BEEP   2
-#define PCA9532_TYPE_GPIO         3
-#define PCA9532_LED_TIMER2        4
-
-#endif /* _DT_BINDINGS_LEDS_PCA9532_H */
diff --git a/include/dt-bindings/media/tda1997x.h b/include/dt-bindings/media/tda1997x.h
deleted file mode 100644
index bd9fbd718ec9..000000000000
--- a/include/dt-bindings/media/tda1997x.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2017 Gateworks Corporation
- */
-#ifndef _DT_BINDINGS_MEDIA_TDA1997X_H
-#define _DT_BINDINGS_MEDIA_TDA1997X_H
-
-/* TDA19973 36bit Video Port control registers */
-#define TDA1997X_VP36_35_32	0
-#define TDA1997X_VP36_31_28	1
-#define TDA1997X_VP36_27_24	2
-#define TDA1997X_VP36_23_20	3
-#define TDA1997X_VP36_19_16	4
-#define TDA1997X_VP36_15_12	5
-#define TDA1997X_VP36_11_08	6
-#define TDA1997X_VP36_07_04	7
-#define TDA1997X_VP36_03_00	8
-
-/* TDA19971 24bit Video Port control registers */
-#define TDA1997X_VP24_V23_20	0
-#define TDA1997X_VP24_V19_16	1
-#define TDA1997X_VP24_V15_12	3
-#define TDA1997X_VP24_V11_08	4
-#define TDA1997X_VP24_V07_04	6
-#define TDA1997X_VP24_V03_00	7
-
-/* Pin groups */
-#define TDA1997X_VP_OUT_EN        0x80	/* enable output group */
-#define TDA1997X_VP_HIZ           0x40	/* hi-Z output group when not used */
-#define TDA1997X_VP_SWP           0x10	/* pin-swap output group */
-#define TDA1997X_R_CR_CBCR_3_0    (0 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_R_CR_CBCR_7_4    (1 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_R_CR_CBCR_11_8   (2 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_B_CB_3_0         (3 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_B_CB_7_4         (4 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_B_CB_11_8        (5 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_G_Y_3_0          (6 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_G_Y_7_4          (7 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-#define TDA1997X_G_Y_11_8         (8 | TDA1997X_VP_OUT_EN | TDA1997X_VP_HIZ)
-/* pinswapped groups */
-#define TDA1997X_R_CR_CBCR_3_0_S  (TDA1997X_R_CR_CBCR_3_0 | TDA1997X_VP_SWAP)
-#define TDA1997X_R_CR_CBCR_7_4_S  (TDA1997X_R_CR_CBCR_7_4 | TDA1997X_VP_SWAP)
-#define TDA1997X_R_CR_CBCR_11_8_S (TDA1997X_R_CR_CBCR_11_8 | TDA1997X_VP_SWAP)
-#define TDA1997X_B_CB_3_0_S       (TDA1997X_B_CB_3_0 | TDA1997X_VP_SWAP)
-#define TDA1997X_B_CB_7_4_S       (TDA1997X_B_CB_7_4 | TDA1997X_VP_SWAP)
-#define TDA1997X_B_CB_11_8_S      (TDA1997X_B_CB_11_8 | TDA1997X_VP_SWAP)
-#define TDA1997X_G_Y_3_0_S        (TDA1997X_G_Y_3_0 | TDA1997X_VP_SWAP)
-#define TDA1997X_G_Y_7_4_S        (TDA1997X_G_Y_7_4 | TDA1997X_VP_SWAP)
-#define TDA1997X_G_Y_11_8_S       (TDA1997X_G_Y_11_8 | TDA1997X_VP_SWAP)
-
-/* Audio bus DAI format */
-#define TDA1997X_I2S16			1 /* I2S 16bit */
-#define TDA1997X_I2S32			2 /* I2S 32bit */
-#define TDA1997X_SPDIF			3 /* SPDIF */
-#define TDA1997X_OBA			4 /* One Bit Audio */
-#define TDA1997X_DST			5 /* Direct Stream Transfer */
-#define TDA1997X_I2S16_HBR		6 /* HBR straight in I2S 16bit mode */
-#define TDA1997X_I2S16_HBR_DEMUX	7 /* HBR demux in I2S 16bit mode */
-#define TDA1997X_I2S32_HBR_DEMUX	8 /* HBR demux in I2S 32bit mode */
-#define TDA1997X_SPDIF_HBR_DEMUX	9 /* HBR demux in SPDIF mode */
-
-/* Audio bus channel layout */
-#define TDA1997X_LAYOUT0	0	/* 2-channel */
-#define TDA1997X_LAYOUT1	1	/* 8-channel */
-
-/* Audio bus clock */
-#define TDA1997X_ACLK_16FS	0
-#define TDA1997X_ACLK_32FS	1
-#define TDA1997X_ACLK_64FS	2
-#define TDA1997X_ACLK_128FS	3
-#define TDA1997X_ACLK_256FS	4
-#define TDA1997X_ACLK_512FS	5
-
-#endif /* _DT_BINDINGS_MEDIA_TDA1997X_H */
diff --git a/include/dt-bindings/media/video-interfaces.h b/include/dt-bindings/media/video-interfaces.h
deleted file mode 100644
index 68ac4e05e37f..000000000000
--- a/include/dt-bindings/media/video-interfaces.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
-/*
- * Copyright (C) 2022 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
- */
-
-#ifndef __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__
-#define __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__
-
-#define MEDIA_BUS_TYPE_CSI2_CPHY		1
-#define MEDIA_BUS_TYPE_CSI1			2
-#define MEDIA_BUS_TYPE_CCP2			3
-#define MEDIA_BUS_TYPE_CSI2_DPHY		4
-#define MEDIA_BUS_TYPE_PARALLEL			5
-#define MEDIA_BUS_TYPE_BT656			6
-
-#endif /* __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__ */
diff --git a/include/dt-bindings/mfd/atmel-flexcom.h b/include/dt-bindings/mfd/atmel-flexcom.h
deleted file mode 100644
index 4e2fc3236394..000000000000
--- a/include/dt-bindings/mfd/atmel-flexcom.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This header provides macros for Atmel Flexcom DT bindings.
- *
- * Copyright (C) 2015 Cyrille Pitchen <cyrille.pitchen@atmel.com>
- */
-
-#ifndef __DT_BINDINGS_ATMEL_FLEXCOM_H__
-#define __DT_BINDINGS_ATMEL_FLEXCOM_H__
-
-#define ATMEL_FLEXCOM_MODE_USART	1
-#define ATMEL_FLEXCOM_MODE_SPI		2
-#define ATMEL_FLEXCOM_MODE_TWI		3
-
-#endif /* __DT_BINDINGS_ATMEL_FLEXCOM_H__ */
diff --git a/include/dt-bindings/mfd/dbx500-prcmu.h b/include/dt-bindings/mfd/dbx500-prcmu.h
deleted file mode 100644
index 7266ae67b03a..000000000000
--- a/include/dt-bindings/mfd/dbx500-prcmu.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for the PRCMU bindings.
- *
- */
-
-#ifndef _DT_BINDINGS_MFD_PRCMU_H
-#define _DT_BINDINGS_MFD_PRCMU_H
-
-/*
- * Clock identifiers.
- */
-#define ARMCLK			0
-#define PRCMU_ACLK		1
-#define PRCMU_SVAMMCSPCLK	2
-#define PRCMU_SDMMCHCLK		2  /* DBx540 only. */
-#define PRCMU_SIACLK		3
-#define PRCMU_SIAMMDSPCLK	3  /* DBx540 only. */
-#define PRCMU_SGACLK		4
-#define PRCMU_UARTCLK		5
-#define PRCMU_MSP02CLK		6
-#define PRCMU_MSP1CLK		7
-#define PRCMU_I2CCLK		8
-#define PRCMU_SDMMCCLK		9
-#define PRCMU_SLIMCLK		10
-#define PRCMU_CAMCLK		10 /* DBx540 only. */
-#define PRCMU_PER1CLK		11
-#define PRCMU_PER2CLK		12
-#define PRCMU_PER3CLK		13
-#define PRCMU_PER5CLK		14
-#define PRCMU_PER6CLK		15
-#define PRCMU_PER7CLK		16
-#define PRCMU_LCDCLK		17
-#define PRCMU_BMLCLK		18
-#define PRCMU_HSITXCLK		19
-#define PRCMU_HSIRXCLK		20
-#define PRCMU_HDMICLK		21
-#define PRCMU_APEATCLK		22
-#define PRCMU_APETRACECLK	23
-#define PRCMU_MCDECLK		24
-#define PRCMU_IPI2CCLK		25
-#define PRCMU_DSIALTCLK		26
-#define PRCMU_DMACLK		27
-#define PRCMU_B2R2CLK		28
-#define PRCMU_TVCLK		29
-#define SPARE_UNIPROCLK		30
-#define PRCMU_SSPCLK		31
-#define PRCMU_RNGCLK		32
-#define PRCMU_UICCCLK		33
-#define PRCMU_G1CLK             34 /* DBx540 only. */
-#define PRCMU_HVACLK            35 /* DBx540 only. */
-#define PRCMU_SPARE1CLK		36
-#define PRCMU_SPARE2CLK		37
-
-#define PRCMU_NUM_REG_CLOCKS	38
-
-#define PRCMU_RTCCLK		PRCMU_NUM_REG_CLOCKS
-#define PRCMU_SYSCLK		39
-#define PRCMU_CDCLK		40
-#define PRCMU_TIMCLK		41
-#define PRCMU_PLLSOC0		42
-#define PRCMU_PLLSOC1		43
-#define PRCMU_ARMSS		44
-#define PRCMU_PLLDDR		45
-
-/* DSI Clocks */
-#define PRCMU_PLLDSI		46
-#define PRCMU_DSI0CLK		47
-#define PRCMU_DSI1CLK		48
-#define PRCMU_DSI0ESCCLK	49
-#define PRCMU_DSI1ESCCLK	50
-#define PRCMU_DSI2ESCCLK	51
-
-/* LCD DSI PLL - Ux540 only */
-#define PRCMU_PLLDSI_LCD        52
-#define PRCMU_DSI0CLK_LCD       53
-#define PRCMU_DSI1CLK_LCD       54
-#define PRCMU_DSI0ESCCLK_LCD    55
-#define PRCMU_DSI1ESCCLK_LCD    56
-#define PRCMU_DSI2ESCCLK_LCD    57
-
-#define PRCMU_NUM_CLKS		58
-
-#endif
diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
deleted file mode 100644
index c340437414fb..000000000000
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Device Tree constants for Microsemi VSC8531 PHY
- *
- * Author: Nagaraju Lakkaraju
- *
- * Copyright (c) 2017 Microsemi Corporation
- */
-
-#ifndef _DT_BINDINGS_MSCC_VSC8531_H
-#define _DT_BINDINGS_MSCC_VSC8531_H
-
-/* PHY LED Modes */
-#define VSC8531_LINK_ACTIVITY			0
-#define VSC8531_LINK_1000_ACTIVITY		1
-#define VSC8531_LINK_100_ACTIVITY		2
-#define VSC8531_LINK_10_ACTIVITY		3
-#define VSC8531_LINK_100_1000_ACTIVITY		4
-#define VSC8531_LINK_10_1000_ACTIVITY		5
-#define VSC8531_LINK_10_100_ACTIVITY		6
-#define VSC8584_LINK_100FX_1000X_ACTIVITY	7
-#define VSC8531_DUPLEX_COLLISION		8
-#define VSC8531_COLLISION			9
-#define VSC8531_ACTIVITY			10
-#define VSC8584_100FX_1000X_ACTIVITY		11
-#define VSC8531_AUTONEG_FAULT			12
-#define VSC8531_SERIAL_MODE			13
-#define VSC8531_FORCE_LED_OFF			14
-#define VSC8531_FORCE_LED_ON			15
-
-#endif
diff --git a/include/dt-bindings/net/qca-ar803x.h b/include/dt-bindings/net/qca-ar803x.h
deleted file mode 100644
index 9c046c7242ed..000000000000
--- a/include/dt-bindings/net/qca-ar803x.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Device Tree constants for the Qualcomm Atheros AR803x PHYs
- */
-
-#ifndef _DT_BINDINGS_QCA_AR803X_H
-#define _DT_BINDINGS_QCA_AR803X_H
-
-#define AR803X_STRENGTH_FULL		0
-#define AR803X_STRENGTH_HALF		1
-#define AR803X_STRENGTH_QUARTER		2
-
-#endif
diff --git a/include/dt-bindings/phy/phy-am654-serdes.h b/include/dt-bindings/phy/phy-am654-serdes.h
deleted file mode 100644
index e8d901729ed9..000000000000
--- a/include/dt-bindings/phy/phy-am654-serdes.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for AM654 SERDES.
- */
-
-#ifndef _DT_BINDINGS_AM654_SERDES
-#define _DT_BINDINGS_AM654_SERDES
-
-#define AM654_SERDES_CMU_REFCLK	0
-#define AM654_SERDES_LO_REFCLK	1
-#define AM654_SERDES_RO_REFCLK	2
-
-#endif /* _DT_BINDINGS_AM654_SERDES */
diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
deleted file mode 100644
index 0122c6067b17..000000000000
--- a/include/dt-bindings/phy/phy-cadence.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for Cadence SERDES.
- */
-
-#ifndef _DT_BINDINGS_CADENCE_SERDES_H
-#define _DT_BINDINGS_CADENCE_SERDES_H
-
-/* Torrent */
-#define TORRENT_SERDES_NO_SSC		0
-#define TORRENT_SERDES_EXTERNAL_SSC	1
-#define TORRENT_SERDES_INTERNAL_SSC	2
-
-#define CDNS_TORRENT_REFCLK_DRIVER      0
-
-/* Sierra */
-#define CDNS_SIERRA_PLL_CMNLC		0
-#define CDNS_SIERRA_PLL_CMNLC1		1
-
-#define SIERRA_SERDES_NO_SSC		0
-#define SIERRA_SERDES_EXTERNAL_SSC	1
-#define SIERRA_SERDES_INTERNAL_SSC	2
-
-#endif /* _DT_BINDINGS_CADENCE_SERDES_H */
diff --git a/include/dt-bindings/pinctrl/apple.h b/include/dt-bindings/pinctrl/apple.h
deleted file mode 100644
index ea0a6f466592..000000000000
--- a/include/dt-bindings/pinctrl/apple.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
-/*
- * This header provides constants for Apple pinctrl bindings.
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_APPLE_H
-#define _DT_BINDINGS_PINCTRL_APPLE_H
-
-#define APPLE_PINMUX(pin, func) ((pin) | ((func) << 16))
-#define APPLE_PIN(pinmux) ((pinmux) & 0xffff)
-#define APPLE_FUNC(pinmux) ((pinmux) >> 16)
-
-#endif /* _DT_BINDINGS_PINCTRL_APPLE_H */
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
deleted file mode 100644
index 765c385f7b2c..000000000000
--- a/include/dt-bindings/pinctrl/dra.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * This header provides constants for DRA pinctrl bindings.
- *
- * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- * Author: Rajendra Nayak <rnayak@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_DRA_H
-#define _DT_BINDINGS_PINCTRL_DRA_H
-
-/* DRA7 mux mode options for each pin. See TRM for options */
-#define MUX_MODE0	0x0
-#define MUX_MODE1	0x1
-#define MUX_MODE2	0x2
-#define MUX_MODE3	0x3
-#define MUX_MODE4	0x4
-#define MUX_MODE5	0x5
-#define MUX_MODE6	0x6
-#define MUX_MODE7	0x7
-#define MUX_MODE8	0x8
-#define MUX_MODE9	0x9
-#define MUX_MODE10	0xa
-#define MUX_MODE11	0xb
-#define MUX_MODE12	0xc
-#define MUX_MODE13	0xd
-#define MUX_MODE14	0xe
-#define MUX_MODE15	0xf
-
-/* Certain pins need virtual mode, but note: they may glitch */
-#define MUX_VIRTUAL_MODE0	(MODE_SELECT | (0x0 << 4))
-#define MUX_VIRTUAL_MODE1	(MODE_SELECT | (0x1 << 4))
-#define MUX_VIRTUAL_MODE2	(MODE_SELECT | (0x2 << 4))
-#define MUX_VIRTUAL_MODE3	(MODE_SELECT | (0x3 << 4))
-#define MUX_VIRTUAL_MODE4	(MODE_SELECT | (0x4 << 4))
-#define MUX_VIRTUAL_MODE5	(MODE_SELECT | (0x5 << 4))
-#define MUX_VIRTUAL_MODE6	(MODE_SELECT | (0x6 << 4))
-#define MUX_VIRTUAL_MODE7	(MODE_SELECT | (0x7 << 4))
-#define MUX_VIRTUAL_MODE8	(MODE_SELECT | (0x8 << 4))
-#define MUX_VIRTUAL_MODE9	(MODE_SELECT | (0x9 << 4))
-#define MUX_VIRTUAL_MODE10	(MODE_SELECT | (0xa << 4))
-#define MUX_VIRTUAL_MODE11	(MODE_SELECT | (0xb << 4))
-#define MUX_VIRTUAL_MODE12	(MODE_SELECT | (0xc << 4))
-#define MUX_VIRTUAL_MODE13	(MODE_SELECT | (0xd << 4))
-#define MUX_VIRTUAL_MODE14	(MODE_SELECT | (0xe << 4))
-#define MUX_VIRTUAL_MODE15	(MODE_SELECT | (0xf << 4))
-
-#define MODE_SELECT		(1 << 8)
-
-#define PULL_ENA		(0 << 16)
-#define PULL_DIS		(1 << 16)
-#define PULL_UP			(1 << 17)
-#define INPUT_EN		(1 << 18)
-#define SLEWCONTROL		(1 << 19)
-#define WAKEUP_EN		(1 << 24)
-#define WAKEUP_EVENT		(1 << 25)
-
-/* Active pin states */
-#define PIN_OUTPUT		(0 | PULL_DIS)
-#define PIN_OUTPUT_PULLUP	(PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(0)
-#define PIN_INPUT		(INPUT_EN | PULL_DIS)
-#define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
-#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
-
-/*
- * Macro to allow using the absolute physical address instead of the
- * padconf registers instead of the offset from padconf base.
- */
-#define DRA7XX_CORE_IOPAD(pa, val)	(((pa) & 0xffff) - 0x3400) (val)
-
-/* DRA7 IODELAY configuration parameters */
-#define A_DELAY_PS(val)			((val) & 0xffff)
-#define G_DELAY_PS(val)			((val) & 0xffff)
-#endif
diff --git a/include/dt-bindings/power/owl-s700-powergate.h b/include/dt-bindings/power/owl-s700-powergate.h
deleted file mode 100644
index 4cf1aefbf09c..000000000000
--- a/include/dt-bindings/power/owl-s700-powergate.h
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Actions Semi S700 SPS
- *
- * Copyright (c) 2017 Andreas Färber
- */
-#ifndef DT_BINDINGS_POWER_OWL_S700_POWERGATE_H
-#define DT_BINDINGS_POWER_OWL_S700_POWERGATE_H
-
-#define S700_PD_VDE	0
-#define S700_PD_VCE_SI	1
-#define S700_PD_USB2_1	2
-#define S700_PD_HDE	3
-#define S700_PD_DMA	4
-#define S700_PD_DS	5
-#define S700_PD_USB3	6
-#define S700_PD_USB2_0	7
-
-#endif
diff --git a/include/dt-bindings/power/raspberrypi-power.h b/include/dt-bindings/power/raspberrypi-power.h
deleted file mode 100644
index b3ff8e09a78f..000000000000
--- a/include/dt-bindings/power/raspberrypi-power.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- *  Copyright © 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
-#define _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H
-
-/* These power domain indices are the firmware interface's indices
- * minus one.
- */
-#define RPI_POWER_DOMAIN_I2C0		0
-#define RPI_POWER_DOMAIN_I2C1		1
-#define RPI_POWER_DOMAIN_I2C2		2
-#define RPI_POWER_DOMAIN_VIDEO_SCALER	3
-#define RPI_POWER_DOMAIN_VPU1		4
-#define RPI_POWER_DOMAIN_HDMI		5
-#define RPI_POWER_DOMAIN_USB		6
-#define RPI_POWER_DOMAIN_VEC		7
-#define RPI_POWER_DOMAIN_JPEG		8
-#define RPI_POWER_DOMAIN_H264		9
-#define RPI_POWER_DOMAIN_V3D		10
-#define RPI_POWER_DOMAIN_ISP		11
-#define RPI_POWER_DOMAIN_UNICAM0	12
-#define RPI_POWER_DOMAIN_UNICAM1	13
-#define RPI_POWER_DOMAIN_CCP2RX		14
-#define RPI_POWER_DOMAIN_CSI2		15
-#define RPI_POWER_DOMAIN_CPI		16
-#define RPI_POWER_DOMAIN_DSI0		17
-#define RPI_POWER_DOMAIN_DSI1		18
-#define RPI_POWER_DOMAIN_TRANSPOSER	19
-#define RPI_POWER_DOMAIN_CCP2TX		20
-#define RPI_POWER_DOMAIN_CDP		21
-#define RPI_POWER_DOMAIN_ARM		22
-
-#define RPI_POWER_DOMAIN_COUNT		23
-
-#endif /* _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H */
diff --git a/include/dt-bindings/regulator/dlg,da9063-regulator.h b/include/dt-bindings/regulator/dlg,da9063-regulator.h
deleted file mode 100644
index 1de710dd0899..000000000000
--- a/include/dt-bindings/regulator/dlg,da9063-regulator.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _DT_BINDINGS_REGULATOR_DLG_DA9063_H
-#define _DT_BINDINGS_REGULATOR_DLG_DA9063_H
-
-/*
- * These buck mode constants may be used to specify values in device tree
- * properties (e.g. regulator-initial-mode).
- * A description of the following modes is in the manufacturers datasheet.
- */
-
-#define DA9063_BUCK_MODE_SLEEP		1
-#define DA9063_BUCK_MODE_SYNC		2
-#define DA9063_BUCK_MODE_AUTO		3
-
-#endif
diff --git a/include/dt-bindings/regulator/maxim,max77802.h b/include/dt-bindings/regulator/maxim,max77802.h
deleted file mode 100644
index cf28631d7109..000000000000
--- a/include/dt-bindings/regulator/maxim,max77802.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * Copyright (C) 2014 Google, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Device Tree binding constants for the Maxim 77802 PMIC regulators
- */
-
-#ifndef _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H
-#define _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H
-
-/* Regulator operating modes */
-#define MAX77802_OPMODE_LP	1
-#define MAX77802_OPMODE_NORMAL	3
-
-#endif /* _DT_BINDINGS_REGULATOR_MAXIM_MAX77802_H */
diff --git a/include/dt-bindings/reset/actions,s700-reset.h b/include/dt-bindings/reset/actions,s700-reset.h
deleted file mode 100644
index 5e3b16b8ef53..000000000000
--- a/include/dt-bindings/reset/actions,s700-reset.h
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
-//
-// Device Tree binding constants for Actions Semi S700 Reset Management Unit
-//
-// Copyright (c) 2018 Linaro Ltd.
-
-#ifndef __DT_BINDINGS_ACTIONS_S700_RESET_H
-#define __DT_BINDINGS_ACTIONS_S700_RESET_H
-
-#define RESET_AUDIO				0
-#define RESET_CSI				1
-#define RESET_DE				2
-#define RESET_DSI				3
-#define RESET_GPIO				4
-#define RESET_I2C0				5
-#define RESET_I2C1				6
-#define RESET_I2C2				7
-#define RESET_I2C3				8
-#define RESET_KEY				9
-#define RESET_LCD0				10
-#define RESET_SI				11
-#define RESET_SPI0				12
-#define RESET_SPI1				13
-#define RESET_SPI2				14
-#define RESET_SPI3				15
-#define RESET_UART0				16
-#define RESET_UART1				17
-#define RESET_UART2				18
-#define RESET_UART3				19
-#define RESET_UART4				20
-#define RESET_UART5				21
-#define RESET_UART6				22
-
-#endif /* __DT_BINDINGS_ACTIONS_S700_RESET_H */
diff --git a/include/dt-bindings/reset/actions,s900-reset.h b/include/dt-bindings/reset/actions,s900-reset.h
deleted file mode 100644
index 42c19d02e43b..000000000000
--- a/include/dt-bindings/reset/actions,s900-reset.h
+++ /dev/null
@@ -1,65 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
-//
-// Device Tree binding constants for Actions Semi S900 Reset Management Unit
-//
-// Copyright (c) 2018 Linaro Ltd.
-
-#ifndef __DT_BINDINGS_ACTIONS_S900_RESET_H
-#define __DT_BINDINGS_ACTIONS_S900_RESET_H
-
-#define RESET_CHIPID				0
-#define RESET_CPU_SCNT				1
-#define RESET_SRAMI				2
-#define RESET_DDR_CTL_PHY			3
-#define RESET_DMAC				4
-#define RESET_GPIO				5
-#define RESET_BISP_AXI				6
-#define RESET_CSI0				7
-#define RESET_CSI1				8
-#define RESET_DE				9
-#define RESET_DSI				10
-#define RESET_GPU3D_PA				11
-#define RESET_GPU3D_PB				12
-#define RESET_HDE				13
-#define RESET_I2C0				14
-#define RESET_I2C1				15
-#define RESET_I2C2				16
-#define RESET_I2C3				17
-#define RESET_I2C4				18
-#define RESET_I2C5				19
-#define RESET_IMX				20
-#define RESET_NANDC0				21
-#define RESET_NANDC1				22
-#define RESET_SD0				23
-#define RESET_SD1				24
-#define RESET_SD2				25
-#define RESET_SD3				26
-#define RESET_SPI0				27
-#define RESET_SPI1				28
-#define RESET_SPI2				29
-#define RESET_SPI3				30
-#define RESET_UART0				31
-#define RESET_UART1				32
-#define RESET_UART2				33
-#define RESET_UART3				34
-#define RESET_UART4				35
-#define RESET_UART5				36
-#define RESET_UART6				37
-#define RESET_HDMI				38
-#define RESET_LVDS				39
-#define RESET_EDP				40
-#define RESET_USB2HUB				41
-#define RESET_USB2HSIC				42
-#define RESET_USB3				43
-#define RESET_PCM1				44
-#define RESET_AUDIO				45
-#define RESET_PCM0				46
-#define RESET_SE				47
-#define RESET_GIC				48
-#define RESET_DDR_CTL_PHY_AXI			49
-#define RESET_CMU_DDR				50
-#define RESET_DMM				51
-#define RESET_HDCP2TX				52
-#define RESET_ETHERNET				53
-
-#endif /* __DT_BINDINGS_ACTIONS_S900_RESET_H */
diff --git a/include/dt-bindings/reset/altr,rst-mgr-a10.h b/include/dt-bindings/reset/altr,rst-mgr-a10.h
deleted file mode 100644
index acb0bbf4f9f5..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr-a10.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Copyright (c) 2014, Steffen Trumtrar <s.trumtrar@pengutronix.de>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_A10_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_A10_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define WDS_RESET		2
-#define SCUPER_RESET		3
-
-/* PER0MODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define EMAC2_RESET		34
-#define USB0_RESET		35
-#define USB1_RESET		36
-#define NAND_RESET		37
-#define QSPI_RESET		38
-#define SDMMC_RESET		39
-#define EMAC0_OCP_RESET		40
-#define EMAC1_OCP_RESET		41
-#define EMAC2_OCP_RESET		42
-#define USB0_OCP_RESET		43
-#define USB1_OCP_RESET		44
-#define NAND_OCP_RESET		45
-#define QSPI_OCP_RESET		46
-#define SDMMC_OCP_RESET		47
-#define DMA_RESET		48
-#define SPIM0_RESET		49
-#define SPIM1_RESET		50
-#define SPIS0_RESET		51
-#define SPIS1_RESET		52
-#define DMA_OCP_RESET		53
-#define EMAC_PTP_RESET		54
-/* 55 is empty*/
-#define DMAIF0_RESET		56
-#define DMAIF1_RESET		57
-#define DMAIF2_RESET		58
-#define DMAIF3_RESET		59
-#define DMAIF4_RESET		60
-#define DMAIF5_RESET		61
-#define DMAIF6_RESET		62
-#define DMAIF7_RESET		63
-
-/* PER1MODRST */
-#define L4WD0_RESET		64
-#define L4WD1_RESET		65
-#define L4SYSTIMER0_RESET	66
-#define L4SYSTIMER1_RESET	67
-#define SPTIMER0_RESET		68
-#define SPTIMER1_RESET		69
-/* 70-71 is reserved */
-#define I2C0_RESET		72
-#define I2C1_RESET		73
-#define I2C2_RESET		74
-#define I2C3_RESET		75
-#define I2C4_RESET		76
-/* 77-79 is reserved */
-#define UART0_RESET		80
-#define UART1_RESET		81
-/* 82-87 is reserved */
-#define GPIO0_RESET		88
-#define GPIO1_RESET		89
-#define GPIO2_RESET		90
-
-/* BRGMODRST */
-#define HPS2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2HPS_RESET		98
-#define F2SSDRAM0_RESET		99
-#define F2SSDRAM1_RESET		100
-#define F2SSDRAM2_RESET		101
-#define DDRSCH_RESET		102
-
-/* SYSMODRST*/
-#define ROM_RESET		128
-#define OCRAM_RESET		129
-/* 130 is reserved */
-#define FPGAMGR_RESET		131
-#define S2F_RESET		132
-#define SYSDBG_RESET		133
-#define OCRAM_OCP_RESET		134
-
-/* COLDMODRST */
-#define CLKMGRCOLD_RESET	160
-/* 161-162 is reserved */
-#define S2FCOLD_RESET		163
-#define TIMESTAMPCOLD_RESET	164
-#define TAPCOLD_RESET		165
-#define HMCCOLD_RESET		166
-#define IOMGRCOLD_RESET		167
-
-/* NRSTMODRST */
-#define NRSTPINOE_RESET		192
-
-/* DBGMODRST */
-#define DBG_RESET		224
-#endif
diff --git a/include/dt-bindings/reset/altr,rst-mgr-s10.h b/include/dt-bindings/reset/altr,rst-mgr-s10.h
deleted file mode 100644
index 1fdcf8ae1531..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr-s10.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2016-2018 Intel Corporation. All rights reserved
- * Copyright (C) 2016 Altera Corporation. All rights reserved
- * derived from Steffen Trumtrar's "altr,rst-mgr-a10.h"
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_S10_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_S10_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define CPU2_RESET		2
-#define CPU3_RESET		3
-
-/* PER0MODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define EMAC2_RESET		34
-#define USB0_RESET		35
-#define USB1_RESET		36
-#define NAND_RESET		37
-/* 38 is empty */
-#define SDMMC_RESET		39
-#define EMAC0_OCP_RESET		40
-#define EMAC1_OCP_RESET		41
-#define EMAC2_OCP_RESET		42
-#define USB0_OCP_RESET		43
-#define USB1_OCP_RESET		44
-#define NAND_OCP_RESET		45
-/* 46 is empty */
-#define SDMMC_OCP_RESET		47
-#define DMA_RESET		48
-#define SPIM0_RESET		49
-#define SPIM1_RESET		50
-#define SPIS0_RESET		51
-#define SPIS1_RESET		52
-#define DMA_OCP_RESET		53
-#define EMAC_PTP_RESET		54
-/* 55 is empty*/
-#define DMAIF0_RESET		56
-#define DMAIF1_RESET		57
-#define DMAIF2_RESET		58
-#define DMAIF3_RESET		59
-#define DMAIF4_RESET		60
-#define DMAIF5_RESET		61
-#define DMAIF6_RESET		62
-#define DMAIF7_RESET		63
-
-/* PER1MODRST */
-#define WATCHDOG0_RESET		64
-#define WATCHDOG1_RESET		65
-#define WATCHDOG2_RESET		66
-#define WATCHDOG3_RESET		67
-#define L4SYSTIMER0_RESET	68
-#define L4SYSTIMER1_RESET	69
-#define SPTIMER0_RESET		70
-#define SPTIMER1_RESET		71
-#define I2C0_RESET		72
-#define I2C1_RESET		73
-#define I2C2_RESET		74
-#define I2C3_RESET		75
-#define I2C4_RESET		76
-/* 77-79 is empty */
-#define UART0_RESET		80
-#define UART1_RESET		81
-/* 82-87 is empty */
-#define GPIO0_RESET		88
-#define GPIO1_RESET		89
-
-/* BRGMODRST */
-#define SOC2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2SOC_RESET		98
-#define F2SSDRAM0_RESET		99
-#define F2SSDRAM1_RESET		100
-#define F2SSDRAM2_RESET		101
-#define DDRSCH_RESET		102
-
-/* COLDMODRST */
-#define CPUPO0_RESET		160
-#define CPUPO1_RESET		161
-#define CPUPO2_RESET		162
-#define CPUPO3_RESET		163
-/* 164-167 is empty */
-#define L2_RESET		168
-
-/* DBGMODRST */
-#define DBG_RESET		224
-#define CSDAP_RESET		225
-
-/* TAPMODRST */
-#define TAP_RESET		256
-
-#endif
diff --git a/include/dt-bindings/reset/altr,rst-mgr.h b/include/dt-bindings/reset/altr,rst-mgr.h
deleted file mode 100644
index 5b7ad7396524..000000000000
--- a/include/dt-bindings/reset/altr,rst-mgr.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2014, Steffen Trumtrar <s.trumtrar@pengutronix.de>
- */
-
-#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_H
-#define _DT_BINDINGS_RESET_ALTR_RST_MGR_H
-
-/* MPUMODRST */
-#define CPU0_RESET		0
-#define CPU1_RESET		1
-#define WDS_RESET		2
-#define SCUPER_RESET		3
-#define L2_RESET		4
-
-/* PERMODRST */
-#define EMAC0_RESET		32
-#define EMAC1_RESET		33
-#define USB0_RESET		34
-#define USB1_RESET		35
-#define NAND_RESET		36
-#define QSPI_RESET		37
-#define L4WD0_RESET		38
-#define L4WD1_RESET		39
-#define OSC1TIMER0_RESET	40
-#define OSC1TIMER1_RESET	41
-#define SPTIMER0_RESET		42
-#define SPTIMER1_RESET		43
-#define I2C0_RESET		44
-#define I2C1_RESET		45
-#define I2C2_RESET		46
-#define I2C3_RESET		47
-#define UART0_RESET		48
-#define UART1_RESET		49
-#define SPIM0_RESET		50
-#define SPIM1_RESET		51
-#define SPIS0_RESET		52
-#define SPIS1_RESET		53
-#define SDMMC_RESET		54
-#define CAN0_RESET		55
-#define CAN1_RESET		56
-#define GPIO0_RESET		57
-#define GPIO1_RESET		58
-#define GPIO2_RESET		59
-#define DMA_RESET		60
-#define SDR_RESET		61
-
-/* PER2MODRST */
-#define DMAIF0_RESET		64
-#define DMAIF1_RESET		65
-#define DMAIF2_RESET		66
-#define DMAIF3_RESET		67
-#define DMAIF4_RESET		68
-#define DMAIF5_RESET		69
-#define DMAIF6_RESET		70
-#define DMAIF7_RESET		71
-
-/* BRGMODRST */
-#define HPS2FPGA_RESET		96
-#define LWHPS2FPGA_RESET	97
-#define FPGA2HPS_RESET		98
-
-/* MISCMODRST*/
-#define ROM_RESET		128
-#define OCRAM_RESET		129
-#define SYSMGR_RESET		130
-#define SYSMGRCOLD_RESET	131
-#define FPGAMGR_RESET		132
-#define ACPIDMAP_RESET		133
-#define S2F_RESET		134
-#define S2FCOLD_RESET		135
-#define NRSTPIN_RESET		136
-#define TIMESTAMPCOLD_RESET	137
-#define CLKMGRCOLD_RESET	138
-#define SCANMGR_RESET		139
-#define FRZCTRLCOLD_RESET	140
-#define SYSDBG_RESET		141
-#define DBG_RESET		142
-#define TAPCOLD_RESET		143
-#define SDRCOLD_RESET		144
-
-#endif
diff --git a/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
deleted file mode 100644
index 757f5e34c814..000000000000
--- a/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (c) 2020 Nuvoton Technology corporation.
-
-#ifndef _DT_BINDINGS_NPCM7XX_RESET_H
-#define _DT_BINDINGS_NPCM7XX_RESET_H
-
-#define NPCM7XX_RESET_IPSRST1		0x20
-#define NPCM7XX_RESET_IPSRST2		0x24
-#define NPCM7XX_RESET_IPSRST3		0x34
-
-/* Reset lines on IP1 reset module (NPCM7XX_RESET_IPSRST1) */
-#define NPCM7XX_RESET_FIU3		1
-#define NPCM7XX_RESET_UDC1		5
-#define NPCM7XX_RESET_EMC1		6
-#define NPCM7XX_RESET_UART_2_3		7
-#define NPCM7XX_RESET_UDC2		8
-#define NPCM7XX_RESET_PECI		9
-#define NPCM7XX_RESET_AES		10
-#define NPCM7XX_RESET_UART_0_1		11
-#define NPCM7XX_RESET_MC		12
-#define NPCM7XX_RESET_SMB2		13
-#define NPCM7XX_RESET_SMB3		14
-#define NPCM7XX_RESET_SMB4		15
-#define NPCM7XX_RESET_SMB5		16
-#define NPCM7XX_RESET_PWM_M0		18
-#define NPCM7XX_RESET_TIMER_0_4		19
-#define NPCM7XX_RESET_TIMER_5_9		20
-#define NPCM7XX_RESET_EMC2		21
-#define NPCM7XX_RESET_UDC4		22
-#define NPCM7XX_RESET_UDC5		23
-#define NPCM7XX_RESET_UDC6		24
-#define NPCM7XX_RESET_UDC3		25
-#define NPCM7XX_RESET_ADC		27
-#define NPCM7XX_RESET_SMB6		28
-#define NPCM7XX_RESET_SMB7		29
-#define NPCM7XX_RESET_SMB0		30
-#define NPCM7XX_RESET_SMB1		31
-
-/* Reset lines on IP2 reset module (NPCM7XX_RESET_IPSRST2) */
-#define NPCM7XX_RESET_MFT0		0
-#define NPCM7XX_RESET_MFT1		1
-#define NPCM7XX_RESET_MFT2		2
-#define NPCM7XX_RESET_MFT3		3
-#define NPCM7XX_RESET_MFT4		4
-#define NPCM7XX_RESET_MFT5		5
-#define NPCM7XX_RESET_MFT6		6
-#define NPCM7XX_RESET_MFT7		7
-#define NPCM7XX_RESET_MMC		8
-#define NPCM7XX_RESET_SDHC		9
-#define NPCM7XX_RESET_GFX_SYS		10
-#define NPCM7XX_RESET_AHB_PCIBRG	11
-#define NPCM7XX_RESET_VDMA		12
-#define NPCM7XX_RESET_ECE		13
-#define NPCM7XX_RESET_VCD		14
-#define NPCM7XX_RESET_OTP		16
-#define NPCM7XX_RESET_SIOX1		18
-#define NPCM7XX_RESET_SIOX2		19
-#define NPCM7XX_RESET_3DES		21
-#define NPCM7XX_RESET_PSPI1		22
-#define NPCM7XX_RESET_PSPI2		23
-#define NPCM7XX_RESET_GMAC2		25
-#define NPCM7XX_RESET_USB_HOST		26
-#define NPCM7XX_RESET_GMAC1		28
-#define NPCM7XX_RESET_CP		31
-
-/* Reset lines on IP3 reset module (NPCM7XX_RESET_IPSRST3) */
-#define NPCM7XX_RESET_PWM_M1		0
-#define NPCM7XX_RESET_SMB12		1
-#define NPCM7XX_RESET_SPIX		2
-#define NPCM7XX_RESET_SMB13		3
-#define NPCM7XX_RESET_UDC0		4
-#define NPCM7XX_RESET_UDC7		5
-#define NPCM7XX_RESET_UDC8		6
-#define NPCM7XX_RESET_UDC9		7
-#define NPCM7XX_RESET_PCI_MAILBOX	9
-#define NPCM7XX_RESET_SMB14		12
-#define NPCM7XX_RESET_SHA		13
-#define NPCM7XX_RESET_SEC_ECC		14
-#define NPCM7XX_RESET_PCIE_RC		15
-#define NPCM7XX_RESET_TIMER_10_14	16
-#define NPCM7XX_RESET_RNG		17
-#define NPCM7XX_RESET_SMB15		18
-#define NPCM7XX_RESET_SMB8		19
-#define NPCM7XX_RESET_SMB9		20
-#define NPCM7XX_RESET_SMB10		21
-#define NPCM7XX_RESET_SMB11		22
-#define NPCM7XX_RESET_ESPI		23
-#define NPCM7XX_RESET_USB_PHY_1		24
-#define NPCM7XX_RESET_USB_PHY_2		25
-
-#endif
diff --git a/include/dt-bindings/reset/raspberrypi,firmware-reset.h b/include/dt-bindings/reset/raspberrypi,firmware-reset.h
deleted file mode 100644
index 1a4f4c792723..000000000000
--- a/include/dt-bindings/reset/raspberrypi,firmware-reset.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2020 Nicolas Saenz Julienne
- * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.com>
- */
-
-#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
-#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_RESET_H
-
-#define RASPBERRYPI_FIRMWARE_RESET_ID_USB	0
-#define RASPBERRYPI_FIRMWARE_RESET_NUM_IDS	1
-
-#endif
diff --git a/include/dt-bindings/reset/sama7g5-reset.h b/include/dt-bindings/reset/sama7g5-reset.h
deleted file mode 100644
index 2116f41d04e0..000000000000
--- a/include/dt-bindings/reset/sama7g5-reset.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-
-#ifndef __DT_BINDINGS_RESET_SAMA7G5_H
-#define __DT_BINDINGS_RESET_SAMA7G5_H
-
-#define SAMA7G5_RESET_USB_PHY1		4
-#define SAMA7G5_RESET_USB_PHY2		5
-#define SAMA7G5_RESET_USB_PHY3		6
-
-#endif /* __DT_BINDINGS_RESET_SAMA7G5_H */
diff --git a/include/dt-bindings/reset/snps,hsdk-reset.h b/include/dt-bindings/reset/snps,hsdk-reset.h
deleted file mode 100644
index e1a643e4bc91..000000000000
--- a/include/dt-bindings/reset/snps,hsdk-reset.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/**
- * This header provides index for the HSDK reset controller.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_SNPS_HSDK
-#define _DT_BINDINGS_RESET_CONTROLLER_SNPS_HSDK
-
-#define HSDK_APB_RESET	0
-#define HSDK_AXI_RESET	1
-#define HSDK_ETH_RESET	2
-#define HSDK_USB_RESET	3
-#define HSDK_SDIO_RESET	4
-#define HSDK_HDMI_RESET	5
-#define HSDK_GFX_RESET	6
-#define HSDK_DMAC_RESET	7
-#define HSDK_EBI_RESET	8
-
-#endif /*_DT_BINDINGS_RESET_CONTROLLER_SNPS_HSDK*/
diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
deleted file mode 100644
index 1d596581da7b..000000000000
--- a/include/dt-bindings/reset/starfive,jh7110-crg.h
+++ /dev/null
@@ -1,183 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2022 StarFive Technology Co., Ltd.
- *
- * Author: Yanhong Wang <yanhong.wang@starfivetech.com>
- */
-
-#ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-#define __DT_BINDINGS_RESET_STARFIVE_JH7110_H__
-
-/* SYSCRG resets */
-#define JH7110_SYSRST_JTAG2APB			0
-#define JH7110_SYSRST_SYSCON			1
-#define JH7110_SYSRST_IOMUX_APB		2
-#define JH7110_SYSRST_BUS			3
-#define JH7110_SYSRST_DEBUG			4
-#define JH7110_SYSRST_CORE0			5
-#define JH7110_SYSRST_CORE1			6
-#define JH7110_SYSRST_CORE2			7
-#define JH7110_SYSRST_CORE3			8
-#define JH7110_SYSRST_CORE4			9
-#define JH7110_SYSRST_CORE0_ST			10
-#define JH7110_SYSRST_CORE1_ST			11
-#define JH7110_SYSRST_CORE2_ST			12
-#define JH7110_SYSRST_CORE3_ST			13
-#define JH7110_SYSRST_CORE4_ST			14
-#define JH7110_SYSRST_TRACE0			15
-#define JH7110_SYSRST_TRACE1			16
-#define JH7110_SYSRST_TRACE2			17
-#define JH7110_SYSRST_TRACE3			18
-#define JH7110_SYSRST_TRACE4			19
-#define JH7110_SYSRST_TRACE_COM		20
-#define JH7110_SYSRST_GPU_APB			21
-#define JH7110_SYSRST_GPU_DOMA			22
-#define JH7110_SYSRST_NOC_BUS_APB_BUS		23
-#define JH7110_SYSRST_NOC_BUS_AXICFG0_AXI	24
-#define JH7110_SYSRST_NOC_BUS_CPU_AXI		25
-#define JH7110_SYSRST_NOC_BUS_DISP_AXI		26
-#define JH7110_SYSRST_NOC_BUS_GPU_AXI		27
-#define JH7110_SYSRST_NOC_BUS_ISP_AXI		28
-#define JH7110_SYSRST_NOC_BUS_DDRC		29
-#define JH7110_SYSRST_NOC_BUS_STG_AXI		30
-#define JH7110_SYSRST_NOC_BUS_VDEC_AXI		31
-
-#define JH7110_SYSRST_NOC_BUS_VENC_AXI		32
-#define JH7110_SYSRST_AXI_CFG1_DEC_AHB		33
-#define JH7110_SYSRST_AXI_CFG1_DEC_MAIN	34
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN	35
-#define JH7110_SYSRST_AXI_CFG0_DEC_MAIN_DIV	36
-#define JH7110_SYSRST_AXI_CFG0_DEC_HIFI4	37
-#define JH7110_SYSRST_DDR_AXI			38
-#define JH7110_SYSRST_DDR_OSC			39
-#define JH7110_SYSRST_DDR_APB			40
-#define JH7110_SYSRST_DOM_ISP_TOP_N		41
-#define JH7110_SYSRST_DOM_ISP_TOP_AXI		42
-#define JH7110_SYSRST_DOM_VOUT_TOP_SRC		43
-#define JH7110_SYSRST_CODAJ12_AXI		44
-#define JH7110_SYSRST_CODAJ12_CORE		45
-#define JH7110_SYSRST_CODAJ12_APB		46
-#define JH7110_SYSRST_WAVE511_AXI		47
-#define JH7110_SYSRST_WAVE511_BPU		48
-#define JH7110_SYSRST_WAVE511_VCE		49
-#define JH7110_SYSRST_WAVE511_APB		50
-#define JH7110_SYSRST_VDEC_JPG_ARB_JPG		51
-#define JH7110_SYSRST_VDEC_JPG_ARB_MAIN	52
-#define JH7110_SYSRST_AXIMEM0_AXI		53
-#define JH7110_SYSRST_WAVE420L_AXI		54
-#define JH7110_SYSRST_WAVE420L_BPU		55
-#define JH7110_SYSRST_WAVE420L_VCE		56
-#define JH7110_SYSRST_WAVE420L_APB		57
-#define JH7110_SYSRST_AXIMEM1_AXI		58
-#define JH7110_SYSRST_AXIMEM2_AXI		59
-#define JH7110_SYSRST_INTMEM			60
-#define JH7110_SYSRST_QSPI_AHB			61
-#define JH7110_SYSRST_QSPI_APB			62
-#define JH7110_SYSRST_QSPI_REF			63
-
-#define JH7110_SYSRST_SDIO0_AHB		64
-#define JH7110_SYSRST_SDIO1_AHB		65
-#define JH7110_SYSRST_GMAC1_AXI		66
-#define JH7110_SYSRST_GMAC1_AHB		67
-#define JH7110_SYSRST_MAILBOX			68
-#define JH7110_SYSRST_SPI0_APB			69
-#define JH7110_SYSRST_SPI1_APB			70
-#define JH7110_SYSRST_SPI2_APB			71
-#define JH7110_SYSRST_SPI3_APB			72
-#define JH7110_SYSRST_SPI4_APB			73
-#define JH7110_SYSRST_SPI5_APB			74
-#define JH7110_SYSRST_SPI6_APB			75
-#define JH7110_SYSRST_I2C0_APB			76
-#define JH7110_SYSRST_I2C1_APB			77
-#define JH7110_SYSRST_I2C2_APB			78
-#define JH7110_SYSRST_I2C3_APB			79
-#define JH7110_SYSRST_I2C4_APB			80
-#define JH7110_SYSRST_I2C5_APB			81
-#define JH7110_SYSRST_I2C6_APB			82
-#define JH7110_SYSRST_UART0_APB		83
-#define JH7110_SYSRST_UART0_CORE		84
-#define JH7110_SYSRST_UART1_APB		85
-#define JH7110_SYSRST_UART1_CORE		86
-#define JH7110_SYSRST_UART2_APB		87
-#define JH7110_SYSRST_UART2_CORE		88
-#define JH7110_SYSRST_UART3_APB		89
-#define JH7110_SYSRST_UART3_CORE		90
-#define JH7110_SYSRST_UART4_APB		91
-#define JH7110_SYSRST_UART4_CORE		92
-#define JH7110_SYSRST_UART5_APB		93
-#define JH7110_SYSRST_UART5_CORE		94
-#define JH7110_SYSRST_SPDIF_APB		95
-
-#define JH7110_SYSRST_PWMDAC_APB		96
-#define JH7110_SYSRST_PDM_DMIC			97
-#define JH7110_SYSRST_PDM_APB			98
-#define JH7110_SYSRST_I2SRX_APB		99
-#define JH7110_SYSRST_I2SRX_BCLK		100
-#define JH7110_SYSRST_I2STX0_APB		101
-#define JH7110_SYSRST_I2STX0_BCLK		102
-#define JH7110_SYSRST_I2STX1_APB		103
-#define JH7110_SYSRST_I2STX1_BCLK		104
-#define JH7110_SYSRST_TDM_AHB			105
-#define JH7110_SYSRST_TDM_CORE			106
-#define JH7110_SYSRST_TDM_APB			107
-#define JH7110_SYSRST_PWM_APB			108
-#define JH7110_SYSRST_WDT_APB			109
-#define JH7110_SYSRST_WDT_CORE			110
-#define JH7110_SYSRST_CAN0_APB			111
-#define JH7110_SYSRST_CAN0_CORE		112
-#define JH7110_SYSRST_CAN0_TIMER		113
-#define JH7110_SYSRST_CAN1_APB			114
-#define JH7110_SYSRST_CAN1_CORE		115
-#define JH7110_SYSRST_CAN1_TIMER		116
-#define JH7110_SYSRST_TIMER_APB		117
-#define JH7110_SYSRST_TIMER0			118
-#define JH7110_SYSRST_TIMER1			119
-#define JH7110_SYSRST_TIMER2			120
-#define JH7110_SYSRST_TIMER3			121
-#define JH7110_SYSRST_INT_CTRL_APB		122
-#define JH7110_SYSRST_TEMP_APB			123
-#define JH7110_SYSRST_TEMP_CORE		124
-#define JH7110_SYSRST_JTAG_CERTIFICATION	125
-
-#define JH7110_SYSRST_END			126
-
-/* AONCRG resets */
-#define JH7110_AONRST_GMAC0_AXI		0
-#define JH7110_AONRST_GMAC0_AHB		1
-#define JH7110_AONRST_IOMUX			2
-#define JH7110_AONRST_PMU_APB			3
-#define JH7110_AONRST_PMU_WKUP			4
-#define JH7110_AONRST_RTC_APB			5
-#define JH7110_AONRST_RTC_CAL			6
-#define JH7110_AONRST_RTC_32K			7
-
-#define JH7110_AONRST_END			8
-
-/* STGCRG resets */
-#define JH7110_STGRST_SYSCON_PRESETN		0
-#define JH7110_STGRST_HIFI4_CORE		1
-#define JH7110_STGRST_HIFI4_AXI		2
-#define JH7110_STGRST_SEC_TOP_HRESETN		3
-#define JH7110_STGRST_E24_CORE			4
-#define JH7110_STGRST_DMA1P_AXI		5
-#define JH7110_STGRST_DMA1P_AHB		6
-#define JH7110_STGRST_USB_AXI			7
-#define JH7110_STGRST_USB_APB			8
-#define JH7110_STGRST_USB_UTMI_APB		9
-#define JH7110_STGRST_USB_PWRUP		10
-#define JH7110_STGRST_PCIE0_MST0		11
-#define JH7110_STGRST_PCIE0_SLV0		12
-#define JH7110_STGRST_PCIE0_SLV		13
-#define JH7110_STGRST_PCIE0_BRG		14
-#define JH7110_STGRST_PCIE0_CORE		15
-#define JH7110_STGRST_PCIE0_APB		16
-#define JH7110_STGRST_PCIE1_MST0		17
-#define JH7110_STGRST_PCIE1_SLV0		18
-#define JH7110_STGRST_PCIE1_SLV		19
-#define JH7110_STGRST_PCIE1_BRG		20
-#define JH7110_STGRST_PCIE1_CORE		21
-#define JH7110_STGRST_PCIE1_APB		22
-
-#define JH7110_STGRST_END			23
-
-#endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_H__ */
diff --git a/include/dt-bindings/sound/apq8016-lpass.h b/include/dt-bindings/sound/apq8016-lpass.h
deleted file mode 100644
index dc605c4bc224..000000000000
--- a/include/dt-bindings/sound/apq8016-lpass.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_APQ8016_LPASS_H
-#define __DT_APQ8016_LPASS_H
-
-#include <dt-bindings/sound/qcom,lpass.h>
-
-/* NOTE: Use qcom,lpass.h to define any AIF ID's for LPASS */
-
-#endif /* __DT_APQ8016_LPASS_H */
diff --git a/include/dt-bindings/sound/tlv320aic31xx.h b/include/dt-bindings/sound/tlv320aic31xx.h
deleted file mode 100644
index 4a80238ab250..000000000000
--- a/include/dt-bindings/sound/tlv320aic31xx.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_TLV320AIC31XX_H
-#define __DT_TLV320AIC31XX_H
-
-#define MICBIAS_2_0V		1
-#define MICBIAS_2_5V		2
-#define MICBIAS_AVDDV		3
-
-#define PLL_CLKIN_MCLK		0x00
-#define PLL_CLKIN_BCLK		0x01
-#define PLL_CLKIN_GPIO1		0x02
-#define PLL_CLKIN_DIN		0x03
-
-#endif /* __DT_TLV320AIC31XX_H */

-- 
2.44.0


