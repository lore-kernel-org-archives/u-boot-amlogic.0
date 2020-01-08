Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.7386.1578488245759477657
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Jan 2020 04:57:26 -0800
Received: by mail-wm1-f67.google.com with SMTP id p9so2377504wmc.2
        for <u-boot-amlogic@groups.io>; Wed, 08 Jan 2020 04:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=rLH7tDkO1iLUgEuvVfdE2T3py2aUxpyLdNm2/ECFuXg=;
        b=qX+tALdHZzXQKOqZjrdGAAqsCE2jPj3H0BgWm8F00LVKzXfqSEScBy9OapZ17vRtgJ
         Y9sDoTzGp1MMXQbGtnifiK1s4uCcA4ZcKaefG33uN59DlHl5Jk0Fb28a9jxhPUMr4UKI
         fsUJqPfVjp0Kx0reeARbtj4sTu0jgA2bJatc5D86fnqB9eq9Xva8zt73SBbFVP+UclUm
         DxoSN+BsuX+uKytbTWYU3pEKlYksw/n6PAxVWVht9BsnSkKZcC2jPKdt6laLm53GZH5e
         Ta4lG5PBlRoCTc1ejK/fqkGcp+Vbtu0XIIO2wk5h1p5k0mxuFZXUUzyVn/H8eks83hGQ
         /2hA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20191018
Message-ID: <fc28b03e-b133-b683-94bd-770bc89ce5aa@baylibre.com>
Date: Wed, 8 Jan 2020 13:57:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR adds more support for the Khadas VIM3L, variant of VIM3 but
using the Amlogic SM1 S905D3 SoC, plus various small fixes.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/1780

Thanks,
Neil

The following changes since commit 0b0c6af38738f2c132cfd41a240889acaa031c8f:

  Prepare v2020.01 (2020-01-06 15:56:31 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20200108

for you to fetch changes up to 262d34363373c10a00279036c1561283c30495c2:

  board: amlogic: select PWRSEQ for all amlogic platform (2020-01-07 14:50:41 +0100)

----------------------------------------------------------------
- Khadas VIM3L based on Amlogic S905D3 support
- Various fixups for amlogic boards
- Unnecessary header includes drop into video/meson

----------------------------------------------------------------
Anand Moon (2):
      configs: meson64: enable GIC support for G12A/G12B
      board: amlogic: select PWRSEQ for all amlogic platform

Christian Hewitt (2):
      ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
      boards: amlogic: add Khadas VIM3L support

Simon Glass (1):
      video: meson: Drop unnecessary header includes

 arch/arm/dts/Makefile                   |   1 +
 arch/arm/dts/meson-sm1-khadas-vim3l.dts |  95 +++++++++++++++++++++++
 arch/arm/mach-meson/Kconfig             |   1 +
 board/amlogic/w400/MAINTAINERS          |   1 +
 board/amlogic/w400/README.khadas-vim3l  | 132 ++++++++++++++++++++++++++++++++
 configs/khadas-vim3l_defconfig          |  62 +++++++++++++++
 drivers/video/meson/meson_canvas.c      |   4 +
 drivers/video/meson/meson_plane.c       |   5 ++
 drivers/video/meson/meson_vclk.c        |   2 +
 drivers/video/meson/meson_venc.c        |   4 +
 drivers/video/meson/meson_vpu.c         |  18 ++++-
 drivers/video/meson/meson_vpu.h         |  17 ++--
 drivers/video/meson/meson_vpu_init.c    |   4 +
 include/configs/meson64.h               |   2 +-
 include/video.h                         |   2 +
 15 files changed, 334 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
 create mode 100644 board/amlogic/w400/README.khadas-vim3l
 create mode 100644 configs/khadas-vim3l_defconfig
