Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.48174.1609172782353272012
 for <u-boot-amlogic@groups.io>;
 Mon, 28 Dec 2020 08:26:22 -0800
Received: by mail-wr1-f52.google.com with SMTP id a12so11740322wrv.8
        for <u-boot-amlogic@groups.io>; Mon, 28 Dec 2020 08:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:from:in-reply-to:references:date:message-id
         :subject:to:cc;
        bh=DYhzNxlRU5RU7MKiJK1L9kMtyAGC84EwCXhy3ZZ2/kw=;
        b=Wgy0rTy/2sGXLjO99r5IcHpTyAi07oCstryAeFwDTwVYogLweuclup+w6ya5hyVZvp
         8V2EHtHk/fVBXkUHQwG23Wj88Pr+5Wt619sSqXjv2wQT4Nz6VzIb7Uvr9h0++62M0Y63
         SeYtUDTGMfCWdInv2NxQuYztMpv+TXkX9DwoY=
MIME-Version: 1.0
Sender: Simon Glass <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20201219174018.1114146-21-sjg@chromium.org>
References: <20201219174018.1114146-21-sjg@chromium.org> <20201219174018.1114146-1-sjg@chromium.org>
Date: Mon, 28 Dec 2020 08:26:19 -0800
Message-ID: <CAPnjgZ2iBdqjcA=fXByo1uMAQVPspu9BXMXUNkqq1wVCwFSGDg@mail.gmail.com>
Subject: Re: [PATCH 22/26] dm: core: Access device ofnode through functions
Content-Type: text/plain; charset="UTF-8"
To: Simon Glass <sjg@chromium.org>
Cc: Aaron Williams <awilliams@marvell.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Eugeniy Paltsev <paltsev@synopsys.com>, Frank Wang <frank.wang@rock-chips.com>, Frank Wunderlich <frank-w@public-files.de>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Jens Wiklander <jens.wiklander@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, Kever Yang <kever.yang@rock-chips.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Lokesh Vutla <lokeshvutla@ti.com>, Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, Lukasz Majewski <lukma@denx.de>, Madalin Bucur <madalin.bucur@oss.nxp.com>, Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Neil Armstrong <narmstrong@baylibre.com>, Patrice Chotard <patrice.chotard@st.com>, Patrick Delaunay <patrick.delaunay@st.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Priyanka Jain <priyanka.jain@nxp.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Robert Marko <robert.marko@sartura.hr>, Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>, Suneel Garapati <sgarapati@marvell.com>, Weijie Gao <weijie.gao@mediatek.com>, "hui.song" <hui.song_1@nxp.com>, u-boot-amlogic@groups.io, uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

At present ofnode is present in the device even if it is never used. With
of-platdata this field is not used, so can be removed. In preparation for
this, change the access to go through inline functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-stm32mp/pwr_regulator.c     |  2 +-
 board/synopsys/hsdk/clk-lib.c             |  2 +-
 drivers/ata/mtk_ahci.c                    |  3 ++-
 drivers/clk/meson/axg.c                   |  2 +-
 drivers/clk/meson/g12a.c                  |  2 +-
 drivers/clk/meson/gxbb.c                  |  2 +-
 drivers/core/device.c                     |  2 +-
 drivers/core/root.c                       |  2 +-
 drivers/gpio/mpc8xxx_gpio.c               |  4 ++--
 drivers/gpio/octeon_gpio.c                |  2 +-
 drivers/misc/swap_case.c                  |  2 +-
 drivers/mmc/octeontx_hsmmc.c              | 23 +++++++++++++----------
 drivers/mtd/nand/raw/octeontx_nand.c      |  2 +-
 drivers/mtd/nand/spi/core.c               |  2 +-
 drivers/net/fm/eth.c                      |  4 ++--
 drivers/net/fsl_enetc.c                   |  8 ++++----
 drivers/net/fsl_enetc_mdio.c              |  2 +-
 drivers/net/mdio-ipq4019.c                |  4 ++--
 drivers/net/mdio_mux_i2creg.c             |  2 +-
 drivers/net/mvmdio.c                      |  4 ++--
 drivers/net/octeontx/smi.c                |  2 +-
 drivers/net/tsec.c                        |  3 ++-
 drivers/phy/phy-ti-am654.c                |  2 +-
 drivers/power/domain/meson-ee-pwrc.c      |  4 ++--
 drivers/power/domain/meson-gx-pwrc-vpu.c  |  4 ++--
 drivers/power/regulator/pbias_regulator.c |  3 ++-
 drivers/pwm/pwm-meson.c                   |  9 ++++++---
 drivers/reset/reset-socfpga.c             |  2 +-
 drivers/spi/fsl_dspi.c                    |  6 ++++--
 drivers/tee/optee/core.c                  |  2 +-
 drivers/usb/cdns3/core.c                  |  4 ++--
 drivers/usb/dwc3/core.c                   |  2 +-
 drivers/usb/dwc3/dwc3-generic.c           |  6 +++---
 drivers/usb/dwc3/dwc3-meson-g12a.c        |  2 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c         |  2 +-
 drivers/usb/gadget/dwc2_udc_otg.c         |  4 ++--
 drivers/usb/host/dwc3-octeon-glue.c       |  2 +-
 drivers/usb/host/dwc3-sti-glue.c          |  5 +++--
 drivers/usb/host/ehci-mx6.c               |  2 +-
 drivers/usb/host/xhci-dwc3.c              |  2 +-
 drivers/usb/mtu3/mtu3_core.c              |  2 +-
 drivers/usb/mtu3/mtu3_plat.c              |  4 ++--
 drivers/usb/musb-new/ti-musb.c            |  2 +-
 drivers/video/nexell_display.c            |  2 +-
 drivers/video/rockchip/rk_mipi.c          |  2 +-
 include/dm/device.h                       | 23 +++++++++++++++++++++--
 include/dm/read.h                         |  2 +-
 include/linux/mtd/mtd.h                   |  4 ++--
 net/mdio-mux-uclass.c                     |  2 +-
 net/mdio-uclass.c                         |  8 ++++----
 50 files changed, 113 insertions(+), 82 deletions(-)

Applied to u-boot-dm/next, thanks!
