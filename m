Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.2665.1665135524681757874
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Oct 2022 02:38:45 -0700
Received: by mail-wr1-f50.google.com with SMTP id f11so6432037wrm.6
        for <u-boot-amlogic@groups.io>; Fri, 07 Oct 2022 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB0plN+Gl9vtheQcWKhz80Cq7j0X82O7hpR1UNdWLCs=;
        b=hLajrrN9VXUeIbHacAkO8peMwJXY0vf/SEbCydXN/hYEPfVeJkycti/bMut4eTqiDR
         qsnlg4GxwsIiSfmtTG1cXHftqozYe1ZsL63iYC2w1EDWDSsICRaSmQHyZAs3rInroI5T
         jUp9zFPWstAB5/FPI2MVsGJtqh1j5NSaqrAANtCIXmmqfv4NwTDQp4jle0fpsII9Wvb/
         GqaWcsr2iPOAR30x7uIvm2SmVOm5Hk5g/jDR9VuZTLJVLWbGPrbeAuuC1N8jxa7I9PAj
         2FiqCaIYKrSxD1I2mQ0Zry/JJbvbzv3GJQIEDewvdxUBz+u13GZ9VU9svRWg09+nATyM
         IMzg==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Fri, 07 Oct 2022 11:38:23 +0200
Subject: [PATCH v2 2/2] mach-meson: g12a: reset usb controller in reset_misc()
MIME-Version: 1.0
Message-Id: <20220728-reset-usb-controller-v2-2-ef7657ce78b1@baylibre.com>
References: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
In-Reply-To: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On some g12a boards like the VIM3L and the SEI610, with some
USB cables/hosts, there is a long (5s) delay before
between "fastboot reboot" and the host detecting a USB reset.

This breaks tools relying on "fastboot reboot fastboot" which assume
that 1s after the command send, the board should disconnect on usb.

To reproduce, enable fastboot in U-Boot console:
=> fastboot usb 0

Then, on the host, run:
  # echo "running fastboot reboot bootloader" > /dev/kmsg && fastboot reboot bootloader
  Rebooting into bootloader                          OKAY [  0.003s]
  Finished. Total time: 3.033s

  [54074.251551] running fastboot reboot bootloader
  ... there is a delay of 5s before we detect a disconnection ...
  [54079.041238] usb 1-7.4: USB disconnect, device number 72
  [54079.239625] usb 1-7.4: new high-speed USB device number 73 using xhci_hcd
  [54079.359103] usb 1-7.4: New USB device found, idVendor=1b8e, idProduct=fada, bcdDevice= 2.27
  [54079.359110] usb 1-7.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
  [54079.359112] usb 1-7.4: Product: USB download gadget
  [54079.359114] usb 1-7.4: Manufacturer: U-Boot
  [54079.359116] usb 1-7.4: SerialNumber: C8631470CC41

Note: this does not happen when we use the RST button on the board.

To fix this, re-implement a platform reset which calls
board_usb_cleanup() before resetting the board.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 arch/arm/mach-meson/board-g12a.c          | 14 ++++++++++++++
 configs/bananapi-m5_defconfig             |  2 ++
 configs/beelink-gsking-x_defconfig        |  2 ++
 configs/beelink-gtking_defconfig          |  2 ++
 configs/beelink-gtkingpro_defconfig       |  2 ++
 configs/khadas-vim3_android_ab_defconfig  |  2 ++
 configs/khadas-vim3_android_defconfig     |  2 ++
 configs/khadas-vim3_defconfig             |  2 ++
 configs/khadas-vim3l_android_ab_defconfig |  2 ++
 configs/khadas-vim3l_android_defconfig    |  2 ++
 configs/khadas-vim3l_defconfig            |  2 ++
 configs/odroid-c4_defconfig               |  2 ++
 configs/odroid-hc4_defconfig              |  2 ++
 configs/odroid-n2_defconfig               |  2 ++
 configs/radxa-zero_defconfig              |  2 ++
 configs/u200_defconfig                    |  2 ++
 16 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
