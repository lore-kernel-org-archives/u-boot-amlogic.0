Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.6382.1627543278561587240
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 00:21:19 -0700
Received: by mail-wm1-f54.google.com with SMTP id u15so3050752wmj.1
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZpk+cjZizQ7pKAwaPwKVXGrufazT0pir0iG2pFR6TA=;
        b=a/YwniKGXG8TW6vc89Q9ielU1tQZxvYCgVVEEvzTAIHeb2hwXTtmGjfFjEt1aTW5/5
         xVGhn+AbmgEdZMVYRQLD0Hbn+QLeaCCuouxLqRPTv438Ipy87gBfiGyW9bGSr436AH2n
         OTz+BbqiRCe+tSbUJ7JuzP5Wv3rKGm15VK/Q7tq3fba9Pvyzj7SGCGka1EKzEH/z8ATA
         76pRnCBqRsTc+WPqG1aRp+VFm4bGJ95sKsOr9wc5HmwSSlt7WhY4bBtjJbES0POgozK/
         WqpB72L6TPws/9Ea/VoNTLkqmByNMF+PoWjfrUEyuQR2yu5vAGfnrhKDlUmnXBWHCIG8
         8CyA==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: [PATCH 0/6] VIM3: misc cleanups to prepare android support
Date: Thu, 29 Jul 2021 09:21:07 +0200
Message-Id: <20210729072113.208099-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Khadas VIM3 and VIM3L boards are well supported in the
Android Open Source project via the yukawa[1] platform.

Their U-Boot version, despite being public [2] is not in mainline.

These series a couple of cleanups to prepare to add mainline U-Boot support
for vim3 / vim3l so that we can boot Android.

[1] https://source.android.com/setup/build/devices#vim3_and_vim3l_boards
[2] https://gitlab.com/baylibre/amlogic/atv/u-boot/-/tree/u-boot/v2021.07/integ

Mattijs Korpershoek (6):
  configs: sei610: fix typo in header comment
  configs: meson64_android: fix bad indent in EXTRA_ENV_SETTINGS
  configs: meson64_android: use CONFIG_FASTBOOT_USB_DEV
  configs: meson64_android: use boot part label instead of index
  configs: meson64_android: use logo part label instead of index
  configs: meson64_android: don't set console bootargs

 include/configs/meson64_android.h | 30 +++++++++++++++++-------------
 include/configs/sei610.h          |  2 +-
 2 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.30.2

