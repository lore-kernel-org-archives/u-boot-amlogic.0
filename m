Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web09.21307.1606494543627341421
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Nov 2020 08:29:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1606494539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=gh+wRplxNJQ2GjDdknr78tRVtOXAwPdpfW06HF9+6hI=;
	b=rXL9zqGinR29V8OHczgOHXNGvK+2E7pF0jaEhzuaYwQjl2QaTrlIc182SSgmx2WW7u1z8R
	Ob2iH/Gf8M3/grs9qCYdkr+sGM3vWZyJdDKCUXf9oO2m2fdTugrtX/5gFt8Y0BNeUondMk
	DL0QCGA+qwjsDMNKV3Trg4TgQO6rttI=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: meson: isolate loading of socinfo
Date: Fri, 27 Nov 2020 17:28:20 +0100
Message-Id: <537d604eeb14149783c1bb398af9f4c9a82374d0.1606492351.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, narmstrong@baylibre.com, u-boot@lists.denx.de
Cc: Stefan Agner <stefan@agner.ch>, Tom Rini <trini@konsulko.com>
List-ID: <u-boot-amlogic@groups.io>

Move loading of socinfo into a separate function so the value can be
reused later.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---

 arch/arm/mach-meson/board-info.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board=
-info.c
index e61d1adb10..a0bcf38f29 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -131,7 +131,7 @@ static void print_board_model(void)
 	printf("Model: %s\n", model ? model : "Unknown");
 }
=20
-int show_board_info(void)
+static unsigned int get_socinfo(void)
 {
 	struct regmap *regmap;
 	int nodeoffset, ret;
@@ -163,8 +163,20 @@ int show_board_info(void)
 		return 0;
 	}
=20
+	return socinfo;
+}
+
+int show_board_info(void)
+{
+	unsigned int socinfo;
+
 	/* print board information */
 	print_board_model();
+
+	socinfo =3D get_socinfo();
+	if (!socinfo)
+		return 0;
+
 	printf("SoC:   Amlogic Meson %s (%s) Revision %x:%x (%x:%x)\n",
 	       socinfo_to_soc_id(socinfo),
 	       socinfo_to_package_id(socinfo),
--=20
2.29.2

