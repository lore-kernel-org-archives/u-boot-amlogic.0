Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web12.181.1582165960919853970
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Feb 2020 18:32:40 -0800
Received: by mail-pl1-f195.google.com with SMTP id ay11so937374plb.0
        for <u-boot-amlogic@groups.io>; Wed, 19 Feb 2020 18:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kRrPm+9vPeKHLMQzvUOULasluUCy6t+P8VNM4TSkiuI=;
        b=geyWr0iHhAFW9nR8+5sjotfckZzDlbDc35pgLctVE2pQCdkPe+2waYsYPTCxLqVOkA
         2UVzbN6c0AOecWlWUkxJO9nGJpYSjoxrh+aPYGaMi9iIDI/vIyUExk7HooTtXopkptyl
         iBgf/VoUbcTsD4dquwOK/QqcKo+xXpShwBT/QlpHU9/8IVWNGOcq210V9gF6iAg+BHSL
         m+8KRkb2i8P56Wu6HagQue8mKxG6z/BjgaDcm0VU6Z6XMKpPMcm3gQyxjC2lFHjw8OAq
         7t+gy+En/F8oybDPt7vat54vkLLN3fz5LsXuCjKymn+C3Pc+wKBPhxGbYXD5CRVWpI30
         +JTA==
Return-Path: <kever.yang@gmail.com>
Sender: Kever Yang <kever.yang@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2 0/9] usb: Covert to support Live DT
Date: Thu, 20 Feb 2020 10:32:15 +0800
Message-Id: <20200220023224.32146-1-kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: frank.wang@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>, Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>, Neil Armstrong <narmstrong@baylibre.com>, Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, Vignesh Raghavendra <vigneshr@ti.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>


This patch set convert to use APIs leading with dev_ or ofnode_ which
supports live DT instead of fdt_ or fdtdec or devfdt_.
Two functions update there parameter from offset to ofnode:
- usb_get_maximum_speed()
- usb_get_dr_mode()

For V2 update:
Drop below patch after include ofnode.h in otg.h:
[PATCH 09/10] usb: Use ofnode as usb_get_dr_mode() parameter


Changes in v2:
- fix build error for ofnode not define
- add ofnode.h in otg.h to avoid build error

Kever Yang (9):
  usb: dwc3-of-simple: Drop redundant inclding header file
  usb: ehci-msm: Use dev interface to get device address
  usb: cdns3: Migrate to use ofnode API for bind function
  usb: dwc3-generic: Migrate to use ofnode API for bind function
  usb: dwc3-generic: Use dev_read_addr() instead of devfdt_get_addr()
  usb: host: dwc3-sti-glue: Migrate to use ofnode API
  usb: musb-new: Migrate to use ofnode API
  usb: Use ofnode as usb_get_dr_mode() parameter
  usb: Use ofnode as usb_get_maximum_speed() parameter

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

