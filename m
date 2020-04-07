Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by mx.groups.io with SMTP id smtpd.web10.4388.1586241129237369184
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Apr 2020 23:32:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1586241126;
	bh=WITMZHaq0ovjDfKloJrxVIFiuSrifiXIpf/HNqB5Ges=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=BmRS9k3PxD4GSGHMAltX54J5eAKbXGvJzth2HpHHULFyXwlzKj0B7MeXYyGUrNZyG
	 EZgdvfZ1Rs3d2B1AR86HRwxLZpHo+zFRvmfjzAA0E2ZdkOqCnSG0nMwU4HQk0XBVPB
	 Ws6MNfbKnaLYNCy0m0cm7glkV8Wh8syFPJsK0ViM=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] configs: correct SMBIOS information for ODROID-C2
Date: Tue,  7 Apr 2020 08:32:00 +0200
Message-Id: <20200407063200.6426-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Beniamino Galvani <b.galvani@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

CONFIG_SMBIOS_MANUFACTURER=3D"amlogic"
CONFIG_SMBIOS_PRODUCT_NAME=3D"p200"

is incorrect for the ODROID-C2.

Show correct board name and manufacturer in SMBIOS.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 configs/odroid-c2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
index 64fbfdf064..39279b40db 100644
=2D-- a/configs/odroid-c2_defconfig
+++ b/configs/odroid-c2_defconfig
@@ -7,6 +7,7 @@ CONFIG_NR_DRAM_BANKS=3D1
 CONFIG_DEBUG_UART_BASE=3D0xc81004c0
 CONFIG_DEBUG_UART_CLOCK=3D24000000
 CONFIG_IDENT_STRING=3D" odroid-c2"
+CONFIG_SMBIOS_PRODUCT_NAME=3D"ODROID-C2"
 CONFIG_DEBUG_UART=3Dy
 CONFIG_OF_BOARD_SETUP=3Dy
 CONFIG_CONSOLE_MUX=3Dy
@@ -41,3 +42,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=3Dy
 CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
 CONFIG_OF_LIBFDT_OVERLAY=3Dy
+CONFIG_SMBIOS_MANUFACTURER=3D"Hardkernel Co., Ltd."
=2D-
2.25.1

