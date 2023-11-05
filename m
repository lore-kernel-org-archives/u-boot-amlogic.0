Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE3C001B2
	for <webhook@archiver.kernel.org>; Sun,  5 Nov 2023 08:38:41 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.26500.1699173512535486592
 for <u-boot-amlogic@groups.io>;
 Sun, 05 Nov 2023 01:38:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=k+pyjvAx;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 119B410000C;
	Sun,  5 Nov 2023 11:38:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 119B410000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1699173511;
	bh=VWm5mZ7k525wGHeC8Zek+eacOZPK50MXAbULGfY7hTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=k+pyjvAxfbW5PT0k99YQINlKNN1WBVKqC8AYKshTbx2sZkqHBNdra/m/rt2vWLZ96
	 djJLbAQkBuD8xE1i1N/KhO+ZHBneXLzr9uN+gsyQzTCrnnt8qBsR4eYW0MnmUJ/dw7
	 0fDntiZkg64KncHU71rBCA0UfF7cyB/UBpF9Kb5mLdofjljYJnF0tiUNb8+nlVaq7F
	 oxMsmeMcA5AX+Evt4EkEhpxXpmMd4OpseR/Dzj3mWqGpEBqSCkiVQEk2GsHTQYhpRd
	 ChfortWfODRlrAh5kRJD1dCtg/EVrE78Jn9uJN6KbaWhKL1ABM4wiKtnjnR02sBjgX
	 Q/xpZEtxa8Ahw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  5 Nov 2023 11:38:30 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 5 Nov 2023 11:38:30 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v6 7/8] clk: treewide: switch to clock dump from clk_ops
Date: Sun, 5 Nov 2023 11:38:08 +0300
Message-ID: <20231105083809.3293-8-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105083809.3293-1-ivprusov@sberdevices.ru>
References: <20231105083809.3293-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181122 [Nov 03 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/05 03:40:00 #22405617
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 05 Nov 2023 08:38:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1840

Switch to using new dump operation in clock provider drivers instead of
overriding soc_clk_dump.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
 arch/mips/mach-pic32/cpu.c             | 23 ----------------
 drivers/clk/aspeed/clk_ast2600.c       | 13 +++++----
 drivers/clk/clk_k210.c                 | 12 +++------
 drivers/clk/clk_pic32.c                | 37 ++++++++++++++++++++++++++
 drivers/clk/clk_versal.c               |  9 ++++---
 drivers/clk/clk_zynq.c                 | 28 ++++++++-----------
 drivers/clk/clk_zynqmp.c               | 22 +++++++--------
 drivers/clk/imx/clk-imx8.c             | 13 +++------
 drivers/clk/meson/a1.c                 | 28 ++++++-------------
 drivers/clk/mvebu/armada-37xx-periph.c | 20 +++++++++-----
 drivers/clk/stm32/clk-stm32mp1.c       | 31 ++++++---------------
 11 files changed, 108 insertions(+), 128 deletions(-)

diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index dbf8c9cd22..3181a946a2 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -143,26 +143,3 @@ const char *get_core_name(void)
 	return str;
 }
 #endif
