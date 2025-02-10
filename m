Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A5C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 12:30:10 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.58752.1739209839934810767
 for <u-boot-amlogic@groups.io>;
 Mon, 10 Feb 2025 09:50:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=mail header.b=NIF3T/VU;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: eabachinin@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9563D120006;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9563D120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1739209837;
	bh=MJWF4VRppRFmQ1uw6qJfhixPjiLU3Kg1O2lNRwoZS0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=NIF3T/VUnFzI2nRBayup32MO7ECd6Am8zvApg/h9w/NGEYni9nmkUQHh+PYWps7tM
	 y7lNYBzjXr9PqmUBO5dEmMs509CV6MXBFr+Z9BvShPsehlS6a5ZRzEvp3YS5hWNwmJ
	 MHK8AHnKo9K5M+zOejFTdZU2KxgPyRYPsi0D39X0Nhjb+/51XougWOmcnvTbcoqnlr
	 vr8nFSJQpTmffU75g7me5X7ggH7TcywEdz5DmNNt43GbaAq2HVWPR6B0CBrLctj6mu
	 n3Y7lT1Mx8dyzGskB+mzD60KMxXFEInkCO/3v8nfKe474FawdlkvlvdgfoLENJCIzp
	 Rl3l0mhlaYT3g==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Feb 2025 20:50:37 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Date: Mon, 10 Feb 2025 20:50:16 +0300
Subject: [PATCH 3/3] arch: arm: meson: support Amlogic chip_id v1 and v2
MIME-Version: 1.0
Message-ID: <20250210-meson_chip_id_all_vers-v1-3-b98f8b6880b8@salutedevices.com>
References: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
In-Reply-To: <20250210-meson_chip_id_all_vers-v1-0-b98f8b6880b8@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Viacheslav Bocharov <adeep@lexina.in>, Arseniy Krasnov
	<avkrasnov@salutedevices.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
	<u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, Evgeny Bachinin
	<EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.162.21]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 190909 [Feb 10 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;github.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/02/10 17:01:00
X-KSMG-LinksScanning: Clean, bases: 2025/02/10 17:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/02/10 15:43:00 #27153787
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 11 Feb 2025 12:30:10 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2620

Patch introduces:
* chip_id API - useful for various things, but used now for
  device_id (did) generation as mentioned in [1] on our private board
  code. Our device_id is calculated by means of permutations of
  chip_id value.
* new SoCs (a1, s4, etc) are usually coming with the support of chip_id
  v2 right away, whereas secure monitors on old SoCs (like axg, g12b,
  g12a, etc) may support only chip_id v1. Chip_id API handles both
  cases
* meson_sm_get_serial() is described via chip_id API.

Links:
[1] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/#m630fbeea6a6e7d531290b5c0af205af4fb979757

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
Co-developed-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---

=== Theory and research

1) Amlogic efuse data layout.

Layout differs for old (axg, g12a, g12b) and new (a1, s4) SoCs.

                  efuse layout for old SoCs
+----+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F |
+----+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|0x0 |     Ver       |               Serial  (12 bytes)        *(1)  |
+----+---------------+-----------------------------------------------+
|0x10|                  < ... Another data ... >                     |
+----+---------------------------------------------------------------+

NOTES: *(1) - in U-Boot & Linux upstream is known as "serial". See [1]

                  efuse layout for new SoCs
+----+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|    | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | A | B | C | D | E | F |
+----+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|0x0 |      Ver      |     cpu_id    |                   Serial...   |
+----+---------------+---------------+-------------------------------+
|0x10| ...(12 bytes) |         < ... Another data ... >              |
+----+---------------+-----------------------------------------------+

2) About Amlogic chip_id V1 & V2 in Amlogic U-Boot

Briefly, some statements and observations:
a) v1 & v2 are 16 bytes in size

b) v1 format: { cpu_id | serial (12b) }
* Old SoCs (axg, g12a, g12b, etc):
  * cpu_id = value, read from reg (aka socinfo)
  * serial - 12 unique bytes from efuse. (Before arriving to the
             client their order is reversed to little-endian)
* New SoCs (a1, s4, etc):
   * cpu_id = 0;
   * serial = {8 unique bytes from efuse | cpu_id (reversed order)}
              (Before arriving to client their order is reversed)

c) v2 format: { 16 bytes from efuse }
* For old & new SoCs: { 16 bytes from efuse } =
       = { cpu_id | serial (12b, little-endian) } (They come from eFUSE
	                             in the correct order right away)

