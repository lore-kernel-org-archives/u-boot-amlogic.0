Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC48C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 08:28:59 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.10575.1721291330530017225
 for <u-boot-amlogic@groups.io>;
 Thu, 18 Jul 2024 01:28:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=HNNjJaEA;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367963ea053so396215f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 18 Jul 2024 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721291329; x=1721896129; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43B6TO/aOb6FbW3KBWg2M6IsZUqwFA6BFIqNaxCWX3g=;
        b=HNNjJaEAyHT0qTV3eQphPt+h8CwImUbLaaqILYmggTnsCgU2XvMCdCLdTDdZKVLycY
         RHdmA1ebXlqH9oGS+iUIpdVfviuUKDgSVapk6mCQdfCFSnaJ74moUJ7BAocu09UiqC/h
         ybzgQ4k55ceOorlYzk5f58MfZjOdOLmVZfW6TngoVloeS2M0yNXrPtUd8Xg7PEq2x9J4
         dlqZC/EfoERiknxZ+0GL7XtGcNHuYal+I6SZ3ocwcUQYSTo0lZB2ab75f4QnRVU2SfFA
         KFJ0zm9UJlfEKj6u0FTKawNN/A1OA+5XW9MxKxHY0jLh5yk/tGExPzjss7l7pDdTNElH
         b7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721291329; x=1721896129;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43B6TO/aOb6FbW3KBWg2M6IsZUqwFA6BFIqNaxCWX3g=;
        b=MaRIYxZszNWZqA2U22OSJ5aNQOUvVKHGBfp6qDVkSO8Tr7UYghJrD9WA0JGKLGgmhk
         CQLjfVGdWN/z8y7N+TFL9oN+YuflkXv7c1IancP4xomRp+di/p35DfXURgSc6kNiJAdn
         HmI0/F7ZFiEYdYHYG4Ui+K8mxbup6gJPX9HLBkDWwtDvkpORiGVinSjSXUvyFFiz5KlK
         W6OUf5QQ0PKtCz2URL+xH6HZqrT/2CvfRx3Op6PhYcvgRUDIQWnS3aa2kVSENlNFsHPY
         k+mbV5OSy2pQlEvyTIHuSvWD1WBQkrb7fGGcPwOFUrZ2dZ+44h0B8E/iw/p9RKwZcS2F
         KYlg==
X-Forwarded-Encrypted: i=1; AJvYcCVn6QV6rdQ2ytQRl0w/rNueXgpwEV9uM6+Ejj2UQxN7BSice+9FdUNwjjospW7jOULYlE3BJfeOEDxS2JCoFin25vcivGSjevE=
X-Gm-Message-State: AOJu0YxjhruHWvkdMBDQkZHdlJmMlUJA3q+TGUXbD9zP9Jc6RF+Mj1mf
	ewFlZWCC7ANHcInyM5U0bgLI5oBoXpbWbZ7+5Y2pFvZM/qxkztMr/q8+q3+7BuA=
X-Google-Smtp-Source: AGHT+IGrpUaV3LGl2m3EvRE1cYXAi6CMqshKtgpzLyCm5+lYzp7Z3ZvP+XhWWIFnLXoL3JbWuPUdIg==
X-Received: by 2002:a05:6000:244:b0:367:8607:daa9 with SMTP id ffacd0b85a97d-368315fe1d3mr3308192f8f.15.1721291328270;
        Thu, 18 Jul 2024 01:28:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf416sm13495519f8f.45.2024.07.18.01.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:28:47 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 18 Jul 2024 10:28:37 +0200
