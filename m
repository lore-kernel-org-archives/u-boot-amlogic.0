Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E177D0EE15
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:21 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.15405.1728661873654227487
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2024 08:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=DCErq9Rm;
 spf=pass (domain: baylibre.com, ip: 209.85.208.182, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb2f4b282cso12378601fa.2
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661872; x=1729266672; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uW8IdV05RANjzdKmGhDvEMhEwsA9h4fg235gPLYTrYA=;
        b=DCErq9RmP0doCrEhVVdMy+7EAgqflAgQxwbtOvAwRy5CLCiNuHoPbTEyIKaqlxd7ms
         x5JFOJMxMOufItXWqCu1EiI0QTcRaVd5krDwDWFi/LZx4vd3LTzbW01hbIeZBTYKxDQv
         G5F11tavHLqlt00JzC4vkTYZ9RV+1/kJhJvhzOGrmvD4Hc2S9z5YjBTSu91JEXgembyg
         ENuXxlA7PrqlNU4DHaSohK+d7wTIE2sOIkQu8KH+DaLLePwnxDHVGzd2SHw3yIlXLX2Z
         CQPGwCSq3sbNKdDLpeZbTrjRuN75COYS2b2541XEtBhOY89MoHpXrbzYlgdAtAuSIJ9I
         RX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661872; x=1729266672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uW8IdV05RANjzdKmGhDvEMhEwsA9h4fg235gPLYTrYA=;
        b=IY7KhF9MvKuFa6eLnNUHRtsGwsQ6oTdMVJ/BB+DvBugIwR8wtKk01jLraif25uFpz7
         nruV3KLGPjcKRinM6at3YptjmQE7YsWbwcTEHEj8i6Q8EeSI1lRcq4k81bCE/krlLV04
         PhsgVaLvQgEGhNkQA2b9sV0R1hp+iZb5qBnqRkrH+3qjkSpYzX6Dp9saWyO8CmK/zRdk
         /BLY9IjZwY7REIOHirB3wq26AQNmoszux2hKtHfTOekQQKRjMHePoF0Ny47lEVwbC6gN
         fbvQe3LNk62xY1NO4fI/vqQGDIYS+Z2Xci2b3HzLI6zP6s/D/szm3oNQVgQkB3DOEibv
         0ykA==
X-Forwarded-Encrypted: i=1; AJvYcCXz3KN1oSPcZNPyXyTGprbTDHkfpYDrMmBOcSqbeY7GLSv2Sax9ODwRbdh23ueFqL0/T5zrhd/Fpe1wctWWFA==@groups.io
X-Gm-Message-State: AOJu0YwZ3kZjrN0WrzWEXwgMa8oJxXLN72axFQ1sbTxZo/XKgO7pGmkR
	MFegpoamZI01htSFD+3IHfYuS+GFMK9Ter/vyg181vlejE8dV7BOhWaj8U2P2BY=
X-Google-Smtp-Source: AGHT+IHSPTkof1aGdCl/QXztBgg35wZz+4EB6/AbGyOxHxjwVuKBoF79QBlDvZ/oVeonq4Dyv5ZPPw==
X-Received: by 2002:ac2:4e16:0:b0:539:d10b:e389 with SMTP id 2adb3069b0e04-539da3c6469mr2175158e87.13.1728661871686;
        Fri, 11 Oct 2024 08:51:11 -0700 (PDT)
Received: from mkorpershoek-xps13.home ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:51:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 11 Oct 2024 17:51:02 +0200
Subject: [PATCH 1/2] configs: khadas-vim3{l}: Increase boot/recovery
 partition size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 11 Oct 2024 15:51:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2448

The Android Common Kernel is over 34MiB now [1]. This does not
include any kernel modules nor the Android ramdisk.

To make sure we are future proof, increase both recovery
and boot partitions to 64 MiB.

[1] https://source.android.com/docs/core/architecture/kernel/gki-android15-6_6-release-builds
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 8 ++++----
 include/configs/khadas-vim3l_android.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index da6adf6c413a..b76e049f09cc 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -21,8 +21,8 @@
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
-	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
-	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
@@ -33,8 +33,8 @@
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
 	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
 	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index b1768e2d8211..0ab8ffd372a4 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -21,8 +21,8 @@
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
-	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
-	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
@@ -33,8 +33,8 @@
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
 	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
 	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \

-- 
2.46.2


