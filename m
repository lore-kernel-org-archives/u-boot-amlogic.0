Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.36831.1600673666947620447
 for <u-boot-amlogic@groups.io>;
 Mon, 21 Sep 2020 00:34:27 -0700
Received: by mail-wr1-f68.google.com with SMTP id t10so11591994wrv.1
        for <u-boot-amlogic@groups.io>; Mon, 21 Sep 2020 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amqyLFX4WQiNI4QucUxNrUyr3srWqaQKpkEc7LVr9lc=;
        b=u8DxtWlNpgOPs8J4msDhpyNpwUVCbHgn5B2xxzVz9ISGoGscJrigbezOqsGZJeBDLd
         egUu/NxNV/9h1QXj5y8VTFuVvNnnSugvyKzOTlgfemmefvH4QB3RZ5iWkO5MPOjsQQgu
         eWrquhwWhtTBGvEzumZhHbrMuWcfHcq4cG2SUGnUMFxullTUm/H7XpsE52HXLWgmAg7u
         MW47T9Md8TWGyjVQKGbuOFb4OZ8sAH296zgDQNgXXXIEG2cO26bfBuw8vFjrq1vMfVZC
         9EcjDwM1eQDZcSQukQqrQ3C2kaiDIwyMufB0pFMEj37q3WXrLJGbq5vjkIAPdN4Gs6ZN
         Q2Rw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 3/4] configs: vim3: use the vim3 board support
Date: Mon, 21 Sep 2020 09:34:14 +0200
Message-Id: <20200921073415.24211-4-narmstrong@baylibre.com>
In-Reply-To: <20200921073415.24211-1-narmstrong@baylibre.com>
References: <20200921073415.24211-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use the newly added VIM3 board support instead of the generic W400.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 configs/khadas-vim3_defconfig  | 2 +-
 configs/khadas-vim3l_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/khadas-vim3_defconfig b/configs/khadas-vim3_defconfig
index a39e0f9c9f..ee5990426d 100644
--- a/configs/khadas-vim3_defconfig
+++ b/configs/khadas-vim3_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="w400"
+CONFIG_SYS_BOARD="vim3"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
diff --git a/configs/khadas-vim3l_defconfig b/configs/khadas-vim3l_defconfig
index 57cc383b9d..5729d339e9 100644
--- a/configs/khadas-vim3l_defconfig
+++ b/configs/khadas-vim3l_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_SYS_BOARD="w400"
+CONFIG_SYS_BOARD="vim3"
 CONFIG_ARCH_MESON=y
 CONFIG_SYS_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
-- 
2.22.0

