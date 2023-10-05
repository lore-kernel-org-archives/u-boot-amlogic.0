Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.11082.1696496091411325561
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2EC2D120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496085;
	bh=lCf9AZRC7ntp/ff+WquINbBXOJABoWti1v17T5MmIwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Jwe+JjQ5GntusMVosiOIcOIGw3p/EBjxj6wmdsk/YP560FOIxhftMxBRnwpL9Jmzo
	 A3+qlid8ll4PZcDLWrBfBa0ewjgKwqN1XJwvzNCOH7jxThYXYuAHOeGjEHQ7Gdlp49
	 p1j1uCrhzgzXdvBFydBgKyx/iqLpYYsqgj3HcxYZsVhVDGqYj1LwGMiONCiZibTY0G
	 s+A6/WS1EFlJrEqW3wEQ2s1LxhJIWXnK9dMhIstAKnOw5KXqAmKLhftGnjj8KaVJe8
	 jbDQNDUiHdCBMl5Eed/FQJJByHbpsIy3gCvgZGthbFGfKMIpoOEv9rGPK9kSMTpzD7
	 vQ3ONDbvx8aQA==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 0/8] Support USB for Meson A1
Date: Thu, 5 Oct 2023 11:54:21 +0300
Message-ID: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Hello!

This patchset adds USB stack support for Amlogic A1 SoC's
series. Made reset / phy / dwc3 drivers more flexible and
added support for A1 board.

V2:

- Made power domain for PHY optional.
- Add missing CLKID_USB_PHY gate.
- Drop patch with USB stack initialization in board-a1.c.
Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
- Support A1 in g12a_child_pre_probe/post_remove functions
in dwc3 driver.

V3:

- Rebased over latests Amlogic U-Boot branch.

Alexey Romanov (7):
  dt-bindings: reset: add Meson A1 reset bindings
  reset: add support for Amlogic A1 family
  phy: get rid of raw hex values
  phy: move clk enable/disable in init/exit
  phy: support Amlogic A1 family
  dwc3: add support for Amlogic A1 family
  ad401: enable USB stack

Igor Prusov (1):
  a1: clk: Add missing USB_PHY_IN and USB_PHY gates

 configs/ad401_defconfig                       |   3 +
 drivers/clk/meson/a1.c                        |   6 +
 drivers/phy/Kconfig                           |   2 +-
 drivers/phy/meson-g12a-usb2.c                 | 235 ++++++++++++++++--
 drivers/reset/reset-meson.c                   |  42 +++-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  79 +++++-
 .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
 7 files changed, 409 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

--=20
2.25.1

