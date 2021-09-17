Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.9605.1631864238749887763
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:19 -0700
Received: by mail-wr1-f52.google.com with SMTP id q11so13588715wrr.9
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2OM/vNXRbDTeXG/ft1iFMYqNwkOsbnqiSOyMRUsyjk=;
        b=uZQKvMB6+2AiBb6Odvz8zTZZnBu8SAwuIVx9bZ4u84Z145sIYKzSwOiKE77K4FbdHA
         TKNTrY/XRc4Y02FARpDi/DLCcWUZ8RY/qguT9GFQ0fy0K75wlU8FRMDQmGtIOx0/Z67P
         nFQuhy186RPP1k0GDw/+BjTeVikDU5RVnv6iRIIe6yxk/Rf8kDqDoZUBzPWWrCDDtUuj
         OFa4mGQPdSwkPjyU0Ld3ByIv2v2Ohwag0l/Wikbm8Wq78KDHglTXF6vq7Px48u7NYscz
         P9FWRpesjA4RbLngM0LUc4ASmPmiqO4SVVnx7Fq+ajWohyQvum3fOU+dJiHdLdf8LxDn
         SE/Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 07/10] ARM: amlogic: add support for Odroid-HC4 device
Date: Fri, 17 Sep 2021 09:37:06 +0200
Message-Id: <20210917073709.1052133-7-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Odroid-HC4 is a variant of the Odroid-C4 board but with a PCIe-SATA bridge
instead of the USB3 ports.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi | 23 +++++
 board/amlogic/odroid-n2/MAINTAINERS           |  1 +
 configs/odroid-hc4_defconfig                  | 92 +++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
 create mode 100644 configs/odroid-hc4_defconfig

diff --git a/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
new file mode 100644
index 0000000000..963bf96b25
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-sm1-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
+
+/* SARADC is needed for proper board variant detection */
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
+&tflash_vdd {
+	gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+};
diff --git a/board/amlogic/odroid-n2/MAINTAINERS b/board/amlogic/odroid-n2/MAINTAINERS
index 77f7746346..43724e6fdd 100644
--- a/board/amlogic/odroid-n2/MAINTAINERS
+++ b/board/amlogic/odroid-n2/MAINTAINERS
@@ -5,5 +5,6 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/odroid-n2/
 F:	configs/odroid-n2_defconfig
 F:	configs/odroid-c4_defconfig
+F:	configs/odroid-hc4_defconfig
 F:	doc/board/amlogic/odroid-n2.rst
 F:	doc/board/amlogic/odroid-c4.rst
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
new file mode 100644
index 0000000000..7671496218
--- /dev/null
+++ b/configs/odroid-hc4_defconfig
@@ -0,0 +1,92 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="odroid-n2"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-odroid-hc4"
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" odroid-hc4"
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_SATA=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PCI=y
+CONFIG_PCIE_DW_MESON=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RESET=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_DM_VIDEO=y
+# CONFIG_VIDEO_BPP8 is not set
+# CONFIG_VIDEO_BPP16 is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MESON=y
+CONFIG_VIDEO_DT_SIMPLEFB=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_VIDEO_BMP_RLE8=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.25.1

