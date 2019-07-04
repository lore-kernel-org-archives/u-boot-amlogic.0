Received: by mail-wm1-f67.google.com with SMTP id n9so5850074wmi.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36wNKgdHK8lDUoTJF+8tRDU66RLmWTTFpiuCod+c9/E=;
        b=Esf0XkgbG7lVYKYnPim8KnQGrEMUxiu7a/0KGtTTDrgeDoVAX6/EnW5uOFWjUomfyR
         eOwx9/laCXgglVXhV6fW+mWxeETz8JgzYkTAsTiWrqSwGcjwHHqfmXwmbkrMcgCzm9vn
         mTes9XoOekt/UefswRSUYwz/T6kfnyLGRmtudOrM57UD11zruvrIh4OGqqTn76WG99z5
         7a5JfG0RUWc2TCbzN8nPOEcoiniMmLvmGtcj7g7WNF4F4lqCCyX2H+JDXYRU2iYG03kR
         Og61wwuIOMjPpZ482jQwg6vPhw2iloDBrB1lQp0LQttodbLugsfNmgpHczyzlOSh0ji9
         mmiw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] video: add support for EDID timings validation
Date: Thu,  4 Jul 2019 15:52:05 +0200
Message-Id: <20190704135208.32104-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This patch introduces an edid_get_timing_validate() variant function with
a mode_valid() callback in order to filter supported timings from a display
driver while adding a new mode_valid() display op.

This permits selecting a valid timing on Amlogic SoCs when plugged on
4K monitors/TVs for example.

Neil Armstrong (3):
  edid: add edid_get_timing_validate() variant to filter out edid modes
  video: display: use edid_get_timing_validate() variant to filter
    supported EDID modes
  video: meson: dw-hdmi: add EDID mode filtering to only select
    supported modes

 common/edid.c                       | 22 +++++++++++++++++++---
 drivers/video/display-uclass.c      | 15 ++++++++++++++-
 drivers/video/meson/meson_dw_hdmi.c |  7 +++++++
 include/display.h                   | 10 ++++++++++
 include/edid.h                      | 22 ++++++++++++++++++++++
 5 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.21.0

