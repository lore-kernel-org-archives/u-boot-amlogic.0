Received: by mail-wm1-f65.google.com with SMTP id f10so14561957wmb.1
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Uuxs0qMNy1a+5YiYZ0xfcpjk0VrqU7vPcJKKT8tmiM0=;
        b=cRpR5VKrAarzQN28OJwEtabRfnCPLi/z2V3UGSxGwd7YCbOIihKt6maHAg6sJFGP6d
         fcoscQnrWu/de8wPHsYbHZkR6tN9f7eNKjqRoThp+nif5FOeOi0PB/Qz+kYRquF6MC/2
         7UkVlJTmRdDMBKbPq2JeHpG8Bvy9n+8rMEmv7Wd0y0p3E7OQPfh2OqPmgNVLFdZiG62i
         9DsyOscTe6YdpzInDxct3U8vtU6ss+vMWnxWQ1JXR/GqaOjWevE81Wji4lKIWClPOS/H
         va/GF3K9tyXvxXy6g+1nMakR3pJmk6PvDxwCeMTRjeNTnLrVYsqTrv1OYK2gF88S1iQs
         8oYw==
Return-Path: <glaroque@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Subject: [PATCH 0/3] Add drive-strength-microamp in Meson pinctrl driver
Date: Tue,  4 Jun 2019 13:53:05 +0200
Message-Id: <20190604115308.26510-1-glaroque@baylibre.com>
To: narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

The purpose of this patchset is to add drive-strength-microamp support in meson pinconf
driver. This is a new feature that was added on the g12a. It is critical for us
to support this since many functions are failing with default pad drive-strength.

The value achievable by the SoC are 500uA, 2500uA, 3000uA and 4000uA and the DT property
'drive-strength-microamp' is expressed in uA.
So this patch add another generic property "drive-strength-microamp". The change to do so
would be minimal and could be benefit to other platforms later on.

it's backport from linux :
https://lore.kernel.org/lkml/20190514082652.20686-1-glaroque@baylibre.com/

Cheers
Guillaume

Guillaume La Roque (3):
  dm: pinctrl: Add driver-strength-microamp property
  pinctrl: meson: add support of drive-strength-microamp
  pinctrl: meson: g12a: add DS bank value

 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 20 ++++----
 drivers/pinctrl/meson/pinctrl-meson.c         | 46 ++++++++++++++++++-
 drivers/pinctrl/meson/pinctrl-meson.h         | 43 +++++++++++------
 include/dm/pinctrl.h                          |  3 ++
 5 files changed, 89 insertions(+), 24 deletions(-)

-- 
2.17.1