d) Old SoCs: chip_id V1 == V2
e) New SoCs: chip_id V1 != V2 (due to (b))
f) New SoCs are coming with chip_id V2 support right away.
g) Due to (f), final format/layout of chip_id V1 & V2 can be considered
   the same.

3) Experimental data from Amlogic U-Boot.

* AXG ver 2:
```
  [in-efuse view]:
     02 00 00 00 25 0C 43 00 C0 22 B6 54 74 79 FA 18 6E 0D 43 86
         ver    |  cpu_id   |    12 bytes of unique data  in       |
                |           | little-endian:  efuse_chip_id[0:11]  |
  [chip_id]: 16 bytes (same as ver.1)
                 25 0C 43 00 C0 22 B6 54 74 79 FA 18 6E 0D 43 86
```

* AXG ver 1:
```
  [in-efuse view]:
     01 00 00 00 86 43 0D 6E 18 FA 79 74 54 B6 22 C0 00 00 00 00
        ver     |    12 bytes of unique data  in    |
                | big-endian:   efuse_chip_id[11:0] |
  [chip_id]: 16 bytes
                 25 0C 43 00 C0 22 B6 54 74 79 FA 18 6E 0D 43 86
               cpu_id from  |   12 bytes of unique data in         |
                 register   | little-endian:  efuse_chip_id[0:11]  |
```

* A1 ver 2:
```
  [in-efuse view]:
     02 00 00 00 2C 0A 01 0A 01 44 18 00 00 06 39 36 32 41 34 50
         ver    |  cpu_id   |    12 bytes of unique data  in       |
                |           | little-endian:  efuse_chip_id[0:11]  |
  [chip_id]:
                 2C 0A 01 0A 01 44 18 00 00 06 39 36 32 41 34 50
```

* A1 ver 1:
```
  [in-efuse view]:
     01 00 00 00 2C 0A 01 0A 50 34 41 32 36 39 06 00 00 00 00 00
        ver     |    cpu_id | 8b of unique data in  |
                |           | big-endian:           |
		|           |  efuse_chip_id[11:0]  |
  [chip_id]:
                 00 00 00 00 00 06 39 36 32 41 34 50 0A 01 0A 2C
         *(1)   buff[0] = 0 | 8b of unique data in  |   cpu_id     |
                            | little-endian:        |              |
			    |  efuse_chip_id[0:11]  |              |

NOTES:
*(1) - for details see [2]
```

Links:
[1] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/#m630fbeea6a6e7d531290b5c0af205af4fb979757
[2] https://github.com/CoreELEC/u-boot/blob/3efc85a8370796bcec3bcadcdecec9aed973f4a9/arch/arm/mach-meson/a1/bl31_apis.c#L443
---
---
 arch/arm/include/asm/arch-meson/boot.h |  14 ++++
 arch/arm/include/asm/arch-meson/sm.h   |  48 ++++++++++++-
 arch/arm/mach-meson/board-info.c       |   6 +-
 arch/arm/mach-meson/sm.c               | 119 ++++++++++++++++++++++++++++++---
 4 files changed, 175 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
index c67d12d06c90b77fb5598aa1e17fae39514bb8fc..a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7 100644
--- a/arch/arm/include/asm/arch-meson/boot.h
+++ b/arch/arm/include/asm/arch-meson/boot.h
@@ -21,4 +21,18 @@ int meson_get_boot_device(void);
 
 int meson_get_soc_rev(char *buff, size_t buff_len);
 
+/**
+ * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
+ *
+ * The value in the following format is read from register:
+ *   +-----------+------------+------------+------------+
+ *   | family_id | package_id |  chip_rev  | layout_rev |
+ *   +-----------+------------+------------+------------+
+ *   | 31     24 | 23      16 | 15       8 | 7        0 |
+ *   +-----------+------------+------------+------------+
+ *
+ * Return: 4 bytes value of cpu_id on success or 0 on failure.
+ */
+u32 meson_get_socinfo(void);
+
 #endif /* __MESON_BOOT_H__ */
diff --git a/arch/arm/include/asm/arch-meson/sm.h b/arch/arm/include/asm/arch-meson/sm.h
index 4b1d564bc480bd546ca94b5e53ba0a5936f6cd28..4d614955fc20dc687938e14e6978312a9e03f9bb 100644
--- a/arch/arm/include/asm/arch-meson/sm.h
+++ b/arch/arm/include/asm/arch-meson/sm.h
@@ -6,6 +6,8 @@
 #ifndef __MESON_SM_H__
 #define __MESON_SM_H__
 
