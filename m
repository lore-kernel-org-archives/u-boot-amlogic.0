Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.7764.1675154892214791278
 for <u-boot-amlogic@groups.io>;
 Tue, 31 Jan 2023 00:48:12 -0800
Received: by mail-wm1-f50.google.com with SMTP id q8so9762375wmo.5
        for <u-boot-amlogic@groups.io>; Tue, 31 Jan 2023 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:organization:content-language:cc:to
         :reply-to:subject:from:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYHUMWdHVjAjP6n+0ge93+ed3GFnIHiXlnOZsZRm8Kw=;
        b=ScEQG4RycOB3bRFF9oqDHjnRcS5t3bweNcV3d5aF+mA4At8FjMxaBt0hFTqwgPgEkZ
         CjI/uXb8BB4ZHZKo6nbwVyQ8W2xnOHF/05jqwx3yVdd8vwXllpQ8gHDUBwvhmBlZtrEh
         PZHMrgR85mCDa1ulfWsTCvgXOLOpA34uKmp9HyfDCSdF7DizVoU4suRjKdOfFePI9CjC
         b2MtFPtizIwNXtPhoN0z4qwcr8SVAFi1VvoJbct/dG9M5RbOnwL42n6G7m1DzssaP4/5
         1VQaiJ5wUi0NbDxUfHcp8vDmyfXWgPHOuPbTVT7gM1dOpeKH0Dko40up757nxn/M48aT
         ZfJQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <ec3802ba-6e79-5370-e41e-cd2487cd618f@linaro.org>
Date: Tue, 31 Jan 2023 09:48:09 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20230131
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


Hi Tom,

Sorry for the late PR, here's changes for next release:
- Switch USB Gadget to DM ! Finally, the last legacy bit is now over
- Add new boards:
  - Odroid Go Ultra, a portable console based on S922X
  - Odroid-N2L, a smaller version of the N2+

The PR also contains:
- jethub j100: add rescue boot from microSD
- move meson sm command to cmd/meson and add efusedump sub-command

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/14947

Thanks,
Neil

