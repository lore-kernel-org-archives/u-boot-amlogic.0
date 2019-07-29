Received: by mail-wr1-f68.google.com with SMTP id 31so62056696wrm.1
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUB51INKSyIFfyS0NJHGOAjLo+KlQhNb1+VVy0ZPhKU=;
        b=qp6N2ymH78bU+mrCEmTOJGhwqJeUxEtwJbvOptgelWeyHxudmgdaQuBECiUk7VJnPE
         OwYDF7VAwPHAv4HWvR4Qa5f9PfwAvxEdqTdXqvumNKpFNAfm5oJ/L6NGpzqSwYtW7JQG
         G5ANNR/VsEBp0H8ZAoxpRukwalCNHarWLwlmkksx+gZFJYg2fi/gWoiPOl5iJvaJcbyv
         JJ8fvu2Dfw7/EJRWJatfpj/SM0dhkmZLzgz05z8bpSTmP87zwvRUYIaSIarxxXFuacow
         0XXV0QlO9s+/6HkAxZLWj8xr6+jay/LD+JcWoCt4xCiOuksxIQsgozm1pfMoVo0kfjsj
         ODCA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [RESEND PATCH 0/5] amlogic: add support for the SEI Robotic SEI510
Date: Mon, 29 Jul 2019 16:07:46 +0200
Message-Id: <20190729140751.7851-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jbrunet@baylibre.com, glaroque@baylibre.com, khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The SEI510 board is based on the Amlogic S905X2 SoC
from the Amlogic G12A SoC family.

The board has the following specifications :
- Amlogic S905X2 ARM Cortex-A53 quad-core SoC
- XGB DDR4 SDRAM
- 10/100 Ethernet (Internal PHY)
- 1 x USB 3.0 Host
- eMMC
- SDcard
- Infrared receiver
- SDIO WiFi Module

The board default behaviour is for booting Android and triggers
fastboot on recovery or reboot mode.

Jerome Brunet (1):
  boards: meson: add g12a sei510

Neil Armstrong (4):
  ARM: dts: Import Amlogic G12A SEI510 DT from Linux 5.3-rc1
  configs: meson64: permit redefining ENV_SIZE
  ARM: meson: Add support for fastboot_set_reboot_flag()
  configs: sei510: disable PSCI_RESET to support fastboot reboot_flag

 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/meson-g12a-sei510.dts   | 502 +++++++++++++++++++++++++++
 arch/arm/include/asm/arch-meson/sm.h |  18 +
 arch/arm/mach-meson/board-common.c   |  33 ++
 arch/arm/mach-meson/sm.c             | 155 +++++++++
 board/amlogic/sei510/MAINTAINERS     |   5 +
 board/amlogic/sei510/Makefile        |   6 +
 board/amlogic/sei510/README          | 123 +++++++
 board/amlogic/sei510/sei510.c        |  26 ++
 configs/sei510_defconfig             |  75 ++++
 include/configs/meson64.h            |   2 +
 include/configs/sei510.h             | 137 ++++++++
 12 files changed, 1083 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12a-sei510.dts
 create mode 100644 board/amlogic/sei510/MAINTAINERS
 create mode 100644 board/amlogic/sei510/Makefile
 create mode 100644 board/amlogic/sei510/README
 create mode 100644 board/amlogic/sei510/sei510.c
 create mode 100644 configs/sei510_defconfig
 create mode 100644 include/configs/sei510.h

-- 
2.22.0

