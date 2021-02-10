Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.6066.1612967170723517885
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Feb 2021 06:26:11 -0800
Received: by mail-wr1-f54.google.com with SMTP id l12so2830828wry.2
        for <u-boot-amlogic@groups.io>; Wed, 10 Feb 2021 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbMIJ0JKpUOGCGYKD5IkxuD5l4e9Hf7nwUBvG2+ABn8=;
        b=0x6R4lpWnDnc+aSW2Rz2PvTPRhMNMbQfZdjl9pS04pADQyW4KIBs215X7Y0YVpATTP
         I0ax5CdFhEijnHKrMQzOrhtUjHTsV2DU0H543vhoNhEoFZz1puzLJxaSxLLnWeVeu9oF
         MN8Gb0FnUnlByzmNO+kkU9rUjKKJPX+936vSHrxxoFcknTlICydgHVT9Btx0I2Jzk/WQ
         jTDXQEqCFLazT877Bzf/UxmbR4TVCRgZlAmx+Ad1WdgJFPJdC1YuQlDeQaDstJXAaa98
         JlEbm9Lc/no+/gYkFT0iEWIeLq8ffr2GfYklgLuvL+bzXcGo/kwJ37XEbE4cA9Siqp54
         7hPg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] configs: meson64: add fdtoverlay_addr_r
Date: Wed, 10 Feb 2021 15:26:05 +0100
Message-Id: <20210210142605.1372944-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to support loading FTD Overlays when booting with the pxe
command (or extlinux.conf), supported with [1], add the missing
fdtoverlay_addr_r used to load the overlay before applying it to
the FDT loaded at fdt_addr_r.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20210120085453.2783678-1-narmstrong@baylibre.com/

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/configs/meson64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index 52cc01f73d..7e97f89052 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -80,6 +80,7 @@
 	"scriptaddr=0x08000000\0" \
 	"kernel_addr_r=0x08080000\0" \
 	"pxefile_addr_r=0x01080000\0" \
+	"fdtoverlay_addr_r=0x01000000\0" \
 	"ramdisk_addr_r=0x13000000\0" \
 	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	BOOTENV
-- 
2.25.1

