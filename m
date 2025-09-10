Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBFBCA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 18:13:43 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
 by mx.groups.io with SMTP id smtpd.web11.26230.1757528022753681463
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 11:13:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=c9pXIURA;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.179, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757528020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m+5kdVhEBn6t3eZvc1dML/BimhYcsvsKQbdMcxNxFjg=;
	b=c9pXIURAjYBuw2IDPrVShCAsRigWL1dFSTWDaDH+lI8TXBixSaqR6R4HuY32Qt6r/taGSk
	1KJza05KDlT1RMXlxLtdcd3uZw2EzRey3TVbFT12hQAQ1qP989jWM2OizV5oh5CtbzZNj8
	V5z0/yWi5TQ8VABteZq4HQplE5XJvH0kA/6jhGD/3pgFLRyYS3F+jFxCDHkuGvzou9bE7U
	DNSoe2X/nUAuIlZW+L9zsr/6gAQLdYwuEhCaE0RKlC55cQ6dElSDq/QVJnnB2KIUPb9xUe
	RRj4VbXgO+O/5Q9A7W1jyOSW5h9MkleS94KBZhMgnsRs3Jlx8OKkgvRimhaknw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH RFC v2 0/8] initial U-Boot SPL support on Amlogic GX SoCs
Date: Wed, 10 Sep 2025 18:13:20 +0000
Message-Id: <20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMC/wWgC/zXMSQrCMBQG4KuUtzaSwdDGlSB4ALfSRWuGBrUJe
 aFUSu9uCLj8B74N0CRvEM7NBsksHn2YS+CHBp7TMDtDvC4ZOOWSdoISjG/iVsLYqRtlp7UYGZR
 zTMb6tUIPuN+u0Jdy8phD+lZ8YXWqjqLt31kYoUS0QkmtrJWDvcSA+TOkl8kBjyE56Pd9/wG2J
 WobqAAAAA==
X-Change-ID: 20250830-spl-gx-1148b58dd3b1
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5173;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=98VgSiZiVbLuX4BVJ7GalDfEK1nMqDYbMv7Jip+TMqg=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBowb/MNemWp/YSDtppmXRLp09jbzgmtljHRhuC5
 dhRr8jkBFOJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaMG/zAAKCRCEr8vQ14ma
 A7xWD/9x15DTwsOrrKZ2kV7srdT4jVtG6Jwo0Ob6V6HXuXLh4ONN0lgFKq1ycHXAiV0O3NKrRyY
 Q399bG1wnNtls5ENNjK0N9HVlGHGoh21Jde9dPJfBsUKtGI6CyTTPr1N0mZ9xR3tMaFapKTGL6l
 TtCnB1+bRyw3fT5AYaLdi8O77hezHvaMYe610FxrmxdnojMkIMkcMUMtsSMLy+yEkfGuwDMNiiZ
 Jnw+6BuQt9SDORh3/hoiOQqzeR1Xvg486ccgus8fR3sszDwb+shOw3rzGwX4ePOy3ky+kamrjBi
 csXRvbpjODfWbMk5jqdViAktFgrp98Rybge6KnBhX6I1nxX5/Z62iF4fkXtNRrnfRaQKrvugfs2
 GlLzOHB3MMIWxlaXdSwYQWU7GCQSqQcCMHkkWmj9/7I2Ce43+0A3G97hAwgKuaIF4FQa1dLLwXV
 vHNRPBxd1l/75No/A7dEStvesPXcEOw7Pq81Q9Rje5y3Kc8pk1oxQXw4SeC5erGx80hbQ3NI7DA
 NVBqWPtZquuSioOxOLY1SUhaCUV1TfapySL7EFMrN4LucMbfradxeFUKhmkWa7+1sZOGgIvEaOe
 xtV/yDW+xdYFRVId2jLModASif2vJfs/63svMqsY3ujSU6g9LXoQKTeToio3SWTDMItF0/TM9do
 AXQt+zNEsKwa31w==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 18:13:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2764

This RFC/RFT patch series adds support for U-Boot SPL booting on Amlogic
GX SoCs, replacing the historical "bl2.bin" binary that runs as BL2 on
these boards.

Boards tested:
 - Libre Computer LaFrite (S805X, 512 MB)
 - Libre Computer LePotato (S905X, 1 GB)
 - Videostrong KII Pro (S905)
 - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
 - (ODROID-C2 (S905) - at some point early in development)

