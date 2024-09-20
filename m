Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F0AC78841
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 13:33:49 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.18322.1726839219429671716
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Sep 2024 06:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=IutIM6jr;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso24776375e9.1
        for <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726839218; x=1727444018; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D82H80JWnLl93uU6ZnbQzaWt6tBC/852dCGNwYDfFiQ=;
        b=IutIM6jrogHHFXmyr2l15M8fQIZPf6lZAqmVjtxbTZA4N85Yh8lIFlkCJTj4I6lp5S
         wbSrGbX07NJiR3Pay1xmMMgwmG/w3UqKTRC/0VM+BAPKVvsbFbpfJzR4VM4h0VpBUJrY
         GRdYNt4PdUpfnd5PLgcEmmqJ8WMgou8aTMbwWSy7kSBKCSCwb82ytkgJW4OHKA+faL7P
         qjMe1Lep1Nt6zsZnTWyhvmiNAwqmlqajFpWZrHw/GbU2c2ijJONkTap7ubkZ2zui3O6U
         nXDlXHaCzIDrpsPx1jNLtBQusKMJSgFFXn3825v/Gi6GmWfQHVsqnk3lNQWaPCbJUKoC
         wBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726839218; x=1727444018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D82H80JWnLl93uU6ZnbQzaWt6tBC/852dCGNwYDfFiQ=;
        b=XUM8JMsK6yJM689tKK3xsnf1KL8sD1RIuOsYRLRkBQ8TmJ9ejWLIMxDCJ1jWKHxysU
         bRrr4JKWJ5kybQhXmBx2S/PPj5xNHXlepvUjaJ7oP1rCXCzNnujIEX8h8LcgRpvCAoLF
         ziQ5+sP1zYT5B6evkjaseA+T+Y8DyhCtqihrOIMcIEztmz9QXDEWQDJp+sI12KucKljE
         YmhppoRgBYLkG+zhy5ME17gMJbF1ulSPPUhSTBDbLZEIE5dZFQJdXKqkfy3otsUZ/Qpp
         4IuesTCDSDx63GGBFQj7K95JoqqsjvP24Nw9hF8v8dkHLpp4ZoHRZPOavIjRJJVCRnLg
         eotQ==
X-Gm-Message-State: AOJu0YzJVS5vi3HEKqSBD9repaXgd2nK/d1MxSKb7qvHup8bGPMVdApU
	d1tUJ1b9y+Q8BB4Cradf7XOxwpT8ogRBvUQaMFnPSmwauwkQTH1BNdJKpQNKyAw=
X-Google-Smtp-Source: AGHT+IEljpnFu6UiUnuaG2eal8EeefdLTqClHXm0AyrscwpQe5ObD56xbJUv/IUP62sQsP6UWUqV/Q==
X-Received: by 2002:a05:600c:1d9a:b0:42c:df29:2366 with SMTP id 5b1f17b1804b1-42e7adf70bfmr28656345e9.33.1726839217706;
        Fri, 20 Sep 2024 06:33:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780df0bsm17557466f8f.113.2024.09.20.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:33:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 15:33:34 +0200
Subject: [PATCH 2/2] ARM: meson: add support for Libre Computer
 aml-s905d3-cc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-2-8915b108840b@linaro.org>
References: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
In-Reply-To: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, da@libre.computer, 
 ilias.apalodimas@linaro.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9718;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=J+jm6x5sqtn5fmJgaZZmennVFocTdnVIXwisTQjmzGU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7XmurN1XZQSPwApDyX7F4surDebxOczVua+iqK5q
 6PusiNeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu15rgAKCRB33NvayMhJ0dswEA
 C1bgJVZcyLu0aA3eI5poNaKol8FsSXVTBZFRmDJYiR1tHp7/ltmG/0qxNVbM2f5+sin3m/BbBi+qB5
 qr6fyV6xrlPxl4OlucGHEzn11reDKDssDVbJ/OHDZ+7hCKNZfGSI6VqzD3mzdwkWwaQZlVSvJQ1Mym
 19FNB3J0I7aM4PPIm9Iecn9pYvpilVi9myiP1RUAL+WscRFud9kjA7xlZLdZED70tLow24aGt+EKQ2
 WKqxQlzaIUmGacKK0PVD+ahOr/dW1Y9CuUso84YCOnCdWwa8b7eO/uKsDlAdVoN1f98+8+srpw0xtR
 XoTLWeOsbB216cfhT6WihH5vGf7SCxp5WsZvsT6PUeXCFDq/wQRqku8VdfixH++AFQoK5PJ+oN/auc
 N6ZRqciKuFtyb3jrGxeVLL/kR7Y0DD8ZMWjvOTFJCr7TvDdNIKfR5MpWqatdmmrJ/+zGQdl7z+aiGI
 1CpccnYZp5dZZOoddLCCpYyWKztUgbcuZdo/wnHWp2580U+r4G89JCatnOR6I2AxePg0s792bkC6bd
 ta1iBbAPPPrq2/5TRlw+Kn1CtGQwgbRbm/YxNeX4jmGpRHKNAOetlefvqhknB60GT4RmLwHmP2Cl6+
 8/lXGrLMitMHfg2qWSB5cPxlzdFsPQsbFYtQ0mnAvhodk+IXXftVTtFcZmVw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 13:33:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2402

Add support for the Libre Computer aml-s905d3-cc "Solitude" board:
https://libre.computer/products/aml-s905d3-cc/

The Solitude board has a Credit Card form factor, similar to the
the previous "Le Potato" card, but with the Amlogic A311D SoC,
MIPI DSI and CSI connectors. PoE header and a single USB2 Type-C
connector replacing the microUSB one for power and USB 2.0.

The board has an embedded SPI NOR flash, and EFI Capsule support
is added.

