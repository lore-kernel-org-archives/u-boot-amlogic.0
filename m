Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.64505.1695657149587346971
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Sep 2023 08:52:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CB2EF100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1695657145;
	bh=2ZwGbKmZIK+fveFyEWFzFRJ0ThWqr+rdOlUFJviTCpM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rUsw83rQtP3VEZgfO+aoz3ZhLcJyIi+CdTyES4gXjBQPbwv4jzed67Tcvc5ONR48T
	 lsNfV3CeHGV7k9CMb2Az1wJj4JeHf4ibGR+ck7P0Ftgql3q0XwnCasg5TouNgsli4a
	 NkYewRdzNQ05kr9Kp8iboSk4JH6ugAnGY78f1kviHfT2Z4CsbpdkMfjpu8ZdWEzifE
	 3VRSf+Iio6gyOA4V3dr7LaZKWn7MRCiMCKHFY/P5udQkjYJxnel5a/umowaF++TpUV
	 z1POYC9ojEN7Si01C5apbnVzeOjyHQkKQYeLdxAojk9SXCYbyxuibyjnksBToP0A/4
	 YhwSBzQwIUNPQ==
From: "Igor Prusov" <ivprusov@salutedevices.com>
Subject: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Date: Mon, 25 Sep 2023 18:52:07 +0300
Message-ID: <20230925155209.130671-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This series adds dt-bindings and driver implementation for Amlogic A1
PLL and Peripherals clock controllers.

V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevice=
s.com/

V1 -> V2:
 - Add more verbose comments for driver

Igor Prusov (2):
  dt-bindings: clock: Add Amlogic A1 clock bindings
  clk: Add clock driver for Amlogic A1

 arch/arm/include/asm/arch-meson/clock-a1.h    |  23 +
 drivers/clk/meson/Kconfig                     |   8 +
 drivers/clk/meson/Makefile                    |   1 +
 drivers/clk/meson/a1.c                        | 723 ++++++++++++++++++
 .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++
 .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +
 6 files changed, 948 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
 create mode 100644 drivers/clk/meson/a1.c
 create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h

--=20
2.34.1