-#ifdef CONFIG_CMD_CLK
-
-int soc_clk_dump(void)
-{
-	int i;
-
-	printf("PLL Speed: %lu MHz\n",
-	       CLK_MHZ(rate(PLLCLK)));
-
-	printf("CPU Speed: %lu MHz\n", CLK_MHZ(rate(PB7CLK)));
-
-	printf("MPLL Speed: %lu MHz\n", CLK_MHZ(rate(MPLL)));
-
-	for (i =3D PB1CLK; i <=3D PB7CLK; i++)
-		printf("PB%d Clock Speed: %lu MHz\n", i - PB1CLK + 1,
-		       CLK_MHZ(rate(i)));
-
-	for (i =3D REF1CLK; i <=3D REF5CLK; i++)
-		printf("REFO%d Clock Speed: %lu MHz\n", i - REF1CLK + 1,
-		       CLK_MHZ(rate(i)));
-	return 0;
-}
-#endif
diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_as=
t2600.c
index b3cc8392fa..eecfacd7fc 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -1109,6 +1109,7 @@ struct aspeed_clks {
 	const char *name;
 };
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
 static struct aspeed_clks aspeed_clk_names[] =3D {
 	{ ASPEED_CLK_HPLL, "hpll" },
 	{ ASPEED_CLK_MPLL, "mpll" },
@@ -1123,18 +1124,12 @@ static struct aspeed_clks aspeed_clk_names[] =3D =
{
 	{ ASPEED_CLK_HUARTX, "huxclk" },
 };
=20
-int soc_clk_dump(void)
+static void ast2600_clk_dump(struct udevice *dev)
 {
-	struct udevice *dev;
 	struct clk clk;
 	unsigned long rate;
 	int i, ret;
=20
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(aspeed_sc=
u),
-					  &dev);
-	if (ret)
-		return ret;
-
 	printf("Clk\t\tHz\n");
=20
 	for (i =3D 0; i < ARRAY_SIZE(aspeed_clk_names); i++) {
@@ -1167,11 +1162,15 @@ int soc_clk_dump(void)
=20
 	return 0;
 }
+#endif
=20
 struct clk_ops ast2600_clk_ops =3D {
 	.get_rate =3D ast2600_clk_get_rate,
 	.set_rate =3D ast2600_clk_set_rate,
 	.enable =3D ast2600_clk_enable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D ast2600_clk_dump,
+#endif
 };
=20
 static int ast2600_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index 2f17152021..b8d666e805 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -1276,16 +1276,10 @@ static void show_clks(struct k210_clk_priv *priv,=
 int id, int depth)
 	}
 }
=20
-int soc_clk_dump(void)
+static int k210_clk_dump(struct udevice *dev)
 {
-	int ret;
-	struct udevice *dev;
 	struct k210_clk_priv *priv;
=20
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(k210_clk)=
,
-					  &dev);
-	if (ret)
-		return ret;
 	priv =3D dev_get_priv(dev);
=20
 	puts(" Rate      Enabled Name\n");
@@ -1293,7 +1287,6 @@ int soc_clk_dump(void)
 	printf(" %-9lu %-7c %*s%s\n", clk_get_rate(&priv->in0), 'y', 0, "",
 	       priv->in0.dev->name);
 	show_clks(priv, K210_CLK_IN0, 1);
-	return 0;
 }
 #endif
=20
@@ -1304,6 +1297,9 @@ static const struct clk_ops k210_clk_ops =3D {
 	.set_parent =3D k210_clk_set_parent,
 	.enable =3D k210_clk_enable,
 	.disable =3D k210_clk_disable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D k210_clk_dump,
+#endif
 };
=20
 static int k210_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/clk_pic32.c b/drivers/clk/clk_pic32.c
index ef06a7fb9f..a77d0e7419 100644
--- a/drivers/clk/clk_pic32.c
+++ b/drivers/clk/clk_pic32.c
@@ -20,6 +20,8 @@
=20
 DECLARE_GLOBAL_DATA_PTR;
=20
+#define CLK_MHZ(x)	((x) / 1000000)
+
 /* Primary oscillator */
 #define SYS_POSC_CLK_HZ	24000000
=20
@@ -385,9 +387,44 @@ static ulong pic32_set_rate(struct clk *clk, ulong r=
ate)
 	return rate;
 }
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static void pic32_dump(struct udevice *dev)
+{
+	int i;
+	struct clk clk;
+
+	clk.dev =3D dev;
+
+	clk.id =3D PLLCLK;
+	printf("PLL Speed: %lu MHz\n",
+	       CLK_MHZ(pic32_get_rate(&clk)));
+
+	clk.id =3D PB7CLK;
+	printf("CPU Speed: %lu MHz\n", CLK_MHZ(pic32_get_rate(&clk)));
+
+	clk.id =3D MPLL;
+	printf("MPLL Speed: %lu MHz\n", CLK_MHZ(pic32_get_rate(&clk)));
+
+	for (i =3D PB1CLK; i <=3D PB7CLK; i++) {
+		clk.id =3D i;
+		printf("PB%d Clock Speed: %lu MHz\n", i - PB1CLK + 1,
+		       CLK_MHZ(pic32_get_rate(&clk)));
+	}
+
+	for (i =3D REF1CLK; i <=3D REF5CLK; i++) {
+		clk.id =3D i;
+		printf("REFO%d Clock Speed: %lu MHz\n", i - REF1CLK + 1,
+		       CLK_MHZ(pic32_get_rate(&clk)));
+	}
+}
+#endif
+
 static struct clk_ops pic32_pic32_clk_ops =3D {
 	.set_rate =3D pic32_set_rate,
 	.get_rate =3D pic32_get_rate,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D pic32_dump,
+#endif
 };
