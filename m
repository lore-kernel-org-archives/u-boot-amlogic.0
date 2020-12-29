Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web08.12083.1609250346311287064
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Dec 2020 05:59:07 -0800
Received: by mail-wm1-f42.google.com with SMTP id e25so2346196wme.0
        for <u-boot-amlogic@groups.io>; Tue, 29 Dec 2020 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQaG2bavhs7h//ycYUz/5MmeRjujEo/b2b1EG5zQfHU=;
        b=zVyKB2tzuze2b5H7AitqmNERe10MEw0GU3BhHqqhJvzikBLedN6iieR+Xk/smZ2oT4
         NFD5I3ekQgIyeLD+0d1ZNri/LUrh6qvt3WQkXqDBl431U9iL0es8ymPaoKj+pKoN5ZgM
         IZQuNQpO3QYU9tfC9T4LUd+gLwZK91+aIll+SLe/oKS1pzwgFUjg2AecJwrQ/8aaYTbQ
         wvHZ/0oepLgUEJFjB681G36LqmPRDrQFGVbnsEOk+ijM8DwpHu4sDk1XFTGWAhoGHX7K
         NBjTwTBY+mXEjgCzM8lVpfbum5E9iBtcpQYL+rRMjlFWpi8aG6/J0W2gd4g6cWVJsWSQ
         JR5w==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/4] phy: add support for Amlogic Meson AXG MIPI-DSI PHY function
Date: Tue, 29 Dec 2020 14:58:57 +0100
Message-Id: <20201229135901.30090-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
MIPI DSI at the same time.

In order to configure the DSI PHY timings, a new "configure" PHY op is added to
permit dynamic (re)configuration of the PHY function.

Finally, the Linux MIPI D-PHY configuration helpers are imported to provide a standard
set of default D-PHY timings, timings struct and correct calculations.

Neil Armstrong (4):
  phy: dphy: Add configuration helpers
  generic-phy: add configure op
  phy: Add Amlogic AXG MIPI D-PHY driver
  phy: Add Amlogic AXG MIPI PCIe Analog PHY driver

 drivers/phy/Kconfig                      |  23 ++
 drivers/phy/Makefile                     |   3 +
 drivers/phy/meson-axg-mipi-dphy.c        | 393 +++++++++++++++++++++++
 drivers/phy/meson-axg-mipi-pcie-analog.c | 233 ++++++++++++++
 drivers/phy/phy-core-mipi-dphy.c         | 161 ++++++++++
 drivers/phy/phy-uclass.c                 |  11 +
 include/generic-phy.h                    |  23 ++
 include/phy-mipi-dphy.h                  | 284 ++++++++++++++++
 8 files changed, 1131 insertions(+)
 create mode 100644 drivers/phy/meson-axg-mipi-dphy.c
 create mode 100644 drivers/phy/meson-axg-mipi-pcie-analog.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 include/phy-mipi-dphy.h

-- 
2.25.1

