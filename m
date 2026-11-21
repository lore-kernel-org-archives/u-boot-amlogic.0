Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15720.1795264973190900572
 for <u-boot-amlogic@groups.io>;
 Sat, 21 Nov 2026 04:42:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=TKCitvXY;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.221.54, mailfrom: dario.binacchi@amarulasolutions.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so1590141f8f.2
        for <u-boot-amlogic@groups.io>; Sat, 21 Nov 2026 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795264971; x=1795869771; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
        b=TKCitvXYjMfUk/W1296jkVLEp944cSVIYDhAcddNGROIGv9yS1xetdHlnMxpVumdSU
         WCeicBJkRIiDbjFZ+y6gTPm3BKMlG2j6znvKufQo1WKaU9jO87l33J3kCmcPtcHJGdlW
         1TDkWhREs6CGrKtdRk7osCvYYSyibEacbsLhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795264971; x=1795869771;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPZ9oA/B+Gz0ryClkoT7lE/q3Keva2mmd38vgmGbTwA=;
        b=dkHm30olgF1Lc+v2PxXhquOUjxNM2mIhOCWVxFEM08NQdIaUb6cbZS3IyejpRX5zLs
         BrRs2E/LKsg/jD7tyyRJLVIHXviU81k6v7qYs6nhAM6SeGKVYVwyQUFdHrT1RKsL9bfJ
         M7poHbJjJF1U7s1HrAplfkduWd3I9lWhM9JzhXT10mKEjlVBpShijke5VmR6jzn03Wl2
         DPRvJfAmlakZdZJybWqOvOEtN8+WwISBMSOJZsNfUrXd1n/Xvv0XgWWwj6UhTm0f20Zr
         grPkQXMyOR2PMP/l3XMTKylZR08Wz2oEgHsPn4q7PGDQM9hVEtSMYbvc6EvFjlJqKHYA
         0kMg==
X-Forwarded-Encrypted: i=1; AL+hErGvcs2MFKIqt8kiCs7BPFOnBuPYOAJVhQBJcSdASeRLonW0p+OxLmQ84kouQ7Kgunln/8+seh7I/lqhhubI9g==@groups.io
X-Gm-Message-State: APuU4Z/hvFYpzxgcRjDIgO27naItiPrgpK69dOBgF3XZc+fgWuq4jbvK
	RYsChjHB1mIxXsUegtvoy1wp6S4SD6AtNbk1J+uBwamB+CVBkDnZjie6wHBR0Acs23qRmFRtp1q
	wD8Lf
X-Gm-Gg: AZFdTZeBcuCoRV7eG5S0OOJ8eOXULf5+FNVXyOIbihCCiVH02U2l5po8mTyfuRr3c5n
	ZfPPE+ynx4PjrA47Om1VnSl1XRpMuW6RPXFAPu4nXaTd6dT7zjfnpjXYqDLudp1ExaxaSir1xoa
	1ImPfZl/ahu4gXa9+xw6txsRlsmCg1mMghg/DG4R7bGhen244RoJIq5S3S758SDpbEUzdTI93+d
	iNXRV0F/RXtaOIDqYMqafGPlYIl6LjYW9iSDdRCR1HdgrIXN2UhZY0CTv7Vfb4yt0OBBfXGM/RQ
	n0OZvqGhzFl4L9cCqyCoFrGxGCNO/1FpJDONnn7xlkQ70KtcPpWDixXXiggZMTNIAEDazxKq4Z8
	+XRHX60Yg4kwwkRDeREb+9HCVw/wWLnlZ5ZLOsjHmAaSxNNNWyeE0d7EPEBEr8i4w1AmuODp9KG
	K8t5PxMa5BtBGHiDlJlgdETsiah9h7FiBhnGf2tRmebHeWzgIOtcRAlhJnLl0HPkiHYFtLdlVM5
	Rs+Z8Sl4nNOcf3Wysisen/9W+zi4cZf+jpJqD3OlNaUBVRU7DuTMlTu/M0BfmeQCeIuwapYZSPx
	Ne3VPx98kEVexTI2Xvcq9bED/IhY6YqshJEExPcnZpY++pTVN4xKS7K7Zqy4+OK/Q53eW0iJtx5
	+5IGA84P/T8/QrCt5C0O0OSy/LM0kJH7QgbhuMtJZx/1+60z9WkNLMCYkbLOZyGWz/qtnjk4wSm
	2fo9u+dtaRTbsSPaWvAU+Zzf3MBg==
