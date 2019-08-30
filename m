Received: by mail-wm1-f65.google.com with SMTP id d16so7203634wme.2
        for <u-boot-amlogic@groups.io>; Fri, 30 Aug 2019 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LY0MYYXVVV2+jvUCJZ/HLDZZF0AkdDfWki7QQDqV1d8=;
        b=MDsoFRCwNrCr60IBXpaMBPvc4H6OdRbY5rHwn6TuVBr3YwtH8s8JB+Oqja4ePB9oZi
         65jF01dsXdaSAemcFVsADd76zj7pdZwfk2zzOox9rc5iOAdT9RB5UtpVCaI+J7BCZGGX
         AQTXP3t/WagZHLxXlewiHP4OSO8ofjQ72G0hH2yStjaZBnPOL3bY0BpUsmbMFRlOEJGW
         98LO7trdhPoQ7hxdAETlUCpWOO/9hZzXQJDlbbvjxAWSsdDSEypFAQDSI0l+th2b5geD
         pGMJusvKdYbRYFuGBnX1SPgwtqh8QER2bjJW7+goQk8Z7Li5OzSlyBhXvXTBg+eaXA9I
         04Pg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/8] arm: meson: add Video support for G12A and SEI510 board
Date: Fri, 30 Aug 2019 14:09:20 +0200
Message-Id: <20190830120928.23890-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, agust@denx.de, jh80.chung@samsung.com, lukma@denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

This patchset adds Amlogic G12A support for HDMI & Composite video output like
the Amlogic GXBB/GXL/GXM, by syncing from the latest Linux VPU DRM driver.

It also adds VPU/VAPB/HDMI Clock & VPU Power Domain support.

Finally it adds the necessary config to show a logo from a fastboot flashed
partition on the SEI510 board.

U200 and Odroid-N2 config support will be added later.

Neil Armstrong (8):
  power: domain: meson-gx-pwrc: add G12A support
  clk: meson: g12a: add support for VPU/HDMI clocks
  video: meson: remove power domain get
  video: meson: sync with linux drm-misc tree
  video: meson: add compatible for Amlogic G12A
  arm: meson: board-g12a: Setup VPU in fdt
  ARM: dts: meson-g12a: add U-Boot specific DT for graphics
  configs: sei510: enable Video Display support

 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi    |   7 +
 arch/arm/dts/meson-g12a-u-boot.dtsi           |  29 +
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |   7 +
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi |   7 +
 arch/arm/mach-meson/board-g12a.c              |   5 +
 configs/sei510_defconfig                      |  11 +
 drivers/clk/meson/g12a.c                      | 620 +++++++++++++++++-
 drivers/power/domain/meson-gx-pwrc-vpu.c      | 155 ++++-
 drivers/video/meson/meson_dw_hdmi.c           |  61 +-
 drivers/video/meson/meson_plane.c             |  47 +-
 drivers/video/meson/meson_registers.h         | 373 ++++++++++-
 drivers/video/meson/meson_vclk.c              | 233 +++++--
 drivers/video/meson/meson_venc.c              | 169 ++++-
 drivers/video/meson/meson_vpu.c               |  11 +-
 drivers/video/meson/meson_vpu.h               |   2 +
 drivers/video/meson/meson_vpu_init.c          | 205 ++++--
 include/configs/sei510.h                      |  12 +
 17 files changed, 1757 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12a-sei510-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi

-- 
2.22.0

