Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.58876.1681745101804280678
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Apr 2023 08:25:02 -0700
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f16b99b936so8945985e9.3
        for <u-boot-amlogic@groups.io>; Mon, 17 Apr 2023 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681745100; x=1684337100;
        h=content-transfer-encoding:organization:content-language:cc:to
         :reply-to:subject:from:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnAa5XlYRpbBJyvlBPihyh5R+ufC4YlHlMcaWoAtrF4=;
        b=A9xD7sNxaZNswl1C7cniysEIsnB/3gcvB2A3/mX+RRVV93bFoFZZoHkBBh5kuXgtNc
         KWn+G+VHWRhzn7Qacp/tJRkOfe9qEVGk1hCpqGm1LtSVE+wNxN3r1GyBS5hMzvfCoRuu
         VzWIt2wAkLf6ujWHL85wTJ2bRejeAN5aRt0twHHSJL2MnJELDYnDGrGmyycrc1mvl2XD
         0Zrd6o9ISaS3/f+NSNAbqBa9MBok80kFJQvH7LdLo0GfXds1TABLWmw2ThSfjaLKWynC
         nFp0UcL1GR5i+ANnN5r9Og+HTKHDhbWhTmXrfVhkigem4WiwPXX7ohontD15i5lUWyHm
         u6VQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <80fcb170-a5a6-9e4d-0c54-8ee6803470ab@linaro.org>
Date: Mon, 17 Apr 2023 17:24:59 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull uu-boot-amlogic-20230417
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

A big set of changes for the next release, it adds 7 new boards:
- BPI-CM4IO
- BananaPi M2-Pro
- BananaPi M2S
- Radxa Zero2
- WeTek Hub
- WeTek Play2
- Beelink GT1 Ultimate
with a welcome doc cleanup!
Finally a simple change to use the right powerdomain driver for LibreTech-CC v2 and WeTek Core2.

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/16023

Thanks,
Neil

The following changes since commit 12c1e5782401abca1a8cff578d1911a9ca7d2e7d:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-04-14 10:50:55 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20230417

for you to fetch changes up to 411d6af8b6a278effbaf1d02aa51280b2f5f8008:

   doc: boards: amlogic: add documentation for Beelink GT1 Ultimate (2023-04-17 11:06:08 +0200)

----------------------------------------------------------------
- Add initial support for BPI-CM4
- Spring Cleanup of Amlogic board documentation
- add support for BananaPi M2-Pro
- add support for BananaPi M2S
- add support for Radxa Zero2
- add support for WeTek Hub and WeTek Play2
- switch LibreTech-CC v2 and WeTek Core2 to EE powerdomain
- add support for Beelink GT1 Ultimate

----------------------------------------------------------------
Christian Hewitt (47):
       doc: boards: amlogic: update documentation for index page
       doc: boards: amlogic: update documentation for boot-flow
       doc: boards: amlogic: update documentation for pre-generated-fip's
       doc: boards: amlogic: update documentation for Beelink GT-King
       doc: boards: amlogic: update documentation for Beelink GT-King Pro
       doc: boards: amlogic: update documentation for JetHub J100
       doc: boards: amlogic: update documentation for JetHub J80
       doc: boards: amlogic: update documentation for Khadas VIM
       doc: boards: amlogic: update documentation for Khadas VIM2
       doc: boards: amlogic: update documentation for Khadas VIM3
       doc: boards: amlogic: update documentation for Khadas VIM3L
       doc: boards: amlogic: update documentation for LaFrite
       doc: boards: amlogic: update documentation for LePotato
       doc: boards: amlogic: update documentation for NanoPi-K2
       doc: boards: amlogic: update documentation for ODROID-C2
       doc: boards: amlogic: update documentation for ODROID-C4
       doc: boards: amlogic: update documentation for ODROID GO ULTRA
       doc: boards: amlogic: update documentation for ODROID-N2/N2+
       doc: boards: amlogic: update documentation for ODROID-N2L
       doc: boards: amlogic: update documentation for P200
       doc: boards: amlogic: update documentation for P201
       doc: boards: amlogic: update documentation for Q200
       doc: boards: amlogic: update documentation for Radxa Zero
       doc: boards: amlogic: update documentation for S400
       doc: boards: amlogic: update documentation for SEI510
       doc: boards: amlogic: update documentation for SEI610
       doc: boards: amlogic: update documentation for U200
       doc: boards: amlogic: update documentation for W400
       doc: boards: amlogic: update documentation for WeTek Core2
       doc: boards: amlogic: add documentation for BananaPi CM4IO
       doc: boards: amlogic: add documentation for BananaPi M5
       doc: boards: amlogic: add documentation for GS-King-X
       doc: boards: amlogic: add documentation for ODROID-HC4
       docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
       ARM: dts: add support for BananaPi M2-Pro
       boards: add BananaPi M2-Pro defconfig
       docs: boards: amlogic: add documentation for BananaPi M2-Pro
       ARM: dts: add support for BananaPi M2S
       boards: add BananaPi M2S defconfig
       docs: boards: amlogic: add documentation for BananaPi M2S
       ARM: dts: add support for Radxa Zero2
       boards: amlogic: add Radxa Zero2 defconfig
       doc: boards: amlogic: add documentation for Radxa Zero2
       ARM: dts: add support for WeTek Hub and WeTek Play2
       boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
       doc: boards: amlogic: add documentation for WeTek Hub and WeTek Play2
       boards: amlogic: switch LibreTech-CC v2 and WeTek Core2 to EE powerdomain

