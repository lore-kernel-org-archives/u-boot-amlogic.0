Received: by mail-wr1-f66.google.com with SMTP id s15so3257568wra.12
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Us2rFgLdFJdGriOAU0fqPP7RHI1eIlEJWLJwdMNhb0=;
        b=1dGSLik3CBYR/2fnER3dI1Y3S/uIuESc3W/flU+C8/IydqEVLrE7XeBukKM2O4cr26
         wgFBBONCTl6M5Axc3+vrgAJOwxgXdnhlpyBQA5qMpEFtzxlDlhn7DQfpkZ2j3ObeK9oF
         fNr6pIQPSVAoiclxar52gyo05XOsQv7va9+b6SCafkmuCqwGTF7PRE+bowfkWNyp7i3A
         03XTyPnhr4Oa+GBlqZTqEWTqZVBeilYK9z5YGkCEj9i5f9OHznJAOiftlX/mLn1b0ezE
         5UmpOHgMPcxwaPBk0PlvoYs9EcFkIKDhLappa9aeAyya5eqnCgr96n4u3X6pePxFbhDI
         5dMQ==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] board: amlogic-q200: fix Khadas VIM2 README
Date: Wed, 10 Apr 2019 16:47:53 +0200
Message-Id: <20190410144753.1343-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

The vendor U-boot branch and defconfig was wrong for the
Khadas VIM2, fix this.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 board/amlogic/q200/README.khadas-vim2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/amlogic/q200/README.khadas-vim2 b/board/amlogic/q200/README.khadas-vim2
index 578693fd2d..8bcfc296f3 100644
--- a/board/amlogic/q200/README.khadas-vim2
+++ b/board/amlogic/q200/README.khadas-vim2
@@ -48,9 +48,9 @@ the git tree published by the board vendor:
  > tar xvfJ gcc-linaro-aarch64-none-elf-4.8-2013.11_linux.tar.xz
  > tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
  > export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
- > git clone https://github.com/khadas/u-boot -b Vim vim-u-boot
+ > git clone https://github.com/khadas/u-boot -b khadas-vim-v2015.01 vim-u-boot
  > cd vim-u-boot
- > make kvim_defconfig
+ > make kvim2_defconfig
  > make
  > export FIPDIR=$PWD/fip
 
-- 
2.21.0

