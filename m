Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8CD4414B
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:59 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.18863.1732016269695020005
 for <u-boot-amlogic@groups.io>;
 Tue, 19 Nov 2024 03:37:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=JIsrm8UZ;
 spf=pass (domain: baylibre.com, ip: 209.85.221.41, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38232c6311fso2203216f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016268; x=1732621068; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=JIsrm8UZKTbSJlJ9fRueJe/xcGorbpCX8VZobe/sqZ4T2Fp5hhQG/RCoZ/EFpXC40L
         qa8FJPuKzrUkFeSsl4Q/uYr+kgJ1xDa0XxYaWGgBfMiIudm/8zfTEMoGWTA3EdSG0tvM
         +nn/iChyxVYPfh1OF3vUvfQL0S8XF6nfDGcLbC7YNsTc6EhQcyL/rzOtULVZL3X3DtXT
         Dlx4Q22U5/2LtRY2NOhGtunHrEz+GO8NizRqn11KI/Xmcn6MsabiGpXT8PKbxDwTkl/r
         V6sKAnSZXfOoJ1NipaG9799DMrjw0CNw7WHFZDXC2e2TTGRhzV91eyN1zBHTxHrYSJVe
         wWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016268; x=1732621068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
        b=CEy1MRoy0UL7YZrOj8drOLhY7HfpqFpNpy0TtgAs7o4tUlxxkRzMelash/8ePJOI45
         wS2127qMrlxaQK6O60qYblSIZufC1jpnzw7jM7ja29uDRVyyAdEsR+otgzvkDVPt7X5G
         hziTE+fwU+xao0szxFcRcJTYggptbSqdoCO+2pED8oyTpLv8pRiL/LOFJ5fjCJE7FJnc
         v2QHyAMG+AW6vHQLAIG1J/1PqUkSENWhyhv8pW3OwN5T7eIOhl7jglBO6TrdUkX0ijnp
         3kAPp/KzfZvA0sGrnJwJkrspn7CFB7x/oJXgivtSeAdVBjteknnErx53rh5ee3kjLF48
         7t6w==
X-Forwarded-Encrypted: i=1; AJvYcCX0nU4t1HqoJk/tlA6063AsZ9d1++x66ZrNc7MYUX9YluAZjIKAMXV46umLEJl5kgDqiDgAe8nubo0iwe6OWQ==@groups.io
X-Gm-Message-State: AOJu0YwGXp0Fb+ztACy+uEExm7T4I6xSi2u9+d7K1uQA1+nMFZpsQqkU
	gOJgPDDpnx57Vt3KAvJkrmVsxWuoVNmkl3bzWwsjK/cQwU0CLz/e8Y1RUgSmRI8=
X-Google-Smtp-Source: AGHT+IEBPT4bYyGwfkt4HQMtOmqYXe/9FNToq35yIq0uimkcEXhMgGy9cU8XLVZ6lpLoVhZ3zm5XyA==
X-Received: by 2002:a05:6000:410b:b0:382:4b6b:bcfd with SMTP id ffacd0b85a97d-3824b6bbe46mr2352557f8f.33.1732016268172;
        Tue, 19 Nov 2024 03:37:48 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:37:47 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 19 Nov 2024 12:37:38 +0100
Subject: [PATCH v3 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-adnroidv2-v3-1-45baa486fb31@baylibre.com>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
In-Reply-To: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 19 Nov 2024 11:37:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2568

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