X-Received: by 2002:a5d:64c8:0:b0:4a6:c5f4:cdf7 with SMTP id ffacd0b85a97d-4abaa976b7fmr11469286f8f.5.1795264496266;
        Sat, 21 Nov 2026 04:34:56 -0800 (PST)
Return-Path: <dario.binacchi@amarulasolutions.com>
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:34:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Heiko Schocher <hs@nabladev.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Anatolij Gustschin <ag.dev.uboot@gmail.com>,
	Brian Ruley <brian.ruley@gehealthcare.com>,
	David Lechner <dlechner@baylibre.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lukasz Majewski <lukma@nabladev.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	"Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Minkyu Kang <mk7.kang@samsung.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stefano Babic <sbabic@nabladev.com>,
	Tom Rini <trini@konsulko.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ye Li <ye.li@nxp.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH v2 00/25] Support display (and even more) on the BSH SMM S2/PRO boards
Date: Sat, 21 Nov 2026 13:33:50 +0100
Message-ID: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Wed, 25 Nov 2026 12:51:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3152

This series was created out of the need to support simple-framebuffer
for BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was
necessary to develop additional code and/or drivers for all the required
components (i. e. clock, power domain, video, etc.). This series has a
Linux counterpart that will also be submitted upstream as soon as
possible.

Sorry for the long time it took to send this v2. Compared to v1, the
series is rebased on top of the clock reparenting rework that came out
of the discussion with Miquel [1], the board-specific PLL enabling is
replaced by a generic handling of the critical clocks in the clock
framework, the patches already merged have been dropped, and the
i.MX8MP media block control is left to the imx8mp-mediamix driver.

Tested on the BSH SMM S2 PRO.

