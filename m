Return-Path: <glaroque@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E814C98328
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:38 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8497.1790343753044117278
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 06:42:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=ZqbmBJOy;
 spf=pass (domain: baylibre.com, ip: 74.125.225.141, mailfrom: glaroque@baylibre.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so5655045e9.1
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790343751; x=1790948551; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
        b=ZqbmBJOy3uj5jIxSMa+Yz/+EJY82Ox4xJOt646DoS0xuD7rPUctPye0a27nnQ1TLAA
         pNvtfVsUQ3d0UHAO2H+UFKbUy8a0WVKtyZ+yg2Bu/kxB0/cr/ia0EwbYdn5++qPNBIGu
         df4Oix5Xiqxe40t7MfKE2c+k9T6q4me8i77kKS69xVnImr13ORVZngVW4j12IbVrYA0M
         sstM68Bz1R2tSbBPKc/UW+jbs6OSl1D8jA5I2/LpENczF8PGK2YxgT67Fbfr+Fpw/xQl
         F75V16o8TTV/DNRMJ7GAPwK30KfgGHvQWTt9aXGx4N2XBfoRx95U2v5S2dJx7jaTf3hS
         FxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343751; x=1790948551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCycwxWCKUWrlTXAQFP8/HCsPLcRxsC7FGA4ECLrMM8=;
        b=P7t4QopnFqhS8x8UwEWKT3lDqGsSRgESPCp6ZaQPeK3Hxj60f9OoaZRzT/RtuqGrxg
         SJVNSNxOXVrObOBioFjxh2eoxS4v0UWOTcFaBTlhpbwrioU39aGMDCsYFrv+zaFQDZMP
         2VCgQerH0Tu3tInC0IfubUITuKXGsV4WIlRuN1Tp9TMFUVcTNiMmud9VaNWVg92UOnBa
         iOCtek5yDoIV+1vfVrsaemxVM5W5FpGg/eiNTUUP2HKMzOZ2O51ExlfXejp7yKW+QN9O
         l4xZrFXAM4Yn5hOSye+AnLn6WPwbFSEZqHNuqywoMsvayUYno3cMD9/8Yke1SgjfUyrh
         cKKA==
X-Gm-Message-State: AFuF++msUlTpKsyYjcuGQRwOpgy/khBL41XKEGhDVIOovAb2Qpk+D8K9
	DO3TxsbGL+2gNr8t0pXrLEGkrh3ebOWVJq02bkIbnA56uBCD6LXT7QqWPYged3Q+Vjh5f2f7KQs
	Jd95mc3k=
X-Gm-Gg: AYBFou0IzEazJR0Wg8nS7b/zFSc/75Z+85v1/QDVgeHxy/S5KfekDg0MmcCYYmJMiJz
	mm3RMMdS0DV0ahKnV96m4O4ZUpN/YoWWgXxfWWeJEyv2Ymj7H2KJaui5u+deVQm64vvORtCvSIl
	hGP0bGtyLOX098UGqNELDimanvQnD8/jO60kRjyIWwKl7dxJo6xwYI/rIV/6deFNtaiDjcPDq5b
	blKGxsmFUc8rU5cun38e/m+JkB1wjbuAAjMv/lagxRee4HqhD/uk5JNcqFG03bqZ6fLFBcEqxMO
	4ZcQkPzquYgArU4WFqAoIrXtOufpZk63rrxtpB7c3TUXrM2jf4tsS4qDUs7+w3wH/iqGt/tDkK6
	GkwXXvqiFLRmJBpf/9tcOSUXGUROKnvS7jm4WO2cpwphySaF5RRDhlbESlztazoe0vlkJF3lF2Z
	B5U7Qo05a0X1ZMaWHuvLdDloFKmyNxSTXNhJxoauLAfYw7Fc4u4FXF7uDY0IOZg6QTs+Wc3aWP
X-Received: by 2002:a05:600c:a4c:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49fe67060cemr101189575e9.31.1790343751341;
        Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:42:31 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Fri, 25 Sep 2026 15:42:25 +0200
Subject: [PATCH 2/4] configs: khadas-vim3: enlarge the fastboot buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-update_vim-v1-2-fddf7ba4dc34@baylibre.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 13:42:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3097

Increase the fastboot buffer from 112 MiB to 512 MiB on VIM3 and
VIM3L to allow larger downloads when flashing Android images.
The buffer fits within the RAM available on both boards.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 1 +
 configs/khadas-vim3l_android_ab_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index 463dc31cb7f..9022587d5a7 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -63,6 +63,7 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index d0cf7d39482..6488211e9e4 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -63,6 +63,7 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x6000000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=2
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y

-- 
2.34.1


