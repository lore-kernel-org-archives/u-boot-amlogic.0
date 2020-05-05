Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.5860.1588710198699205071
 for <u-boot-amlogic@groups.io>;
 Tue, 05 May 2020 13:23:19 -0700
Received: by mail-wm1-f67.google.com with SMTP id x25so55205wmc.0
        for <u-boot-amlogic@groups.io>; Tue, 05 May 2020 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txpDlHYQuuE9opOUeYrvRj4RVHhmlL7/Psgy6XT469g=;
        b=Epr+xDpaLPCCx/L9zG2MDv3pxjpizz7554uqC1M5bZsKX3WKBA58hyHxnQLcN8rpjK
         9VW0qF+eMi10O0Jw2lgzY3y420sSpk5j1iYHipxWKiAKEwr2GLr/IxWrbFuPzv3SddMS
         xmNWEtJ8mLUemEr/aPdUVNk3Cy1O6PcwNwLc4hE52zT4SsGWfiBW5nyAXdRE8vrnz/Ks
         kU6jLSOf4+kEIH1xX/kQ1xSIiHDiDDnLlKvzwS083z6lD4aVrQquPbwSIv0fndCjhMlF
         aznZKylrC2jUVkliS+ho52eJsaWu035SvVSRtzmheJPzUTSyYqvo4QkyRJWhoOP5zDlq
         91EQ==
Return-Path: <b.galvani@gmail.com>
From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH 2/2] boards: amlogic: add ODROID-C4 support
Date: Tue,  5 May 2020 22:22:17 +0200
Message-Id: <20200505202217.7849-3-b.galvani@gmail.com>
In-Reply-To: <20200505202217.7849-1-b.galvani@gmail.com>
References: <20200505202217.7849-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, Beniamino Galvani <b.galvani@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Introduce support for ODROID-C4, a single board computer manufactured
by Hardkernel Co. Ltd with the following specifications:

 - Amlogic S905X3 ARM Cortex-A55 quad-core SoC
 - 4GiB DDR4 SDRAM
 - Gigabit Ethernet (External Realtek RTL8211F PHY)
 - 4 x USB 3.0 Host ports
 - 1 x USB 2.0 OTG port
 - HDMI 2.0
 - eMMC
 - SDcard
 - 40-pin GPIO header
 - Infrared receiver

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 board/amlogic/odroid-c4/MAINTAINERS |  6 +++
 board/amlogic/odroid-c4/Makefile    |  3 ++
 board/amlogic/odroid-c4/README      | 83 +++++++++++++++++++++++++++++
 board/amlogic/odroid-c4/odroid-c4.c | 17 ++++++
 configs/odroid-c4_defconfig         | 63 ++++++++++++++++++++++
 5 files changed, 172 insertions(+)
 create mode 100644 board/amlogic/odroid-c4/MAINTAINERS
 create mode 100644 board/amlogic/odroid-c4/Makefile
 create mode 100644 board/amlogic/odroid-c4/README
 create mode 100644 board/amlogic/odroid-c4/odroid-c4.c
 create mode 100644 configs/odroid-c4_defconfig

