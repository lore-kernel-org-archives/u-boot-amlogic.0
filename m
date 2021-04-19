Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.127.1618846503962814544
 for <u-boot-amlogic@groups.io>;
 Mon, 19 Apr 2021 08:35:04 -0700
Received: by mail-wr1-f43.google.com with SMTP id r7so22504102wrm.1
        for <u-boot-amlogic@groups.io>; Mon, 19 Apr 2021 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wjIlK7H1NZUg40g9phV8RhKeX9gwrb2+o7X6cW/D/bQ=;
        b=hFj7arhZ3jJwWX3SzKo3mWsg9lla8EQAXuisgdxKGA9P+6VRGUb4O3vETpcSgnVKbX
         P88RYgXFze0LNsCrYkjRz0dH2c+fKf9ooEQe8sCEKXpTCmgyunDx0+w9i14rz4+x7rZM
         FwLC29sJrZq2ZpK4EJwfpN45iuV4JwPEN3V9qAKxoiRDTSbyF2xRM1vaHmbUA8RY8lIZ
         Cv2JUDUkvGhLv1fCc9XHLZH3Q0V4YADS5+C7nadfZqbwQ06BJcb7LhsFTsSay+jluACQ
         +wgKJfO5ths5Z1JpE5DtSExDH2bv0vnUq4a74PoWWy5IT4w+l+zELJRn3R+BTUH7gUlJ
         rI5w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210419
Reply-To: narmstrong@baylibre.com
Message-ID: <08d42f1d-2d55-0bc2-2e7f-fc2993fd4726@baylibre.com>
Date: Mon, 19 Apr 2021 17:35:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This serie fixes Ethernet on Odroid-C2 and enables support for PCIe on the Khadas VIM3 & VIM3L
with all the necessary bits after Bin merged the PCIe driver.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/7216

Thanks,
Neil

The following changes since commit 3a9aaefcaa3efc2a1cef86fbe0bf229a1bff9902:

  Merge tag 'efi-2021-07-rc1-2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2021-04-18 08:47:27 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210419

for you to fetch changes up to fcf3c9deae1acfda81051c8c211fcbefd4217e1d:

  boards: amlogic: update documentation for PCIe support (2021-04-19 16:59:33 +0200)

----------------------------------------------------------------
- fix Ethernet on Odroid-C2 by re-adding old bindings style PHY reset
- add G12A PCIe clock gates
- add G12A PCIe PHY OPs
- enable PCIe for Khadas VIM3/VIM3L boards DT
- enable PCIe and NVME for Khadas VIM3/VIM3L boards config
- update Amlogic board documentation for PCIe support

----------------------------------------------------------------
Neil Armstrong (6):
      clk: meson-g12a: add PCIe gates
      phy: meson-g12a-usb3-pcie: add support for PCIe ops
      arm: dts: meson-khadas-vim3: enable PCIe in U-boot
      configs: khadas-vim3: enable PCIe and NVMe
      configs: meson64: add NVME boot target
      boards: amlogic: update documentation for PCIe support

Stefan Agner (1):
      arm64: dts: meson: odroidc2: readd PHY reset properties

 arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi |  6 +++
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi   |  4 ++
 configs/khadas-vim3_defconfig                |  5 ++
 configs/khadas-vim3l_defconfig               |  5 ++
 doc/board/amlogic/index.rst                  |  2 +
 drivers/clk/meson/g12a.c                     |  2 +
 drivers/phy/meson-g12a-usb3-pcie.c           | 81 ++++++++++++++++++++++++++--
 include/configs/meson64.h                    |  7 +++
 8 files changed, 108 insertions(+), 4 deletions(-)
