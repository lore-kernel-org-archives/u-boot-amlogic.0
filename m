Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB0CCD1A3
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:24 +0000 (UTC)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
 by mx.groups.io with SMTP id smtpd.web11.22367.1760545573007716462
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 09:26:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=jl5Jhynm;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.172, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760545570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/KC+bMXU8CAIuypmLaSZ7nbr3Nx/tG/uz0rgLju4Twk=;
	b=jl5JhynmGncPgs2802LoQvAcndj157quRqWXXDZ/bF6BYMPjycDW2Gte9XCFVlRjYPmwv7
	+uOAOIko06Iw0f88Q+1Zjp9h9wTrj2KHKXqJJrxkTa/I4UYUYVTekK3/nL5oPmffhUyuub
	feVfwRfixKh3OjzK+T2xFgB/N7KFncTuG06grkioi2uWIvaTvgeI73q6RmOB9++ZUHI5Ys
	pE6ZRk/0LyVcW6Wd71OesfYtOukBHKQLwcb2jHu+Ll6/NdPhpJRPYQfsuBizRTqJd8Bjhy
	RnhkRQ28bx3ezI0KU86RWkOupPPwZavYx2MeFuAsI4zUWOwWdn1qXyzg62PBkA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v4 0/8] initial U-Boot SPL support on Amlogic GX SoCs
Date: Wed, 15 Oct 2025 16:25:47 +0000
Message-Id: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAzL72gC/3XOSw7CIBhG0a0YxmJ4CjhyH8YBLdAStTTQkJqme
 5fW2DjQ4feHc8MEko3eJnDaTSDa7JMPXRlsvwN1q7vGQm/KBgQRjiRFMPV32IwQYyYrLo2hFQb
 lcR+t8+MaulzLbn0aQnyu3YyX6zuhkPgkMoYIUkEVN8o5rt25D2l46HizQ0iHEBuwlDL50nj7Q
 CZFS8eJ1jUTFrE/mm4aIyQ3TYvmSqkjFcaxSv3Q8zy/ALoJDZYfAQAA
X-Change-ID: 20250830-spl-gx-1148b58dd3b1
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5854;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=UiZADVmRAZQYuOelPlZBVOqR9TpQW4yVSdd2qaWd+Zs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sZj8axt5QAU2Ctv2mQW2Azk9TKUszKjZPM5
 QqNLK7rwiqJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LGQAKCRCEr8vQ14ma
 AyiOEACes/S5iNN51ZoTgUzT/IpG5/A05qscE2NjfUes29GzvkbrMrCDBVBbTFU8dLbFnhX4fre
 MVjnzm69XQvZKj8CwTL+/QfoH7ZVvG9qMa2DL6ePPCDhYKe+HdVNB/XH3yVuMK6bxq7Ho8sG2C0
 RQfGtn6toBXtfyxCadXCXRGhLuAlN9CChuf6sGvpXP99u0hAgoejkBmZLo95ZWZn9An1bPZMXaR
 ttHekrqY4mJanTRajrrp5m86TmB4eTNwrTmET5wxLM5tuKR8c9SAqtwgcw8x4SDkI6j3X5Zfi8l
 GZQOz0wb774/XUYfNLnh1P5NcjdxOwrUbwWqoJrqzyCPEfqBtjI248/UZzU534HWBpH95Iei58J
 JtD/AIBoBbO/ECB0NazpkcSM6I4Rk49KfiY9ujhI3vFq4TlsEqwdSftdtplYNAXpAzqfs8/5hq7
 RSktW3DbJKuZ4Z/GX/xjd/OHgu9m+zignLwN9HGWPA2f+Jhbr7Ue3eTi/UBIiUUP5F7TRQjhZNf
 Wxnr76umn3pvEW/MUKNB1OOMdGNhHIgw1G5Eb/IpUFOHo5O0/6XNh3JyCZSUPc19PFqLpAZcnfG
 l4kbQokNjJJBdXzlUNTCZ21TIozeOqjxS/mnKHYv93qloON/uq7jcfDhNZwHgAMPgOVl7BWrpHQ
 YgzHH5F7gEOcNMg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 16:26:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2813

This patch series adds support for U-Boot SPL booting on Amlogic GX SoCs,
replacing the now legacy "bl2.bin" binary that runs as BL2 on these boards.

Boards tested:
 - Libre Computer LaFrite (S805X, 512 MB)
 - Libre Computer LePotato (S905X, 1 GB)
 - Videostrong KII Pro (S905)
 - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
 - ODROID-C2 (S905)

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
Changes in v4:
 - Remove "RFC" prefix, no longer an RFC patch (but still testing
   and feedback very much welcome)
 - Continue using meson_gx_mmc_is_compatible in DM MMC driver
 - Fix typo in amlimage secure boot info printf
 - Drop FIT image post-processing on libretech-cc
 - Add Neil's R-b tags for all the other patches except MMC patch
 - Link to v3: https://lore.kernel.org/r/20251008-spl-gx-v3-0-5999637df4b9@postmarketos.org

Changes in v3:
 - Do not depend on DEBUG_UART_BASE in the non-DM UART driver
 - Grammar fixes in documentation
 - amlimage: check digest type in _print_header, version in _verify_image
 - Link to v2: https://lore.kernel.org/r/20250910-spl-gx-v2-0-8f52aac47e04@postmarketos.org

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
 arch/arm/include/asm/arch-meson/clock-gx.h         |  14 +
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
 arch/arm/mach-meson/spl-gx.c                       | 168 +++++++++
 arch/arm/mach-meson/spl-gxbb.c                     | 113 ++++++
 arch/arm/mach-meson/spl-gxl.c                      |  39 ++
 arch/arm/mach-meson/spl.c                          | 123 ++++++
 board/amlogic/p200/spl-odroid-c2.config            |  37 ++
 board/amlogic/p200/spl-videostrong-kii-pro.config  |  38 ++
 board/amlogic/p212/spl-libretech-cc-1gb.config     |  35 ++
 board/amlogic/p212/spl-libretech-cc-2gb.config     |  37 ++
 boot/image.c                                       |   1 +
 doc/board/amlogic/index.rst                        |   1 +
 doc/board/amlogic/pre-generated-fip.rst            |   9 +
 doc/board/amlogic/spl.rst                          |  77 ++++
 drivers/mmc/meson_gx_mmc.c                         |  77 ++++
 drivers/serial/serial.c                            |   2 +
 drivers/serial/serial_meson.c                      | 119 +++++-
 include/image.h                                    |   1 +
 tools/Makefile                                     |   1 +
 tools/amlimage.c                                   | 255 +++++++++++++
 33 files changed, 3337 insertions(+), 2 deletions(-)
---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20250830-spl-gx-1148b58dd3b1

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


