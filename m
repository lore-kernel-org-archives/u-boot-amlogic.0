Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by mx.groups.io with SMTP id smtpd.web10.102660.1680617543121761154
 for <u-boot-amlogic@groups.io>;
 Tue, 04 Apr 2023 07:12:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1680617541;
	bh=Av+nAjll95/V07i1rVX8QkEYQgPIiz9CocMeuCmFXTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFjEeBzmLG4R/PhszCHpXLapVOESfPXAKhsvH2OxG1FsbI2icmGI4Xno9Rm5A98mU
	 wnPNO/mEq+5sUSN4oXFaht7KZeYkWoj4yuAF1IRkjOZxAS15HTSILbfZjRZTnG+YST
	 l7edxeES0qvmc44HAurW4CQOJJaylK7s3CQMNDI9c1iB1F9mliaMItSVWcWFYy9iVA
	 9kuqzeuh943eD1+YL7/f+ijEzy4Ig0vtdyvWGRI5FW2RjHBy0LodloFyEf+NuNWTir
	 G3MXhUffOVa0nKbhC/CR+aubY9PQehefgKY/+6gqcGQuXgBapmEGwBux3+TaTqqWyz
	 yGePUxdR9eF0g==
From: Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH v4 3/5] phy: add support for phy-supply
Date: Tue,  4 Apr 2023 17:11:53 +0300
Message-Id: <20230404141155.283987-3-eugen.hristev@collabora.com>
In-Reply-To: <20230404141155.283987-1-eugen.hristev@collabora.com>
References: <20230404141155.283987-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, kever.yang@rock-chips.com, neil.armstrong@linaro.org, jagan@edgeble.ai, jonas@kwiboo.se, xdrudis@tinet.cat, anarsoul@gmail.com, Eugen Hristev <eugen.hristev@collabora.com>
List-ID: <u-boot-amlogic@groups.io>

Some phys require a phy-supply property that is a phandle to a regulator
that needs to be enabled for phy operations.
Implement basic supply lookup, enable and disabling, if DM_REGULATOR is
available.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/phy/phy-uclass.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 3fef5135a9cb..475ac285df05 100644
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
@@ -224,6 +227,12 @@ int generic_phy_init(struct phy *phy)
 		return 0;
 	}
=20
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	device_get_supply_regulator(phy->dev, "phy-supply", &counts->supply);
+	if (IS_ERR(counts->supply))
+		dev_dbg(phy->dev, "no phy-supply property found\n");
+#endif
+
 	ret =3D ops->init(phy);
 	if (ret)
 		dev_err(phy->dev, "PHY: Failed to init %s: %d.\n",
@@ -272,6 +281,12 @@ int generic_phy_exit(struct phy *phy)
 		return 0;
 	}
=20
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	if (!IS_ERR_OR_NULL(counts->supply)) {
+		ret =3D regulator_set_enable(counts->supply, false);
+		dev_dbg(phy->dev, "supply disable status: %d\n", ret);
+	}
+#endif
 	ret =3D ops->exit(phy);
 	if (ret)
 		dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
@@ -300,6 +315,13 @@ int generic_phy_power_on(struct phy *phy)
 		return 0;
 	}
=20
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	if (!IS_ERR_OR_NULL(counts->supply)) {
+		ret =3D regulator_set_enable(counts->supply, true);
+		dev_dbg(phy->dev, "supply enable status: %d\n", ret);
+	}
+#endif
+
 	ret =3D ops->power_on(phy);
 	if (ret)
 		dev_err(phy->dev, "PHY: Failed to power on %s: %d.\n",
--=20
2.34.1

