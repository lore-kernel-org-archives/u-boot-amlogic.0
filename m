Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web12.6025.1582077299812556373
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Feb 2020 17:54:59 -0800
Received: by mail-pj1-f66.google.com with SMTP id e9so1835687pjr.4
        for <u-boot-amlogic@groups.io>; Tue, 18 Feb 2020 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=qEMvwQKTV5hip5awTnaegc35D071yc6cb4iVvfBhqio=;
        b=MGd2tXEA0Q40kXmyZ5wY0S17q01tmZt1S4aTwEGAfoLsD39nqxTMZPc7S68BtzZ1A8
         0MVljacDuxUGC60BrYD+rYJRqMoV2fzzMRyyeXu6KyXfk3DTYxvT3zEOPDPOC7ddziaq
         OR4CuOo8DUlhEslmaSXIeLnBV2g3Nka2Wwp7MGfKYtNP/1driy43thjIM/mrUgmVe9AP
         Mwv5oj0AIjmz7uqy1GvQ/I9ZYjUhc9y5fgXEGgAQ1//pZIWE8eAb3ap650fvWFgfVBJ0
         KKS2SeVZnMTM3b6bfsrKbWm87OOxY+9GYYsPGAHwSjPXTJcbgLW1KBgVmtIoMeBxhuMH
         QdlA==
Return-Path: <kever.yang@gmail.com>
Sender: Kever Yang <kever.yang@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 00/10] usb: Covert to support Live DT
Date: Wed, 19 Feb 2020 09:54:37 +0800
Message-Id: <20200219015447.19392-1-kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jagan Teki <jagan@amarulasolutions.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>, Neil Armstrong <narmstrong@baylibre.com>, Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>


This patch set convert to use APIs leading with dev_ or ofnode_ which
supports live DT instead of fdt_ or fdtdec or devfdt_.
Two functions update there parameter from offset to ofnode:
- usb_get_maximum_speed()
- usb_get_dr_mode()



Kever Yang (10):
  usb: dwc3-of-simple: Drop redundant inclding header file
  usb: ehci-msm: Use dev interface to get device address
  usb: cdns3: Migrate to use ofnode API for bind function
  usb: dwc3-generic: Migrate to use ofnode API for bind function
  usb: dwc3-generic: Use dev_read_addr() instead of devfdt_get_addr()
  usb: host: dwc3-sti-glue: Migrate to use ofnode API
  usb: musb-new: Migrate to use ofnode API
  usb: dwc3: core: reorder the header file including sequence
  usb: Use ofnode as usb_get_dr_mode() parameter
  usb: Use ofnode as usb_get_maximum_speed() parameter

 drivers/usb/cdns3/core.c           | 17 +++++++----------
 drivers/usb/cdns3/gadget.c         |  2 +-
 drivers/usb/common/common.c        | 12 +++++-------
 drivers/usb/dwc3/core.c            |  6 +++---
 drivers/usb/dwc3/dwc3-generic.c    | 16 +++++++---------
 drivers/usb/dwc3/dwc3-meson-g12a.c |  2 +-
 drivers/usb/gadget/dwc2_udc_otg.c  |  5 ++---
 drivers/usb/host/dwc3-of-simple.c  |  1 -
 drivers/usb/host/dwc3-sti-glue.c   | 20 +++++++-------------
 drivers/usb/host/ehci-msm.c        |  4 +---
 drivers/usb/host/ehci-mx6.c        |  2 +-
 drivers/usb/host/xhci-dwc3.c       |  3 +--
 drivers/usb/musb-new/ti-musb.c     | 12 +++++-------
 include/linux/usb/otg.h            |  8 ++++----
 14 files changed, 45 insertions(+), 65 deletions(-)

-- 
2.17.1

