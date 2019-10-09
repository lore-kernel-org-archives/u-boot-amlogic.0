Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.5325.1570629843070291418
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2019 07:04:03 -0700
Received: by mail-wm1-f65.google.com with SMTP id r19so2774884wmh.2
        for <u-boot-amlogic@groups.io>; Wed, 09 Oct 2019 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+jl/1FkSJzAeUz7etFWhefUtEi7LbhKQ3MhmK1xLKFE=;
        b=ZdX9ILcXAw2FuMpBcnsY53nrJrrlCQH4agKw9zG8P5QZ0JWsSmI45amh8Mk7J2gSzw
         ei8BVGR+8dCuMT3IXFQk6YpoZehL/9SQi68ulrXBVetiWdGnxz0FdAfQMTlhq9Ssja4D
         Xoxu3nj4tM6uyKBdmU/Udfx1AKoUSy6hsQFPXVwnRO9vV9JHwIFW0j08t3UT9ZMwNftj
         Er7F47WDqAukzQMqR4q0bZ6IsrlNvoJ3adN1UaYPf0vPlRldsyzm1BrvwUni8dpbbpqI
         TGYMJR4La4ydrmdwBBHzvqDsukPlbgCcZHdRGxuSHLeOzZpNEeNKbD2qZJeZ8eifois+
         l8sg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH v3 0/4] amlogic: Add Khadas VIM3 support
Date: Wed,  9 Oct 2019 16:03:53 +0200
Message-Id: <20191009140357.27279-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: afaerber@suse.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Andreas,

This is a resend from v2 with first patch resync'ed on v5.4-rc2.

This mini-series adds initial support for Amlogic A311D based Khadas VIM3.

v2 fixes an oversight and adds some cleanups.

v2 -> v3:
* Resync patch 1 on v5.4-rc2
* Removed bad signeoff of Julien Masson in patch 3

v1 -> v2:
* Fixed branch name in README
* Mention linux-next tag for DT/header import (Neil)
* Avoid "Unknown" SoC output for A311D, fixing a typo while at it

Andreas Färber (4):
  arm: dts: Import and update DT for Khadas VIM3
  configs: Add Khadas VIM3 defconfig
  arm: meson: Tidy SoC information output
  arm: meson: Recognize A311D SoC

 arch/arm/dts/Makefile                         |    3 +-
 arch/arm/dts/meson-g12-common.dtsi            | 2435 +++++++++++++++++
 arch/arm/dts/meson-g12a.dtsi                  | 2422 +---------------
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts |   16 +
 arch/arm/dts/meson-g12b-a311d.dtsi            |  149 +
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi      |  189 ++
 arch/arm/dts/meson-g12b-odroid-n2.dts         |  104 +-
 arch/arm/dts/meson-g12b-s922x.dtsi            |  124 +
 arch/arm/dts/meson-g12b.dtsi                  |   39 +-
 arch/arm/dts/meson-khadas-vim3.dtsi           |  360 +++
 arch/arm/mach-meson/board-info.c              |    3 +-
 board/amlogic/w400/MAINTAINERS                |    1 +
 board/amlogic/w400/README.khadas-vim3         |  132 +
 configs/khadas-vim3_defconfig                 |   54 +
 include/dt-bindings/clock/g12a-clkc.h         |    6 +
 include/dt-bindings/power/meson-g12a-power.h  |   13 +
 .../reset/amlogic,meson-g12a-audio-reset.h    |   38 +
 17 files changed, 3705 insertions(+), 2383 deletions(-)
 create mode 100644 arch/arm/dts/meson-g12-common.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
 create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
 create mode 100644 arch/arm/dts/meson-g12b-s922x.dtsi
 create mode 100644 arch/arm/dts/meson-khadas-vim3.dtsi
 create mode 100644 board/amlogic/w400/README.khadas-vim3
 create mode 100644 configs/khadas-vim3_defconfig
 create mode 100644 include/dt-bindings/power/meson-g12a-power.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h

-- 
2.22.0

