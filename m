Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web09.11014.1650477314260287816
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 10:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650477311; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TOHJwlT70RsobBJbPyrBhfXaoLCjuA5y39sCVPbLHSs=;
	b=QGIW2HLe65IxkHBMQXu1eUfG09fssia6pPfe5fsjG3n+L2KXd41wD5/X7mXPkOZ5RqjpGb
	s7E9Ur5JwSEgWpVjBKclIuQlMk4UD6f25Nv8XozG+1h0vvobvHcyKbT1bgoFnnIWlONGIc
	WxndGkuhmg/+KZ6rTFOYhA1aFkKaOOaESZ3UM2OM5UX2Cw4AZ/f4R/1YNWDy9g9ll8B0bK
	B3bN7y26whNRkCbVAsStBYsdMSp9HY1Nh0jPSh7C/MmJ4H8RLNOw3Ur0rF8wXPfFBz4Tux
	QyJ6/AlFIwPgkhUyeVdu3DiRUjoo94oTecsnvy+0xCosF3WFpfQSHlIMvf/VGA==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 2/5] clk: meson: fix driver name for g12a-ao clocks
Date: Wed, 20 Apr 2022 20:54:59 +0300
Message-Id: <20220420175502.2449249-3-adeep@lexina.in>
In-Reply-To: <20220420175502.2449249-1-adeep@lexina.in>
References: <20220420175502.2449249-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Update the clk-g12a-ao driver from "axg" to "g12a"

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/clk/meson/g12a-ao.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 0148529e04..17b11eb52a 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -73,7 +73,7 @@ static const struct udevice_id meson_clk_ids[] =3D {
 	{ }
 };
=20
-U_BOOT_DRIVER(meson_clk_axg) =3D {
+U_BOOT_DRIVER(meson_clk_g12a_ao) =3D {
 	.name		=3D "meson_clk_g12a_ao",
 	.id		=3D UCLASS_CLK,
 	.of_match	=3D meson_clk_ids,
--=20
2.30.2

