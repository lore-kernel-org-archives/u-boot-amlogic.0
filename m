Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD33CCA476
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 18:16:35 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
 by mx.groups.io with SMTP id smtpd.web10.5282.1760206593610511280
 for <u-boot-amlogic@groups.io>;
 Sat, 11 Oct 2025 11:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=pmiOcE9Z;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.176, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760206591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NB+i8hKtu/UL3KZcs/fzm2KExaCdzZmT1fkAUDci8ow=;
	b=pmiOcE9ZsI3GAKuvjdYE+khSSzRQkyrUjtzTjbJgbhfaT63P8Uep7qX8C9Zb03H+lM+Ai3
	DWyLTgVNnJPpWCnXkrivjtRyCFfbtvYhrOTqJWWa5eThoUpghqHp5VjEtrS15LBPtMI3Mm
	5Ixxa5AuAuXTNNh0gc08c876JkSIoGC/tf0MdYnahoziQbNar9f3DDBEAotQbi2DWGVkSC
	aWqgtt70aD8gCjWemfIbzW/mzHtpikOGnnRWzn5qHA2JYxacYHF7qmA46RTwDJ+LqH304i
	bMI0ac9axlcHk4C32Zg1fzIe2tBmxRRTQWhjkQeRc9Vwbs5Y7OsrHRElh7Ejlw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Sat, 11 Oct 2025 18:16:23 +0000
Subject: [PATCH v2] arm: meson: add support for EFI capsule updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAPae6mgC/3XMQQ6CMBCF4auQWVvTIrWpK+5hWFQcoFGYplMbD
 eHuVvYu/5e8bwXG6JHhUq0QMXv2tJSoDxX0k1tGFP5eGmpZayWlETMyLaJ3gV9PFE5ZfbIonW4
 QyidEHPx7965d6clzovjZ+ax+6z8pK6HEWRk9mFvTDxbbQJxmFx+YiI8UR+i2bfsCLRQ7p7EAA
 AA=
X-Change-ID: 20251007-meson-capsule-a19539e0a54e
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6207;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=cUBHnY0OLwoo5jeQW7nKHXpA1l8JN8zuAcOwVoLM/bs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo6p79pB3tpOVSzNFRKujI08adoDHVElLpISmVw
 r/WDVEXCvmJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOqe/QAKCRCEr8vQ14ma
 A+CtD/9YGWguq6lVk/ttiSKyxgeNC7jHsta5EzhOMkEfOAS96SWywCxjvwWebdaGYYFAnJbQsJ6
 7AhbNJ5LUzQrLyq/eW92KesmMC7waPnXEHVDnqwyMrv6yDwfVRhhVxQ+uwYReZRsNMs3sez2Gi0
 ieszwfZ0wH8fSpKpDAr0viI/hBrevCM7cAVSGN+oFaoOsP4KYNZ4o1/ZBVYlVWxJwgr8mrwQh4F
 oFuStCPNsS0e/KsLz0Mzp5wBF9nfUqL2HAvmxFHrVJhpqJy7GCdFoJXVhILXOubheOgaoSG5gX7
 5zLG3SG9RBA/OJfo/yM1TvPm/xVs2t0RJQBHUW40bRJqQs+6fARRAD5tenM88sNqxeVa8+ilfzM
 rivO5JJa+drvtqWyFmgl0DZaBG8qSKHclmmTG1k7AbvM7BXWRuK/dJ5M1wLQZanRc7wbFafCgCU
 sHAF/U/yFZBB1Fl4dOT2I3hFzzrvRE519/o1NurFCeRmwJw+iPHoiExAUcl3G2PtJagUpIdX7EV
 uLwv2utWEKxMWOhmkJqXpGKRVTuL+jBmMekts1Kce/9f1NHktUcbHlL5pJhDTw4AJ7iGNUeLnQY
 EkywFrf9xRvFOzgkbtwg0+dfHb1SUvuCxugAv8c8LT3ULf4+PdbzwcD5AF6paX8j+F3yQT34uYW
 7KgQaIaXIumEIvA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sat, 11 Oct 2025 18:16:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2806

Previously, few Amlogic devices supported EFI capsule updates.
Generally only the Libre Computer ones with SPI flash supported it,
thanks to board-specific code.

