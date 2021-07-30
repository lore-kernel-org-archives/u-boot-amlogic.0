Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.23508.1627648100428120864
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 05:28:21 -0700
Received: by mail-wr1-f45.google.com with SMTP id k4so286212wrc.0
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgWEPLEPfyljFNLxJaQpeF+oxvOE9O1otL2Shz7CTn4=;
        b=uywiYmQE1cTqVIIM4dySwC5bQ6UIJG4mx/J5IEiMSJkWj7Ab7kmEQfWec7Qs+UjRFu
         n1RRwFK6yN3uDt/d/NZiXHVwQlFQzKJxjgYo8sxCLjW5lU3uTgsWyAx7L37RB9S8yL2k
         Y1ifmGGPbk78YMlBAcA0+jKL7RKgEF/iM6Ri5nqOkogGFxQzT0XL6pu4Q/1xSP9StrMM
         6E8auFKly0isf3ytENTlpQDRdKSgSuGfXoiz6LIewiMltbmW3FRPPx11KBvyZsYtQBey
         JW7MPOyV043fayi6dK4VmWvjG8+NalTbLod9IbhY3YYQWdNqnL20cWAKPGKAeadaO45C
         DxLQ==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/5] meson64_android: use BCB for reboot reason
Date: Fri, 30 Jul 2021 14:28:07 +0200
Message-Id: <20210730122812.3011529-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SEI-610 and SEI-510 boards are well supported in the
Android Open Source project via the yukawa [1] platform.

Their U-Boot version, despite being public [2] is not in mainline.

Android has multiple OSes it can boot into:
* Main android
* Recovery OS
* Fastbootd (recovery OS with fastboot mode)
* Bootloader (U-Boot) with fastboot mode

The decision of which OS to boot into is taken by the bootloader based on
the "reboot reason".

For amlogic boards, we pass the reboot reason via a custom smc call.
This support is limited: we don't r

These series reworks the reboot reason handling to use the BCB, which
is the standard Android way.

[1] https://android.googlesource.com/device/amlogic/yukawa
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ

Changes in v2:
* re-ordered commits
* added Neil's Acked-by

Mattijs Korpershoek (5):
  configs: meson64_android: use BCB for reboot to bootloader
  configs: meson64_android: implement recovery boot via BCB
  configs: meson64_android: reboot to fastbootd from bootloader
  configs: sei610/sei510: set CONFIG_CMD_BCB=y
  Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"

 arch/arm/mach-meson/board-common.c | 34 -----------------
 configs/sei510_defconfig           |  1 +
 configs/sei610_defconfig           |  1 +
 include/configs/meson64_android.h  | 60 ++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 54 deletions(-)

-- 
2.30.2

