Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.11087.1696496099051198233
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6EB5212000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496091;
	bh=PAkrasm5+Fo1/+bC4ligWBrZq+1j4l1wgbERXnvEE7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=sNPFHu+5U/a5lb8d6+L6gVz/7Go5zSWuNiqfpOGSBQ+Hxynb27pyr5JfhtwoeHZYV
	 l+K2bCA4NMbxMUpLzRGp3TZGkkHOm5GJsbBw659mhiyfqjhw6NFmFDR0O1V3PBg4af
	 hh7dru/YyN4FYzQyzyJO4ASCtXDex7CU6nX5Xf9KOHkDSYwi/TJHu7rPj6ybUDDFDA
	 jzgr3UvGLX9NbXt6CTi6lR915x8YuBnjVZD77lkeUeyalNw0BZpJ7U416g+lhPApNp
	 M0sURHIw/QAWvm2K/qekQVLH4fSvShayml770Z3JNcYh6OsU5cpNptqRHyZWNNJoZR
	 ZM1Zqyy0ay9qA==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 4/8] phy: move clk enable/disable in init/exit
Date: Thu, 5 Oct 2023 11:54:25 +0300
Message-ID: <20231005085434.74755-5-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
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
index a803b6796c..2ea0498f86 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -161,6 +161,14 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
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
@@ -253,6 +261,10 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
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
@@ -290,13 +302,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
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

