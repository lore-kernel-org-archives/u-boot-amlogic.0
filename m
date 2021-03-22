Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web09.10113.1616404697725957449
 for <u-boot-amlogic@groups.io>;
 Mon, 22 Mar 2021 02:18:18 -0700
Received: by mail-wm1-f44.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso2928136wmq.1
        for <u-boot-amlogic@groups.io>; Mon, 22 Mar 2021 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h7cHnNeVuxm99mWC9y6v/9uTO8W2TCbz/evep+udaiw=;
        b=WoWPx0KyYeYFTbiDgMI6yaKvOqVnhN/3bcGLJQH6/Z/zM995oj/NwMwYqo1WpImfbB
         GMuaFR2QpyxGmF+4rBjQLin6daqklL++HG48Rl8A1UBVQs4KXyiRIEKej90MvakH7HBj
         B0YVauSKbLoDZ9gSUV27sX3WPwi6YxTYhDBPqeGIO0C02CZe1GGCtMUSdr7wbm6YTSiU
         qF2nWYyy8CsS8B+lK0A6lGBioEm1MUtYvW4b1BaDwUg3apQC37Vi09cbGns4muIud01u
         LVYcXiWL19aNqy3W0MBSE42paeAn2uVQGchbVd4ThvFwPkMB9jHSiV8ChbHNv7wcTD4C
         7/Eg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH RFT 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Date: Mon, 22 Mar 2021 10:18:08 +0100
Message-Id: <20210322091812.2511462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: lokeshvutla@ti.com, nsekhar@ti.com, shawn.lin@rock-chips.com
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.

This introduce a "common" DW PCIe helpers file with common code merged from the
dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.

The following changes will switch the dw_ti and dw_rockchip, and introduce a new
driver to support the Amlogic AXG & G12 SoCs using these new common helpers.

The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
on hardware to validate nothing has been broken.

Neil Armstrong (4):
  pci: add common Designware PCIe functions
  pci: pcie_dw_ti: migrate to common Designware PCIe functions
  pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
  pci: add Amlogic Meson Designware PCIe controller

 drivers/pci/Kconfig            |  15 +-
 drivers/pci/Makefile           |   2 +
 drivers/pci/pcie_dw_common.c   | 352 ++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h   | 153 +++++++++++
 drivers/pci/pcie_dw_meson.c    | 459 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
 drivers/pci/pcie_dw_ti.c       | 444 +++----------------------------
 7 files changed, 1046 insertions(+), 851 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_common.c
 create mode 100644 drivers/pci/pcie_dw_common.h
 create mode 100644 drivers/pci/pcie_dw_meson.c

-- 
2.25.1

