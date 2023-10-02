Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.87627.1696265948522393435
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8AAD2120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265944;
	bh=a05rhRH6lRb/b8LFTBK4OtmGi5eSDSw0jUUnpNO1BUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=VmaOZAyfMaQ8VlAX9b9xtqsjp1GSoCBmtKV50vSjOD8m0kxELmPjzbao5YWOPviwZ
	 5IqO9WsD5bQWTaRHrRPsNJX0gTwJH1J/Sa4cZlyWH0zrvaNzYyoYbOnLnrHCRYOJFI
	 hE+fZDOyxVE1hQvOilgGcowuUIstQY1DTNBWcY3alX8gonQUlilgDV6EPx3ZHAZmpB
	 Pj4WpHPjsl4mKsj78QoMKLEuuJKT4+TVqqjSwXO0bPra8mwTzyCVkBXRP/xOX4xv9q
	 aQ2HHEiy0LELXkMI1TSfLFY3sgin1Pbt0hrm4Yfddhds1Aow4JSyhZsWfEbSI+utLQ
	 Hjg8JVjpp3V6w==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 0/8] Support USB for Meson A1
Date: Mon, 2 Oct 2023 19:58:44 +0300
Message-ID: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Hello!

This patchset adds USB stack support for Amlogic A1 SoC's
series. Made reset / phy / dwc3 drivers more flexible and
added support for A1 board.

Alexey Romanov (7):
  dt-bindings: reset: add Meson A1 reset bindings
  reset: add support for Amlogic A1 family
  phy: get rid of raw hex values
  phy: move clk enable/disable in init/exit
  phy: support Amlogic A1 family
  dwc3: add support for Amlogic A1 family
  arch: a1: introduce USB initialization functionality

Igor Prusov (1):
  a1: clk: Add missing CLKID_USB_PHY_IN gate

 arch/arm/mach-meson/board-a1.c                |  89 +++++++
 drivers/clk/meson/a1.c                        |   3 +
 drivers/phy/Kconfig                           |   2 +-
 drivers/phy/meson-g12a-usb2.c                 | 233 ++++++++++++++++--
 drivers/reset/reset-meson.c                   |  42 +++-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
 .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
 7 files changed, 484 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

--=20
2.25.1

