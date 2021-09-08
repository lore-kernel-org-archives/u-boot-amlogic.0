Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.11832.1631110661165009709
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:41 -0700
Received: by mail-wm1-f46.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so1684809wms.2
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVHZeYjiz6qAGSy6+lmV+fTVbskhk+dC/KBHRBZsbPc=;
        b=m8n+AsTVR2gtCQjxc98vuDekYu3vMwFnwNlu/4r+PuET9vTO+NPxuLRK96gbgLMgOG
         ej9FLOM9wPw+eN65bmIylyKBKHOwpBGFeGHkQOsPYdaxSYHEyyvVyQzEmbqEouQP0/uG
         cT4tIZg6uQL0PMe0ckXq6Cg53nGf1WtMEP3w/r7zeeESYIiUkQ/MxLYXb4ukWXw8oqjJ
         aXVeJ7KI/2qI4SnSUUJx+9NVkBroN0CoQtfCHhYAV44xqxR9sPNjxnC7DvSweVwt5iBo
         2xXjpIGQ6ErdrXEvmoHegnaxofp+BzVwGaUTJj/DHsyC+NB0DEvkku8Pfhn9kLPVjdcD
         gU5g==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 6/9] ARM: amlogic: add support for Odroid-HC4 device
Date: Wed,  8 Sep 2021 16:17:25 +0200
Message-Id: <20210908141728.585797-6-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Odroid-HC4 is a variant of the Odroid-C4 board but with an PCIe-SATA bridge
instead of the USB3 ports.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi | 23 +++++
 configs/odroid-hc4_defconfig                  | 83 +++++++++++++++++++
 2 files changed, 106 insertions(+)
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
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
new file mode 100644
index 0000000000..aca294adba
--- /dev/null
+++ b/configs/odroid-hc4_defconfig
@@ -0,0 +1,83 @@
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
+CONFIG_DM_RESET=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
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

