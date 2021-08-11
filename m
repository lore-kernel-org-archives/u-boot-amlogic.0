Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.4667.1628667685341242975
 for <u-boot-amlogic@groups.io>;
 Wed, 11 Aug 2021 00:41:26 -0700
Received: by mail-wr1-f47.google.com with SMTP id q11so1687717wrr.9
        for <u-boot-amlogic@groups.io>; Wed, 11 Aug 2021 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FKqtM0Tw98A46ts+vKU25ek2RXDCN8clWO3lgDX0dy8=;
        b=GpaLkTLhLYCwnLrOqEBpNWAKLrP5J9eGMEpw87QSkpVXeCkdZnvaSHyRsItV++zkWd
         9CizupgAAbewIohRbURFpcW09nVVGPNzJ/4ePW8NelP7j/euZEXZo+pjj8/gPFfHIaYC
         XC1qScmMlgyUPHKN4lWLfqqiZbdNYZPmWgl9f0hTog0wPvqgG2Mz7kF9YOfy77SEbaCn
         ipNDWB9YcBsRcKcu7ocyTCe+/2GzyKDC5t0WxhYyxQem/fEmotrCCOwibMJYaVbdEt6N
         AvE0k+z3uJyZMj5qKD9Q4kN2ypZK9INpwmteHXfY47EIvbFPc+NAsqS6dd7KIXhLn58h
         j7Sw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-202107810
Reply-To: narmstrong@baylibre.com
Message-ID: <a3fc8b7f-34e1-05c3-4bc6-d9435d6b84a0@baylibre.com>
Date: Wed, 11 Aug 2021 09:41:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's a bunch of changes concerning:
- single fix for odroid-n2+ detection
- HW reboot_reason drop in favor of BCB for Android boot state tracking
- meson64_android config cleanups and support for A/V, AVB and fastbootd via recovery

While the actual meson64_android config removes distro defaults targets and makes booting non-Android
possible but complex, we are working toward either adding back the default targets or trying to
leverage boot_android at some point to avoid building android-only u-boot binaries.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/8655

Thanks,
Neil

The following changes since commit bbcacdf4cd23f2e5deb9ef916096c956c955243d:

  Merge branch '2021-07-28-build-improvements' (2021-07-28 18:51:16 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210810

for you to fetch changes up to 33b51765583e6cbe1888f068da795bea599bad18:

  configs: sei510/610: android bootflow via abootimg (2021-08-10 10:43:54 +0200)

----------------------------------------------------------------
- odroid-n2: fix fdtfile suffix for n2-plus
- sei610 & meson64_android cleanups to prepare android 11 boot support
- use Android BCB mechanism for reboot reason instead of HW reboot flag
- Switch meson64_android boot flow to use abootimg for A/B, AVB and DTBO support

----------------------------------------------------------------
Christian Hewitt (1):
      board: amlogic: odroid-n2: fix fdtfile suffix for n2-plus

Guillaume La Roque (2):
      configs: meson64_android: boot android via abootimg
      configs: sei510/610: android bootflow via abootimg

Mattijs Korpershoek (18):
      configs: sei610: fix typo in header comment
      configs: meson64_android: fix bad indent in EXTRA_ENV_SETTINGS
      configs: meson64_android: use CONFIG_FASTBOOT_USB_DEV
      configs: meson64_android: use boot part label instead of index
      configs: meson64_android: use logo part label instead of index
      configs: meson64_android: don't set console bootargs
      configs: meson64_android: use BCB for reboot to bootloader
      configs: meson64_android: implement recovery boot via BCB
      configs: meson64_android: reboot to fastbootd from bootloader
      configs: sei610/sei510: set CONFIG_CMD_BCB=y
      Revert "ARM: meson: Add support for fastboot_set_reboot_flag()"
      configs: meson64: permit redefining SYS_MALLOC_LEN
      configs: meson64_android: increase SYS_MALLOC_LEN to 128M for AVB
      configs: meson64_android: implement AVB support
      configs: meson64_android: implement A/B slot support
      configs: meson64_android: define BOOT_CMD macro
      configs: sei510/sei610: reformat PARTS_default
      configs: sei510/sei610: don't use hard-coded gpt uuids

 arch/arm/mach-meson/board-common.c  |  34 ------
 board/amlogic/odroid-n2/odroid-n2.c |   2 +-
 configs/odroid-n2_defconfig         |   2 +-
 configs/sei510_defconfig            |   6 +
 configs/sei610_defconfig            |   6 +
 include/configs/meson64.h           |   2 +
 include/configs/meson64_android.h   | 215 ++++++++++++++++++++++++++++++------
 include/configs/sei510.h            |  23 ++--
 include/configs/sei610.h            |  25 ++---
 9 files changed, 220 insertions(+), 95 deletions(-)