index 2e59eee8f792..df7d1959aa74 100644
--- a/arch/arm/mach-meson/board-g12a.c
+++ b/arch/arm/mach-meson/board-g12a.c
@@ -17,7 +17,9 @@
 #include <asm/io.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
+#include <linux/psci.h>
 #include <usb.h>
+#include <reset.h>
 #include <linux/usb/otg.h>
 #include <asm/arch/usb.h>
 #include <usb/dwc2_udc.h>
@@ -217,3 +219,15 @@ int board_usb_cleanup(int index, enum usb_init_type init)
 	return 0;
 }
 #endif
+
+#if !CONFIG_IS_ENABLED(PSCI_RESET)
+void reset_misc(void)
+{
+	struct udevice *dev;
+
+	board_usb_cleanup(0, USB_INIT_UNKNOWN);
+
+	uclass_get_device_by_name(UCLASS_FIRMWARE, "psci", &dev);
+	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+}
+#endif
diff --git a/configs/bananapi-m5_defconfig b/configs/bananapi-m5_defconfig
index 6ab2d8ef0c44..df4fbb292a61 100644
--- a/configs/bananapi-m5_defconfig
+++ b/configs/bananapi-m5_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -9,6 +10,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING="bpi-m5"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/beelink-gsking-x_defconfig b/configs/beelink-gsking-x_defconfig
index 2c8c642dcb2d..aa90e49f715e 100644
--- a/configs/beelink-gsking-x_defconfig
+++ b/configs/beelink-gsking-x_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" beelink"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/beelink-gtking_defconfig b/configs/beelink-gtking_defconfig
index 9848252e7e95..c5ff7821997e 100644
--- a/configs/beelink-gtking_defconfig
+++ b/configs/beelink-gtking_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" beelink"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/beelink-gtkingpro_defconfig b/configs/beelink-gtkingpro_defconfig
index 484e039fe034..2f698a2f5210 100644
--- a/configs/beelink-gtkingpro_defconfig
+++ b/configs/beelink-gtkingpro_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="beelink-s922x"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" beelink"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index f3e9f11a8edf..73916ea3b2db 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -11,6 +12,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index f076b6e4e564..fe10741adf89 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -11,6 +12,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index 0cf4bac809b9..bff664726df9 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 828ce6dee9dd..66676dca609a 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -11,6 +12,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3l"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index ee1fa5c31f82..03ccff90e275 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -11,6 +12,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3l"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index f1524f562acb..6b26fedd22c2 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="vim3"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" khadas-vim3l"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
index d244e71866e7..5c2dd96c62b9 100644
--- a/configs/odroid-c4_defconfig
+++ b/configs/odroid-c4_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="odroid-n2"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" odroid-c4/hc4"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index fe70d5f12a16..418fc0271ad7 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="odroid-n2"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" odroid-hc4"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
diff --git a/configs/odroid-n2_defconfig b/configs/odroid-n2_defconfig
index 3703d7e17cee..1d6384817555 100644
--- a/configs/odroid-n2_defconfig
+++ b/configs/odroid-n2_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="odroid-n2"
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -10,6 +11,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" odroid-n2/n2-plus"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/radxa-zero_defconfig b/configs/radxa-zero_defconfig
index d3744f48a31b..a0a0a82a650f 100644
--- a/configs/radxa-zero_defconfig
+++ b/configs/radxa-zero_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -9,6 +10,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" radxa-zero"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
diff --git a/configs/u200_defconfig b/configs/u200_defconfig
index b4f2f21d7eda..d4eb0123c3d7 100644
--- a/configs/u200_defconfig
+++ b/configs/u200_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -9,6 +10,7 @@ CONFIG_MESON_G12A=y
 CONFIG_DEBUG_UART_BASE=0xff803000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_IDENT_STRING=" u200"
+# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_DEBUG_UART=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y

-- 
b4 0.11.0-dev-5166b
