Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web11.38068.1681911638876395475
 for <u-boot-amlogic@groups.io>;
 Wed, 19 Apr 2023 06:40:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681911637;
	bh=OPJCWA8SM8ALtuRFU+OFQWeRwKn/a3Y7mc0YD18t/nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUSjX8VWx1v5C1WNHatDGxBR0sgy1HduEsvDu2M3LmqTq+gEkrzWjU8PXTufkyfof
	 ZhuWwd8y7APYvGU+tiJ2YmMP8UGnS5+4ut2zzpCxNPaosTLGLuuEGiNGdaugLkY/Tr
	 pl55JUjgTbv8kqyitFDM7vUSxRxohnEuBLkCdtF1V+Nir2eE+YbmfgnwS4FKFppYOU
	 LDc+tZ7dfXBkBfur9nRKKwCQJMVvM5pA3wVT96akynZTqITWgvFFpczzKx5IPf2US9
	 lRs63zDukylVCb5fzI2EFe2Qe1RH5OGkzsjMp1+yzKMTmF6J72tMAeFsVFVM2xhlxk
	 /0Bs8qGskXbew==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v5 3/6] phy: add support for phy-supply
Date: Wed, 19 Apr 2023 16:40:11 +0300
Message-Id: <20230419134014.128461-3-eugen.hristev@collabora.com>
In-Reply-To: <20230419134014.128461-1-eugen.hristev@collabora.com>
References: <20230419134014.128461-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: kever.yang@rock-chips.com, jonas@kwiboo.se, eugen.hristev@collabora.com, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, xdrudis@tinet.cat, jagan@edgeble.ai, neil.armstrong@linaro.org, anarsoul@gmail.com
List-ID: <u-boot-amlogic@groups.io>

Some phys require a phy-supply property that is a phandle to a regulator
that needs to be enabled for phy operations.
Implement basic supply lookup, enable and disabling, if DM_REGULATOR is
available.

[jonas@kwiboo.se:
use regulator_set_enable_if_allowed and disable if power_on ops fails]
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Changes in v5:
- add changes done by Jonas

 drivers/phy/phy-uclass.c | 51 +++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 3fef5135a9cb..45ec1471d0ae 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -12,6 +12,7 @@
 #include <dm/devres.h>
 #include <generic-phy.h>
 #include <linux/list.h>
+#include <power/regulator.h>
=20
 /**
  * struct phy_counts - Init and power-on counts of a single PHY port
@@ -29,12 +30,14 @@
  *              without a matching generic_phy_exit() afterwards
  * @list: Handle for a linked list of these structures corresponding to
  *        ports of the same PHY provider
+ * @supply: Handle to a phy-supply device
  */
 struct phy_counts {
 	unsigned long id;
 	int power_on_count;
 	int init_count;
 	struct list_head list;
+	struct udevice *supply;
 };
=20
 static inline struct phy_ops *phy_dev_ops(struct udevice *dev)
@@ -58,7 +61,7 @@ static struct phy_counts *phy_get_counts(struct phy *ph=
y)
 	return NULL;
 }
=20
-static int phy_alloc_counts(struct phy *phy)
+static int phy_alloc_counts(struct phy *phy, struct udevice *supply)
 {
 	struct list_head *uc_priv;
 	struct phy_counts *counts;
@@ -76,6 +79,7 @@ static int phy_alloc_counts(struct phy *phy)
 	counts->id =3D phy->id;
 	counts->power_on_count =3D 0;
 	counts->init_count =3D 0;
+	counts->supply =3D supply;
 	list_add(&counts->list, uc_priv);
=20
 	return 0;
@@ -123,7 +127,7 @@ int generic_phy_get_by_index_nodev(ofnode node, int i=
ndex, struct phy *phy)
 {
 	struct ofnode_phandle_args args;
 	struct phy_ops *ops;
-	struct udevice *phydev;
+	struct udevice *phydev, *supply =3D NULL;
 	int i, ret;
=20
 	debug("%s(node=3D%s, index=3D%d, phy=3D%p)\n",
@@ -172,7 +176,17 @@ int generic_phy_get_by_index_nodev(ofnode node, int =
index, struct phy *phy)
 		goto err;
 	}
=20
-	ret =3D phy_alloc_counts(phy);
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret =3D device_get_supply_regulator(phydev, "phy-supply",
+						  &supply);
+		if (ret && ret !=3D -ENOENT) {
+			debug("%s: device_get_supply_regulator failed: %d\n",
+			      __func__, ret);
+			goto err;
+		}
+	}
+
+	ret =3D phy_alloc_counts(phy, supply);
 	if (ret) {
 		debug("phy_alloc_counts() failed: %d\n", ret);
 		goto err;
@@ -300,14 +314,23 @@ int generic_phy_power_on(struct phy *phy)
 		return 0;
 	}
=20
+	ret =3D regulator_set_enable_if_allowed(counts->supply, true);
+	if (ret && ret !=3D -ENOSYS) {
+		dev_err(phy->dev, "PHY: Failed to enable regulator %s: %d.\n",
+			counts->supply->name, ret);
+		return ret;
+	}
+
 	ret =3D ops->power_on(phy);
-	if (ret)
+	if (ret) {
 		dev_err(phy->dev, "PHY: Failed to power on %s: %d.\n",
 			phy->dev->name, ret);
-	else
-		counts->power_on_count =3D 1;
+		regulator_set_enable_if_allowed(counts->supply, false);
+		return ret;
+	}
+	counts->power_on_count =3D 1;
=20
-	return ret;
+	return 0;
 }
=20
 int generic_phy_power_off(struct phy *phy)
@@ -331,13 +354,19 @@ int generic_phy_power_off(struct phy *phy)
 	}
=20
 	ret =3D ops->power_off(phy);
-	if (ret)
+	if (ret) {
 		dev_err(phy->dev, "PHY: Failed to power off %s: %d.\n",
 			phy->dev->name, ret);
-	else
-		counts->power_on_count =3D 0;
+		return ret;
+	}
+	counts->power_on_count =3D 0;
=20
-	return ret;
+	ret =3D regulator_set_enable_if_allowed(counts->supply, false);
+	if (ret && ret !=3D -ENOSYS)
+		dev_err(phy->dev, "PHY: Failed to disable regulator %s: %d.\n",
+			counts->supply->name, ret);
+
+	return 0;
 }
=20
 int generic_phy_configure(struct phy *phy, void *params)
--=20
2.34.1

