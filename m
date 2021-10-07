Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.11255.1633611583913868634
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Oct 2021 05:59:44 -0700
Received: by mail-wr1-f44.google.com with SMTP id k7so18718696wrd.13
        for <u-boot-amlogic@groups.io>; Thu, 07 Oct 2021 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mMiz82thhF9v0nm2knTiakpzhwFbQTO7VObX5h8TmlQ=;
        b=VOUkBcm0W8Rgv1Xu+jWr/D6h/6O0PZwcfjOx7G8WI0Qc3kYyzeZEovCgxzrExc2Huf
         3Y1UlNy8meCdL7bwYu5C/zvcUlH1MxyOK0B0TLpmvZT6ZiXe5/SJT7KqkGGXBZFWkjDS
         Xj1irJqago3E5eIZnB8cDmo9XGeEGh1XYh1Vsm7+Kp2X5m0OPS1WsHQglrHM3wcG3wX/
         YVcHQ4WDIfuGyRYKB3bWhr9qrRxeGzIDxlrCH1WFciYwsC1g15t1pxXs9JcPqYiZgHxW
         B8kwywZklD1Vt9LwHMTIXojbNQzHdvfKKBJqCD802Qg0YTkFC+juEJa+EyXRFFmhcU5P
         Pkiw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20211007
Reply-To: narmstrong@baylibre.com
Message-ID: <f604ebca-0bac-f2ce-7d96-a7ca28c274bd@baylibre.com>
Date: Thu, 7 Oct 2021 14:59:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here's a bunch of changes concerning:
- Sync DT from Linux 5.14 in order to support those new boards:
  - Odroid-HC4: a variant of Odroid-C4 with 2 SATA ports (via PCIe-SATA bridge)
  - Beelink GS-King X: A variant of the other Beelink board with 2 SATA ports (via USB3-SATA bridge)
  - Banana Pi M5: another credit card SBC
  - JetHub D1/H1: home automation controllers
  - Radxa Zero: another RPi Zero sized SBC
- Other misc changes related to DT update
- PCIe fixup when link init fails
- distro_bootcmd scsi_boot change so we can boot on the Odroid-HC4 SATA disks over the PCIe-SATA bridge

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/9389

Thanks,
Neil

