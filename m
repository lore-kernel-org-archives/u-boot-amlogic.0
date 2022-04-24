Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.15569.1650788532876763018
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788529; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=d9TvfXh0qjmQ1x8biKX06Pj+UALtxRFt30djTpjYG/Y=;
	b=qOifpRNNjATKIyBocTcUijzqy1q1dT0SIG7vzuy5/il2X8y2pwojhgu+BiEsRBgd8tNFYZ
	SmOpIavIz+728Dy/9zgQHxrv80FooPKpWv+bJ7dNeLA49DFJ+xNE+L5qoMLCRhzRjVlkqr
	G6GISau7bXG9tXsVppyn08vpto2vfGgUB8t0B9Cz4DT4Q1LQac+sAx1Czr0kHOksg51zk3
	yMlCinn1BEY5HAdNVUEklWYwkCMk4uRLBTfUIV1FLBbT79ei2ZExucH7VtHq1817kK6Uzc
	VD2z2YkdoZAkHOyEtAIRaVlv6MlZS/3CT86FAlp36fOGu7DZGNOmfb6KJWpvVw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 2/6] clk: meson: fix driver name for g12a-ao clocks
Date: Sun, 24 Apr 2022 11:21:55 +0300
Message-Id: <20220424082159.757622-3-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Update the clk-g12a-ao driver from "axg" to "g12a"

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
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

