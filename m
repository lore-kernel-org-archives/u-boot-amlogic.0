Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [62.209.51.94])
 by mx.groups.io with SMTP id smtpd.web11.1334.1593790637239506057
 for <u-boot-amlogic@groups.io>;
 Fri, 03 Jul 2020 08:37:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=JT/EgjMvT9BGlYUQQpfEQPtdABruY+WNSCjTwnx6Cbs=;
 b=DtJ/jEclyswuoJdCeBe77MpRTnJvJvmlKAO2Y1KOpfggquPx/J3N7zIwG0Kpqzd7ejWQ
 mRH1c6ozi0gKRU3BWLnjxdMeehFO9kK/VAW4pck6KWhklfuu416M1PMc8wMrEJm7zPQh
 vouhgDLujzoL10J8x1jVE0n5tywxLjSkM/qMRx7pXVsp9D5md1JKGlzNI+M7gkPVaUeC
 opR5aAZNSkuBztEpfJAvtDRD7/IXK5ZEBr/p0u7OroTm+o8svSrAhQjzpJPl3CO4KrP8
 46BPv1g7lqsl1vNPjC8xOZNQNNlUYginDa1aK5TimOPk1OqHTkxBTc7ImQniOoOfpXgg 4Q== 
From: Patrick Delaunay <patrick.delaunay@st.com>
Subject: [PATCH v3 0/7] phy: generic: add error trace to detect PHY issue in uclass
Date: Fri, 3 Jul 2020 17:36:39 +0200
Message-ID: <20200703153646.28533-1-patrick.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrick Delaunay <patrick.delaunay@st.com>, Anatolij Gustschin <agust@denx.de>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jagan Teki <jagan@amarulasolutions.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Joe Hershberger <joe.hershberger@ni.com>, Kever Yang <kever.yang@rock-chips.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Maxime Ripard <mripard@kernel.org>, Michal Suchanek <msuchanek@suse.de>, Neil Armstrong <narmstrong@baylibre.com>, Patrice Chotard <patrice.chotard@st.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Weijie Gao <weijie.gao@mediatek.com>, u-boot-amlogic@groups.io, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
List-ID: <u-boot-amlogic@groups.io>


Hi,

it is a V3 serie for [1].

After rebase 2 patches are no more needed:
[v2,2/8] usb: gadget: dwc2: change trace level for phy errors managed by uclass
[v2,6/8] usb: dwc3: change trace level for phy errors managed by uclass

And I add a patch in this V3 serie:
[PATCH v3 7/7] arm: meson: change trace level for phy errors managed

Regards,

Patrick

[1] [v2,1/8] phy: generic: add error trace to detect PHY issue in uclass
http://patchwork.ozlabs.org/project/uboot/list/?series=159187&state=*

Changes in v3:
- rebase on next branch
- removed added dm/device_compat.h include after rebase
- simplify test on ops presence after Marek review
- add update for mach-meson board-gx: new generic_phy API usage

Changes in v2:
- Rebase and add include dm/device_compat.h
- Added patch after rebase: new generic_phy API usage

Patrick Delaunay (7):
  phy: generic: add error trace to detect PHY issue in uclass
  board: sunxi: change trace level for phy errors managed by uclass
  usb: host: ohci: change trace level for phy errors managed by uclass
  usb: host: ehci-hcd: change trace level for phy errors managed by
    uclass
  ata: dwc-ahci: change trace level for phy errors managed by uclass
  usb: musb-new: sunxi: change trace level for phy errors managed by
    uclass
  arm: meson: change trace level for phy errors managed by uclass

 arch/arm/mach-meson/board-gx.c  |  8 +++---
 board/sunxi/board.c             |  2 +-
 drivers/ata/dwc_ahci.c          |  4 +--
 drivers/phy/phy-uclass.c        | 45 +++++++++++++++++++++++++++++----
 drivers/usb/host/ehci-hcd.c     |  8 +++---
 drivers/usb/host/ohci-generic.c |  8 +++---
 drivers/usb/musb-new/sunxi.c    |  8 +++---
 7 files changed, 59 insertions(+), 24 deletions(-)

-- 
2.17.1

