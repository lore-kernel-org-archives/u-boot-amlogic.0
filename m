Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.106039.1696332530598238217
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 04:28:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C96A1120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696332525;
	bh=Yvd+CKPMs6O6ncjOg65VrHCqjzGUyCaE29/EZthVP2M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rYoVvvnxdHy3PThHH8hvX9jQlIgW77WFRQqoXXhMkWxLdlFzuy4Br/VNNI139zULQ
	 UIRbWWnytyx+siMJYstUlyJw5bUNfwRioMqc4Z+RETCl+1Z7FU2lYwq+mdYnCj+RKl
	 DVa34nz2g/Q/HvoXcG+MAARhejvJFwPXpki6qc94afw1ddHEJVrGT1RXDDBdbr/AD5
	 lFT3+AGX/96PL0DbGbo9W+PTmQIz4JKt0LMNoajyOj0Svn+95hB74CDtJnL+ye4haf
	 VIQXHAuAm1pqxnEmeVcJFlTb/trsXThNSLqQTKv0KiU4ujKGIejGs3pOA2V8YdA6cQ
	 lgY+UcahmTQmg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/8] Support USB for Meson A1
Date: Tue, 3 Oct 2023 14:28:26 +0300
Message-ID: <20231003112838.41503-1-avromanov@salutedevices.com>
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

V2:

- Made power domain for PHY optional.
- Add missing CLKID_USB_PHY gate.
- Drop patch with USB stack initialization in board-a1.c.
Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
- Support A1 in g12a_child_pre_probe/post_remove functions
in dwc3 driver.


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
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
 .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
 7 files changed, 403 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

--=20
2.25.1

