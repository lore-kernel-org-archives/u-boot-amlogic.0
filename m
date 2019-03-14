Received: by mail-ed1-f67.google.com with SMTP id d12so5281261edp.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Mar 2019 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+J+g874IW5OEILM6L8sLf/43ksDwSQUT7NX+odq0nLE=;
        b=Cx/gPbY/A8uPaDIaSv4kbHNpa2fgKMaIWTD/bZUVtTQ/Ce9cqAOjKO68SwmubUpOzf
         LeTSg1AEBNcIV7jQIZlE8LFVhcbpfvMoCbZ4ZdWwb9kJtZQ2EKG6dObRhiy7q2NpLgGW
         ukJK/+bVOjREhr1nYx0/gh/mozRzCae9l7mF0QCpAGA1wIjhfNBmp4ybamS7Bbi5MIwj
         DwIbk3GzhgxKpq0NCjxfGrO05P31KgGox+Ghb/UESPhPQ/HlHMpmPpOBUjO3vJNgGime
         iAVAGzq8exz3z1/kMHCQ0hN6nAd2MGFIHpMUiQD+5ysmGUYDCzpmCZjdQ7ZMMES8jTFU
         i8cw==
Return-Path: <mohammad.rasim96@gmail.com>
From: Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: [PATCH v2 0/3] ARM: meson: add p200 and p201 boards
Date: Thu, 14 Mar 2019 20:00:41 +0300
Message-Id: <20190314170044.4844-1-mohammad.rasim96@gmail.com>
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

