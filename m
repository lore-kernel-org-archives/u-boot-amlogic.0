Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4393CD374B9
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:52 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.1854.1729181448037830613
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=rvYJEO+j;
 spf=pass (domain: baylibre.com, ip: 209.85.221.43, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso880269f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181446; x=1729786246; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI865ORU5M3+h8g6Id1rOMoKVljvk5cflOPVUidj2Ok=;
        b=rvYJEO+jCzWtR+VBTC0zD1wZP3ctA84rwwjxFK96410bn/FkuWyGaJ0RmvNOAR3Yck
         1c+P+GZw+maOl9lSJitKPWenKzKWSgjj3CJZYGZiImDJGPmCa2D7ijFVPp/sP31tqH05
         K3fa8OR67eWwuP2n5Rr7RNfLZnUR469ZprI7mk5b6RbfuXwvLejLlX3ch/291xxF3MTJ
         dyG3KMtVfRkAD0DIBSw1J9r5udyQvS7CRvtGCVy3BEdHc4PULnp0dFXLx2YG8azBm0d8
         g2zpyBW1gFUUs9m3dHQHPti4Dme/ZIQXtSySnJdUHpQNfPqC+mZcj2u0AMkZpBs5s1Ta
         GZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181446; x=1729786246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI865ORU5M3+h8g6Id1rOMoKVljvk5cflOPVUidj2Ok=;
        b=ijjO3ob3Q+02MAsSALYb9KdA4TO1YwY5/wcp9nHZcyL5DFgElGuSgJJia79tedTEt8
         xeySMFHEZBDvljNQt0oV82P8ELQs3h3s7L/exeu5+qym4jhqCTyXmOgeKmPI1jYD3eM6
         bW2BxSIrLNM8h2vpe7dFdvqCe6GQzPCP9K8XaB1MBYqyoTSadQEjTlCAWQRE0dEasFyl
         vGfVJObgdIhEkyViBS/ds7U3SVXGj3W2wrZZWHgxIWPVqJh+r7RIN0bxJLlfL+kru9n5
         b329UXnB81ofl6zihNHHKoVIOVL3xLrQRF+g+tZnWND0kExDSpvFnIvfM6NnLMAcJlWp
         Xqkg==
X-Forwarded-Encrypted: i=1; AJvYcCVpalJz1GzSjCDaDPyjinbgz2FLZWHbXVby3YSMC2wNcEzbXb1NPNWBK0TofaI/V9awL8q4FYXyAi4uao4bKg==@groups.io
X-Gm-Message-State: AOJu0Yxv9KAryjZ8cQnq796rweHeSX6d0UhSX7pNCtsyMnt08LzoKJ+K
	wIxUWZ9Vz1hmGdLarppo9HU7uzBrl9qQWQtcEaU6zlrOg4a+VBRIDlGY9zBSy30=
X-Google-Smtp-Source: AGHT+IFZ+ZgyMCO9Hm1RZf07wJLvzl+dqzIpsknhtVKFghTdbv9eqzeRBtJOMdk0OSwUna7qM1l4iw==
X-Received: by 2002:a5d:64e1:0:b0:37d:3a2d:8577 with SMTP id ffacd0b85a97d-37d86c03b05mr5909717f8f.33.1729181446339;
        Thu, 17 Oct 2024 09:10:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:26 +0200
Subject: [PATCH 2/6] bootstd: android: add non-A/B image support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-2-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 16:10:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2504

Update android bootmeth to support non-A/B image.
Enable AB support only when ANDROID_AB is enabled.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/Kconfig                     |  1 -
 boot/bootmeth_android.c          | 53 ++++++++++++++++++++++++++++++++++------
 configs/am62x_a53_android.config |  1 +
 configs/sandbox_defconfig        |  1 +
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 1d50a83a2d2f..fa0739ff05dd 100644
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
index 2e7f85e4a708..8fa4952df3f2 100644
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
@@ -323,14 +338,24 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
+	int partname_len;
 	int ret;
 	u32 n;
 
 	/* Ensure name fits in partname it should be: <name>_<slot>\0 */
-	if (strlen(name) > (PART_NAME_LEN - 2 - 1))
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
@@ -382,7 +407,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	AvbSlotVerifyData *out_data;
 	enum avb_boot_state boot_state;
 	char *extra_args;
-	char slot_suffix[3];
+	char *slot_suffix = "";
 	bool unlocked = false;
 	int ret;
 
@@ -390,7 +415,10 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
 
-	sprintf(slot_suffix, "_%s", priv->slot);
+	if (priv->slot) {
+		slot_suffix = malloc(3);
+		sprintf(slot_suffix, "_%s", priv->slot);
+	}
 
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK)
@@ -427,12 +455,18 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (ret < 0)
 		goto free_out_data;
 
+	if (priv->slot)
+		free(slot_suffix);
+
 	return 0;
 
  free_out_data:
 	if (out_data)
 		avb_slot_verify_data_free(out_data);
 
+	if (priv->slot)
+		free(slot_suffix);
+
 	return log_msg_ret("avb cmdline", ret);
 }
 #else
@@ -480,6 +514,9 @@ static int boot_android_normal(struct bootflow *bflow)
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
index d111858082d5..6b8dedf20712 100644
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


