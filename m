Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.4936.1617868252275785936
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Apr 2021 00:50:52 -0700
Received: by mail-wr1-f42.google.com with SMTP id i18so1036436wrm.5
        for <u-boot-amlogic@groups.io>; Thu, 08 Apr 2021 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPzwK4r4YeKXcIsvlQaAXJPT5ldS52xtjO38xWtsBhQ=;
        b=QB77ZC1l9eYO2kaVuXq6/kfAwFxU2iEJZSCNPYXF+0t6jtkcQSrJQXs6rms+KiiuJX
         SarF5u3qIFWFN2F+cpEtwUaQWL2LD+7ZsaCJhMa/FmEy+Jdt0+ljGvch3cLrAN13/gRj
         vDVEXKYzWQimdoHsOltEWGjct1exjVvvd++7Z/hbDdBpF7RvxjVOBVlWdXVvwMrx3rCB
         aBwa5syzyjgQm2cy36aH8obg8u0tUexQvJONmp4OY/KG+VhEJ/9M3IeZFd2bAMjps8br
         Yk/5xhJlemiJ14FMBqPOu+oU3q4cK4neN9RCIgE8NQKqHGigxZcySqF8GYf9J4TuqeeX
         rvWw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/5] ARM: khadas-vim3: enable PCIe and NVMe
Date: Thu,  8 Apr 2021 09:50:42 +0200
Message-Id: <20210408075047.4076954-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This adds the missing bits to enable PCIe and NVMe support in U-Boot for
the Khadas VIM3 & VIM3L board.

This serie depends on [1].

[1] https://patchwork.ozlabs.org/project/uboot/cover/20210325144921.1791892-1-narmstrong@baylibre.com/

Neil Armstrong (5):
  clk: meson-g12a: add PCIe gates
  phy: meson-g12a-usb3-pcie: add support for PCIe ops
  arm: dts: meson-khadas-vim3: enable PCIe in U-boot
  configs: khadas-vim3: enable PCIe and NVMe
  configs: meson64: add NVME boot target

 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi |  4 ++
 configs/khadas-vim3_defconfig              |  5 ++
 configs/khadas-vim3l_defconfig             |  5 ++
 drivers/clk/meson/g12a.c                   |  2 +
 drivers/phy/meson-g12a-usb3-pcie.c         | 81 ++++++++++++++++++++--
 include/configs/meson64.h                  |  7 ++
 6 files changed, 100 insertions(+), 4 deletions(-)

-- 
2.25.1

