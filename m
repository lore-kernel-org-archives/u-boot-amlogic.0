Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.7831.1637594536555725948
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Nov 2021 07:22:17 -0800
Received: by mail-wr1-f54.google.com with SMTP id d27so33428325wrb.6
        for <u-boot-amlogic@groups.io>; Mon, 22 Nov 2021 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NcsMZgde6WSraElGN84/u03qIvg2UKRNJqmplLU6aiE=;
        b=E9hIip7sM7x+g3Fgf7Xp42UuNL9HpXet0xItF/i7AMzO7GWxgjkq7kxyysKonlM84R
         E8Kv5xkm4DATbh7m7GpYm/Uve+EnuZXid620n2MR7JvMMRT0+D8E04Sj2MbRcnnVvICb
         58sHgfTBK35T5NVCneqN8KJrEapTfMq7UcXbnuTomEdOuLJ+IWUHNg2VGTh7zwvpHDpC
         xVL2DzT4P5yjB5eazgs5bqf7V86xIEY7+OlhzNK5uogc8TY11Dp3l0qpTSuCRcs3YAJR
         fgKaXJk6SeJ4rWYlME/YoicJEfCfIXaFO/itjuc8miXAux27jkIr5bigqctbi1DQlQjo
         f65A==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/4] meson64_android: add support for vim3/vim3l boards
Date: Mon, 22 Nov 2021 16:22:03 +0100
Message-Id: <20211122152207.219023-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The VIM3 and VIM3L boards are well supported in the
Android Open Source project via the yukawa [1] platform.

Their U-Boot version, despite being public [2] is not in mainline.

[1] https://android.googlesource.com/device/amlogic/yukawa
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ

Add defconfigs for both vim3, vim3l to support
traditional and A/B booting/partitioning schemes.

Changes in v2:
* Squashed defconfig changes for initial support
* Split out partitition changes for A/B

v1:
* https://lore.kernel.org/u-boot/20211119100829.843139-1-mkorpershoek@baylibre.com/T/#t


Mattijs Korpershoek (4):
  configs: meson64_android: add board specific env settings
  configs: add khadas-vim3{l}_android for AOSP support
  configs: prepare khadas-vim3{l}_ab_android for AOSP support
  configs: khadas-vim3{l}_android_ab: enable A/B support

 board/amlogic/vim3/MAINTAINERS            |   4 +
 configs/khadas-vim3_android_ab_defconfig  | 109 ++++++++++++++++++++++
 configs/khadas-vim3_android_defconfig     | 107 +++++++++++++++++++++
 configs/khadas-vim3l_android_ab_defconfig | 109 ++++++++++++++++++++++
 configs/khadas-vim3l_android_defconfig    | 107 +++++++++++++++++++++
 include/configs/khadas-vim3_android.h     |  50 ++++++++++
 include/configs/khadas-vim3l_android.h    |  50 ++++++++++
 include/configs/meson64_android.h         |  17 ++++
 8 files changed, 553 insertions(+)
 create mode 100644 configs/khadas-vim3_android_ab_defconfig
 create mode 100644 configs/khadas-vim3_android_defconfig
 create mode 100644 configs/khadas-vim3l_android_ab_defconfig
 create mode 100644 configs/khadas-vim3l_android_defconfig
 create mode 100644 include/configs/khadas-vim3_android.h
 create mode 100644 include/configs/khadas-vim3l_android.h

-- 
2.32.0

