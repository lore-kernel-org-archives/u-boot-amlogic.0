Received: by mail-ed1-f66.google.com with SMTP id d21so4420720edx.12
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwM7wGoPn3szirDhqOw2V1xoTWSkKQ8Wv9xYUP7UaMI=;
        b=JLbaC5SgoECDtnKWvqRjE3hJa3rDre+YRb6J6fN6koGfFOaT1kVr2G5GV562yZgjU6
         BPkGMMvmnG3GqtfanBsL+r/+MlAOHUTBh+Qa3dDQvdLyuGAfJre2TqgXnCgO20jUY4t2
         kgT0kt+RGh69Fu9KOHXAMoKLzCFpcWyl/4gTevz/970PqcrCta+1s72X5fWxSqC54tsM
         NALM9U3U6/nvWc5PJl/pYl19iOGcai/ui8vHUFNq0nsX2c2DIPDWScYD0gWKXph9plz/
         q3xgdHJj06Wd7tGpc3izpxddZx66AH1qwgoIKYhKHrfwgfHKSNu41O7Rsu0Muh8MFVT4
         ek4w==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v3 0/3] ARM: meson: add p200 and p201 boards
Date: Fri, 15 Mar 2019 00:09:17 +0300
Message-Id: <20190314210920.11006-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Mohammad Rasim <mohammad.rasim96@gmail.com>, narmstrong@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

This adds support for p200 and p201 reference boards from amlogic

Mohammad Rasim (3):
  ARM: dts: meson: add p200 and p201 boards
  ARM: board: meson: add p201 board
  ARM: board: meson: add p200 board

 arch/arm/dts/Makefile               |   2 +
 arch/arm/dts/meson-gxbb-p200.dts    |  99 +++++++++++
 arch/arm/dts/meson-gxbb-p201.dts    |  26 +++
 arch/arm/dts/meson-gxbb-p20x.dtsi   | 247 ++++++++++++++++++++++++++++
 board/amlogic/odroid-c2/MAINTAINERS |   1 +
 board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++
 board/amlogic/p201/MAINTAINERS      |   5 +
 board/amlogic/p201/Makefile         |   5 +
 board/amlogic/p201/README.p201      | 103 ++++++++++++
 board/amlogic/p201/p201.c           |  43 +++++
 configs/p200_defconfig              |  41 +++++
 configs/p201_defconfig              |  41 +++++
 12 files changed, 716 insertions(+)
 create mode 100644 arch/arm/dts/meson-gxbb-p200.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p201.dts
 create mode 100644 arch/arm/dts/meson-gxbb-p20x.dtsi
 create mode 100644 board/amlogic/odroid-c2/README.p200
 create mode 100644 board/amlogic/p201/MAINTAINERS
 create mode 100644 board/amlogic/p201/Makefile
 create mode 100644 board/amlogic/p201/README.p201
 create mode 100644 board/amlogic/p201/p201.c
 create mode 100644 configs/p200_defconfig
 create mode 100644 configs/p201_defconfig

--
2.21.0