The GUID is dynamically generated for the board, to get it:
=> efidebug capsule esrt
========================================
ESRT: fw_resource_count=1
ESRT: fw_resource_count_max=1
ESRT: fw_resource_version=1
[entry 0]==============================
ESRT: fw_class=4302C3CB-2502-5EFE-87E0-894A8A322893
ESRT: fw_type=unknown
ESRT: fw_version=0
ESRT: lowest_supported_fw_version=0
ESRT: capsule_flags=0
ESRT: last_attempt_version=0
ESRT: last_attempt_status=success
========================================

On the host (with the aml_encrypt_g12a result binary):
$ eficapsule --guid 4302C3CB-2502-5EFE-87E0-894A8A322893 -i 1 u-boot.bin u-boot.cap

On the board (from USB disk containing u-boot.cap at root):
=> load usb 0:1 $kernel_addr_r u-boot.cap
=> efidebug capsule update $kernel_addr_r

The binary will then be flashed on the SPI.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi  |  15 +++
 board/libre-computer/aml-s905d3-cc/MAINTAINERS     |   7 ++
 board/libre-computer/aml-s905d3-cc/Makefile        |   6 ++
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  44 +++++++++
 configs/aml-s905d3-cc_defconfig                    | 108 +++++++++++++++++++++
 doc/board/amlogic/aml-s905d3-cc.rst                |  46 +++++++++
 doc/board/amlogic/index.rst                        |   1 +
 7 files changed, 227 insertions(+)

diff --git a/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi b/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi
new file mode 100644
index 00000000000..1c4f019120f
--- /dev/null
+++ b/arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include "meson-g12-common-u-boot.dtsi"
+
+&sd_emmc_c {
+	pinctrl-0 = <&emmc_ctrl_pins>, <&emmc_data_4b_pins>, <&emmc_ds_pins>;
+	bus-width = <4>;
+};
+
+&spifc {
+	status = "okay";
+};
diff --git a/board/libre-computer/aml-s905d3-cc/MAINTAINERS b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
new file mode 100644
index 00000000000..4b75c815c07
--- /dev/null
+++ b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
@@ -0,0 +1,7 @@
+LIBRE-COMPUTER AML-S905D3-CC
+M:	Neil Armstrong <neil.armstrong@linaro.org>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/aml-s905d3-cc/
+F:	configs/aml-s905d3-cc_defconfig
+F:	doc/board/amlogic/aml-s905d3-cc.rst
diff --git a/board/libre-computer/aml-s905d3-cc/Makefile b/board/libre-computer/aml-s905d3-cc/Makefile
new file mode 100644
index 00000000000..7d2c41e6436
--- /dev/null
+++ b/board/libre-computer/aml-s905d3-cc/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= aml-s905d3-cc.o
diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
new file mode 100644
index 00000000000..f641db5a494
--- /dev/null
+++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <init.h>
+#include <net.h>
+#include <efi_loader.h>
+#include <asm/io.h>
+#include <asm/arch/eth.h>
+
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"AML_S905D3_CC_BOOT",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (strcmp(interface, "ram") == 0)
+		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
+	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
+int misc_init_r(void)
+{
+	meson_generate_serial_ethaddr();
+
+	return 0;
+}
diff --git a/configs/aml-s905d3-cc_defconfig b/configs/aml-s905d3-cc_defconfig
new file mode 100644
index 00000000000..a6e5d584c0a
--- /dev/null
+++ b/configs/aml-s905d3-cc_defconfig
@@ -0,0 +1,108 @@
+CONFIG_ARM=y
+CONFIG_SYS_VENDOR="libre-computer"
+CONFIG_SYS_BOARD="aml-s905d3-cc"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x01000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFF0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-sm1-s905d3-libretech-cc"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING="aml-s905d3-cc"
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_SYS_MAXARGS=32
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_DFU=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ADC=y
+CONFIG_SARADC_MESON=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MESON_SPIFC=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
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
+CONFIG_VIDEO=y
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
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/doc/board/amlogic/aml-s905d3-cc.rst b/doc/board/amlogic/aml-s905d3-cc.rst
new file mode 100644
index 00000000000..083a591fc52
--- /dev/null
+++ b/doc/board/amlogic/aml-s905d3-cc.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+U-Boot for Libre Computer AML-S905D3-CC 'Solitude' (S905D3)
+===========================================================
+
+AML-S905D3-CC is a Single Board Computer manufactured by Libre Computer Technology with
+the following specifications:
+
+ - Amlogic S905D3 Cortex-A55 quad-core SoC
+ - 2 or 4GB LPDDR4 SDRAM
+ - Gigabit Ethernet
+ - HDMI 2.1 display
+ - 40-pin GPIO header
+ - 4 x USB 3.0 Host, 1 x USB 2.0 Type-C
+ - eMMC 5.x SM Interface for Libre Computer Modules
+ - microSD
+ - Infrared receiver
+
+Schematics are available on the manufacturer website.
+
+U-Boot Compilation
+------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make aml-s905d3-cc_defconfig
+    $ make
+
+U-Boot Signing with Pre-Built FIP repo
+--------------------------------------
+
+.. code-block:: bash
+
+    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
+    $ cd amlogic-boot-fip
+    $ mkdir my-output-dir
+    $ ./build-fip.sh aml-s905d3-cc /path/to/u-boot/u-boot.bin my-output-dir
+
+Then write U-Boot to SD or eMMC with:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index de91b21f977..dcd935224ac 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -86,6 +86,7 @@ Board Documentation
    :maxdepth: 1
 
    aml-a311d-cc
+   aml-s905d3-cc
    bananapi-cm4io
    bananapi-m2pro
    bananapi-m2s

-- 
2.34.1


