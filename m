Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF5FCF58F9
	for <webhook@archiver.kernel.org>; Fri, 20 Sep 2024 09:27:38 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.69906.1726221421839191307
 for <u-boot-amlogic@groups.io>;
 Fri, 13 Sep 2024 02:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=TaFk4Q8R;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.208.51, mailfrom: dario.binacchi@amarulasolutions.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c3ed267a7bso2165447a12.3
        for <u-boot-amlogic@groups.io>; Fri, 13 Sep 2024 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1726221420; x=1726826220; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swiTdlXpxz7ztsvlYK79VGvCm12s6t/1zlzaJmhbPu8=;
        b=TaFk4Q8RprSXRH5nPwACMSZN9Pz7XTNrXcmjw2gKXZwxhU13AQv8AMi0Z7/uWUDW/T
         FrnklZeIrdDOPLFKrBB2ZYudA+oAxtGwlCMWkDsyXJZZONKi0xVzI6IhHZIxarvgf13t
         AhhqK2PRNxaH1+w6pCZeJiGbepgbLEKRIZAWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221420; x=1726826220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swiTdlXpxz7ztsvlYK79VGvCm12s6t/1zlzaJmhbPu8=;
        b=eyYVj91mLMVNuQ563049sLVnq623pu8t7tVNFeluSCrxqe7Pb9po9875vY82a2KEpR
         DoZlzmvz4sHQYjcs1Fuy2O9uYiBc7c6JAwmH3TMZ6CVn1lkyxW/9yh90NX5+U8SZNVdI
         BujMPkHqZVR8SL3dn3tpXobSZOlsO0p87by9fgCg+lH4mkIyv31QDKraw02yxGFxT/ae
         F3Xz2YAoKEtQgjO4GbZiOcR41GLquF/0xZRLfxlg2SMxjlyyFMkg9pho2DyxCfa5yqzf
         EiKl4q2Mw27UUeW/a4Qh42l7i++eIgan8kcXPPJrfGkNGAtcy8vjxOdDsEKtpgEp1HoJ
         t+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWkRkBq5gYXY97J9K8qCXye8t+FJBOvEd3X9niLvzCP2WH9N4b3oRt12P2Q2FNSazrUSpj/rUHv7pelC87UvA==@groups.io
X-Gm-Message-State: AOJu0YxvrG+/Hup8tIy2owse67Dwp7NmRfR9daEjv3Nn6ds15JS5LCTH
	mVZdiUQCMAuDF5a9imR5/iSoTrGvGjOFxiD7DtSKiq9JfuquKkbTZ2puw36hxN4=
