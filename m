Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B72BCAC584
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 14:36:39 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
 by mx.groups.io with SMTP id smtpd.web10.19819.1757255792348487438
 for <u-boot-amlogic@groups.io>;
 Sun, 07 Sep 2025 07:36:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=kCSfPcW8;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.182, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757255789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lgupsgb5roRxBoeeIaVTQ0ZXEdTdlt1CL8aOY/06QRk=;
	b=kCSfPcW8ojF2bWOPkaX0INlIAuxz81MptNK6gS1dQQxSUK2v39dlvhV10wamiRUuevOhXi
	XjXYiF6dYaOUYJBPknliXKUD8sHMM2a8LdHLD14Yk5EkGme87N05kXVwh6dQY7T9XSwg8r
	lDZINnmoB7Vy6dleggfPyCGxCUng6tl5Bzg+PPGgh+jbzJxljGLpzAxWZfK9lILqyKClaR
	ShVmNB6S/CjjK8OQvvVy8DW+Q8/sOBJAcd7q6X3ZoRJJkafbbVRfbvs5R/FksbwOyKYGDh
	JeTqsG0nieApIwVqDm/KtiYWoW5SEl3lWHFOnkSLzmmWZu4XQle2aney7FUh2Q==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH RFC 0/9] initial U-Boot SPL support on Amlogic GX SoCs
Date: Sun, 07 Sep 2025 14:36:06 +0000
Message-Id: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaYvWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC2MD3eKCHN30Cl1DQxOLJFOLlBTjJEMloOKCotS0zAqwQdFKQW7OSrG
 1tQDNcWhcXQAAAA==
X-Change-ID: 20250830-spl-gx-1148b58dd3b1
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4569;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=xUAdv2bp/XXBYMyHuOObJFeUcNP7bgnZxLVh+2KGZkQ=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBovZhqyW05y4dvMc5hfSOyAd22y4PreSURs2h0m
 Pp69y01umGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaL2YagAKCRCEr8vQ14ma
 A6emEACkx/LH6q3DdWX5a9kFkwi2li6sPH/Wvt7zg2mjdRFqjj9XS0nhFQz6ARmG7RGicmMFHwB
 WHcmXm7JXZWpWOnfaHsC/16DX6F+8QC6b46ts+Um1PpsuJu/wVB5NMgru4Sx91pRTHAlfTX7VGM
 aCgWAX6+yNsC20Yf8A6/UYpzWfu/RB3+uI+R1UHuJdRHq4bSNQoG0mGnwbLp11mNulcnbktyCvh
 gYC7mNpaNtFznbgR0SQQ1tQyU6sSUns40H4Q25zx+VNuwBA+cC2cmRkgrAYEQzCpqo4IaFBmmQw
 tvEX7cBt3POTw90AFop+rREJmZgqkcO9m9wvAgn9ooolS8yu1AIZsrYG03IL646cOAIWjM/iByd
 xqi1Gp1zzLcEmEnF8ZfmS56AddQkNMHy9IJYs68YkJRQqtEeHjGnumlEtzj4lvr4CgHyotLk/6e
 PDk+g3qI8T0uqTH1FO09REs167zxqWhHJI3VPY7yJzu9IkqofvDfe5tWqzPwIYjVjlnSkJbvShT
 kRgwFL5PyqE4VRqtRNCxBB2xTxL+OrkC+RwkPESsjiYy+/UEFEhkzK1thbWqQ86saQwk5Xjo+Y2
 86XB2p2aLZO9PuJNawuzMXrlOWfnHzgpM00RJjSVfXV0zSDBxyKYnyZcnt745mMxfdM+8fB+UXz
 M0iAkkrZET4uE0A==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 07 Sep 2025 14:36:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2743

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
Ferass El Hafidi (8):
      mmc: meson_gx_mmc: add minimal non-DM driver
      mmc: meson_gx_mmc: don't bail if there is no clock driver
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
 arch/arm/mach-meson/Makefile                       |   8 +
 arch/arm/mach-meson/board-common.c                 |  11 +
 arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
 arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
 arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
 arch/arm/mach-meson/spl-gx.c                       | 278 ++++++++++++++
 arch/arm/mach-meson/spl.c                          | 123 ++++++
 board/amlogic/p200/spl-odroid-c2.config            |  37 ++
 board/amlogic/p200/spl-videostrong-kii-pro.config  |  38 ++
 board/amlogic/p212/spl-libretech-cc-1gb.config     |  36 ++
 board/amlogic/p212/spl-libretech-cc-2gb.config     |  38 ++
 boot/image.c                                       |   1 +
 doc/board/amlogic/index.rst                        |   1 +
 doc/board/amlogic/pre-generated-fip.rst            |   9 +
 doc/board/amlogic/spl.rst                          |  77 ++++
 drivers/mmc/meson_gx_mmc.c                         |  79 +++-
 drivers/serial/serial.c                            |   2 +
 drivers/serial/serial_meson.c                      | 112 +++++-
 include/image.h                                    |   1 +
 tools/Makefile                                     |   1 +
 tools/amlimage.c                                   | 246 ++++++++++++
 31 files changed, 3265 insertions(+), 5 deletions(-)
---
base-commit: e4c8b32d03d7ecffd586b7d33336603ad639d7c0
change-id: 20250830-spl-gx-1148b58dd3b1

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


