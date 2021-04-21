Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.9690.1618996698488486568
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Apr 2021 02:18:18 -0700
Received: by mail-wr1-f54.google.com with SMTP id s7so40485895wru.6
        for <u-boot-amlogic@groups.io>; Wed, 21 Apr 2021 02:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12xVK7p9c5fZTmJc83RpoW1OXJKr84du+5p/8X1vrnE=;
        b=xb5GHDYMOVIBgdNpBsaketMt63Jr5CcFUzGojw888dOeHHbULxK/hihm7Rj3Ilkhxq
         QBFlaz4IVzubNzcYc5iZXPvqxNNkXvkvakd8Xmo42Hz5xd7n7BRZLjUL00ktnpZfvnO0
         aerjpnrzJ5hAA0lKYEtMDxTcT4jEsBxizkb/z57+iVXp7cPaUK1BBdblwufSDIf70ENV
         niekKY6ZOMIuqam99dHA8Lv1Ez6XKUGooG2Al5KaGW4fBwxrnOMfAAYbXDae5W86eF1S
         dk/UPhMUl1krG2pN88yPwNtAF2slpa+wfOp9UhaL5mYfe8lp7jvtmB/S/xizXleBiF6E
         PS/Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 4/8] configs: meson64: add SCSI boot target
Date: Wed, 21 Apr 2021 11:18:05 +0200
Message-Id: <20210421091809.3103002-4-narmstrong@baylibre.com>
In-Reply-To: <20210421091809.3103002-1-narmstrong@baylibre.com>
References: <20210421091809.3103002-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Mark Kettenis <kettenis@openbsd.org>
List-ID: <u-boot-amlogic@groups.io>

Add SCSI target to be able to boot from the SATA disks on the Odroid HC4 using
an on-board AHCI PCIe controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 include/configs/meson64.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 17ebccd2c4..d1539477a0 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -64,6 +64,12 @@
 	#define BOOT_TARGET_NVME(func)
 #endif
 
+#ifdef CONFIG_CMD_SCSI
+	#define BOOT_TARGET_SCSI(func) func(SCSI, scsi, 0)
+#else
+	#define BOOT_TARGET_SCSI(func)
+#endif
+
 #ifndef BOOT_TARGET_DEVICES
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
@@ -72,6 +78,7 @@
 	func(MMC, mmc, 2) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(PXE, pxe, na) \
 	func(DHCP, dhcp, na)
 #endif
-- 
2.25.1

