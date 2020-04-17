Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.6690.1587117234719858182
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Apr 2020 02:53:55 -0700
Received: by mail-wm1-f67.google.com with SMTP id u127so1220532wmg.1
        for <u-boot-amlogic@groups.io>; Fri, 17 Apr 2020 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=tZGM9j8dldsjKqBK04wssZRnt5YmSvX1tEFKvVXgBWo=;
        b=TEZOn8F5VFCzNu1OKfVMvAW/7C05xpfnC6dEYASCKB0JXGR1y1SrTM7sS8Q8wIBChN
         7s0IydlmYIkKnWG31NjC6CjQO2AgRQwNdEG90r5U5O/rk6i8SHYTAkTucJxV4K3gidkb
         Gn9Z9CYeSdzr2MJix99P1XtW2rTAOQzYuJw6t+t5PbQcKevUjxOxEMN5HDJcx+EP9Uka
         6z0wAls0BQc/cQZZ3cIIQkIJs65cCPFVj1sZbRmQooAdGbDpyySpHnMaSqNxHrzEg4sD
         /bSNIvbogxRwsbYNt6cKvW7wHcVuToD0/j6FwIW1shv2kPC7fSxRU2Umlw02GtEOwPGe
         UQFA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20200417
Reply-To: u-boot-amlogic@groups.io, narmstrong@baylibre.com
Message-ID: <8fa8ff4a-5965-8a27-9394-729b5692d9a9@baylibre.com>
Date: Fri, 17 Apr 2020 11:53:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR enables RNG on meson boards for UEFI, fixes the SMBIOS information for ODROID-C2,
fixes HDMI Video Output broken on GXBB/GXL/GXM based boards and adds support for USB gadget
on GXL/GXM boards.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/2800

Thanks,
Neil

The following changes since commit 142a07f2a44262d76fec609e1fcde51794a456eb:

  Merge branch 'master' of git://git.denx.de/u-boot-marvell (2020-04-14 08:47:07 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200417

for you to fetch changes up to e8b6dd8263e84f52d91bc0ac3e2582cb6e832307:

  configs: libretech-s912-pc: Enable USB gadget with Mass Storage function (2020-04-17 09:52:13 +0200)

----------------------------------------------------------------
- enable DM_RNG on meson boards
- fix SMBIOS info on Odroid-C2
- Fix video output on GXBB/GXL/GXM boards
- add USB gadget support for GXL/GXM boards

----------------------------------------------------------------
Heinrich Schuchardt (2):
      arm: meson: imply DM_RNG
      configs: correct SMBIOS information for ODROID-C2

Neil Armstrong (12):
      ARM: dts: add missing meson-gxl-s805x-libretech-ac-u-boot.dtsi file
      arm64: dts: meson-gx: add back dmc register range until canvas driver is available
      generic-phy: add generic_phy_get_by_node()
      phy: meson-gxl-usb: add set_mode call to force switch to peripheral mode
      arm: meson-gx: add board_usb_init()/cleanup() for USB gadget
      arm: dts: meson-gxl: Add USB Gadget nodes for U-Boot
      configs: libretech-cc: Enable USB gadget with Mass Storage function
      configs: libretech-ac: Enable USB gadget with Mass Storage function
      configs: khadas-vim2: Enable USB gadget with Mass Storage function
      configs: khadas-vim: Enable USB gadget with Mass Storage function
      configs: libretech-s905d-pc: Enable USB gadget with Mass Storage function
      configs: libretech-s912-pc: Enable USB gadget with Mass Storage function

 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/meson-gx-u-boot.dtsi                  |   4 +
 .../dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi   |   7 ++
 .../arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi |   2 +-
 .../dts/meson-gxl-s905x-libretech-cc-u-boot.dtsi   |   6 +-
 arch/arm/dts/meson-gxl-s905x-p212-u-boot.dtsi      |   2 +-
 arch/arm/dts/meson-gxl-u-boot.dtsi                 |  23 ++++
 arch/arm/include/asm/arch-meson/usb-gx.h           |  16 +++
 arch/arm/mach-meson/board-gx.c                     | 118 +++++++++++++++++++++
 configs/khadas-vim2_defconfig                      |   7 ++
 configs/khadas-vim_defconfig                       |   7 ++
 configs/libretech-ac_defconfig                     |   7 ++
 configs/libretech-cc_defconfig                     |   7 ++
 configs/libretech-s905d-pc_defconfig               |   7 ++
 configs/libretech-s912-pc_defconfig                |   7 ++
 configs/odroid-c2_defconfig                        |   2 +
 drivers/phy/meson-gxl-usb2.c                       |  30 ++++--
 drivers/phy/meson-gxl-usb3.c                       |  44 +++++---
 drivers/phy/phy-uclass.c                           |  16 ++-
 include/generic-phy.h                              |  27 +++++
 20 files changed, 314 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
 create mode 100644 arch/arm/dts/meson-gxl-u-boot.dtsi
 create mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h