=20
 static int pic32_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index c473643603..42ab032bf7 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -555,7 +555,8 @@ static int versal_clock_get_rate(u32 clk_id, u64 *clk=
_rate)
 	return 0;
 }
=20
-int soc_clk_dump(void)
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static void versal_clk_dump(struct udevice __always_unused *dev)
 {
 	u64 clk_rate =3D 0;
 	u32 type, ret, i =3D 0;
@@ -575,9 +576,8 @@ int soc_clk_dump(void)
 			printf("clk: %s  freq:%lld\n",
 			       clock[i].clk_name, clk_rate);
 	}
-
-	return 0;
 }
+#endif
=20
 static void versal_get_clock_info(void)
 {
@@ -769,6 +769,9 @@ static struct clk_ops versal_clk_ops =3D {
 	.set_rate =3D versal_clk_set_rate,
 	.get_rate =3D versal_clk_get_rate,
 	.enable =3D versal_clk_enable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D versal_clk_dump,
+#endif
 };
=20
 static const struct udevice_id versal_clk_ids[] =3D {
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index be5226175f..34f964d72a 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -454,6 +454,7 @@ static int dummy_enable(struct clk *clk)
 	return 0;
 }
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
 static const char * const clk_names[clk_max] =3D {
 	"armpll", "ddrpll", "iopll",
 	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
@@ -468,22 +469,10 @@ static const char * const clk_names[clk_max] =3D {
 	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
 };
=20
-/**
- * soc_clk_dump() - Print clock frequencies
- * Returns zero on success
- *
- * Implementation for the clk dump command.
- */
-int soc_clk_dump(void)
+static void zynq_clk_dump(struct udevice *dev)
 {
-	struct udevice *dev;
 	int i, ret;
=20
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
-					  DM_DRIVER_GET(zynq_clk), &dev);
-	if (ret)
-		return ret;
-
 	printf("clk\t\tfrequency\n");
 	for (i =3D 0; i < clk_max; i++) {
 		const char *name =3D clk_names[i];
@@ -494,8 +483,11 @@ int soc_clk_dump(void)
=20
 			clk.id =3D i;
 			ret =3D clk_request(dev, &clk);
-			if (ret < 0)
-				return ret;
+			if (ret < 0) {
+				printf("%s clk_request() failed: %d\n",
+				       __func__, ret);
+				break;
+			}
=20
 			rate =3D clk_get_rate(&clk);
=20
@@ -508,9 +500,8 @@ int soc_clk_dump(void)
 				printf("%10s%20lu\n", name, rate);
 		}
 	}
-
-	return 0;
 }
+#endif
=20
 static struct clk_ops zynq_clk_ops =3D {
 	.get_rate =3D zynq_clk_get_rate,
@@ -518,6 +509,9 @@ static struct clk_ops zynq_clk_ops =3D {
 	.set_rate =3D zynq_clk_set_rate,
 #endif
 	.enable =3D dummy_enable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D zynq_clk_dump,
+#endif
 };
=20
 static int zynq_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 1cfe0e25b1..a334a77b79 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -735,16 +735,11 @@ static ulong zynqmp_clk_set_rate(struct clk *clk, u=
long rate)
 	}
 }
=20
-int soc_clk_dump(void)
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static void zynqmp_clk_dump(struct udevice *dev)
 {
-	struct udevice *dev;
 	int i, ret;
=20
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
-		DM_DRIVER_GET(zynqmp_clk), &dev);
-	if (ret)
-		return ret;
-
 	printf("clk\t\tfrequency\n");
 	for (i =3D 0; i < clk_max; i++) {
 		const char *name =3D clk_names[i];
@@ -754,8 +749,11 @@ int soc_clk_dump(void)
=20
 			clk.id =3D i;
 			ret =3D clk_request(dev, &clk);
-			if (ret < 0)
-				return ret;
+			if (ret < 0) {
+				printf("%s clk_request() failed: %d\n",
+				       __func__, ret);
+				break;
+			}
=20
 			rate =3D clk_get_rate(&clk);
=20
@@ -769,9 +767,8 @@ int soc_clk_dump(void)
 				printf("%10s%20lu\n", name, rate);
 		}
 	}
-
-	return 0;
 }
