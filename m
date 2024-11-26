Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33426D5A6F4
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:01 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.41174.1732608419382468326
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:06:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=OKsfH3Lh;
 spf=pass (domain: baylibre.com, ip: 209.85.128.48, mailfrom: glaroque@baylibre.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315abed18aso47155085e9.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608418; x=1733213218; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhB6kw1tx/Ugu7yuPZdkIB43/62QybkmpZ3EzW2E+6k=;
        b=OKsfH3LhCakDFfZIdw7nXPbnUONxEksgAfSSKRoiphI/FGyfRos6M3ZWvNW10WQBP0
         Eh6OKNIMhRazTxZ6JyFAYcTqPUU4F/hCkEgXVEsE8xeQq6Q1nJOd08+Fw/EUy8rWPFNc
         Zuym1fQXg5/uBGWAbiNH06TEr219DL5r0j5yBj9Z2WHepi8Dz5+DSvcDhUSS7MwNBZZt
         MOVV77OmqJkqPo+SOS8feQ/3wYQ3f/TH3TR1QtK+nWVJJrwXhzhDai1YCjKRjB7HkRlp
         HATUN7RDUpCYoHLfdwXgnqcPJziwX3DToFHtsiAiJ+g85/D6mv0k/MjXruS+zuTrElmY
         6rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608418; x=1733213218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhB6kw1tx/Ugu7yuPZdkIB43/62QybkmpZ3EzW2E+6k=;
        b=QDSGu9xju3k6Erz+VZRbQ0RWDJLNsh3uJ8exAtzNUmAjwGnVs2Zj2Gz4JM3LbmPQqI
         SWP290iKsVfSkH4kubNdU+0DyR0tYhsG6SnFOmfq4jHQGSgJdPhvJtpqlH8CdhLd5mTy
         yC+tkkc+nmubslH3+9Z3DVbEo4LI4aJ0p+iqSK3deV2JcoUs5sselchdVRXP2XI2FbyY
         d4mTVzUw5ny4gIoCNELTQEfEBWec6dBDx7nPsNI3VMg0Kv2RbncHk33iC+vNxPWzjK0V
         m5r+gG+/FFOnIt6xFlVntxLj6CLqAnMO156iX4gj7K0dBALnFiGEinu+HT/0Uu9o3Tb5
         XiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfOIVNs5cOTwakTjBG+PlVuhiyndejFrsMaJFsyz15/pSNgFHZEtlqn7MpO2WHEIVbIJretVC5mdkido9bjA==@groups.io
X-Gm-Message-State: AOJu0Yy+FmmR17vq2+trpjl6M8nRX74ntBiQ7LC2YkNeV7NPmeLa2OGF
	McokXkqhuA6pKQrKhteJ+ReqfPR14/1wplqv0aaEKNFpnIWyYc9AB68Q+T/eYtc=
X-Gm-Gg: ASbGncuhUDmzQE7jB5NSZ4tTjXUfBRz5F7mOXyEEZJlWUOG+l93VO/B1AufMmZd8SrA
	+bi7706Gmn+Uvdht5DwC35YT2QOi4u+uNu3uuP53VeufKBw9j+FZd7fkwvoVKeAXMqhby2kWUH8
	NaC/O+i/ls638XlqkwBUe60lOIX9BBkuh/bnzYzl0tStRq8sH62+05luwvLcejfaE0+J743llH4
	DF8ZN2ixtDXDmY2D5ubVVKgi/AyR9LSK/174ZGozRNBKMBJyCvQhA==
X-Google-Smtp-Source: AGHT+IHs9It68rFXjrf1Ye2uqXknPDgeWP5YIbCA0amoQDFhfpoxrpIC7e671AZWPJh3b2u5e/cT9Q==
X-Received: by 2002:a05:600c:46c7:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-433ce41bf62mr143939795e9.2.1732608417598;
        Tue, 26 Nov 2024 00:06:57 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:06:57 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 26 Nov 2024 09:06:10 +0100
Subject: [PATCH v4 2/5] bootstd: android: add non-A/B image support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-adnroidv2-v4-2-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 08:07:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2585

Update android bootmeth to support non-A/B image.
Enable AB support only when ANDROID_AB is enabled.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/Kconfig                     |  1 -
 boot/bootmeth_android.c          | 51 +++++++++++++++++++++++++++++++++-------
 configs/am62x_a53_android.config |  1 +
 configs/sandbox_defconfig        |  1 +
 4 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7dd30a030e39..661e89ca05b2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -500,7 +500,6 @@ config BOOTMETH_ANDROID
 	bool "Bootdev support for Android"
 	depends on X86 || ARM || SANDBOX
 	depends on CMDLINE
-	select ANDROID_AB
 	select ANDROID_BOOT_IMAGE
 	select CMD_BCB
 	imply CMD_FASTBOOT
diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 2e7f85e4a708..2aac32331d3c 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -29,6 +29,7 @@
 #define BCB_PART_NAME "misc"
 #define BOOT_PART_NAME "boot"
 #define VENDOR_BOOT_PART_NAME "vendor_boot"
+#define SLOT_LEN 2
 
 /**
  * struct android_priv - Private data
@@ -42,7 +43,7 @@
  */
 struct android_priv {
 	enum android_boot_mode boot_mode;
-	char slot[2];
+	char *slot;
 	u32 header_version;
 };
 
@@ -71,7 +72,11 @@ static int scan_boot_part(struct udevice *blk, struct android_priv *priv)
 	char *buf;
 	int ret;
 
-	sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
+	if (priv->slot)
+		sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
+	else
+		sprintf(partname, BOOT_PART_NAME);
+
 	ret = part_get_info_by_name(desc, partname, &partition);
 	if (ret < 0)
 		return log_msg_ret("part info", ret);
@@ -108,7 +113,11 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
 	char *buf;
 	int ret;
 
-	sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
+	if (priv->slot)
+		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
+	else
+		sprintf(partname, VENDOR_BOOT_PART_NAME);
+
 	ret = part_get_info_by_name(desc, partname, &partition);
 	if (ret < 0)
 		return log_msg_ret("part info", ret);
@@ -142,6 +151,11 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
 	char slot_suffix[3];
 	int ret;
 
+	if (!CONFIG_IS_ENABLED(ANDROID_AB)) {
+		priv->slot = NULL;
+		return 0;
+	}
+
 	ret = part_get_info_by_name(desc, BCB_PART_NAME, &misc);
 	if (ret < 0)
 		return log_msg_ret("part", ret);
@@ -150,6 +164,7 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
 	if (ret < 0)
 		return log_msg_ret("slot", ret);
 
+	priv->slot = malloc(SLOT_LEN);
 	priv->slot[0] = BOOT_SLOT_NAME(ret);
 	priv->slot[1] = '\0';
 
@@ -274,7 +289,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	configure_serialno(bflow);
 	configure_bootloader_version(bflow);
 
-	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
+	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL && priv->slot) {
 		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
 					       "1", false);
 		if (ret < 0) {
@@ -323,14 +338,28 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
+	size_t partname_len;
 	int ret;
 	u32 n;
 
-	/* Ensure name fits in partname it should be: <name>_<slot>\0 */
-	if (strlen(name) > (PART_NAME_LEN - 2 - 1))
+	/*
+	 * Ensure name fits in partname.
+	 * For A/B, it should be <name>_<slot>\0
+	 * For non A/B, it should be <name>\0
+	 */
+	if (CONFIG_IS_ENABLED(ANDROID_AB))
+		partname_len = PART_NAME_LEN - 2 - 1;
+	else
+		partname_len = PART_NAME_LEN - 1;
+
+	if (strlen(name) > partname_len)
 		return log_msg_ret("name too long", -EINVAL);
 
-	sprintf(partname, "%s_%s", name, slot);
+	if (slot)
+		sprintf(partname, "%s_%s", name, slot);
+	else
+		sprintf(partname, "%s", name);
+
 	ret = part_get_info_by_name(desc, partname, &partition);
 	if (ret < 0)
 		return log_msg_ret("part", ret);
@@ -382,7 +411,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	AvbSlotVerifyData *out_data;
 	enum avb_boot_state boot_state;
 	char *extra_args;
-	char slot_suffix[3];
+	char slot_suffix[3] = "";
 	bool unlocked = false;
 	int ret;
 
@@ -390,7 +419,8 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
 
-	sprintf(slot_suffix, "_%s", priv->slot);
+	if (priv->slot)
+		sprintf(slot_suffix, "_%s", priv->slot);
 
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK)
@@ -480,6 +510,9 @@ static int boot_android_normal(struct bootflow *bflow)
 	}
 	set_abootimg_addr(loadaddr);
 
+	if (priv->slot)
+		free(priv->slot);
+
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 
 	return log_msg_ret("boot", ret);
diff --git a/configs/am62x_a53_android.config b/configs/am62x_a53_android.config
index adbe2b8e126f..2aca51e3a107 100644
--- a/configs/am62x_a53_android.config
+++ b/configs/am62x_a53_android.config
@@ -11,6 +11,7 @@ CONFIG_RANDOM_UUID=y # Needed for FASTBOOT_CMD_OEM_FORMAT
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # Enable Android boot flow
 CONFIG_BOOTMETH_ANDROID=y
+CONFIG_ANDROID_AB=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_AVB_VERIFY=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c8..8c244c859bcf 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -50,6 +50,7 @@ CONFIG_LOG_DEFAULT_LEVEL=6
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_STACKPROTECTOR=y
+CONFIG_ANDROID_AB=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_SMBIOS=y

-- 
2.34.1


