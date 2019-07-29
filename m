Received: by mail-wr1-f68.google.com with SMTP id x1so12108015wrr.9
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tsQTxTGBkyUPZ6+UQnNXuSW1Iroif7ej/wptYt/RvQ=;
        b=hATNzC/dIxTozcUSnJ7fy0WYBVLe5vvigRtr9rzUk43djIGaUQJwLbRFgrJPJqKNwW
         cTnab66nIdNMgwOHN9Q+flDTGuBSKAcUw1xlsgT3NfgJC6/rFtr8t9O7nckVb6ezbv7C
         ot0pDn1Aqh1XXwTx4qcYOqQ7PPrXWrWvZLLoQNRGFY2kqxCpW8Q09LqIyII2w4WdaX4N
         4akfZW62294jbL+GnVFOiZ0CNZx+B6CdI+hnVLSMuOvDg4NIc++kQApon8NPAaXiokoE
         C23CstKgXjoM0J7tIMmjQt/Dq6Y3+iJe6c48SyVpAGWkmETtvBqDsVY/YOUEh2mwW7mB
         MClw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RESEND PATCH 3/5] boards: meson: add g12a sei510
Date: Mon, 29 Jul 2019 16:07:49 +0200
Message-Id: <20190729140751.7851-4-narmstrong@baylibre.com>
In-Reply-To: <20190729140751.7851-1-narmstrong@baylibre.com>
References: <20190729140751.7851-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

From: Jerome Brunet <jbrunet@baylibre.com>

The SEI510 board is based on the Amlogic S905X2 SoC
from the Amlogic G12A SoC family.

The board has the following specifications :
- Amlogic S905X2 ARM Cortex-A53 quad-core SoC
- XGB DDR4 SDRAM
- 10/100 Ethernet (Internal PHY)
- 1 x USB 3.0 Host
- eMMC
- SDcard
- Infrared receiver
- SDIO WiFi Module

The board default behaviour is for booting Android and triggers
fastboot on recovery or reboot mode.

USB vendor ID (used by fastboot) is 0x18d1 (Google) for
default udev rules for existing android users work out of the box.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/sm.h |  18 ++++
 arch/arm/mach-meson/sm.c             | 155 +++++++++++++++++++++++++++
 board/amlogic/sei510/MAINTAINERS     |   5 +
 board/amlogic/sei510/Makefile        |   6 ++
 board/amlogic/sei510/README          | 123 +++++++++++++++++++++
 board/amlogic/sei510/sei510.c        |  26 +++++
 configs/sei510_defconfig             |  74 +++++++++++++
 include/configs/sei510.h             | 137 +++++++++++++++++++++++
 8 files changed, 544 insertions(+)
 create mode 100644 board/amlogic/sei510/MAINTAINERS
 create mode 100644 board/amlogic/sei510/Makefile
 create mode 100644 board/amlogic/sei510/README
 create mode 100644 board/amlogic/sei510/sei510.c
 create mode 100644 configs/sei510_defconfig
 create mode 100644 include/configs/sei510.h

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
index 60d04ae228..6ae52cc584 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -6,7 +6,25 @@
 #ifndef __MESON_SM_H__
 #define __MESON_SM_H__
 
+enum {
+	REBOOT_REASON_COLD = 0,
+	REBOOT_REASON_NORMAL = 1,
+	REBOOT_REASON_RECOVERY = 2,
+	REBOOT_REASON_UPDATE = 3,
+	REBOOT_REASON_FASTBOOT = 4,
+	REBOOT_REASON_SUSPEND_OFF = 5,
+	REBOOT_REASON_HIBERNATE = 6,
+	REBOOT_REASON_BOOTLOADER = 7,
+	REBOOT_REASON_SHUTDOWN_REBOOT = 8,
+	REBOOT_REASON_RPMBP = 9,
+	REBOOT_REASON_CRASH_DUMP = 11,
+	REBOOT_REASON_KERNEL_PANIC = 12,
+	REBOOT_REASON_WATCHDOG_REBOOT = 13,
+};
+
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
+int meson_sm_get_serial(void *buffer, size_t size);
+int meson_sm_get_reboot_reason(void);
 
 #define SM_SERIAL_SIZE	12
 
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 05b7f0bdf2..51a697df4a 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -8,6 +8,10 @@
 #include <common.h>
 #include <asm/arch/sm.h>
 #include <linux/kernel.h>
