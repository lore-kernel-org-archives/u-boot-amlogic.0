Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web08.7623.1610022989886823280
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Jan 2021 04:36:30 -0800
Received: by mail-oi1-f180.google.com with SMTP id l200so7165149oig.9
        for <u-boot-amlogic@groups.io>; Thu, 07 Jan 2021 04:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/AtC5wJaC4zUYNIwOXwSJjq+chEpbbNNRRoG/goO2Q=;
        b=JJaSZCXAk3Kgb4u0WNufgAWYNwfIp8Khbu3FvYFi4A8MlXfz3GuxvfHRcWdKQYMGvW
         bhjY/pLfTRGK0HHXB/JM5Rk7UP1fgigdxpUZJw2TFvEmHI20FDiDBZ/DP68k+DyT1qBg
         SOVVzOur2X6q/66zC0jPsG6/a2LXv713CggZk=
MIME-Version: 1.0
References: <20201219174018.1114146-1-sjg@chromium.org> <20201219174018.1114146-21-sjg@chromium.org>
 <1c2c4185-cb77-3713-41f9-e1549d0f88d1@foss.st.com>
In-Reply-To: <1c2c4185-cb77-3713-41f9-e1549d0f88d1@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Jan 2021 05:36:14 -0700
Message-ID: <CAPnjgZ2wdnm2VF7mxCrpW38BOrM7Q=JHQecpMHuOn3qWzicqJw@mail.gmail.com>
Subject: Re: [PATCH 22/26] dm: core: Access device ofnode through functions
Content-Type: text/plain; charset="UTF-8"
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, uboot-snps-arc@synopsys.com, Peng Fan <peng.fan@nxp.com>, Neil Armstrong <narmstrong@baylibre.com>, Lokesh Vutla <lokeshvutla@ti.com>, u-boot-amlogic@groups.io, Pavel Herrmann <morpheus.ibis@gmail.com>, Alexey Brodkin <alexey.brodkin@synopsys.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, Stefan Bosch <stefan_b@posteo.net>, Joe Hershberger <joe.hershberger@ni.com>, Patrick Delaunay <patrick.delaunay@st.com>, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Marek Vasut <marex@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, Luka Perkov <luka.perkov@sartura.hr>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Masahiro Yamada <masahiroy@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, Lukasz Majewski <lukma@denx.de>, Ley Foon Tan <ley.foon.tan@intel.com>, Suneel Garapati <sgarapati@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Madalin Bucur <madalin.bucur@oss.nxp.com>, Jagan Teki <jagan@amarulasolutions.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Anatolij Gustschin <agust@denx.de>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Roese <sr@denx.de>, Frank Wunderlich <frank-w@public-files.de>, Frank Wang <frank.wang@rock-chips.com>, Eugeniy Paltsev <paltsev@synopsys.com>, Robert Marko <robert.marko@sartura.hr>, "hui.song" <hui.song_1@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, Sean Anderson <seanga2@gmail.com>, Patrice Chotard <patrice.chotard@st.com>, Aaron Williams <awilliams@marvell.com>, Luka Kovacic <luka.kovacic@sartura.hr>, Bin Meng <bmeng.cn@gmail.com>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Jens Wiklander <jens.wiklander@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi Patrick,

