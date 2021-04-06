Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.10952.1617711582971924377
 for <u-boot-amlogic@groups.io>;
 Tue, 06 Apr 2021 05:19:43 -0700
Received: by mail-wm1-f47.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so966002wma.0
        for <u-boot-amlogic@groups.io>; Tue, 06 Apr 2021 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9iLK4JysqlI4AMBFG99GFX0ZMln6Xz+5Aw5ksXr0ZzY=;
        b=QjRatxLyVL7pyELyBy3qJU9l/GKeWI/3tCOJSojc00Rrn4U40cXJq/kKB4D80zYdk3
         N7W83MN1aWVANpSIZ7RzctB/V1WCXPrpSXyC0uYfa2yQKrQI0yo2VPfQtY8d09GiWUCu
         vtC5T/gcaO0Ewqpv3uea6jwOjxjOzlhupREr6uqPU//xFtIrH88UPMqkEVGyhkD035E8
         azQW7+lfjaiK6oytKwiL5AKZxE/tkFylfOxpkaNbMQII/500Y+s+6xDD9H283qP6h++6
         X/dF3azNo4rW1Q4TLigX4Vral5uSrsQ4HiY8sW33eIX6NtE3F2Qnb/eDS9RMwTV0m3Gn
         A7Eg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210406
Reply-To: narmstrong@baylibre.com
Message-ID: <f67d9f94-3bc2-5ee0-a709-48a2ef0fbe3c@baylibre.com>
Date: Tue, 6 Apr 2021 14:19:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Let's start this new version with finally all changes to remove static ethernet MAC & PHY
setup for Amlogic SoCs, with DM_MDIO to support MDIO mux driver and a proper designware
Glue driver. And finally it removes a whole bunch of ugly static code, yay !

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/7021

Thanks,
Neil
The following changes since commit 90eba245a66aa20589404ba537215faf2012c1a3:

  Merge branch 'next' (2021-04-05 11:29:57 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210406

for you to fetch changes up to 2fbd37001c77f0b78d43c578d8e350a6afa27e24:

  arm: meson: remove static ethernet link setup (2021-04-06 11:10:29 +0200)

----------------------------------------------------------------
- Add MMIO MDIO mux driver
- Add Amlogic G12A MDIO mux driver
- Add DM_MDIO support for designware ethernet driver
- Add Amlogic Meson8b and later designware ethernet glue driver
- Switch all amlogic boards to Amlogic designware ethernet glue driver
- Switch all amlogic boards to DM_MDIO when necessary
- Remove all static ethernet setup code

----------------------------------------------------------------
Neil Armstrong (11):
      net: add MMIO Register MDIO MUX driver
      net: designware: add DM_MDIO support
      net: add Amlogic Meson G12A MDIO MUX driver
      net: designware: add Amlogic Meson8b & later glue driver
      configs: update Amlogic Meson GXL & GXM config for MDIO MUX
      configs: update Amlogic Meson G12A, G12B & SM1 configs for MDIO MUX
      arm: meson: remove static MDIO mux handling
      configs: meson: use Designware glue driver for Amlogic Meson8b & later SoCs
      net: designware: remove amlogic compatibles
      arm: meson: remove static ethernet memory power domain enable
      arm: meson: remove static ethernet link setup

 arch/arm/include/asm/arch-meson/axg.h       |  22 ----
 arch/arm/include/asm/arch-meson/eth.h       |  12 ---
 arch/arm/include/asm/arch-meson/g12a.h      |  35 -------
 arch/arm/include/asm/arch-meson/gx.h        |  20 ----
 arch/arm/mach-meson/board-axg.c             |  34 -------
 arch/arm/mach-meson/board-g12a.c            |  67 -------------
 arch/arm/mach-meson/board-gx.c              |  48 ---------
 board/amlogic/beelink-s922x/beelink-s922x.c |   2 -
 board/amlogic/odroid-n2/odroid-n2.c         |   2 -
 board/amlogic/p200/p200.c                   |   2 -
 board/amlogic/p201/p201.c                   |   2 -
 board/amlogic/p212/p212.c                   |   3 -
 board/amlogic/q200/q200.c                   |   2 -
 board/amlogic/s400/s400.c                   |   2 -
 board/amlogic/sei510/sei510.c               |   3 -
 board/amlogic/sei610/sei610.c               |   3 -
 board/amlogic/u200/u200.c                   |   3 +-
 board/amlogic/vim3/vim3.c                   |   2 -
 board/amlogic/w400/w400.c                   |   2 +-
 configs/beelink-gtking_defconfig            |   5 +-
 configs/beelink-gtkingpro_defconfig         |   5 +-
 configs/khadas-vim2_defconfig               |   5 +-
 configs/khadas-vim3_defconfig               |   5 +-
 configs/khadas-vim3l_defconfig              |   5 +-
 configs/khadas-vim_defconfig                |   7 +-
 configs/libretech-ac_defconfig              |   7 +-
 configs/libretech-cc_defconfig              |   7 +-
 configs/libretech-cc_v2_defconfig           |   7 +-
 configs/libretech-s905d-pc_defconfig        |   5 +-
 configs/libretech-s912-pc_defconfig         |   5 +-
 configs/nanopi-k2_defconfig                 |   2 +-
 configs/odroid-c2_defconfig                 |   2 +-
 configs/odroid-c4_defconfig                 |   5 +-
 configs/odroid-n2_defconfig                 |   5 +-
 configs/p200_defconfig                      |   2 +-
 configs/p201_defconfig                      |   2 +-
 configs/p212_defconfig                      |   7 +-
 configs/s400_defconfig                      |   2 +-
 configs/sei510_defconfig                    |   7 +-
 configs/sei610_defconfig                    |   7 +-
 configs/u200_defconfig                      |   7 +-
 configs/wetek-core2_defconfig               |   5 +-
 drivers/net/Kconfig                         |  22 ++++
 drivers/net/Makefile                        |   3 +
 drivers/net/designware.c                    |  96 +++++++++++++++++-
 drivers/net/dwmac_meson8b.c                 | 150 ++++++++++++++++++++++++++++
 drivers/net/mdio_mux_meson_g12a.c           | 149 +++++++++++++++++++++++++++
 drivers/net/mdio_mux_mmioreg.c              | 129 ++++++++++++++++++++++++
 48 files changed, 624 insertions(+), 307 deletions(-)
 create mode 100644 drivers/net/dwmac_meson8b.c
 create mode 100644 drivers/net/mdio_mux_meson_g12a.c
 create mode 100644 drivers/net/mdio_mux_mmioreg.c
