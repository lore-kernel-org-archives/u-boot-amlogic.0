Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.web09.9644.1608132317973907669
 for <u-boot-amlogic@groups.io>;
 Wed, 16 Dec 2020 07:25:18 -0800
Received: by mail-io1-f41.google.com with SMTP id z5so24296010iob.11
        for <u-boot-amlogic@groups.io>; Wed, 16 Dec 2020 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5TUpY4vfcqCTZna8cq//tKPU6LakOf/+KTqi6n4XLQ=;
        b=XBzc2komtDYXzUyTPUmGej4cGCwh+tXRBdXj3eli1Sw7myhEqlICJj2SItKkYIffAt
         5M+QTLEnHv3dhs5KROjd7MvIXiMrBxsNMicQDiqgaXoAAzmOpkxxgevL9d4T0KupLYY0
         zg5mBikia9I90rczvppLOosafrkyU3GAG1Ksk=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 00/18] dm: Preparation for enhanced of-platdata
Date: Wed, 16 Dec 2020 08:24:48 -0700
Message-Id: <20201216152506.119900-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adam Ford <aford173@gmail.com>, Aiden Park <aiden.park@intel.com>, Alexander Graf <agraf@csgraf.de>, Anatolij Gustschin <agust@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Angelo Durgehello <angelo.dureghello@timesys.com>, Anji J <anji.jagarlmudi@nxp.com>, Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, Biwen Li <biwen.li@nxp.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Dario Binacchi <dariobin@libero.it>, Faiz Abbas <faiz_abbas@ti.com>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Giulio Benetti <giulio.benetti@benettiengineering.com>, Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Icenowy Zheng <icenowy@aosc.io>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Joe Hershberger <joe.hershberger@ni.com>, Joel Johnson <mrjoel@lixil.net>, Kever Yang <kever.yang@rock-chips.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Madalin Bucur <madalin.bucur@oss.nxp.com>, Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, Martin Fuzzey <martin.fuzzey@flowbird.group>, Masahiro Yamada <masahiroy@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michael Walle <michael@walle.cc>, Michal Simek <michal.simek@xilinx.com>, Michal Simek <monstr@monstr.eu>, Neil Armstrong <narmstrong@baylibre.com>, Oleksandr Zhadan and Michael Durrant <arcsupport@arcturusnetworks.com>, Otavio Salvador <otavio@ossystems.com.br>, Ovidiu Panait <ovidiu.panait@windriver.com>, Patrice Chotard <patrice.chotard@st.com>, Patrick Delaunay <patrick.delaunay@st.com>, =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Philippe Reynes <philippe.reynes@softathome.com>, Pragnesh Patel <Pragnesh.patel@sifive.com>, Pratyush Yadav <p.yadav@ti.com>, Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Reuben Dowle <reubendowle0@gmail.com>, Rick Chen <rick@andestech.com>, Robert Beckett <bob.beckett@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, Sagar Shrikant Kadam <sagar.kadam@sifive.com>, Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>, Suneel Garapati <sgarapati@marvell.com>, Thor Thayer <thor.thayer@linux.intel.com>, Tien Fong Chee <tien.fong.chee@intel.com>, Walter Lozano <walter.lozano@collabora.com>, Walter Schweizer <swwa@users.sourceforge.net>, Weijie Gao <weijie.gao@mediatek.com>, Wolfgang Wallner <wolfgang.wallner@br-automation.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
List-ID: <u-boot-amlogic@groups.io>

This series includes various patches in service of some upcoming
of-platdata enhancements. The new features will support declaring devices
and uclasses at build time (automatically, using dtoc) so as to further
reduce the code-size overhead of driver model.

The main changes in this series are:
- Support for separate SPL and TPL devicetree files, so dtoc can produce
   of-platdata for each individually
- Rename of NS16550 to ns16550 so it follows the identifier rules
- Report TPL code/data sizes in buildman, to support measuring size
- Update U-Boot to access device/uclass-private data via functions (to
     allow the storage mechanism to change later)
