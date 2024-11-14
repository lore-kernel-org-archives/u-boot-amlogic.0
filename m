Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802ADD6A235
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.5655.1731619797196536825
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:29:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=ltv59LmW;
 spf=pass (domain: baylibre.com, ip: 209.85.221.43, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38223cee0d5so39107f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619795; x=1732224595; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+NoPWiZJn1nodJhNJoyPyQr7vFwN82gPGCxno4/qO4=;
        b=ltv59LmWRihGyv7jtCiGGTbCY3l9rIivv6RzOMbWNqacw950tbmqdT3/xtkNqY3LsQ
         RTS+IgUVYTLO0LvU9jC5HR/mSGzsZlMKZN0Jnp919WXPt+WyVZhu0mv3CEcd3nYj2Fo0
         lJZR9JZDGOJS1UTRn5pilmKH/2StuRwgWKcSMUi2V9ajY26tHfks70DlROVbBc1apSuR
         VaeXf9hn2/Z+IHkCbfkcngBX35KknZNQbsKTgDHN1DL+rMiGLp5wN6B6yA7ZUkqTLhKR
         DHxnUeNRXuWkbeSfnNKalfmYDf+kqyQwu6me/VwizMLfUPbU5PB84ViLNn0aEAMowZXH
         GURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619795; x=1732224595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+NoPWiZJn1nodJhNJoyPyQr7vFwN82gPGCxno4/qO4=;
        b=lhpu4fcIhNDPtRIcHkOK2TR7t2+fFHZd0x5E1jwNOCVvxPYOZoAP7KeP0zN+o2KL8D
         UMIKH3gm8eCgH4y3xDFVsr8ZKkh68izsCnlyOlIQafb6EjK6r7M6j8GQVu6Jz2SuwBs2
         e32q/jYjlm+jXyZFwjZE49Rv9zDu9jRHy/GgGrr95TBK+TdQoHjlcR/98Efo7rVc9Olh
         KS/EnF4AcNJaLDL9l1DQ+1h5MXmRItEUfZPpijcmFJy2X2Az5mAkVqJ2qrXqv9EZWA4Y
         uorVm4y6hDGTZeuM+Yu7LtnYXc1PtlvbjAxQEQZWKwVqRfuul+nhIyTsvSwDFGvp5l9E
         qTmw==
X-Forwarded-Encrypted: i=1; AJvYcCU1rMzAzAKhcQnwkuzneUKlLZEhqt3L1mchNFxBd6HAaTQ6blMmuqbkHFWC/gcSGkz/KFa5gfK9v8Eq4DD8oQ==@groups.io
X-Gm-Message-State: AOJu0YwxD84lkUEjtFsMhagmiuZ+jlowP5+mihVsBbpoL78WuH/+Wpww
	3VGGaNmAECHtKh7jvoPvnXlNGLWfxM69bpn9rDul/ILVi9aboNvR4IJU+iXc/arDb1UnMyRwQ2C
	FarA=
X-Google-Smtp-Source: AGHT+IGLDUSuKHTYaHRlxMU4dRJLdx+fXfWyCyU7xbhTgiVVF6usQ6jXpll0wnYihMU585dIh/UggA==
X-Received: by 2002:a5d:5e0a:0:b0:382:2349:b2b5 with SMTP id ffacd0b85a97d-3822590f8b3mr225419f8f.21.1731619795377;
        Thu, 14 Nov 2024 13:29:55 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:54 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:45 +0100
Subject: [PATCH v2 2/5] bootstd: android: add non-A/B image support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-2-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 21:30:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2553

Update android bootmeth to support non-A/B image.
Enable AB support only when ANDROID_AB is enabled.

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


