Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web10.37962.1681911641691440234
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Apr 2023 06:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681911640;
	bh=UnoKf7ife6Pu94ACOKBYHLKlj2dsjKFzxK2bvx0lEv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvARXzVnXSzfyhW0FiFn8wA+XXDumIAjguVM7x6sPhAxL6jzurCgpcuAircZvMX8o
	 bzjb7u9ZlFdh6t+LpUE8qUssHr7kEWF0zQbh2gWEP+zoJ6yzrDY/QxW4gZSN+WGocc
	 b3cYkkUifVXDrl6UiD4whvJz+5mh/BUQO/Sv26x7r1Dq3uhKe2/o+DPTA7gtxs6VL4
	 fV35u5bGwm+zFKubEz6jJHtYTRRXdENYRwdRfdrEjpg+M320rOjqsjr5tXT9doQjtC
	 GmAjnUPPc1DeFKl0fnIM1CQWa7TUySE143qNFvFhmrvAe0FmvZCSoiHS0jtAVKUuPj
	 SyqPuR1rFNvRA==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v5 6/6] phy: Keep balance of counts when ops is missing
Date: Wed, 19 Apr 2023 16:40:14 +0300
Message-Id: <20230419134014.128461-6-eugen.hristev@collabora.com>
In-Reply-To: <20230419134014.128461-1-eugen.hristev@collabora.com>
References: <20230419134014.128461-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@collabora.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, xdrudis@tinet.cat, jagan@edgeble.ai, neil.armstrong@linaro.org, anarsoul@gmail.com
List-ID: <u-boot-amlogic@groups.io>

From: Jonas Karlman <jonas@kwiboo.se>

Fixes: 226fce6108fe ("phy: Track power-on and init counts in uclass")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/phy-uclass.c | 80 ++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 45ec1471d0ae..2a672549f268 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -228,24 +228,24 @@ int generic_phy_init(struct phy *phy)
=20
 	if (!generic_phy_valid(phy))
 		return 0;
-	ops =3D phy_dev_ops(phy->dev);
-	if (!ops->init)
-		return 0;
-
 	counts =3D phy_get_counts(phy);
 	if (counts->init_count > 0) {
 		counts->init_count++;
 		return 0;
 	}
=20
-	ret =3D ops->init(phy);
-	if (ret)
-		dev_err(phy->dev, "PHY: Failed to init %s: %d.\n",
-			phy->dev->name, ret);
-	else
-		counts->init_count =3D 1;
+	ops =3D phy_dev_ops(phy->dev);
+	if (ops->init) {
+		ret =3D ops->init(phy);
+		if (ret) {
+			dev_err(phy->dev, "PHY: Failed to init %s: %d.\n",
+				phy->dev->name, ret);
+			return ret;
+		}
+	}
+	counts->init_count =3D 1;
=20
-	return ret;
+	return 0;
 }
=20
 int generic_phy_reset(struct phy *phy)
@@ -274,10 +274,6 @@ int generic_phy_exit(struct phy *phy)
=20
 	if (!generic_phy_valid(phy))
 		return 0;
-	ops =3D phy_dev_ops(phy->dev);
-	if (!ops->exit)
-		return 0;
-
 	counts =3D phy_get_counts(phy);
 	if (counts->init_count =3D=3D 0)
 		return 0;
@@ -286,14 +282,18 @@ int generic_phy_exit(struct phy *phy)
 		return 0;
 	}
=20
-	ret =3D ops->exit(phy);
-	if (ret)
-		dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
-			phy->dev->name, ret);
-	else
-		counts->init_count =3D 0;
+	ops =3D phy_dev_ops(phy->dev);
+	if (ops->exit) {
+		ret =3D ops->exit(phy);
+		if (ret) {
+			dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
+				phy->dev->name, ret);
+			return ret;
+		}
+	}
+	counts->init_count =3D 0;
=20
-	return ret;
+	return 0;
 }
=20
 int generic_phy_power_on(struct phy *phy)
@@ -304,10 +304,6 @@ int generic_phy_power_on(struct phy *phy)
=20
 	if (!generic_phy_valid(phy))
 		return 0;
-	ops =3D phy_dev_ops(phy->dev);
-	if (!ops->power_on)
-		return 0;
-
 	counts =3D phy_get_counts(phy);
 	if (counts->power_on_count > 0) {
 		counts->power_on_count++;
@@ -321,12 +317,15 @@ int generic_phy_power_on(struct phy *phy)
 		return ret;
 	}
=20
-	ret =3D ops->power_on(phy);
-	if (ret) {
-		dev_err(phy->dev, "PHY: Failed to power on %s: %d.\n",
-			phy->dev->name, ret);
-		regulator_set_enable_if_allowed(counts->supply, false);
-		return ret;
+	ops =3D phy_dev_ops(phy->dev);
+	if (ops->power_on) {
+		ret =3D ops->power_on(phy);
+		if (ret) {
+			dev_err(phy->dev, "PHY: Failed to power on %s: %d.\n",
+				phy->dev->name, ret);
+			regulator_set_enable_if_allowed(counts->supply, false);
+			return ret;
+		}
 	}
 	counts->power_on_count =3D 1;
=20
@@ -341,10 +340,6 @@ int generic_phy_power_off(struct phy *phy)
=20
 	if (!generic_phy_valid(phy))
 		return 0;
-	ops =3D phy_dev_ops(phy->dev);
-	if (!ops->power_off)
-		return 0;
-
 	counts =3D phy_get_counts(phy);
 	if (counts->power_on_count =3D=3D 0)
 		return 0;
@@ -353,11 +348,14 @@ int generic_phy_power_off(struct phy *phy)
 		return 0;
 	}
=20
-	ret =3D ops->power_off(phy);
-	if (ret) {
-		dev_err(phy->dev, "PHY: Failed to power off %s: %d.\n",
-			phy->dev->name, ret);
-		return ret;
+	ops =3D phy_dev_ops(phy->dev);
+	if (ops->power_off) {
+		ret =3D ops->power_off(phy);
+		if (ret) {
+			dev_err(phy->dev, "PHY: Failed to power off %s: %d.\n",
+				phy->dev->name, ret);
+			return ret;
+		}
 	}
 	counts->power_on_count =3D 0;
=20
--=20
2.34.1

