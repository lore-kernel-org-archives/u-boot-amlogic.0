From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 4/4] arm: meson: Recognize A311D SoC
Date: Mon,  2 Sep 2019 14:19:10 +0200
Message-Id: <20190902121914.18946-5-afaerber@suse.de>
In-Reply-To: <20190902121914.18946-1-afaerber@suse.de>
References: <20190902121914.18946-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Christian Hewitt <christianshewitt@gmail.com>, Albert Aribaud <albert.u.boot@aribaud.net>
List-ID: <u-boot-amlogic@groups.io>

Values imported from Linux driver, but in correct numeric order.

Khadas VIM3 prints: Amlogic Meson G12B (A311D) Revision 29:b (10:2)

Cc: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 v2: New
=20
 arch/arm/mach-meson/board-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board=
-info.c
index ea32c01d11..9571b5a189 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -59,6 +59,7 @@ static const struct meson_gx_package_id {
 	{ "A113D",  0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
+	{ "A311D",  0x29, 0x10, 0xf0 },
 	{ "S922X",  0x29, 0x40, 0xf0 },
 };
=20
--=20
2.16.4

