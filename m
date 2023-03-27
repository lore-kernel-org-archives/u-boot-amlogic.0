Received: from sonic313-46.consmr.mail.sg3.yahoo.com (sonic313-46.consmr.mail.sg3.yahoo.com [106.10.240.105])
 by mx.groups.io with SMTP id smtpd.web10.41286.1679936104340036827
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Mar 2023 09:55:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679936101; bh=vMH0FdG+pVVk72U+XwEXW5RnSQSwbWbkClV+syiEhkg=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=JFCYqG16ptjbofXqmOM35KgMb9FKBCnYKlta0s2accYDvBm7iRHAVDY2plt0kfmuSM5GpBLqLjcm/EYp/GdBVHPhmmnIgxiaI5MRDBOSmqb4jh4Whl2XfUMgr89uhlrQh/bPDiL4/kjI+h48gXMvV0k62yzBYImXc9HnF+7lafDJjJ8A5X6ncl9FQnR6FFg7Z/6COcL2Vrk/fWoKa29V8HA+PiM+NqBWsgAUZIbdMgLDiSBj7swsYKZIlML0n2prhYTueQAsqR3PEFIcEUF+WaMhW0Mzx6t81yFRxqNylBrSklxptEdyZGLrFULLUuoVYsMwVX+ZmpM8r9WHM7itug==
Message-ID: <8aaf7344-e65b-4060-3cb8-34a8a2ea2441@yahoo.com>
Date: Tue, 28 Mar 2023 04:06:12 +0800
MIME-Version: 1.0
From: "Karl Chan" <exkcmailist@yahoo.com>
Subject: [RESENT][PATCHv7 1/3] ARM: dts: add support for Beelink GT1 Ultimate
References: <8aaf7344-e65b-4060-3cb8-34a8a2ea2441.ref@yahoo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Import the device-tree from linux-amlogic/for-next (Linux 6.3-rc1).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
  arch/arm/dts/Makefile                         |  1 +
  .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
  arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
  3 files changed, 99 insertions(+)
  create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1c843882d1..b4ac7e9877 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -200,6 +200,7 @@ dtb-$(CONFIG_ARCH_MESON) += \
      meson-gxl-s905x-libretech-cc.dtb \
      meson-gxl-s905x-libretech-cc-v2.dtb \
      meson-gxl-s905x-p212.dtb \
+    meson-gxm-gt1-ultimate.dtb \
      meson-gxm-khadas-vim2.dtb \
      meson-gxm-s912-libretech-pc.dtb \
      meson-gxm-wetek-core2.dtb \
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi 
b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
new file mode 100644
index 0000000000..39270ea71c
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gxl-u-boot.dtsi"
diff --git a/arch/arm/dts/meson-gxm-gt1-ultimate.dts 
b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
new file mode 100644
index 0000000000..2c267884cc
--- /dev/null
+++ b/arch/arm/dts/meson-gxm-gt1-ultimate.dts
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+    compatible = "azw,gt1-ultimate", "amlogic,s912", "amlogic,meson-gxm";
+    model = "Beelink GT1 Ultimate";
+
+    leds {
+        compatible = "gpio-leds";
+
+        led-white {
+            color = <LED_COLOR_ID_WHITE>;
+            function = LED_FUNCTION_POWER;
+            gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
+            default-state = "on";
+            panic-indicator;
+        };
+    };
+
+    adc-keys {
+        compatible = "adc-keys";
+        io-channels = <&saradc 0>;
+        io-channel-names = "buttons";
+        keyup-threshold-microvolt = <1710000>;
+
+        button-function {
+            label = "update";
+            linux,code = <KEY_VENDOR>;
+            press-threshold-microvolt = <10000>;
+        };
+    };
+};
+
+&ethmac {
+    pinctrl-0 = <&eth_pins>;
+    pinctrl-names = "default";
+    phy-handle = <&external_phy>;
+    amlogic,tx-delay-ns = <2>;
+    phy-mode = "rgmii";
+};
+
+&external_mdio {
+    external_phy: ethernet-phy@0 {
+        /* Realtek RTL8211F (0x001cc916) */
+        reg = <0>;
+        max-speed = <1000>;
+
+        reset-assert-us = <10000>;
+        reset-deassert-us = <80000>;
+        reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+        interrupt-parent = <&gpio_intc>;
+        /* MAC_INTR on GPIOZ_15 */
+        interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+    };
+};
+
+&ir {
+    linux,rc-map-name = "rc-beelink-gs1";
+};
+
+&sd_emmc_a {
+    brcmf: wifi@1 {
+        reg = <1>;
+        compatible = "brcm,bcm4329-fmac";
+    };
+};
+
+&uart_A {
+    status = "okay";
+    pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+    pinctrl-names = "default";
+    uart-has-rtscts;
+
+    bluetooth {
+        compatible = "brcm,bcm43438-bt";
+        shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+        max-speed = <2000000>;
+        clocks = <&wifi32k>;
+        clock-names = "lpo";
+    };
+};
