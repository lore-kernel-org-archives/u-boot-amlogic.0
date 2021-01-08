Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.18.1610083012283199360
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Jan 2021 21:16:52 -0800
Received: by mail-il1-f175.google.com with SMTP id u12so9159040ilv.3
        for <u-boot-amlogic@groups.io>; Thu, 07 Jan 2021 21:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4uqqwjbkqtmSXVkTQpMF3s647HYgaV3bkA0doNQG9k=;
        b=S/FFrU53TzvdrrsbRNqtHTYBFex+gm+jqZu2t0lpi+mvX2fiolpU7I2M/qibSB5O5N
         4nSGDf4h1rFSH6hSiLI7AgvwHR3b/qmbuesPxn3f6vuldDZmk+BIAZNDHh22qhlSsqBo
         +D4SqxPegPvDG3lVwpZsH+UmPdcC1WxVlU94k=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v4 0/8] RFC: dm: core: Add support for vital devices
Date: Thu,  7 Jan 2021 22:16:28 -0700
Message-Id: <20210108051636.2928002-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Ramon Fried <rfried.dev@gmail.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Sean Anderson <seanga2@gmail.com>, Srinath Mannam <srinath.mannam@broadcom.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

This is an attempt to come up with a 'late removal' feature, as
implemented by Marek, but using different terminology and trying to fit in
with the existing removal flags.

Missing from this is a call to dm_remove_devices_flags() with the
DM_REMOVE_NON_VITAL flag, except for the call in dm_init(). It could
perhaps be placed in bootm.

I have taken the opportunity to clean up a few related things.

The series is available at u-boot-dm/late-working

The previous patch was here:

   http://patchwork.ozlabs.org/project/uboot/patch/20201108140818.55172-1-marek.vasut+renesas@gmail.com/

Changes in v4:
- Use 'vital' rather than 'late' as the description
- Invert the removal flag to DM_REMOVE_NON_VITAL, to avoid the need for
        two-pass processing in the bowels of driver model
- Simplify the test to only test 'vital'
- Drop the change to uclass_destroy()
- Revised and updated based on discussion

Marek Vasut (1):
  dm: core: Add late driver remove option

Simon Glass (7):
  smem: Don't use -EPROBE_DEFER
  nand: brcmnand: Don't use -EPROBE_DEFER
  dm: Rename DM_FLAG_REMOVE_WITH_PD_ON
  dm: pci: Correct use of wrong flag name
  dm: core: Remove children before advising uclass
  dm: core: Avoid partially removing devices
  dm: core: Add documentation about device removal

 doc/driver-model/design.rst              | 20 ++++++
 drivers/core/device-remove.c             | 83 +++++++++++++++---------
 drivers/core/root.c                      |  2 +
 drivers/mtd/nand/raw/brcmnand/brcmnand.c |  5 +-
 drivers/pci/pcie_iproc.c                 |  2 +-
 drivers/smem/msm_smem.c                  |  6 +-
 drivers/video/meson/meson_vpu.c          |  2 +-
 drivers/watchdog/rti_wdt.c               |  2 +-
 include/dm/device-internal.h             | 15 ++++-
 include/dm/device.h                      | 15 ++++-
 test/dm/core.c                           | 47 ++++++++++++++
 test/dm/test-driver.c                    | 11 ++++
 test/dm/virtio.c                         |  4 +-
 13 files changed, 169 insertions(+), 45 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