diff --git a/board/amlogic/odroid-c4/MAINTAINERS b/board/amlogic/odroid-c4/MAINTAINERS
new file mode 100644
index 0000000000..ebc1a9efe5
--- /dev/null
+++ b/board/amlogic/odroid-c4/MAINTAINERS
@@ -0,0 +1,6 @@
+ODROID-C4
+M:	Beniamino Galvani <b.galvani@gmail.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/odroid-c4/
+F:	configs/odroid-c4_defconfig
diff --git a/board/amlogic/odroid-c4/Makefile b/board/amlogic/odroid-c4/Makefile
new file mode 100644
index 0000000000..a0ca5fb242
--- /dev/null
+++ b/board/amlogic/odroid-c4/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	:= odroid-c4.o
diff --git a/board/amlogic/odroid-c4/README b/board/amlogic/odroid-c4/README
new file mode 100644
index 0000000000..9308965738
--- /dev/null
+++ b/board/amlogic/odroid-c4/README
@@ -0,0 +1,83 @@
+U-Boot for ODROID-C4
+====================
+
+ODROID-C4 is a single board computer manufactured by Hardkernel
+Co. Ltd with the following specifications:
+
+ - Amlogic S905X3 ARM Cortex-A55 quad-core SoC
+ - 4GiB DDR4 SDRAM
+ - Gigabit Ethernet (External Realtek RTL8211F PHY)
+ - 4 x USB 3.0 Host ports
+ - 1 x USB 2.0 OTG port
+ - HDMI 2.0
+ - eMMC
+ - SDcard
+ - 40-pin GPIO header
+ - Infrared receiver
+
+Currently the u-boot port supports the following devices:
+ - Serial
+ - Clock controller
+ - USB
+
+u-boot compilation
+==================
+
+ export ARCH=arm
+ export CROSS_COMPILE=aarch64-none-elf-
+ make odroid-c4_defconfig
+ make
+
+Image creation
+==============
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain them from
+the git tree published by the board vendor:
+
+ wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ wget https://releases.linaro.org/archive/14.04/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz
+ tar xf gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ tar xf gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz
+ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin:$PATH
+ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 hardkernel-u-boot
+ cd hardkernel-u-boot
+ make odroidc4_defconfig
+ make
+ export UBOOTDIR=$PWD
+
+Go back to mainline U-Boot source tree and then:
+
+ mkdir fip
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl30sig --level v3 \
+                                     --input $UBOOTDIR/build/fip/bl30_new.bin \
+                                     --output fip/bl30_new.bin.g12.enc
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --type bl30 --level v3 \
+                                     --input fip/bl30_new.bin.g12.enc \
+                                     --output fip/bl30_new.bin.enc
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --type bl31 --level v3 \
+                                     --input $UBOOTDIR/fip/g12a/bl31.img \
+                                     --output fip/bl31.img.enc
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl3sig --type bl33 --level v3 \
+                                     --compress lz4 \
+                                     --input u-boot.bin \
+                                     --output fip/bl33.bin.enc
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bl2sig \
+                                     --input $UBOOTDIR/build/fip/bl2_new.bin \
+                                     --output fip/bl2.n.bin.sig
+ $UBOOTDIR/fip/g12a/aml_encrypt_g12a --bootmk \
+                                     --output fip/u-boot.bin \
+                                     --bl2 fip/bl2.n.bin.sig \
+                                     --bl30 fip/bl30_new.bin.enc \
+                                     --bl31 fip/bl31.img.enc \
+                                     --bl33 fip/bl33.bin.enc \
+                                     --ddrfw1 $UBOOTDIR/fip/g12a/ddr4_1d.fw \
+                                     --ddrfw2 $UBOOTDIR/fip/g12a/ddr4_2d.fw \
+                                     --ddrfw4 $UBOOTDIR/fip/g12a/piei.fw \
+                                     --ddrfw8 $UBOOTDIR/fip/g12a/aml_ddr.fw \
+                                     --level v3
+
+and then write the image to SD with:
+
+ DEV=/dev/your_sd_device
+ dd if=fip/u-boot.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
diff --git a/board/amlogic/odroid-c4/odroid-c4.c b/board/amlogic/odroid-c4/odroid-c4.c
new file mode 100644
index 0000000000..14f1748fa0
--- /dev/null
+++ b/board/amlogic/odroid-c4/odroid-c4.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <asm/arch/eth.h>
+
+int misc_init_r(void)
+{
+	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
+
+	meson_generate_serial_ethaddr();
+
+	return 0;
+}
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
new file mode 100644
index 0000000000..cc27c6fc1b
--- /dev/null
+++ b/configs/odroid-c4_defconfig
@@ -0,0 +1,63 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="odroid-c4"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_MESON_G12A=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" odroid-c4"
+# CONFIG_PSCI_RESET is not set
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_CONSOLE_MUX is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_BMP=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-c4"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+# CONFIG_INPUT is not set
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=8
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.25.1

