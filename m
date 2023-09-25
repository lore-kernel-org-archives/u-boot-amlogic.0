Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.64506.1695657150019500874
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Sep 2023 08:52:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D689E12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1695657146;
	bh=P5sLefxkAxzz+U5yDD3RLskh7gFgspahP9dsymu8dNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Nwbz0PL2c8wF/7zr9p5azhhKIbQUT00AkZHe1qzfpYWRkqY/DAEeV+Ox9oGKGMCRJ
	 JWso1v00848waVol5URO/wZHUuTQbWJd97TOWjizw8dmQV2DcgcM69pqEMdxLduwqO
	 4CGTH4heLrYmbvoIDQrO0l4EYJ+pSv7XAu0hvYQ8Owd3KzmJMJPpOmbVXfUFMdbMeo
	 aG3N2weZm9l9n/SLh8Hze1EMk7Qof5nFNhbljVk0tKWyhnEZNW80nEJAy4IF9SrTP8
	 RiWVTFmLaMffL7iaPd++ZQ+M9gQswhigOM2PHa+Dq83O3LFmrVJRYxENKnn37DV25J
	 hEAwaOKwe2g1A==
From: "Igor Prusov" <ivprusov@salutedevices.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: Add Amlogic A1 clock bindings
Date: Mon, 25 Sep 2023 18:52:08 +0300
Message-ID: <20230925155209.130671-2-ivprusov@salutedevices.com>
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Add clock bindings for Amlogic A1 from linux-next next-20230821.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++++++++++++++++
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +++
 2 files changed, 193 insertions(+)
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/incl=
ude/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
new file mode 100644
index 0000000000..06f198ee76
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PERIPHERALS_CLKC_H
+#define __A1_PERIPHERALS_CLKC_H
+
+#define CLKID_XTAL_IN		0
+#define CLKID_FIXPLL_IN		1
+#define CLKID_USB_PHY_IN	2
+#define CLKID_USB_CTRL_IN	3
+#define CLKID_HIFIPLL_IN	4
+#define CLKID_SYSPLL_IN		5
+#define CLKID_DDS_IN		6
+#define CLKID_SYS		7
+#define CLKID_CLKTREE		8
+#define CLKID_RESET_CTRL	9
+#define CLKID_ANALOG_CTRL	10
+#define CLKID_PWR_CTRL		11
+#define CLKID_PAD_CTRL		12
+#define CLKID_SYS_CTRL		13
+#define CLKID_TEMP_SENSOR	14
+#define CLKID_AM2AXI_DIV	15
+#define CLKID_SPICC_B		16
+#define CLKID_SPICC_A		17
+#define CLKID_MSR		18
+#define CLKID_AUDIO		19
+#define CLKID_JTAG_CTRL		20
+#define CLKID_SARADC_EN		21
+#define CLKID_PWM_EF		22
+#define CLKID_PWM_CD		23
+#define CLKID_PWM_AB		24
+#define CLKID_CEC		25
+#define CLKID_I2C_S		26
+#define CLKID_IR_CTRL		27
+#define CLKID_I2C_M_D		28
+#define CLKID_I2C_M_C		29
+#define CLKID_I2C_M_B		30
+#define CLKID_I2C_M_A		31
+#define CLKID_ACODEC		32
+#define CLKID_OTP		33
+#define CLKID_SD_EMMC_A		34
+#define CLKID_USB_PHY		35
+#define CLKID_USB_CTRL		36
+#define CLKID_SYS_DSPB		37
+#define CLKID_SYS_DSPA		38
+#define CLKID_DMA		39
+#define CLKID_IRQ_CTRL		40
+#define CLKID_NIC		41
+#define CLKID_GIC		42
+#define CLKID_UART_C		43
+#define CLKID_UART_B		44
+#define CLKID_UART_A		45
+#define CLKID_SYS_PSRAM		46
+#define CLKID_RSA		47
+#define CLKID_CORESIGHT		48
+#define CLKID_AM2AXI_VAD	49
+#define CLKID_AUDIO_VAD		50
+#define CLKID_AXI_DMC		51
+#define CLKID_AXI_PSRAM		52
+#define CLKID_RAMB		53
+#define CLKID_RAMA		54
+#define CLKID_AXI_SPIFC		55
+#define CLKID_AXI_NIC		56
+#define CLKID_AXI_DMA		57
+#define CLKID_CPU_CTRL		58
+#define CLKID_ROM		59
+#define CLKID_PROC_I2C		60
+#define CLKID_DSPA_SEL		61
+#define CLKID_DSPB_SEL		62
+#define CLKID_DSPA_EN		63
+#define CLKID_DSPA_EN_NIC	64
+#define CLKID_DSPB_EN		65
+#define CLKID_DSPB_EN_NIC	66
+#define CLKID_RTC		67
+#define CLKID_CECA_32K		68
+#define CLKID_CECB_32K		69
+#define CLKID_24M		70
+#define CLKID_12M		71
+#define CLKID_FCLK_DIV2_DIVN	72
+#define CLKID_GEN		73
+#define CLKID_SARADC_SEL	74
+#define CLKID_SARADC		75
+#define CLKID_PWM_A		76
+#define CLKID_PWM_B		77
+#define CLKID_PWM_C		78
+#define CLKID_PWM_D		79
+#define CLKID_PWM_E		80
+#define CLKID_PWM_F		81
+#define CLKID_SPICC		82
+#define CLKID_TS		83
+#define CLKID_SPIFC		84
+#define CLKID_USB_BUS		85
+#define CLKID_SD_EMMC		86
+#define CLKID_PSRAM		87
+#define CLKID_DMC		88
+#define CLKID_SYS_A_SEL		89
+#define CLKID_SYS_A_DIV		90
+#define CLKID_SYS_A		91
+#define CLKID_SYS_B_SEL		92
+#define CLKID_SYS_B_DIV		93
+#define CLKID_SYS_B		94
+#define CLKID_DSPA_A_SEL	95
+#define CLKID_DSPA_A_DIV	96
+#define CLKID_DSPA_A		97
+#define CLKID_DSPA_B_SEL	98
+#define CLKID_DSPA_B_DIV	99
+#define CLKID_DSPA_B		100
+#define CLKID_DSPB_A_SEL	101
+#define CLKID_DSPB_A_DIV	102
+#define CLKID_DSPB_A		103
+#define CLKID_DSPB_B_SEL	104
+#define CLKID_DSPB_B_DIV	105
+#define CLKID_DSPB_B		106
+#define CLKID_RTC_32K_IN	107
+#define CLKID_RTC_32K_DIV	108
+#define CLKID_RTC_32K_XTAL	109
+#define CLKID_RTC_32K_SEL	110
+#define CLKID_CECB_32K_IN	111
+#define CLKID_CECB_32K_DIV	112
+#define CLKID_CECB_32K_SEL_PRE	113
+#define CLKID_CECB_32K_SEL	114
+#define CLKID_CECA_32K_IN	115
+#define CLKID_CECA_32K_DIV	116
+#define CLKID_CECA_32K_SEL_PRE	117
+#define CLKID_CECA_32K_SEL	118
+#define CLKID_DIV2_PRE		119
+#define CLKID_24M_DIV2		120
+#define CLKID_GEN_SEL		121
+#define CLKID_GEN_DIV		122
+#define CLKID_SARADC_DIV	123
+#define CLKID_PWM_A_SEL		124
+#define CLKID_PWM_A_DIV		125
+#define CLKID_PWM_B_SEL		126
+#define CLKID_PWM_B_DIV		127
+#define CLKID_PWM_C_SEL		128
+#define CLKID_PWM_C_DIV		129
+#define CLKID_PWM_D_SEL		130
+#define CLKID_PWM_D_DIV		131
+#define CLKID_PWM_E_SEL		132
+#define CLKID_PWM_E_DIV		133
+#define CLKID_PWM_F_SEL		134
+#define CLKID_PWM_F_DIV		135
+#define CLKID_SPICC_SEL		136
+#define CLKID_SPICC_DIV		137
+#define CLKID_SPICC_SEL2	138
+#define CLKID_TS_DIV		139
+#define CLKID_SPIFC_SEL		140
+#define CLKID_SPIFC_DIV		141
+#define CLKID_SPIFC_SEL2	142
+#define CLKID_USB_BUS_SEL	143
+#define CLKID_USB_BUS_DIV	144
+#define CLKID_SD_EMMC_SEL	145
+#define CLKID_SD_EMMC_DIV	146
+#define CLKID_SD_EMMC_SEL2	147
+#define CLKID_PSRAM_SEL		148
+#define CLKID_PSRAM_DIV		149
+#define CLKID_PSRAM_SEL2	150
+#define CLKID_DMC_SEL		151
+#define CLKID_DMC_DIV		152
+#define CLKID_DMC_SEL2		153
+
+#endif /* __A1_PERIPHERALS_CLKC_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-pll-clkc.h b/include/dt-b=
indings/clock/amlogic,a1-pll-clkc.h
new file mode 100644
index 0000000000..2b660c0f2c
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a1-pll-clkc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Jian Hu <jian.hu@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
+ */
+
+#ifndef __A1_PLL_CLKC_H
+#define __A1_PLL_CLKC_H
+
+#define CLKID_FIXED_PLL_DCO	0
+#define CLKID_FIXED_PLL		1
+#define CLKID_FCLK_DIV2_DIV	2
+#define CLKID_FCLK_DIV3_DIV	3
+#define CLKID_FCLK_DIV5_DIV	4
+#define CLKID_FCLK_DIV7_DIV	5
+#define CLKID_FCLK_DIV2		6
+#define CLKID_FCLK_DIV3		7
+#define CLKID_FCLK_DIV5		8
+#define CLKID_FCLK_DIV7		9
+#define CLKID_HIFI_PLL		10
+
+#endif /* __A1_PLL_CLKC_H */
--=20
2.34.1

