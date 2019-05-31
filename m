Received: by mail-wm1-f44.google.com with SMTP id z23so5321088wma.4
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=ynl2y417vzOJlgllWxTA4S9bUmy6XzMsHpVHXn9+/lw=;
        b=ZHNStCs3Ot+2LDN03Yd/g9wmQkS7zl5R0/guZTEWEzjYwP29rWeXRKlQ37ClNAODos
         zULj1CZZ9pWzhBL/v4Vb+R3gppntcWqp0t1eqiON41wGgJ2vYBJzrR0DHkVGgqztQW5h
         Cnp+Mgbu9M//ARdbP/lapkeww9tVKmLLS1zP/z6tKb9LMhYKp3PFL1LAYvwOj7hyE7ab
         90Oipu+dc/KALfN28yOyKuljUovmyxtahMc+FsF/g2v92J9uGA56GeaDa4oY4SLURaEa
         aFvq8WtALQ/oVA3B12rMASOXdLbsPC/BRw+SF5Gkk4lGw3EKHzzKjfTtGWzmfraMrcdf
         I7Jg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190531
Message-ID: <79cb920d-2608-86c6-f486-c50ada73f33a@baylibre.com>
Date: Fri, 31 May 2019 10:21:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR syncs G12A support (DT, clock, config) to enable full functionalities
with already merged drivers, fixes a bug for internal PHY routing on Amlogic GXL/GXM
soc when chainloading, and finally removes an useless PHY reset on the Q200 board support.

Thanks,
Neil

The following changes since commit e2822ccc2c7c0ba8d7d959a1fa1e6221ed135423:

  Merge branch 'master' of git://git.denx.de/u-boot-tegra (2019-05-29 07:28:40 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190531

for you to fetch changes up to d0b1f72a04e49cb2abfac5c4e13696eabc125132:

  configs: u200: enable support for USB Host & Gadget (2019-05-31 10:09:41 +0200)

----------------------------------------------------------------
- Sync DT with Linux 5.2-rc1 for G12A
- Add USB clock support that was introduced in 5.2-rc1 bindings
- Add currently in-review for Linux eMMC & USB DT for G12A in -u-boot.dtsi
- Fix PHY routing to external PHY when chainloading from a misconfigred bootloader
- Remove useless PHY GPIO reset from q200 board file
- Enable USB support for Amlogic U200 reference board

----------------------------------------------------------------
Neil Armstrong (6):
      ARM: dts: sync Amlogic G12A DT with Linux 5.2-rc1
      clk: meson-g12a: Add PCIE PLL support
      ARM: dts: Add missing DT for Meson G12A support
      ARM: meson-gx: Reset GXL/GXM to external PHY when not using internal PHY
      boards: amlogic-g200: remove phy reset
      configs: u200: enable support for USB Host & Gadget

 arch/arm/dts/meson-g12a-u-boot.dtsi                | 216 ++++++++++
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi           |  63 +++
 arch/arm/dts/meson-g12a-u200.dts                   | 147 +++++++
 arch/arm/dts/meson-g12a.dtsi                       | 465 +++++++++++++++++++++
 arch/arm/mach-meson/board-gx.c                     |  17 +-
 board/amlogic/q200/q200.c                          |   6 -
 configs/u200_defconfig                             |  17 +
 drivers/clk/meson/g12a.c                           | 103 +++++
 include/dt-bindings/clock/g12a-aoclkc.h            |   2 +
 include/dt-bindings/clock/g12a-clkc.h              |   5 +
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |   5 +-
 11 files changed, 1034 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
