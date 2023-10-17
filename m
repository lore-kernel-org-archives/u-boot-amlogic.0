Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CADACDB483
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 16:57:20 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.224825.1697561833953563132
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 09:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=lwlUuGBs;
 spf=pass (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6940712000F;
	Tue, 17 Oct 2023 19:57:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6940712000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1697561832;
	bh=unQt9zMtBVnaUFZL6phBIMNd+mh6wjhqlzH1gUb0L3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lwlUuGBsk10ppeeqgW1LcgXvTAtg5Q7N1cQPTq2mQ4rNWsWA86HsjwLpFVem+Ltpw
	 PHG0HKEeccUXokH+kfqkDYWiRg7xBjjueb+A/oQyB9/RzjyOVjfKMK19kvkuLIK7cm
	 zEvJ9iPmkmUu1JyyExsjpfnWKzHa1xJxCahxStrO4idx2PpYsOsgTAABnMs7078Q8p
	 Udx2GIP3e5oUVxSXg9i0wq3heCouB/nWWV02PCp48voW6i4/8cUQQyuT9xUMAtpPw0
	 n0MOCQ8tyCBPQh/hs3SjrlAfdzmhmWUNkBhiPEnoLjLXMrsrtRYm6IyWjHZSY4tb4t
	 OV1LvWN7P0MMw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 19:57:12 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 19:57:11 +0300
From: Igor Prusov <ivprusov@sberdevices.ru>
To: Michal Simek <michal.simek@amd.com>, Daniel Schwierzeck
	<daniel.schwierzeck@gmail.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei
 Wang <chiawei_wang@aspeedtech.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
CC: <prusovigor@gmail.com>, <kernel@sberdevices.ru>, Igor Prusov
	<ivprusov@sberdevices.ru>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel
 Stanley <joel@jms.id.au>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v4 7/8] clk: treewide: switch to clock dump from clk_ops
Date: Tue, 17 Oct 2023 19:56:48 +0300
Message-ID: <20231017165649.1492-8-ivprusov@sberdevices.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017165649.1492-1-ivprusov@sberdevices.ru>
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180684 [Oct 17 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/17 15:08:00 #22212325
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 16:57:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1768

Switch to using new dump operation in clock provider drivers instead of
overriding soc_clk_dump.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/mips/mach-pic32/cpu.c             | 23 ---------------
 drivers/clk/aspeed/clk_ast2600.c       | 13 ++++-----
 drivers/clk/clk_k210.c                 | 11 +++-----
 drivers/clk/clk_pic32.c                | 39 ++++++++++++++++++++++++++
 drivers/clk/clk_versal.c               |  7 ++++-
 drivers/clk/clk_zynq.c                 | 19 ++++---------
 drivers/clk/clk_zynqmp.c               | 13 ++++-----
 drivers/clk/imx/clk-imx8.c             | 11 +++-----
 drivers/clk/meson/a1.c                 | 24 ++++------------
 drivers/clk/mvebu/armada-37xx-periph.c |  5 +++-
 drivers/clk/stm32/clk-stm32mp1.c       | 29 ++++++-------------
 11 files changed, 89 insertions(+), 105 deletions(-)

diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index 7ed306e045..68099dd02f 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -144,26 +144,3 @@ const char *get_core_name(void)
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
index b3cc8392fa..e1365d3f81 100644
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
+static int ast2600_clk_dump(struct udevice *dev)
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
index 2f17152021..058940b828 100644
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
@@ -1304,6 +1298,9 @@ static const struct clk_ops k210_clk_ops =3D {
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
index ef06a7fb9f..f756fc88f0 100644
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
@@ -385,9 +387,46 @@ static ulong pic32_set_rate(struct clk *clk, ulong r=
ate)
 	return rate;
 }
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static int pic32_dump(struct udevice *dev)
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
+
+	return 0;
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
index c473643603..f3fafec7f7 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -555,7 +555,8 @@ static int versal_clock_get_rate(u32 clk_id, u64 *clk=
_rate)
 	return 0;
 }
=20
-int soc_clk_dump(void)
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static int versal_clk_dump(struct udevice __always_unused *dev)
 {
 	u64 clk_rate =3D 0;
 	u32 type, ret, i =3D 0;
@@ -578,6 +579,7 @@ int soc_clk_dump(void)
=20
 	return 0;
 }
+#endif
=20
 static void versal_get_clock_info(void)
 {
@@ -769,6 +771,9 @@ static struct clk_ops versal_clk_ops =3D {
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
index be5226175f..d492eea3b0 100644
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
+static int zynq_clk_dump(struct udevice *dev)
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
@@ -511,6 +500,7 @@ int soc_clk_dump(void)
=20
 	return 0;
 }
+#endif
=20
 static struct clk_ops zynq_clk_ops =3D {
 	.get_rate =3D zynq_clk_get_rate,
@@ -518,6 +508,9 @@ static struct clk_ops zynq_clk_ops =3D {
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
index 1cfe0e25b1..dfcda429c7 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -735,16 +735,11 @@ static ulong zynqmp_clk_set_rate(struct clk *clk, u=
long rate)
 	}
 }
=20
-int soc_clk_dump(void)
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static int zynqmp_clk_dump(struct udevice *dev)
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
@@ -772,6 +767,7 @@ int soc_clk_dump(void)
=20
 	return 0;
 }
