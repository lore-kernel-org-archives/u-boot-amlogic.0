Received: by mail-wr1-f52.google.com with SMTP id c2so16155407wrm.8
        for <u-boot-amlogic@groups.io>; Wed, 12 Jun 2019 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFhZUPAAKLeF7otPHQ2W+1ec8wQjavcucI26pxRcFTk=;
        b=1WrzKWgK9NyFLcS+Y+lFpS35871fkAySw8PQwAJCiHODxzXKuWS6FrmX9MOL7nTpAY
         R0BFITlIFwKUOHzpK9wE9A2o+x1CnAjp+V7VQZbGeBpWy1iITfuFyowAHsLZYV2vKAXu
         ce9YLNHIzDyVdiPpYZukAzCwIeMewkK0oevi/1tB4oN95WUnOhghJalXJGTK+cq7qtc+
         NJRwTGV7zBAgW53dhVnd99RCUZOhi1atyy07ipKuUcCSGnW6XjDC7ZQypYQqyHm+Gm1b
         bUSZXs4lLWeZ9dOxTbq06v7DTGrH+rpDgGdSpzzY2KyOmnfEjPqi1H2/YFP07hfVzOCg
         UYOg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/3] amlogic: add unique MAC address generatio
Date: Wed, 12 Jun 2019 11:49:05 +0200
Message-Id: <20190612094908.24858-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

This patchset adds support for generating an unique MAC address per-SoC,
and enables it on the q200 (VIM2) and P212 (libretech-cc, khadas-vim, libretech-ac)
based boards.

Neil Armstrong (3):
  ARM: meson: sm: Add secure monitor calls to retrieve SoC serial number
  ARM: meson: add unique MAC address generation
  board: amlogic: Generate unique MAC address for Q200 and P212 based
    boards

 arch/arm/include/asm/arch-meson/eth.h |  3 +++
 arch/arm/include/asm/arch-meson/sm.h  |  4 ++++
 arch/arm/mach-meson/board-common.c    | 31 +++++++++++++++++++++++++++
 arch/arm/mach-meson/sm.c              | 24 +++++++++++++++++++++
 board/amlogic/p212/p212.c             |  2 ++
 board/amlogic/q200/q200.c             |  2 ++
 6 files changed, 66 insertions(+)

-- 
2.21.0

