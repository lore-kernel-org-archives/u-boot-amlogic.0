Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.11083.1696496091671018800
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6EE64100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496087;
	bh=AhyjZRwsFsTWqTQTltLkGCSO8YdEOeSdhmHxjovN03U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=f5q3Ikz5Z+ju4KdGcxnM57CDe6FNgJxgsIUZMJQPK3jtngrexYUTi5MKSxHQ0EEe6
	 bivoaO14emwG28PaDvE6Xdtl2h+fkV3lWdcnncQyN+xZKiFtP+MsHiJMH1QncoLAh8
	 g0QtChLIyjvf7tFv67EHj9j+Zbu7Me9hk2UqZBgTEuu45GsjFyO0VRwALP/U2T4OGU
	 RhI1tpiAQVA18CaExz2pS3xj5PARmD9LKT+Ay41GogvSq5zJLNgj4ROzjVkOjDduRF
	 qEMIOsHJEwtSWuMkGgfBQaWqRbHIF+Bi4aK7CGAiIW/EsTkkLhdQ/Pi5rbf3BwOUi4
	 ehrrp4Wwkchag==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 1/8] dt-bindings: reset: add Meson A1 reset bindings
Date: Thu, 5 Oct 2023 11:54:22 +0300
Message-ID: <20231005085434.74755-2-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Get this from Linux 6.6-rc3.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../reset/amlogic,meson-a1-reset.h            | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/d=
t-bindings/reset/amlogic,meson-a1-reset.h
new file mode 100644
index 0000000000..2c749c655e
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ *
+ * Copyright (c) 2023, SberDevices, Inc.
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
+
+/*	RESET0					*/
+/*					0	*/
+#define RESET_AM2AXI_VAD		1
+/*					2-3	*/
+#define RESET_PSRAM			4
+#define RESET_PAD_CTRL			5
+/*					6	*/
+#define RESET_TEMP_SENSOR		7
+#define RESET_AM2AXI_DEV		8
+/*					9	*/
+#define RESET_SPICC_A			10
+#define RESET_MSR_CLK			11
+#define RESET_AUDIO			12
+#define RESET_ANALOG_CTRL		13
+#define RESET_SAR_ADC			14
+#define RESET_AUDIO_VAD			15
+#define RESET_CEC			16
+#define RESET_PWM_EF			17
+#define RESET_PWM_CD			18
+#define RESET_PWM_AB			19
+/*					20	*/
+#define RESET_IR_CTRL			21
+#define RESET_I2C_S_A			22
+/*					23	*/
+#define RESET_I2C_M_D			24
+#define RESET_I2C_M_C			25
+#define RESET_I2C_M_B			26
+#define RESET_I2C_M_A			27
+#define RESET_I2C_PROD_AHB		28
+#define RESET_I2C_PROD			29
+/*					30-31	*/
+
+/*	RESET1					*/
+#define RESET_ACODEC			32
+#define RESET_DMA			33
+#define RESET_SD_EMMC_A			34
+/*					35	*/
+#define RESET_USBCTRL			36
+/*					37	*/
+#define RESET_USBPHY			38
+/*					39-41	*/
+#define RESET_RSA			42
+#define RESET_DMC			43
+/*					44	*/
+#define RESET_IRQ_CTRL			45
+/*					46	*/
+#define RESET_NIC_VAD			47
+#define RESET_NIC_AXI			48
+#define RESET_RAMA			49
+#define RESET_RAMB			50
+/*					51-52	*/
+#define RESET_ROM			53
+#define RESET_SPIFC			54
+#define RESET_GIC			55
+#define RESET_UART_C			56
+#define RESET_UART_B			57
+#define RESET_UART_A			58
+#define RESET_OSC_RING			59
+/*					60-63	*/
+
+/*	RESET2					*/
+/*					64-95	*/
+
+#endif
--=20
2.25.1

