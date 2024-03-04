Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2038EC54E7A
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.104448.1709571117922565426
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Mar 2024 08:51:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=um4iPnM5;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412cf3c5cdeso19613365e9.2
        for <u-boot-amlogic@groups.io>; Mon, 04 Mar 2024 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709571116; x=1710175916; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1ASbhJ8pDNxOQKza4SvWtSWDi9xDgSqdUryll9us+Q=;
        b=um4iPnM5LiGhop5Bz9mEGifbGuoY1vDFdSKWu9CkXOBB5tqD8aceHpAJd1rDUZsjsF
         cFFVeJ2kvzBuK2VmA1dlUCSrZJngpSM4RUNvvl60lt4Jj01trMBXyi1VE/J0k11gDaW4
         AwaXx8cLSGvQeSjEAXiKdq5PfVwp9HKkZJLwGpDIAvEXlwHvkbXx5szYPMb5DPBsPyrc
         0H0iGoYVTnv14vcNnEd0eG/ZubcP68mQrs6IkTByxEjUWl5KskkHNlG3BgaFRtGDJBD9
         f9S0RgAzLRaj0ghF3Irg/kxG7pOdDYQ10e3j5NuEJq7tFeU8iAyyKR7oRCI7wwdyB6lO
         iHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571116; x=1710175916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1ASbhJ8pDNxOQKza4SvWtSWDi9xDgSqdUryll9us+Q=;
        b=uG1XOhztwhjvLSvJZm2zFKf7m/mzBGKqbYEEt9BqL+Wt6sxA0o3dKAK3j0J7NVi/lR
         NWu5bmcM3WORQhT1OOXj3mlBOfbEnb4XtjCy087Apyh5ynMCoNnLAtctaRT5Mo5y1C6w
         uQdoceaU+qXdDnhs4E55Gr6D15ZlJLVRFdjBD1hXP0TxSH3JQT6VaSNF6XGYsnHWeVjE
         4PAN9P5wTkcVMCcfoj/Z1ZzrrlAf/lqsGwy2qIGmJH2fzcUBkcGHg+T5r/zcNIBfLCPe
         /ZS+1DRVdkOGZ6cP4+CTRAjVI6jBvvyr2vLl1hZ1qSR2VgaCZJmVTcPWCdMMsGLm04cH
         h6bw==
X-Forwarded-Encrypted: i=1; AJvYcCXBAsb+VNlvt1jmIUiVRxra9XMhsJrJsE+j2BNvPYmRhg7YD9JdLebk+05cIBkJ2cUQBAN0HfypmGj14y2GSpFhBmD1/8IxIjM=
X-Gm-Message-State: AOJu0YyfuqxOlbAWsaNyKyECEql2gsKvy9isf0MiDWEuRwdny3SW+pUC
	2of0L1XAxx0qXPBN/GKGBbIC2tZa+kUjqFHw5rc9eFHSCwf/o/xUL88Dx98U+D0=
X-Google-Smtp-Source: AGHT+IGhXo5D37Lahhj6QS+zokKmdwUnMLdqyNG94Sq2NOvYI9hNetLKv0Ef9DMBUPJvIDVwrnLdyg==
X-Received: by 2002:a05:600c:a12:b0:412:e221:2bd5 with SMTP id z18-20020a05600c0a1200b00412e2212bd5mr3022635wmp.3.1709571116384;
        Mon, 04 Mar 2024 08:51:56 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b00412cb0961fasm10598517wmq.6.2024.03.04.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:51:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 04 Mar 2024 16:51:29 +0000
