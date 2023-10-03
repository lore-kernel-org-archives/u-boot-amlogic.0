Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.105635.1696332537852949242
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 04:28:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CB1D6100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696332534;
	bh=f6ZnH3Dtz73Vojy7+t1qCQ1MxL4DKJuwRa7GZWGCArE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dw8vVuATW73tfHTKVQI6I44G4+U8HPxdEX1uX/HqFg7blptxsR7Y5worjl3HgMTuZ
	 I2lifW/+L5MPuJb+iK52K51+auBDQJgmJ0hpZFphFwZxcLg4SV2gzPECOq11swV4u4
	 kmY5jCTvSfBBZFQrKHgxl3xKkFiaGCnVZ+/h12PtvNj1m3ULIMzGr+LZ0EMNnwYQle
	 fvMrVy/zd1aA3eKaggBs1W6mh+ScKbhNXX6GH+QsjaSB5rurBX7CM2a0Hvz1STw/TV
	 OxATtMfD5FlIXn/W5v2jxvgp1cC5Kp0cHf5S4hxQpm8nEI674RxA3zQhvKqDqAoxhH
	 40C+Uzqap4zng==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 4/8] phy: move clk enable/disable in init/exit
Date: Tue, 3 Oct 2023 14:28:30 +0300
Message-ID: <20231003112838.41503-5-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

