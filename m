Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.4934.1650605366859861046
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605364; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uc9WGoELHeXsSSZFRkwf2LzmsfErl9Gh5dI4kM5+o3E=;
	b=hh7qMn8X2b6msxnmjoKWlX6KnHIUwdHdLrwP/pZNAWghfcfSJTPnXzRCbF7mDKIsaHXMKS
	mNmVwOYZJhz3jCTAzgc0a0oKOWlY1AshtuNxgWY/fL1JghXwSfJwPVR3s8dxwQy+6fVubV
	uwzFmwzBFpbTbMF41mgIm9q716pw3iCb0sQ1WipGsv5cSlHLqNdpe02LItke03lm6tQhXE
	d/ibwnEPuWYWX27OfkxJcVbNeBwi/fVMUnCn45AjNQLnPMa2f91jKrezSlPZktFkPyA7mh
	PrP71APMaFfJ2or9u9qKWD89OEa9RJmnGnoe2NGLs6JdRJtfsd9k215Xf63ovw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 3/6] clk: meson: update driver for g12a-ao clocks
Date: Fri, 22 Apr 2022 08:29:11 +0300
Message-Id: <20220422052914.1836694-4-adeep@lexina.in>
In-Reply-To: <20220422052914.1836694-1-adeep@lexina.in>
References: <20220422052914.1836694-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Move clk->id check to .request function

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/clk/meson/g12a-ao.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 17b11eb52a..22c85cff1d 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -28,9 +28,6 @@ static int meson_set_gate(struct clk *clk, bool on)
 	struct meson_clk *priv =3D dev_get_priv(clk->dev);
 	struct meson_gate *gate;
=20
-	if (clk->id >=3D ARRAY_SIZE(gates))
-		return -ENOENT;
-
 	gate =3D &gates[clk->id];
=20
 	if (gate->reg =3D=3D 0)
@@ -63,9 +60,18 @@ static int meson_clk_probe(struct udevice *dev)
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

