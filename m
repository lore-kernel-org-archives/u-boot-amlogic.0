Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.9090.1600421357997641944
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Sep 2020 02:29:18 -0700
Received: by mail-wr1-f65.google.com with SMTP id x14so4877437wrl.12
        for <u-boot-amlogic@groups.io>; Fri, 18 Sep 2020 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7c0Za6IBqW9wwVCwESd8Lrhd9tlbmcdVTajXqAmCpQ=;
        b=D7hom/tRwENE7aiKJNVamjRfFSSRuNlgP1rMW4sxqz9Z7IbVzsuca6ueM3ZEDy5VWO
         0m/xLEjXgXVks3z6RI3jSkSREORJXgDB1/O3NCm7cTgRaPmV+FceYYZj2lhLNkwt/mki
         Wl+6NbY5LH1Oxf0R48/4Ai7rj2dBwYHBzEhokrTU5t68ZnjONaxYs5nEM2pePW+n7fhN
         gOMLL521F+I+Pg906ACfdnaaWW0Gsj8qlHOU7HXwMCy6GmuqWVssuY3ul34+qaLhH1Us
         KamKQzhBEHyCZxwx2g67Ghsj4XzcShfnuo+sh3iAsfbs2WVZ6RwuRmoEeP77QQ7wS9ER
         Zh0w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/4] configs: vim3: use the vim3 board support
Date: Fri, 18 Sep 2020 11:29:01 +0200
Message-Id: <20200918092902.28028-4-narmstrong@baylibre.com>
In-Reply-To: <20200918092902.28028-1-narmstrong@baylibre.com>
References: <20200918092902.28028-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, khilman@baylibre.com, nick@khadas.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Use the newly added VIM3 board support instead of the generic W400.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
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