+#endif
=20
 static int zynqmp_get_freq_by_name(char *name, struct udevice *dev, ulon=
g *freq)
 {
@@ -871,6 +867,9 @@ static struct clk_ops zynqmp_clk_ops =3D {
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
index ceeead3434..6cd55f4369 100644
--- a/drivers/clk/imx/clk-imx8.c
+++ b/drivers/clk/imx/clk-imx8.c
@@ -43,18 +43,12 @@ static int imx8_clk_enable(struct clk *clk)
 }
=20
 #if IS_ENABLED(CONFIG_CMD_CLK)
-int soc_clk_dump(void)
+static int imx8_clk_dump(struct udevice *dev)
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
@@ -94,6 +88,9 @@ static struct clk_ops imx8_clk_ops =3D {
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
index e3fa9db7d0..1820b31ff7 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -639,7 +639,7 @@ static const char *meson_clk_get_name(struct clk *clk=
, int id)
 	return IS_ERR(info) ? "unknown" : info->name;
 }
=20
-static int meson_clk_dump(struct clk *clk)
+static int meson_clk_dump_single(struct clk *clk)
 {
 	const struct meson_clk_info *info;
 	struct meson_clk *priv;
@@ -674,7 +674,7 @@ static int meson_clk_dump(struct clk *clk)
 	return 0;
 }
=20
-static int meson_clk_dump_dev(struct udevice *dev)
+static int meson_clk_dump(struct udevice *dev)
 {
 	int i;
 	struct meson_clk_data *data;
@@ -687,7 +687,7 @@ static int meson_clk_dump_dev(struct udevice *dev)
=20
 	data =3D (struct meson_clk_data *)dev_get_driver_data(dev);
 	for (i =3D 0; i < data->num_clocks; i++) {
-		meson_clk_dump(&(struct clk){
+		meson_clk_dump_single(&(struct clk){
 			.dev =3D dev,
 			.id =3D i
 		});
@@ -696,27 +696,15 @@ static int meson_clk_dump_dev(struct udevice *dev)
 	return 0;
 }
=20
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
-}
-
 static struct clk_ops meson_clk_ops =3D {
 	.disable	=3D meson_clk_disable,
 	.enable		=3D meson_clk_enable,
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
index e75052f383..faf75c8792 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -499,7 +499,7 @@ static int clk_dump(const char *name, int (*func)(str=
uct udevice *))
=20
 int armada_37xx_tbg_clk_dump(struct udevice *);
=20
-int soc_clk_dump(void)
+static int armada37xx_clk_dump(struct udevice __always_unused *dev)
 {
 	printf("  xtal at %u000000 Hz\n\n", get_ref_clk());
=20
@@ -605,6 +605,9 @@ static const struct clk_ops armada_37xx_periph_clk_op=
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
index f3ac8c7583..f78540ad1d 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -2225,10 +2225,13 @@ static void stm32mp1_osc_init(struct udevice *dev=
)
 	}
 }
=20
-static void  __maybe_unused stm32mp1_clk_dump(struct stm32mp1_clk_priv *=
priv)
+static int __maybe_unused stm32mp1_clk_dump(struct udevice *dev)
 {
 	char buf[32];
 	int i, s, p;
+	struct stm32mp1_clk_priv *priv;
+
+	priv =3D dev_get_priv(dev);
=20
 	printf("Clocks:\n");
 	for (i =3D 0; i < _PARENT_NB; i++) {
@@ -2250,28 +2253,9 @@ static void  __maybe_unused stm32mp1_clk_dump(stru=
ct stm32mp1_clk_priv *priv)
 			       stm32mp1_clk_parent_sel_name[i], i, p);
 		}
 	}
-}
-
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
=20
 	return 0;
 }
-#endif
=20
 static int stm32mp1_clk_probe(struct udevice *dev)
 {
@@ -2302,7 +2286,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
 #if defined(VERBOSE_DEBUG)
 	/* display debug information for probe after relocation */
 	if (gd->flags & GD_FLG_RELOC)
-		stm32mp1_clk_dump(priv);
+		stm32mp1_clk_dump(dev);
 #endif
=20
 	gd->cpu_clk =3D stm32mp1_clk_get(priv, _CK_MPU);
@@ -2333,6 +2317,9 @@ static const struct clk_ops stm32mp1_clk_ops =3D {
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


