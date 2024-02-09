Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F295C4829C
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 08:58:45 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.7605.1707469120065001960
 for <u-boot-amlogic@groups.io>;
 Fri, 09 Feb 2024 00:58:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Zrzqgdwm;
 spf=pass (domain: baylibre.com, ip: 209.85.128.45, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4106cf2e9e2so2401455e9.3
        for <u-boot-amlogic@groups.io>; Fri, 09 Feb 2024 00:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707469118; x=1708073918; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=posx/ZxBxswvvlLYAmXzcIYEnem1fOJ4oCDk/8BThCU=;
        b=ZrzqgdwmTW3XURjTh7h8uIj96L8gjockXserZ6Bv737x88H5PC7yMGdU/i7QipCj5i
         JwpRgTeUIdm1WxcPQaiuftrLiums8M74Zev2XdK6iidfPU7kEslpQ6NzgaLu7mz6T6Km
         uEorbBHjcyrsQxb/BkIoaWwLMTmRhtQY/qqK6RkIW1sfgjsPHKnpZ+GHKA3XX9XW36ZT
         sDCpBqWgkY5107d0cpl0Gcjx0cl263coHXMhbHx39IRzwn3b+O5jv6R66VCfHKnKKSbS
         R8yE4MjMP5fHX/Ok2vHsiZpit5DcWt3QzwkyOrs1g2MghHZxxv3xq3VjhnMTwB59ye7S
         dlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707469118; x=1708073918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=posx/ZxBxswvvlLYAmXzcIYEnem1fOJ4oCDk/8BThCU=;
        b=fHvPMcoVZft118HmyTuy2KsXmavQ1mcrF90MzjgC3S+DnTD9lIRyq7s0CadbGuu7kg
         2JDnadIfkL4oJjf2+OSnShFuUBo4RPre+IRQwGGeY6ZJmw5C6uUilsqOvCkfJwzMTFVM
         eJBpgSsr7iS+JLuB6iuuZQAYYJfqDKkvJZVdkDmHpOqYvjexA5Dt0f40MBzq5QpOB7O7
         t+x6E0hxBcEGua4xu4cv6Atau0vE/cMcR5CXuRTfknCWnxykaAqr377NDHzU6j9zEWAf
         ny3uySK/hcKgkUoaAQ27wm0ydvBtxKisQvz8SWVR9RyXDSiAfFK6cRw+D8zMUn2Xwaju
         rwjA==
X-Gm-Message-State: AOJu0YwUY1VVN6cY5rHNZH69a1Uap878dFBmJeOFN3k4eNGR00NxVdGS
	PGuNGw12mGrMlUn6Hhgyj547ijYlfiRUS/DnZbWdWuCBlob0UTGhS1k0evJay90=
X-Google-Smtp-Source: AGHT+IGJ0rVata0KzDrNxRJORGGH1vmaiKugNhbRKNMrU0DFOAW3j2HgrdoCpEaT6cMWOQ6V0acIUQ==
X-Received: by 2002:adf:fc12:0:b0:33b:178a:6715 with SMTP id i18-20020adffc12000000b0033b178a6715mr628184wrr.24.1707469118511;
        Fri, 09 Feb 2024 00:58:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXISbMGR5gasCj1D1pIsYAFgikNaPepnKxmW19tg3AvecjjGER3rcVapNhRMl+u7l68oXTpphCHKlIoz+E/s65ctXL6qVYz1ZhPLdiAzcZnEShJfhAtEdoBlz7Y17NfKnPjo8azQYxGq4BcBzn/UPe/6LqIeuIOxsu5
Received: from [192.168.1.26] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b0040e9d507424sm1937159wmq.5.2024.02.09.00.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:58:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 09 Feb 2024 09:58:35 +0100
Subject: [PATCH] configs: khadas-vim3*_android: fix AVB oom error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-vim3-avb-malloc-v1-1-91427d8c19ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADrpxWUC/x2NywrCMBAAf6Xs2YWYVEF/RTxskrVdyEOSGoTSf
 2/a48AMs0LlIlzhOaxQuEmVnDpcLwO4mdLEKL4zaKVHpdUDm0SD1CxGCiE7JDKeb2b0d1LQK0u
 V0RZKbj66H9qcF6QY8iTuEL6FP/I/l6/3tu3H1TEaggAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 Feb 2024 08:58:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2115

When booting Android with AVB enabled, an OOM is observed:

  => avb init ${mmcdev}
  => avb verify _a
  ## Android Verified Boot 2.0 version 1.1.0
  read_is_device_unlocked not supported yet
  read_rollback_index not supported yet
  avb_util.c:182: ERROR: Failed to allocate memory.
  OOM error occurred during verification

A custom malloc length of 128MB is required as documented in
commit 285a83b12bdf ("configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB")

However, this 128M custom malloc length was not ported to Kconfig in
commit 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")

Add it back to fix AVB verification on VIM3/VIM3L.

Fixes: 7cfbba36e9f8 ("Convert CONFIG_SYS_MALLOC_LEN to Kconfig")
Co-developed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3_android_defconfig     | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 configs/khadas-vim3l_android_defconfig    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index b41c2660fff0..ee62fe36d414 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 88197f5f5e99..cecbe5061793 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 3381d2e92701..ec4e0dc72e22 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 3fa587ef1db5..206f8defca6b 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3l_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SYS_MALLOC_LEN=0x08000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000

---
base-commit: 076529725f16f07a5cb2d5feba25d62b5f5a5872
change-id: 20240209-vim3-avb-malloc-aa3de534d6a0

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>


