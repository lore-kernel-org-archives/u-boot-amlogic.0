Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7728FC88E42
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:45 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15013.1789049078405001675
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 07:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=gYHCy1Db;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso11438225e9.3
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789049076; x=1789653876; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
        b=gYHCy1Db9RPKpNN7oEytU5tfBX3NBejN/bOZfxN0f+gUH9Y8952/2DCDScZcuojqzG
         wQZlzw4KnHAwMjtQctfRgDdCtjKDhFtXyRqMlennELBjAY0CR3Qr013KD4mrIT0RXjPV
         J+cIbVwtQPwwqatlOVr0FCPjYvrCt8OSa/WO7zzuUQTl+U2DM0FB3+V4MkmEckiliUc4
         iYGAaEPQ9+Q0xtUjpZIb+xXvKfoEU/c6mAZq1vLWTvGuYrlY9gLP1zMZ/Cou4pZ6X9No
         obJg5vHCufdz4deYqXVpsOvhTgJ7cLiYHZ7jBwPV5moYeU/ix1lNLA6uAnn89bwy0NAv
         b+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049076; x=1789653876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X0IoAfjKsiCDT4cgwlZ5bolaPEwGjA0V2cO5MiZChIg=;
        b=jPulN2QMUTlm+PZYiSfxF0ymgEaymQuSu8g32Yq8LXFRBMpe8bz4nfABYfSN824V0U
         gO/iO50ZUi/sI/41W4wstKfHULhAi9L62MEH920uPh1s9ljXHxBAw5dR4cRRSgzjV0AV
         POdaAfvt2ZuFdF+ebjOBTX0uu7fYyhPwjT6fCto8c+ia7SxEeJB/wk4cMh3DG9qIZFTR
         NZN1bJqv+wfCMA/729GYqDDB7OZqCgiOY6ZA/fKO27eWKjksiFa04Us+sXWDgx3OTiBB
         n/zhjLjNO661AByE/OSKYxNoOPQao3xiVdGUqOk3Noa/TD3TQBw1V6z0q52IfUOWEHRm
         OaeQ==
X-Gm-Message-State: AFuF++mEFiloittO28FP/v0/1y3H5bbeL30NFxviy4QAH+wF7uXjW0xY
	6wMCwJzDq3HiA+TLu9iQuxll25t9K0XCqc6mPJdicxV9Gah0/6IPFvGPdGZqXpo99Ok=
X-Gm-Gg: AYBFou1lVaZWzn/ac+TzC3WSgo7tkf2EgDQf3bHpz6J0a6lkxPsnETvnU8wpoUdOfMn
	uqVbYBg0QSvcDPK3GNss//i+MGDVZ1+bkKb4GhD+DlSUdrQ3RjGTls6Zf9q9Y9MvhL/+dGgKqO2
	oR/zHbLF0iy4UwnBSf8YdRsr1TD6mjybmPnANpWnJJdslR9wfreNOdKch2CKuhS8bnZOxTZVovv
	ICJ/Da35i+5yAcMzl+YJTgZnBr1aSEYesudCE/kF3lXiWiLjnRQJru6ZHuc3vwHz88zEIplYZVN
	zM/Avtyhc54E9MNNYMjotJzGfAuXhWCNh6Ez1vN0sbL/Hvbhtqjidh4ntzZyzTfzmFdUhNsM/yr
	mU6OqAQAncJQIxNgH+9TGwdGmf4AxtX1OCQiWnw83GwkGlDMlLpDVI/dx7gH+vMqV0bmDL1fPze
	ku7Xex8TspltefdB2mjeMfi++voQ5JZz10fHoCw8a5nLliaJoY6d6ZYJf1vNC3
X-Received: by 2002:a05:600c:45d5:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49d258f1d5cmr144248015e9.7.1789049076585;
        Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:04:36 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:23 +0200
Subject: [PATCH 2/3] configs: sei610: drop Android support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-2-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 14:04:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3090

Android is no longer supported on SEI610. Remove its Android
configuration and use meson64.h for generic board support.

Drop "fastboot oem format" as well, since it depends on the removed
Android partition layout.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/sei610/MAINTAINERS |  1 -
 configs/sei610_defconfig         | 10 ----------
 include/configs/sei610.h         | 30 ------------------------------
 3 files changed, 41 deletions(-)

diff --git a/board/amlogic/sei610/MAINTAINERS b/board/amlogic/sei610/MAINTAINERS
index 799ad687f09..6d0159f204b 100644
--- a/board/amlogic/sei610/MAINTAINERS
+++ b/board/amlogic/sei610/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei610/
 F:	configs/sei610_defconfig
-F:	include/configs/sei610.h
 F:	doc/board/amlogic/sei610.rst
diff --git a/configs/sei610_defconfig b/configs/sei610_defconfig
index 7f6488dfba0..91ebc3282e1 100644
--- a/configs/sei610_defconfig
+++ b/configs/sei610_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="sei610"
-CONFIG_SYS_CONFIG_NAME="sei610"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_SYS_MALLOC_LEN=0x8000000
@@ -25,18 +24,12 @@ CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="run load_logo"
 # CONFIG_CONSOLE_MUX is not set
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=y
-CONFIG_AVB_VERIFY=y
 CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_BDI is not set
-CONFIG_CMD_ADTIMG=y
-CONFIG_CMD_ABOOTIMG=y
 # CONFIG_CMD_IMI is not set
-CONFIG_CMD_BCB=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -47,7 +40,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_BMP=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -58,7 +50,6 @@ CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 # CONFIG_INPUT is not set
 CONFIG_MMC_MESON_GX=y
 CONFIG_DM_MDIO=y
@@ -99,4 +90,3 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
-CONFIG_LIBAVB=y
diff --git a/include/configs/sei610.h b/include/configs/sei610.h
deleted file mode 100644
index 783eece271d..00000000000
--- a/include/configs/sei610.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for the SEI610
- *
- * Copyright (C) 2019 Baylibre, SAS
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#define LOGO_UUID "43a3305d-150f-4cc9-bd3b-38fca8693846;"
-#define ROOT_UUID "ddb8c3f6-d94d-4394-b633-3134139cc2e0;"
-
-#define PARTS_DEFAULT \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=logo,start=512K,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12274M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-
-#include <configs/meson64_android.h>
-
-#endif /* __CONFIG_H */

-- 
2.34.1