Karl Chan (3):
       ARM: dts: add support for Beelink GT1 Ultimate
       boards: amlogic: add Beelink GT1 Ultimate defconfig
       doc: boards: amlogic: add documentation for Beelink GT1 Ultimate

Neil Armstrong (2):
       ARM: dts: import initial DT for BPI-CM4 module with BPI-CM4IO baseboard
       ARM: meson: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard

  arch/arm/dts/Makefile                              |   9 +-
  arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |  33 ++
  .../dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi  |   6 +
  arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     | 165 +++++++
  arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          | 388 +++++++++++++++
  arch/arm/dts/meson-g12b-bananapi-u-boot.dtsi       |   7 +
  arch/arm/dts/meson-g12b-bananapi.dtsi              | 521 +++++++++++++++++++++
  arch/arm/dts/meson-g12b-radxa-zero2-u-boot.dtsi    |   7 +
  arch/arm/dts/meson-g12b-radxa-zero2.dts            | 489 +++++++++++++++++++
  arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |  14 +
  arch/arm/dts/meson-gxbb-wetek-hub.dts              |  58 +++
  arch/arm/dts/meson-gxbb-wetek-play2.dts            | 119 +++++
  arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi          |  13 +
  arch/arm/dts/meson-gxbb-wetek.dtsi                 | 292 ++++++++++++
  arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |   7 +
  arch/arm/dts/meson-gxm-gt1-ultimate.dts            |  91 ++++
  arch/arm/dts/meson-sm1-bananapi-m2-pro-u-boot.dtsi |  14 +
  arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |  97 ++++
  arch/arm/dts/meson-sm1-bananapi-m5.dts             | 427 +----------------
  arch/arm/dts/meson-sm1-bananapi.dtsi               | 435 +++++++++++++++++
  board/amlogic/beelink-s922x/MAINTAINERS            |   3 +-
  board/amlogic/p200/MAINTAINERS                     |   4 +
  board/amlogic/q200/MAINTAINERS                     |   2 +
  board/amlogic/u200/MAINTAINERS                     |   3 +
  board/amlogic/w400/MAINTAINERS                     |   6 +
  configs/bananapi-cm4-cm4io_defconfig               |  84 ++++
  configs/bananapi-m2-pro_defconfig                  |  76 +++
  configs/bananapi-m2s_defconfig                     |  82 ++++
  configs/beelink-gt1-ultimate_defconfig             |  78 +++
  configs/libretech-cc_v2_defconfig                  |   2 +-
  configs/radxa-zero2_defconfig                      |  77 +++
  configs/wetek-core2_defconfig                      |   2 +-
  configs/wetek-hub_defconfig                        |  70 +++
  configs/wetek-play2_defconfig                      |  70 +++
  doc/board/amlogic/bananapi-cm4io.rst               | 153 ++++++
  doc/board/amlogic/bananapi-m2pro.rst               | 143 ++++++
  doc/board/amlogic/bananapi-m2s.rst                 | 153 ++++++
  doc/board/amlogic/bananapi-m5.rst                  | 142 ++++++
  doc/board/amlogic/beelink-gskingx.rst              | 122 +++++
  doc/board/amlogic/beelink-gt1-ultimate.rst         | 110 +++++
  doc/board/amlogic/beelink-gtking.rst               | 119 ++---
  doc/board/amlogic/beelink-gtkingpro.rst            | 119 ++---
  doc/board/amlogic/boot-flow.rst                    | 178 +++----
  doc/board/amlogic/index.rst                        | 146 +++---
  doc/board/amlogic/jethub-j100.rst                  |  67 +--
  doc/board/amlogic/jethub-j80.rst                   |  47 +-
  doc/board/amlogic/khadas-vim.rst                   |  77 +--
  doc/board/amlogic/khadas-vim2.rst                  |  77 +--
  doc/board/amlogic/khadas-vim3.rst                  | 138 +++---
  doc/board/amlogic/khadas-vim3l.rst                 | 138 +++---
  doc/board/amlogic/libretech-ac.rst                 |  78 +--
  doc/board/amlogic/libretech-cc.rst                 | 110 ++---
  doc/board/amlogic/nanopi-k2.rst                    |  94 ++--
  doc/board/amlogic/odroid-c2.rst                    |  55 ++-
  doc/board/amlogic/odroid-c4.rst                    | 118 ++---
  doc/board/amlogic/odroid-go-ultra.rst              |  28 +-
  doc/board/amlogic/odroid-hc4.rst                   | 142 ++++++
  doc/board/amlogic/odroid-n2.rst                    | 123 ++---
  doc/board/amlogic/odroid-n2l.rst                   |  34 +-
  doc/board/amlogic/p200.rst                         |  88 ++--
  doc/board/amlogic/p201.rst                         |  88 ++--
  doc/board/amlogic/pre-generated-fip.rst            | 138 ++++--
  doc/board/amlogic/q200.rst                         |  77 +--
  doc/board/amlogic/radxa-zero.rst                   |  46 +-
  doc/board/amlogic/radxa-zero2.rst                  |  80 ++++
  doc/board/amlogic/s400.rst                         |  90 ++--
  doc/board/amlogic/sei510.rst                       | 114 ++---
  doc/board/amlogic/sei610.rst                       | 119 ++---
  doc/board/amlogic/u200.rst                         | 114 ++---
  doc/board/amlogic/w400.rst                         | 116 ++---
  doc/board/amlogic/wetek-core2.rst                  |  84 ++--
  doc/board/amlogic/wetek-hub.rst                    | 111 +++++
  doc/board/amlogic/wetek-play2.rst                  | 116 +++++
  73 files changed, 6107 insertions(+), 1736 deletions(-)
  create mode 100644 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts
  create mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts
  create mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-bananapi-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-bananapi.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-radxa-zero2-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-g12b-radxa-zero2.dts
  create mode 100644 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts
  create mode 100644 arch/arm/dts/meson-gxbb-wetek-hub.dts
  create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2.dts
  create mode 100644 arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-gxbb-wetek.dtsi
  create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
  create mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts
  create mode 100644 arch/arm/dts/meson-sm1-bananapi.dtsi
  create mode 100644 configs/bananapi-cm4-cm4io_defconfig
  create mode 100644 configs/bananapi-m2-pro_defconfig
  create mode 100644 configs/bananapi-m2s_defconfig
  create mode 100644 configs/beelink-gt1-ultimate_defconfig
  create mode 100644 configs/radxa-zero2_defconfig
  create mode 100644 configs/wetek-hub_defconfig
  create mode 100644 configs/wetek-play2_defconfig
  create mode 100644 doc/board/amlogic/bananapi-cm4io.rst
  create mode 100644 doc/board/amlogic/bananapi-m2pro.rst
  create mode 100644 doc/board/amlogic/bananapi-m2s.rst
  create mode 100644 doc/board/amlogic/bananapi-m5.rst
  create mode 100644 doc/board/amlogic/beelink-gskingx.rst
  create mode 100644 doc/board/amlogic/beelink-gt1-ultimate.rst
  create mode 100644 doc/board/amlogic/odroid-hc4.rst
  create mode 100644 doc/board/amlogic/radxa-zero2.rst
  create mode 100644 doc/board/amlogic/wetek-hub.rst
  create mode 100644 doc/board/amlogic/wetek-play2.rst
