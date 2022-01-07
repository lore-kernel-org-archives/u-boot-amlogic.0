Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.7803.1641568471793215450
 for <u-boot-amlogic@groups.io>;
 Fri, 07 Jan 2022 07:14:32 -0800
Received: by mail-wr1-f43.google.com with SMTP id e9so10135828wra.2
        for <u-boot-amlogic@groups.io>; Fri, 07 Jan 2022 07:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zv+aG3KmGSN+Toc/umRp4/4YLGjI6P7PyLHyl3Zdkg4=;
        b=kdsykQbr3ywClei+C81ruHlYYs3TrDJ0u6FXMG3egGONMJf5bvbIB1K/S1B1dfyA+2
         oktH4D+/jGLkSlVwADQnH1kK7udrSbDHpNTUFOziwGHk5t/9meoVab1gK58PLXTK2SEk
         kL3gG7idWJ228R+7V6GNi3c1sXMmnX9cWE8i2uROil6EJRWNAUZ1Am2V6ImEAvSXkXgd
         wDK4jXhcXRi6ddhKhujNz8TqB6C3RNFtt453Ltu7CxhEf43vSfRXhp/UxZz0JcVYxc+i
         Kzc5xSrlF+UQPOelH9nHX61LrIpvjFGjwlpkVJ/j3IzasMAAAWL4YhrnJU6inPQG5Xn0
         0hKw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20220107
Reply-To: narmstrong@baylibre.com
Message-ID: <a62eb809-699c-0f94-0e6a-e119bcea28dd@baylibre.com>
Date: Fri, 7 Jan 2022 16:14:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's changes for next release, nothing particular, no new boards either:
- CONFIG_NET_RANDOM_ETHADDR cleanup as you suggested
- android boot support for Khadas VIM3/L, and will ease support android boot for any amlogic boards

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/10491

Thanks,
Neil

The following changes since commit c00c147dae51f06e012841371f9baffb4b9dc1b3:

  Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2022-01-05 13:08:45 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20220107

for you to fetch changes up to 4c8d067bc520fc2ce6dcd7c5833b090f22c67185:

  configs: khadas-vim3{l}_android_ab: enable A/B support (2022-01-07 10:12:43 +0100)

----------------------------------------------------------------
- disable CONFIG_NET_RANDOM_ETHADDR when unnecessary on amlogic based configs
- meson64_android: add board specific env settings, in order to support VIM3/L for android
- add changes to support VIM3/L android boot by using meson64_android.h config

----------------------------------------------------------------
Mattijs Korpershoek (4):
      configs: meson64_android: add board specific env settings
      configs: add khadas-vim3{l}_android for AOSP support
      configs: prepare khadas-vim3{l}_ab_android for AOSP support
      configs: khadas-vim3{l}_android_ab: enable A/B support

Neil Armstrong (1):
      configs: amlogic: Disable CONFIG_NET_RANDOM_ETHADDR when unnecessary

 board/amlogic/vim3/MAINTAINERS            |   4 ++
 configs/bananapi-m5_defconfig             |   1 -
 configs/beelink-gsking-x_defconfig        |   1 -
 configs/beelink-gtking_defconfig          |   1 -
 configs/beelink-gtkingpro_defconfig       |   1 -
 configs/jethub_j80_defconfig              |   1 -
 configs/khadas-vim2_defconfig             |   1 -
 configs/khadas-vim3_android_ab_defconfig  | 109 ++++++++++++++++++++++++++++++
 configs/khadas-vim3_android_defconfig     | 107 +++++++++++++++++++++++++++++
 configs/khadas-vim3_defconfig             |   1 -
 configs/khadas-vim3l_android_ab_defconfig | 109 ++++++++++++++++++++++++++++++
 configs/khadas-vim3l_android_defconfig    | 107 +++++++++++++++++++++++++++++
 configs/khadas-vim3l_defconfig            |   1 -
 configs/khadas-vim_defconfig              |   1 -
 configs/libretech-ac_defconfig            |   1 -
 configs/libretech-cc_defconfig            |   1 -
 configs/libretech-cc_v2_defconfig         |   1 -
 configs/libretech-s905d-pc_defconfig      |   1 -
 configs/libretech-s912-pc_defconfig       |   1 -
 configs/odroid-c4_defconfig               |   1 -
 configs/odroid-hc4_defconfig              |   1 -
 configs/odroid-n2_defconfig               |   1 -
 configs/p212_defconfig                    |   1 -
 configs/s400_defconfig                    |   1 -
 configs/sei510_defconfig                  |   1 -
 configs/sei610_defconfig                  |   1 -
 configs/u200_defconfig                    |   1 -
 configs/wetek-core2_defconfig             |   1 -
 include/configs/khadas-vim3_android.h     |  50 ++++++++++++++
 include/configs/khadas-vim3l_android.h    |  50 ++++++++++++++
 include/configs/meson64_android.h         |  17 +++++
 31 files changed, 553 insertions(+), 23 deletions(-)
 create mode 100644 configs/khadas-vim3_android_ab_defconfig
 create mode 100644 configs/khadas-vim3_android_defconfig
 create mode 100644 configs/khadas-vim3l_android_ab_defconfig
 create mode 100644 configs/khadas-vim3l_android_defconfig
 create mode 100644 include/configs/khadas-vim3_android.h
 create mode 100644 include/configs/khadas-vim3l_android.h
