Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.9542.1631864236757160245
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:17 -0700
Received: by mail-wr1-f46.google.com with SMTP id t18so13658415wrb.0
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8E2qbaf7N0jIDuLpNYyFY9uxgua9aYGDxUzGtqDqMQ=;
        b=4QPgh1NkXAQJ0H/xdyOrjQUfZRZNHUi2+/RN3g+rhrE7tn+vmkc6MSaBMDu/rhum6Y
         HYbAeeW/5JALXP/d4FttKh+ChQCBX8ECzX5IDYGjqpTLed9RLQ2loST9P04ASibi/V4V
         ZGlV5jSepiyx14xkvSNAS6DbUJkhDyvGbHrO/uTkVjdAE91OfzPiZwOszVOP/Scyuyxk
         JJm2w5Pi5aycJdvSUfJ6MBRlY4I/fQyppbDpDCSMDGBMdRHLIG6MAGdnlnrSZekUUQye
         fxVO+OrLghi2ZOeQHbUr8xHlWKsqdxQUlf7kCzKH9FLiSHGuDaHYy9FLjsS4L/GoJ8nM
         PekA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 05/10] configs: meson64: add SCSI boot target
Date: Fri, 17 Sep 2021 09:37:04 +0200
Message-Id: <20210917073709.1052133-5-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
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
index f9bb0240d2..08816fff1f 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -66,6 +66,12 @@
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
@@ -74,6 +80,7 @@
 	func(MMC, mmc, 2) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(PXE, pxe, na) \
 	func(DHCP, dhcp, na)
 #endif
-- 
2.25.1

