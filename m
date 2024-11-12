Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72988D42B97
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.85896.1731416338949245501
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Nov 2024 04:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=dXZw9QFi;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avromanov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6C716100012;
	Tue, 12 Nov 2024 15:58:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6C716100012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731416337;
	bh=BRDQxhNx5o2QumS73a4TlVBLksIfcboeioSGkHWZdYo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dXZw9QFiqz1FeBBkTKCTpNw5CP+qvqdvDx2UUhia4IfBOI2BqegdLgVFwb3GemjWN
	 YBuD7EucMnb/glgiIOOyuXLC2jpVNPMd/s2/e4xZg6NO1jYm1oByciBdvh0Xi6JBgy
	 MMXHGvQMm23a+wFggz5q0GhSqX1Hru81DlxiAkQyvqspZ3wksoWnhfZie6oRYFPgrW
	 X/OdHtQ2MYdm6xX0FSd0MlkLxqnAEr/dMeHm1Z8CcLyYIDCHHYqYowS5iTki6gf8NN
	 noPPpx7mxj4ReaHWEnm8NrII4/q/IID3BSwdtkFcikIPgjuscBxk8emmEUS4+b6JO4
	 m/J45jROh3Bgw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 12 Nov 2024 15:58:57 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <trini@konsulko.com>, <neil.armstrong@linaro.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
	<kernel@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 3/4] dt-bindings: remove axg bindings from include/
Date: Tue, 12 Nov 2024 15:58:35 +0300
Message-ID: <20241112125836.3239832-4-avromanov@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2544

We have exactly the same in upstream bindings.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 include/dt-bindings/clock/axg-audio-clkc.h |  94 -------------------
 include/dt-bindings/clock/axg-clkc.h       | 100 ---------------------
 2 files changed, 194 deletions(-)
 delete mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
 delete mode 100644 include/dt-bindings/clock/axg-clkc.h

diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindin=
gs/clock/axg-audio-clkc.h
deleted file mode 100644
index f561f5c5ef..0000000000
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- * Copyright (c) 2018 Baylibre SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __AXG_AUDIO_CLKC_BINDINGS_H
-#define __AXG_AUDIO_CLKC_BINDINGS_H
-
-#define AUD_CLKID_DDR_ARB		29
-#define AUD_CLKID_PDM			30
-#define AUD_CLKID_TDMIN_A		31
-#define AUD_CLKID_TDMIN_B		32
-#define AUD_CLKID_TDMIN_C		33
-#define AUD_CLKID_TDMIN_LB		34
-#define AUD_CLKID_TDMOUT_A		35
-#define AUD_CLKID_TDMOUT_B		36
-#define AUD_CLKID_TDMOUT_C		37
-#define AUD_CLKID_FRDDR_A		38
-#define AUD_CLKID_FRDDR_B		39
-#define AUD_CLKID_FRDDR_C		40
-#define AUD_CLKID_TODDR_A		41
-#define AUD_CLKID_TODDR_B		42
-#define AUD_CLKID_TODDR_C		43
-#define AUD_CLKID_LOOPBACK		44
-#define AUD_CLKID_SPDIFIN		45
-#define AUD_CLKID_SPDIFOUT		46
-#define AUD_CLKID_RESAMPLE		47
-#define AUD_CLKID_POWER_DETECT		48
-#define AUD_CLKID_MST_A_MCLK		49
-#define AUD_CLKID_MST_B_MCLK		50
-#define AUD_CLKID_MST_C_MCLK		51
-#define AUD_CLKID_MST_D_MCLK		52
-#define AUD_CLKID_MST_E_MCLK		53
-#define AUD_CLKID_MST_F_MCLK		54
-#define AUD_CLKID_SPDIFOUT_CLK		55
-#define AUD_CLKID_SPDIFIN_CLK		56
-#define AUD_CLKID_PDM_DCLK		57
-#define AUD_CLKID_PDM_SYSCLK		58
-#define AUD_CLKID_MST_A_SCLK		79
-#define AUD_CLKID_MST_B_SCLK		80
-#define AUD_CLKID_MST_C_SCLK		81
-#define AUD_CLKID_MST_D_SCLK		82
-#define AUD_CLKID_MST_E_SCLK		83
-#define AUD_CLKID_MST_F_SCLK		84
-#define AUD_CLKID_MST_A_LRCLK		86
-#define AUD_CLKID_MST_B_LRCLK		87
-#define AUD_CLKID_MST_C_LRCLK		88
-#define AUD_CLKID_MST_D_LRCLK		89
-#define AUD_CLKID_MST_E_LRCLK		90
-#define AUD_CLKID_MST_F_LRCLK		91
-#define AUD_CLKID_TDMIN_A_SCLK_SEL	116
-#define AUD_CLKID_TDMIN_B_SCLK_SEL	117
-#define AUD_CLKID_TDMIN_C_SCLK_SEL	118
-#define AUD_CLKID_TDMIN_LB_SCLK_SEL	119
-#define AUD_CLKID_TDMOUT_A_SCLK_SEL	120
-#define AUD_CLKID_TDMOUT_B_SCLK_SEL	121
-#define AUD_CLKID_TDMOUT_C_SCLK_SEL	122
-#define AUD_CLKID_TDMIN_A_SCLK		123
-#define AUD_CLKID_TDMIN_B_SCLK		124
-#define AUD_CLKID_TDMIN_C_SCLK		125
-#define AUD_CLKID_TDMIN_LB_SCLK		126
-#define AUD_CLKID_TDMOUT_A_SCLK		127
-#define AUD_CLKID_TDMOUT_B_SCLK		128
-#define AUD_CLKID_TDMOUT_C_SCLK		129
-#define AUD_CLKID_TDMIN_A_LRCLK		130
-#define AUD_CLKID_TDMIN_B_LRCLK		131
-#define AUD_CLKID_TDMIN_C_LRCLK		132
-#define AUD_CLKID_TDMIN_LB_LRCLK	133
-#define AUD_CLKID_TDMOUT_A_LRCLK	134
-#define AUD_CLKID_TDMOUT_B_LRCLK	135
-#define AUD_CLKID_TDMOUT_C_LRCLK	136
-#define AUD_CLKID_SPDIFOUT_B		151
-#define AUD_CLKID_SPDIFOUT_B_CLK	152
-#define AUD_CLKID_TDM_MCLK_PAD0		155
-#define AUD_CLKID_TDM_MCLK_PAD1		156
-#define AUD_CLKID_TDM_LRCLK_PAD0	157
-#define AUD_CLKID_TDM_LRCLK_PAD1	158
-#define AUD_CLKID_TDM_LRCLK_PAD2	159
-#define AUD_CLKID_TDM_SCLK_PAD0		160
-#define AUD_CLKID_TDM_SCLK_PAD1		161
-#define AUD_CLKID_TDM_SCLK_PAD2		162
-#define AUD_CLKID_TOP			163
-#define AUD_CLKID_TORAM			164
-#define AUD_CLKID_EQDRC			165
-#define AUD_CLKID_RESAMPLE_B		166
-#define AUD_CLKID_TOVAD			167
-#define AUD_CLKID_LOCKER		168
-#define AUD_CLKID_SPDIFIN_LB		169
-#define AUD_CLKID_FRDDR_D		170
-#define AUD_CLKID_TODDR_D		171
-#define AUD_CLKID_LOOPBACK_B		172
-
-#endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
diff --git a/include/dt-bindings/clock/axg-clkc.h b/include/dt-bindings/clo=
ck/axg-clkc.h
deleted file mode 100644
index 93752ea107..0000000000
--- a/include/dt-bindings/clock/axg-clkc.h
+++ /dev/null
@@ -1,100 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
-/*
- * Meson-AXG clock tree IDs
- *
- * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
- */
-
-#ifndef __AXG_CLKC_H
-#define __AXG_CLKC_H
-
-#define CLKID_SYS_PLL				0
-#define CLKID_FIXED_PLL				1
-#define CLKID_FCLK_DIV2				2
-#define CLKID_FCLK_DIV3				3
-#define CLKID_FCLK_DIV4				4
-#define CLKID_FCLK_DIV5				5
-#define CLKID_FCLK_DIV7				6
-#define CLKID_GP0_PLL				7
-#define CLKID_CLK81				10
-#define CLKID_MPLL0				11
-#define CLKID_MPLL1				12
-#define CLKID_MPLL2				13
-#define CLKID_MPLL3				14
-#define CLKID_DDR				15
-#define CLKID_AUDIO_LOCKER			16
-#define CLKID_MIPI_DSI_HOST			17
-#define CLKID_ISA				18
-#define CLKID_PL301				19
-#define CLKID_PERIPHS				20
-#define CLKID_SPICC0				21
-#define CLKID_I2C				22
-#define CLKID_RNG0				23
-#define CLKID_UART0				24
-#define CLKID_MIPI_DSI_PHY			25
-#define CLKID_SPICC1				26
-#define CLKID_PCIE_A				27
-#define CLKID_PCIE_B				28
-#define CLKID_HIU_IFACE				29
-#define CLKID_ASSIST_MISC			30
-#define CLKID_SD_EMMC_B				31
-#define CLKID_SD_EMMC_C				32
-#define CLKID_DMA				33
-#define CLKID_SPI				34
-#define CLKID_AUDIO				35
-#define CLKID_ETH				36
-#define CLKID_UART1				37
-#define CLKID_G2D				38
-#define CLKID_USB0				39
-#define CLKID_USB1				40
-#define CLKID_RESET				41
-#define CLKID_USB				42
-#define CLKID_AHB_ARB0				43
-#define CLKID_EFUSE				44
-#define CLKID_BOOT_ROM				45
-#define CLKID_AHB_DATA_BUS			46
-#define CLKID_AHB_CTRL_BUS			47
-#define CLKID_USB1_DDR_BRIDGE			48
-#define CLKID_USB0_DDR_BRIDGE			49
-#define CLKID_MMC_PCLK				50
-#define CLKID_VPU_INTR				51
-#define CLKID_SEC_AHB_AHB3_BRIDGE		52
-#define CLKID_GIC				53
-#define CLKID_AO_MEDIA_CPU			54
-#define CLKID_AO_AHB_SRAM			55
-#define CLKID_AO_AHB_BUS			56
-#define CLKID_AO_IFACE				57
-#define CLKID_AO_I2C				58
-#define CLKID_SD_EMMC_B_CLK0			59
-#define CLKID_SD_EMMC_C_CLK0			60
-#define CLKID_HIFI_PLL				69
-#define CLKID_PCIE_CML_EN0			79
-#define CLKID_PCIE_CML_EN1			80
-#define CLKID_GEN_CLK				84
-#define CLKID_VPU_0_SEL				92
-#define CLKID_VPU_0				93
-#define CLKID_VPU_1_SEL				95
-#define CLKID_VPU_1				96
-#define CLKID_VPU				97
-#define CLKID_VAPB_0_SEL			99
-#define CLKID_VAPB_0				100
-#define CLKID_VAPB_1_SEL			102
-#define CLKID_VAPB_1				103
-#define CLKID_VAPB_SEL				104
-#define CLKID_VAPB				105
-#define CLKID_VCLK				106
-#define CLKID_VCLK2				107
-#define CLKID_VCLK_DIV1				122
-#define CLKID_VCLK_DIV2				123
-#define CLKID_VCLK_DIV4				124
-#define CLKID_VCLK_DIV6				125
-#define CLKID_VCLK_DIV12			126
-#define CLKID_VCLK2_DIV1			127
-#define CLKID_VCLK2_DIV2			128
-#define CLKID_VCLK2_DIV4			129
-#define CLKID_VCLK2_DIV6			130
-#define CLKID_VCLK2_DIV12			131
-#define CLKID_CTS_ENCL				133
-#define CLKID_VDIN_MEAS				136
-
-#endif /* __AXG_CLKC_H */
--=20
2.34.1


