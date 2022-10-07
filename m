Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web12.2569.1665135523226526709
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Oct 2022 02:38:43 -0700
Received: by mail-wm1-f51.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso4279750wma.1
        for <u-boot-amlogic@groups.io>; Fri, 07 Oct 2022 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=h2S4+OYsJNXvqbW83QyBS5/ZPM1IJHbVoYCFOhgfyaM=;
        b=TME9EE6gMdPiYdJH9shSrBLbrTZev3UEnYOlSXOH2NSvrddQovrH3jJQu3OzGz4w9x
         AqdvIjnpn8lxYACDEffzE6BZmDnGapniKnM4O7JKpc8H2qOmKi5luYi1bE4yZopbnvmu
         WchSu9WKIMeAu/2y0ou1mOGnVGGfQqBOD/mBsvxH23PlG5rG3ooyLmv5tXpYNv/hE9AS
         mqZlbpwF/+mXookNm3XJ8FXSvk5KLCbWhiTGcIIc39hp+pD8Xc9uqXRmPQ3Sjc/YvA1h
         Y0V4ETZgTj/LOTLeuVVFxDoJUBs+XiNg+wLvp2+hygu0isEbt4JFcTHYT9SWzZJl1gwC
         Kgug==
Return-Path: <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/2] fastboot/mach-meson: release usb_gadget on reboot commands
MIME-Version: 1.0
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Fri, 07 Oct 2022 11:38:21 +0200
Message-Id: <20220728-reset-usb-controller-v2-0-ef7657ce78b1@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Christian Hewitt <christianshewitt@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

When host issues "fastboot reboot fastboot", it's expected that the
board drops the USB connection before resetting.

On some boards, such as Khadas VIM3L and SEI610, this is not the case.

We observe the following error:
$ fastboot reboot fastboot
Rebooting into fastboot                            OKAY [  0.004s]
fastboot: error: Failed to boot into userspace fastboot; one or more components might be unbootable.

This does not happen when we use the RST button on the board.
It can be reproduced in linux with:
$ echo b > /proc/sysrq-trigger

In this case, we hit a undefined hardware behavior, where D+ and D-
are in an unknown state. Therefore the host can't detect usb
disconnection.

This series proposes 2 approaches for this problem:
* generic fix, which ensures that usb_gadget_disconnect() is called
  when the board receives any "fastboot reboot" commands
* platform specific reset implementation for g12a to ensure
  that the usb controller gets properly reset.

Changes in v2:
* Transformed into a series to provide both generic and platform
  specific fix (Marek)
* Simplified generic fix via g_dnl_trigger_detach() (Marek)
* Link to v1: https://lore.kernel.org/r/20220721135955.360195-1-mkorpershoek@baylibre.com

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

---
Mattijs Korpershoek (2):
      usb: gadget: fastboot: detach usb on reboot commands
      mach-meson: g12a: reset usb controller in reset_misc()

 arch/arm/mach-meson/board-g12a.c          | 14 ++++++++++++++
 cmd/fastboot.c                            |  2 +-
 configs/bananapi-m5_defconfig             |  2 ++
 configs/beelink-gsking-x_defconfig        |  2 ++
 configs/beelink-gtking_defconfig          |  2 ++
 configs/beelink-gtkingpro_defconfig       |  2 ++
 configs/khadas-vim3_android_ab_defconfig  |  2 ++
 configs/khadas-vim3_android_defconfig     |  2 ++
 configs/khadas-vim3_defconfig             |  2 ++
 configs/khadas-vim3l_android_ab_defconfig |  2 ++
 configs/khadas-vim3l_android_defconfig    |  2 ++
 configs/khadas-vim3l_defconfig            |  2 ++
 configs/odroid-c4_defconfig               |  2 ++
 configs/odroid-hc4_defconfig              |  2 ++
 configs/odroid-n2_defconfig               |  2 ++
 configs/radxa-zero_defconfig              |  2 ++
 configs/u200_defconfig                    |  2 ++
 drivers/usb/gadget/f_fastboot.c           |  1 +
 18 files changed, 46 insertions(+), 1 deletion(-)
---
base-commit: 2d4591353452638132d711551fec3495b7644731
change-id: 20220728-reset-usb-controller-1b54be54b9d8

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>
