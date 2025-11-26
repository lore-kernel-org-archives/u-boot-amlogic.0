Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C767D10F25
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 12:17:35 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11618.1764159453878712332
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Nov 2025 04:17:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=OARmd+PQ;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.179, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1764159451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PnX7wWKRJkwcU2CNGUKoXiFgnMk4/qUMOWykPosJaIk=;
	b=OARmd+PQHeSamN9CbyIHkYiA+kcxlRZEBnDKb+u0s2Abu+v2AeswTMVT/zinnGe+8oQn0p
	pWzxFzNlxyIw5GvDq7apVRAAUOpniMPOAl5jyqqAIhNLxMOkb8FcujN3M3mcpHe5ooqWES
	bXrtZb3iETNqn5gGgu9WIlfTAwrT+EgrFq3Nt7ie6VuZ60mG9zSEbp1jjSjzfIXr2HKDal
	/dCmlFjSwoE/xJq+oYSnLk9HNcMGCyWO0xItS7N0gggL+xMAop8keqegyrjSgKcbYyQ74q
	uqvuN34POnb26zocU5/aYEfA4x5OlH7dIl04mL9M0T82leSVQnydS1zgvUItmA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v5 00/10] initial U-Boot SPL support on Amlogic GX SoCs
Date: Wed, 26 Nov 2025 12:17:02 +0000
Message-Id: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7vJmkC/3XOzY7CIBSG4VsxrMUcfo6AK+/DzIIKVKKWBhrix
 PTeB53YuNDld8LzhjspPkdfyG51J9nXWGIa2sD1ihxPdug9ja5twoEjaAG0jBfa3yhjUneonRM
 dI+3xmH2It2fo8NP2KZYp5d9nt7LH9T9hQL0SlVGgQgmDzoSANuzHVKarzWc/pbJJuSePUuVvm
 i0fqLxpHZBbe5TKg/yixaIZgF60aBqNMVuhXJCd+aLlm2a4aNl0QKeCB8E5dh/0PM9/yzu1/F0
 BAAA=
X-Change-ID: 20250830-spl-gx-1148b58dd3b1
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7632;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=BqWoiW8i4TOC5l10Cz2acVyJu8+vFQnzK645CgdXS8Y=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/RegU7ypE0QVX7O89XRE0qyRnxmXWpyHmd2
 Lxu4X3tHziJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv0QAKCRCEr8vQ14ma
 A3luEACYFIlOz6B1S0BhcymmU6Gfy0m8S3+gnoKqBDaPbw3JZ+LxlWox4ndLI26DZil/dsabs7J
 DUpUPgIZ3b2qB//TlCLH60hjaJoNEkG5GTMPThxId4N8Nx14TRU0jxbSlaF5EDhOvTXJ3F0k5pp
 vhp7EyQbpfcpjQtBajFBZ4i5ISKim+zmmQlMUPtVt81vTqOMyz5in0ekcuL+Fv9CG8RJEHOI1wB
 ElywpO2mpwg0CqcNOyQ1Nb8etnqmbaVRBnJnMTviPFGB0YqXKP1mjmlVV9u4sJ6q8rmWhqabnOM
 kk2339bgyTnNvEDsdVByJptTBYsWoxVUFes0cyNFzC+uBqNPETol6y+IIn8NGI6UOHZB/MrjZEt
 ftdisxqumKl02zam17sLQ4tZzu6LC43aEfYZhZb+nX3qSNMWd6O3KH5eW59WSpFvNrUdLpgNSCV
 MOk1zwYjPGAEoezca2/wVFCi/St/3Vic51CoCcjll+hBNYB5C1q0SJD4E5p91NJU97ga6rw50un
 GMWnxWq8Vfn0coKh/dwZq9rkhfoVPjh7u6wU+dund0/XV2UmKdMkFGa+4h5tnq/luHQaEQ0lRbG
 29lE50wgQmWJoUF6ppM9bup3vqt77JHKKGEcSZMAtivxq1Gf+FgdJGo3UZTAqzOmSQbrYJCKUon
 dyIkyXALWHuxQWQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Nov 2025 12:17:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2851

This patch series adds support for U-Boot SPL booting on Amlogic GX SoCs,
replacing the "bl2.bin" binary blob running as TF-A BL2 on these boards.

Boards tested:
 - Libre Computer LePotato (S905X, 1 GB)
 - Videostrong KII Pro (S905)
 - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
 - ODROID-C2 (S905)

Each of these boards were tested booting mainline u-boot and TF-A BL31,
either from an SD card or using Ymodem, and then booting to Linux.

