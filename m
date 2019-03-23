Received: by mail-wr1-f65.google.com with SMTP id p1so5013692wrs.8
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJ4Wct4TQAKyn5QqZ6rAq+hZYLN11TMt3rhFF2NR1BU=;
        b=LK+Rj97WOS95nXfPK7noWeHdskKHIQ5i/79cYXsvobRB/vmGgfZvSZltR8t67hok7I
         0fo2kheGZiW0GzIUNuOqEmN0A6EoRNWQ3+KETatO3aQ3PNGKO1D5fJjQdu/Az3+vYS+V
         ZnsVE6tHhbJREUAg8MQFNrJyhbOkuIcmv/qMvfzbuyL/oTrxO+YhTCV/WRS8TWljXrQh
         FvnDmblvkT8QwwMWUJdE0AbW647mSAhUXGBjq5AweiktljVsshBCZaNvWchmSK4gvVlH
         45Quey1P7N+NK5HLeMHIw2sBtLTHSUOqGk/ZfNHdXyl1gtj5/Mur8+Cs8/L9mnn2q76d
         2m4g==
Return-Path: <mohammad.rasim96@gmail.com>
From: mohammad.rasim96@gmail.com
Subject: [PATCH v5 0/5] ARM: meson: add support for p200 and p201 boards
Date: Sat, 23 Mar 2019 14:52:00 +0300
Message-Id: <20190323115200.1675-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This adds support for p200 and p201 reference boards from amlogic

Mohammad Rasim (5):
  ARM: board: meson: rename odroid-c2 to p200
  ARM: dts: meson: add p200 and p201 boards
  ARM: dts: meson: add u-boot.dtsi for p200 and p201
  ARM: board: meson: add p200 board
  ARM: board: meson: add p201 board

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi      |   7 +
 arch/arm/dts/meson-gxbb-p200.dts              |  99 +++++++
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi      |   7 +
 arch/arm/dts/meson-gxbb-p201.dts              |  26 ++
 arch/arm/dts/meson-gxbb-p20x.dtsi             | 247 ++++++++++++++++++
 arch/arm/mach-meson/Kconfig                   |   2 +-
 board/amlogic/{odroid-c2 => p200}/MAINTAINERS |   6 +-
 board/amlogic/{odroid-c2 => p200}/Makefile    |   2 +-
 .../{odroid-c2 => p200}/README.nanopi-k2      |   0
 .../{odroid-c2 => p200}/README.odroid-c2      |   0
 board/amlogic/p200/README.p200                | 103 ++++++++
 .../{odroid-c2/odroid-c2.c => p200/p200.c}    |   0
 board/amlogic/p201/MAINTAINERS                |   5 +
 board/amlogic/p201/Makefile                   |   5 +
 board/amlogic/p201/README.p201                | 103 ++++++++
 board/amlogic/p201/p201.c                     |  43 +++
 configs/p200_defconfig                        |  41 +++
 configs/p201_defconfig                        |  41 +++
 19 files changed, 734 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 rename board/amlogic/{odroid-c2 => p200}/MAINTAINERS (70%)
 rename board/amlogic/{odroid-c2 => p200}/Makefile (82%)
 rename board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 (100%)
 rename board/amlogic/{odroid-c2 => p200}/README.odroid-c2 (100%)
 create mode 100644 board/amlogic/p200/README.p200
 rename board/amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} (100%)
 create mode 100644 board/amlogic/p201/MAINTAINERS
 create mode 100644 board/amlogic/p201/Makefile
 create mode 100644 board/amlogic/p201/README.p201
 create mode 100644 board/amlogic/p201/p201.c
 create mode 100644 configs/p200_defconfig
 create mode 100644 configs/p201_defconfig

--
2.21.0