- Drop bd_info from the image to save space


Simon Glass (18):
  Makefile: Build a separate .dtb for TPL
  Makefile: Build SPL dtbs in the spl/ directory
  Makefile: Tidy up SPL dtb production
  Makefile: Use common args for dtoc
  buildman: Report sizes for TPL also
  serial: Update NS16550_t and struct NS16550
  serial: Rename ns16550 functions to lower case
  sandbox: Drop unnecessary test node
  spl: Drop bd_info in the data section
  dm: core: Support dm_dump_all() in SPL
  dm: core: Use 'uclass_driver' for the uclass linker_list
  dm: core: Only include simple-bus devicetree id when needed
  x86: apl: Drop support for !OF_PLATDATA_PARENT
  dm: core: Add function to access uclass priv
  dm: core: Add functions to set priv/plat
  dm: Use access methods for dev/uclass private data
  dm: core: Use access methods for dev/uclass private data
  dm: core: Rename the priv/plat members

 arch/arm/cpu/armv7/ls102xa/fdt.c           |   4 +
 arch/arm/cpu/armv8/fsl-layerscape/spl.c    |   5 +-
 arch/arm/mach-davinci/da850_lowlevel.c     |   4 +-
 arch/arm/mach-davinci/spl.c                |   4 +-
 arch/arm/mach-keystone/init.c              |   2 +-
 arch/arm/mach-stm32mp/pwr_regulator.c      |   3 +-
 arch/sandbox/dts/sandbox.dtsi              |   5 -
 arch/x86/cpu/apollolake/Kconfig            |   1 +
 arch/x86/cpu/apollolake/spl.c              |  28 ------
 arch/x86/cpu/apollolake/uart.c             |   5 +-
 arch/x86/cpu/slimbootloader/serial.c       |   4 +-
 board/Arcturus/ucp1020/spl.c               |   2 +-
 board/Arcturus/ucp1020/spl_minimal.c       |   6 +-
 board/Synology/ds109/ds109.c               |   9 +-
 board/freescale/mpc8313erdb/mpc8313erdb.c  |   6 +-
 board/freescale/mpc8315erdb/mpc8315erdb.c  |   6 +-
 board/freescale/p1010rdb/spl.c             |   2 +-
 board/freescale/p1010rdb/spl_minimal.c     |   8 +-
 board/freescale/p1_p2_rdb_pc/spl.c         |   2 +-
 board/freescale/p1_p2_rdb_pc/spl_minimal.c |   8 +-
 board/freescale/t102xrdb/spl.c             |   2 +-
 board/freescale/t104xrdb/spl.c             |   2 +-
 board/freescale/t208xqds/spl.c             |   2 +-
 board/freescale/t208xrdb/spl.c             |   2 +-
 board/freescale/t4rdb/spl.c                |   2 +-
 common/spl/Kconfig                         |   9 ++
 common/spl/spl.c                           |  20 ++--
 drivers/clk/clk.c                          |   2 +-
 drivers/clk/clk_fixed_rate.c               |   4 +-
 drivers/clk/rockchip/clk_px30.c            |   3 +-
 drivers/clk/rockchip/clk_rk3036.c          |   3 +-
 drivers/clk/rockchip/clk_rk3128.c          |   3 +-
 drivers/clk/rockchip/clk_rk3188.c          |   2 +-
 drivers/clk/rockchip/clk_rk322x.c          |   3 +-
 drivers/clk/rockchip/clk_rk3288.c          |   2 +-
 drivers/clk/rockchip/clk_rk3308.c          |   3 +-
 drivers/clk/rockchip/clk_rk3328.c          |   3 +-
 drivers/clk/rockchip/clk_rk3368.c          |   3 +-
 drivers/clk/rockchip/clk_rk3399.c          |   3 +-
 drivers/clk/rockchip/clk_rv1108.c          |   3 +-
 drivers/core/device-remove.c               |  24 ++---
 drivers/core/device.c                      | 103 ++++++++++++++-------
 drivers/core/dump.c                        |   6 +-
 drivers/core/lists.c                       |   4 +-
 drivers/core/root.c                        |   4 +-
 drivers/core/simple-bus.c                  |   4 +-
 drivers/core/uclass.c                      |  23 ++++-
 drivers/ddr/altera/sdram_agilex.c          |   2 +-
 drivers/ddr/altera/sdram_gen5.c            |   4 +-
 drivers/ddr/altera/sdram_s10.c             |   2 +-
 drivers/ddr/altera/sdram_soc64.c           |   2 +-
 drivers/gpio/dwapb_gpio.c                  |   2 +-
 drivers/gpio/gpio-uclass.c                 |   2 +-
 drivers/gpio/hi6220_gpio.c                 |   2 +-
 drivers/gpio/imx_rgpio2p.c                 |   5 +-
 drivers/gpio/lpc32xx_gpio.c                |   2 +-
 drivers/gpio/mt7621_gpio.c                 |   2 +-
 drivers/gpio/mxs_gpio.c                    |   2 +-
 drivers/gpio/omap_gpio.c                   |   3 +-
 drivers/gpio/s5p_gpio.c                    |   6 +-
 drivers/gpio/sandbox.c                     |   6 +-
 drivers/gpio/sunxi_gpio.c                  |   2 +-
 drivers/gpio/tegra186_gpio.c               |   6 +-
 drivers/gpio/tegra_gpio.c                  |   6 +-
 drivers/i2c/i2c-uclass.c                   |   4 +-
 drivers/misc/altera_sysid.c                |   2 +-
 drivers/misc/cros_ec_sandbox.c             |   4 +-
 drivers/misc/fs_loader.c                   |   6 +-
 drivers/misc/p2sb-uclass.c                 |  15 ---
 drivers/misc/vexpress_config.c             |   2 +-
 drivers/mmc/arm_pl180_mmci.c               |   6 +-
 drivers/mmc/mxsmmc.c                       |   2 +-
 drivers/mmc/octeontx_hsmmc.c               |  17 +++-
 drivers/mux/mmio.c                         |   3 +-
 drivers/net/eth-phy-uclass.c               |   4 +-
 drivers/net/fm/eth.c                       |  22 ++++-
 drivers/net/fsl_mcdmafec.c                 |  10 +-
 drivers/net/mcffec.c                       |  12 +--
 drivers/net/mcfmii.c                       |   8 ++
 drivers/net/pfe_eth/pfe_eth.c              |   2 +-
 drivers/net/sunxi_emac.c                   |   2 +-
 drivers/net/tsec.c                         |  46 ++++++---
 drivers/net/xilinx_emaclite.c              |   2 +-
 drivers/pci/pci-emul-uclass.c              |   4 +-
 drivers/pci/pci-uclass.c                   |   8 +-
 drivers/pinctrl/pinctrl-qe-io.c            |   4 +-
 drivers/pinctrl/pinctrl-single.c           |   6 +-
 drivers/power/regulator/da9063.c           |  24 ++---
 drivers/power/regulator/pbias_regulator.c  |   3 +-
 drivers/remoteproc/rproc-uclass.c          |   4 +-
 drivers/reset/reset-mediatek.c             |   3 +-
 drivers/reset/reset-rockchip.c             |   3 +-
 drivers/reset/reset-sifive.c               |   3 +-
 drivers/reset/reset-sunxi.c                |   3 +-
 drivers/serial/altera_jtag_uart.c          |   8 +-
 drivers/serial/altera_uart.c               |   8 +-
 drivers/serial/atmel_usart.c               |   2 +-
 drivers/serial/ns16550.c                   |  62 ++++++-------
 drivers/serial/sandbox.c                   |   6 +-
 drivers/serial/serial_arc.c                |   8 +-
 drivers/serial/serial_coreboot.c           |   2 +-
 drivers/serial/serial_intel_mid.c          |   2 +-
 drivers/serial/serial_linflexuart.c        |   2 +-
 drivers/serial/serial_lpuart.c             |  10 +-
 drivers/serial/serial_mcf.c                |  10 +-
 drivers/serial/serial_meson.c              |  12 +--
 drivers/serial/serial_mxc.c                |  12 +--
 drivers/serial/serial_ns16550.c            |  26 +++---
 drivers/serial/serial_omap.c               |   8 +-
 drivers/serial/serial_pxa.c                |  10 +-
 drivers/serial/serial_rockchip.c           |   7 +-
 drivers/serial/serial_s5p.c                |  12 +--
 drivers/spi/cadence_qspi.c                 |  12 +--
 drivers/spi/cf_spi.c                       |   2 +-
 drivers/spi/davinci_spi.c                  |   4 +-
 drivers/spi/designware_spi.c               |   4 +-
 drivers/spi/exynos_spi.c                   |   4 +-
 drivers/spi/fsl_dspi.c                     |   4 +-
 drivers/spi/fsl_espi.c                     |   2 +-
 drivers/spi/fsl_qspi.c                     |   2 +-
 drivers/spi/mxs_spi.c                      |   2 +-
 drivers/spi/pl022_spi.c                    |   2 +-
 drivers/spi/rk_spi.c                       |   6 +-
 drivers/spi/soft_spi.c                     |   4 +-
 drivers/spi/tegra114_spi.c                 |   4 +-
 drivers/spi/tegra20_sflash.c               |   4 +-
 drivers/spi/tegra20_slink.c                |   4 +-
 drivers/spi/tegra210_qspi.c                |   4 +-
 drivers/spi/uniphier_spi.c                 |   8 +-
 drivers/spi/zynq_qspi.c                    |   4 +-
 drivers/spi/zynq_spi.c                     |   8 +-
 drivers/spi/zynqmp_gqspi.c                 |   6 +-
 drivers/timer/ag101p_timer.c               |   4 +-
 drivers/timer/altera_timer.c               |   4 +-
 drivers/timer/andes_plmt_timer.c           |   7 +-
 drivers/timer/mpc83xx_timer.c              |   2 +-
 drivers/timer/sifive_clint_timer.c         |   7 +-
 drivers/timer/timer-uclass.c               |   2 +-
 drivers/usb/gadget/ether.c                 |  16 +++-
 drivers/usb/host/usb-uclass.c              |   6 +-
 drivers/video/video-uclass.c               |   2 +-
 dts/Makefile                               |  14 ++-
 include/dm/device-internal.h               |  84 +++++++++++++++++
 include/dm/device.h                        |  29 +++---
 include/dm/uclass-internal.h               |  14 +++
 include/dm/uclass.h                        |  14 ++-
 include/ns16550.h                          |  21 +++--
 include/spl.h                              |  10 +-
 lib/efi/efi_stub.c                         |   2 +-
 lib/efi_loader/efi_device_path.c           |   2 +-
 net/eth-uclass.c                           |  22 ++---
 scripts/Makefile.spl                       |  18 ++--
 test/dm/core.c                             |  24 ++---
 test/dm/test-driver.c                      |   7 +-
 test/dm/test-fdt.c                         |   4 +-
 test/dm/test-uclass.c                      |   4 +-
 test/py/tests/test_ofplatdata.py           |   1 -
 tools/buildman/builderthread.py            |   2 +-
 tools/dtoc/dtoc_test_simple.dts            |   5 -
 tools/dtoc/test_dtoc.py                    |  12 ---
 160 files changed, 757 insertions(+), 527 deletions(-)

-- 
2.29.2.684.gfbc64c5ab5-goog

