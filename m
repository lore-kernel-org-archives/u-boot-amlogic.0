Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD7D374BC
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:52 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.1853.1729181447073747767
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=GsiMArpi;
 spf=pass (domain: baylibre.com, ip: 209.85.221.53, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so791758f8f.3
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181445; x=1729786245; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypEy+gyVZPJdWyy0rUEA8YAJ2c9h6fNy1ZHn+v+cvco=;
        b=GsiMArpipCC5c0JOnLJpuDRAlXhopih97vF2vDh9Lv65Hhjss3iYDu4uV7+se2FeBk
         iB2tPfSwWScHY8XzcZ9dYR9T0wDfimQb+v++PMQJxopxJc/0dtpg5LCYpoI8cuN9FgT9
         PMgX8Ayj/M+eh/Uv+/IyDXGBtVi2stQZ/+eNphl6U9MOBxGTQC7M42qaDKLiU8mVIVVT
         Qc7ST7tSHlgVHa/2eaxcZUPEJju6v9sFOZ9LCa0wcI/bGmPXNsVZx0HJ7izkBUsmling
         c4SKGinz++kHvzJpFwfPZsm13EOw+bL8F3GlWlYJjTYMd69oZbL78+zs/oDM5E7ICOYf
         cxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181445; x=1729786245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypEy+gyVZPJdWyy0rUEA8YAJ2c9h6fNy1ZHn+v+cvco=;
        b=M3/VwM4UlwRPOxeVpOim8RGpFBg2uoZYd7+cmkSh4VRUXBn9oNr90WkmdqpZC40foV
         v2yVcpdqOylT5YArRzFrvxnIAIwV6ZopsV6Vsnn+raFIgUEx6bNcpRYi+yZ5Gq9qUfxT
         XL9HD6F45xwpL6XlA3H3ZdCTSVu8E+5qi4y9QROAowBBtZ8q3n1jNBpEKMfkiUfCm98c
         mLJLpYuT+WZbDChn+3gxtNL+v1lLjxrizRXx6fQ0UhKCpAaX/uG9YinXQHVALTTvh/jp
         FchJBUF2TfeVON+YMKq1EGPaLbws7XhL+WWgMb8a440mphtxOb7b/eqiT4wCxl1XAoEy
         x6ow==
X-Forwarded-Encrypted: i=1; AJvYcCUW6jwXZjm95FRP3ia2nWfRDCDC/VikoGJJzjOWaWudrLYM92wpDKQUXNoeL4aMIep1dV7Vz26YlTNUkEsFJA==@groups.io
X-Gm-Message-State: AOJu0YzsuEaSlXQl3ku+4vRUy7U7hYO0l8GegE5fZqgjusbVYEl/ZK8A
	BAUgPtQEFsmjaMIZ9lzew7CeHkwTNkjpYRf/0WYe4228bomDiR5jVj+ug/ZhU70=
X-Google-Smtp-Source: AGHT+IGdLQEVeyz6TCaxDZbNYOA4Gm0+koijcA15cq3eyxPttmNlNE7tBONKxNO+Bi4YbItriTsx+A==
X-Received: by 2002:adf:fe86:0:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-37d55198857mr14799341f8f.9.1729181445378;
        Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:25 +0200
Subject: [PATCH 1/6] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-1-781c939902c9@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2503

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version if version is less than 3.

1: https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

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


