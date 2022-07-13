Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
 by mx.groups.io with SMTP id smtpd.web08.19441.1657697566012975966
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Jul 2022 00:32:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1657697561; bh=W+zEgPZhzGCea3YqBQ2KZzN4CF3ognwgIXQs0CfKfRU=;
	h=From:To:Cc:Subject:Date;
	b=bbtlAMDKH6dxTghoOBsPdN4CvwP7yU8bvTtpTNCqbXmAZmjEs4SuPMZ7m0Yt1rpfk
	 5/C6B6RXb7H97iZ4OHzGL4mN4xjrvhPiHi4iZ349P8OnbcoDsnc5qSD9OBv3XCprUs
	 dC1izXKAvl+sS8aKQweSyKSv4j0XQfFuULboJaUM=
Message-ID: <tencent_8F0BB2B1BFF6631B0CE99F099C062A03BB07@qq.com>
From: Zhang Ning <zhangn1985@qq.com>
Subject: [PATCH] [Meson] add magicbox m16s config, dts and doc
Date: Wed, 13 Jul 2022 15:32:35 +0800
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: narmstrong@baylibre.com, sjg@chromium.org, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Zhang Ning <zhangn1985@qq.com>
List-ID: <u-boot-amlogic@groups.io>

MagicBox M16S or MagicBox 3Pro is welcome Tv box in China,
which is developed by Alibaba at 2016.

No schemtics, no vendor source code right now
thus no fip blobs to create mainline u-boot.
Need to use chainloader to boot a mainline u-boot, then mainline kernel.

from pre-installed u-boot log, it's gxm_q201_v1 or its decendent.

add a simple dts and config to enable this Tv box.
a simple doc for how to enable mainline uboot.

Signed-off-by: Zhang Ning <zhangn1985@qq.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../dts/meson-gxm-magicbox-m16s-u-boot.dtsi   |   6 +
 arch/arm/dts/meson-gxm-magicbox-m16s.dts      |  24 ++++
 configs/magicbox-m16s_defconfig               |  68 +++++++++++
 doc/board/amlogic/index.rst                   |   1 +
 doc/board/amlogic/magicboxm16s.rst            | 109 ++++++++++++++++++
 6 files changed, 209 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxm-magicbox-m16s-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-magicbox-m16s.dts
 create mode 100644 configs/magicbox-m16s_defconfig
 create mode 100644 doc/board/amlogic/magicboxm16s.rst

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index a7e0d9f6c0..31294c4c18 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -191,6 +191,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
 	meson-gxm-khadas-vim2.dtb \
 	meson-gxm-s912-libretech-pc.dtb \
 	meson-gxm-wetek-core2.dtb \
+	meson-gxm-magicbox-m16s.dtb \
 	meson-g12a-radxa-zero.dtb \
 	meson-g12a-sei510.dtb \
 	meson-g12a-u200.dtb \
diff --git a/arch/arm/dts/meson-gxm-magicbox-m16s-u-boot.dtsi b/arch/arm/dts/meson-gxm-magicbox-m16s-u-boot.dtsi
new file mode 100644
index 0000000000..87a6e8525e
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-magicbox-m16s-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Zhang Ning <zhangn1985@qq.com>
+ */
+
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxm-magicbox-m16s.dts b/arch/arm/dts/meson-gxm-magicbox-m16s.dts
new file mode 100644
index 0000000000..a382fafc51
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-magicbox-m16s.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Zhang Ning <zhangn1985@qq.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "magicbox,m16s", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Magicbox M16S";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>; /* 2 GiB */
+	};
+
+};
+&ethmac {
+        phy-mode = "rmii";
+        phy-handle = <&internal_phy>;
+};
diff --git a/configs/magicbox-m16s_defconfig b/configs/magicbox-m16s_defconfig
new file mode 100644
index 0000000000..df9a746b65
--- /dev/null
+++ b/configs/magicbox-m16s_defconfig
@@ -0,0 +1,68 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-gxm-magicbox-m16s"
+CONFIG_MESON_GXM=y
+CONFIG_DEBUG_UART_BASE=0xc81004c0
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" magicbox m16s"
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_ADC=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SARADC_MESON=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MMIOREG=y
+CONFIG_MESON_GXL_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_GXL=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_GXL=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_OF_LIBFDT_OVERLAY=y
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index 9c7fadf2c0..2620b38b5d 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -113,3 +113,4 @@ Board Documentation
    u200
    wetek-core2
    w400
