Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC02D6A233
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 21:29:57 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.5703.1731619796307445321
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 13:29:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=b0zfZ5AO;
 spf=pass (domain: baylibre.com, ip: 209.85.221.52, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so722716f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 13:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619794; x=1732224594; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=b0zfZ5AOng61F+sk0C0N4NCT2gk9ChG3WAYrbFGGEnpMeOwEbs3YbtvCSu0oEKJFKd
         TrsnjfANcDlNBnRklZsaqwPK0MtD9tl0KdSAttZAztcsXVJlfiEWRqBkGYzY4mi7P3K/
         DZT1ZAIFCm9nkJLDt7b0lwgQdvqTkOwZvAAI72iXaoelDQI2ThAK6GV7JI/fODbxXvV1
         mKY86yQ/pRYNDBv9LnkS1kuV/56xiHs/7Gt7XvtRcT8ib1H7o7SnQ/Dfw0A9Ppm5LVYf
         /yjtdipVRQ4iwJnUxv5LTjWIimindWOkjBb7oyQIKlXYZEzQI3oDdfecZ3hVZ+8EHJm9
         rgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731619794; x=1732224594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=FTyePCjU1aLvPYIsDGYuX4Qd5yTJzCGgkP8TYFKRAWUwMTCYHdK0adEuO2wO9/L5AA
         3taTDqrzF5FJtVBWbYATs0/zDLykNsVjNBxbotz7xF7jM/twxqqZEosriCvwBZgetkaI
         MGq+Mf/t4NhZY90fd8mtW6LMxtNHzJGvndfwMQzqNBDkqIkQBTSUcfMlvUGahBzK975/
         UKVX/7BbVNe73+U5WT+gtk76Clni4AB07qPBOT3MiXzbBmAcpoKm8EEraupTBhsw2yEA
         1JGf33o4SjTNgRP1+3DvCGwsGSASQu6QrGy7p/s8vJHeIZKy0c4i6L/4qDTiS3mcZ2uA
         Jn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUoIF0NIrq8rWC4RtkFXJp8fkUm/oWO3i9gppXQWDG4kL7kvL5FuNDXsrnjM+ZAMeKEFydYlTN6nR5LJRPvFQ==@groups.io
X-Gm-Message-State: AOJu0Yx1e/qAf91GS5QsrZForvvp7nGHGuNQ8NAxPAkRKGZHuvKEQlRy
	MxkQBpDDD2bkWB3bbxS6QeNM/f5qdxvgOhOIk8/9mOf1IgkmIF+wTgZHP0dQ+wFY4hhP97iox5g
	Me+M=
X-Google-Smtp-Source: AGHT+IEcBF+9wkrlQEeC5mSKwymVTfnjHDGNZswpOEf6Vm1s0Zqh2lo4x44cfOJGgFluSzI2EJsSsw==
X-Received: by 2002:a5d:598e:0:b0:37c:d11e:949 with SMTP id ffacd0b85a97d-38225a0b7e6mr205729f8f.28.1731619794247;
        Thu, 14 Nov 2024 13:29:54 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:29:53 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:44 +0100
Subject: [PATCH v2 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-1-015bffb1373a@baylibre.com>
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
 <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 21:29:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2551

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version is less than 3.

[1] https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Tested-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1


