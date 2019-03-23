Received: by mail-wm1-f66.google.com with SMTP id a184so4481346wma.2
        for <u-boot-amlogic@groups.io>; Sat, 23 Mar 2019 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ao2OXYfjppogIU9As9WebILNXt7h1B6gJu6sMFXCtCw=;
        b=jQ5iD7l6iKOLgyWCmzdhrUhrUBYloqkbB5oDgGoVwyNWwGVR0mn8IfLHmaGWzly2If
         xng/xwCNcaP5qxu/qJLcrDtA12alEQk7dfSCOUXZXpse19z+PynsiEiZS5VCiiDbNkwR
         ctRoi91NRr4gWpIcQARhwzjxEuu6mfzlO+mrjYzGmb6kIgJGur4SFE8+GbVEMD4nwvZk
         Cqd8OfpIaA9w4jbtIHGAMhbXuxwAg8o6x5bzDcIikfeDCFxg2e41U5N0miRRPEp8hyGt
         4q8wwFegAlBzhXcBf2a1YPOkwC2JAYzqVTo4f6LC6OI7145UtX1rZy+XUyH62iV1PBTV
         z+xg==
Return-Path: <mohammad.rasim96@gmail.com>
From: "Mohammad Rasim" <mohammad.rasim96@gmail.com>
Subject: [PATCH v5 1/5] ARM: board: meson: rename odroid-c2 to p200
Date: Sat, 23 Mar 2019 14:52:22 +0300
Message-Id: <20190323115222.1914-1-mohammad.rasim96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Albert Aribaud <albert.u.boot@aribaud.net>, Neil Armstrong <narmstrong@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, Mohammad Rasim <mohammad.rasim96@gmail.com>, "open list:ARM AMLOGIC SOC SUPPORT" <u-boot-amlogic@groups.io>, open list <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

This renames the odroid-c2 to p200 and set it as the default GXBB board
Other boards (odroid-c2 and nanopi-k2) will inherit from p200

Signed-off-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-meson/Kconfig                          | 2 +-
 board/amlogic/{odroid-c2 => p200}/MAINTAINERS        | 5 ++---
 board/amlogic/{odroid-c2 => p200}/Makefile           | 2 +-
 board/amlogic/{odroid-c2 => p200}/README.nanopi-k2   | 0
 board/amlogic/{odroid-c2 => p200}/README.odroid-c2   | 0
 board/amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} | 0
 6 files changed, 4 insertions(+), 5 deletions(-)
 rename board/amlogic/{odroid-c2 => p200}/MAINTAINERS (70%)
 rename board/amlogic/{odroid-c2 => p200}/Makefile (82%)
 rename board/amlogic/{odroid-c2 => p200}/README.nanopi-k2 (100%)
 rename board/amlogic/{odroid-c2 => p200}/README.odroid-c2 (100%)
 rename board/amlogic/{odroid-c2/odroid-c2.c => p200/p200.c} (100%)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 11077bc6cc24..1b1d0aef0d22 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -61,7 +61,7 @@ config SYS_VENDOR

 config SYS_BOARD
 	string "Board name"
-	default "odroid-c2" if MESON_GXBB
+	default "p200" if MESON_GXBB
 	default "p212" if MESON_GXL
 	default "q200" if MESON_GXM
 	default "s400" if MESON_AXG
diff --git a/board/amlogic/odroid-c2/MAINTAINERS b/board/amlogic/p200/MAINTAINERS
similarity index 70%
rename from board/amlogic/odroid-c2/MAINTAINERS
rename to board/amlogic/p200/MAINTAINERS
index 6a853066d781..77a055b681d9 100644
--- a/board/amlogic/odroid-c2/MAINTAINERS
+++ b/board/amlogic/p200/MAINTAINERS
@@ -1,8 +1,7 @@
-ODROID-C2
+P200
 M:	Beniamino Galvani <b.galvani@gmail.com>
 M:	Neil Armstrong <narmstrong@baylibre.com>
 S:	Maintained
-F:	board/amlogic/odroid-c2/
-F:	include/configs/odroid-c2.h
+F:	board/amlogic/p200/
 F:	configs/nanopi-k2_defconfig
 F:	configs/odroid-c2_defconfig
diff --git a/board/amlogic/odroid-c2/Makefile b/board/amlogic/p200/Makefile
similarity index 82%
rename from board/amlogic/odroid-c2/Makefile
rename to board/amlogic/p200/Makefile
index a6a3db755f21..f82a7ea9ca6b 100644
--- a/board/amlogic/odroid-c2/Makefile
+++ b/board/amlogic/p200/Makefile
@@ -2,4 +2,4 @@
 #
 # (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>

-obj-y	:= odroid-c2.o
+obj-y	:= p200.o
diff --git a/board/amlogic/odroid-c2/README.nanopi-k2 b/board/amlogic/p200/README.nanopi-k2
similarity index 100%
rename from board/amlogic/odroid-c2/README.nanopi-k2
rename to board/amlogic/p200/README.nanopi-k2
diff --git a/board/amlogic/odroid-c2/README.odroid-c2 b/board/amlogic/p200/README.odroid-c2
similarity index 100%
rename from board/amlogic/odroid-c2/README.odroid-c2
rename to board/amlogic/p200/README.odroid-c2
diff --git a/board/amlogic/odroid-c2/odroid-c2.c b/board/amlogic/p200/p200.c
similarity index 100%
rename from board/amlogic/odroid-c2/odroid-c2.c
rename to board/amlogic/p200/p200.c
--
2.21.0

