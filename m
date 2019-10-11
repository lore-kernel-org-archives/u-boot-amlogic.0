Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web10.256.1570799544730100281
 for <u-boot-amlogic@groups.io>;
 Fri, 11 Oct 2019 06:12:25 -0700
Received: by mail-wr1-f67.google.com with SMTP id j18so11864265wrq.10
        for <u-boot-amlogic@groups.io>; Fri, 11 Oct 2019 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLDeIFYMdIbC04UQof/m1umzrilscLe1u5gnruxfANk=;
        b=BcrmQJgtUmX8skBn8wLAKXUkcttIRbt7fFRwCXVKaE6M6vafp0mDoOqCDTAGqXbmD2
         cR8B8B4X2vdjxF+aNv1J2EQbvDmFn8XvWK6Tb4Lw7wJyTU9AfhPlikrhLku3PC7kzMAb
         H+YU9u6rE0oKOvM1HpUQz7xVjMZDCXs+i7M0H0C5oUgxpW6fuMGlZrshsAtY8+0CnF/k
         EKO8KM3Gj9vecnTLkILoStsPFScrj4OQNHJz0b9JP0KXcnN/cmzhflMI2XTgEVZX51fE
         OjFgCOaooq4Be2KNc+7HwX/YdwuGINmCZYbjzlpoFrgCMvYn/Kzh2i5BhEad6PZsIrMx
         xacg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/2] amlogic: Add support for the Everything-Else power domain driver
Date: Fri, 11 Oct 2019 15:12:18 +0200
Message-Id: <20191011131220.10873-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, jh80.chung@samsung.com, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

For SM1 support a new Power Domain driver is needed to handle more than
the VPU power domain.

This Power Domain driver is also used for G12A to also control the Ethernet
Power Domain for example.

Neil Armstrong (2):
  power: domain: add Amlogic Everything-Else power domain driver
  configs: sei510: enable everything-else power domain

 configs/sei510_defconfig             |   2 +-
 drivers/power/domain/Kconfig         |   7 +
 drivers/power/domain/Makefile        |   1 +
 drivers/power/domain/meson-ee-pwrc.c | 430 +++++++++++++++++++++++++++
 4 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/domain/meson-ee-pwrc.c

-- 
2.22.0

