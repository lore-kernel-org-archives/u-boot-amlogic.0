Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.32595.1605522202785217522
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Nov 2020 02:23:23 -0800
Received: by mail-wm1-f45.google.com with SMTP id p22so23182574wmg.3
        for <u-boot-amlogic@groups.io>; Mon, 16 Nov 2020 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:reply-to:to:cc:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=uiCzzLknbTF7vWruLnvqPIN+bs8RCRp8VA8+GEp3Jfg=;
        b=f2UH7lo4GH18W0rjRw8HyucayDtqSVNPI/4nWxhFs1gsam9BQbrtsUFsfhFxM8gljp
         53KuGLuaJ0mBukhyh0D9Lx2oeoe2s0wVcoPfTdZvB2aIWUJTkytZRn6fWQgNF43faskM
         4ppONEF5USrCj9eLPVMvjauHAR5FGILVnbqz9yywQCaD/5qx0darw7A4DgAoupP4NcdD
         m4+oS/DFfNKPisUk11mq31HCUEPFR0aAgwp3E6xrkzDbB+cwLk5HTO6UDGL6R11KkLa9
         40jzB1+nNiV++nGHWt+VECr1Qe53irtZ4wCOL2siiUNNy07jeSbl113F+O4hUDfbhafH
         SglQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20201116
Reply-To: narmstrong@baylibre.com
Message-ID: <d04edf13-4004-d39f-1280-8589a880e2c9@baylibre.com>
Date: Mon, 16 Nov 2020 11:23:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR fixes the MMC driver on SM1 based platforms, syncs the SoC Ids and fixes 2 potential
build warning.

The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/5354

Thanks,
Neil

The following changes since commit 832bfad7451e2e7bd23c96edff2be050905ac3f6:

  libfdt: Fix signedness comparison warnings (2020-11-10 14:31:08 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20201116

for you to fetch changes up to c87eab81616d671a6004ffc95847bad21b7eb005:

  ARM: dts: meson-sm1: add u-boot specific MMC controller compatible (2020-11-12 14:31:29 +0100)

----------------------------------------------------------------
- Clock fix MMC driver for SM1 based platforms
- sync SOC Ids from Linux 5.10-rc1
- fix potential build warning on meson_dw_hdmi and meson-g12a-usb2 phy

----------------------------------------------------------------
Jaehoon Chung (2):
      phy: meson-g12a-usb2: fix the potential build warning
      video: meson: meson_dw_hdmi: fix the potential build warning

Neil Armstrong (4):
      ARM: mach-meson: update SoC IDs
      mmc: meson-gx: move arch header to local header
      mmc: meson-gx: change clock phase value on SM1 SoCs
      ARM: dts: meson-sm1: add u-boot specific MMC controller compatible

 .../dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi   |  1 +
 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi         |  2 --
 arch/arm/dts/meson-sm1-khadas-vim3l-u-boot.dtsi    |  1 +
 arch/arm/dts/meson-sm1-odroid-c4-u-boot.dtsi       |  2 +-
 arch/arm/dts/meson-sm1-sei610-u-boot.dtsi          |  2 +-
 arch/arm/dts/meson-sm1-u-boot.dtsi                 | 20 +++++++++++++++
 arch/arm/mach-meson/board-info.c                   |  7 +++++-
 drivers/mmc/meson_gx_mmc.c                         | 29 ++++++++++++++++++----
 .../sd_emmc.h => drivers/mmc/meson_gx_mmc.h        | 10 +++++---
 drivers/phy/meson-g12a-usb2.c                      |  4 +--
 drivers/video/meson/meson_dw_hdmi.c                |  2 ++
 11 files changed, 64 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/meson-sm1-u-boot.dtsi
 rename arch/arm/include/asm/arch-meson/sd_emmc.h => drivers/mmc/meson_gx_mmc.h (95%)
