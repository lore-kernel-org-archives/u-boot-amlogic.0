Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.10705.1594215374476305981
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Jul 2020 06:36:15 -0700
Received: by mail-wr1-f43.google.com with SMTP id z2so26768297wrp.2
        for <u-boot-amlogic@groups.io>; Wed, 08 Jul 2020 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=vnFj1oPYnVNmqjwaIxkXM5h8/ARhL9LDq8pa30oQL1U=;
        b=wjJAit9+ah7lWNs2TVOWRIWo4EdN+veS7XAlRDD+DLHrMFGz9+HwF65BJX6rf8mDkS
         52epnran+UPZrnOMj4RDxE21avwhpz2crn2Jqj1ErracMSGhPoeamPPgo4XPYjoB7Xnt
         Cd8qehX7o4oisdXTXLeVaL1Tm1UM9YLM/Huq0kmCQfZFo/VQenR+RbX6anxsXkgTN1i4
         4/ucqARUr5O06OsCRS89KWs72RpjcoRq2uJWXq2dUJcn9zU0YOSe72hjE1qWKjXVzRP9
         N+EVnA9G7xlY5rh2W0F5o72HoJICwQ3le7QYV9PvkTZlFv3gV7euINAI4a24yxAmvZaM
         D1HQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200708
Reply-To: narmstrong@baylibre.com
Message-ID: <9ed7160f-95d9-6c3f-0a06-92d8dbcc4263@baylibre.com>
Date: Wed, 8 Jul 2020 15:36:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds a proper board support for Odroid-N2 to get the MAC address from fuses and
adds support for the new Odroid-C4 single board computer.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/3944

Thanks,
Neil

The following changes since commit 2f5fbb5b39f7b67044dda5c35e4a4b31685a3109:

  Prepare v2020.07 (2020-07-06 15:22:53 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200708

for you to fetch changes up to d9c967792b7830d51a1fe596f9a27ea6dfd4bcfe:

  ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset (2020-07-08 10:52:45 +0200)

----------------------------------------------------------------
- Add proper Odroid-N2 board support code
- Add support for Odroid-C4 single board computer

----------------------------------------------------------------
Christian Hewitt (2):
      ARM: dts: sync amlogic G12A/G12B/SM1 DT from Linux 5.8-rc1
      boards: amlogic: add Odroid C4 support

Neil Armstrong (1):
      ARM: dts: meson-sm1-odroid-c4: add ethernet PHY reset

Pascal Vizeli (1):
      board: amlogic: Add Odroid-N2 board support

 arch/arm/dts/Makefile                        |   1 +
 arch/arm/dts/meson-g12-common.dtsi           |  13 +-
 arch/arm/dts/meson-g12.dtsi                  |  32 +--
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi     |  22 +-
 arch/arm/dts/meson-g12b-s922x.dtsi           |  15 +
 arch/arm/dts/meson-g12b.dtsi                 |  22 ++
 arch/arm/dts/meson-khadas-vim3.dtsi          |   4 +-
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi |  13 +
 arch/arm/dts/meson-sm1-odroid-c4.dts         | 402 +++++++++++++++++++++++++++
 arch/arm/dts/meson-sm1-sei610.dts            |   2 +-
 arch/arm/dts/meson-sm1.dtsi                  |  24 ++
 board/amlogic/odroid-n2/MAINTAINERS          |   9 +
 board/amlogic/odroid-n2/Makefile             |   6 +
 board/amlogic/odroid-n2/odroid-n2.c          |  49 ++++
 board/amlogic/w400/MAINTAINERS               |   2 -
 configs/odroid-c4_defconfig                  |  62 +++++
 configs/odroid-n2_defconfig                  |   2 +-
 doc/board/amlogic/index.rst                  |   3 +-
 doc/board/amlogic/odroid-c4.rst              | 134 +++++++++
 19 files changed, 777 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
 create mode 100644 board/amlogic/odroid-n2/MAINTAINERS
 create mode 100644 board/amlogic/odroid-n2/Makefile
 create mode 100644 board/amlogic/odroid-n2/odroid-n2.c
 create mode 100644 configs/odroid-c4_defconfig
 create mode 100644 doc/board/amlogic/odroid-c4.rst
