Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.2825.1627399732898169445
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 08:28:53 -0700
Received: by mail-wm1-f54.google.com with SMTP id u15so4461826wmj.1
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GkvQEIAPAQO8ONrAihEjuIX/ckTuiarjqmfvzeMzPlE=;
        b=Fa5sq8eBzWBECwnc9Ng5zoO2TpBzq1U9QD7buATBNSL9swgXbNTHEYDLubifE+s43w
         R9ds9cs8DKZ1W5c7FyFOHHIFjWuBJFWMXKOsSEjFDZSzWItTgcns+vemoo3Jyrwn0+co
         xOMsHCcTF+iFX5UoTHyx/ju9JJQzeg+j8NJwUjEGgaNTTLV9J7GTnkF72FquisMGDh98
         uThpPT5DJRDgE4imlZSn2kRdoKrea4fNCGTAqKQyz98kXaNq4iBElsTWEhkF4sc+2Xrh
         bO+Osyuy+p/r8x9Vaenqzlq3IDRoEwjZSGoh3X/si/PRiAD3ltluFTd7Nk6jiuM0D9LM
         wkxA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20210727
Reply-To: narmstrong@baylibre.com
Message-ID: <c78bdec2-07b4-57db-18ed-7072bec8b701@baylibre.com>
Date: Tue, 27 Jul 2021 17:28:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

Here is bunch of fixes/changes for the Amlogic based VIM boards, and a build fix for the
AXG MIPI DSP PHY driver.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/8444

Thanks,
Neil

The following changes since commit b70b9b07463db2f6937c7ea6d7fb5122feb7ba1b:

  Prepare v2021.10-rc1 (2021-07-26 20:57:18 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20210727

for you to fetch changes up to 24d2aea19b8069fb124313435cffcbb07c8317a1:

  configs: Enable SMBIOS for Khadas VIM boards (2021-07-27 10:33:23 +0200)

----------------------------------------------------------------
- Add SMBIOS info for Khadas VIM boards
- Fix meson-axg-mipi PHY build
- Fix VIM3 board phy-names property setup
- Return correct value for non emmc boot sources on VIM3
- add kernel compression vars

----------------------------------------------------------------
Alper Nebi Yasak (2):
      phy: meson-axg-mipi: Rename "priv_auto_alloc_size" to "priv_auto"
      phy: meson-axg-mipi: Access parent ofnode through dev_ofnode()

Artem Lapkin (5):
      meson64: add kernel compression vars
      VIM3: mmc_get_env_dev correct non emmc boot sources
      board: amlogic: vim3: fix phy-names property setup
      ARM: dts: meson: Use devicetree for SMBIOS settings for Khadas VIM boards
      configs: Enable SMBIOS for Khadas VIM boards

 .../dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi   | 23 ++++++++++++++++++++++
 .../arm/dts/meson-gxl-s905x-khadas-vim-u-boot.dtsi | 23 ++++++++++++++++++++++
 arch/arm/dts/meson-gxm-khadas-vim2-u-boot.dtsi     | 21 ++++++++++++++++++++
 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi    | 23 ++++++++++++++++++++++
 board/amlogic/vim3/vim3.c                          | 14 +++++++++----
 configs/khadas-vim2_defconfig                      |  2 ++
 configs/khadas-vim3_defconfig                      |  2 ++
 configs/khadas-vim3l_defconfig                     |  2 ++
 configs/khadas-vim_defconfig                       |  2 ++
 drivers/phy/meson-axg-mipi-dphy.c                  |  2 +-
 drivers/phy/meson-axg-mipi-pcie-analog.c           |  4 ++--
 include/configs/meson64.h                          |  2 ++
 12 files changed, 113 insertions(+), 7 deletions(-)
