Received: by mail-wm1-f42.google.com with SMTP id o25so7022569wmf.5
        for <u-boot-amlogic@groups.io>; Wed, 03 Apr 2019 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQ8DB/qicTrFPQfRPC5vVoEyQQdv/kcKu1m0OaSnYls=;
        b=WltCHoKOmMrONbkoU7RWpbf7472ZRA3RgTJNLvmyx/WXA26mzKxzbItt+WDIfFfX1M
         Y6Sn24++AOwZsgSWKrfMg+UJqN3xsPeWIITvYg8YQbWoBLXooXFq5DIPH7Ic471xvVqq
         2pTnBJf/HVd05jaYrmZrD8ViY8q8WrGQ8My4rkCkCTE1yQUEnkpT/9Z96lb0U5wJfia8
         J2z4wYElQJKqEcVMbvOM0y8o9qAUmijT7n2GuV14G0K+EDteaLzuwvzFfTpsqwdaVhg7
         L9Pfhl/AJploTeJ+PqDV6FDuPnFkXmiFuYvqUsBroSLM1/LR8zSoDmYlsqOZs6cglBBj
         XsUg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 0/2] arm: meson: Fix khadas-vim2 USB
Date: Wed,  3 Apr 2019 13:46:35 +0200
Message-Id: <20190403114637.32068-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: marex@denx.de, ldevulder@suse.de, trini@konsulko.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This patchset :
- fixes the MESON_GXL_USB_PHY dependency to also allow MESON_GXM
- fixes the khadas-vim2 defconfig

Tom, I know it's _very_ late in the cycle, is it still OK for final
2019.04 release ?

Neil Armstrong (2):
  phy: Also allow MESON_GXM for MESON_GXL_USB_PHY
  configs: khadas_vim2: Fix defconfig

 configs/khadas-vim2_defconfig | 3 +++
 drivers/phy/Kconfig           | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.21.0

