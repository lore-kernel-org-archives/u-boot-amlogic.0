Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.12137.1631110659433823514
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Sep 2021 07:17:39 -0700
Received: by mail-wm1-f42.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso1682472wmi.5
        for <u-boot-amlogic@groups.io>; Wed, 08 Sep 2021 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJgbbqo/6bQo2p9nmIFUbGQJBxvosMwO730hx+ONHCc=;
        b=sKFvoHZomRKLZVs70QPFTTlpJip1T4ts4Z/pxw375Ya+f7kQjpeo8yEIMYJF2x/8rK
         WU9tnhFIvxnW611lxZ8S5/2olugeaetCftPwa5mYMysbfveHdf7tnSFQFCmqIfWAQo06
         V4Q2+5wSIsGn+OgS79H0rgI6OT9Fe0rzzbHMnxoDbzmPrJy7Rjy+1QBoOPFjmmYoxuR2
         V+WzlrqIv0bu7Zx6OEAexT8PHm871vDkrsC1zqjdIRR4OxQeIOx2YkxaIY8TY+hoxfrC
         l6/0zdiy4rr1CDi3NYFEYapHpKInQ6zL2CgY1jleOOOYqE7NbOPpaFmHTGtjknqpjVKQ
         lPGA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v2 5/9] distro_bootcmd: run pci enum for scsi_boot just like it is done for nvme_boot
Date: Wed,  8 Sep 2021 16:17:24 +0200
Message-Id: <20210908141728.585797-5-narmstrong@baylibre.com>
In-Reply-To: <20210908141728.585797-1-narmstrong@baylibre.com>
References: <20210908141728.585797-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, Mark Kettenis <kettenis@openbsd.org>
List-ID: <u-boot-amlogic@groups.io>

The SCSI device can be a PCIe adapter, so run pcie enum if enabled.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/config_distro_bootcmd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 750e9e04e8..3f724aa10f 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -226,6 +226,7 @@
 		"fi\0" \
 	\
 	"scsi_boot=" \
+		BOOTENV_RUN_PCI_ENUM \
 		BOOTENV_RUN_SCSI_INIT \
 		BOOTENV_SHARED_BLKDEV_BODY(scsi)
 #define BOOTENV_DEV_SCSI	BOOTENV_DEV_BLKDEV
-- 
2.25.1