+#endif
=20
 static int zynqmp_get_freq_by_name(char *name, struct udevice *dev, ulon=
g *freq)
 {
@@ -871,6 +868,9 @@ static struct clk_ops zynqmp_clk_ops =3D {
 	.set_rate =3D zynqmp_clk_set_rate,
 	.get_rate =3D zynqmp_clk_get_rate,
 	.enable =3D zynqmp_clk_enable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D zynqmp_clk_dump,
+#endif
 };
=20
 static const struct udevice_id zynqmp_clk_ids[] =3D {
diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
index ceeead3434..9600672e07 100644
--- a/drivers/clk/imx/clk-imx8.c
+++ b/drivers/clk/imx/clk-imx8.c
@@ -43,18 +43,12 @@ static int imx8_clk_enable(struct clk *clk)
 }
=20
 #if IS_ENABLED(CONFIG_CMD_CLK)
-int soc_clk_dump(void)
+static void imx8_clk_dump(struct udevice *dev)
 {
-	struct udevice *dev;
 	struct clk clk;
 	unsigned long rate;
 	int i, ret;
=20
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
-					  DM_DRIVER_GET(imx8_clk), &dev);
-	if (ret)
-		return ret;
-
 	printf("Clk\t\tHz\n");
=20
 	for (i =3D 0; i < num_clks; i++) {
@@ -84,8 +78,6 @@ int soc_clk_dump(void)
 		printf("%s(%3lu):\t%lu\n",
 		       imx8_clk_names[i].name, imx8_clk_names[i].id, rate);
 	}
-
-	return 0;
 }
 #endif
=20
@@ -94,6 +86,9 @@ static struct clk_ops imx8_clk_ops =3D {
 	.get_rate =3D imx8_clk_get_rate,
 	.enable =3D imx8_clk_enable,
 	.disable =3D imx8_clk_disable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D imx8_clk_dump,
+#endif
 };
=20
 static int imx8_clk_probe(struct udevice *dev)
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index e3fa9db7d0..e5f712f44b 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -630,6 +630,7 @@ static const struct udevice_id meson_clk_ids[] =3D {
 	{ }
 };
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
 static const char *meson_clk_get_name(struct clk *clk, int id)
 {
 	const struct meson_clk_info *info;
@@ -639,7 +640,7 @@ static const char *meson_clk_get_name(struct clk *clk=
, int id)
 	return IS_ERR(info) ? "unknown" : info->name;
 }
=20
-static int meson_clk_dump(struct clk *clk)
+static int meson_clk_dump_single(struct clk *clk)
 {
 	const struct meson_clk_info *info;
 	struct meson_clk *priv;
@@ -674,7 +675,7 @@ static int meson_clk_dump(struct clk *clk)
 	return 0;
 }
