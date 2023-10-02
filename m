Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.87630.1696265952231751998
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4D590120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265948;
	bh=WV4OccKYZrIl8V3cSRLdvJ7FeM8Bv+wDt4uXI09i314=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nfNm5nulVIdC86oAgHArt2RDAW3rMihShBT0TZ6YD8Mfj0Jtmk3irhtFPSSyVX7MS
	 7BkQYK7ALFWGGOSx7LErf7fSV+DOb2WeCWLSpW8c8ffeH4xXsDJDiQczP4qNBuQB+t
	 k2WZ7l+Q6NENvsKO1k0LHSlCgghpGMDDxjcP+NZFOyTBmplhgGY30kht58MmOxvMdp
	 REOSxkS51/X1rq8JgpTQ3gEo7R1rn94yNyQWoCjoJm4p4GHUZqJBo0nlcXUQfZ0lbQ
	 Wlzl/bnfir2bQwljBtxMkZG2gEZhYNt/fSa83owk84fsq2El7mVwBeheqC25ZugHrq
	 Z+mAm/Dxn5t8g==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 4/8] phy: move clk enable/disable in init/exit
Date: Mon, 2 Oct 2023 19:58:48 +0300
Message-ID: <20231002165857.19512-5-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

It is better to place clk_enable() in phy_meson_g12a_usb2_init()
and clk_disable() in phy_meson_g12a_usb2_exit().

For more detailed information, please see comments in the review of
a similar driver in the Linux Kernel:

https://lore.kernel.org/all/CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=3D7hMhq1mvT6C=
uEOjGw@mail.gmail.com/

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/phy/meson-g12a-usb2.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 2e366b16ae..7b028784a0 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -160,6 +160,14 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
 	int ret;
=20
+#if CONFIG_IS_ENABLED(CLK)
+	ret =3D clk_enable(&priv->clk);
+	if (ret && ret !=3D -ENOSYS && ret !=3D -ENOTSUPP) {
+		pr_err("failed to enable PHY clock\n");
+		return ret;
+	}
+#endif
+
 	ret =3D reset_assert(&priv->reset);
 	udelay(1);
 	ret |=3D reset_deassert(&priv->reset);
@@ -252,6 +260,10 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
 	struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
 	int ret;
=20
+#if CONFIG_IS_ENABLED(CLK)
+	clk_disable(&priv->clk);
+#endif
+
 	ret =3D reset_assert(&priv->reset);
 	if (ret)
 		return ret;
@@ -289,13 +301,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 	ret =3D clk_get_by_index(dev, 0, &priv->clk);
 	if (ret < 0)
 		return ret;
-
-	ret =3D clk_enable(&priv->clk);
-	if (ret && ret !=3D -ENOSYS && ret !=3D -ENOTSUPP) {
-		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
-		return ret;
-	}
 #endif
=20
 	return 0;
--=20
2.25.1

