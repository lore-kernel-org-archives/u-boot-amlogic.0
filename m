Received: by mail-wm1-f66.google.com with SMTP id t124so13303711wma.4
        for <u-boot-amlogic@groups.io>; Tue, 26 Mar 2019 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i956hLeRMBcMAp7u0yfDNxHU0oLRtOL7OWgMd6HkPbY=;
        b=DHF1CcRruJluXX502pqjqNCPP1AVNYADuC1Zg8SFc2XYhCZv2x/N30pon88bQ8QHBJ
         1AEFOqzfZPBYpICfBLXzk0jU+wN0clSUMIoVqRlNiQbELpJd/WM72q1++efN5qIJY4mm
         D4VpwpEe91bOH4urvByP7iq7Y3FYZjcURJBECISZNXy1SBa17E+BRtDT71CaniDbuU7L
         JEPwmeJbSjSalvHneBfiNTxFe48ijDx7r3olp/TLUMPuxDjZyPtxlK/mjMexVrafQgRl
         fDvuZgyu9bVlQk9VjAXrkmTappvVufsQhiPEyIO1WTpQE3A5giuuqsIxOdHmtaiw6SuY
         JSjQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] ARM: meson: Add G12A USB Support
Date: Tue, 26 Mar 2019 16:15:34 +0100
Message-Id: <20190326151537.23118-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for USB on Amlogic G12A SoCs.

This patchset is composed with :
- PHY Drivers
- USB Control Glue driver
- G12A board setup for Device mode

Device Tree nodes will be added in a separate patchset when applied
on a tagged Linux tree.

The Amlogic G12A USB Complex is composed of :
- 2 USB Controllers :
 * DWC3 for USB2 and USB3 Host functionality
 * DWC2 for USB2 Peripheral functionality
- 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
- 1 USB3 PHY shared with PCIE funcionnality
- A Glue to control PHY routing, setup and OTG detection

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

This drivers supports the on-probe setup of the OTG mode, and manually
via a setup function in the G12A common board code. 

Neil Armstrong (3):
  usb: dwc3: Add Meson G12A USB Glue
  phy: meson: add Amlogic G12A USB2 and USB3+PCIE PHY drivers
  mach-meson: g12a: add DWC2 peripheral mode support

 arch/arm/include/asm/arch-meson/usb.h |  12 +
 arch/arm/mach-meson/board-g12a.c      | 126 +++++++
 drivers/phy/Kconfig                   |   8 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/meson-g12a-usb2.c         | 216 ++++++++++++
 drivers/phy/meson-g12a-usb3-pcie.c    | 345 +++++++++++++++++++
 drivers/usb/dwc3/Kconfig              |   8 +
 drivers/usb/dwc3/Makefile             |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c    | 456 ++++++++++++++++++++++++++
 9 files changed, 1173 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/usb.h
 create mode 100644 drivers/phy/meson-g12a-usb2.c
 create mode 100644 drivers/phy/meson-g12a-usb3-pcie.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

-- 
2.21.0