+#include <asm/types.h>
+
 /**
  * meson_sm_read_efuse - read efuse memory into buffer
  *
@@ -27,16 +29,60 @@ ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size);
 ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size);
 
 #define SM_SERIAL_SIZE	12
+#define MESON_CPU_ID_SZ	4
+#define MESON_CHIP_ID_SZ 16
+
+/**
+ * union meson_cpu_id - Amlogic cpu_id.
+ * @raw: buffer to hold the cpu_id value as sequential bytes.
+ * @val: cpu_id represented as 32 bit value.
+ */
+union meson_cpu_id {
+	u8 raw[MESON_CPU_ID_SZ];
+	u32 val;
+};
+
+/**
+ * struct meson_sm_chip_id - Amlogic chip_id.
+ * @cpu_id: cpu_id value, which is distinct from socinfo in that the order of
+ *          PACK & MINOR bytes are swapped according to Amlogic chip_id format.
+ * @serial: 12 byte unique SoC number, identifying particular die, read
+ *          usually from efuse OTP storage. Serial comes in little-endian
+ *          order.
+ */
+struct meson_sm_chip_id {
+	union meson_cpu_id cpu_id;
+	u8 serial[SM_SERIAL_SIZE];
+};
 
 /**
- * meson_sm_get_serial - read chip unique id into buffer
+ * meson_sm_get_serial - read chip unique serial (OTP data) into buffer
  *
  * @buffer: pointer to buffer
  * @size: buffer size.
+ *
+ * Serial is returned in big-endian order.
+ *
  * @return: zero on success or -errno on failure
  */
 int meson_sm_get_serial(void *buffer, size_t size);
 
+/**
+ * meson_sm_get_chip_id - read Amlogic chip_id
+ *
+ * @chip_id: pointer to buffer capable to hold the struct meson_sm_chip_id
+ *
+ * Amlogic SoCs support 2 versions of chip_id. Function requests the newest
+ * one (v2), but if chip_id v2 is not supported, then secure monitor returns
+ * v1. All differences between v1 and v2 versions are handled by this function
+ * and chip_id is returned in unified format.
+ *
+ * chip_id contains serial, which is returned here in little-endian order.
+ *
+ * @return: 0 on success or -errno on failure
+ */
+int meson_sm_get_chip_id(struct meson_sm_chip_id *chip_id);
+
 enum {
 	REBOOT_REASON_COLD = 0,
 	REBOOT_REASON_NORMAL = 1,
diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 94b066170c43019b379f05ab8d1e6d426592a1e1..d3807dc787d8768c3234204e8270f226c549c909 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -126,7 +126,7 @@ static const char *socinfo_to_soc_id(u32 socinfo)
 	return "Unknown";
 }
 
