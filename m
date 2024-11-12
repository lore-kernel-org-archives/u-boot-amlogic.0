Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA01D42BA1
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.86296.1731416338336224171
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Nov 2024 04:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=NRBcfc20;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A2A74100011;
	Tue, 12 Nov 2024 15:58:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A2A74100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731416336;
	bh=5IE2Nnxec/GWwiInH0d8tnPPbjakYncxgSSPwNBcXF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=NRBcfc20qxp3VVUsNZ9fYtFstZipQKpXdBbGhkcHtzSurT85mI6U8rk9ovk+y/2Es
	 ysmmSCff3Qzw+2xKoHxblFsSWUQUbImbsTThXZygXl+GX50s/SMpBqc7hBtMGUFcE9
	 LvHAcThq993dWTqa9QkU/HV3wNmdaQLV/rANP3rYCcg6bhbYpZmCKn4aN0BR/suRv6
	 n3DTp6T3bX0+3G4HTxrfM2BstIz1apggnO+x9uj9C2/1THRtWs7Dim8bqpQdte2lnJ
	 PwJIL/104yALndzzHdfVr33q5q+v9VncB1FHHFkXyMikLNfmGl7oIrwaxXVk3gQpx3
	 dlihTuHa9UnoQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Nov 2024 15:58:56 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 2/4] dt-bindings: remove a1 bindings from include/
Date: Tue, 12 Nov 2024 15:58:34 +0300
Message-ID: <20241112125836.3239832-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112125836.3239832-1-avromanov@salutedevices.com>
References: <20241112125836.3239832-1-avromanov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.130.77]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189114 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 09:54:00 #26847665
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2541

We have exactly the same in upstream bindings.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ------------------
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 ---
 include/dt-bindings/gpio/meson-a1-gpio.h      |  73 --------
 include/dt-bindings/power/meson-a1-power.h    |  32 ----
 .../reset/amlogic,meson-a1-reset.h            |  76 --------
 5 files changed, 374 deletions(-)
 delete mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 delete mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
 delete mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h
 delete mode 100644 include/dt-bindings/power/meson-a1-power.h
 delete mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/incl=
