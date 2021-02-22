Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.35257.1614004241169606500
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Feb 2021 06:30:41 -0800
Received: by mail-wm1-f44.google.com with SMTP id v21so652085wml.4
        for <u-boot-amlogic@groups.io>; Mon, 22 Feb 2021 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=1YVYtL2Zu9z+EV3peOGaJT1k980H9HLn2LElgBvI8Q8=;
        b=dsTvWHCnLm6DvLI1zModj2pSq4OiL6g+fFzKbfsBRGFiFRP6tUgCfAGTBUzNLDz50U
         MuvMZXuAzVwh8uN+DUa+OJ4TKx1Gm4us8rgLpNIX1PXe08Bzw2F599XkjXj4I4pY8Qte
         kmiT367YcywDlmhdm5dP0Bjrt2HxAVxl2Mr+tSkK0vQQ/Kajk6RuZJmbq9FfNPjADonG
         pSmYffP+gCU3V9IxnYHfe7CyhXm2m8muHMD2SdEWEQH/905VYKw8uvO2VYVt+r7qeHSs
         XWy7xJUu5unySJ3g7XiYjiEihMVHKO9kFIWbc3xuAd7Dlo9rkBGGFfu8mOKNmEuOnnHG
         Yn4w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210222
Reply-To: narmstrong@baylibre.com
Message-ID: <2417b7bc-0dad-64ce-c4a9-ed4d9851df44@baylibre.com>
Date: Mon, 22 Feb 2021 15:30:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

These changes adds support for reading the ADC key on the Khadas VIM3 & VIM3L, in the same
time it adds plumbing for ADC keys and a test for sandbox.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/6461

Thanks,
Neil

The following changes since commit 496f49464d90b564da5f1a2f4eecb5553e01edf9:

  Merge branch '2021-02-16-assorted-improvements' (2021-02-16 15:14:34 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210222

for you to fetch changes up to 2d339efb1ff941705a770e93494427912689ce18:

  button: add udevice forward declaration (2021-02-22 11:07:57 +0100)

----------------------------------------------------------------
- adds adc-keys button driver
- fix meson-saradc driver to get reference voltage
- add adc-keys test for sandbox
- enable adc-keys for VIM3 & VIM3L boards
- fix button.h build

----------------------------------------------------------------
Marek Szyprowski (5):
      dt-bindings: input: adc-keys bindings documentation
      button: add a simple Analog to Digital Converter device based button driver
      adc: meson-saradc: add support for getting reference voltage value
      configs: khadas-vim3(l): enable Function button support
      test: add a simple test for the adc-keys button driver

Neil Armstrong (1):
      button: add udevice forward declaration

 arch/sandbox/dts/test.dts                   |  28 +++++-
 configs/khadas-vim3_defconfig               |   2 +
 configs/khadas-vim3l_defconfig              |   2 +
 configs/sandbox_defconfig                   |   1 +
 doc/device-tree-bindings/input/adc-keys.txt |  67 +++++++++++++
 drivers/adc/meson-saradc.c                  |  21 ++++
 drivers/button/Kconfig                      |   8 ++
 drivers/button/Makefile                     |   1 +
 drivers/button/button-adc.c                 | 146 ++++++++++++++++++++++++++++
 include/button.h                            |   2 +
 test/dm/button.c                            |  50 +++++++++-
 11 files changed, 325 insertions(+), 3 deletions(-)
 create mode 100644 doc/device-tree-bindings/input/adc-keys.txt
 create mode 100644 drivers/button/button-adc.c
