Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web09.461.1582607425044200463
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Feb 2020 21:10:26 -0800
Received: by mail-wm1-f65.google.com with SMTP id t14so1673553wmi.5
        for <u-boot-amlogic@groups.io>; Mon, 24 Feb 2020 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DOGmJxUy4TyMEfMv2a10nwA4xcNGB1wzFJ+D5mEF/yo=;
        b=deCfEuCi5Xym0JztXzMChd50LfwR4F0ratUqOODsy/W35PJC2SLckY1FWuXQPvBspd
         4fdYTu+ftzuSjclGXmsrIADAre0IakIYhCP6Hh5FXygMKXUmuANWCVDEhmdP3zBVOoDQ
         K3yvDZO8z4J3GCmqVa5kve3FGA09bHOQEBvQg=
Return-Path: <michael@amarulasolutions.com>
From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 0/2] Update reserved memory for simple framebuffer
Date: Tue, 25 Feb 2020 06:10:19 +0100
Message-Id: <20200225051021.15311-1-michael@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Reserved memory for simple frame buffer should be created in a different
way:

+       aliases {
+               display0 = &lcdif;
+       };
+
+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               display_reserved: framebuffer@86fa2000 {
+                       reg = <0x86fa2000 0x80000>;
+                       no-map;
+               };
+
+       };

We add a function to change the loaded dts and inject those information.
I have added another patch for meson. Right now I'm testing on tinker-s
board.

Michael Trimarchi (2):
  common: fdt: Add a function for reserving memory without kernel linear
    mapping
  video: meson: Use reserving memory function without kernel linear
    mapping

 common/fdt_support.c            | 40 +++++++++++++++++++++++++++++++++
 drivers/video/meson/meson_vpu.c |  6 ++---
 include/fdt_support.h           | 11 +++++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

-- 
2.17.1