-static u32 get_socinfo(void)
+u32 meson_get_socinfo(void)
 {
 	struct regmap *regmap;
 	int nodeoffset, ret;
@@ -165,7 +165,7 @@ int checkboard(void)
 {
 	u32 socinfo;
 
-	socinfo = get_socinfo();
+	socinfo = meson_get_socinfo();
 	if (!socinfo)
 		return 0;
 
@@ -184,7 +184,7 @@ int meson_get_soc_rev(char *buff, size_t buff_len)
 {
 	u32 socinfo;
 
-	socinfo = get_socinfo();
+	socinfo = meson_get_socinfo();
 	if (!socinfo)
 		return -1;
 
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index 43a259d695b058361445d7ef7047353b3afd5419..b1f91ca29ceccc368508ad66fc7dfad4a4d6fa01 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -10,11 +10,13 @@
 #include <regmap.h>
 #include <sm.h>
 #include <syscon.h>
+#include <asm/arch/boot.h>
 #include <asm/arch/sm.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <linux/bitops.h>
+#include <linux/compiler_attributes.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
@@ -76,30 +78,131 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
 	return err;
 }
 
-#define SM_CHIP_ID_LENGTH	119
-#define SM_CHIP_ID_OFFSET	4
+/*
+ * Helps to handle two flavors of cpu_id layouts:
+ *
+ * - in-register view (value read from cpu_id reg, a.k.a. socinfo):
+ *   +-----------+------------+------------+------------+
+ *   | family_id | package_id |  chip_rev  | layout_rev |
+ *   +-----------+------------+------------+------------+
+ *   | 31     24 | 23      16 | 15       8 | 7        0 |
+ *   +-----------+------------+------------+------------+
+ *
+ * - in-efuse view (value, residing inside efuse/shmem data usually for
+ *   chip_id v2. Chip_id v1 does not contain cpu_id value inside efuse
+ *   data (i.e. in chip_id_efuse)):
+ *   +-----------+------------+------------+------------+
+ *   | family_id |  chip_rev  | package_id | layout_rev |
+ *   +-----------+------------+------------+------------+
+ *   | 31     24 | 23      16 | 15       8 | 7        0 |
+ *   +-----------+------------+------------+------------+
+ */
+enum {
+	/* In-register view of cpu_id */
+	CPU_ID_REG_MAJOR,	/* 31-24 bits */
+	CPU_ID_REG_PACK,	/* 23-16 bits */
+	CPU_ID_REG_MINOR,	/* 15-8 bits */
+	CPU_ID_REG_MISC,	/* 7-0 bits */
 
-int meson_sm_get_serial(void *buffer, size_t size)
+	/* In-efuse view of cpu_id */
+	CPU_ID_MAJOR = CPU_ID_REG_MAJOR,
+	CPU_ID_PACK  = CPU_ID_REG_MINOR,
+	CPU_ID_MINOR = CPU_ID_REG_PACK,
+	CPU_ID_MISC  = CPU_ID_REG_MISC,
+};
+
+/*
+ * This is a beginning chunk of the whole efuse storage area, containing
+ * data related to chip_id only
+ */
+struct chip_id_efuse {
+	u32 version;
+	u8 raw[MESON_CHIP_ID_SZ]; /* payload */
+} __packed;
+
+static void meson_sm_serial_reverse(u8 serial[SM_SERIAL_SIZE])
+{
+	for (int i = 0; i < SM_SERIAL_SIZE / 2; i++) {
+		int k = SM_SERIAL_SIZE - 1 - i;
+
+		swap(serial[i], serial[k]);
+	}
+}
+
+int meson_sm_get_chip_id(struct meson_sm_chip_id *chip_id)
 {
 	struct udevice *dev;
+	union meson_cpu_id socinfo;
 	struct pt_regs regs = { 0 };
-	u8 id_buffer[SM_CHIP_ID_LENGTH];
+	struct chip_id_efuse chip_id_efuse;
 	int err;
 
 	dev = meson_get_sm_device();
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	err = sm_call_read(dev, id_buffer, SM_CHIP_ID_LENGTH,
+	/*
+	 * Request v2. If not supported by secure monitor, then v1 should be
+	 * returned.
+	 */
+	regs.regs[1] = 2;
+
+	err = sm_call_read(dev, &chip_id_efuse, sizeof(chip_id_efuse),
 			   MESON_SMC_CMD_CHIP_ID_GET, &regs);
-	if (err < 0)
-		pr_err("Failed to read serial number (%d)\n", err);
+	if (err < 0) {
+		pr_err("Failed to read chip_id (%d)\n", err);
+		return err;
+	}
+
+	if (chip_id_efuse.version == 2) {
+		memcpy((u8 *)chip_id, chip_id_efuse.raw,
+		       sizeof(struct meson_sm_chip_id));
+		return 0;
+	}
 
-	memcpy(buffer, id_buffer + SM_CHIP_ID_OFFSET, size);
+	/*
+	 * Legacy chip_id (v1) read out, transform data
+	 * to expected order format (little-endian)
+	 */
+	memcpy(chip_id->serial, chip_id_efuse.raw, sizeof(chip_id->serial));
+	meson_sm_serial_reverse(chip_id->serial);
+
+	socinfo.val = meson_get_socinfo();
+	if (!socinfo.val)
+		return -ENODEV;
+
+	chip_id->cpu_id = (union meson_cpu_id){
+		.raw[CPU_ID_MAJOR] = socinfo.raw[CPU_ID_REG_MAJOR],
+		.raw[CPU_ID_PACK]  = socinfo.raw[CPU_ID_REG_PACK],
+		.raw[CPU_ID_MINOR] = socinfo.raw[CPU_ID_REG_MINOR],
+		.raw[CPU_ID_MISC]  = socinfo.raw[CPU_ID_REG_MISC],
+	};
 
 	return 0;
 }
 
+int meson_sm_get_serial(void *buffer, size_t size)
+{
+	struct meson_sm_chip_id chip_id;
+	int ret;
+
+	if (size < SM_SERIAL_SIZE)
+		return -EINVAL;
+
+	ret = meson_sm_get_chip_id(&chip_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * The order of serial inside chip_id and serial which function must
+	 * return does not match: stick here to big-endian for backward
+	 * compatibility.
+	 */
+	meson_sm_serial_reverse(chip_id.serial);
+	memcpy(buffer, chip_id.serial, sizeof(chip_id.serial));
+	return ret;
+}
+
 #define AO_SEC_SD_CFG15		0xfc
 #define REBOOT_REASON_MASK	GENMASK(15, 12)
 

-- 
2.34.1


