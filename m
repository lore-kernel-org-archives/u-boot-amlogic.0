Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.4849.1612961696746508251
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Feb 2021 04:54:57 -0800
Received: by mail-wr1-f52.google.com with SMTP id v14so2397641wro.7
        for <u-boot-amlogic@groups.io>; Wed, 10 Feb 2021 04:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=V9a9s7JJyiFyx9ciGkE3saFB+NDIg2c2Wboin7Yx3As=;
        b=H0y6RgAOFoR3rNL9bh7XKg01PVHUAY5vMZw0oHaGWb9mtNX5UXvFLNdqvNjjfn3UdH
         FZ7ychH6SU/5dV/neb959wyy5RbdMni1E7UvgDWGI39cCxlAa4Tp35Sdt9Lha87SGPHN
         aTe/jy7r1wh/A3uFABoeoy30z8oWh0GcRsqQ8IYXichFKQkAiloHgyr7MUSrV84FnBY1
         LlqB/LuI9AxU7xgLLc5LWadZ4s0pgoV2wPtyrmNPC8I5zooJXnnyrY4D4NJn/Ib6Yv11
         mv6BzRHDrsrGJnbiEWuJ2DFRfLhi4spnVlJ7uLqgSulA+2zQKly6h/MnvOGZGSE3nXat
         DfKA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210210
Reply-To: narmstrong@baylibre.com
Message-ID: <fbdafedd-9625-1a50-ed83-b5649fa08a7e@baylibre.com>
Date: Wed, 10 Feb 2021 13:54:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

These changes adds the plumbing to support MIPI D-PHYs, including the timings helpers from
Linux, the AXG Analog and Digital D-PHY drivers. Finally automatic detection of model is added
for the HardKernel Odroid N2 & C4 families.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/6346

Thanks,
Neil

The following changes since commit e14d5762de1db84cae6d84d59c1e40f3eb26c4c3:

  Merge git://git.denx.de/u-boot-marvell (2021-02-08 10:55:51 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210210

for you to fetch changes up to 8bc780106c1399bd263c4283a8747889a613ca5d:

  board: amlogic: odroid: add runtime detection of the N2/N2+/C4/HC4 variants (2021-02-10 10:00:51 +0100)

----------------------------------------------------------------
- Add configuration helpers for MIPI D-PHY
- generic-phy: add configure op
- Add Amlogic AXG MIPI D-PHY driver & MIPI PCIe Analog PHY driver
- odroid: add runtime detection of the N2/N2+/C4/HC4 variants

----------------------------------------------------------------
Marek Szyprowski (1):
      board: amlogic: odroid: add runtime detection of the N2/N2+/C4/HC4 variants

Neil Armstrong (4):
      phy: dphy: Add configuration helpers
      generic-phy: add configure op
      phy: Add Amlogic AXG MIPI D-PHY driver
      phy: Add Amlogic AXG MIPI PCIe Analog PHY driver

 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |   6 +
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |   6 +
 board/amlogic/odroid-n2/odroid-n2.c           |  80 ++++++
 configs/odroid-c4_defconfig                   |   4 +-
 configs/odroid-n2_defconfig                   |   4 +-
 drivers/phy/Kconfig                           |  23 ++
 drivers/phy/Makefile                          |   3 +
 drivers/phy/meson-axg-mipi-dphy.c             | 393 ++++++++++++++++++++++++++
 drivers/phy/meson-axg-mipi-pcie-analog.c      | 233 +++++++++++++++
 drivers/phy/phy-core-mipi-dphy.c              | 161 +++++++++++
 drivers/phy/phy-uclass.c                      |  11 +
 include/generic-phy.h                         |  23 ++
 include/phy-mipi-dphy.h                       | 284 +++++++++++++++++++
 13 files changed, 1229 insertions(+), 2 deletions(-)
 create mode 100644 drivers/phy/meson-axg-mipi-dphy.c
 create mode 100644 drivers/phy/meson-axg-mipi-pcie-analog.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 include/phy-mipi-dphy.h
