Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.2457.1589275616124132686
 for <u-boot-amlogic@groups.io>;
 Tue, 12 May 2020 02:26:56 -0700
Received: by mail-wm1-f50.google.com with SMTP id g14so8883704wme.1
        for <u-boot-amlogic@groups.io>; Tue, 12 May 2020 02:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=+f+69drr7wRQ5wy7VvvxPyrcvCyZkF7KgMPBMxy9GDA=;
        b=gK/nwf53q/+xTPyKFvi57bGbSTjCfvelzgvSMmS50UBeFefH2LbaC871MtiVM6BtHc
         6i4LcfatXSomb5Y4QQUYb5TzbkymjKF96/zjJr/q8bTSTKq1/Mb28KdIJEJdZ5Uiha22
         c2s6bUn0Uz1jHe1KjTaD1QCX1vk7ibAp5Jh2Q8qH4PDSWnMCSuCL6N7lgdBEpPHtB85p
         wSlzLnpz5v1hIcv7GhKLvPjmYrfHeNgPi/KavdmuxCRIQbIzlaCIOCR4MJFK7p5StIwB
         oUukQL066Hc8/HNjbd0a8nn8U+lokjQG3zHSwpbCgBkjRnCXqHHBJHjg+yGU879Hwq+t
         NJsw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200511
Reply-To: narmstrong@baylibre.com
Message-ID: <c4e53b7a-128a-2d60-729f-713c4981c4f1@baylibre.com>
Date: Tue, 12 May 2020 11:26:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR enables adds GPIO Open-Drain/Open-Source emulation in GPIO uclass
and finally enables USB Host support for the Odroid-C2 board.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/3196

Thanks,
Neil

The following changes since commit c5c657644bc35fd6b3d6e5517698721e90646b8d:

  Merge branch '2020-05-08-assorted-fixes' (2020-05-08 18:58:19 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200511

for you to fetch changes up to 9bf87e256c26246fa6d8df491617e40cb7df89c2:

  test: dm: update test for open-drain/open-source emulation in gpio-uclass (2020-05-11 15:12:56 +0200)

----------------------------------------------------------------
- Enable USB Host for Odroid-C2 board
- Add Open-Drain/Open-Source emulation in GPIO uclass

----------------------------------------------------------------
Beniamino Galvani (1):
      odroid-c2: enable USB host controller

Neil Armstrong (2):
      gpio: emulate open drain & open source in dm_gpio_set_value()
      test: dm: update test for open-drain/open-source emulation in gpio-uclass

 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi |  8 +++
 arch/sandbox/dts/test.dts                    |  4 +-
 configs/odroid-c2_defconfig                  |  7 +++
 drivers/gpio/gpio-uclass.c                   | 15 +++++
 test/dm/gpio.c                               | 89 ++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 1 deletion(-)
