Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BEBC5B56A
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 14:38:03 +0000 (UTC)
Received: from mta1.migadu.com (mta1.migadu.com [95.215.58.189])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31447.1786372673543010946
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Aug 2026 07:37:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=Rx2qcI1P;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.189, mailfrom: funderscore@postmarketos.org)
X-Envelope-To: u-boot-amlogic@groups.io
DKIM-Signature: a=rsa-sha256; bh=qxhXtg9IYIx5zlh2t0bMQL/9ezBqi36a7f9x9EyrJ4s=;
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786372671; v=1; x=1786977471;
 b=Rx2qcI1Pp+oWN1AqQ0GRWpBRiNHMENx30FaSiaHvwBg8crLuxUS0wU8aNIOSAQn2QZs7mQVE
 2kt2c+QGWokfauB//z7bZ10GOhEJUBi7h3/qca7cuBxmNENW+1fGB424/PSafTppTwON0tFMFsl
 farXZGqxGZZoJhY+Hy/TMgIBFiZv+NjfxmATamY9TSyIK+8o/cZUGM8r9lBXZ+0vMlJOiy0itq9
 ioF1Oxc5D0zHmWMLtgtWK5PH1uMhYc8SDzXaGL3BkPGNfBFAnQlEZN4Ho9O4LKEEPO34aqKXkO3
 eDCkbtskrae+NtBl/tDzukTRMid9S1n2wG9Nrd6EZx7fA==
X-Envelope-To: u-boot-amlogic@groups.io
Received: from meli-email.org (160.90.43.132)
	by mta10.migadu.com with ESMTPS id 58c0de219b813361;
	Mon, 10 Aug 2026 14:37:51 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
Date: Mon, 10 Aug 2026 14:30:30 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org, funderscore@postmasteros.org, u-boot-amlogic@groups.io, Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 3/4] board: amlogic: add Khadas VIM4 support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com> <20260806101809.72526-4-tanure@linux.com>
In-Reply-To: <20260806101809.72526-4-tanure@linux.com>
Message-ID: <tjk5yq.2kzx2i3phlgjs@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 10 Aug 2026 14:38:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3023

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>Add initial support for the Khadas VIM4 board (Amlogic A311D2, T7
>family): UART console, DRAM (first bank), PSCI reset through BL31 and
>the secure monitor. Storage, network and USB support come later.
>
>The image is position independent with TEXT_BASE=0, so the same
>u-boot.bin can be chainloaded from the vendor U-Boot for development
>or packaged as BL33 into the vendor boot image.
>
>The console runs at 921600 baud, the serial console convention on the
>VIM4 (this is also how BL2 configures uart_a).
>
>Assisted-by: Claude:claude-fable-5
>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi | 22 +++++++++++++++
> board/amlogic/vim4/MAINTAINERS                |  7 +++++
> board/amlogic/vim4/Makefile                   |  4 +++
> board/amlogic/vim4/vim4.c                     | 14 ++++++++++
> configs/khadas-vim4_defconfig                 | 27 +++++++++++++++++++
> 5 files changed, 74 insertions(+)
> create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
> create mode 100644 board/amlogic/vim4/MAINTAINERS
> create mode 100644 board/amlogic/vim4/Makefile
> create mode 100644 board/amlogic/vim4/vim4.c
> create mode 100644 configs/khadas-vim4_defconfig
>
>diff --git a/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>new file mode 100644
>index 00000000000..dde2cd804e3
>--- /dev/null
>+++ b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>@@ -0,0 +1,22 @@
>+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>+/*
>+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+/ {
>+	chosen {
>+		stdout-path = "serial0:921600n8";
>+	};
>+
>+	soc {
>+		bootph-all;
>+	};
>+};
>+
>+&uart_a {
>+	bootph-all;
>+};
>+
>+&xtal {
>+	bootph-all;
>+};

Maybe this should go in a common amlogic-t7-u-boot dts instead of
something board-specific?

>diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
>new file mode 100644
>index 00000000000..5e1ec98b571
>--- /dev/null
>+++ b/board/amlogic/vim4/MAINTAINERS
>@@ -0,0 +1,7 @@
>+VIM4
>+M:	Lucas Tanure <tanure@linux.com>
>+S:	Maintained
>+L:	u-boot-amlogic@groups.io
>+F:	board/amlogic/vim4/
>+F:	configs/khadas-vim4_defconfig
>+F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
>diff --git a/board/amlogic/vim4/Makefile b/board/amlogic/vim4/Makefile
>new file mode 100644
>index 00000000000..0cc4078c549
>--- /dev/null
>+++ b/board/amlogic/vim4/Makefile
>@@ -0,0 +1,4 @@
>+# SPDX-License-Identifier: GPL-2.0+
>+# (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+
>+obj-y	:= vim4.o
>diff --git a/board/amlogic/vim4/vim4.c b/board/amlogic/vim4/vim4.c
>new file mode 100644
>index 00000000000..5db3deefe0e
>--- /dev/null
>+++ b/board/amlogic/vim4/vim4.c
>@@ -0,0 +1,14 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/*
>+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
>+ */
>+
>+#include <init.h>
>+#include <asm/arch/eth.h>
>+
>+int misc_init_r(void)
>+{
>+	meson_generate_serial_ethaddr();
>+
>+	return 0;
>+}
>diff --git a/configs/khadas-vim4_defconfig b/configs/khadas-vim4_defconfig
>new file mode 100644
>index 00000000000..10a64c07a88
>--- /dev/null
>+++ b/configs/khadas-vim4_defconfig
>@@ -0,0 +1,27 @@
>+CONFIG_ARM=y
>+CONFIG_POSITION_INDEPENDENT=y
>+CONFIG_ARCH_MESON=y
>+CONFIG_TEXT_BASE=0x00000000
>+CONFIG_NR_DRAM_BANKS=1
>+CONFIG_ENV_SIZE=0x2000
>+CONFIG_DM_GPIO=y
>+CONFIG_DEFAULT_DEVICE_TREE="amlogic/amlogic-t7-a311d2-khadas-vim4"
>+CONFIG_OF_LIBFDT_OVERLAY=y
>+CONFIG_MESON_T7=y
>+CONFIG_SYS_LOAD_ADDR=0x10000000
>+CONFIG_DEBUG_UART_BASE=0xfe078000
>+CONFIG_DEBUG_UART_CLOCK=24000000
>+CONFIG_IDENT_STRING=" khadas-vim4"
>+CONFIG_DEBUG_UART=y
>+CONFIG_OF_BOARD_SETUP=y
>+# CONFIG_DISPLAY_CPUINFO is not set
>+# CONFIG_DISPLAY_BOARDINFO is not set
>+CONFIG_SYS_PROMPT="kvim4> "

Leave this unset

>+# CONFIG_CMD_BDI is not set
>+# CONFIG_CMD_IMI is not set
>+CONFIG_CMD_CACHE=y
>+CONFIG_OF_CONTROL=y
>+CONFIG_BAUDRATE=921600
>+CONFIG_DEBUG_UART_ANNOUNCE=y
>+CONFIG_DEBUG_UART_SKIP_INIT=y
>+CONFIG_MESON_SERIAL=y
>-- 
>2.55.0

Best regards,
Ferass

