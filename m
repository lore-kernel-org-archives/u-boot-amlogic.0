Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.9271.1642668951888332494
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jan 2022 00:55:52 -0800
Received: by mail-wm1-f48.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so12016541wmq.2
        for <u-boot-amlogic@groups.io>; Thu, 20 Jan 2022 00:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Z4QttmG/qf9nU+IClsTOZFK7eJK3g4WMgQ5iG8jZT8Q=;
        b=NSHHIQ7DxtNRDA6hjQEGvXzqnFupjIen7DvM+y+nOdOYhxbEBVGvFmAyKnoS2P9qbb
         KoeW942Drt2PYKUMIvcBMIUXwK5134zL8Z8YheT5WZubQM/Qlla+oNu5bxVWjo6oE2S5
         ukte8DI5BXwG0hZNFN1wAdKSt0hiSn1iV7IHnf/E4GEXrOUhO+GdbhU+/CXPBFLAV3sP
         HkMlYXAcELfvsuDfWRSW/Yn0SNfl8bj5Z/4iogWjSVJsy+n7IE7soeX+uisoMbVsVnNM
         cAFAxTEBIKFY5qVYwf95UENxcC/ds6Po1cgmwyrNFrQGXPFs0PrjHpJxQ4lQjbBaPWXP
         scfg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20220120
Reply-To: narmstrong@baylibre.com
Message-ID: <4972104f-d6c4-c0c0-5ce3-bd057e2c6cb9@baylibre.com>
Date: Thu, 20 Jan 2022 09:55:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's a few changes :
- CONFIG_NET_RANDOM_ETHADDR cleanup for VIM3/L Android configs I missed
- raw parts for bootloader to flash bootloader with fastboot with Android configs
- Add missing serial# like sei510/610 in order to satisfy fastboot

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/10491

Thanks,
Neil

The following changes since commit 068415eadefbbc81f14d4ce61fcf7a7eb39650d4:

  Merge tag 'xilinx-for-v2022.04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze (2022-01-19 11:43:44 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20220120

for you to fetch changes up to 09c2debab70271fdb3b1ff89e0e7d186502c548d:

  board: amlogic: vim3: configure serial# from ethaddr (2022-01-20 09:50:54 +0100)

----------------------------------------------------------------
- Disable CONFIG_NET_RANDOM_ETHADDR for android configs
- meson64_android: define raw parts for bootloader to permit flashing with fastboot
- vim3: configure serial# from ethaddr to permit using fastboot like sei510/610

----------------------------------------------------------------
Mattijs Korpershoek (3):
      configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR for android
      configs: meson64_android: define raw parts for bootloader
      board: amlogic: vim3: configure serial# from ethaddr

 board/amlogic/vim3/vim3.c                 | 9 +++++++++
 configs/khadas-vim3_android_ab_defconfig  | 1 -
 configs/khadas-vim3_android_defconfig     | 1 -
 configs/khadas-vim3l_android_ab_defconfig | 1 -
 configs/khadas-vim3l_android_defconfig    | 1 -
 include/configs/meson64_android.h         | 2 ++
 6 files changed, 11 insertions(+), 4 deletions(-)
