Received: by mail-wm1-f67.google.com with SMTP id 10so11906886wmp.3
        for <u-boot-amlogic@groups.io>; Mon, 12 Aug 2019 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=g+ALaZ66r1IG4jDGAEOYSLc3fkhSOq7GL2bByIjVeeE=;
        b=or1m0quVwMji71P03B13NANJK/k8RcLvboA0y7HuKbO4ayPsCRS3ri272s5oVdLWkc
         W4SlmW+nBTFenpe6Dy0WNhp5fG0dfJWYV8lzWRvOm6TtIt/rDKtmXYolZAXMSGCwrYvu
         Zm5LxezRLp0/YI15FAWXRo8bZMZRHD6hhn4x11FAwV+rvnC6SnkAZWg75SChSVLZAyW2
         ekZZ3iw1i8/9tGxjqAdsiZHDZBz8MJAhEM56Fo4YaO/mG1lNKXAabU1lFEeTEEP7ldSf
         lsecMxbZK0usV9vW9qwwMpCp1G+Oai1zgUR1EK3jf3H7Nhu6vJ2hIlYHNGH4o5OkFEKH
         4O6w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190812
Message-ID: <78f15f0e-4369-edfd-ffa1-1ca22c1549fa@baylibre.com>
Date: Mon, 12 Aug 2019 14:01:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds support for the SEI Robotic SEI510 board and synced with Linux 5.3-rc1.

The CI jobs passed at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/438

Thanks,
Neil

The following changes since commit feb5a02f869d5678190dfc915ef6c2781b4f7a6c:

  Merge branch 'master' of git://git.denx.de/u-boot-sh (2019-08-10 17:57:58 -0400)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20190812

for you to fetch changes up to eb1677250d704b93169a58114a74424c7bfa495a:

  configs: sei510: disable PSCI_RESET to support fastboot reboot_flag (2019-08-12 10:05:10 +0200)

----------------------------------------------------------------
- amlogic: add support for the SEI Robotic SEI510

----------------------------------------------------------------
Jerome Brunet (1):
      boards: meson: add g12a sei510

Neil Armstrong (6):
      ARM: dts: Import Amlogic G12A SEI510 DT from Linux 5.3-rc1
      configs: meson64: permit redefining ENV_SIZE
      arm: meson: add sm cmd to retrieve SoC serial
      arm: meson: add sm command to retrieve the reboot reason
      ARM: meson: Add support for fastboot_set_reboot_flag()
      configs: sei510: disable PSCI_RESET to support fastboot reboot_flag

 arch/arm/dts/Makefile                |   1 +
 arch/arm/dts/meson-g12a-sei510.dts   | 502 +++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-meson/sm.h |  18 ++
 arch/arm/mach-meson/board-common.c   |  33 +++
 arch/arm/mach-meson/sm.c             | 133 ++++++++++
 board/amlogic/sei510/MAINTAINERS     |   7 +
 board/amlogic/sei510/Makefile        |   6 +
 board/amlogic/sei510/README          | 123 +++++++++
 board/amlogic/sei510/sei510.c        |  26 ++
 configs/sei510_defconfig             |  75 ++++++
 include/configs/meson64.h            |   2 +
 include/configs/sei510.h             | 137 ++++++++++
 12 files changed, 1063 insertions(+)
 create mode 100644 arch/arm/dts/meson-g12a-sei510.dts
 create mode 100644 board/amlogic/sei510/MAINTAINERS
 create mode 100644 board/amlogic/sei510/Makefile
 create mode 100644 board/amlogic/sei510/README
 create mode 100644 board/amlogic/sei510/sei510.c
 create mode 100644 configs/sei510_defconfig
 create mode 100644 include/configs/sei510.h