+   magicboxm16s
diff --git a/doc/board/amlogic/magicboxm16s.rst b/doc/board/amlogic/magicboxm16s.rst
new file mode 100644
index 0000000000..2161fb1d0c
--- /dev/null
+++ b/doc/board/amlogic/magicboxm16s.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Hacking notes for MagicBox M16S
+=======================
+
+MagicBox M16S or MagicBox 3Pro is popular Tv box in China, which is
+manufactured by Alibaba in 2016, with following specifications:
+
+ - Amlogic S912-H (S192 with dolby and DTS)
+ - 2GB DDR3 SDRAM
+ - 100M Ethernet
+ - HDMI 2.0 4K/60Hz display
+ - 1 x USB 2.0
+ - 16G eMMC
+ - Infrared receiver
+ - Marvel SD8897 WiFi module
+ - AV out
+ - Rest hole
+ - 5V2A power jack
+
+No schematics and source code available from vendor.
+
+U-Boot compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make magicbox-m16s_defconfig
+    $ make
+
+Enable chainloader
+--------------
+
+Due to no vendor source code, thus not able to create bootable u-boot image as other devices.
+
+thus only way to run mainline u-boot is chainloader.
+
+Step1: connect TTL to mainboard.
+
+Open metal cover, and you will see TTL test points show as below:
+
+   G>---              <<-- gnd
+
+       ---            <<-- Tx
+
+     ---              <<-- Rx
+
+       ---            <<-- pwr
+
+Connect an USB TTL to these test points.
+
+Step2: enable chainloader.
+
+Connect USE TTL to you PC, and open it with any teminal tool, with configure: 115200n8
+
+Power on Tv box, and press `enter` on your keyboard. and then you get:
+
+.. code-block:: bash
+   gxm_q201_v1#
+
+If not, power off, and redo this step.
+
+Type below u-boot command to console:
+
+.. code-block:: bash
+   setenv OLDBOOTCMD "set_usb_boot 4;run storeboot"
+   setenv USBBOOTCMD "usb start;if fatload usb 0 0x1000000 u-boot.bin; then go 0x1000000; fi;"
+   setenv bootcmd "run USBBOOTCMD; run OLDBOOTCMD; run storeboot"
+   saveenv
+   sleep 1
+   reboot
+
+If you reboot to pre-installed OS, there will be a very long boot time, just wait, it's not brick.
+
+Step2: prepare boot media
+
+Parition you Usb flash driver to Dos partition table, and first partition to 10M, format it to fat32.
+
+Copy u-boot.bin to first partition.
+
+Insert it to Tv box, it will automatically boot to mainline u-boot.
+
+
+Step3: optional boot script for sysboot
+
+If you want to use u-boot-menu to generate extlinux.conf to make a grub-like OS menu,
+a simple boot script is needed. (assume your extlinux.conf is in 2nd partition)
+
+.. code-block::
+   sysboot usb 0:2 any 0x1080000 /boot/extlinux/extlinux.conf
+
+# use: mkimage -A arm64 -T script -O linux -d boot.cmd boot.scr
+
+copy boot.scr to first partition, it will automatically load extlinux.conf and boot to OS.
+
+Status
+-----------
+Debian sid with kernel 5.19-rc4
+HDMI: OK, sound not test
+WIFI: OK
+eth:  OK
+BT:   OK
+IR:   No decoder, keymap
+
+Issues: Due need to keep vendor u-boot, not able to use internal emmc.
+       Due to no power key, it will automatically poweron, even after poweroff.
+       WIFI loss after reboot, need disconnect power to recover.
+
-- 
2.35.1

