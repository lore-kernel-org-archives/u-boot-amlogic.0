Received: by mail-wm1-f66.google.com with SMTP id x15so78706214wmj.3
        for <u-boot-amlogic@groups.io>; Tue, 06 Aug 2019 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vRJp6TAiHBMCUDcsb9a5blAm2nzpdjQHwmoA5Ltqo3g=;
        b=zWlIeVET+WK5tlNhdGyfeeedb8/tcctnrkoP1ao+MHeGyrk1oFyal2/B5SkJBTH6jB
         hgXjSz99Awh8BK/+7H5n/U5IK3c3bqU3+huvh09b9z3VG1XWBICPB9N0Xzuk72I4GJqW
         YpfFh6dEVdG2SCCxNOQhtiYVDLCHijYB6vHDeX6uxwOUpwqdlkRVSpdKK+7zRGCHOrCm
         zQyowiSnEmxhgJq6rmZGWeC7TAdM2o/ob3TW712nr8zhCsdDJ1hnRe/K48dzDdsEYbB4
         PUT4QjmAyuuEMjirf2RW6WK6fBJHmVSDD9qSKK5O2TzHL6kgaXqWuXhDLD1eJB2D62YC
         q3Qg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 4/7] arm: meson: add sm command to retrieve the reboot reason
Date: Tue,  6 Aug 2019 17:43:16 +0200
Message-Id: <20190806154319.10505-5-narmstrong@baylibre.com>
In-Reply-To: <20190806154319.10505-1-narmstrong@baylibre.com>
References: <20190806154319.10505-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Secure Monitor offers multiple services, like returning the
SoC unique serial number, and can provide the "reboot reason" as
set by the previous booted system.

This extends the Amlogic specific "sm" cmd with a "reboot_reason" subcommand
to print or set a specified environment variable with the reboot reason in
human readable format.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/asm/arch-meson/sm.h | 18 ++++++
 arch/arm/mach-meson/sm.c             | 87 +++++++++++++++++++++++++++-
 2 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
index 60d04ae228..f3ae46a6d6 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -12,4 +12,22 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
 
 int meson_sm_get_serial(void *buffer, size_t size);
 
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
+int meson_sm_get_reboot_reason(void);
+
 #endif /* __MESON_SM_H__ */
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 99fa17d9a8..fabcb3bfd7 100644
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
@@ -78,6 +82,39 @@ int meson_sm_get_serial(void *buffer, size_t size)
 	return 0;
 }
 
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
 static int do_sm_serial(cmd_tbl_t *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -96,8 +133,55 @@ static int do_sm_serial(cmd_tbl_t *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
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
 static cmd_tbl_t cmd_sm_sub[] = {
 	U_BOOT_CMD_MKENT(serial, 2, 1, do_sm_serial, "", ""),
+	U_BOOT_CMD_MKENT(reboot_reason, 1, 1, do_sm_reboot_reason, "", ""),
 };
 
 static int do_sm(cmd_tbl_t *cmdtp, int flag, int argc,
@@ -123,5 +207,6 @@ static int do_sm(cmd_tbl_t *cmdtp, int flag, int argc,
 U_BOOT_CMD(
 	sm, 5, 0, do_sm,
 	"Secure Monitor Control",
-	"serial <address> - read chip unique id to memory address"
+	"serial <address> - read chip unique id to memory address\n"
+	"sm reboot_reason [name] - get reboot reason and store to to environment"
 );
-- 
2.22.0

