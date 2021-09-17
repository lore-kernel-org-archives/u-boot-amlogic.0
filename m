Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.9604.1631864237812283714
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Sep 2021 00:37:18 -0700
Received: by mail-wr1-f41.google.com with SMTP id u15so13592002wru.6
        for <u-boot-amlogic@groups.io>; Fri, 17 Sep 2021 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJgbbqo/6bQo2p9nmIFUbGQJBxvosMwO730hx+ONHCc=;
        b=nrlGOgWiDipPZsDam5fspk6SMxm2y9Dkozb/4p6K9QeKeMiaS3JWHuqRcjUsiYDp1+
         vGzl+m5hXoPZd82KpIxGUvJikP9EUmpCPBtD+F0g1VFZJ3ivS6rwTe+ipSHG9YhtkODQ
         /nnIx+ydH5IzZTeXJhAwXMhS7xRR1VtzOJjgwEvVeWlu9dt/iRHds+uxBTe7GvrieMqo
         Ev3yw0WiODlLks9sdz/8sKuNNFn7MqwWki71Jexw9THMl7OvRE/QTU3fHj8+58FDTst1
         OnjZFPQSTjU68A18TOkNqJP3pU9QX4Z8CiZCqXzzA5q7z3P97eMwc2abnJNRPKxgbT6g
         gzUg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 06/10] distro_bootcmd: run pci enum for scsi_boot just like it is done for nvme_boot
Date: Fri, 17 Sep 2021 09:37:05 +0200
Message-Id: <20210917073709.1052133-6-narmstrong@baylibre.com>
In-Reply-To: <20210917073709.1052133-1-narmstrong@baylibre.com>
References: <20210917073709.1052133-1-narmstrong@baylibre.com>
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