+#include <dm.h>
+#include <linux/bitfield.h>
+#include <regmap.h>
+#include <syscon.h>
 
 #define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
 #define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
@@ -77,3 +81,154 @@ int meson_sm_get_serial(void *buffer, size_t size)
 
 	return 0;
 }
+
+#define AO_SEC_SD_CFG15		0xfc
+#define REBOOT_REASON_MASK	GENMASK(15, 12)
+
+int meson_sm_get_reboot_reason(void)
+{
+	struct regmap *regmap;
+	int nodeoffset;
+	ofnode node;
+	unsigned int reason;
+
+	/* find the offset of compatible node */
+	nodeoffset = fdt_node_offset_by_compatible(gd->fdt_blob, -1,
+						   "amlogic,meson-gx-ao-secure");
+	if (nodeoffset < 0) {
+		printf("%s: failed to get amlogic,meson-gx-ao-secure\n",
+		       __func__);
+		return -ENODEV;
+	}
+
+	/* get regmap from the syscon node */
+	node = offset_to_ofnode(nodeoffset);
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		printf("%s: failed to get regmap\n", __func__);
+		return -EINVAL;
+	}
+
+	regmap_read(regmap, AO_SEC_SD_CFG15, &reason);
+
+	/* The SMC call is not used, we directly use AO_SEC_SD_CFG15 */
+	return FIELD_GET(REBOOT_REASON_MASK, reason);
+}
+
+static int do_sm_serial(cmd_tbl_t *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	ulong address;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	address = simple_strtoul(argv[1], NULL, 0);
+
+	ret = meson_sm_get_serial((void *)address, SM_CHIP_ID_SIZE);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+#define MAX_REBOOT_REASONS 14
+
+static const char *reboot_reasons[MAX_REBOOT_REASONS] = {
+	[REBOOT_REASON_COLD] = "cold_boot",
+	[REBOOT_REASON_NORMAL] = "normal",
+	[REBOOT_REASON_RECOVERY] = "recovery",
+	[REBOOT_REASON_UPDATE] = "update",
+	[REBOOT_REASON_FASTBOOT] = "fastboot",
+	[REBOOT_REASON_SUSPEND_OFF] = "suspend_off",
+	[REBOOT_REASON_HIBERNATE] = "hibernate",
+	[REBOOT_REASON_BOOTLOADER] = "bootloader",
+	[REBOOT_REASON_SHUTDOWN_REBOOT] = "shutdown_reboot",
+	[REBOOT_REASON_RPMBP] = "rpmbp",
+	[REBOOT_REASON_CRASH_DUMP] = "crash_dump",
+	[REBOOT_REASON_KERNEL_PANIC] = "kernel_panic",
+	[REBOOT_REASON_WATCHDOG_REBOOT] = "watchdog_reboot",
+};
+
+static int do_sm_reboot_reason(cmd_tbl_t *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	const char *reason_str;
+	char *destarg = NULL;
+	int reason;
+
+	if (argc > 1)
+		destarg = argv[1];
+
+	reason = meson_sm_get_reboot_reason();
+	if (reason < 0)
+		return CMD_RET_FAILURE;
+
+	if (reason >= MAX_REBOOT_REASONS ||
+	    !reboot_reasons[reason])
+		reason_str = "unknown";
+	else
+		reason_str = reboot_reasons[reason];
+
+	if (destarg)
+		env_set(destarg, reason_str);
+	else
+		printf("reboot reason: %s (%x)\n", reason_str, reason);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_sm_efuse_read(cmd_tbl_t *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	ulong offset;
+	ulong size;
+	ulong dest;
+
+	if (argc < 4)
+		return CMD_RET_FAILURE;
+
+	offset = simple_strtoul(argv[1], NULL, 0);
+	size = simple_strtoul(argv[2], NULL, 0);
+	dest = simple_strtoul(argv[3], NULL, 0);
+
+	if (meson_sm_read_efuse(offset, (void *)dest, size) != -1)
+		return CMD_RET_SUCCESS;
+
+	return CMD_RET_FAILURE;
+}
+
+static cmd_tbl_t cmd_sm_sub[] = {
+	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
+	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
+	U_BOOT_CMD_MKENT(efuse_read, 4, 1, do_sm_efuse_read, "", ""),
+};
+
+static int do_sm(cmd_tbl_t *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	cmd_tbl_t *c;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	/* Strip off leading 'sm' command argument */
+	argc--;
+	argv++;
+
+	c = find_cmd_tbl(argv[0], &cmd_sm_sub[0], ARRAY_SIZE(cmd_sm_sub));
+
+	if (c)
+		return c->cmd(cmdtp, flag, argc, argv);
+	else
+		return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	sm, 5, 0, do_sm,
+	"Secure Monitor Control",
+	"serial <address> - read chip unique id to memory address\n"
+	"sm reboot_reason [name] - get reboot reason and store to to environment\n"
+	"sm efuse_read <offset> <length> <address> - read length bytes from efuse offset to memory address"
+);
diff --git a/board/amlogic/sei510/MAINTAINERS b/board/amlogic/sei510/MAINTAINERS
new file mode 100644
index 0000000000..792ae22176
--- /dev/null
+++ b/board/amlogic/sei510/MAINTAINERS
@@ -0,0 +1,5 @@
+U200
+M:	Neil Armstrong <narmstrong@baylibre.com>
+S:	Maintained
+F:	board/amlogic/sei510/
+F:	configs/sei510_defconfig
diff --git a/board/amlogic/sei510/Makefile b/board/amlogic/sei510/Makefile
new file mode 100644
index 0000000000..03399a3849
--- /dev/null
+++ b/board/amlogic/sei510/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2016 BayLibre, SAS
+# Author: Neil Armstrong <narmstrong@baylibre.com>
+
+obj-y	:= sei510.o
diff --git a/board/amlogic/sei510/README b/board/amlogic/sei510/README
new file mode 100644
index 0000000000..216ff06093
--- /dev/null
+++ b/board/amlogic/sei510/README
@@ -0,0 +1,123 @@
+U-Boot for Amlogic SEI510
+=======================
+
+SEI510 is a custemer board manufactured by SEI Robotics with the following
+specifications:
+
+ - Amlogic S905X2 ARM Cortex-A53 quad-core SoC
+ - 2GB DDR4 SDRAM
+ - 10/100 Ethernet (Internal PHY)
+ - 1 x USB 3.0 Host
+ - eMMC
+ - SDcard
+ - Infrared receiver
+ - SDIO WiFi Module
+
+Currently the u-boot port supports the following devices:
+ - serial
+ - Ethernet
+ - Regulators
+ - Clock controller
+
+u-boot compilation
+==================
+
+ > export ARCH=arm
+ > export CROSS_COMPILE=aarch64-none-elf-
+ > make sei510_defconfig
+ > make
+
+Image creation
+==============
+
+Amlogic doesn't provide sources for the firmware and for tools needed
+to create the bootloader image, so it is necessary to obtain them from
+the git tree published by the board vendor:
+
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > wget https://releases.linaro.org/archive/13.11/components/toolchain/binaries/gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
+ > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
+ > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
+ > git clone https://github.com/BayLibre/u-boot.git -b buildroot-openlinux-20180418 amlogic-u-boot
+ > cd amlogic-u-boot
+ > make g12a_u200_v1_defconfig
+ > make
+ > export UBOOTDIR=$PWD
+
+Download the latest Amlogic Buildroot package, and extract it :
+ > wget http://openlinux2.amlogic.com:8000/ARM/filesystem/Linux_BSP/buildroot_openlinux_kernel_4.9_fbdev_20180706.tar.gz
+ > tar xfz buildroot_openlinux_kernel_4.9_fbdev_20180706.tar.gz buildroot_openlinux_kernel_4.9_fbdev_20180706/bootloader
+ > export BRDIR=$PWD/buildroot_openlinux_kernel_4.9_fbdev_20180706
+ > export FIPDIR=$BRDIR/bootloader/uboot-repo/fip
+
+Go back to mainline U-Boot source tree then :
+ > mkdir fip
+
+ > wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
+ > cp $UBOOTDIR/build/scp_task/bl301.bin fip/
+ > cp $UBOOTDIR/build/board/amlogic/g12a_u200_v1/firmware/acs.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl2/bin/g12a/bl2.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl30/bin/g12a/bl30.bin fip/
+ > cp $BRDIR/bootloader/uboot-repo/bl31_1.3/bin/g12a/bl31.img fip/
+ > cp $FIPDIR/g12a/ddr3_1d.fw fip/
+ > cp $FIPDIR/g12a/ddr4_1d.fw fip/
+ > cp $FIPDIR/g12a/ddr4_2d.fw fip/
+ > cp $FIPDIR/g12a/diag_lpddr4.fw fip/
+ > cp $FIPDIR/g12a/lpddr4_1d.fw fip/
+ > cp $FIPDIR/g12a/lpddr4_2d.fw fip/
+ > cp $FIPDIR/g12a/piei.fw fip/
+ > cp u-boot.bin fip/bl33.bin
+
+ > sh fip/blx_fix.sh \
+	fip/bl30.bin \
+	fip/zero_tmp \
+	fip/bl30_zero.bin \
+	fip/bl301.bin \
+	fip/bl301_zero.bin \
+	fip/bl30_new.bin \
+	bl30
+
+ > sh fip/blx_fix.sh \
+	fip/bl2.bin \
+	fip/zero_tmp \
+	fip/bl2_zero.bin \
+	fip/acs.bin \
+	fip/bl21_zero.bin \
+	fip/bl2_new.bin \
+	bl2
+
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl30sig --input fip/bl30_new.bin \
+					--output fip/bl30_new.bin.g12a.enc \
+					--level v3
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl30_new.bin.g12a.enc \
+					--output fip/bl30_new.bin.enc \
+					--level v3 --type bl30
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl31.img \
+					--output fip/bl31.img.enc \
+					--level v3 --type bl31
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl3sig --input fip/bl33.bin --compress lz4 \
+					--output fip/bl33.bin.enc \
+					--level v3 --type bl33
+ > $FIPDIR/g12a/aml_encrypt_g12a --bl2sig --input fip/bl2_new.bin \
+					--output fip/bl2.n.bin.sig
+ > $FIPDIR/g12a/aml_encrypt_g12a --bootmk \
+		--output fip/u-boot.bin \
+		--bl2 fip/bl2.n.bin.sig \
+		--bl30 fip/bl30_new.bin.enc \
+		--bl31 fip/bl31.img.enc \
+		--bl33 fip/bl33.bin.enc \
+		--ddrfw1 fip/ddr4_1d.fw \
+		--ddrfw2 fip/ddr4_2d.fw \
+		--ddrfw3 fip/ddr3_1d.fw \
+		--ddrfw4 fip/piei.fw \
+		--ddrfw5 fip/lpddr4_1d.fw \
+		--ddrfw6 fip/lpddr4_2d.fw \
+		--ddrfw7 fip/diag_lpddr4.fw \
+		--level v3
+
+and then write the image to SD with:
+
+ > DEV=/dev/your_sd_device
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
+ > dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=444
diff --git a/board/amlogic/sei510/sei510.c b/board/amlogic/sei510/sei510.c
new file mode 100644
index 0000000000..a92fccd3fd
--- /dev/null
+++ b/board/amlogic/sei510/sei510.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <environment.h>
+#include <asm/io.h>
+#include <asm/arch/axg.h>
+#include <asm/arch/sm.h>
+#include <asm/arch/eth.h>
+#include <asm/arch/mem.h>
+
+int misc_init_r(void)
+{
+	meson_eth_init(PHY_INTERFACE_MODE_RMII,
+		       MESON_USE_INTERNAL_RMII_PHY);
+
+	meson_generate_serial_ethaddr();
+
+	env_set("serial#", "AMLG12ASEI510");
+
+	return 0;
+}
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
new file mode 100644
index 0000000000..20534bd6b4
--- /dev/null
+++ b/configs/sei510_defconfig
@@ -0,0 +1,74 @@
+CONFIG_ARM=y
+CONFIG_SYS_CONFIG_NAME="sei510"
+CONFIG_SYS_BOARD="sei510"
+CONFIG_ARCH_MESON=y
+CONFIG_SYS_TEXT_BASE=0x01000000
+CONFIG_MESON_G12A=y
+CONFIG_DEBUG_UART_BASE=0xff803000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" sei510"
+CONFIG_DEBUG_UART=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_MISC_INIT_R=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO=y
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_FDT=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_LZ4=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_DEFAULT_DEVICE_TREE="meson-g12a-sei510"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_MMC=y
+CONFIG_MMC_MESON_GX=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_ADDR=8
+CONFIG_DM_ETH=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_G12A=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RESET=y
+CONFIG_DEBUG_UART_MESON=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_USB=y
+CONFIG_USB_HOST=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_PHY=y
+CONFIG_MESON_G12A_USB_PHY=y
+CONFIG_DM_USB=y
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_MESON_G12A=y
+CONFIG_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xfada
+CONFIG_OF_LIBFDT=y
+CONFIG_EFI_PARTITION=y
+CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_PART=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
new file mode 100644
index 0000000000..9957902250
--- /dev/null
+++ b/include/configs/sei510.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration for the SEI510
+ *
+ * Copyright (C) 2019 Baylibre, SAS
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CONFIG_SYS_MMC_ENV_DEV	2
+#define CONFIG_SYS_MMC_ENV_PART	1
+#define CONFIG_ENV_SIZE		0x10000
+#define CONFIG_ENV_OFFSET	(-0x10000)
+
+#define CACHE_UUID "99207ae6-5207-11e9-999e-6f77a3612069;"
+#define SYSTEM_UUID "99f9b7ac-5207-11e9-8507-c3c037e393f3;"
+#define VENDOR_UUID "9d082802-5207-11e9-954c-cbbce08ba108;"
+#define USERDATA_UUID "9b976e42-5207-11e9-8f16-ff47ac594b22;"
+#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
+
+#define PARTS_DEFAULT                                        \
+	"uuid_disk=${uuid_gpt_disk};"  			\
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=cache,size=256M,uuid=" CACHE_UUID             \
+	"name=system,size=1536M,uuid=" SYSTEM_UUID           \
+	"name=vendor,size=256M,uuid=" VENDOR_UUID            \
+	"name=userdata,size=4746M,uuid=" USERDATA_UUID	\
+	"name=rootfs,size=-,uuid=" ROOT_UUID
+
+#define BOOTENV_DEV_FASTBOOT(devtypeu, devtypel, instance) \
+	"bootcmd_fastboot=" \
+		"sm reboot_reason reason;" \
+		"setenv run_fastboot 0;" \
+		"if gpt verify mmc ${mmcdev} ${partitions}; then; " \
+		"else " \
+			"echo Broken MMC partition scheme;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${reason}\" = \"bootloader\" -o " \
+			"\"${reason}\" = \"fastboot\"; then " \
+			"echo Fastboot asked by reboot reason;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${skip_fastboot}\" -eq 1; then " \
+			"echo Fastboot skipped by environment;" \
+			"setenv run_fastboot 0;" \
+		"fi;" \
+		"if test \"${force_fastboot}\" -eq 1; then " \
+			"echo Fastboot forced by environment;" \
+			"setenv run_fastboot 1;" \
+		"fi;" \
+		"if test \"${run_fastboot}\" -eq 1; then " \
+			"echo Running Fastboot...;" \
+			"fastboot 0;" \
+		"fi\0"
+
+#define BOOTENV_DEV_NAME_FASTBOOT(devtypeu, devtypel, instance)	\
+		"fastboot "
+
+/* TOFIX: Run actual recovery instead of fastboot */
+#define BOOTENV_DEV_RECOVERY(devtypeu, devtypel, instance) \
+	"bootcmd_recovery=" \
+		"pinmux dev pinctrl@14;" \
+		"pinmux dev pinctrl@40;" \
+		"sm reboot_reason reason;" \
+		"setenv run_recovery 0;" \
+		"if run check_button; then " \
+			"echo Recovery button is pressed;" \
+			"setenv run_recovery 1;" \
+		"elif test \"${reason}\" = \"recovery\" -o " \
+			  "\"${reason}\" = \"update\"; then " \
+			"echo Recovery asked by reboot reason;" \
+			"setenv run_recovery 1;" \
+		"fi;" \
+		"if test \"${skip_recovery}\" -eq 1; then " \
+			"echo Recovery skipped by environment;" \
+			"setenv run_recovery 0;" \
+		"fi;" \
+		"if test \"${force_recovery}\" -eq 1; then " \
+			"echo Recovery forced by environment;" \
+			"setenv run_recovery 1;" \
+		"fi;" \
+		"if test \"${run_recovery}\" -eq 1; then " \
+			"echo Running Recovery...;" \
+			"fastboot 0;" \
+		"fi\0"
+
+#define BOOTENV_DEV_NAME_RECOVERY(devtypeu, devtypel, instance)	\
+		"recovery "
+
+#define BOOTENV_DEV_SYSTEM(devtypeu, devtypel, instance) \
+	"bootcmd_system=" \
+		"echo Loading Android boot partition...;" \
+		"mmc dev ${mmcdev};" \
+		"setenv bootargs ${bootargs} console=${console} androidboot.serialno=${serial#};" \
+		"part start mmc ${mmcdev} ${bootpart} boot_start;" \
+		"part size mmc ${mmcdev} ${bootpart} boot_size;" \
+		"if mmc read ${loadaddr} ${boot_start} ${boot_size}; then " \
+			"echo Running Android...;" \
+			"bootm ${loadaddr};" \
+		"fi;" \
+		"echo Failed to boot Android...;" \
+		"reset\0"
+
+#define BOOTENV_DEV_NAME_SYSTEM(devtypeu, devtypel, instance)	\
+		"system "
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(ROMUSB, romusb, na)  \
+	func(FASTBOOT, fastboot, na) \
+	func(RECOVERY, recovery, na) \
+	func(SYSTEM, system, na) \
+
+#define CONFIG_EXTRA_ENV_SETTINGS                                     \
+	"partitions=" PARTS_DEFAULT "\0"                              \
+	"mmcdev=2\0"                                                  \
+	"bootpart=1\0"                                                \
+	"gpio_recovery=88\0"                                          \
+	"check_button=gpio input ${gpio_recovery};test $? -eq 0;\0"   \
+	"console=/dev/ttyAML0\0"                                      \
+	"bootargs=no_console_suspend\0"                               \
+	"stdin=" STDIN_CFG "\0"                                       \
+	"stdout=" STDOUT_CFG "\0"                                     \
+	"stderr=" STDOUT_CFG "\0"                                     \
+	"loadaddr=0x01000000\0"                                       \
+	"fdt_addr_r=0x01000000\0"                                     \
+	"scriptaddr=0x08000000\0"                                     \
+	"kernel_addr_r=0x01080000\0"                                  \
+	"pxefile_addr_r=0x01080000\0"                                 \
+	"ramdisk_addr_r=0x13000000\0"                                 \
+	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" BOOTENV
+
+#include <configs/meson64.h>
+
+#endif /* __CONFIG_H */
-- 
2.22.0

