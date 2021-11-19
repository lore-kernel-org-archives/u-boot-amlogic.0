Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web12.7007.1637316519602900600
 for <u-boot-amlogic@groups.io>;
 Fri, 19 Nov 2021 02:08:40 -0800
Received: by mail-wr1-f44.google.com with SMTP id w29so17167177wra.12
        for <u-boot-amlogic@groups.io>; Fri, 19 Nov 2021 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfGm1QrY3wutz4clEtezIITM8vXLANbTk+KL49Hqp/k=;
        b=SqHYpl771iz4X3V7QKoVbJGWtuikQgQKD+Tqt5Be8jF8pU9wJVpz5Pxhw+4iqvboVg
         vNQbE2khVgSqRWXLnvMxuCNvAMK3UfG72imPhUIV/vyT7b+F0krweVaiPRx6mth9+Umn
         Er31ZvJqwnEn/moOCoaJAOOc4ts/uvfO70H/9Ymt0600OvWfO5S1ItJIKqDUEWm12x7i
         4wd7BFIlcbOuA7x/v6vjC3yVFFBoGdyxu7ChrB0F1Nh8EOZlOqEYqE3VzKzU+kZZb5HL
         7HwjAPFvd+v+xfqrf/4d6vhtdujWBBE1uzFBn8lF769O/vXIXGePd3O1tzG8Qi9yyKaK
         zr2Q==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 0/5] meson64_android: add support for vim3/vim3l boards
Date: Fri, 19 Nov 2021 11:08:24 +0100
Message-Id: <20211119100829.843139-1-mkorpershoek@baylibre.com>
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

Mattijs Korpershoek (5):
  configs: meson64_android: add board specific env settings
  configs: prepare khadas-vim3{l}_android for AOSP support
  boards: meson: add khadas vim3{l} android support
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