This commit commonises capsule update support across supported
Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
and firmware name is automatically generated at runtime depending on
which device we are booted from.  Right now this supports flashing to
the eMMC/SD and SPI flash.

As usual, the capsule UUID is automatically generated.  You can get it
by enabling CONFIG_CMD_EFIDEBUG and running:

	=> efidebug capsule esrt
	========================================
	ESRT: fw_resource_count=1
	ESRT: fw_resource_count_max=1
	ESRT: fw_resource_version=1
	[entry 0]==============================
	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
	ESRT: fw_type=unknown
	ESRT: fw_version=0
	ESRT: lowest_supported_fw_version=0
	ESRT: capsule_flags=0
	ESRT: last_attempt_version=0
	ESRT: last_attempt_status=success
	========================================

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Currently EFI capsule updates are only supported on the following
Amlogic-based boards:

 - Libre Computer AML-S805X-AC
 - Libre Computer AML-A311D-CC
 - Libre Computer AML-S905D3-CC

This is done with board-specific configuration in board/libre-computer/.

With this patch, EFI capsule updates can now work on most of the other
Amlogic boards supported by u-boot, such as the Libre Computer
AML-S905X-CC, without the need for board-specific configuration
beforehand.

Please note that flashing to the eMMC bootX partitions is not yet
supported.
---
Changes in v2:
 - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
   are enabled
 - Coding style fixes
 - Return when boot device is unsupported
 - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org
---
 arch/arm/include/asm/arch-meson/boot.h |  2 ++
 arch/arm/mach-meson/Makefile           |  2 +-
 arch/arm/mach-meson/board-common.c     |  5 +++
 arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c01502a72773213b2 100644
--- a/arch/arm/include/asm/arch-meson/boot.h
+++ b/arch/arm/include/asm/arch-meson/boot.h
@@ -21,6 +21,8 @@ int meson_get_boot_device(void);
 
 int meson_get_soc_rev(char *buff, size_t buff_len);
 
+void meson_setup_capsule(void);
+
 /**
  * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
  *
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b212991edea26de2987d4 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
 
-obj-y += board-common.o sm.o board-info.o
+obj-y += board-common.o sm.o board-info.o capsule.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 39774c43049a40ed11578086603717571bedd23b..e8012604c33376ee031b89bbfcf16ef34d6dec73 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -145,6 +145,11 @@ int board_late_init(void)
 {
 	meson_set_boot_source();
 
+	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
+		/* Generate dfu_string for EFI capsule updates */
+		meson_setup_capsule();
+	}
+
 	return meson_board_late_init();
 }
 
diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
new file mode 100644
index 0000000000000000000000000000000000000000..6e968a59c2cf26db179e11caac1eb6c3f76b2d2c
--- /dev/null
+++ b/arch/arm/mach-meson/capsule.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+
+#include <asm/arch/boot.h>
+#include <dm.h>
+#include <efi_loader.h>
+#include <mmc.h>
+
+/*
+ * To be able to support multiple devices and flash to the correct one we need
+ * to automatically generate the dfu_string and fw_name to match the device we
+ * are booted from. This is done by meson_setup_capsule() which is then called
+ * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
+ * eMMC and SD cards.
+ */
+struct efi_fw_image fw_images[] = {
+	{
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = NULL, /* to be set in meson_capsule_setup */
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+/*
+ * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
+ */
+void meson_setup_capsule(void)
+{
+	static char dfu_string[32] = { 0 };
+	int mmc_devnum = 0; /* mmc0 => SD card */
+	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
+	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
+	int boot_device = meson_get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_EMMC:
+		mmc_devnum = 1; /* mmc1 is always eMMC */
+		fallthrough;
+	case BOOT_DEVICE_SD:
+		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
+		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
+		break;
+	case BOOT_DEVICE_SPI:
+		/* We assume there's only one SPI flash */
+		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
+		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
+		break;
+	default:
+		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
+		return;
+	}
+	debug("EFI Capsule DFU string: %s", dfu_string);
+
+	update_info.dfu_string = dfu_string;
+}

---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20251007-meson-capsule-a19539e0a54e

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


