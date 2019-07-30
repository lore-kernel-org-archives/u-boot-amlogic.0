DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1564520628;
	bh=ga6CwWXO++q7xEQTQjqN9Gf0giLD45LYjtNk/RhZXkM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=jRV0VqG87lKpXG3ecaJfnSUhjZda0bKbYPJWxrW8J0kfsD8cxgYh6edRs4OuKswMX
	 Bhvc5YfsyzYQmnen3aGAw7fMFftA9SS7rhRhiHSqMJhZHRe9nZPNIO4MASVPHzC/dr
	 Wpcot5i4/8q2AOmq/bw4MT/9nEYRDAJLHp2KeaxI=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] clk: meson: remove duplicate logic
Date: Tue, 30 Jul 2019 23:03:43 +0200
Message-Id: <20190730210343.24173-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Lukasz Majewski <lukma@denx.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

First thing we check in meson_clk_set_rate_by_id() is current_rate =3D=3D =
rate.
There is not need to check it again.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/clk/meson/gxbb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 2cb53fb92d..abb5337e78 100644
=2D-- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -823,10 +823,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk=
, unsigned long id,
 	case CLKID_MPLL1:
 	case CLKID_MPLL2:
 	case CLKID_CLK81:
-		if (current_rate !=3D rate)
-			return -EINVAL;
-
-		return 0;
+		return -EINVAL;
 	case CLKID_VPU:
 		return meson_clk_set_rate_by_id(clk,
 				meson_mux_get_parent(clk, CLKID_VPU), rate,
=2D-
2.20.1