ude/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
deleted file mode 100644
index 06f198ee76..0000000000
--- a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
+++ /dev/null
@@ -1,168 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- * Author: Jian Hu <jian.hu@amlogic.com>
- *
- * Copyright (c) 2023, SberDevices. All Rights Reserved.
- * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
- */
-
-#ifndef __A1_PERIPHERALS_CLKC_H
-#define __A1_PERIPHERALS_CLKC_H
-
-#define CLKID_XTAL_IN		0
-#define CLKID_FIXPLL_IN		1
-#define CLKID_USB_PHY_IN	2
-#define CLKID_USB_CTRL_IN	3
-#define CLKID_HIFIPLL_IN	4
-#define CLKID_SYSPLL_IN		5
-#define CLKID_DDS_IN		6
-#define CLKID_SYS		7
-#define CLKID_CLKTREE		8
-#define CLKID_RESET_CTRL	9
-#define CLKID_ANALOG_CTRL	10
-#define CLKID_PWR_CTRL		11
-#define CLKID_PAD_CTRL		12
-#define CLKID_SYS_CTRL		13
-#define CLKID_TEMP_SENSOR	14
-#define CLKID_AM2AXI_DIV	15
-#define CLKID_SPICC_B		16
-#define CLKID_SPICC_A		17
-#define CLKID_MSR		18
-#define CLKID_AUDIO		19
-#define CLKID_JTAG_CTRL		20
-#define CLKID_SARADC_EN		21
-#define CLKID_PWM_EF		22
-#define CLKID_PWM_CD		23
-#define CLKID_PWM_AB		24
-#define CLKID_CEC		25
-#define CLKID_I2C_S		26
-#define CLKID_IR_CTRL		27
-#define CLKID_I2C_M_D		28
-#define CLKID_I2C_M_C		29
-#define CLKID_I2C_M_B		30
-#define CLKID_I2C_M_A		31
-#define CLKID_ACODEC		32
-#define CLKID_OTP		33
-#define CLKID_SD_EMMC_A		34
-#define CLKID_USB_PHY		35
-#define CLKID_USB_CTRL		36
-#define CLKID_SYS_DSPB		37
-#define CLKID_SYS_DSPA		38
-#define CLKID_DMA		39
-#define CLKID_IRQ_CTRL		40
-#define CLKID_NIC		41
-#define CLKID_GIC		42
-#define CLKID_UART_C		43
-#define CLKID_UART_B		44
-#define CLKID_UART_A		45
-#define CLKID_SYS_PSRAM		46
-#define CLKID_RSA		47
-#define CLKID_CORESIGHT		48
-#define CLKID_AM2AXI_VAD	49
-#define CLKID_AUDIO_VAD		50
-#define CLKID_AXI_DMC		51
-#define CLKID_AXI_PSRAM		52
-#define CLKID_RAMB		53
-#define CLKID_RAMA		54
-#define CLKID_AXI_SPIFC		55
-#define CLKID_AXI_NIC		56
-#define CLKID_AXI_DMA		57
-#define CLKID_CPU_CTRL		58
-#define CLKID_ROM		59
-#define CLKID_PROC_I2C		60
-#define CLKID_DSPA_SEL		61
-#define CLKID_DSPB_SEL		62
-#define CLKID_DSPA_EN		63
-#define CLKID_DSPA_EN_NIC	64
-#define CLKID_DSPB_EN		65
-#define CLKID_DSPB_EN_NIC	66
-#define CLKID_RTC		67
-#define CLKID_CECA_32K		68
-#define CLKID_CECB_32K		69
-#define CLKID_24M		70
-#define CLKID_12M		71
-#define CLKID_FCLK_DIV2_DIVN	72
-#define CLKID_GEN		73
-#define CLKID_SARADC_SEL	74
-#define CLKID_SARADC		75
-#define CLKID_PWM_A		76
-#define CLKID_PWM_B		77
-#define CLKID_PWM_C		78
-#define CLKID_PWM_D		79
-#define CLKID_PWM_E		80
-#define CLKID_PWM_F		81
-#define CLKID_SPICC		82
-#define CLKID_TS		83
-#define CLKID_SPIFC		84
-#define CLKID_USB_BUS		85
-#define CLKID_SD_EMMC		86
-#define CLKID_PSRAM		87
-#define CLKID_DMC		88
-#define CLKID_SYS_A_SEL		89
-#define CLKID_SYS_A_DIV		90
-#define CLKID_SYS_A		91
-#define CLKID_SYS_B_SEL		92
-#define CLKID_SYS_B_DIV		93
-#define CLKID_SYS_B		94
-#define CLKID_DSPA_A_SEL	95
-#define CLKID_DSPA_A_DIV	96
-#define CLKID_DSPA_A		97
-#define CLKID_DSPA_B_SEL	98
-#define CLKID_DSPA_B_DIV	99
-#define CLKID_DSPA_B		100
-#define CLKID_DSPB_A_SEL	101
-#define CLKID_DSPB_A_DIV	102
-#define CLKID_DSPB_A		103
-#define CLKID_DSPB_B_SEL	104
-#define CLKID_DSPB_B_DIV	105
-#define CLKID_DSPB_B		106
-#define CLKID_RTC_32K_IN	107
-#define CLKID_RTC_32K_DIV	108
-#define CLKID_RTC_32K_XTAL	109
-#define CLKID_RTC_32K_SEL	110
-#define CLKID_CECB_32K_IN	111
-#define CLKID_CECB_32K_DIV	112
-#define CLKID_CECB_32K_SEL_PRE	113
-#define CLKID_CECB_32K_SEL	114
-#define CLKID_CECA_32K_IN	115
-#define CLKID_CECA_32K_DIV	116
-#define CLKID_CECA_32K_SEL_PRE	117
-#define CLKID_CECA_32K_SEL	118
-#define CLKID_DIV2_PRE		119
-#define CLKID_24M_DIV2		120
-#define CLKID_GEN_SEL		121
-#define CLKID_GEN_DIV		122
-#define CLKID_SARADC_DIV	123
-#define CLKID_PWM_A_SEL		124
-#define CLKID_PWM_A_DIV		125
-#define CLKID_PWM_B_SEL		126
-#define CLKID_PWM_B_DIV		127
-#define CLKID_PWM_C_SEL		128
-#define CLKID_PWM_C_DIV		129
-#define CLKID_PWM_D_SEL		130
-#define CLKID_PWM_D_DIV		131
-#define CLKID_PWM_E_SEL		132
-#define CLKID_PWM_E_DIV		133
-#define CLKID_PWM_F_SEL		134
-#define CLKID_PWM_F_DIV		135
-#define CLKID_SPICC_SEL		136
-#define CLKID_SPICC_DIV		137
-#define CLKID_SPICC_SEL2	138
-#define CLKID_TS_DIV		139
-#define CLKID_SPIFC_SEL		140
-#define CLKID_SPIFC_DIV		141
-#define CLKID_SPIFC_SEL2	142
-#define CLKID_USB_BUS_SEL	143
-#define CLKID_USB_BUS_DIV	144
-#define CLKID_SD_EMMC_SEL	145
-#define CLKID_SD_EMMC_DIV	146
-#define CLKID_SD_EMMC_SEL2	147
-#define CLKID_PSRAM_SEL		148
-#define CLKID_PSRAM_DIV		149
-#define CLKID_PSRAM_SEL2	150
-#define CLKID_DMC_SEL		151
-#define CLKID_DMC_DIV		152
-#define CLKID_DMC_SEL2		153
-
-#endif /* __A1_PERIPHERALS_CLKC_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-b=
indings/clock/amlogic,a1-pll-clkc.h
deleted file mode 100644
index 2b660c0f2c..0000000000
--- a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- * Author: Jian Hu <jian.hu@amlogic.com>
- *
- * Copyright (c) 2023, SberDevices. All Rights Reserved.
- * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
- */
-
-#ifndef __A1_PLL_CLKC_H
-#define __A1_PLL_CLKC_H
-
-#define CLKID_FIXED_PLL_DCO	0
-#define CLKID_FIXED_PLL		1
-#define CLKID_FCLK_DIV2_DIV	2
-#define CLKID_FCLK_DIV3_DIV	3
-#define CLKID_FCLK_DIV5_DIV	4
-#define CLKID_FCLK_DIV7_DIV	5
-#define CLKID_FCLK_DIV2		6
-#define CLKID_FCLK_DIV3		7
-#define CLKID_FCLK_DIV5		8
-#define CLKID_FCLK_DIV7		9
-#define CLKID_HIFI_PLL		10
-
-#endif /* __A1_PLL_CLKC_H */
diff --git a/include/dt-bindings/gpio/meson-a1-gpio.h b/include/dt-bindings=
/gpio/meson-a1-gpio.h
deleted file mode 100644
index 40e57a5ff1..0000000000
--- a/include/dt-bindings/gpio/meson-a1-gpio.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- * Author: Qianggui Song <qianggui.song@amlogic.com>
- */
-
-#ifndef _DT_BINDINGS_MESON_A1_GPIO_H
-#define _DT_BINDINGS_MESON_A1_GPIO_H
-
-#define GPIOP_0		0
-#define GPIOP_1		1
-#define GPIOP_2		2
-#define GPIOP_3		3
-#define GPIOP_4		4
-#define GPIOP_5		5
-#define GPIOP_6		6
-#define GPIOP_7		7
-#define GPIOP_8		8
-#define GPIOP_9		9
-#define GPIOP_10	10
-#define GPIOP_11	11
-#define GPIOP_12	12
-#define GPIOB_0		13
-#define GPIOB_1		14
-#define GPIOB_2		15
-#define GPIOB_3		16
-#define GPIOB_4		17
-#define GPIOB_5		18
-#define GPIOB_6		19
-#define GPIOX_0		20
-#define GPIOX_1		21
-#define GPIOX_2		22
-#define GPIOX_3		23
-#define GPIOX_4		24
-#define GPIOX_5		25
-#define GPIOX_6		26
-#define GPIOX_7		27
-#define GPIOX_8		28
-#define GPIOX_9		29
-#define GPIOX_10	30
-#define GPIOX_11	31
-#define GPIOX_12	32
-#define GPIOX_13	33
-#define GPIOX_14	34
-#define GPIOX_15	35
-#define GPIOX_16	36
-#define GPIOF_0		37
-#define GPIOF_1		38
-#define GPIOF_2		39
-#define GPIOF_3		40
-#define GPIOF_4		41
-#define GPIOF_5		42
-#define GPIOF_6		43
-#define GPIOF_7		44
-#define GPIOF_8		45
-#define GPIOF_9		46
-#define GPIOF_10	47
-#define GPIOF_11	48
-#define GPIOF_12	49
-#define GPIOA_0		50
-#define GPIOA_1		51
-#define GPIOA_2		52
-#define GPIOA_3		53
-#define GPIOA_4		54
-#define GPIOA_5		55
-#define GPIOA_6		56
-#define GPIOA_7		57
-#define GPIOA_8		58
-#define GPIOA_9		59
-#define GPIOA_10	60
-#define GPIOA_11	61
-
-#endif /* _DT_BINDINGS_MESON_A1_GPIO_H */
diff --git a/include/dt-bindings/power/meson-a1-power.h b/include/dt-bindin=
gs/power/meson-a1-power.h
deleted file mode 100644
index 8e39dfc0b6..0000000000
--- a/include/dt-bindings/power/meson-a1-power.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
-/*
- * Copyright (c) 2023 SberDevices, Inc.
- * Author: Alexey Romanov <avromanov@sberdevices.ru>
- */
-
-#ifndef _DT_BINDINGS_MESON_A1_POWER_H
-#define _DT_BINDINGS_MESON_A1_POWER_H
-
-#define PWRC_DSPA_ID	8
-#define PWRC_DSPB_ID	9
-#define PWRC_UART_ID	10
-#define PWRC_DMC_ID	11
-#define PWRC_I2C_ID	12
-#define PWRC_PSRAM_ID	13
-#define PWRC_ACODEC_ID	14
-#define PWRC_AUDIO_ID	15
-#define PWRC_OTP_ID	16
-#define PWRC_DMA_ID	17
-#define PWRC_SD_EMMC_ID	18
-#define PWRC_RAMA_ID	19
-#define PWRC_RAMB_ID	20
-#define PWRC_IR_ID	21
-#define PWRC_SPICC_ID	22
-#define PWRC_SPIFC_ID	23
-#define PWRC_USB_ID	24
-#define PWRC_NIC_ID	25
-#define PWRC_PDMIN_ID	26
-#define PWRC_RSA_ID	27
-#define PWRC_MAX_ID	28
-
-#endif
diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/d=
t-bindings/reset/amlogic,meson-a1-reset.h
deleted file mode 100644
index 2c749c655e..0000000000
--- a/include/dt-bindings/reset/amlogic,meson-a1-reset.h
+++ /dev/null
@@ -1,76 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
- * Author: Xingyu Chen <xingyu.chen@amlogic.com>
- *
- * Copyright (c) 2023, SberDevices, Inc.
- * Author: Alexey Romanov <avromanov@salutedevices.com>
- */
-
-#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
-#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
-
-/*	RESET0					*/
-/*					0	*/
-#define RESET_AM2AXI_VAD		1
-/*					2-3	*/
-#define RESET_PSRAM			4
-#define RESET_PAD_CTRL			5
-/*					6	*/
-#define RESET_TEMP_SENSOR		7
-#define RESET_AM2AXI_DEV		8
-/*					9	*/
-#define RESET_SPICC_A			10
-#define RESET_MSR_CLK			11
-#define RESET_AUDIO			12
-#define RESET_ANALOG_CTRL		13
-#define RESET_SAR_ADC			14
-#define RESET_AUDIO_VAD			15
-#define RESET_CEC			16
-#define RESET_PWM_EF			17
-#define RESET_PWM_CD			18
-#define RESET_PWM_AB			19
-/*					20	*/
-#define RESET_IR_CTRL			21
-#define RESET_I2C_S_A			22
-/*					23	*/
-#define RESET_I2C_M_D			24
-#define RESET_I2C_M_C			25
-#define RESET_I2C_M_B			26
-#define RESET_I2C_M_A			27
-#define RESET_I2C_PROD_AHB		28
-#define RESET_I2C_PROD			29
-/*					30-31	*/
-
-/*	RESET1					*/
-#define RESET_ACODEC			32
-#define RESET_DMA			33
-#define RESET_SD_EMMC_A			34
-/*					35	*/
-#define RESET_USBCTRL			36
-/*					37	*/
-#define RESET_USBPHY			38
-/*					39-41	*/
-#define RESET_RSA			42
-#define RESET_DMC			43
-/*					44	*/
-#define RESET_IRQ_CTRL			45
-/*					46	*/
-#define RESET_NIC_VAD			47
-#define RESET_NIC_AXI			48
-#define RESET_RAMA			49
-#define RESET_RAMB			50
-/*					51-52	*/
-#define RESET_ROM			53
-#define RESET_SPIFC			54
-#define RESET_GIC			55
-#define RESET_UART_C			56
-#define RESET_UART_B			57
-#define RESET_UART_A			58
-#define RESET_OSC_RING			59
-/*					60-63	*/
-
-/*	RESET2					*/
-/*					64-95	*/
-
-#endif
--=20
2.34.1


