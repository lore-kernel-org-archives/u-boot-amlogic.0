Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.8819.1641573565777604211
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Jan 2022 08:39:26 -0800
Received: by mail-wr1-f52.google.com with SMTP id w20so12098068wra.9
        for <u-boot-amlogic@groups.io>; Fri, 07 Jan 2022 08:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqhbHySaNECv358J/u6FBmuuP5B2R0WOun3xK+D1LDY=;
        b=FVLYjeRWyV6BsaDOes0ajoxUVymhKiOnInFTRor+o3hh1xIv1wAaIk36tIfQgro5MH
         l1BCPMzvPzc2SCxKMDMb/IWesGXDln1G+Eom/QUbjS0g2SaISlx/NA1rDL7VAsDKDDZz
         YsaH3uouTVAnc1xErBn7wsN2+m8x82Kzv8zOiJ/yTQv+ihRTTwqLR0kIlOvmEJc19j+6
         xzxh34F60HwJuw7y6qn5oHoVUJ1KOexiSQjs7CVztw8KlHVNjZ4cv8bpBaGq6jmOkKgA
         888kKcYcIhAVd05pCDGArcorMsos7oIlhV7PG8CPnnIsiizyqxCaXupyz1Aeh9N21zZE
         NrKw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH] configs: meson64_android: define raw parts for bootloader
Date: Fri,  7 Jan 2022 17:39:13 +0100
Message-Id: <20220107163913.3393563-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Gary Bisson <gary.bisson@boundarydevices.com>
List-ID: <u-boot-amlogic@groups.io>

Per the android documentation[1]:
- the mmc2boot0 partition should be labeled "bootloader".
- the mmc2boot1 partition should be labeled "bootenv".

Also the u-boot documentation[2] refers to a BOOT1_OFFSET of 1 block.

Define 2 raw partitions to store the bootloaders and the bootenv.

[1] https://source.android.com/setup/build/devices#vim3-fastboot
[2] https://u-boot.readthedocs.io/en/latest/board/amlogic/khadas-vim3l.html

Suggested-by: Gary Bisson <gary.bisson@boundarydevices.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/meson64_android.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
index 0303d187de..1266851196 100644
--- a/include/configs/meson64_android.h
+++ b/include/configs/meson64_android.h
@@ -283,6 +283,8 @@
 	EXTRA_ANDROID_ENV_SETTINGS                                    \
 	"partitions=" PARTS_DEFAULT "\0"                              \
 	"mmcdev=2\0"                                                  \
+	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
+	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
 	ANDROIDBOOT_GET_CURRENT_SLOT_CMD                              \
 	AVB_VERIFY_CMD                                                \
 	"force_avb=0\0"                                               \
-- 
2.32.0

