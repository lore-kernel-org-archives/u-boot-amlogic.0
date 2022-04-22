Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.4933.1650605366583910306
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605363; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TOHJwlT70RsobBJbPyrBhfXaoLCjuA5y39sCVPbLHSs=;
	b=Yn1ou947M6qUhneWZa7KnBxdXrcM5PVmDVIkf+n5woRxTQxtJ7VGHnmjQk6djak52jekLk
	8VTjMSavNLT85z2h7UyGNG8y3L1OfOaQuDM65ueJ0Ua16N3/lo4E8ivToEAA7uIWDDnper
	lq3IepW5VEKAZEaUWiEb5P6+UaJSWhkqeuo4qxY25/GwPazgqjxE8lGSv+TzBdxgqi1dE3
	FrcZK0uFKfnIYPZUzKc6jGt1U80w664OGZNRplxzgTtRebhemjNyRC2Ms7ei70vsFjeZYn
	EddNwQheRStTdBApHsPisHTBBLAXa5NQX1Wm1lhAedQ2Qabg243T0ecVPHHjVQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 2/6] clk: meson: fix driver name for g12a-ao clocks
Date: Fri, 22 Apr 2022 08:29:10 +0300
Message-Id: <20220422052914.1836694-3-adeep@lexina.in>
In-Reply-To: <20220422052914.1836694-1-adeep@lexina.in>
References: <20220422052914.1836694-1-adeep@lexina.in>
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

