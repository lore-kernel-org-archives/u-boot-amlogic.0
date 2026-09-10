Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B56C88E40
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 14:04:45 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15015.1789049077740575347
 for <u-boot-amlogic@groups.io>;
 Thu, 10 Sep 2026 07:04:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=eWr2ubcL;
 spf=pass (domain: baylibre.com, ip: 74.125.225.140, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so14639335e9.1
        for <u-boot-amlogic@groups.io>; Thu, 10 Sep 2026 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789049076; x=1789653876; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
        b=eWr2ubcL1oQchdwKcwGktSCtHWX0UzMvG2HZYzxcmKvX1zS7nbevBWTPgaaFq1ESaY
         txxGVnHiKaiZVq8lcjIloeHVjWD+gYmFXVykIecgxRDbm/4t/I9LqY7IDoXSqxSdpho+
         qLTOYo//qrQn3ikwDKamg9LvjN7fl6PQMuZzE2DTi6DnMzS8evn2Oot4mYCPxVg5cvp4
         UoS7Oy43C0dYTE6ExYoirVdR0GGoHB5RbFwp2f2ShEGaIFAUZF1jOXe0fRCDyEVOj9sE
         d05mqPojAR1BpF8A2w/0kz9rjsdPT608pMxPEPeJRreWVX0RuoXk3VP0LfHwwRZYXepx
         vnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789049076; x=1789653876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgqLAMnM0QnMkdx8jYMYTz3x06MbZ4R0X0M4NhMO5Ok=;
        b=ofHD6VlaUrq/sqG5n7w8FX2nVyEPBB+S2QXJaT4PytjP+eMRpYWHOcZwzh48d0GgLK
         Hj5cQfSHzkgCGq16vsWGNHbqst8Pa7XiN790DQq94GrnlrnXXQgNwnNCxzy8zzErP5XW
         rHCITmOWHJYuI09ZHoVskmqPEFWc0E4obgRa77bIXy81mYXw2btiXFaLOhQeXjBN/i8h
         cC4lPlhOWs732DrnSQ3mKSihOXfeFAwP8SFlF805Qnt6b1KZF6dWiKUveS0VFtLm+juu
         zVBCTs2wr4Dio5tHd0NlXruLV5npglCmfCpvKGtxmvuTCW4vH5sg7wRd0lsrO3fR+BrQ
         hn0g==
X-Gm-Message-State: AFuF++nEbUoDte1r0SZVR+kyBWUeoOIjglhp+OcOFr0W1KymkVTnDlqi
	HWH6jNFGVD+QRh4B8YJ6lny1xXZe6zGSSvV7zsLLFqm5xHXUDjcZcPqjWxspbJnKjfk=
X-Gm-Gg: AYBFou3xWnpC2wGpHdSOYQb3KYFYofMA9t6klNQjDKuq6TCvUUiFfet0f2CunsoykWr
	jHNZiXjjC7m6PWTi9TVdTa5ZSZrUCWh7/YKIYjDmWREtbLD5B5mCMMte8p841pmuAJgpl+mOKzy
	PEvPSZUADUNiPjpLSvD+2o03Yk/+Kb/fjUzRtKsNF7zVw0y9U1VGxgwfw5EwlqnO4TSeHOx791J
	6+EyL6I3069h7CgOOpFFAC5H5Vj34iBWpyFdDQkuEMDZhiGSLNyANQypYz1hLhRisr5pO+BtU42
	STCoACettCpcxZgvewGuULmE+YIKZqNA7o/5xDeimEa+YsXkhtMdpALszOokOGzvMcj7CZGyXQb
	vILPABA65lZQTKWBU19A5SxSDCom8CZT6oFgDgy3K/giegujbQooh8pZJKz9ISkdrxG2PXrRwhe
	K/TilXl5T5ZVs5Mu/tZCjPDOOu5dmKHxprNvdk1jLpiwIN7JEfrzDo1YO2T8bTTtaf92deUM0=
X-Received: by 2002:a05:600c:4f4b:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49d1f21afcdmr231341375e9.1.1789049075852;
        Thu, 10 Sep 2026 07:04:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm147660745e9.3.2026.09.10.07.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:04:35 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 10 Sep 2026 16:04:22 +0200
Subject: [PATCH 1/3] configs: sei510: drop Android support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-remove_sei_android-v1-1-b7bcbcef3834@baylibre.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3089

Android is no longer supported on SEI510. Remove its Android
configuration and use meson64.h for generic board support.

Drop "fastboot oem format" as well, since it depends on the removed
Android partition layout.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/amlogic/sei510/MAINTAINERS |  1 -
 configs/sei510_defconfig         | 10 ----------
 include/configs/sei510.h         | 30 ------------------------------
 3 files changed, 41 deletions(-)

diff --git a/board/amlogic/sei510/MAINTAINERS b/board/amlogic/sei510/MAINTAINERS
index c6039bc82e2..ea27e800983 100644
--- a/board/amlogic/sei510/MAINTAINERS
+++ b/board/amlogic/sei510/MAINTAINERS
@@ -4,5 +4,4 @@ S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/sei510/
 F:	configs/sei510_defconfig
-F:	include/configs/sei510.h
 F:	doc/board/amlogic/sei510.rst
diff --git a/configs/sei510_defconfig b/configs/sei510_defconfig
index 689c12e388f..0ef6343098a 100644
--- a/configs/sei510_defconfig
+++ b/configs/sei510_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARM=y
 CONFIG_SYS_BOARD="sei510"
-CONFIG_SYS_CONFIG_NAME="sei510"
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
diff --git a/include/configs/sei510.h b/include/configs/sei510.h
deleted file mode 100644
index 0f8070b8d31..00000000000
--- a/include/configs/sei510.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Configuration for the SEI510
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
-	"name=logo,size=2M,uuid=" LOGO_UUID \
-	"name=misc,size=128K,uuid=${uuid_gpt_misc};" \
-	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
-	"name=vbmeta,size=64K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
-	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
-	"name=super,size=2304M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=4820M,uuid=${uuid_gpt_userdata};" \
-	"name=rootfs,size=-,uuid=" ROOT_UUID
-
-#include <configs/meson64_android.h>
-
-#endif /* __CONFIG_H */

-- 
2.34.1


