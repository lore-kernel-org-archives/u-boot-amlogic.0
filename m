Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.9691.1618996702370922629
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Apr 2021 02:18:22 -0700
Received: by mail-wm1-f50.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so853411wmq.4
        for <u-boot-amlogic@groups.io>; Wed, 21 Apr 2021 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3qvDO0LDF7+zKKTRsGNnyQ6wdyRvtlZifi5Wmm38WE=;
        b=00dZcqjrN8LsGi4LuPJ6j/AXxyAUwXHKESW0Nsvsqve9hvdbDaI1MyWFYKBHOgr+lM
         j0IR7/IrUcphyFdMd5u942DTnE7/XDywRaSRnWoAmKfYtXHvMNt6e+IAK5xW3RAepVQe
         r1uJacW9K5xB27x+y1tOjUpdyFWSy3XDCUAKSRn/tHXa3NoXQGrSBQCMlUXI0sfgdEee
         NdACRXiV5rFcwbCipxUTfpT2RvgX5Pvi0wv5H91IL/dZ5vBudJibSiyZ94hKLkgAuqTL
         tfFH4Pz5SLaGoGSRu/wKLcyKA5AsCrSK9uPTQ9NGNMzEe/nzMNpxnqIrMchJwJQ+e0vM
         sxHw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 8/8] ARM: meson: add Beelink GS-King X board
Date: Wed, 21 Apr 2021 11:18:09 +0200
Message-Id: <20210421091809.3103002-8-narmstrong@baylibre.com>
In-Reply-To: <20210421091809.3103002-1-narmstrong@baylibre.com>
References: <20210421091809.3103002-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Beelink GS-King X is a variant of the GS King boards but with an internal
USB to SATA bridge and advanced audio features.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi |  7 ++
 configs/beelink-gsking-x_defconfig           | 72 ++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
 create mode 100644 configs/beelink-gsking-x_defconfig

diff --git a/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi b/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
new file mode 100644
index 0000000000..236f2468dc
--- /dev/null
+++ b/arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
new file mode 100644
index 0000000000..ec9079d960
--- /dev/null
+++ b/configs/beelink-gsking-x_defconfig
@@ -0,0 +1,72 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" beelink"
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-gsking-x"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_USB=y
+CONFIG_DM_USB=y
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
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.25.1

