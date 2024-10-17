Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5238FD374BF
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:52 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.1856.1729181449034143221
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 09:10:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=OW1PJS3+;
 spf=pass (domain: baylibre.com, ip: 209.85.221.49, mailfrom: glaroque@baylibre.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so839730f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181447; x=1729786247; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eek7gRBW6g+Iapx/5zEf6sS/TBDPdHF5a1htgBIWQQg=;
        b=OW1PJS3+Cv0FQfYXwREdmBczoNbkl3tG9DjqXl8pPLjTJeDcFIwUR9XqqGUfgsGUSR
         Ddj2JfWF2ZLwgdwy93r5dG9v8qWQPeDelWBxYJT0Z/TycZ4yhFXAL2ha5Ci/bW0XGxy3
         ifp3JBIR6YDz21Z+VEqN4TPaSonjluL6OBnObfzMrff4Pm3XpbRaDgcr6Xc4PYoppLQ/
         s8aYxBUPmVuzaFT1YVnqomi0v05AvVCcoQuK4ebSxToCJhtnWsfMdo3lqH9cf3PyLLu3
         oQ1PEZIpLrAE1cFtgPYj/sNiU6FhrWgI5HCwoctVkw+gpb15xWmJ2qDSkmgfXia4w3gw
         Pl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181447; x=1729786247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eek7gRBW6g+Iapx/5zEf6sS/TBDPdHF5a1htgBIWQQg=;
        b=lBLaBljD8/vhqRwTCvARA5gWCTv+WZPv8ML2i5RqUl349SQKSqX0KOlMUfKmP165mj
         jHfKtTZf/wqDJ8Tr68jcHmD8MjGLOlQdbKqAKCQetiTSZ5HDsX3dVRu6m+2QmOahcMXk
         ka1GbXKDrhRXVfGZUZXOo9hQWDa37j64/NBrVe8cSdgxWrCeNjg4TyeSMPgm0lFrkknU
         f4Gy8yQQ+6HX1d2OPTUBsRlHQ0hGS3TV4VSYRgmmpiNY4i0l9Lsvukmf/Eiyzt+Xu9oq
         x+aElx/Q5fXCOv9tmLyUVI5QRDY5vg+vkETzEU/S7Xcfs8W/s/0i1DJmb5hWYCM8bajS
         zNNw==
X-Forwarded-Encrypted: i=1; AJvYcCUVrWsSWFZpygTaW+agjerjSjqH3mK6sKNMvrEY0nC6zYqQM3g4iIrgPbX86MM8RUxolT5nXBVbZS80YGnEYw==@groups.io
X-Gm-Message-State: AOJu0YzgwdQmEUF5tdrfLLnZjGGPW4QHLbsR76fitQDA76kTtYhb0k8k
	rS73Un9WkHiNPi6rKauAgew5OA5njB2T9zekyFb5EjBnQStKbtBd/qyDagCEQSUjxHfx4jhDZrH
	S
X-Google-Smtp-Source: AGHT+IHLxEIBMQzPy2d9LZ5WMJTJFVui5jEuVkjRgsMH4DB4Qlx0CqgWUHdQwrTv7wwYrhLDqW8ARQ==
X-Received: by 2002:adf:e908:0:b0:37d:33a3:de1c with SMTP id ffacd0b85a97d-37d55262ad2mr15901805f8f.38.1729181447313;
        Thu, 17 Oct 2024 09:10:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:10:46 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:27 +0200
Subject: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2505

After increase boot and recovery partition userdata was not resize.
so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
$partitions` fail because end of last partition is outside of eMMC
size.

Remove 64MB on userdata partitions to fix it.

Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
partition size")
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 4 ++--
 include/configs/khadas-vim3l_android.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index fc89efb4c36e..0e2953fe71b3 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -24,7 +24,7 @@
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #else
 #define PARTS_DEFAULT \
@@ -37,7 +37,7 @@
 	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 5b2aed1cf62a..f39a3782d663 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -24,7 +24,7 @@
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #else
 #define PARTS_DEFAULT \
@@ -37,7 +37,7 @@
 	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 

-- 
2.34.1


