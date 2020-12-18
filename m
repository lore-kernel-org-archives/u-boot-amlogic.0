Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.10737.1608301641480220401
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 06:27:22 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201218142703euoutp02c2ff35cc30a29362b034eb11081bd91b~R1c5MXNEw3042730427euoutp02q
	for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 14:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201218142703euoutp02c2ff35cc30a29362b034eb11081bd91b~R1c5MXNEw3042730427euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608301624;
	bh=uLKwTNYNSy/DWFf+MLtaAp8zDHG4MsQbuLFF+PlwNLA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lCWubyrU3UxKt9mImcYnjXjQMChzDUAmzWfaxDjoIXKITuobdBpAv1hjRodN1Vw3k
	 2/SodAAJr8/xQhcCv1z74mXJG6WhduXUqhYUyKYakQvPAY35Y1eXBQ+QC2zkfOUI7+
	 NZmZ4LB50eC0bprIHhikznie3jZFSDPkrX6y9h0Y=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] board: amlogic: add MMC boot device detection for environment load
Date: Fri, 18 Dec 2020 15:26:45 +0100
Message-Id: <20201218142645.5496-1-m.szyprowski@samsung.com>
References: <CGME20201218142657eucas1p1834b72338d1cd92f59738e7e3e0c875d@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Detect eMMC or SD card boot on Odroid-C4/N2 and Khadas VIM3(l) boards and
report proper MMC device for the environment loading code. This allows to
automatically load and store environment variables on the FAT partition
or RAW offset of the MMC device without the need to use different
configurations on eMMC and SD card.

To use this feature with environment stored on FAT partition, one has to
specify an empty device part (i.e. ":1" for the first partition) in
CONFIG_ENV_FAT_DEVICE_AND_PART to let the code to set the device to the
value returned by mmc_get_env_dev() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 board/amlogic/odroid-n2/odroid-n2.c | 8 ++++++++
 board/amlogic/vim3/vim3.c           | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index caf7fd6810..12ee5d3abc 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -10,6 +10,7 @@
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
+#include <asm/arch/boot.h>
 #include <asm/arch/sm.h>
 #include <asm/arch/eth.h>
 
@@ -17,6 +18,13 @@
 #define EFUSE_MAC_SIZE		12
 #define MAC_ADDR_LEN		6
 
+int mmc_get_env_dev(void)
+{
+	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
+		return 1;
+	return 0;
+}
+
 int misc_init_r(void)
 {
 	u8 mac_addr[MAC_ADDR_LEN];
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 09ef39ff30..f9049e0172 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -10,10 +10,18 @@
 #include <init.h>
 #include <net.h>
 #include <asm/io.h>
+#include <asm/arch/boot.h>
 #include <asm/arch/eth.h>
 #include <i2c.h>
 #include "khadas-mcu.h"
 
+int mmc_get_env_dev(void)
+{
+	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
+		return 2;
+	return 1;
+}
+
 /*
  * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
  * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
-- 
2.17.1

