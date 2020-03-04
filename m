Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.134])
 by mx.groups.io with SMTP id smtpd.web12.2806.1583283653398138601
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Mar 2020 17:00:53 -0800
From: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v3 0/3] usb: Covert to support Live DT
Date: Wed,  4 Mar 2020 08:59:47 +0800
Message-Id: <20200304005951.8225-1-kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>, Neil Armstrong <narmstrong@baylibre.com>, Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>


This patch set convert to use APIs leading with dev_ or ofnode_ which
supports live DT instead of fdt_ or fdtdec or devfdt_.
Two functions update there parameter from offset to ofnode:
- usb_get_maximum_speed()
- usb_get_dr_mode()

For V3 update:
Squesh patch 3rd~9th/9 into one patch because the ofnode_to_offset(node) is
not work with the livetree, so we have to convert the api to support
livetree and its related function at the same time.

For V2 update:
Drop below patch after include ofnode.h in otg.h:
[PATCH 09/10] usb: Use ofnode as usb_get_dr_mode() parameter


Changes in v3:
- Squesh the 3rd~9th into one patch.

Kever Yang (3):
  usb: dwc3-of-simple: Drop redundant inclding header file
  usb: ehci-msm: Use dev interface to get device address
  usb: Migrate to support live DT for some driver

 drivers/usb/cdns3/core.c           | 15 ++++++---------
 drivers/usb/cdns3/gadget.c         |  2 +-
 drivers/usb/common/common.c        | 12 +++++-------
 drivers/usb/dwc3/dwc3-generic.c    | 16 +++++++---------
 drivers/usb/dwc3/dwc3-meson-g12a.c |  2 +-
 drivers/usb/gadget/dwc2_udc_otg.c  |  5 ++---
 drivers/usb/host/dwc3-of-simple.c  |  1 -
 drivers/usb/host/dwc3-sti-glue.c   | 20 +++++++-------------
 drivers/usb/host/ehci-msm.c        |  4 +---
 drivers/usb/host/ehci-mx6.c        |  2 +-
 drivers/usb/host/xhci-dwc3.c       |  3 +--
 drivers/usb/musb-new/ti-musb.c     | 12 +++++-------
 include/linux/usb/otg.h            | 10 ++++++----
 13 files changed, 43 insertions(+), 61 deletions(-)

-- 
2.17.1



