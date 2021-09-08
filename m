Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.12136.1631110658219981384
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:38 -0700
Received: by mail-wm1-f49.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so1789025wmi.0
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8E2qbaf7N0jIDuLpNYyFY9uxgua9aYGDxUzGtqDqMQ=;
        b=dZFJUkN3Mwyw/S350Ny4mJfUVEORuh7e6ewbgpzl3RzTqj0oaOdWzJkIhwFTVwGCYK
         U2DRPfTElPz39KLAD3F2oYbM1UfGurTddJZpewPw72v1ZWO4J8KKm9EvK5wQaEKVnWvy
         QrTS24z6FbWNZxebF77SVMUJGRxu36Xn5PNDBvGFf5Rzh32xlD8t0kB3CnKkxnBRn7bM
         AHNtl158AKGDPpfGMvSi911nbLQ8xIcK8nwg65RDwx2fK6IwXbhPYDHyVup76hwUxxkn
         hlQLZhlYJTO35r51F+v5Wydattq/yLiHOpbbAE43MgL4BdCLjrb8f9BuOCUG9uvzwbkb
         h3Kg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 4/9] configs: meson64: add SCSI boot target
Date: Wed,  8 Sep 2021 16:17:23 +0200
Message-Id: <20210908141728.585797-4-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
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

