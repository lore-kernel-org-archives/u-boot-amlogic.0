Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.26260.1683291419842438507
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:57:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=wsAlbcfdKcfnHbB66ie9KemlxKu/i3cLrSDqjMKp7pU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=VktbK+LMUOO1/7cEq9rdiZvTvK/DJzPFjPamXv+4tbG9l+GWs1cWWL7zURuJtO65z
	 bti0x9ifI9J780xZlfMoc+I+DgDwKuogiTcb3p+4J8wsDqcMP5CXJtbnjBQTA6bKBZ
	 dEz+CkZYKq5AsBOu6Uf8X2i8hrFMXX8oWSoRLwwy6aGlcbh1IcwzSrTqvjkASTR8Ar
	 V3TAFw29B7rIv6A/DS19vzSAkO/HcC7kjylpD2ZoYBXCo+gv6dk2pQccgmRFX64wbB
	 PLS7HGwxlKDCKm0GG8CrqFzcnXaro2F72L6G+0MCVepCilYBBdm59+oJeMFgguk9bi
	 iI0D9boxZEuag==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 5/5] board: amlogic: add support for AD401 board
Date: Fri, 5 May 2023 15:56:39 +0300
Message-ID: <20230505125639.3605-6-ivprusov@sberdevices.ru>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The AD401 board is the Amlogic A1 SoC reference board

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig     |  1 +
 board/amlogic/ad401/MAINTAINERS |  6 ++++
 board/amlogic/ad401/Makefile    |  4 +++
 board/amlogic/ad401/ad401.c     | 15 +++++++++
 configs/ad401_defconfig         | 54 +++++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 board/amlogic/ad401/MAINTAINERS
 create mode 100644 board/amlogic/ad401/Makefile
 create mode 100644 board/amlogic/ad401/ad401.c
 create mode 100644 configs/ad401_defconfig

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 519ed563c0..669ca09a00 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -75,6 +75,7 @@ config SYS_VENDOR
=20
 config SYS_BOARD
 	string "Board name"
+	default "ad401" if MESON_A1
 	default "p200" if MESON_GXBB
 	default "p212" if MESON_GXL
 	default "q200" if MESON_GXM
diff --git a/board/amlogic/ad401/MAINTAINERS b/board/amlogic/ad401/MAINTAIN=
ERS
new file mode 100644
index 0000000000..52a44bd66c
--- /dev/null
+++ b/board/amlogic/ad401/MAINTAINERS
@@ -0,0 +1,6 @@
+AD401
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/ad401/
+F:	configs/ad401_defconfig
diff --git a/board/amlogic/ad401/Makefile b/board/amlogic/ad401/Makefile
new file mode 100644
index 0000000000..e65c1215f6
--- /dev/null
+++ b/board/amlogic/ad401/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2023 SberDevices, Inc.
+
+obj-y	:=3D ad401.o
diff --git a/board/amlogic/ad401/ad401.c b/board/amlogic/ad401/ad401.c
new file mode 100644
index 0000000000..356b2880bd
--- /dev/null
+++ b/board/amlogic/ad401/ad401.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@sberdevices.ru>
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
diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
new file mode 100644
index 0000000000..529e553bac
--- /dev/null
+++ b/configs/ad401_defconfig
@@ -0,0 +1,54 @@
+CONFIG_ARM=3Dy
+CONFIG_ARCH_MESON=3Dy
+CONFIG_TEXT_BASE=3D0x00000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x00200000
+CONFIG_DM_GPIO=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"meson-a1-ad401"
+CONFIG_SYS_PROMPT=3D"ad401 # "
+CONFIG_OF_LIBFDT_OVERLAY=3Dy
+CONFIG_MESON_A1=3Dy
+CONFIG_DEBUG_UART_BASE=3D0xfe001c00
+CONFIG_DEBUG_UART_CLOCK=3D24000000
+CONFIG_SYS_LOAD_ADDR=3D0x0
+CONFIG_DEBUG_UART=3Dy
+CONFIG_ANDROID_BOOT_IMAGE=3Dy
+CONFIG_FIT=3Dy
+CONFIG_FIT_SIGNATURE=3Dy
+CONFIG_OF_BOARD_SETUP=3Dy
+CONFIG_BOOTCOMMAND=3D"run storeboot"
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=3Dy
+CONFIG_CMD_I2C=3Dy
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_MTD=3Dy
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_CACHE=3Dy
+CONFIG_CMD_MTDPARTS=3Dy
+CONFIG_CMD_UBI=3Dy
+CONFIG_OF_CONTROL=3Dy
+CONFIG_ADC=3Dy
+CONFIG_SARADC_MESON=3Dy
+CONFIG_DM_I2C=3Dy
+CONFIG_SYS_I2C_MESON=3Dy
+CONFIG_LED=3Dy
+CONFIG_MISC=3Dy
+CONFIG_MTD=3Dy
+CONFIG_DM_SPI_FLASH=3Dy
+CONFIG_PHY=3Dy
+CONFIG_PINCTRL=3Dy
+CONFIG_PINCTRL_MESON_A1=3Dy
+CONFIG_DM_REGULATOR=3Dy
+CONFIG_DM_PWM=3Dy
+CONFIG_PWM_MESON=3Dy
+CONFIG_DEBUG_UART_ANNOUNCE=3Dy
+CONFIG_DEBUG_UART_SKIP_INIT=3Dy
+CONFIG_MESON_SERIAL=3Dy
+CONFIG_SPI=3Dy
+CONFIG_DM_SPI=3Dy
+CONFIG_WDT=3Dy
--=20
2.34.1

