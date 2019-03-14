Received: by mail-ed1-f48.google.com with SMTP id p27so4863448edc.6
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:date:subject;
        bh=JpYmQDqs4+yBbyHXFf4l7k1xyYeAVOA61/hiSK+fOYQ=;
        b=YE86SfOd4xzWzeUDTyf2nxo702lEXsPzL609urkUB96vm8XPKQfIVdSfprAF62hJlb
         GUUPfOyyPJl3glCEEVQP3TOFSh2oQJQnEAGoYmd26osi1ujYvIRc4yQ4PXtijrYPNumi
         Twf7aJ0Oeyw7XLuN3W1PtZEGur3+7IWbN8H7bcrZvJY6jo5DAB8sAc53kWb/AQmvbvlJ
         rhMRqU6+Aj2I5eWKfWJrWIN4Y3cuJC8C5KZGv6YxFNuGwyk4hNTbteqb8IATg1aE+HR6
         IKjqa9TE4I3Yk9rB1VbQkNCrhKDYBX/Tr+FCLTqYH0qR5SwroqWIrSziUpthMId87GlR
         3AMw==
Return-Path: <mohammad.rasim96@gmail.com>
Message-ID: <5c8a69f8.1c69fb81.cc832.5b07@mx.google.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Date: Thu, 14 Mar 2019 17:02:38 +0300
Subject: [PATCH 0/2] ARM: meson: add p200 and p201 boards
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: narmstrong@baylibre.com
List-ID: <u-boot-amlogic@groups.io>

This adds support for p200 and p201 reference boards from amlogic

Mohammad Rasim (2):
  ARM: dts: meson: add p200 and p201 boards
  ARM: board: meson: add p200 and p201 boards

 arch/arm/dts/Makefile               |   2 +
 arch/arm/dts/meson-gxbb-p200.dts    |  99 +++++++++++
 arch/arm/dts/meson-gxbb-p201.dts    |  26 +++
 arch/arm/dts/meson-gxbb-p20x.dtsi   | 247 ++++++++++++++++++++++++++++
 board/amlogic/odroid-c2/README.p200 | 103 ++++++++++++
 board/amlogic/p201/MAINTAINERS      |   6 +
 board/amlogic/p201/Makefile         |   5 +
 board/amlogic/p201/README.p201      | 103 ++++++++++++
 board/amlogic/p201/p201.c           |  43 +++++
 configs/p200_defconfig              |  41 +++++
 configs/p201_defconfig              |  41 +++++
 11 files changed, 716 insertions(+)
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

