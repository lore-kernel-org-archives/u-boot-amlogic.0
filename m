Received: by mail-ed1-f65.google.com with SMTP id x10so4751578edh.11
        for <u-boot-amlogic@groups.io>; Fri, 15 Mar 2019 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOKDGdw+YWIo+er6fnxpyRHNkAAAnwQylOEsSd3BuSs=;
        b=jRQNXr1Fhi2jE3wBQxzyGyNomuV+RHP2oC0vO5ozhdcGAEBLqDSwVsqH6XX5YOYnI/
         QnCHKz8q8phjeQsmR4z95WyVJ/2I0vx6p8knzsU4oWZnmd+gn3Po4vcDpKZyUK7/2drn
         XDXYTmQLFm8afUgVk70548Kxl4AglPLFENKFUmTl6TdkkfaZnUESmMHxOPbvr25P9dWy
         C0/yXKEeoFIAKnH93nEYjMgfVwnLkW8blpAhVmVOXLKq7yB4vuQVUHSFdg4yb0rKwd1z
         q+8dmVCc45l9lOrokw2F1dXEDZtzxJQtzOlu8hR7Q/jPtP/4dNDaCXqpfYGYzLsI7Oo7
         kdrA==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v4 0/5] Arm: meson: add support for p200 and p201 boards
Date: Fri, 15 Mar 2019 18:11:05 +0300
Message-Id: <20190315151109.17317-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, narmstrong@baylibre.com
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>
List-ID: <u-boot-amlogic@groups.io>


This adds support for p200 and p201 reference boards from amlogic

Mohammad Rasim (5):
  ARM: board: meson: rename odroid-c2 to p200
  ARM: dts: meson: add p200 and p201 boards
  Arm: dts: meson: add u-boot.dtsi for p200 and p201
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
 configs/nanopi-k2_defconfig                   |   1 +
 configs/odroid-c2_defconfig                   |   1 +
 configs/p200_defconfig                        |  41 +++
 configs/p201_defconfig                        |  41 +++
 21 files changed, 736 insertions(+), 5 deletions(-)
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

