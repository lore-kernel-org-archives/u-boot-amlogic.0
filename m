Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.21400.1627635347086708419
 for <u-boot-amlogic@groups.io>;
 Fri, 30 Jul 2021 01:55:47 -0700
Received: by mail-wm1-f51.google.com with SMTP id n21so5477927wmq.5
        for <u-boot-amlogic@groups.io>; Fri, 30 Jul 2021 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6+BNW7EcN+hHvLmYQEg7jKEwGsUBAmuChKrFnOO2s0=;
        b=dmP9PbQAcTz6HtOkIGf1OGh/9OU1TE/XMbBM95AlYiq9g8Ovhtf46pgIuKZHeg1SOD
         3vWdsAMZnMd8OH/Z87+fhMr2G5Lt8kx40fwH4OG8HXHIgV9CMO2f37JKrtR0yajjfCAw
         jH6aTEMK3TDWFM/GOM4Q/CfH2bf8aK/uB06EvSYa0/oooTrRFVcyb0E09HorBW8PGHM6
         m8rEd8f53omWztgcRzUK+Mxyye+YXw+wciu8WTIBL7bXv6UylIMRfmRpmuDbQMsDs/Qp
         /geE58GczwIzzgOKDdosMqQajoYEIQee3k5lb5fSNqbAmE+KoSzB7b8fkhhi+gSqjZXM
         WTnA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 0/5] meson64_android: use BCB for reboot reason
Date: Fri, 30 Jul 2021 10:55:26 +0200
Message-Id: <20210730085531.2849834-1-mkorpershoek@baylibre.com>
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

Mattijs Korpershoek (5):
  Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
  configs: meson64_android: use BCB for reboot to bootloader
  configs: meson64_android: implement recovery boot via BCB
  configs: meson64_android: reboot to fastbootd from bootloader
  configs: sei610/sei510: set CONFIG_CMD_BCB=y

 arch/arm/mach-meson/board-common.c | 34 -----------------
 configs/sei510_defconfig           |  1 +
 configs/sei610_defconfig           |  1 +
 include/configs/meson64_android.h  | 60 ++++++++++++++++++++----------
 4 files changed, 42 insertions(+), 54 deletions(-)

-- 
2.30.2

