Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.1021.1576780591620075870
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Dec 2019 10:36:32 -0800
Received: by mail-wm1-f66.google.com with SMTP id p17so6731004wmb.0
        for <u-boot-amlogic@groups.io>; Thu, 19 Dec 2019 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcoDgOk3rXDcoY5ehiIKxAb3cSuXXsd4x2qnhhuI3hY=;
        b=RgErnR3nwyLLbwR7Ts2ZTcp2bGqIWGcPq1+kfmZEvKb1FMdbLXHQb/nFGacev7/jmB
         LGQF9bHFiTnK5NwWimC4RFLCwRo4OE6I/guOZNQHwOhY2UXHcBNiCkQdqVxXbq5x6Joz
         oQm3eMRgd/7eyJSScMbArG+YBf0XTQ+gFdET508dJ6Rpz10ova7W59QssOaC/Qw8d3j1
         F0EQa2yOxMYeqF/rx/eXAnMvZnkKk5jnIkUaw0Fcpxuv8KDd48Ea/dn29/3dZ3DUsTdx
         1JSqbni4Aj9BKvI9JUrGokPKGyRqPM5o3DoOOWOwncyIRnxA5Dgqvvt1ZzMQJ/sxGf/K
         b4wQ==
Return-Path: <jbrunet@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/5] dt-bindings: leds: import common led bindings from linux v5.4
Date: Thu, 19 Dec 2019 19:36:16 +0100
Message-Id: <20191219183620.1423118-2-jbrunet@baylibre.com>
In-Reply-To: <20191219183620.1423118-1-jbrunet@baylibre.com>
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Import the common leds bindings definition from linux v5.4

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/leds/common.h | 75 +++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 include/dt-bindings/leds/common.h

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
new file mode 100644
index 000000000000..9e1256a7c1bf
--- /dev/null
+++ b/include/dt-bindings/leds/common.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for the common LEDs device tree bindings.
+ *
+ * Copyright (C) 2015, Samsung Electronics Co., Ltd.
+ * Author: Jacek Anaszewski <j.anaszewski@samsung.com>
+ *
+ * Copyright (C) 2019 Jacek Anaszewski <jacek.anaszewski@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_LEDS_H
+#define __DT_BINDINGS_LEDS_H
+
+/* External trigger type */
+#define LEDS_TRIG_TYPE_EDGE	0
+#define LEDS_TRIG_TYPE_LEVEL	1
+
+/* Boost modes */
+#define LEDS_BOOST_OFF		0
+#define LEDS_BOOST_ADAPTIVE	1
+#define LEDS_BOOST_FIXED	2
+
+/* Standard LED colors */
+#define LED_COLOR_ID_WHITE	0
+#define LED_COLOR_ID_RED	1
+#define LED_COLOR_ID_GREEN	2
+#define LED_COLOR_ID_BLUE	3
+#define LED_COLOR_ID_AMBER	4
+#define LED_COLOR_ID_VIOLET	5
+#define LED_COLOR_ID_YELLOW	6
+#define LED_COLOR_ID_IR		7
+#define LED_COLOR_ID_MAX	8
+
+/* Standard LED functions */
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_CPU "cpu"
+#define LED_FUNCTION_CAPSLOCK "capslock"
+#define LED_FUNCTION_CHARGING "charging"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DISK "disk"
+#define LED_FUNCTION_DISK_ACTIVITY "disk-activity"
+#define LED_FUNCTION_DISK_ERR "disk-err"
+#define LED_FUNCTION_DISK_READ "disk-read"
+#define LED_FUNCTION_DISK_WRITE "disk-write"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_KBD_BACKLIGHT "kbd_backlight"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_MAIL "mail"
+#define LED_FUNCTION_MTD "mtd"
+#define LED_FUNCTION_MICMUTE "micmute"
+#define LED_FUNCTION_MUTE "mute"
+#define LED_FUNCTION_NUMLOCK "numlock"
+#define LED_FUNCTION_PANIC "panic"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_POWER "power"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SCROLLLOCK "scrolllock"
+#define LED_FUNCTION_STANDBY "standby"
+#define LED_FUNCTION_STATUS "status"
+#define LED_FUNCTION_TORCH "torch"
+#define LED_FUNCTION_TX "tx"
+#define LED_FUNCTION_USB "usb"
+#define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WPS "wps"
+
+#endif /* __DT_BINDINGS_LEDS_H */
-- 
2.23.0

