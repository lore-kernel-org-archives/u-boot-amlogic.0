Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.10753.1614092307823649910
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Feb 2021 06:58:28 -0800
Received: by mail-wr1-f50.google.com with SMTP id w11so207255wrr.10
        for <u-boot-amlogic@groups.io>; Tue, 23 Feb 2021 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=lwlrJi0YYsYWTQcFCrvc50o+YWVX0M8Y6VrnuIuH9H8=;
        b=HdyKcJxtCBYLQ6s+PHbAsGgLUOfv6DaM8XnJ19quioeKFbF6lNT1wXzYl/PYjkNiYc
         6Xn5qQyELpITJMFo5a1pjxPMjZpm8uBMW50lfOX4RZVDfQLQBIG/aa9RVVGxQp+2JE2K
         7RNkfhmXxxkeiSqk3js6NWodLLKR93bNTX99LlyULPwF1tl72GN00SaGOos7MzCODovb
         xBK+VtWh2nl/pC4UE36HLgmky0KfSzLpuzyTmpSvg8PH2grjCny7QpcCM1De0uvEzdzu
         83bF/xMj/XkKkdPttJ/P2Cjr58wAq7aj8hgQvC22rPlxSIJvcHLKfAtLYj5CUYmlf2C4
         v6Yw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210223
Reply-To: narmstrong@baylibre.com
Message-ID: <37445fd3-321a-21ee-8813-81ac50244d6c@baylibre.com>
Date: Tue, 23 Feb 2021 15:58:25 +0100
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
This time with s/treshold/threshold/.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/6480

Thanks,
Neil

The following changes since commit 496f49464d90b564da5f1a2f4eecb5553e01edf9:

  Merge branch '2021-02-16-assorted-improvements' (2021-02-16 15:14:34 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210223

for you to fetch changes up to ceeb50b3bf074960ddfa541b7be3732b38e15c99:

  button: add udevice forward declaration (2021-02-23 15:55:53 +0100)

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
