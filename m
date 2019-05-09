Received: by mail-wm1-f65.google.com with SMTP id y5so2056377wma.2
        for <u-boot-amlogic@groups.io>; Thu, 09 May 2019 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=/72yLS1KF5/NNM1OEulMqkavCe1Phx35Sh7vJHT7bvI=;
        b=c7+ao7M01wysZXFJ1bPqWvK4q+vFXNvlg3MdUAnqVauFLtQi6wB2tMBL4sGGNvxlQy
         qEjxOd/GWJi3RCveVJ2Hu++aV2Dtuk8eXmcAlHt9iH23oFfHnJocvlVpFYQwh6LOHbnS
         WPrmBEe3T78MN7yRnN4TkklwzfwkBX3yIs4wKI7fDBndgCGrA0GCz/sWSmxO20CMB4lJ
         Bn1q40f5Wa96gJknmj6srtAtg2aecqkxXwvMW/LWpBZO3VbA6q4VbkDrIDXYZSE0Jk+p
         3LegCmAQsEkA63aXeDCB/w2geitsxwZUJiTpJI8e8d1QTSpu3DP1sOjcGUi8Ej9V6Zkd
         bVgA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190509
Message-ID: <bcaf6efe-d6db-8f57-6ad3-50d9bd0b11ec@baylibre.com>
Date: Thu, 9 May 2019 10:42:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR add support for USB on Amlogic G12A, Marek and Lukasz acked me for
sending these patches via the amlogic u-boot tree.

Thanks,
Neil

The following changes since commit 504bf790da08db9b4a443566cf6ef577f9c7996a:

  Merge branch 'master' of git://git.denx.de/u-boot-sunxi (2019-05-08 16:21:43 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190509

for you to fetch changes up to 92d911b2eedec8fee1f494ab961585e253351d4f:

  mach-meson: g12a: add DWC2 peripheral mode support (2019-05-09 10:38:32 +0200)

----------------------------------------------------------------
- Add USB PHY drivers for Amlogic G12A
- Add USB Complex Glue driver for Amlogic G12A
- Add USB Gadget support for Amlogic G12A

----------------------------------------------------------------
Neil Armstrong (3):
      usb: dwc3: Add Meson G12A USB Glue
      phy: meson: add Amlogic G12A USB2 and USB3+PCIE PHY drivers
      mach-meson: g12a: add DWC2 peripheral mode support

 arch/arm/include/asm/arch-meson/usb.h |  12 +
 arch/arm/mach-meson/board-g12a.c      | 126 ++++++++++
 drivers/phy/Kconfig                   |   8 +
 drivers/phy/Makefile                  |   1 +
 drivers/phy/meson-g12a-usb2.c         | 216 ++++++++++++++++
 drivers/phy/meson-g12a-usb3-pcie.c    | 345 +++++++++++++++++++++++++
 drivers/usb/dwc3/Kconfig              |   8 +
 drivers/usb/dwc3/Makefile             |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c    | 456 ++++++++++++++++++++++++++++++++++
 9 files changed, 1173 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-meson/usb.h
 create mode 100644 drivers/phy/meson-g12a-usb2.c
 create mode 100644 drivers/phy/meson-g12a-usb3-pcie.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
