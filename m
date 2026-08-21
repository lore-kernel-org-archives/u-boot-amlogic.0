Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61152C61DBE
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:45 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3446.1787302281853611532
 for <u-boot-amlogic@groups.io>;
 Fri, 21 Aug 2026 01:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: tanurelinux@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c20ce3c118aso138923666b.0
        for <u-boot-amlogic@groups.io>; Fri, 21 Aug 2026 01:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302280; x=1787907080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=94JUQfT7Ei1J/+4ToB0rfBA9YujicOnrX4NdY/GL6Es=;
        b=OU9cWGwFv6+XGTyzjDkEd/2m3P+qzYweF8zsdhQ+hgYH89NCwJXnJuJAGJZrZEMyfQ
         3U4+EbyNGvGOE6qTqdOZuHt1xb08EnE8eYh6a29k7I6soZmxwz2VY90AaGKNQxuXwCKE
         FyIEK8DbhCbZlAvkshFPfMs13xgqAXBLE9unvHSn8EVkHaVDT+Aih4SFjMu5B3F+Wzaj
         vF+86m07NbO7OEMwGZ5kMRJNhdmeF+/Ljvyr9BzpKYLt+PbVvVmLbbg8oASLdqOtXOGG
         istK8OGCOMgDKzQ+yjB6rGBsbyqzNToECxFduNhM2ffgNZwWw7zpLCT7VzmZ/e5gNkth
         zEYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqgay65Bem6Gxs8TrKpcIPFgHBpBqbB9UBhvUZVGrprbtKBbiLVQZSNUD0kz0ZXGVecr1dp1U4mjbjE5ST3qQ==@groups.io
X-Gm-Message-State: AFuF++mrHpdqaVfLZA1wklWaYlIXeROlmwCm5JzpvLglRtpVgQGZniwY
	6iVw6K1SrTECZ8iPTAJlhemATTa1FFFkBqdqaaud8lLDodV/OAHprnDdVEBmmg==
X-Gm-Gg: AR+sD13Eeyymi6psTUcaEr1PETH+qG0YqiYCWjG3ONgtgu4rlOY3p/R1F/6v0yPhTEk
	kqaCRMjgYEgVKA/764WzjDSKisxNxk0AHOgf/XdHTLp5pYdjEaN2ckbnv53o8rBIj54a6UvYYnu
	2aTDfiHCP5y3iLZPfnvSmU0b5hPb54dGZ6MUNS114y1441l+yOZfBabPGIhGXfk/NO+7dFuH+FC
	2hdrjuZK7rI63FmvbvjizlExG4PiiIVNDPwDeOQFh5Dr7bbrIyvv/2D0yqlbSlWf+YVRwbeOzsq
	GzxVzXaL4cAFMzB4pZhITs2fJKqF0DVf1/p0gE8wCIRaWc88uL1sIkXQspxgrUqU0w2RCUerz5Q
	NMFEI8WDOQRAR+2is5GUlfAsVoFsoBnfGxMNYxT8t1gqYaYEQfZvvbBD6V0bwPXgn+9rRRZdR9L
	TeJVkV8a28X/GOHSCG+YGCCD85kOp4/D/tZ67lTnsQwwoEnUSAgZFvohIIQ2s2gAAsf3QLn6iFo
	eeshcInvE3lT1Q58OE2bD9vV8SB
X-Received: by 2002:a05:600c:5490:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-499b913eb08mr36889765e9.1.1787301969984;
        Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org,
	trini@konsulko.com,
	ilias.apalodimas@linaro.org,
	funderscore@postmasteros.org,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 3/4] board: amlogic: add Khadas VIM4 support
Date: Fri, 21 Aug 2026 09:46:02 +0100
Message-ID: <20260821084603.25974-4-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3048

Add initial support for the Khadas VIM4 board (Amlogic A311D2, T7
family): UART console, DRAM (first bank), PSCI reset through BL31 and
the secure monitor. Storage, network and USB support come later.

The image is position independent with TEXT_BASE=0, so the same
u-boot.bin can be chainloaded from the vendor U-Boot for development
or packaged as BL33 into the vendor boot image.

The console runs at 921600 baud, the serial console convention on the
VIM4 (this is also how BL2 configures uart_a).

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi | 16 ++++++++++++
 arch/arm/dts/amlogic-t7-u-boot.dtsi           | 14 ++++++++++
 board/amlogic/vim4/MAINTAINERS                |  7 +++++
 board/amlogic/vim4/Makefile                   |  4 +++
 board/amlogic/vim4/vim4.c                     | 14 ++++++++++
 configs/khadas-vim4_defconfig                 | 26 +++++++++++++++++++
 6 files changed, 81 insertions(+)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/dts/amlogic-t7-u-boot.dtsi
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig

diff --git a/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
new file mode 100644
index 00000000000..eaf9f073050
--- /dev/null
+++ b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include "amlogic-t7-u-boot.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
+
+&xtal {
+	bootph-all;
+};
diff --git a/arch/arm/dts/amlogic-t7-u-boot.dtsi b/arch/arm/dts/amlogic-t7-u-boot.dtsi
new file mode 100644
index 00000000000..648685e1acf
--- /dev/null
+++ b/arch/arm/dts/amlogic-t7-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+/ {
+	soc {
+		bootph-all;
+	};
+};
+
+&uart_a {
+	bootph-all;
+};
diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
new file mode 100644
index 00000000000..5e1ec98b571
--- /dev/null
+++ b/board/amlogic/vim4/MAINTAINERS
@@ -0,0 +1,7 @@
+VIM4
+M:	Lucas Tanure <tanure@linux.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/vim4/
+F:	configs/khadas-vim4_defconfig
+F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
diff --git a/board/amlogic/vim4/Makefile b/board/amlogic/vim4/Makefile
new file mode 100644
index 00000000000..0cc4078c549
--- /dev/null
+++ b/board/amlogic/vim4/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+
+obj-y	:= vim4.o
diff --git a/board/amlogic/vim4/vim4.c b/board/amlogic/vim4/vim4.c
new file mode 100644
index 00000000000..5db3deefe0e
--- /dev/null
+++ b/board/amlogic/vim4/vim4.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/eth.h>
+
+int misc_init_r(void)
+{
+	meson_generate_serial_ethaddr();
+
+	return 0;
+}
diff --git a/configs/khadas-vim4_defconfig b/configs/khadas-vim4_defconfig
new file mode 100644
index 00000000000..a9c22c44986
--- /dev/null
+++ b/configs/khadas-vim4_defconfig
@@ -0,0 +1,26 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/amlogic-t7-a311d2-khadas-vim4"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_MESON_T7=y
+CONFIG_SYS_LOAD_ADDR=0x10000000
+CONFIG_DEBUG_UART_BASE=0xfe078000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" khadas-vim4"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_BAUDRATE=921600
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
-- 
2.55.0


