Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web09.15823.1650788532235997613
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788529; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hCyvAledVEA5jmOB5QU6iGsaTZiPZy2ZrPaf1mSVERE=;
	b=QfnvLTo4z2fzn/WVa1FlRc+k1PUi52ryBiLDFyhSPD3mal30re1sKUAQsf7L/ZRIZ/fhMg
	3ziR7/CtOeqmcyTBHbVjD2GmxQHg94FsfZzfy9OEBo8M3Abnk22CfQ1iq+O0F/PjOwKk7u
	/GKaXsRCeMKUH05A1tmfWJdMqvsoFqSrjELZgGUwHvyx4B0WPykoOmpX7Dh6K61ZZf2SBj
	XRySziF/X9eLQkgyt0LTjoFVfkNL/c8DjrZC7qG2QDBu2bAV2KDiJW0bdpvrYR1Qps6fC4
	41tYYv/zwTv1yAVcdemz3mAFuSZcN3qDmUDi3fZOB9hG8OgB45CHR6V2HXURWw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 3/6] clk: meson: update driver for g12a-ao clocks
Date: Sun, 24 Apr 2022 11:21:56 +0300
Message-Id: <20220424082159.757622-4-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Update g12a-ao clk driver:
- move clk->id check to .request function
- remove unnecessary check (gate->reg =3D=3D 0)

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/clk/meson/g12a-ao.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 17b11eb52a..1a855a6896 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -28,14 +28,8 @@ static int meson_set_gate(struct clk *clk, bool on)
 	struct meson_clk *priv =3D dev_get_priv(clk->dev);
 	struct meson_gate *gate;
=20
-	if (clk->id >=3D ARRAY_SIZE(gates))
-		return -ENOENT;
-
 	gate =3D &gates[clk->id];
=20
-	if (gate->reg =3D=3D 0)
-		return 0;
-
 	regmap_update_bits(priv->map, gate->reg,
 			   BIT(gate->bit), on ? BIT(gate->bit) : 0);
=20
@@ -63,9 +57,18 @@ static int meson_clk_probe(struct udevice *dev)
 	return 0;
 }
=20
+static int meson_clk_request(struct clk *clk)
+{
+	if (clk->id >=3D ARRAY_SIZE(gates))
+		return -ENOENT;
+
+	return 0;
+}
+
 static struct clk_ops meson_clk_ops =3D {
 	.disable	=3D meson_clk_disable,
 	.enable		=3D meson_clk_enable,
+	.request	=3D meson_clk_request,
 };
=20
 static const struct udevice_id meson_clk_ids[] =3D {
--=20
2.30.2

