Received: by mail-wm1-f51.google.com with SMTP id p6so1574885wmc.1
        for <u-boot-amlogic@groups.io>; Thu, 31 Jan 2019 00:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=aNEyVIjm0HUfwvcOi72gnauk/8XGlvlKA1rqysWbScQ=;
        b=UkQSM/HNLwZs4v6zHGJtkM5upeF0reJaWirvp3vzOYqg2A8lHJyDXQsB+rUpSXNrDH
         Zp0SQgxhuitEosuRpTuzbTKXvD6CX1+CqQnTwcwoYvSdOyRefHubQJyv2LCsbmY2NMN1
         v1jqVzsYieWcwVUGKmZ+QvJJdICZABac4xiAdE4jWYFmo6F0CILvdiGm1lJbar220jt1
         Mg4dtSo8c1eUJfpbsQlHfaw6v7/7K/EyYJv42/EsURixCdvcyL9pc3dvzP2/d2LXLRL9
         pvvfF6EO1vEM56sO/I91jlYdPx1EIpbqgrmVVCqL7lAQXh8uCSIz+ONUkfuZO68kNoqc
         Q4Rg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190129
Message-ID: <f31bd6e3-4980-8a59-3a00-7bbe9cb0e41c@baylibre.com>
Date: Thu, 31 Jan 2019 09:41:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds support for HDMI & CVBS video output support for Amlogic GX SoCs.
For simplicity, Anatolij acked to include the video patches along the platform
changes in this PR.
Video has been enabled only on libretech-cc, but will be enabled on the other
boards after broader testing.

Thanks,
Neil


The following changes since commit 535d74a8ae8d194269cefdf59ae17a92cd6e75dc:

  MAINTAINERS: Add Amlogic entry (2019-01-30 21:22:53 -0500)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190131

for you to fetch changes up to fce1069bfb9b0b12fb760c408833c33243492257:

  arm: libretech-cc: enable video by default (2019-01-31 09:35:01 +0100)

----------------------------------------------------------------
- Add features and fixups to support video on Amlogic GX SoCs
- Add video support for Amlogic GX SoC
- Add DT fixups
- Enable Video and USB Console for libretech-cc board

----------------------------------------------------------------
Jorge Ramirez-Ortiz (2):
      video: dw_hdmi: support SoC specific read/write ops
      video: dw_hdmi: add support for color conversion

Maxime Jourdan (6):
      power: domain: meson-gx-pwrc-vpu: add missing depends
      arm64: dts: meson-gx: vpu should be probed before relocation
      arm64: dts: meson-gx: add hhi reg entry to hdmi_tx
      arm: meson: board-gx: Setup VPU in fdt
      arm: meson64: enable console mux and console env by default
      arm: libretech-cc: enable video by default

Neil Armstrong (3):
      video: Add Meson Video Processing Unit Driver
      arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
      configs: meson64: use vidconsole and usbkbd if enabled

 arch/arm/dts/meson-gx-u-boot.dtsi                  |   21 +
 arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi      |    7 +
 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi       |    7 +
 .../arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi |    7 +
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |    1 +
 .../dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi   |    7 +
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |    1 +
 arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi      |    7 +
 arch/arm/dts/meson-gxl-s905x-p212.dts              |    1 +
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi     |    7 +
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |    1 +
 arch/arm/include/asm/arch-meson/meson-vpu.h        |   13 +
 arch/arm/mach-meson/board-gx.c                     |    5 +
 configs/khadas-vim2_defconfig                      |    2 +
 configs/khadas-vim_defconfig                       |    2 +
 configs/libretech-cc_defconfig                     |    8 +
 configs/odroid-c2_defconfig                        |    2 +
 configs/p212_defconfig                             |    2 +
 drivers/power/domain/Kconfig                       |    2 +-
 drivers/video/Kconfig                              |    2 +
 drivers/video/Makefile                             |    1 +
 drivers/video/dw_hdmi.c                            |  267 +++-
 drivers/video/meson/Kconfig                        |   12 +
 drivers/video/meson/Makefile                       |    9 +
 drivers/video/meson/meson_canvas.c                 |   45 +
 drivers/video/meson/meson_dw_hdmi.c                |  445 ++++++
 drivers/video/meson/meson_dw_hdmi.h                |  134 ++
 drivers/video/meson/meson_plane.c                  |  177 +++
 drivers/video/meson/meson_registers.h              | 1393 +++++++++++++++++++
 drivers/video/meson/meson_vclk.c                   |  893 ++++++++++++
 drivers/video/meson/meson_venc.c                   | 1464 ++++++++++++++++++++
 drivers/video/meson/meson_vpu.c                    |  211 +++
 drivers/video/meson/meson_vpu.h                    |   97 ++
 drivers/video/meson/meson_vpu_init.c               |  440 ++++++
 drivers/video/meson/simplefb_common.c              |   29 +
 drivers/video/meson/simplefb_common.h              |   21 +
 include/configs/meson64.h                          |   23 +
 include/dw_hdmi.h                                  |   74 +
 include/media_bus_format.h                         |  156 +++
 39 files changed, 5992 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/dts/meson-gx-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/meson-vpu.h
 create mode 100644 drivers/video/meson/Kconfig
 create mode 100644 drivers/video/meson/Makefile
 create mode 100644 drivers/video/meson/meson_canvas.c
 create mode 100644 drivers/video/meson/meson_dw_hdmi.c
 create mode 100644 drivers/video/meson/meson_dw_hdmi.h
 create mode 100644 drivers/video/meson/meson_plane.c
 create mode 100644 drivers/video/meson/meson_registers.h
 create mode 100644 drivers/video/meson/meson_vclk.c
 create mode 100644 drivers/video/meson/meson_venc.c
 create mode 100644 drivers/video/meson/meson_vpu.c
 create mode 100644 drivers/video/meson/meson_vpu.h
 create mode 100644 drivers/video/meson/meson_vpu_init.c
 create mode 100644 drivers/video/meson/simplefb_common.c
 create mode 100644 drivers/video/meson/simplefb_common.h
 create mode 100644 include/media_bus_format.h