Subject: [PATCH RFC 21/26] hisi: drop dt-binding headers
MIME-Version: 1.0
Message-Id: <20240304-b4-upstream-dt-headers-v1-21-b7ff41925f92@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15260;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=S6l2X68dLtPLBye6TdWUWbFGD8YCUQmcKehHGXIg088=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSnfzg+Mc5U4VHKd984S7AwN6tV+uqV7GDz2cZmledWe
 fWs193eUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZyrJuRYeUbH4ZrPqlPvp/I
 /CzxI6v8xzyFf4HX77NUds4PzTzC8IORoYe9YOuj6FlM30WiP+1KlL1qURDJ3Nxra7Ki88a8v2I
 lUwE=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2177

Drop in favour of dts/upstream

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/clock/hi3660-clock.h | 214 -------------------------------
 include/dt-bindings/clock/hi6220-clock.h | 173 -------------------------
 include/dt-bindings/pinctrl/hisi.h       |  74 -----------
 3 files changed, 461 deletions(-)

diff --git a/include/dt-bindings/clock/hi3660-clock.h b/include/dt-bindings/clock/hi3660-clock.h
deleted file mode 100644
index e1374e180943..000000000000
--- a/include/dt-bindings/clock/hi3660-clock.h
+++ /dev/null
@@ -1,214 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2016-2017 Linaro Ltd.
- * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
- */
-
-#ifndef __DTS_HI3660_CLOCK_H
-#define __DTS_HI3660_CLOCK_H
-
-/* fixed rate clocks */
-#define HI3660_CLKIN_SYS		0
-#define HI3660_CLKIN_REF		1
-#define HI3660_CLK_FLL_SRC		2
-#define HI3660_CLK_PPLL0		3
-#define HI3660_CLK_PPLL1		4
-#define HI3660_CLK_PPLL2		5
-#define HI3660_CLK_PPLL3		6
-#define HI3660_CLK_SCPLL		7
-#define HI3660_PCLK			8
-#define HI3660_CLK_UART0_DBG		9
-#define HI3660_CLK_UART6		10
-#define HI3660_OSC32K			11
-#define HI3660_OSC19M			12
-#define HI3660_CLK_480M			13
-#define HI3660_CLK_INV			14
-
-/* clk in crgctrl */
-#define HI3660_FACTOR_UART3		15
-#define HI3660_CLK_FACTOR_MMC		16
-#define HI3660_CLK_GATE_I2C0		17
-#define HI3660_CLK_GATE_I2C1		18
-#define HI3660_CLK_GATE_I2C2		19
-#define HI3660_CLK_GATE_I2C6		20
-#define HI3660_CLK_DIV_SYSBUS		21
-#define HI3660_CLK_DIV_320M		22
-#define HI3660_CLK_DIV_A53		23
-#define HI3660_CLK_GATE_SPI0		24
-#define HI3660_CLK_GATE_SPI2		25
-#define HI3660_PCIEPHY_REF		26
-#define HI3660_CLK_ABB_USB		27
-#define HI3660_HCLK_GATE_SDIO0		28
-#define HI3660_HCLK_GATE_SD		29
-#define HI3660_CLK_GATE_AOMM		30
-#define HI3660_PCLK_GPIO0		31
-#define HI3660_PCLK_GPIO1		32
-#define HI3660_PCLK_GPIO2		33
-#define HI3660_PCLK_GPIO3		34
-#define HI3660_PCLK_GPIO4		35
-#define HI3660_PCLK_GPIO5		36
-#define HI3660_PCLK_GPIO6		37
-#define HI3660_PCLK_GPIO7		38
-#define HI3660_PCLK_GPIO8		39
-#define HI3660_PCLK_GPIO9		40
-#define HI3660_PCLK_GPIO10		41
-#define HI3660_PCLK_GPIO11		42
-#define HI3660_PCLK_GPIO12		43
-#define HI3660_PCLK_GPIO13		44
-#define HI3660_PCLK_GPIO14		45
-#define HI3660_PCLK_GPIO15		46
-#define HI3660_PCLK_GPIO16		47
-#define HI3660_PCLK_GPIO17		48
-#define HI3660_PCLK_GPIO18		49
-#define HI3660_PCLK_GPIO19		50
-#define HI3660_PCLK_GPIO20		51
-#define HI3660_PCLK_GPIO21		52
-#define HI3660_CLK_GATE_SPI3		53
-#define HI3660_CLK_GATE_I2C7		54
-#define HI3660_CLK_GATE_I2C3		55
-#define HI3660_CLK_GATE_SPI1		56
-#define HI3660_CLK_GATE_UART1		57
-#define HI3660_CLK_GATE_UART2		58
-#define HI3660_CLK_GATE_UART4		59
-#define HI3660_CLK_GATE_UART5		60
-#define HI3660_CLK_GATE_I2C4		61
-#define HI3660_CLK_GATE_DMAC		62
-#define HI3660_PCLK_GATE_DSS		63
-#define HI3660_ACLK_GATE_DSS		64
-#define HI3660_CLK_GATE_LDI1		65
-#define HI3660_CLK_GATE_LDI0		66
-#define HI3660_CLK_GATE_VIVOBUS		67
-#define HI3660_CLK_GATE_EDC0		68
-#define HI3660_CLK_GATE_TXDPHY0_CFG	69
-#define HI3660_CLK_GATE_TXDPHY0_REF	70
-#define HI3660_CLK_GATE_TXDPHY1_CFG	71
-#define HI3660_CLK_GATE_TXDPHY1_REF	72
-#define HI3660_ACLK_GATE_USB3OTG	73
-#define HI3660_CLK_GATE_SPI4		74
-#define HI3660_CLK_GATE_SD		75
-#define HI3660_CLK_GATE_SDIO0		76
-#define HI3660_CLK_GATE_UFS_SUBSYS	77
-#define HI3660_PCLK_GATE_DSI0		78
-#define HI3660_PCLK_GATE_DSI1		79
-#define HI3660_ACLK_GATE_PCIE		80
-#define HI3660_PCLK_GATE_PCIE_SYS       81
-#define HI3660_CLK_GATE_PCIEAUX		82
-#define HI3660_PCLK_GATE_PCIE_PHY	83
-#define HI3660_CLK_ANDGT_LDI0		84
-#define HI3660_CLK_ANDGT_LDI1		85
-#define HI3660_CLK_ANDGT_EDC0		86
-#define HI3660_CLK_GATE_UFSPHY_GT	87
-#define HI3660_CLK_ANDGT_MMC		88
-#define HI3660_CLK_ANDGT_SD		89
-#define HI3660_CLK_A53HPM_ANDGT		90
-#define HI3660_CLK_ANDGT_SDIO		91
-#define HI3660_CLK_ANDGT_UART0		92
-#define HI3660_CLK_ANDGT_UART1		93
-#define HI3660_CLK_ANDGT_UARTH		94
-#define HI3660_CLK_ANDGT_SPI		95
-#define HI3660_CLK_VIVOBUS_ANDGT	96
-#define HI3660_CLK_AOMM_ANDGT		97
-#define HI3660_CLK_320M_PLL_GT		98
-#define HI3660_AUTODIV_EMMC0BUS		99
-#define HI3660_AUTODIV_SYSBUS		100
-#define HI3660_CLK_GATE_UFSPHY_CFG	101
-#define HI3660_CLK_GATE_UFSIO_REF	102
-#define HI3660_CLK_MUX_SYSBUS		103
-#define HI3660_CLK_MUX_UART0		104
-#define HI3660_CLK_MUX_UART1		105
-#define HI3660_CLK_MUX_UARTH		106
-#define HI3660_CLK_MUX_SPI		107
-#define HI3660_CLK_MUX_I2C		108
-#define HI3660_CLK_MUX_MMC_PLL		109
-#define HI3660_CLK_MUX_LDI1		110
-#define HI3660_CLK_MUX_LDI0		111
-#define HI3660_CLK_MUX_SD_PLL		112
-#define HI3660_CLK_MUX_SD_SYS		113
-#define HI3660_CLK_MUX_EDC0		114
-#define HI3660_CLK_MUX_SDIO_SYS		115
-#define HI3660_CLK_MUX_SDIO_PLL		116
-#define HI3660_CLK_MUX_VIVOBUS		117
-#define HI3660_CLK_MUX_A53HPM		118
-#define HI3660_CLK_MUX_320M		119
-#define HI3660_CLK_MUX_IOPERI		120
-#define HI3660_CLK_DIV_UART0		121
-#define HI3660_CLK_DIV_UART1		122
-#define HI3660_CLK_DIV_UARTH		123
-#define HI3660_CLK_DIV_MMC		124
-#define HI3660_CLK_DIV_SD		125
-#define HI3660_CLK_DIV_EDC0		126
-#define HI3660_CLK_DIV_LDI0		127
-#define HI3660_CLK_DIV_SDIO		128
-#define HI3660_CLK_DIV_LDI1		129
-#define HI3660_CLK_DIV_SPI		130
-#define HI3660_CLK_DIV_VIVOBUS		131
-#define HI3660_CLK_DIV_I2C		132
-#define HI3660_CLK_DIV_UFSPHY		133
-#define HI3660_CLK_DIV_CFGBUS		134
-#define HI3660_CLK_DIV_MMC0BUS		135
-#define HI3660_CLK_DIV_MMC1BUS		136
-#define HI3660_CLK_DIV_UFSPERI		137
-#define HI3660_CLK_DIV_AOMM		138
-#define HI3660_CLK_DIV_IOPERI		139
-#define HI3660_VENC_VOLT_HOLD		140
-#define HI3660_PERI_VOLT_HOLD		141
-#define HI3660_CLK_GATE_VENC		142
-#define HI3660_CLK_GATE_VDEC		143
-#define HI3660_CLK_ANDGT_VENC		144
-#define HI3660_CLK_ANDGT_VDEC		145
-#define HI3660_CLK_MUX_VENC		146
-#define HI3660_CLK_MUX_VDEC		147
-#define HI3660_CLK_DIV_VENC		148
-#define HI3660_CLK_DIV_VDEC		149
-#define HI3660_CLK_FAC_ISP_SNCLK	150
-#define HI3660_CLK_GATE_ISP_SNCLK0	151
-#define HI3660_CLK_GATE_ISP_SNCLK1	152
-#define HI3660_CLK_GATE_ISP_SNCLK2	153
-#define HI3660_CLK_ANGT_ISP_SNCLK	154
-#define HI3660_CLK_MUX_ISP_SNCLK	155
-#define HI3660_CLK_DIV_ISP_SNCLK	156
-
-/* clk in pmuctrl */
-#define HI3660_GATE_ABB_192		0
-
-/* clk in pctrl */
-#define HI3660_GATE_UFS_TCXO_EN		0
-#define HI3660_GATE_USB_TCXO_EN		1
-
-/* clk in sctrl */
-#define HI3660_PCLK_AO_GPIO0		0
-#define HI3660_PCLK_AO_GPIO1		1
-#define HI3660_PCLK_AO_GPIO2		2
-#define HI3660_PCLK_AO_GPIO3		3
-#define HI3660_PCLK_AO_GPIO4		4
-#define HI3660_PCLK_AO_GPIO5		5
-#define HI3660_PCLK_AO_GPIO6		6
-#define HI3660_PCLK_GATE_MMBUF		7
-#define HI3660_CLK_GATE_DSS_AXI_MM	8
-#define HI3660_PCLK_MMBUF_ANDGT		9
-#define HI3660_CLK_MMBUF_PLL_ANDGT	10
-#define HI3660_CLK_FLL_MMBUF_ANDGT	11
-#define HI3660_CLK_SYS_MMBUF_ANDGT	12
-#define HI3660_CLK_GATE_PCIEPHY_GT	13
-#define HI3660_ACLK_MUX_MMBUF		14
-#define HI3660_CLK_SW_MMBUF		15
-#define HI3660_CLK_DIV_AOBUS		16
-#define HI3660_PCLK_DIV_MMBUF		17
-#define HI3660_ACLK_DIV_MMBUF		18
-#define HI3660_CLK_DIV_PCIEPHY		19
-
-/* clk in iomcu */
-#define HI3660_CLK_I2C0_IOMCU		0
-#define HI3660_CLK_I2C1_IOMCU		1
-#define HI3660_CLK_I2C2_IOMCU		2
-#define HI3660_CLK_I2C6_IOMCU		3
-#define HI3660_CLK_IOMCU_PERI0		4
-
-/* clk in stub clock */
-#define HI3660_CLK_STUB_CLUSTER0	0
-#define HI3660_CLK_STUB_CLUSTER1	1
-#define HI3660_CLK_STUB_GPU		2
-#define HI3660_CLK_STUB_DDR		3
-#define HI3660_CLK_STUB_NUM		4
-
-#endif	/* __DTS_HI3660_CLOCK_H */
diff --git a/include/dt-bindings/clock/hi6220-clock.h b/include/dt-bindings/clock/hi6220-clock.h
deleted file mode 100644
index 70ee3833a7a0..000000000000
--- a/include/dt-bindings/clock/hi6220-clock.h
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright (c) 2015 Hisilicon Limited.
- *
- * Author: Bintian Wang <bintian.wang@huawei.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_HI6220_H
-#define __DT_BINDINGS_CLOCK_HI6220_H
-
-/* clk in Hi6220 AO (always on) controller */
-#define HI6220_NONE_CLOCK	0
-
-/* fixed rate clocks */
-#define HI6220_REF32K		1
-#define HI6220_CLK_TCXO		2
-#define HI6220_MMC1_PAD		3
-#define HI6220_MMC2_PAD		4
-#define HI6220_MMC0_PAD		5
-#define HI6220_PLL_BBP		6
-#define HI6220_PLL_GPU		7
-#define HI6220_PLL1_DDR		8
-#define HI6220_PLL_SYS		9
-#define HI6220_PLL_SYS_MEDIA	10
-#define HI6220_DDR_SRC		11
-#define HI6220_PLL_MEDIA	12
-#define HI6220_PLL_DDR		13
-
-/* fixed factor clocks */
-#define HI6220_300M		14
-#define HI6220_150M		15
-#define HI6220_PICOPHY_SRC	16
-#define HI6220_MMC0_SRC_SEL	17
-#define HI6220_MMC1_SRC_SEL	18
-#define HI6220_MMC2_SRC_SEL	19
-#define HI6220_VPU_CODEC	20
-#define HI6220_MMC0_SMP		21
-#define HI6220_MMC1_SMP		22
-#define HI6220_MMC2_SMP		23
-
-/* gate clocks */
-#define HI6220_WDT0_PCLK	24
-#define HI6220_WDT1_PCLK	25
-#define HI6220_WDT2_PCLK	26
-#define HI6220_TIMER0_PCLK	27
-#define HI6220_TIMER1_PCLK	28
-#define HI6220_TIMER2_PCLK	29
-#define HI6220_TIMER3_PCLK	30
-#define HI6220_TIMER4_PCLK	31
-#define HI6220_TIMER5_PCLK	32
-#define HI6220_TIMER6_PCLK	33
-#define HI6220_TIMER7_PCLK	34
-#define HI6220_TIMER8_PCLK	35
-#define HI6220_UART0_PCLK	36
-
-#define HI6220_AO_NR_CLKS	37
-
-/* clk in Hi6220 systrl */
-/* gate clock */
-#define HI6220_MMC0_CLK		1
-#define HI6220_MMC0_CIUCLK	2
-#define HI6220_MMC1_CLK		3
-#define HI6220_MMC1_CIUCLK	4
-#define HI6220_MMC2_CLK		5
-#define HI6220_MMC2_CIUCLK	6
-#define HI6220_USBOTG_HCLK	7
-#define HI6220_CLK_PICOPHY	8
-#define HI6220_HIFI		9
-#define HI6220_DACODEC_PCLK	10
-#define HI6220_EDMAC_ACLK	11
-#define HI6220_CS_ATB		12
-#define HI6220_I2C0_CLK		13
-#define HI6220_I2C1_CLK		14
-#define HI6220_I2C2_CLK		15
-#define HI6220_I2C3_CLK		16
-#define HI6220_UART1_PCLK	17
-#define HI6220_UART2_PCLK	18
-#define HI6220_UART3_PCLK	19
-#define HI6220_UART4_PCLK	20
-#define HI6220_SPI_CLK		21
-#define HI6220_TSENSOR_CLK	22
-#define HI6220_MMU_CLK		23
-#define HI6220_HIFI_SEL		24
-#define HI6220_MMC0_SYSPLL	25
-#define HI6220_MMC1_SYSPLL	26
-#define HI6220_MMC2_SYSPLL	27
-#define HI6220_MMC0_SEL		28
-#define HI6220_MMC1_SEL		29
-#define HI6220_BBPPLL_SEL	30
-#define HI6220_MEDIA_PLL_SRC	31
-#define HI6220_MMC2_SEL		32
-#define HI6220_CS_ATB_SYSPLL	33
-
-/* mux clocks */
-#define HI6220_MMC0_SRC		34
-#define HI6220_MMC0_SMP_IN	35
-#define HI6220_MMC1_SRC		36
-#define HI6220_MMC1_SMP_IN	37
-#define HI6220_MMC2_SRC		38
-#define HI6220_MMC2_SMP_IN	39
-#define HI6220_HIFI_SRC		40
-#define HI6220_UART1_SRC	41
-#define HI6220_UART2_SRC	42
-#define HI6220_UART3_SRC	43
-#define HI6220_UART4_SRC	44
-#define HI6220_MMC0_MUX0	45
-#define HI6220_MMC1_MUX0	46
-#define HI6220_MMC2_MUX0	47
-#define HI6220_MMC0_MUX1	48
-#define HI6220_MMC1_MUX1	49
-#define HI6220_MMC2_MUX1	50
-
-/* divider clocks */
-#define HI6220_CLK_BUS		51
-#define HI6220_MMC0_DIV		52
-#define HI6220_MMC1_DIV		53
-#define HI6220_MMC2_DIV		54
-#define HI6220_HIFI_DIV		55
-#define HI6220_BBPPLL0_DIV	56
-#define HI6220_CS_DAPB		57
-#define HI6220_CS_ATB_DIV	58
-
-#define HI6220_SYS_NR_CLKS	59
-
-/* clk in Hi6220 media controller */
-/* gate clocks */
-#define HI6220_DSI_PCLK		1
-#define HI6220_G3D_PCLK		2
-#define HI6220_ACLK_CODEC_VPU	3
-#define HI6220_ISP_SCLK		4
-#define HI6220_ADE_CORE		5
-#define HI6220_MED_MMU		6
-#define HI6220_CFG_CSI4PHY	7
-#define HI6220_CFG_CSI2PHY	8
-#define HI6220_ISP_SCLK_GATE	9
-#define HI6220_ISP_SCLK_GATE1	10
-#define HI6220_ADE_CORE_GATE	11
-#define HI6220_CODEC_VPU_GATE	12
-#define HI6220_MED_SYSPLL	13
-
-/* mux clocks */
-#define HI6220_1440_1200	14
-#define HI6220_1000_1200	15
-#define HI6220_1000_1440	16
-
-/* divider clocks */
-#define HI6220_CODEC_JPEG	17
-#define HI6220_ISP_SCLK_SRC	18
-#define HI6220_ISP_SCLK1	19
-#define HI6220_ADE_CORE_SRC	20
-#define HI6220_ADE_PIX_SRC	21
-#define HI6220_G3D_CLK		22
-#define HI6220_CODEC_VPU_SRC	23
-
-#define HI6220_MEDIA_NR_CLKS	24
-
-/* clk in Hi6220 power controller */
-/* gate clocks */
-#define HI6220_PLL_GPU_GATE	1
-#define HI6220_PLL1_DDR_GATE	2
-#define HI6220_PLL_DDR_GATE	3
-#define HI6220_PLL_MEDIA_GATE	4
-#define HI6220_PLL0_BBP_GATE	5
-
-/* divider clocks */
-#define HI6220_DDRC_SRC		6
-#define HI6220_DDRC_AXI1	7
-
-#define HI6220_POWER_NR_CLKS	8
-#endif
diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
deleted file mode 100644
index 0359bfdc9119..000000000000
--- a/include/dt-bindings/pinctrl/hisi.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * This header provides constants for hisilicon pinctrl bindings.
- *
- * Copyright (c) 2015 Hisilicon Limited.
- * Copyright (c) 2015 Linaro Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef _DT_BINDINGS_PINCTRL_HISI_H
-#define _DT_BINDINGS_PINCTRL_HISI_H
-
-/* iomg bit definition */
-#define MUX_M0		0
-#define MUX_M1		1
-#define MUX_M2		2
-#define MUX_M3		3
-#define MUX_M4		4
-#define MUX_M5		5
-#define MUX_M6		6
-#define MUX_M7		7
-
-/* iocg bit definition */
-#define PULL_MASK	(3)
-#define PULL_DIS	(0)
-#define PULL_UP		(1 << 0)
-#define PULL_DOWN	(1 << 1)
-
-/* drive strength definition */
-#define DRIVE_MASK	(7 << 4)
-#define DRIVE1_02MA	(0 << 4)
-#define DRIVE1_04MA	(1 << 4)
-#define DRIVE1_08MA	(2 << 4)
-#define DRIVE1_10MA	(3 << 4)
-#define DRIVE2_02MA	(0 << 4)
-#define DRIVE2_04MA	(1 << 4)
-#define DRIVE2_08MA	(2 << 4)
-#define DRIVE2_10MA	(3 << 4)
-#define DRIVE3_04MA	(0 << 4)
-#define DRIVE3_08MA	(1 << 4)
-#define DRIVE3_12MA	(2 << 4)
-#define DRIVE3_16MA	(3 << 4)
-#define DRIVE3_20MA	(4 << 4)
-#define DRIVE3_24MA	(5 << 4)
-#define DRIVE3_32MA	(6 << 4)
-#define DRIVE3_40MA	(7 << 4)
-#define DRIVE4_02MA	(0 << 4)
-#define DRIVE4_04MA	(2 << 4)
-#define DRIVE4_08MA	(4 << 4)
-#define DRIVE4_10MA	(6 << 4)
-
-/* drive strength definition for hi3660 */
-#define DRIVE6_MASK	(15 << 4)
-#define DRIVE6_04MA	(0 << 4)
-#define DRIVE6_12MA	(4 << 4)
-#define DRIVE6_19MA	(8 << 4)
-#define DRIVE6_27MA	(10 << 4)
-#define DRIVE6_32MA	(15 << 4)
-#define DRIVE7_02MA	(0 << 4)
-#define DRIVE7_04MA	(1 << 4)
-#define DRIVE7_06MA	(2 << 4)
-#define DRIVE7_08MA	(3 << 4)
-#define DRIVE7_10MA	(4 << 4)
-#define DRIVE7_12MA	(5 << 4)
-#define DRIVE7_14MA	(6 << 4)
-#define DRIVE7_16MA	(7 << 4)
-#endif

-- 
2.44.0


