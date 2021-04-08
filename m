Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.4903.1617868257977536522
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:50:58 -0700
Received: by mail-wr1-f51.google.com with SMTP id a4so1041106wrr.2
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOH4sgk4Iiaygb2dOblf6xMYF8u5nvROYz0A3bw/hfM=;
        b=ikirk24kTIKfmsvrC9hyE9mbRz3MXdDz6bWPxeQWsMY7pggKaIE1Dl9AgLtOAWzsy1
         /wAO+vMPLR+P/82HUfhLnbz5EcPiHceHLv0Z3j7FNrQPxq9iiLpJJQPqgsdAGewkqmGC
         txd1RBAhFtr8ZpaZTgMSlSBJS12WfU9qBfgsFb2F7Tf+hPRoJdnx9zuhpRgbCb2wxKYu
         sPwq2i46glcKkInz2Ksu/nS8C58rZC1ScAYiSBg477DdAjkZicA6phrFq/051HodfZRK
         Cvi+iZ30jBMwm4rCPnx4EAQ6o91PX8HS4VIvrmal28+kwpGrvwsfAg/KiG+D0XENe/fg
         flhg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/5] configs: meson64: add NVME boot target
Date: Thu,  8 Apr 2021 09:50:47 +0200
Message-Id: <20210408075047.4076954-6-narmstrong@baylibre.com>
In-Reply-To: <20210408075047.4076954-1-narmstrong@baylibre.com>
References: <20210408075047.4076954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Let's add a boot target for NVMe so we can do a full boot over NVMe.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/configs/meson64.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 7e97f89052..17ebccd2c4 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -58,6 +58,12 @@
 #define BOOT_TARGET_DEVICES_USB(func)
 #endif
 
+#ifdef CONFIG_CMD_NVME
+	#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
+#else
+	#define BOOT_TARGET_NVME(func)
+#endif
+
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
@@ -65,6 +71,7 @@
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2) \
 	BOOT_TARGET_DEVICES_USB(func) \
+	BOOT_TARGET_NVME(func) \
 	func(PXE, pxe, na) \
 	func(DHCP, dhcp, na)
 #endif
-- 
2.25.1