Each of these boards were tested booting mainline u-boot and TF-A BL31,
either from an SD card or using Ymodem, and then booting to Linux.

More testing is, of course, very much welcome.  In particular, further
testing of other boards that could not be tested, of the ODROID-C2, and
of the 2 GB LePotato would be appreciated.

Currently known issues:
 - LPDDR2/LPDDR3 support not implemented
 - some DRAM rank modes are not supported
 - eMMC booting is broken (pwrseq?)
 - SPI boot is untested
 - we are quite limited in space, so e.g. the clock driver does not fit
   (TPL might be considered in the future)

See doc/board/amlogic/spl.rst for building and installation instructions.

This patch series depends on Jonas Karlman's amlimage work, which was
sent in the mailing list [2].  It has been rebased for resending as part 
of this patch series.  Thanks Jonas!

I would like to also thank Libre Computer and MNT Research for donating
boards to me and the rest of the linux-amlogic community for the
invaluable help.

[1]: https://scm.dersco.re/amlogic/u-boot-kii-pro.git/commit/?h=wip/spl-aquaman-2025.08&id=d030951d0aaac04f1e2cc8a8eb01eb662a782f21
[2]: https://lore.kernel.org/all/20250103215904.2590769-1-jonas@kwiboo.se/

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v2:
 - Drop "mmc: meson_gx_mmc: don't bail if there is no clock driver",
   given SPL does not use the DM MMC driver by default anyway
 - Drop spurious DM_DRIVER_ALIAS from UART driver
 - Document in send_scp() why it is only needed for GXBB
 - Move GXBB/GXL-specific code to separate spl-gxbb/spl-gxl files
 - Add a few defines for pll init
 - Actually disable FIT image post-processing on GXL
 - Add Neil's R-b tag (subset)
 - Link to v1: https://lore.kernel.org/r/20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org

---
Ferass El Hafidi (7):
      mmc: meson_gx_mmc: add minimal non-DM driver
      serial: serial_meson: add minimal non-DM driver
      arm: meson: initial u-boot SPL support for GX SoCs
      arm: meson: spl: add support for SPL DRAM init
      arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
      board: amlogic: add kconfig fragments for SPL
      doc: board: amlogic: add u-boot-spl documentation

Jonas Karlman (1):
      tools: mkimage: Add Amlogic Boot Image type

 MAINTAINERS                                        |   1 +
 arch/arm/dts/meson-gx-u-boot.dtsi                  | 142 +++++++
 arch/arm/include/asm/arch-meson/clock-gx.h         |   1 +
 arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++++
 arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
 arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
 arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
 arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
 arch/arm/include/asm/arch-meson/gx.h               |  41 ++
 arch/arm/mach-meson/Kconfig                        | 112 +++++-
 arch/arm/mach-meson/Makefile                       |  10 +
 arch/arm/mach-meson/board-common.c                 |  11 +
 arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
 arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
 arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
 arch/arm/mach-meson/spl-gx.c                       | 179 +++++++++
 arch/arm/mach-meson/spl-gxbb.c                     | 113 ++++++
 arch/arm/mach-meson/spl-gxl.c                      |  39 ++
 arch/arm/mach-meson/spl.c                          | 123 ++++++
 board/amlogic/p200/spl-odroid-c2.config            |  37 ++
 board/amlogic/p200/spl-videostrong-kii-pro.config  |  38 ++
 board/amlogic/p212/spl-libretech-cc-1gb.config     |  36 ++
 board/amlogic/p212/spl-libretech-cc-2gb.config     |  38 ++
 boot/image.c                                       |   1 +
 doc/board/amlogic/index.rst                        |   1 +
 doc/board/amlogic/pre-generated-fip.rst            |   9 +
 doc/board/amlogic/spl.rst                          |  77 ++++
 drivers/mmc/meson_gx_mmc.c                         |  75 +++-
 drivers/serial/serial.c                            |   2 +
 drivers/serial/serial_meson.c                      | 110 +++++-
 include/image.h                                    |   1 +
 tools/Makefile                                     |   1 +
 tools/amlimage.c                                   | 246 ++++++++++++
 33 files changed, 3316 insertions(+), 3 deletions(-)
---
base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0
change-id: 20250830-spl-gx-1148b58dd3b1

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