The following changes since commit 7b84c973b96775576dcff228d865e8570be26c82:

   ns16650: Correct CONFIG_SYS_NS16550_MEM32 platforms (2023-01-09 11:30:49 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20230131

for you to fetch changes up to 8f5e9de121003bfd9a64a5b3a503c0fbd02af823:

   ARM: meson: Add support for Odroid-N2L (2023-01-30 14:24:17 +0100)

----------------------------------------------------------------
- jethub j100: add rescue boot from microSD
- move meson sm command to cmd/meson and add efusedump sub-command
- switch dwc2 otg to DM for G12A, GXL & AXG
- Add new boards:
  - Odroid Go Ultra
  - Odroid-N2L

----------------------------------------------------------------
Alexey Romanov (5):
       asm/arch-meson: add missing meson_sm_write_efuse signature
       arm/mach-meson: move smc commands in cmd/meson
       doc/usage: cmd: documentation for meson/sm command
       cmd/arm: meson: sm: introduce efusedump command
       doc/usage: cmd: sm: documentation efusedump cmd

Mattijs Korpershoek (2):
       usb: dwc3-meson-g12a: force mode on child add/removal
       ARM: meson: g12a: switch dwc2 otg to DM

Neil Armstrong (6):
       usb: dwc3-meson-gxl: force mode on child add/removal
       ARM: meson: switch AXG & GX dwc2 otg to DM
       ARM: dts: sync Amlogic ARM64 DT from v6.2-rc1
       ARM: meson: add support for Odroid Go Ultra
       ARM: dts: Import Odroid-N2L support
       ARM: meson: Add support for Odroid-N2L

Viacheslav Bocharov (1):
       board: amlogic: jethub j100: add rescue boot from microSD

  MAINTAINERS                                        |   1 +
  arch/arm/dts/Makefile                              |   2 +
  arch/arm/dts/meson-g12-common.dtsi                 | 167 +++--
  arch/arm/dts/meson-g12a.dtsi                       |   5 +
  .../arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi |  16 +
  arch/arm/dts/meson-g12b-odroid-go-ultra.dts        | 722 +++++++++++++++++++++
  arch/arm/dts/meson-g12b-odroid-n2.dtsi             | 410 +-----------
  arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi     |   7 +
  arch/arm/dts/meson-g12b-odroid-n2l.dts             | 125 ++++
  arch/arm/dts/meson-g12b-odroid.dtsi                | 445 +++++++++++++
  arch/arm/dts/meson-g12b.dtsi                       |   5 +
  arch/arm/dts/meson-sm1.dtsi                        |  52 +-
  arch/arm/include/asm/arch-meson/sm.h               |  28 +
  arch/arm/mach-meson/board-axg.c                    | 129 ----
  arch/arm/mach-meson/board-g12a.c                   | 127 ----
  arch/arm/mach-meson/board-gx.c                     | 137 ----
  arch/arm/mach-meson/sm.c                           | 144 ----
  cmd/Kconfig                                        |   7 +
  cmd/Makefile                                       |   3 +
  cmd/meson/Makefile                                 |   5 +
  cmd/meson/sm.c                                     | 191 ++++++
  configs/bananapi-m5_defconfig                      |   1 +
  configs/beelink-gsking-x_defconfig                 |   1 +
  configs/beelink-gtking_defconfig                   |   1 +
  configs/beelink-gtkingpro_defconfig                |   1 +
  configs/jethub_j100_defconfig                      |   1 +
  configs/jethub_j80_defconfig                       |   1 +
  configs/khadas-vim2_defconfig                      |   1 +
  configs/khadas-vim3_android_ab_defconfig           |   1 +
  configs/khadas-vim3_android_defconfig              |   1 +
  configs/khadas-vim3_defconfig                      |   1 +
  configs/khadas-vim3l_android_ab_defconfig          |   1 +
  configs/khadas-vim3l_android_defconfig             |   1 +
  configs/khadas-vim3l_defconfig                     |   1 +
  configs/khadas-vim_defconfig                       |   1 +
  configs/libretech-ac_defconfig                     |   1 +
  configs/libretech-cc_defconfig                     |   1 +
  configs/libretech-s905d-pc_defconfig               |   1 +
  configs/libretech-s912-pc_defconfig                |   1 +
  configs/odroid-c4_defconfig                        |   1 +
  configs/odroid-go-ultra_defconfig                  |  70 ++
  configs/odroid-hc4_defconfig                       |   1 +
  configs/odroid-n2_defconfig                        |   1 +
  configs/odroid-n2l_defconfig                       |  70 ++
  configs/radxa-zero_defconfig                       |   1 +
  configs/s400_defconfig                             |   1 +
  configs/sei510_defconfig                           |   1 +
  configs/sei610_defconfig                           |   1 +
  configs/u200_defconfig                             |   1 +
  configs/wetek-core2_defconfig                      |   1 +
  doc/board/amlogic/index.rst                        |   6 +-
  doc/board/amlogic/odroid-go-ultra.rst              |  34 +
  doc/board/amlogic/odroid-n2l.rst                   |  31 +
  doc/usage/cmd/sm.rst                               |  48 ++
  doc/usage/index.rst                                |   1 +
  drivers/usb/dwc3/dwc3-meson-g12a.c                 |  18 +
  drivers/usb/dwc3/dwc3-meson-gxl.c                  |  18 +
  include/configs/jethub.h                           |   1 +
  58 files changed, 2040 insertions(+), 1012 deletions(-)
  create mode 100644 arch/arm/dts/meson-g12b-odroid-go-ultra-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-odroid-go-ultra.dts
  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2l-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-odroid-n2l.dts
  create mode 100644 arch/arm/dts/meson-g12b-odroid.dtsi
  create mode 100644 cmd/meson/Makefile
  create mode 100644 cmd/meson/sm.c
  create mode 100644 configs/odroid-go-ultra_defconfig
  create mode 100644 configs/odroid-n2l_defconfig
  create mode 100644 doc/board/amlogic/odroid-go-ultra.rst
  create mode 100644 doc/board/amlogic/odroid-n2l.rst
  create mode 100644 doc/usage/cmd/sm.rst