=20
-static int meson_clk_dump_dev(struct udevice *dev)
+static void meson_clk_dump(struct udevice *dev)
 {
 	int i;
 	struct meson_clk_data *data;
@@ -687,29 +688,13 @@ static int meson_clk_dump_dev(struct udevice *dev)
=20
 	data =3D (struct meson_clk_data *)dev_get_driver_data(dev);
 	for (i =3D 0; i < data->num_clocks; i++) {
-		meson_clk_dump(&(struct clk){
+		meson_clk_dump_single(&(struct clk){
 			.dev =3D dev,
 			.id =3D i
 		});
 	}
-
-	return 0;
-}
-
-int soc_clk_dump(void)
-{
-	struct udevice *dev;
-	int i =3D 0;
-
-	while (!uclass_get_device(UCLASS_CLK, i++, &dev)) {
-		if (dev->driver =3D=3D DM_DRIVER_GET(meson_clk)) {
-			meson_clk_dump_dev(dev);
-			printf("\n");
-		}
-	}
-
-	return 0;
 }
+#endif
=20
 static struct clk_ops meson_clk_ops =3D {
 	.disable	=3D meson_clk_disable,
@@ -717,6 +702,9 @@ static struct clk_ops meson_clk_ops =3D {
 	.get_rate	=3D meson_clk_get_rate,
 	.set_rate	=3D meson_clk_set_rate,
 	.set_parent	=3D meson_clk_set_parent,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump		=3D meson_clk_dump,
+#endif
 };
=20
 U_BOOT_DRIVER(meson_clk) =3D {
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/a=
rmada-37xx-periph.c
index e75052f383..1a7097029a 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -488,33 +488,36 @@ static int armada_37xx_periph_clk_dump(struct udevi=
ce *dev)
 static int clk_dump(const char *name, int (*func)(struct udevice *))
 {
 	struct udevice *dev;
+	int ret;
=20
 	if (uclass_get_device_by_name(UCLASS_CLK, name, &dev)) {
 		printf("Cannot find device %s\n", name);
 		return -ENODEV;
 	}
=20
-	return func(dev);
+	ret =3D func(dev);
+	if (ret)
+		printf("Dump failed for %s: %d\n", name, ret);
+
+	return ret;
 }
=20
 int armada_37xx_tbg_clk_dump(struct udevice *);
=20
-int soc_clk_dump(void)
+static void armada37xx_clk_dump(struct udevice __always_unused *dev)
 {
 	printf("  xtal at %u000000 Hz\n\n", get_ref_clk());
=20
 	if (clk_dump("tbg@13200", armada_37xx_tbg_clk_dump))
-		return 1;
+		return;
=20
 	if (clk_dump("nb-periph-clk@13000",
 		     armada_37xx_periph_clk_dump))
-		return 1;
+		return;
=20
 	if (clk_dump("sb-periph-clk@18000",
 		     armada_37xx_periph_clk_dump))
-		return 1;
-
-	return 0;
+		return;
 }
 #endif
=20
@@ -605,6 +608,9 @@ static const struct clk_ops armada_37xx_periph_clk_op=
s =3D {
 	.set_parent =3D armada_37xx_periph_clk_set_parent,
 	.enable =3D armada_37xx_periph_clk_enable,
 	.disable =3D armada_37xx_periph_clk_disable,
+#if IS_ENABLED(CONFIG_CMD_CLK)
+	.dump =3D armada37xx_clk_dump,
+#endif
 };
=20
 static const struct udevice_id armada_37xx_periph_clk_ids[] =3D {
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm=
32mp1.c
index f3ac8c7583..6f000c8e44 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -2225,10 +2225,13 @@ static void stm32mp1_osc_init(struct udevice *dev=
)
 	}
 }
=20
-static void  __maybe_unused stm32mp1_clk_dump(struct stm32mp1_clk_priv *=
priv)
+static void __maybe_unused stm32mp1_clk_dump(struct udevice *dev)
 {
 	char buf[32];
 	int i, s, p;
+	struct stm32mp1_clk_priv *priv;
+
+	priv =3D dev_get_priv(dev);
=20
 	printf("Clocks:\n");
 	for (i =3D 0; i < _PARENT_NB; i++) {
@@ -2252,27 +2255,6 @@ static void  __maybe_unused stm32mp1_clk_dump(stru=
ct stm32mp1_clk_priv *priv)
 	}
 }
=20
-#ifdef CONFIG_CMD_CLK
-int soc_clk_dump(void)
-{
-	struct udevice *dev;
-	struct stm32mp1_clk_priv *priv;
-	int ret;
-
-	ret =3D uclass_get_device_by_driver(UCLASS_CLK,
-					  DM_DRIVER_GET(stm32mp1_clock),
-					  &dev);
-	if (ret)
-		return ret;
-
-	priv =3D dev_get_priv(dev);
-
-	stm32mp1_clk_dump(priv);
-
-	return 0;
-}
-#endif
-
 static int stm32mp1_clk_probe(struct udevice *dev)
 {
 	int result =3D 0;
@@ -2302,7 +2284,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
 #if defined(VERBOSE_DEBUG)
 	/* display debug information for probe after relocation */
 	if (gd->flags & GD_FLG_RELOC)
-		stm32mp1_clk_dump(priv);
+		stm32mp1_clk_dump(dev);
 #endif
=20
 	gd->cpu_clk =3D stm32mp1_clk_get(priv, _CK_MPU);
@@ -2333,6 +2315,9 @@ static const struct clk_ops stm32mp1_clk_ops =3D {
 	.disable =3D stm32mp1_clk_disable,
 	.get_rate =3D stm32mp1_clk_get_rate,
 	.set_rate =3D stm32mp1_clk_set_rate,
+#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_SPL_BUILD)
+	.dump =3D stm32mp1_clk_dump,
+#endif
 };
=20
 U_BOOT_DRIVER(stm32mp1_clock) =3D {
--=20
2.34.1