[1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@bootlin.com/

Changes in v2:
- Add patch, replacing "clk: imx8mn: Mark IMX8MN_SYS_PLL2 and
  IMX8MN_SYS_PLL3 as enabled" with a generic solution
- Reword subject and commit message to describe the change
- Fix the coding style of the new clocks
- Add patch
- Rebase on top of the parent enabling now done by clk_set_parent()
- Read the flags from the private clock
- Add CLK_SET_RATE_UNGATE support
- Treat an error pointer returned by clk_get_parent() as no parent
- Reword subject and commit message
- Fix build error
- Drop i.MX8MP support, already provided by the imx8mp-mediamix driver
- Let the power domain uclass count the domain references
- Check the domains allocation
- Reword subject and commit message
- Look up a device as a bridge before looking it up as a DSI host
- Reword commit message
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"
- Add patch, split from "video: Update mxsfb video drivers for
  iMX8MM/iMX8MN display"
- Move the coding style fix and the DE polarity change to separate
  patches
- Bind the DSI host to the DSIM node and drop the
  "samsung,sec-mipi-dsi" compatible
- Fix typo in a comment
- Drop the dsi-host node
- Add commit message
- Drop the custom boot-on properties added to the Linux device tree
- Drop the #if guard around smm_s2_setup_simplefb()
- Fix the style of a comment

Dario Binacchi (9):
  clk: ccf: enable the critical clocks when they are registered
  clk: clk-uclass: fix parent reference counting in clk_set_parent()
  video: mxsfb: add missing space after if
  boot: fdt_simplefb: add a debug message
  video: mxsfb: support simple frame-buffer
  video: bridge: samsung: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: enable simple frame-buffer
  imx8mn_bsh_smm_s2/pro: add splash screen with BSH logo

Michael Trimarchi (16):
  clk: imx8mn: register the main_axi, noc and gic clocks as critical
  clk: implement CLK_OPS_PARENT_ENABLE and CLK_SET_RATE_UNGATE
  clk: imx8mn: add video clocks support
  power: domain: add i.MX8MM/i.MX8MN display block control driver
  video: Add video link framework
  video: bridge: Add check_timing interface
  video: dsi_host: add disable host interface
  video: mxsfb: set the DE polarity from the display timings
  video: Update mxsfb video drivers for iMX8MM/iMX8MN display
  video: Enable DM_UC_FLAG_SEQ_ALIAS for display and bridge
  phy: dphy: add support to calculate the timing based on hs_clk_rate
  phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})
  phy: dphy: Correct clk_pre parameter
  video: bridge: Add Samsung DSIM bridge
  video: Add Synaptics R63353 panel driver
  imx8mn_bsh_smm_s2/pro: Enable display on reference design

 .../dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi  |   16 +
 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c       |   72 +
 boot/fdt_simplefb.c                           |    2 +
 common/stdio.c                                |    4 +
 configs/imx8mn_bsh_smm_s2_defconfig           |   21 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   21 +
 drivers/clk/clk-uclass.c                      |   70 +-
 drivers/clk/clk.c                             |   15 +
 drivers/clk/imx/clk-imx8mn.c                  |  105 ++
 drivers/phy/meson-axg-mipi-dphy.c             |    2 +-
 drivers/phy/phy-core-mipi-dphy.c              |   36 +-
 drivers/power/domain/Kconfig                  |    7 +
 drivers/power/domain/Makefile                 |    1 +
 drivers/power/domain/imx8m-blk-ctrl.c         |  355 ++++
 drivers/power/domain/imx8m-power-domain.c     |  166 +-
 drivers/video/Kconfig                         |   14 +
 drivers/video/Makefile                        |    2 +
 drivers/video/bridge/Kconfig                  |   13 +
 drivers/video/bridge/Makefile                 |    1 +
 drivers/video/bridge/samsung-dsi-host.c       | 1570 +++++++++++++++++
 drivers/video/bridge/samsung-dsim.c           |  165 ++
 drivers/video/bridge/samsung-dsim.h           |   20 +
 drivers/video/bridge/video-bridge-uclass.c    |   11 +
 drivers/video/display-uclass.c                |    1 +
 drivers/video/dsi-host-uclass.c               |   10 +
 drivers/video/mxsfb.c                         |  142 +-
 drivers/video/synaptics-r63353.c              |  228 +++
 drivers/video/video_link.c                    |  448 +++++
 include/configs/imx8mn_bsh_smm_s2.h           |    1 +
 include/configs/imx8mn_bsh_smm_s2_common.h    |    4 +
 include/configs/imx8mn_bsh_smm_s2pro.h        |    1 +
 include/dsi_host.h                            |    8 +
 include/linux/clk-provider.h                  |   12 +-
 include/phy-mipi-dphy.h                       |    3 +
 include/video_bridge.h                        |   20 +
 include/video_link.h                          |   19 +
 tools/logos/bsh.bmp                           |  Bin 0 -> 10644 bytes
 37 files changed, 3521 insertions(+), 65 deletions(-)
 create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
 create mode 100644 drivers/video/bridge/samsung-dsi-host.c
 create mode 100644 drivers/video/bridge/samsung-dsim.c
 create mode 100644 drivers/video/bridge/samsung-dsim.h
 create mode 100644 drivers/video/synaptics-r63353.c
 create mode 100644 drivers/video/video_link.c
 create mode 100644 include/video_link.h
 create mode 100644 tools/logos/bsh.bmp

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
branch: bsh-smm-s2-display

-- 
2.43.0

