Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.9693.1618996699510964119
 for <u-boot-amlogic@groups.io>;
 Wed, 21 Apr 2021 02:18:19 -0700
Received: by mail-wr1-f48.google.com with SMTP id r7so28561088wrm.1
        for <u-boot-amlogic@groups.io>; Wed, 21 Apr 2021 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpz69pAtRkeip+snKcs0FEA/EzYhZar/nV7xj0f4NxM=;
        b=tyBiZg/Kbp0a/BwdmxWko5rbcjq/XBuGI6koTrzCeCsnokDzUUrDbYg7j4WVuWJf/0
         nl3kCgOqMnclqj56r1RZ323lfSIu61uPaC9JuBCpLIUKEKCJHPSC3FYGwv5Szxf12EUz
         4h//2/tmBBUvBAMDr4ysn8a/dqvU0V7tWtbciQemPd6knpTOaTGCxMQUlE/dNNo06b3G
         rtX9/IDKSdxZQxfdCiX5kMOeWfkvkpILe9vdMp+70LGf5ezsxOJ4v2kpsXLPaeNsk0js
         z3VoPOdXmmbHcZZH0MyA5+wMRoeEUUacFsQqFaKSllRXN12f7HunOWuPy3EHCVY9Q7Ph
         kNGw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 5/8] distro_bootcmd: run pci enum for scsi_boot just like it is done for nvme_boot
Date: Wed, 21 Apr 2021 11:18:06 +0200
Message-Id: <20210421091809.3103002-5-narmstrong@baylibre.com>
In-Reply-To: <20210421091809.3103002-1-narmstrong@baylibre.com>
References: <20210421091809.3103002-1-narmstrong@baylibre.com>
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
index 2627c2a6a5..f4f6fa8f8a 100644
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

