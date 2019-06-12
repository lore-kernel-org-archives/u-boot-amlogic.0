Received: by mail-wm1-f67.google.com with SMTP id 207so6934616wma.1
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2019 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:openpgp:autocrypt:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=9NPdU4IFku7SnbYNFhb4ytFL0Iibk4rHiph6IEob7ts=;
        b=UkvLec1PxFYkQq6kRYdxG1B4k/VUMU7Y62TIlz/rs8dphSUdjfeVSilmrGgZzGIH3q
         4imgej4m0MqNDq6Mej/5aqi1vp+btiAUKxNUoFcjTw2sY3hrDIjnALDBfLtomiyoIsho
         pbHp8Gr6T/pwjN/XCi88vx1X4pcmAygi7cWKT5SUyR90tFdZLEjX9qNXsk2RAwEp0ScT
         TMB6Hqa7HiopZuq7VbfYofOY3hU8cO4opuXvr0ca9gyVIvFMa4U7h11uYMs6rsidT3nR
         fIUyqJrQ5rSCf1ATy/1HCFnMwTCl2hHHdCKHlVNK2k+1cQTjUqUQDLoa1wDkeDJ6kUQ6
         ad4Q==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PULL u-boot] Please pull u-boot-amlogic-20190612
Message-ID: <af502890-26a7-20b7-b96e-8b6739e2a9a9@baylibre.com>
Date: Wed, 12 Jun 2019 16:59:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Tom,

This PR is only for pinctrl, fixing HDMI support for GXBB fixing badly
defined pins for GXL & GXBB, adds support for getting pinmux status and
finally adds drive-strength-microamp support for G12A, fixing external
ethernet PHY support.

Thanks,
Neil

The following changes since commit 68b90e57bc034e237923b02acb633dc4e91d44cb:

  configs: tinker-rk3288 disable CONFIG_SPL_I2C_SUPPORT (2019-06-11 08:13:05 -0400)

are available in the Git repository at:

  git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190612

for you to fetch changes up to 63860dbfdfdda97a8af7fd16c184d45648db3506:

  pinctrl: meson-gxbb: add hdmi related pins (2019-06-12 11:50:02 +0200)

----------------------------------------------------------------
- pinctrl: meson-gx: fix GPIO_TEST_N and GPIOCLK_ groups
- pinctrl: meson-gxbb: add hdmi related pins to fix HDMI on GXBB
- pinctrl: meson: add support for getting pinmux status
- pinctrl: meson-g12a: add support for drive-strength-microamp property

----------------------------------------------------------------
Guillaume La Roque (3):
      dm: pinctrl: Add driver-strength-microamp property
      pinctrl: meson: add support of drive-strength-microamp
      pinctrl: meson: g12a: add DS bank value

Maxime Jourdan (1):
      pinctrl: meson-gxbb: add hdmi related pins

Neil Armstrong (4):
      pinctrl: meson-gx: fix GPIO_TEST_N and GPIOCLK_ groups
      pinctrl: meson: add common function to get pins name
      pinctrl: meson-gx: add support for getting pinmux status
      pinctrl: meson-axg: add support for getting pinmux status

 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 49 +++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 20 ++++----
 drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c  | 44 +++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c    | 26 +++++++++-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c     |  6 ++-
 drivers/pinctrl/meson/pinctrl-meson.c         | 69 ++++++++++++++++++++++++++-
 drivers/pinctrl/meson/pinctrl-meson.h         | 45 ++++++++++++-----
 include/dm/pinctrl.h                          |  3 ++
 8 files changed, 234 insertions(+), 28 deletions(-)
