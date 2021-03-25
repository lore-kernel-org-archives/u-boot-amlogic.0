Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.269.1616683775719982696
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Mar 2021 07:49:36 -0700
Received: by mail-wr1-f46.google.com with SMTP id x16so2568160wrn.4
        for <u-boot-amlogic@groups.io>; Thu, 25 Mar 2021 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zTFJYQW1c3YdCCh30wj2urANPakC0tY8Q3lX/mMpBOs=;
        b=ayW0AiFxnJHq7L1a3aeIZroc7HFJ/iV18eepNxkGgFHRlMWnkOmDp+y+IDs0mdJCEm
         yE694NFRbLFcFTiV50jALAP4n90vnPwWLpZN9Ea8H6ZJKxjCtUL48N7zlhV8Nqn8fjgY
         FZlEhFStNh/pe42WpSPrEE8uGWafWDY+jLG97GZUgsR6snHKOQzPnNmK+Z2M8n2woRC1
         DGJA9fl9UifeMdMh8CHpVLHGov+xVbcw2pQ5u/r1WVE40RCHu8ZImogSXuGlfJa+oHs5
         kD9JP1FLh3suYXpYR1DRb5xlLdRsBqYBrPa54Cs34b0dalScSV1VL0FgoThl+mmTxrsF
         +MZw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Date: Thu, 25 Mar 2021 15:49:17 +0100
Message-Id: <20210325144921.1791892-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: lokeshvutla@ti.com, nsekhar@ti.com, shawn.lin@rock-chips.com, bmeng.cn@gmail.com, green.wan@sifive.com
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

Changes since v1:
- added prefetch memory region support
- switched to __iomem
- fixed circular dependency for PCI_KEYSTONE

Neil Armstrong (4):
  pci: add common Designware PCIe functions
  pci: pcie_dw_ti: migrate to common Designware PCIe functions
  pci: pcie_dw_rockchip: migrate to common Designware PCIe functions
  pci: add Amlogic Meson Designware PCIe controller

 drivers/pci/Kconfig            |  16 +-
 drivers/pci/Makefile           |   2 +
 drivers/pci/pcie_dw_common.c   | 366 +++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h   | 155 +++++++++++
 drivers/pci/pcie_dw_meson.c    | 459 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_rockchip.c | 472 ++-------------------------------
 drivers/pci/pcie_dw_ti.c       | 444 +++----------------------------
 7 files changed, 1062 insertions(+), 852 deletions(-)
 create mode 100644 drivers/pci/pcie_dw_common.c
 create mode 100644 drivers/pci/pcie_dw_common.h
 create mode 100644 drivers/pci/pcie_dw_meson.c

-- 
2.25.1

