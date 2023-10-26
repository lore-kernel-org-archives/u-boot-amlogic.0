Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D12C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 13:42:07 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.70834.1698327720678298279
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Oct 2023 06:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=FsPYWOrj;
 spf=pass (domain: baylibre.com, ip: 209.85.128.53, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-408382da7f0so7069295e9.0
        for <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698327719; x=1698932519; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXYwkjf/k/iPjcFqnMiDY68NJWoXknz2s5MJIBWpwyM=;
        b=FsPYWOrj21k1ICshJ+UuWyqfPb4MgdomHlxRHIplaE0K7wKns6eTTPlbzDyAGpXt3E
         NFRPMs1Y7apY1iJ7bKZyzusO6O97Hhg4z4+61VZiKRjhPE4LUamraVcxTVwik8fSJkJZ
         O/52AiJoP+cnL64nnWDDyvMukOJxsimlETVGWskAu6JJFsDrFQWUa3+lYKmfwPXW/4bh
         wYs7ZqjepRJg63IL7wHiDy8Y9e87rpjbp6rlRUqJMpxnjngXpyX5BvlZUExk3D5Zgz0y
         ZDjdicK9EeW6jLodSITSuVivdeA26gA+A5d2jhrZCUgSF8siyzZsXh7ohrmCD5tKNDAq
         G7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698327719; x=1698932519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXYwkjf/k/iPjcFqnMiDY68NJWoXknz2s5MJIBWpwyM=;
        b=LEdQ/6pksrr2wBou9qXbqkA2uDhDAGdEQIPOm/YeU5fURv5wZlVgilGdnj5vCO+tqs
         bHJsJLCTkWGX7eWrGP8iK06++K0Qe0/nt4CHPsKYCHJi2cvQlbEsoK79dupScT1pVI8e
         qam+xyObTdpVSbZheF6RhwtBLa+xQrrjafLubRYO5m9/WbFC6bkQrjDCMC+QPRTEhdMd
         pMHMW0Y4fGn9CljXcjdxwBPda7lnNdUNQsWdomEm58mOBMsn8ScN/fObvUk8BXUJtHNj
         LHrxj40ktXfT6Tu25NqNFz+oaWIvXrJxMh7LyV0C26eFmizYX0bXe8J02nh7ZW1Zfifw
         i1hQ==
X-Gm-Message-State: AOJu0YySLiXPDjZ11wfEQ4DwO+hnYx8Qhu/kRUAXVpOqshWpuibPhh4B
	OB8TUlqO1isQNB5FP3QC4fnkoQ==
X-Google-Smtp-Source: AGHT+IH42prjvBPsRBRsFFnXZBRP2fAOVCt5HkwH10gTh+1rr806sQTMmiQzNTESIiRo+RnvbqHG3g==
X-Received: by 2002:a05:600c:4445:b0:408:80bb:ae80 with SMTP id v5-20020a05600c444500b0040880bbae80mr11686024wmn.7.1698327719048;
        Thu, 26 Oct 2023 06:41:59 -0700 (PDT)
Received: from [192.168.2.42] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b004060f0a0fdbsm2646407wms.41.2023.10.26.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:41:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 26 Oct 2023 15:41:31 +0200
Subject: [PATCH] configs: khadas-vim3*_android: fix environment saving
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-fix-saveenv-v1-1-6aa59be65481@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAIpsOmUC/x2MQQqAIBAAvyJ7TtDNRPpKdLDaai8WLkgg/T3pO
 AwzFYQyk8CoKmQqLHylBrZTsJ4xHaR5awxosLcGvd750RILUSqalsEF5xExILTiztT0f5vm9/0
 A1KtjYV0AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 13:42:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1800

The environment is used to configure some additional boot features such as:
* extra boot arguments
* enable AVB (Android Verified Boot) verification

Right now, we cannot store it in eMMC:

  Loading Environment from nowhere... OK

Fix it by enabling the appropriate options in the defconfig

Fixes: b749d5ecdc06 ("configs: meson64_android: define raw parts for bootloader")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 configs/khadas-vim3_android_ab_defconfig  | 4 ++++
 configs/khadas-vim3_android_defconfig     | 4 ++++
 configs/khadas-vim3l_android_ab_defconfig | 4 ++++
 configs/khadas-vim3l_android_defconfig    | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index ccd6f6f8a075..0abccb64ee15 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
index 5c3d565971d6..33ede5262295 100644
--- a/configs/khadas-vim3_android_defconfig
+++ b/configs/khadas-vim3_android_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-g12b-a311d-khadas-vim3"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_ab_defconfig b/configs/khadas-vim3l_android_ab_defconfig
index 0d6de8001382..8f32f8e8ad5b 100644
--- a/configs/khadas-vim3l_android_ab_defconfig
+++ b/configs/khadas-vim3l_android_ab_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -45,7 +46,10 @@ CONFIG_CMD_AB_SELECT=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y
diff --git a/configs/khadas-vim3l_android_defconfig b/configs/khadas-vim3l_android_defconfig
index 827752f24373..443c10aee3d0 100644
--- a/configs/khadas-vim3l_android_defconfig
+++ b/configs/khadas-vim3l_android_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
 CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="meson-sm1-khadas-vim3l"
 CONFIG_OF_LIBFDT_OVERLAY=y
@@ -43,7 +44,10 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_ADC=y
 CONFIG_SARADC_MESON=y
 CONFIG_BUTTON=y

---
base-commit: 14a21f1a80afc58d52dc72e35f27d3a47d36c082
change-id: 20231026-fix-saveenv-eb5484622282

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>