On Mon, 4 Jan 2021 at 06:02, Patrick DELAUNAY
<patrick.delaunay@foss.st.com> wrote:
>
> Hi Simon,
>
>
> On 12/19/20 6:40 PM, Simon Glass wrote:
> > At present ofnode is present in the device even if it is never used. With
> > of-platdata this field is not used, so can be removed. In preparation for
> > this, change the access to go through inline functions.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   arch/arm/mach-stm32mp/pwr_regulator.c     |  2 +-
> >   board/synopsys/hsdk/clk-lib.c             |  2 +-
> >   drivers/ata/mtk_ahci.c                    |  3 ++-
> >   drivers/clk/meson/axg.c                   |  2 +-
> >   drivers/clk/meson/g12a.c                  |  2 +-
> >   drivers/clk/meson/gxbb.c                  |  2 +-
> >   drivers/core/device.c                     |  2 +-
> >   drivers/core/root.c                       |  2 +-
> >   drivers/gpio/mpc8xxx_gpio.c               |  4 ++--
> >   drivers/gpio/octeon_gpio.c                |  2 +-
> >   drivers/misc/swap_case.c                  |  2 +-
> >   drivers/mmc/octeontx_hsmmc.c              | 23 +++++++++++++----------
> >   drivers/mtd/nand/raw/octeontx_nand.c      |  2 +-
> >   drivers/mtd/nand/spi/core.c               |  2 +-
> >   drivers/net/fm/eth.c                      |  4 ++--
> >   drivers/net/fsl_enetc.c                   |  8 ++++----
> >   drivers/net/fsl_enetc_mdio.c              |  2 +-
> >   drivers/net/mdio-ipq4019.c                |  4 ++--
> >   drivers/net/mdio_mux_i2creg.c             |  2 +-
> >   drivers/net/mvmdio.c                      |  4 ++--
> >   drivers/net/octeontx/smi.c                |  2 +-
> >   drivers/net/tsec.c                        |  3 ++-
> >   drivers/phy/phy-ti-am654.c                |  2 +-
> >   drivers/power/domain/meson-ee-pwrc.c      |  4 ++--
> >   drivers/power/domain/meson-gx-pwrc-vpu.c  |  4 ++--
> >   drivers/power/regulator/pbias_regulator.c |  3 ++-
> >   drivers/pwm/pwm-meson.c                   |  9 ++++++---
> >   drivers/reset/reset-socfpga.c             |  2 +-
> >   drivers/spi/fsl_dspi.c                    |  6 ++++--
> >   drivers/tee/optee/core.c                  |  2 +-
> >   drivers/usb/cdns3/core.c                  |  4 ++--
> >   drivers/usb/dwc3/core.c                   |  2 +-
> >   drivers/usb/dwc3/dwc3-generic.c           |  6 +++---
> >   drivers/usb/dwc3/dwc3-meson-g12a.c        |  2 +-
> >   drivers/usb/dwc3/dwc3-meson-gxl.c         |  2 +-
> >   drivers/usb/gadget/dwc2_udc_otg.c         |  4 ++--
> >   drivers/usb/host/dwc3-octeon-glue.c       |  2 +-
> >   drivers/usb/host/dwc3-sti-glue.c          |  5 +++--
> >   drivers/usb/host/ehci-mx6.c               |  2 +-
> >   drivers/usb/host/xhci-dwc3.c              |  2 +-
> >   drivers/usb/mtu3/mtu3_core.c              |  2 +-
> >   drivers/usb/mtu3/mtu3_plat.c              |  4 ++--
> >   drivers/usb/musb-new/ti-musb.c            |  2 +-
> >   drivers/video/nexell_display.c            |  2 +-
> >   drivers/video/rockchip/rk_mipi.c          |  2 +-
> >   include/dm/device.h                       | 23 +++++++++++++++++++++--
> >   include/dm/read.h                         |  2 +-
> >   include/linux/mtd/mtd.h                   |  4 ++--
> >   net/mdio-mux-uclass.c                     |  2 +-
> >   net/mdio-uclass.c                         |  8 ++++----
> >   50 files changed, 113 insertions(+), 82 deletions(-)
>
> in all the modified drivers,
> for the functions ofnode_XXXX(dev->node,...) modified to ofnode_XXXX(dev_ofnode(dev),
> they can also modified to dev_XXX function :
>
> ofnode_read_u32(dev_ofnode(dev), ...) => dev_read_u32(dev,....)
> ofnode_read_string(dev_ofnode(dev), ...) => dev_read_string(dev,....)
> ofnode_valid(dev_ofnode(dev)) => dev_has_ofnode(dev)
>
> but you prefer perhaps minizes the modifications in this patchset and if
> it is the case :
>
> Reviewed-by: Patrick Delaunay
>
>
> You can found some other examples below.

Thanks for that.

I wonder if we can press coccinelle into service here. I think the
dev_read() API came later so people didn't know about it?

Regards,
Simon
