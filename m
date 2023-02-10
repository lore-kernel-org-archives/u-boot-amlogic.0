Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.11071.1676024710271436386
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Feb 2023 02:25:10 -0800
Received: by mail-wm1-f42.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso5925589wms.5
        for <u-boot-amlogic@groups.io>; Fri, 10 Feb 2023 02:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB2/33kgEn+HQCOrg0iRaMKV5CoxKJ9F2y8Ldb2Ffxc=;
        b=NAa2AuIvoUUGAXKFr30p6U7Vum+zBascm5Xvc8pm1xe1JlHxTFIYs5xgSy4ipAjOvV
         +5VByVLUrEspTdoIzoMfb9Njb14OHGnxSyNvNFgo3A2yUQKb2wjVlBHQcL+MPwGfAnPu
         FdyzemO8vHOswVUQs3Wu10oTJa2Bfm46cfvfDH1A8BeKceIwLmrJzMT9wWu/G8aUSaqb
         q0Rf1/4Vxk8fY1oDtcWj81/UQQXfiLtaJTwtfKW8Htwtbz0H9PBRIzFgOh6B1HiTwhnG
         FDnKTxRAaSj4DiZh5x7wAKFVqC1wfPD3x8b8LSc+vhR1djERkxy0e3Z95LLpu0jxsCHB
         Fh4g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Date: Fri, 10 Feb 2023 11:25:07 +0100
Subject: [PATCH] ARM: meson: odroid-go-ultra: setup PMIC regulators are board init
MIME-Version: 1.0
Message-Id: <20230210-u-boot-odroid-go-ultra-pmics-setup-v1-1-1f16d62b76af@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

The Odroid Go Ultra has 2 chained PMICs RK818 and RK818, and needs
an adjustment on the BUCK and LDO values.

Add the initial regulators values in -u-boot.dtsi & run the initial
regulator setup in a new odroid-go-ultra board.

Proper OTG and BOOST regulators are still missing to have USB-A
host properly working.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi |  8 ++++++++
 board/amlogic/odroid-go-ultra/MAINTAINERS          |  7 +++++++
 board/amlogic/odroid-go-ultra/Makefile             |  5 +++++
 board/amlogic/odroid-go-ultra/odroid-go-ultra.c    | 22 ++++++++++++++++++++++
 configs/odroid-go-ultra_defconfig                  |  4 ++--
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
index 00852f5e54..1c0f9765eb 100644
--- a/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
@@ -14,3 +14,11 @@
 &usb3_pcie_phy {
 	/delete-property/ phy-supply;
 };
+
+&vcc_2v3 {
+	regulator-init-microvolt = <2400000>;
+};
+
+&vdd_ee {
+	regulator-init-microvolt = <875000>;
+};
diff --git a/board/amlogic/odroid-go-ultra/MAINTAINERS b/board/amlogic/odroid-go-ultra/MAINTAINERS
new file mode 100644
index 0000000000..c22951b4e7
--- /dev/null
+++ b/board/amlogic/odroid-go-ultra/MAINTAINERS
@@ -0,0 +1,7 @@
+ODROID-GO-ULTRA
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/odroid-go-ultra
+F:	configs/odroid-go-ultra_defconfig
+F:	doc/board/amlogic/odroid-go-ultra.rst
diff --git a/board/amlogic/odroid-go-ultra/Makefile b/board/amlogic/odroid-go-ultra/Makefile
new file mode 100644
index 0000000000..8ebaa0c215
--- /dev/null
+++ b/board/amlogic/odroid-go-ultra/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Neil Armstrong <neil.armstrong@linaro.org>
+
+obj-y	:= odroid-go-ultra.o
diff --git a/board/amlogic/odroid-go-ultra/odroid-go-ultra.c b/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
new file mode 100644
index 0000000000..bbd23e20fc
--- /dev/null
+++ b/board/amlogic/odroid-go-ultra/odroid-go-ultra.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <common.h>
+#include <asm/arch/boot.h>
+#include <power/regulator.h>
+
+int mmc_get_env_dev(void)
+{
+	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
+		return 1;
+	return 0;
+}
+
+int board_init(void)
+{
+	regulators_enable_boot_on(_DEBUG);
+
+	return 0;
+}
diff --git a/configs/odroid-go-ultra_defconfig b/configs/odroid-go-ultra_defconfig
index a4d349fba4..c71c82dd1d 100644
--- a/configs/odroid-go-ultra_defconfig
+++ b/configs/odroid-go-ultra_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="w400"
+CONFIG_SYS_BOARD="odroid-go-ultra"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
@@ -17,7 +17,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_REMAKE_ELF=y
 CONFIG_OF_BOARD_SETUP=y
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_MISC_INIT_R=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
@@ -27,6 +26,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y

---
base-commit: d1f5dbe6645ad51e318dd322033fe6a08bce357b
change-id: 20230210-u-boot-odroid-go-ultra-pmics-setup-0e79dad28de6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