X-Google-Smtp-Source: AGHT+IGLl12s3eWwNMQAnqBHvSe8OPkRJojHZeHEtacQm0VkuqPbz2JNV3Wa01/dbRiAwJV9HtJReg==
X-Received: by 2002:a17:907:940e:b0:a8d:2ab2:c9b1 with SMTP id a640c23a62f3a-a90296716efmr520301166b.56.1726221419343;
        Fri, 13 Sep 2024 02:56:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-4-102-18.retail.telecomitalia.it. [87.4.102.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cee72bsm863224766b.173.2024.09.13.02.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:56:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	AKASHI Takahiro <akashi.tkhro@gmail.com>,
	Alexander Dahl <ada@thorsis.com>,
	Anatolij Gustschin <agust@denx.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Anton Bambura <jenneron@protonmail.com>,
	Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
	Devarsh Thakkar <devarsht@ti.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Igor Prusov <ivprusov@salutedevices.com>,
	Igor Prusov <ivprusov@sberdevices.ru>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joe Hershberger <joe.hershberger@ni.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Julien Masson <jmasson@baylibre.com>,
	Liu Ying <victor.liu@nxp.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Marek Vasut <marex@denx.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Minkyu Kang <mk7.kang@samsung.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
	Nikhil M Jain <n-jain1@ti.com>,
	Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
	Peng Fan <peng.fan@nxp.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Sean Anderson <seanga2@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	Stefan Bosch <stefan_b@posteo.net>,
	Stefano Babic <sbabic@denx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Tom Rini <trini@konsulko.com>,
	Vinod Koul <vkoul@kernel.org>,
	Yang Xiwen <forbidden405@outlook.com>,
	Ye Li <ye.li@nxp.com>,
	u-boot-amlogic@groups.io
Subject: [PATCH 00/26] Support display (and even more) on the BSH SMM S2/PRO boards
Date: Fri, 13 Sep 2024 11:55:42 +0200
Message-ID: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 20 Sep 2024 09:27:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2395


This series was created out of the need to supportsimple-framebuffer for
BSH boards SMM_S2 and SMM_S2PRO. To achieve this goal, it was necessary
to develop additional code and/or drivers for all the required components
(i. e. clock, power domain, video, etc.). This series has a Linux
counterpart that will also be submitted upstream as soon as possible.
Furthermore, given the overlap in topics with the recent series [1], we
are open to collaborate on the common parts to ensure proper development.

[1] https://lore.kernel.org/all/20240910101344.110633-1-miquel.raynal@bootlin.com/T/#mb7cd440abc6fcc0de205f577eb3225e1c1c76823


Dario Binacchi (6):
  boot: fdt_simplefb: add a debug message
  video: mxsfb: support simple frame-buffer
  video: bridge: samsung: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: support simple frame-buffer
  imx8mn_bsh_smm_s2/pro: enable simple frame-buffer
  imx8mn_bsh_smm_s2/pro: add splash screen with BSH logo

Michael Trimarchi (20):
  clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE present for gate
    and mux
  clk: imx8mn: Prevent clock critical path from disabling during
    reparent and set_rate
  clk: imx8mm: Prevent clock critical path from disabling during
    reparent and set_rate
  clk: clk-uclass: Implement CLK_OPS_PARENT_ENABLE
  clk: imx8mm: Mark IMX8MM_SYS_PLL2 and IMX8MM_SYS_PLL3 as enabled
  clk: imx8mn: Mark IMX8MN_SYS_PLL2 and IMX8MN_SYS_PLL3 as enabled
  clk: imx8mn: add video clocks support
  power: Add iMX8M block ctrl driver for dispmix
  video: Add video link framework
  video: bridge: Add check_timing interface
  video: dsi_host: add disable host interface
  video: Update mxsfb video drivers for iMX8MM/iMX8MN display
  video: Enable DM_UC_FLAG_SEQ_ALIAS for display and bridge
  phy: dphy: add support to calculate the timing based on hs_clk_rate
  phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})
  phy: dphy: Correct clk_pre parameter
  lib: div64: sync with Linux
  video: bridge: Add Samsung DSIM bridge
  video: Add Synaptics R63353 panel driver
  imx8mn_bsh_smm_s2/pro: Enable display on reference design

 .../dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi  |   23 +
 board/bsh/imx8mn_smm_s2/imx8mn_smm_s2.c       |   99 ++
 boot/fdt_simplefb.c                           |    2 +
 common/stdio.c                                |    4 +
 configs/imx8mn_bsh_smm_s2_defconfig           |   21 +
 configs/imx8mn_bsh_smm_s2pro_defconfig        |   21 +
 drivers/clk/clk-gate.c                        |    1 +
 drivers/clk/clk-mux.c                         |    2 +-
 drivers/clk/clk-uclass.c                      |   67 +-
 drivers/clk/clk.c                             |    9 +
 drivers/clk/imx/clk-imx8mm.c                  |   73 +-
 drivers/clk/imx/clk-imx8mn.c                  |  131 +-
 drivers/phy/meson-axg-mipi-dphy.c             |    2 +-
 drivers/phy/phy-core-mipi-dphy.c              |   36 +-
 drivers/power/domain/Kconfig                  |    6 +
 drivers/power/domain/Makefile                 |    1 +
 drivers/power/domain/imx8m-blk-ctrl.c         |  438 +++++
 drivers/power/domain/imx8m-power-domain.c     |  213 ++-
 drivers/video/Kconfig                         |   14 +
 drivers/video/Makefile                        |    2 +
 drivers/video/bridge/Kconfig                  |   13 +
 drivers/video/bridge/Makefile                 |    1 +
 drivers/video/bridge/samsung-dsi-host.c       | 1576 +++++++++++++++++
 drivers/video/bridge/samsung-dsim.c           |  151 ++
 drivers/video/bridge/samsung-dsim.h           |   20 +
 drivers/video/bridge/video-bridge-uclass.c    |   11 +
 drivers/video/display-uclass.c                |    1 +
 drivers/video/dsi-host-uclass.c               |   10 +
 drivers/video/mxsfb.c                         |  144 +-
 drivers/video/synaptics-r63353.c              |  228 +++
 drivers/video/video_link.c                    |  529 ++++++
 include/clk.h                                 |    9 +
 include/configs/imx8mn_bsh_smm_s2.h           |    1 +
 include/configs/imx8mn_bsh_smm_s2_common.h    |    4 +
 include/configs/imx8mn_bsh_smm_s2pro.h        |    1 +
 include/dsi_host.h                            |    8 +
 include/linux/clk-provider.h                  |    1 +
 include/linux/math64.h                        |  110 ++
 include/phy-mipi-dphy.h                       |    3 +
 include/video_bridge.h                        |   20 +
 include/video_link.h                          |   19 +
 tools/logos/bsh.bmp                           |  Bin 0 -> 10644 bytes
 42 files changed, 3942 insertions(+), 83 deletions(-)
 create mode 100644 drivers/power/domain/imx8m-blk-ctrl.c
 create mode 100644 drivers/video/bridge/samsung-dsi-host.c
 create mode 100644 drivers/video/bridge/samsung-dsim.c
 create mode 100644 drivers/video/bridge/samsung-dsim.h
 create mode 100644 drivers/video/synaptics-r63353.c
 create mode 100644 drivers/video/video_link.c
 create mode 100644 include/video_link.h
 create mode 100644 tools/logos/bsh.bmp

-- 
2.43.0


