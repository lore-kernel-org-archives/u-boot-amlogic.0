Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.26258.1683291416762427383
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:56:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=oJlJ3ivZ5JD2wrnuFhTTwmeA3OqSGEE3zbex3EOvj5c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZSI9Nh/vnaSQY3eXha3N/B+en1L3n2VwYHMCX34R0XNLGbmRdpGpGxelG4BOBgVqu
	 8pnWSkqlU2wKteMOgntarHUHhVqeky3uU3HLL8gXEnxHGVi7tFY2t0s2Dhcr3sdrDA
	 sxwUp9v40CQ4cHRailozj6U0gPH1fSDARi3QpKY3A3M2jsBYhAJaVFs6Gl1nXvrHQi
	 PjaxYuqr1wKHspNCJCBghnzTlOge3U7aa1+WnjWW9QmYHuqzzcZJrD8qRC7TQutOca
	 +PKbQvuYkVqzRA3gn2KiOF4u7BPG3HXExCBPzSBJtnEX0TbzPZrTinUDfHeiE9jXX/
	 18yQ/BMWEa+yQ==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 0/5] Amlogic A1 SoC Family Support
Date: Fri, 5 May 2023 15:56:34 +0300
Message-ID: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This patch series adds basic support for Amlogic AD401 development board
based on Amlogic A1 SoC family

Changelog:
 v1 -> v2:
 - Add MAINTAINERS for new board instead of using one in the repo root

Igor Prusov (5):
  ARM: dts: Add Amlogic Meson A1 DT from Linux 6.3-rc7
  ARM: dts: sync meson-a1-ad401 from Linux 6.3-rc7
  ARM: meson: add A1 support
  pinctrl: meson: add pinctrl driver for Amlogic A1
  board: amlogic: add support for AD401 board

 arch/arm/dts/Makefile                    |   1 +
 arch/arm/dts/meson-a1-ad401.dts          |  30 +
 arch/arm/dts/meson-a1.dtsi               | 161 +++++
 arch/arm/include/asm/arch-meson/a1.h     |  20 +
 arch/arm/mach-meson/Kconfig              |   7 +
 arch/arm/mach-meson/Makefile             |   1 +
 arch/arm/mach-meson/board-a1.c           |  59 ++
 board/amlogic/ad401/MAINTAINERS          |   6 +
 board/amlogic/ad401/Makefile             |   4 +
 board/amlogic/ad401/ad401.c              |  15 +
 configs/ad401_defconfig                  |  54 ++
 drivers/pinctrl/meson/Kconfig            |   4 +
 drivers/pinctrl/meson/Makefile           |   1 +
 drivers/pinctrl/meson/pinctrl-meson-a1.c | 867 +++++++++++++++++++++++
 include/configs/meson64.h                |   3 +
 include/dt-bindings/gpio/meson-a1-gpio.h |  73 ++
 16 files changed, 1306 insertions(+)
 create mode 100644 arch/arm/dts/meson-a1-ad401.dts
 create mode 100644 arch/arm/dts/meson-a1.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/a1.h
 create mode 100644 arch/arm/mach-meson/board-a1.c
 create mode 100644 board/amlogic/ad401/MAINTAINERS
 create mode 100644 board/amlogic/ad401/Makefile
 create mode 100644 board/amlogic/ad401/ad401.c
 create mode 100644 configs/ad401_defconfig
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-a1.c
 create mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h

--=20
2.34.1

