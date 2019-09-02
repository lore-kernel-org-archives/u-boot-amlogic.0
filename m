From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 3/4] arm: meson: Tidy SoC information output
Date: Mon,  2 Sep 2019 14:19:09 +0200
Message-Id: <20190902121914.18946-4-afaerber@suse.de>
In-Reply-To: <20190902121914.18946-1-afaerber@suse.de>
References: <20190902121914.18946-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Julien Masson <jmasson@baylibre.com>, Albert Aribaud <albert.u.boot@aribaud.net>
List-ID: <u-boot-amlogic@groups.io>

Write SoC instead of Soc. The Linux driver is not affected.

Fixes: f41d723b9f ("ARM: meson: display Amlogic SoC Information")
Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 v2: New
=20
 arch/arm/mach-meson/board-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board=
-info.c
index ba248e8ff6..ea32c01d11 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -154,7 +154,7 @@ int show_board_info(void)
=20
 	/* print board information */
 	print_board_model();
-	printf("Soc:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
+	printf("SoC:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
 	       socinfo_to_soc_id(socinfo),
 	       socinfo_to_package_id(socinfo),
 	       socinfo_to_major(socinfo),
--=20
2.16.4