Subject: [PATCH] ARM: dts: remove leftover Amlogic GX/G12 bindings headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-u-boot-fix-v6-10-upstream-build-v1-1-ebeb67ef773e@linaro.org>
X-B4-Tracking: v=1; b=H4sIADTSmGYC/x2NQQqDMBQFryJ/7YNESyq9SnGhzY9+qEYSI0LI3
 Ru6HBhmMkUOwpFeTabAl0TxewXdNvRZp31hiK1Mneoe6qkHJMzen3By4zLQCumIZ+Bpw5zka8G
 9ZaedMb2yVCtH4Or+D++xlB8vfAHZcQAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20803;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ofo9+SdbwxMZ3iBn4ZbgBURRaq49ei8ECRchqCtG7XU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmNI+NHS0/vKJL+WcrsqOldednhaAmRhcSsWZZQGU
 B152NkmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZpjSPgAKCRB33NvayMhJ0Xi4EA
 CgbORoAlV808KLrWZkKs+GpTyi11sXs/deyQdBGEX2XUcp26Wr5fIvdMDPlHGk8/JjcTd6SLYr97DB
 AXhDReitUQ+yjo4Aj5HMgSa+6nvjY1TJGWoJgK3rwEki8DInCHEWxb6dvjBECc8rPKxDZ8Ro5YPmqn
 SjkHRgDM1mVeExCab4ciswa5QvN8SAvTtXOD8cHr6jv6gxvRVBhQruEZFnYTOtrRDUJRLAsZVjr/o3
 rl2EMGWLKuNNYFZAc5dCstYWnHRFTINtyoFQvLf1kSyumRE1IMy31Pb1n18pczwvBGCDsGgGDe7Q/W
 iwd/UYfNNhbsZaHvyB068Dx4+U1ZMezH5K3aawFBMdqYyFGWxtfNIOGQ0vUckYj2qqyz7HSBOA6EqL
 G/khKNRMHewZPdB/ghlEnhZnbDcdGuHqH3R1GZfJfU96um97bf4zCrmfsc/EzjY5a4Xhnfmzpi/SdM
 QGXHuqp4ttRT27HG9gRUtXPySputJtkxssqBLWpKx4DmEklzS/YtOyAD73Oy47wOJVCzv6lRfY1+aD
 v5LoGoWObsTFhxyG7lq9h2rgpTihbfVg2wgfU/uBs+ESTSahTcQC0l39wDtaQ0MJjSbKUBdOPanzB2
 oe083RKK04sxoXdaot9ib3YdTAUQbGkhqduhNIMs/+9l8jX+ee3KnHaDNkWA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 18 Jul 2024 08:28:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2356

Remove the leftover Amlogic GX/G12 bindings headers that
maked the v6.10 upstream DT fail to build.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/clock/axg-aoclkc.h  |  31 -------
 include/dt-bindings/clock/g12a-aoclkc.h |  36 --------
 include/dt-bindings/clock/g12a-clkc.h   | 153 --------------------------------
 include/dt-bindings/clock/gxbb-aoclkc.h |  74 ---------------
 include/dt-bindings/clock/gxbb-clkc.h   | 151 -------------------------------
 include/dt-bindings/reset/axg-aoclkc.h  |  20 -----
 include/dt-bindings/reset/g12a-aoclkc.h |  18 ----
 include/dt-bindings/reset/gxbb-aoclkc.h |  66 --------------
 8 files changed, 549 deletions(-)

diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
deleted file mode 100644
index 8ec4a269c7..0000000000
--- a/include/dt-bindings/clock/axg-aoclkc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright (c) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Copyright (c) 2018 Amlogic, inc.
- * Author: Qiufang Dai <qiufang.dai@amlogic.com>
- */
-
-#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
-#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
-
-#define CLKID_AO_REMOTE		0
-#define CLKID_AO_I2C_MASTER	1
-#define CLKID_AO_I2C_SLAVE	2
-#define CLKID_AO_UART1		3
-#define CLKID_AO_UART2		4
-#define CLKID_AO_IR_BLASTER	5
-#define CLKID_AO_SAR_ADC	6
-#define CLKID_AO_CLK81		7
-#define CLKID_AO_SAR_ADC_SEL	8
-#define CLKID_AO_SAR_ADC_DIV	9
-#define CLKID_AO_SAR_ADC_CLK	10
-#define CLKID_AO_CTS_OSCIN	11
-#define CLKID_AO_32K_PRE	12
-#define CLKID_AO_32K_DIV	13
-#define CLKID_AO_32K_SEL	14
-#define CLKID_AO_32K		15
-#define CLKID_AO_CTS_RTC_OSCIN	16
-
-#endif
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
deleted file mode 100644
index e916e49ff2..0000000000
--- a/include/dt-bindings/clock/g12a-aoclkc.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright (c) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Copyright (c) 2018 Amlogic, inc.
- * Author: Qiufang Dai <qiufang.dai@amlogic.com>
- */
-
-#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
-#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
-
-#define CLKID_AO_AHB		0
-#define CLKID_AO_IR_IN		1
-#define CLKID_AO_I2C_M0		2
-#define CLKID_AO_I2C_S0		3
-#define CLKID_AO_UART		4
-#define CLKID_AO_PROD_I2C	5
-#define CLKID_AO_UART2		6
-#define CLKID_AO_IR_OUT		7
-#define CLKID_AO_SAR_ADC	8
-#define CLKID_AO_MAILBOX	9
-#define CLKID_AO_M3		10
-#define CLKID_AO_AHB_SRAM	11
-#define CLKID_AO_RTI		12
-#define CLKID_AO_M4_FCLK	13
-#define CLKID_AO_M4_HCLK	14
-#define CLKID_AO_CLK81		15
-#define CLKID_AO_SAR_ADC_SEL	16
-#define CLKID_AO_SAR_ADC_CLK	18
-#define CLKID_AO_CTS_OSCIN	19
-#define CLKID_AO_32K		23
-#define CLKID_AO_CEC		27
-#define CLKID_AO_CTS_RTC_OSCIN	28
-
-#endif
diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
deleted file mode 100644
index a93b58c5e1..0000000000
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ /dev/null
@@ -1,153 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
-/*
- * Meson-G12A clock tree IDs
- *
- * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
- */
-
-#ifndef __G12A_CLKC_H
-#define __G12A_CLKC_H
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
-#define CLKID_DOS				16
-#define CLKID_AUDIO_LOCKER			17
-#define CLKID_MIPI_DSI_HOST			18
-#define CLKID_ETH_PHY				19
-#define CLKID_ISA				20
-#define CLKID_PL301				21
-#define CLKID_PERIPHS				22
-#define CLKID_SPICC0				23
-#define CLKID_I2C				24
-#define CLKID_SANA				25
-#define CLKID_SD				26
-#define CLKID_RNG0				27
-#define CLKID_UART0				28
-#define CLKID_SPICC1				29
-#define CLKID_HIU_IFACE				30
-#define CLKID_MIPI_DSI_PHY			31
-#define CLKID_ASSIST_MISC			32
-#define CLKID_SD_EMMC_A				33
-#define CLKID_SD_EMMC_B				34
-#define CLKID_SD_EMMC_C				35
-#define CLKID_AUDIO_CODEC			36
-#define CLKID_AUDIO				37
-#define CLKID_ETH				38
-#define CLKID_DEMUX				39
-#define CLKID_AUDIO_IFIFO			40
-#define CLKID_ADC				41
-#define CLKID_UART1				42
-#define CLKID_G2D				43
-#define CLKID_RESET				44
-#define CLKID_PCIE_COMB				45
-#define CLKID_PARSER				46
-#define CLKID_USB				47
-#define CLKID_PCIE_PHY				48
-#define CLKID_AHB_ARB0				49
-#define CLKID_AHB_DATA_BUS			50
-#define CLKID_AHB_CTRL_BUS			51
-#define CLKID_HTX_HDCP22			52
-#define CLKID_HTX_PCLK				53
-#define CLKID_BT656				54
-#define CLKID_USB1_DDR_BRIDGE			55
-#define CLKID_MMC_PCLK				56
-#define CLKID_UART2				57
-#define CLKID_VPU_INTR				58
-#define CLKID_GIC				59
-#define CLKID_SD_EMMC_A_CLK0			60
-#define CLKID_SD_EMMC_B_CLK0			61
-#define CLKID_SD_EMMC_C_CLK0			62
-#define CLKID_HIFI_PLL				74
-#define CLKID_VCLK2_VENCI0			80
-#define CLKID_VCLK2_VENCI1			81
-#define CLKID_VCLK2_VENCP0			82
-#define CLKID_VCLK2_VENCP1			83
-#define CLKID_VCLK2_VENCT0			84
-#define CLKID_VCLK2_VENCT1			85
-#define CLKID_VCLK2_OTHER			86
-#define CLKID_VCLK2_ENCI			87
-#define CLKID_VCLK2_ENCP			88
-#define CLKID_DAC_CLK				89
-#define CLKID_AOCLK				90
-#define CLKID_IEC958				91
-#define CLKID_ENC480P				92
-#define CLKID_RNG1				93
-#define CLKID_VCLK2_ENCT			94
-#define CLKID_VCLK2_ENCL			95
-#define CLKID_VCLK2_VENCLMMC			96
-#define CLKID_VCLK2_VENCL			97
-#define CLKID_VCLK2_OTHER1			98
-#define CLKID_FCLK_DIV2P5			99
-#define CLKID_DMA				105
-#define CLKID_EFUSE				106
-#define CLKID_ROM_BOOT				107
-#define CLKID_RESET_SEC				108
-#define CLKID_SEC_AHB_APB3			109
-#define CLKID_VPU_0_SEL				110
-#define CLKID_VPU_0				112
-#define CLKID_VPU_1_SEL				113
-#define CLKID_VPU_1				115
-#define CLKID_VPU				116
-#define CLKID_VAPB_0_SEL			117
-#define CLKID_VAPB_0				119
-#define CLKID_VAPB_1_SEL			120
-#define CLKID_VAPB_1				122
-#define CLKID_VAPB_SEL				123
-#define CLKID_VAPB				124
-#define CLKID_HDMI_PLL				128
-#define CLKID_VID_PLL				129
-#define CLKID_VCLK				138
-#define CLKID_VCLK2				139
-#define CLKID_VCLK_DIV1				148
-#define CLKID_VCLK_DIV2				149
-#define CLKID_VCLK_DIV4				150
-#define CLKID_VCLK_DIV6				151
-#define CLKID_VCLK_DIV12			152
-#define CLKID_VCLK2_DIV1			153
-#define CLKID_VCLK2_DIV2			154
-#define CLKID_VCLK2_DIV4			155
-#define CLKID_VCLK2_DIV6			156
-#define CLKID_VCLK2_DIV12			157
-#define CLKID_CTS_ENCI				162
-#define CLKID_CTS_ENCP				163
-#define CLKID_CTS_VDAC				164
-#define CLKID_HDMI_TX				165
-#define CLKID_HDMI				168
-#define CLKID_MALI_0_SEL			169
-#define CLKID_MALI_0				171
-#define CLKID_MALI_1_SEL			172
-#define CLKID_MALI_1				174
-#define CLKID_MALI				175
-#define CLKID_MPLL_50M				177
-#define CLKID_CPU_CLK				187
-#define CLKID_PCIE_PLL				201
-#define CLKID_VDEC_1				204
-#define CLKID_VDEC_HEVC				207
-#define CLKID_VDEC_HEVCF			210
-#define CLKID_TS				212
-#define CLKID_CPUB_CLK				224
-#define CLKID_GP1_PLL				243
-#define CLKID_DSU_CLK				252
-#define CLKID_CPU1_CLK				253
-#define CLKID_CPU2_CLK				254
-#define CLKID_CPU3_CLK				255
-#define CLKID_SPICC0_SCLK			258
-#define CLKID_SPICC1_SCLK			261
-#define CLKID_NNA_AXI_CLK			264
-#define CLKID_NNA_CORE_CLK			267
-#define CLKID_MIPI_DSI_PXCLK_SEL		269
-#define CLKID_MIPI_DSI_PXCLK			270
-
-#endif /* __G12A_CLKC_H */
diff --git a/include/dt-bindings/clock/gxbb-aoclkc.h b/include/dt-bindings/clock/gxbb-aoclkc.h
deleted file mode 100644
index ec3b26319f..0000000000
--- a/include/dt-bindings/clock/gxbb-aoclkc.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
- *
- * BSD LICENSE
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_GXBB_AOCLK
-#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_GXBB_AOCLK
-
-#define CLKID_AO_REMOTE		0
-#define CLKID_AO_I2C_MASTER	1
-#define CLKID_AO_I2C_SLAVE	2
-#define CLKID_AO_UART1		3
-#define CLKID_AO_UART2		4
-#define CLKID_AO_IR_BLASTER	5
-#define CLKID_AO_CEC_32K	6
-#define CLKID_AO_CTS_OSCIN	7
-#define CLKID_AO_32K_PRE	8
-#define CLKID_AO_32K_DIV	9
-#define CLKID_AO_32K_SEL	10
-#define CLKID_AO_32K		11
-#define CLKID_AO_CTS_RTC_OSCIN	12
-#define CLKID_AO_CLK81		13
-
-#endif
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
deleted file mode 100644
index 4073eb7a9d..0000000000
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ /dev/null
@@ -1,151 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * GXBB clock tree IDs
- */
-
-#ifndef __GXBB_CLKC_H
-#define __GXBB_CLKC_H
-
-#define CLKID_SYS_PLL		0
-#define CLKID_HDMI_PLL		2
-#define CLKID_FIXED_PLL		3
-#define CLKID_FCLK_DIV2		4
-#define CLKID_FCLK_DIV3		5
-#define CLKID_FCLK_DIV4		6
-#define CLKID_FCLK_DIV5		7
-#define CLKID_FCLK_DIV7		8
-#define CLKID_GP0_PLL		9
-#define CLKID_CLK81		12
-#define CLKID_MPLL0		13
-#define CLKID_MPLL1		14
-#define CLKID_MPLL2		15
-#define CLKID_DDR		16
-#define CLKID_DOS		17
-#define CLKID_ISA		18
-#define CLKID_PL301		19
-#define CLKID_PERIPHS		20
-#define CLKID_SPICC		21
-#define CLKID_I2C		22
-#define CLKID_SAR_ADC		23
-#define CLKID_SMART_CARD	24
-#define CLKID_RNG0		25
-#define CLKID_UART0		26
-#define CLKID_SDHC		27
-#define CLKID_STREAM		28
-#define CLKID_ASYNC_FIFO	29
-#define CLKID_SDIO		30
-#define CLKID_ABUF		31
-#define CLKID_HIU_IFACE		32
-#define CLKID_ASSIST_MISC	33
-#define CLKID_SPI		34
-#define CLKID_ETH		36
-#define CLKID_I2S_SPDIF		35
-#define CLKID_DEMUX		37
-#define CLKID_AIU_GLUE		38
-#define CLKID_IEC958		39
-#define CLKID_I2S_OUT		40
-#define CLKID_AMCLK		41
-#define CLKID_AIFIFO2		42
-#define CLKID_MIXER		43
-#define CLKID_MIXER_IFACE	44
-#define CLKID_ADC		45
-#define CLKID_BLKMV		46
-#define CLKID_AIU		47
-#define CLKID_UART1		48
-#define CLKID_G2D		49
-#define CLKID_USB0		50
-#define CLKID_USB1		51
-#define CLKID_RESET		52
-#define CLKID_NAND		53
-#define CLKID_DOS_PARSER	54
-#define CLKID_USB		55
-#define CLKID_VDIN1		56
-#define CLKID_AHB_ARB0		57
-#define CLKID_EFUSE		58
-#define CLKID_BOOT_ROM		59
-#define CLKID_AHB_DATA_BUS	60
-#define CLKID_AHB_CTRL_BUS	61
-#define CLKID_HDMI_INTR_SYNC	62
-#define CLKID_HDMI_PCLK		63
-#define CLKID_USB1_DDR_BRIDGE	64
-#define CLKID_USB0_DDR_BRIDGE	65
-#define CLKID_MMC_PCLK		66
-#define CLKID_DVIN		67
-#define CLKID_UART2		68
-#define CLKID_SANA		69
-#define CLKID_VPU_INTR		70
-#define CLKID_SEC_AHB_AHB3_BRIDGE 71
-#define CLKID_CLK81_A53		72
-#define CLKID_VCLK2_VENCI0	73
-#define CLKID_VCLK2_VENCI1	74
-#define CLKID_VCLK2_VENCP0	75
-#define CLKID_VCLK2_VENCP1	76
-#define CLKID_GCLK_VENCI_INT0	77
-#define CLKID_GCLK_VENCI_INT	78
-#define CLKID_DAC_CLK		79
-#define CLKID_AOCLK_GATE	80
-#define CLKID_IEC958_GATE	81
-#define CLKID_ENC480P		82
-#define CLKID_RNG1		83
-#define CLKID_GCLK_VENCI_INT1	84
-#define CLKID_VCLK2_VENCLMCC	85
-#define CLKID_VCLK2_VENCL	86
-#define CLKID_VCLK_OTHER	87
-#define CLKID_EDP		88
-#define CLKID_AO_MEDIA_CPU	89
-#define CLKID_AO_AHB_SRAM	90
-#define CLKID_AO_AHB_BUS	91
-#define CLKID_AO_IFACE		92
-#define CLKID_AO_I2C		93
-#define CLKID_SD_EMMC_A		94
-#define CLKID_SD_EMMC_B		95
-#define CLKID_SD_EMMC_C		96
-#define CLKID_SAR_ADC_CLK	97
-#define CLKID_SAR_ADC_SEL	98
-#define CLKID_MALI_0_SEL	100
-#define CLKID_MALI_0		102
-#define CLKID_MALI_1_SEL	103
-#define CLKID_MALI_1		105
-#define CLKID_MALI		106
-#define CLKID_CTS_AMCLK		107
-#define CLKID_CTS_MCLK_I958	110
-#define CLKID_CTS_I958		113
-#define CLKID_32K_CLK		114
-#define CLKID_SD_EMMC_A_CLK0	119
-#define CLKID_SD_EMMC_B_CLK0	122
-#define CLKID_SD_EMMC_C_CLK0	125
-#define CLKID_VPU_0_SEL		126
-#define CLKID_VPU_0		128
-#define CLKID_VPU_1_SEL		129
-#define CLKID_VPU_1		131
-#define CLKID_VPU		132
-#define CLKID_VAPB_0_SEL	133
-#define CLKID_VAPB_0		135
-#define CLKID_VAPB_1_SEL	136
-#define CLKID_VAPB_1		138
-#define CLKID_VAPB_SEL		139
-#define CLKID_VAPB		140
-#define CLKID_VDEC_1		153
-#define CLKID_VDEC_HEVC		156
-#define CLKID_GEN_CLK		159
-#define CLKID_VID_PLL		166
-#define CLKID_VCLK		175
-#define CLKID_VCLK2		176
-#define CLKID_VCLK_DIV1		185
-#define CLKID_VCLK_DIV2		186
-#define CLKID_VCLK_DIV4		187
-#define CLKID_VCLK_DIV6		188
-#define CLKID_VCLK_DIV12	189
-#define CLKID_VCLK2_DIV1	190
-#define CLKID_VCLK2_DIV2	191
-#define CLKID_VCLK2_DIV4	192
-#define CLKID_VCLK2_DIV6	193
-#define CLKID_VCLK2_DIV12	194
-#define CLKID_CTS_ENCI		199
-#define CLKID_CTS_ENCP		200
-#define CLKID_CTS_VDAC		201
-#define CLKID_HDMI_TX		202
-#define CLKID_HDMI		205
-#define CLKID_ACODEC		206
-
-#endif /* __GXBB_CLKC_H */
diff --git a/include/dt-bindings/reset/axg-aoclkc.h b/include/dt-bindings/reset/axg-aoclkc.h
deleted file mode 100644
index d342c0b6b2..0000000000
--- a/include/dt-bindings/reset/axg-aoclkc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright (c) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Copyright (c) 2018 Amlogic, inc.
- * Author: Qiufang Dai <qiufang.dai@amlogic.com>
- */
-
-#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
-#define DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
-
-#define RESET_AO_REMOTE		0
-#define RESET_AO_I2C_MASTER	1
-#define RESET_AO_I2C_SLAVE	2
-#define RESET_AO_UART1		3
-#define RESET_AO_UART2		4
-#define RESET_AO_IR_BLASTER	5
-
-#endif
diff --git a/include/dt-bindings/reset/g12a-aoclkc.h b/include/dt-bindings/reset/g12a-aoclkc.h
deleted file mode 100644
index bd2e233713..0000000000
--- a/include/dt-bindings/reset/g12a-aoclkc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright (c) 2016 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
-#define DT_BINDINGS_RESET_AMLOGIC_MESON_G12A_AOCLK
-
-#define RESET_AO_IR_IN		0
-#define RESET_AO_UART		1
-#define RESET_AO_I2C_M		2
-#define RESET_AO_I2C_S		3
-#define RESET_AO_SAR_ADC	4
-#define RESET_AO_UART2		5
-#define RESET_AO_IR_OUT		6
-
-#endif
diff --git a/include/dt-bindings/reset/gxbb-aoclkc.h b/include/dt-bindings/reset/gxbb-aoclkc.h
deleted file mode 100644
index 9e3fd60c30..0000000000
--- a/include/dt-bindings/reset/gxbb-aoclkc.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
- *
- * BSD LICENSE
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_GXBB_AOCLK
-#define DT_BINDINGS_RESET_AMLOGIC_MESON_GXBB_AOCLK
-
-#define RESET_AO_REMOTE		0
-#define RESET_AO_I2C_MASTER	1
-#define RESET_AO_I2C_SLAVE	2
-#define RESET_AO_UART1		3
-#define RESET_AO_UART2		4
-#define RESET_AO_IR_BLASTER	5
-
-#endif

---
base-commit: cb88250f74b3850fdba4163ec260dbcee8ec183a
change-id: 20240718-u-boot-fix-v6-10-upstream-build-e3def1f6630d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


