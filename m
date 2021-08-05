Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.10217.1628176655364053203
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Aug 2021 08:17:35 -0700
Received: by mail-wr1-f50.google.com with SMTP id c9so7024352wri.8
        for <u-boot-amlogic@groups.io>; Thu, 05 Aug 2021 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2At7FbT/M7VQiKOx4K1VoUemwd+9VWKsnd73THjElpQ=;
        b=Wkc+4N9QrckqXQFFJcj/WGT5uUNfW9EoveLwLtQoFcnuBQ6FRT0sYOvRX4HCaq9LQQ
         6POK4q/BfzVR+3/2vA3PAbc5mFLF59Cn6iqdAIAD5PGTr7LP0Xe5UjbzapWXpquBaJ6R
         q4quPGXxPHFg0RQwa2zXTRCrAwZ9oy1kqvsPDyIAlOWciP795eWair/GDmCD7CyAzT/b
         oT5mrABVi0polEI1scK4Oq/U3I2tMyn8NdAtg7ZPkrQ8p0KfaPC4xHWTkCHqteqdVjpE
         hRmenBGjAmmR0XQfiOZ8lJ0MC/vs+XuYKZzWVEP8Qv6gU+WJ3GdGiBtITrc7bMqFVwnN
         LOkQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 0/9] meson64_android: Android boot flow using abootimg
Date: Thu,  5 Aug 2021 17:17:19 +0200
Message-Id: <20210805151728.422329-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SEI-610 and SEI-510 boards are well supported in the
Android Open Source project via the yukawa [1] platform.

Their U-Boot version, despite being public [2] is not in mainline.

Android 10 and higher have significantly reworked the bootloader
requirements:

* bootloader should pass slot information in case of A/B
* bootloader should perform AVB verification in case it's supported
* bootloader should read and apply dtb overlays from a dtbo partition

These series add support for all the above.

[1] https://android.googlesource.com/device/amlogic/yukawa
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ

Guillaume La Roque (2):
  configs: meson64_android: boot android via abootimg
  configs: sei510/610: android bootflow via abootimg

Mattijs Korpershoek (7):
  configs: meson64: permit redefining SYS_MALLOC_LEN
  configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB
  configs: meson64_android: implement AVB support
  configs: meson64_android: implement A/B slot support
  configs: meson64_android: define BOOT_CMD macro
  configs: sei510/sei610: reformat PARTS_default
  configs: sei510/sei610: don't use hard-coded gpt uuids

 configs/sei510_defconfig          |   5 ++
 configs/sei610_defconfig          |   5 ++
 include/configs/meson64.h         |   2 +
 include/configs/meson64_android.h | 139 ++++++++++++++++++++++++++++--
 include/configs/sei510.h          |  23 +++--
 include/configs/sei610.h          |  23 +++--
 6 files changed, 165 insertions(+), 32 deletions(-)

-- 
2.30.2

