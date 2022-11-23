Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.23607.1669218188439872479
 for <u-boot-amlogic@groups.io>;
 Wed, 23 Nov 2022 07:43:08 -0800
Received: by mail-wr1-f51.google.com with SMTP id i12so26114919wrb.0
        for <u-boot-amlogic@groups.io>; Wed, 23 Nov 2022 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=tR1mGpm/ef5PnmB+HivZwcg/0quU/v4LYGRoQWYkE1c=;
        b=TDWMk0NeGDSocxvW4t6E+Ewm1xc6G9OKwwiewUMq5fVjt4f0OmgtU/i1KslJX89hmV
         resCxjs/fmJj0tQjdFdczff3H7tuSucyICxCH02UPwMhpEJb8DmNA4VQoxiqtb2mckP4
         gfrt5kyx7Eb83TrdEuipfgYRuhy5JrrENuWdYTJb++gjL8MFyxDvTEUFJ0BP2ZaOoQST
         slKosDI4mICrSagobFR5Vjs2RzF3G5/3lGl0ToXzRHSdVT/W8TClqXLMIjFa6Q65SLoB
         qCP0YH3vOvXXyP2n88VXLG7jcYotHNgYj23Ex3H0AzCcFoMNcwCVLD8SeuajCs9YkVOn
         pMjg==
Return-Path: <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] mach-meson: port dwc2_otg usage to CONFIG_DM_USB_GADGET=y
MIME-Version: 1.0
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Date: Wed, 23 Nov 2022 16:42:48 +0100
Message-Id: <20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <neil.armstrong@linaro.org>, Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

While working on some USB bugs on the VIM3L board, we stumbled upon the fact
that mach-meson still uses legacy board_usb_*() functions instead of using DM [1]

This series aim to switch the g12a based boards to use CONFIG_DM_USB_GADGET and
removes the board_usb_*() logic.

* The first patch adds mode switching in the dwc3-meson-g12a glue driver whenever
  the dwc2 otg driver is probed()/removed().

* The second patch enables the config option and cleans up all board_usb_*().

This has been mainly tested with khadas-vim3l_android_defconfig using fastboot:

=> fastboot usb 0

=> # hit Ctrl-c

Other tests:
* ums 0 mmc 2 # can list / mount partitions from host
* usb start; usb storage # list usb thumb drive
* all defconfigs have been build tested

[1] https://lore.kernel.org/u-boot/938b9439-9014-5ee8-1627-16af508bface@linaro.org/
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

---
Mattijs Korpershoek (2):
      usb: dwc3-meson-g12a: force mode on child add/removal
      ARM: meson: g12a: switch dwc2 otg to DM

 arch/arm/mach-meson/board-g12a.c          | 127 ------------------------------
 configs/bananapi-m5_defconfig             |   1 +
 configs/beelink-gsking-x_defconfig        |   1 +
 configs/beelink-gtking_defconfig          |   1 +
 configs/beelink-gtkingpro_defconfig       |   1 +
 configs/khadas-vim3_android_ab_defconfig  |   1 +
 configs/khadas-vim3_android_defconfig     |   1 +
 configs/khadas-vim3_defconfig             |   1 +
 configs/khadas-vim3l_android_ab_defconfig |   1 +
 configs/khadas-vim3l_android_defconfig    |   1 +
 configs/khadas-vim3l_defconfig            |   1 +
 configs/odroid-c4_defconfig               |   1 +
 configs/odroid-hc4_defconfig              |   1 +
 configs/odroid-n2_defconfig               |   1 +
 configs/radxa-zero_defconfig              |   1 +
 configs/sei510_defconfig                  |   1 +
 configs/sei610_defconfig                  |   1 +
 configs/u200_defconfig                    |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c        |  18 +++++
 19 files changed, 35 insertions(+), 127 deletions(-)
---
base-commit: 7b70f68977578360d9c47bb25d6d1937075153b4
change-id: 20221024-meson-dm-usb-60e413696519

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>
