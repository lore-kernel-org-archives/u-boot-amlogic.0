Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.9352.1604655001066229532
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:30:01 -0800
Received: by mail-wm1-f66.google.com with SMTP id a65so678153wme.1
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SdHgAs+GHV6MN199yXGdXmlilzG3BQreydUcRXYDlV4=;
        b=V3g47dscZ2OvwMx6PTqOHOGrtnVWKEikVD3wMztHfs5FbGeLtX682lAYyOabRUn7uR
         snl85zS+QZyG+ReqmHdXOidieIC5uIYBk9CeAksGHLsb2ac2jC6zb8lTuWJKxqIYAWPB
         6s74ABCvNqvn6RAmPeHf3O084frT0PcnvkhTZqe71g8OdElX7g13gxau1EUNye7BKtvK
         8gVLty8uiMYS4oii2XbgI/W1FCulK2fnYlFtJaLW5+e6cyBMYKYiB+kfpJKyDA6RqgSJ
         DbtuxA0kUrS1jBmXrZykMx0M+voJJQntUJ+ZtXVxJ9ghOAuyWZHgwoc2wwDREtA1XhFR
         7+cg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] mmc: meson-gx: fix mmc & scard failure on SM1 SoCs
Date: Fri,  6 Nov 2020 10:27:52 +0100
Message-Id: <20201106092755.2250773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Amlogic SM1 SoCs doesn't handle very well high clocks from the DIV2 input
Thus we limit the max freq to 26MHz on SM1 SoCs until we handle higher
frequencies via the first input from a composite clock.

Here 26MHz corresponds to MMC_HS clock speed.

We also add a u-boot only sm1 compatible to distinguish the controller in a new
meson-sm1-u-boot.dtsi and reworks the other -u-boot.dtsi to use this for SM1 based boards.

Finally a TOFIX is added to precise the clock management should use
the clock controller instead of local management with fixed clock rates.

Neil Armstrong (3):
  mmc: meson-gx: move arch header to local header
  mmc: meson-gx: limit max frequency on SM1 SoCs
  ARM: dts: meson-sm1: add u-boot specific MMC controller compatible

 .../meson-g12b-a311d-khadas-vim3-u-boot.dtsi  |  1 +
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi    |  2 --
 .../dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  1 +
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi  |  2 +-
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi     |  2 +-
 arch/arm/dts/meson-sm1-u-boot.dtsi            | 20 +++++++++++++
 drivers/mmc/meson_gx_mmc.c                    | 28 ++++++++++++++++---
 .../sd_emmc.h => drivers/mmc/meson_gx_mmc.h   | 10 ++++---
 8 files changed, 54 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-u-boot.dtsi
 rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (95%)

-- 
2.25.1

