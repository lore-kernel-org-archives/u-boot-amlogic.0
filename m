Received: by mail-wm1-f50.google.com with SMTP id x15so62101338wmj.3
        for <u-boot-amlogic@groups.io>; Wed, 31 Jul 2019 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=JqMnEpJEjLNdJPBQ6yW1lbQSoRlE49R1KMup5U9B044=;
        b=2Ng7pGDbBKzAMhiuC4OWHCj9N4X9guYYjn+peMYVSaDVlXY3oUNrvzxh02vXJa5qcy
         CN2LdtxHNWHpd2rIIdOxaX1nVrroCVkKTDXeoj3BEC1jwAkL9c3OuOCZKyPqt2GDvyC4
         AMtAwiIXkQfy+uh2erYOY+Z28g2WzSGcaQPpCMZzyEzladgJIKKvIrdXsUUMmC5eo49r
         /pL5YQnMtD+5IokGFh5R8rJ/YvZskW7+cyPSkF3rU/NFHeu0nsRTNIahmH5uwTNQRSBz
         HJtfGIx/a8EQk0pC9zhXdpsoqveVpi0kd38pS+s1Erzyr76Qo9TigB4PsZvk9UC3R+6q
         WfbA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190731
Message-ID: <9d44c293-3ed7-b681-a3b5-33087115b555@baylibre.com>
Date: Wed, 31 Jul 2019 21:57:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds support for the Odroid-N2 board and sync the Amlogic G12A DT
with Linux 5.3-rc1, removing the local DT in -u-boot.dtsi files.
It also includes the last minute fix from Heinrich in the gxbb clock driver.

The CI jobs passed at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/376

Thanks,
Neil

The following changes since commit d0d07ba86afc8074d79e436b1ba4478fa0f0c1b5:

  Prepare v2019.10-rc1 (2019-07-29 21:16:16 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20190731

for you to fetch changes up to 0c0cdc86103a1f579cb9f86a3c7c076abb383542:

  clk: meson: remove duplicate logic (2019-07-31 12:11:04 +0200)

----------------------------------------------------------------
- sync Amlogic G12A DT with linux 5.3-rc1
- add support for 4GiB DRAM memory
- add support for Amlogic G12B based Odroid-N2
- small duplicate logic fix for gxbb clock driver

----------------------------------------------------------------
Heinrich Schuchardt (1):
      clk: meson: remove duplicate logic

Neil Armstrong (4):
      ARM: dts: Sync Amlogic G12A with Linux 5.3-rc1
      ARM: dts: add support for Odroid-N2
      ARM: meson-g12a: Handle 4GiB DRAM size
      board: amlogic: add support for Odroid-N2

 arch/arm/dts/Makefile                           |    3 +-
 arch/arm/dts/meson-g12a-u-boot.dtsi             |  216 ---
 arch/arm/dts/meson-g12a-u200-u-boot.dtsi        |   63 -
 arch/arm/dts/meson-g12a-u200.dts                |  122 +-
 arch/arm/dts/meson-g12a.dtsi                    | 1825 ++++++++++++++++++++++-
 arch/arm/dts/meson-g12b-odroid-n2.dts           |  386 +++++
 arch/arm/dts/meson-g12b.dtsi                    |   82 +
 arch/arm/mach-meson/board-g12a.c                |   13 +-
 board/amlogic/w400/MAINTAINERS                  |    6 +
 board/amlogic/w400/Makefile                     |    6 +
 board/amlogic/w400/README.odroid-n2             |  130 ++
 board/amlogic/w400/README.w400                  |  130 ++
 board/amlogic/w400/w400.c                       |   18 +
 configs/odroid-n2_defconfig                     |   56 +
 drivers/clk/meson/gxbb.c                        |    5 +-
 include/dt-bindings/clock/axg-aoclkc.h          |    7 +-
 include/dt-bindings/clock/axg-audio-clkc.h      |   30 +-
 include/dt-bindings/clock/g12a-clkc.h           |    3 +-
 include/dt-bindings/sound/meson-g12a-tohdmitx.h |   13 +
 19 files changed, 2765 insertions(+), 349 deletions(-)
 delete mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
 delete mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm/dts/meson-g12b.dtsi
 create mode 100644 board/amlogic/w400/MAINTAINERS
 create mode 100644 board/amlogic/w400/Makefile
 create mode 100644 board/amlogic/w400/README.odroid-n2
 create mode 100644 board/amlogic/w400/README.w400
 create mode 100644 board/amlogic/w400/w400.c
 create mode 100644 configs/odroid-n2_defconfig
 create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h