The following changes since commit ea67f467a43e4c8852bd1ce1bb75f5dc6c3788d1:

  Merge branch '2021-10-06-assorted-improvements' (2021-10-06 13:46:31 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20211007

for you to fetch changes up to 506fd30740081541d672ec2651cd23734899af76:

  doc: boards: amlogic: update for Radxa Zero (2021-10-07 13:45:46 +0200)

----------------------------------------------------------------
- Add new SoC ID for S905Y2 found in Radxa Zero
- pcie_dw_meson: fix usb fail when pci link fails to go up
- Sync Amlogic DT from Linux 5.14
- dwc3-meson-gxl: add AXG compatible
- dts: keep back HW order for MMC devices since change in Upstream Linux
- Cleanup local AXG DT USB nodes now everything is upstream
- distro_bootcmd: run pci enum for scsi_boot just like it is done for nvme_boot
- New Boards:
  - Odroid-HC4: a variant of Odroid-C4 with 2 SATA ports (via PCIe-SATA bridge)
  - Beelink GS-King X: A variant of the other Beelink board with 2 SATA ports (via USB3-SATA bridge)
  - Banana Pi M5: another credit card SBC
  - JetHub D1/H1: home automation controllers
  - Radxa Zero: another RPi Zero sized SBC

----------------------------------------------------------------
Christian Hewitt (5):
      ARM: meson: Add S905Y2 SOC ID
      ARM: dts: sort Amlogic Makefile section
      ARM: dts: add support for Radxa Zero
      boards: amlogic: add Radxa Zero defconfig
      doc: boards: amlogic: update for Radxa Zero

Neil Armstrong (11):
      pci: pcie_dw_meson: fix usb fail when pci link fails to go up
      ARM: meson: Sync Amlogic DT from Linux 5.14
      usb: dwc3: meson-gxl: add AXG compatible
      ARM: meson: keep HW order for MMC devices
      ARM: meson-axg: remove local USB nodes
      configs: meson64: add SCSI boot target
      distro_bootcmd: run pci enum for scsi_boot just like it is done for nvme_boot
      ARM: amlogic: add support for Odroid-HC4 device
      doc: boards: amlogic: update for Odroid HC4
      ARM: meson: add Beelink GS-King X board
      ARM: amlogic: add Banana Pi M5

Vyacheslav Bocharov (3):
      ARM: amlogic: add JetHub common config header
      ARM: amlogic: add JetHub D1/H1 device support
      ARM: amlogic: add JetHub D1/H1 docs

 arch/arm/dts/Makefile                              |  18 +-
 arch/arm/dts/meson-axg-jethome-jethub-j100.dts     | 361 ++++++++++++
 arch/arm/dts/meson-axg-s400-u-boot.dtsi            |   8 -
 arch/arm/dts/meson-axg-s400.dts                    |  16 +
 arch/arm/dts/meson-axg-u-boot.dtsi                 |  62 --
 arch/arm/dts/meson-axg.dtsi                        | 181 ++++++
 arch/arm/dts/meson-g12-common-u-boot.dtsi          |   7 +
 arch/arm/dts/meson-g12-common.dtsi                 |  31 +-
 arch/arm/dts/meson-g12a-radxa-zero-u-boot.dtsi     |   7 +
 arch/arm/dts/meson-g12a-radxa-zero.dts             | 405 +++++++++++++
 arch/arm/dts/meson-g12a-sei510.dts                 |   2 +-
 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi       |   7 +
 arch/arm/dts/meson-g12b-gsking-x.dts               | 133 +++++
 arch/arm/dts/meson-g12b-gtking-pro.dts             |  23 +-
 arch/arm/dts/meson-g12b-gtking.dts                 |  22 +-
 arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   2 +-
 arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  74 ++-
 arch/arm/dts/meson-g12b-w400.dtsi                  |   2 +-
 arch/arm/dts/meson-g12b.dtsi                       |   4 +
 arch/arm/dts/meson-gx-libretech-pc.dtsi            |   2 +-
 arch/arm/dts/meson-gx-p23x-q20x.dtsi               |   2 +-
 arch/arm/dts/meson-gx-u-boot.dtsi                  |   7 +
 arch/arm/dts/meson-gx.dtsi                         |   7 +
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  42 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               |  44 +-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts | 241 ++++++++
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  50 +-
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |   6 +-
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |   2 +-
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  55 +-
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   2 +-
 arch/arm/dts/meson-gxm.dtsi                        |  20 +
 arch/arm/dts/meson-khadas-vim3.dtsi                |  73 ++-
 arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi     |  13 +
 arch/arm/dts/meson-sm1-bananapi-m5.dts             | 646 +++++++++++++++++++++
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  20 +-
 arch/arm/dts/meson-sm1-odroid-c4.dts               | 448 +-------------
 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi      |  23 +
 arch/arm/dts/meson-sm1-odroid-hc4.dts              | 140 +++++
 arch/arm/dts/meson-sm1-odroid.dtsi                 | 449 ++++++++++++++
 arch/arm/dts/meson-sm1-sei610.dts                  |  10 +-
 arch/arm/dts/meson-sm1.dtsi                        |  12 +-
 arch/arm/mach-meson/board-info.c                   |   1 +
 board/amlogic/beelink-s922x/MAINTAINERS            |   1 +
 board/amlogic/jethub-j80/MAINTAINERS               |   9 +
 board/amlogic/jethub-j80/Makefile                  |   6 +
 board/amlogic/jethub-j80/jethub-j80.c              |  67 +++
 board/amlogic/odroid-n2/MAINTAINERS                |   1 +
 board/amlogic/u200/MAINTAINERS                     |   3 +
 configs/bananapi-m5_defconfig                      |  74 +++
 configs/beelink-gsking-x_defconfig                 |  71 +++
 configs/jethub_j100_defconfig                      |  63 ++
 configs/jethub_j80_defconfig                       |  71 +++
 configs/odroid-hc4_defconfig                       |  93 +++
 configs/radxa-zero_defconfig                       |  65 +++
 doc/board/amlogic/index.rst                        | 128 ++--
 doc/board/amlogic/jethub-j100.rst                  | 108 ++++
 doc/board/amlogic/jethub-j80.rst                   |  97 ++++
 doc/board/amlogic/odroid-c4.rst                    |   3 +
 doc/board/amlogic/radxa-zero.rst                   |  74 +++
 drivers/pci/pcie_dw_meson.c                        |   8 +-
 drivers/usb/dwc3/dwc3-meson-gxl.c                  |   1 +
 include/config_distro_bootcmd.h                    |   1 +
 include/configs/jethub.h                           |  40 ++
 include/configs/meson64.h                          |   7 +
 include/dt-bindings/clock/axg-clkc.h               |  26 +-
 include/dt-bindings/clock/g12a-clkc.h              |   2 +
 68 files changed, 4033 insertions(+), 668 deletions(-)
 create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
 delete mode 100644 arch/arm/dts/meson-axg-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-radxa-zero-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12a-radxa-zero.dts
 create mode 100644 arch/arm/dts/meson-g12b-gsking-x-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-gsking-x.dts
 create mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
 create mode 100644 arch/arm/dts/meson-sm1-bananapi-m5-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-bananapi-m5.dts
 create mode 100644 arch/arm/dts/meson-sm1-odroid-hc4-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-sm1-odroid-hc4.dts
 create mode 100644 arch/arm/dts/meson-sm1-odroid.dtsi
 create mode 100644 board/amlogic/jethub-j80/MAINTAINERS
 create mode 100644 board/amlogic/jethub-j80/Makefile
 create mode 100644 board/amlogic/jethub-j80/jethub-j80.c
 create mode 100644 configs/bananapi-m5_defconfig
 create mode 100644 configs/beelink-gsking-x_defconfig
 create mode 100644 configs/jethub_j100_defconfig
 create mode 100644 configs/jethub_j80_defconfig
 create mode 100644 configs/odroid-hc4_defconfig
 create mode 100644 configs/radxa-zero_defconfig
 create mode 100644 doc/board/amlogic/jethub-j100.rst
 create mode 100644 doc/board/amlogic/jethub-j80.rst
 create mode 100644 doc/board/amlogic/radxa-zero.rst
 create mode 100644 include/configs/jethub.h
