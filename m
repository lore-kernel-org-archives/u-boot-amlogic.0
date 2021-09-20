Received: from mx.msync.work (mx.msync.work [95.217.65.204])
 by mx.groups.io with SMTP id smtpd.web09.9058.1632127224521701546
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 01:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1632127221; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=13K11jIsfC3hv2KUcvtPGPXhRak47xzQ9t5seCBra3U=;
	b=PDYiED/beHeJ/vh1U6vZyD9qgOh8KLYtWkzmilrRbo2iix0IxL3Xujm/vfdra7Df3TsIB4
	2v38ic6Muktj3E2TAYomYUXLfb/j1QCWSWXcGvjeC/pBpAPEZENgnzhN2p9Kvx0fH2zcXy
	5ayvg9BwEttVRMB1q+eOY/9MfB05CZHT2N2NgIchozdxtaEE7hqGSylMYKN1hnXwelNW/X
	Cwa+Zbf+OUJYnDa5cn4yvzQXYify9e787YM62TNg/gHPSRhPCZp0eHTTWFWrqpFyKWijtB
	CWjOnFKZjM/3xlw/51+QCfIgwouF7vNFyyhlDyupm2tOJEN6+OuVeKHEbEe9wg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 0/3] ARM: meson: add support for JetHub D1/H1
Date: Mon, 20 Sep 2021 11:40:13 +0300
Message-Id: <20210920084016.2536084-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add support for new home automation devices manufactured by JetHome.
Patches prepared for use with the "ARM: meson: Sync Amlogic DT from Linux=
 5.14" patch series by Neil Armstrong

JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation cont=
roller with the following features:
- DIN Rail Mounting case
- Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 512Mb/1GB DDR3
- 8/16GB eMMC flash
- 1 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac=
, Bluetooth 4.2.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power=
 and Zigbee 3.0 support.
- 2 x gpio LEDS
- GPIO user Button
- 1 x 1-Wire
- 2 x RS-485
- 4 x dry contact digital GPIO inputs
- 3 x relay GPIO outputs
- DC source with a voltage of 9 to 56 V / Passive POE

JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation cont=
roller with the following features:
- Square plastic case
- Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 1GB DDR3
- 8/16GB eMMC flash
- 2 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power=
 and Zigbee 3.0 support.
- MicroSD 2.x/3.x/4.x DS/HS cards.
- 1 x gpio LED
- ADC user Button
- DC source 5V microUSB with serial console

Changes from v2:
- fix "Alignment should match open parenthesis" in board/amlogic/jethub-j=
80/jethub-j80.c
- add missing files to board/amlogic/jethub-j80/MAINTAINERS
- fix unexpected unindent in doc files

Changes from v1:
- fix BOOT_TARGET_DEVICES in jethub.h (patch 1/3)
- add lore URLs to description (patch 2/3)

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>

Vyacheslav Bocharov (3):
  ARM: amlogic: add JetHub common config header
  ARM: amlogic: add JetHub D1/H1 device support
  ARM: amlogic: add JetHub D1/H1 docs

 arch/arm/dts/Makefile                         |   2 +
 .../arm/dts/meson-axg-jethome-jethub-j100.dts | 361 ++++++++++++++++++
 .../meson-gxl-s905w-jethome-jethub-j80.dts    | 241 ++++++++++++
 board/amlogic/jethub-j80/MAINTAINERS          |   9 +
 board/amlogic/jethub-j80/Makefile             |   6 +
 board/amlogic/jethub-j80/jethub-j80.c         |  68 ++++
 configs/jethub_j100_defconfig                 |  55 +++
 configs/jethub_j80_defconfig                  |  63 +++
 doc/board/amlogic/index.rst                   | 128 ++++---
 doc/board/amlogic/jethub-j100.rst             | 108 ++++++
 doc/board/amlogic/jethub-j80.rst              |  97 +++++
 include/configs/jethub.h                      |  40 ++
 12 files changed, 1115 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
 create mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
 create mode 100644 board/amlogic/jethub-j80/MAINTAINERS
 create mode 100644 board/amlogic/jethub-j80/Makefile
 create mode 100644 board/amlogic/jethub-j80/jethub-j80.c
 create mode 100644 configs/jethub_j100_defconfig
 create mode 100644 configs/jethub_j80_defconfig
 create mode 100644 doc/board/amlogic/jethub-j100.rst
 create mode 100644 doc/board/amlogic/jethub-j80.rst
 create mode 100644 include/configs/jethub.h

--=20
2.30.2

