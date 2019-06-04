Received: by mail-wm1-f65.google.com with SMTP id z23so13837420wma.4
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YxoM7z3JsJjy6GuGSt7yK5q3O5kUo8bkldMPzUa5Ig=;
        b=wJ+CxQcfS8FqumYNt9k+Ev9WMaqNMqxgUNjmajUbMCvlgNEpapzs9DugsczGsqof49
         VXi+TsNqGL9YnZjd986P0BqAiWnDXcARC+gul+51M3SmdJ2cPbd76e5bI9FVkuyZqCHZ
         varwfIRzK6P5V5cloh5ycMlX47hbTn/1Jox0ZTP3p2BWHSIaSEQQ7XI6fdSS2c5LFB3I
         bqi7+R9FPkUGAZtEvVUp/olDVvl8vblpsU/ajlUbbNAAgNCZyHCACuHtsMO3w4ei1BwF
         LzuUsb2461xrlHR7GRS8aP3uQMqDENFeQJcXzjVCrcr104AnnOKueV4uJxdxREwbe8pQ
         nYRw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/4] pinctrl: meson: add support for pinmux status
Date: Tue,  4 Jun 2019 11:04:50 +0200
Message-Id: <20190604090454.18245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

In order to support the "pinmux status" command, fix the GX pinctrl
drivers and add the necessary functions callbacks.

Neil Armstrong (4):
  pinctrl: meson-gx: fix GPIO_TEST_N and GPIOCLK_ groups
  pinctrl: meson: add common function to get pins name
  pinctrl: meson-gx: add support for getting pinmux status
  pinctrl: meson-axg: add support for getting pinmux status

 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 48 +++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c  | 44 +++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c    |  7 ++-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c     |  6 ++-
 drivers/pinctrl/meson/pinctrl-meson.c         | 24 ++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h         |  3 ++
 6 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.21.0