More testing is, of course, very much welcome. In particular, further
testing of other boards that could not be tested, of the ODROID-C2, and
of the 2 GB LePotato would be appreciated.

Currently known issues:
 - LPDDR2/LPDDR3 support not implemented
 - some DRAM rank modes are not supported
 - eMMC booting is broken (pwrseq?)
 - SPI boot is untested
 - we are quite limited in space, so e.g. the clock driver does not fit

Future work:
 - add logic to automatically detect rank mode and DRAM size
 - investigate using U-Boot TPL to free some space
   - may fix eMMC booting as a side effect
 - support more rank modes
 - add support for Amlogic g12b/sm1 SoCs
 - ...

See doc/board/amlogic/spl.rst for building and installation instructions.

This patch series depends on Jonas Karlman's amlimage work, which was
sent in the mailing list [2]. It has been rebased for resending as part 
of this patch series. Thanks Jonas!

I would like to also thank Libre Computer and MNT Research for donating
boards to me and the rest of the linux-amlogic community for the
invaluable help.

[1]: https://scm.dersco.re/amlogic/u-boot-kii-pro.git/commit/?h=wip/spl-aquaman-2025.08&id=d030951d0aaac04f1e2cc8a8eb01eb662a782f21
[2]: https://lore.kernel.org/all/20250103215904.2590769-1-jonas@kwiboo.se/

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v5:
 - Mention future work in cover letter
 - Remove unrelated changes from binman patch
 - Enforce SPL max size at build system level rather than at the mkimage
   level
 - Add meson-gxbb-u-boot.dtsi (similar to already existing
   meson-gxl-u-boot.dtsi)
 - DT: Drop a few #define's:
   - BL31_ADDR => BL31 address now set in gxbb/gxl-u-boot DTSI
   - SCP_ADDR
   - Don't check CONFIG_MESON_GX (already implied)
 - DT: SHA256 hash on all images
   - Check CONFIG_SPL_FIT_SIGNATURE and CONFIG_SPL_SHA256 (except for
     SCP image, not a dealbreaker if it cannot be verified in SPL, as it
     is verified by the SCP bootROM anyway)
 - DT: move mkimage args to gxbb/gxl-u-boot DTSI
 - Mention AML_STDPARAMS=1 in TF-A building docs
 - Fix typo in spl.c (s/YMODEM/YMODEM_SUPPORT/)
 - Link to v4: https://lore.kernel.org/r/20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org

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
Ferass El Hafidi (9):
      mmc: meson_gx_mmc: add minimal non-DM driver
      serial: serial_meson: add minimal non-DM driver
      arm: meson: initial u-boot SPL support for GX SoCs
      arm: meson: spl: add support for SPL DRAM init
      arm: dts: meson: add meson-gxbb-u-boot.dtsi
      arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
      board: amlogic: add kconfig fragments for SPL
      spl: meson: set SPL max size for GX SoCs
      doc: board: amlogic: add u-boot-spl documentation

Jonas Karlman (1):
      tools: mkimage: Add Amlogic Boot Image type

 MAINTAINERS                                        |   1 +
 arch/arm/dts/meson-gx-u-boot.dtsi                  | 125 ++++++
 arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi        |   2 +-
 arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi      |   2 +-
 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi       |   2 +-
 arch/arm/dts/meson-gxbb-p200-u-boot.dtsi           |   2 +-
 arch/arm/dts/meson-gxbb-p201-u-boot.dtsi           |   2 +-
 arch/arm/dts/meson-gxbb-u-boot.dtsi                |  27 ++
 arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi      |   2 +-
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi    |   2 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi                 |  20 +
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
 board/amlogic/p200/spl-odroid-c2.config            |  38 ++
 board/amlogic/p200/spl-videostrong-kii-pro.config  |  39 ++
 board/amlogic/p212/spl-libretech-cc-1gb.config     |  36 ++
 board/amlogic/p212/spl-libretech-cc-2gb.config     |  38 ++
 boot/image.c                                       |   1 +
 common/spl/Kconfig                                 |   1 +
 doc/board/amlogic/index.rst                        |   1 +
 doc/board/amlogic/pre-generated-fip.rst            |   9 +
 doc/board/amlogic/spl.rst                          |  77 ++++
 drivers/mmc/meson_gx_mmc.c                         |  77 ++++
 drivers/serial/serial.c                            |   2 +
 drivers/serial/serial_meson.c                      | 119 +++++-
 include/image.h                                    |   1 +
 tools/Makefile                                     |   1 +
 tools/amlimage.c                                   | 255 +++++++++++++
 43 files changed, 3379 insertions(+), 9 deletions(-)
---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20250830-spl-gx-1148b58dd3b1

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


