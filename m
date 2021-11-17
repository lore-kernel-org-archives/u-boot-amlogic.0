Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.5624.1637147059817838477
 for <u-boot-amlogic@groups.io>;
 Wed, 17 Nov 2021 03:04:20 -0800
Received: by mail-wm1-f54.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4424736wms.2
        for <u-boot-amlogic@groups.io>; Wed, 17 Nov 2021 03:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz5Xv7YmLg6cgi6PwjWHr2g/RUFNDMhbWiWyYjThw4c=;
        b=oImk974DNA0+0pU4paVTu6xOrrNhbyKeYqHQ58goHsnE0QlnZT2RpjuiBtImK2waV8
         amKlEO89k4TRh8jlbXD6GZC0Y2XbRB6Li5P7Wl5CVolLkAk/x/+NBb7+H27lY/Ge5qOE
         Tf1fX2Tnqh9/W5Hmz/9jWZH1MncPa9WN50ydakG22HuJnMCwo98hKJtoQtD3KGxrWxdG
         PJKsgWMkAdl0Elv8B+F5ojwaZLgjfwb8mHfblDUDNNzoRwEJrJBBZEXXzMPwsWwvhBiJ
         DVncJ1vcUIg4kDwDoPO189RwBSImneaooHbVmpz1gMpoPPnq3yCcAEbeN0C+t0Csn+cl
         hhRw==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] meson64_android: fix initial flashing failures
Date: Wed, 17 Nov 2021 12:04:09 +0100
Message-Id: <20211117110411.710190-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: "To : Neil Armstrong" <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SEI-610 and SEI-510 boards are well supported in the
Android Open Source project via the yukawa [1] platform.

Their U-Boot version, despite being public [2] is not in mainline.

For initial boards, with an empty eMMC, we can have boot loops
while using the flashing process described in [3].

This series add 2 fixes for these bootloops.

[1] https://android.googlesource.com/device/amlogic/yukawa
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ
[3] https://gitlab.com/baylibre/amlogic/atv/aosp/device/amlogic/yukawa/-/wikis/Khadas_VIM3#flash-android-bootloader

Neil Armstrong (2):
  configs: meson64_android: bypass other checks on run_fastboot=1
  configs: meson64_android: add PANIC stage for SYSTEM fails

 include/configs/meson64_android.h | 47 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)


base-commit: 4f4f974a46244270c1c6723017711c0aa8250206
-- 
2.32.0

