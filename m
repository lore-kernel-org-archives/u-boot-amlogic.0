Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.4826.1679810790289535084
 for <u-boot-amlogic@groups.io>;
 Sat, 25 Mar 2023 23:06:30 -0700
Received: by mail-wm1-f43.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so5070086wmq.2
        for <u-boot-amlogic@groups.io>; Sat, 25 Mar 2023 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679810789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cueX1tlDyZQ065KUwhnXoi1nTSev/k3RQzOBMsNBLiU=;
        b=p31anWWkKI0R5+RJJrSLUoTqdWe5dYLsXbXGLzMlYKNGVHaRTUSjqUkHhiRfT4O6FM
         eFZ2CEr4QBHOL3KKMeX/H0oPyP0PCeiXhRpPXiLE8I/FYi7idxPBrgDgBuvM5FjJEIaK
         uFN17sOfTHzuqeL5Hu+87yjsIfh/nsduN9WrSm9fm7CzI13triR47KkvBZrVD79kE/mK
         x/meNPYBt6wTlJXYNUHAnuBXCtAfvBaat0Qc4NNpigF4sM9RM/ZGpK0xm6cxKxlJRS1t
         JgpEMROoxXBHNWzHrVeHbnaqhUBd49FIjmDhYatmmY2y3QRhSwr3+Ek/JIIOQCu3hWF9
         0W1w==
Return-Path: <christianshewitt@gmail.com>
From: "Christian Hewitt" <christianshewitt@gmail.com>
Subject: [PATCH] boards: amlogic: switch LibreTech-CC v2 and WeTek Core2 to EE powerdomain
Date: Sun, 26 Mar 2023 06:06:25 +0000
Message-Id: <20230326060625.2734090-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

The LibreTech-CC (LePotato) v2 and WeTek Core2 boards are still using
the older GX VPU powerdomain driver. Update their configs to use the
newer EE driver like other Amlogic boards [0].

[0] https://lore.kernel.org/all/20201106101901.2472557-5-narmstrong@baylibre.com/T/#u

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 configs/libretech-cc_v2_defconfig | 2 +-
 configs/wetek-core2_defconfig     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/libretech-cc_v2_defconfig b/configs/libretech-cc_v2_defconfig
index 30b1651554..ea71f055d9 100644
--- a/configs/libretech-cc_v2_defconfig
+++ b/configs/libretech-cc_v2_defconfig
@@ -51,7 +51,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
 CONFIG_MESON_SERIAL=y
diff --git a/configs/wetek-core2_defconfig b/configs/wetek-core2_defconfig
index f5149fc002..07d2587f77 100644
--- a/configs/wetek-core2_defconfig
+++ b/configs/wetek-core2_defconfig
@@ -44,7 +44,7 @@ CONFIG_MESON_GXL_USB_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_MESON_GXL=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MESON_GX_VPU_POWER_DOMAIN=y
+CONFIG_MESON_EE_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
-- 
2.34.1

