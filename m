Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3821AC4167B
	for <webhook@archiver.kernel.org>; Sun,  5 Nov 2023 08:38:41 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.26843.1699173510582581161
 for <u-boot-amlogic@groups.io>;
 Sun, 05 Nov 2023 01:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=gcjsouIF;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 14443100009;
	Sun,  5 Nov 2023 11:38:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 14443100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1699173508;
	bh=gBOdzydja8Nsi8AZU2xyNEDvA6Dqk2mnbxHqrUlwk0M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gcjsouIFhz7i+1IAcV14GOhFO+MhbkBxmoyYedJWKv/pvzA5GW73SNQjvu3Lbl7x6
	 ZRZ1MMPU+etEl/v9wL3u52eMvfNSl6MEkyhHwqCqFGG/igAI1VDLZYXQfMYLYnPJoF
	 kHLHtu65O/PP/IHisSIWamkQkvktsH2+rtWICJupkqHCeJn7/IeHMZTc9Un19EDPla
	 JbPM/z6gSN4bBymLjtDVpqzXagALo03uVHt5fnvYASSxGjN7ZHruGnCg/8zVedfDWB
	 +PiFBgAqHReAlXLSeTx9AfT/DcCW4yaDD9xtmYvmJ1gh6SnKH28u6bNtY5l2Dq4n+c
	 5XD6V/sMYY/Dg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  5 Nov 2023 11:38:27 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 5 Nov 2023 11:38:27 +0300
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
Subject: [PATCH v6 3/8] clk: k210: Move soc_clk_dump function
Date: Sun, 5 Nov 2023 11:38:04 +0300
Message-ID: <20231105083809.3293-4-ivprusov@sberdevices.ru>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1836

Move clock dump function to avoid forward declaration after switching to
dump in clk_ops.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Sean Anderson <seanga2@gmail.com>
---
 drivers/clk/clk_k210.c | 92 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index c534cc07e0..2f17152021 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -1238,52 +1238,6 @@ static int k210_clk_request(struct clk *clk)
 	return 0;
 }
=20
-static const struct clk_ops k210_clk_ops =3D {
-	.request =3D k210_clk_request,
-	.set_rate =3D k210_clk_set_rate,
-	.get_rate =3D k210_clk_get_rate,
-	.set_parent =3D k210_clk_set_parent,
-	.enable =3D k210_clk_enable,
-	.disable =3D k210_clk_disable,
-};
-
-static int k210_clk_probe(struct udevice *dev)
-{
-	int ret;
-	struct k210_clk_priv *priv =3D dev_get_priv(dev);
-
-	priv->base =3D dev_read_addr_ptr(dev_get_parent(dev));
-	if (!priv->base)
-		return -EINVAL;
-
-	ret =3D clk_get_by_index(dev, 0, &priv->in0);
-	if (ret)
-		return ret;
-
-	/*
-	 * Force setting defaults, even before relocation. This is so we can
-	 * set the clock rate for PLL1 before we relocate into aisram.
-	 */
-	if (!(gd->flags & GD_FLG_RELOC))
-		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
-
-	return 0;
-}
-
-static const struct udevice_id k210_clk_ids[] =3D {
-	{ .compatible =3D "canaan,k210-clk" },
-	{ },
-};
-
-U_BOOT_DRIVER(k210_clk) =3D {
-	.name =3D "k210_clk",
-	.id =3D UCLASS_CLK,
-	.of_match =3D k210_clk_ids,
-	.ops =3D &k210_clk_ops,
-	.probe =3D k210_clk_probe,
-	.priv_auto =3D sizeof(struct k210_clk_priv),
-};
-
 #if IS_ENABLED(CONFIG_CMD_CLK)
 static char show_enabled(struct k210_clk_priv *priv, int id)
 {
@@ -1342,3 +1296,49 @@ int soc_clk_dump(void)
 	return 0;
 }
 #endif
+
+static const struct clk_ops k210_clk_ops =3D {
+	.request =3D k210_clk_request,
+	.set_rate =3D k210_clk_set_rate,
+	.get_rate =3D k210_clk_get_rate,
+	.set_parent =3D k210_clk_set_parent,
+	.enable =3D k210_clk_enable,
+	.disable =3D k210_clk_disable,
+};
+
+static int k210_clk_probe(struct udevice *dev)
+{
+	int ret;
+	struct k210_clk_priv *priv =3D dev_get_priv(dev);
+
+	priv->base =3D dev_read_addr_ptr(dev_get_parent(dev));
+	if (!priv->base)
+		return -EINVAL;
+
+	ret =3D clk_get_by_index(dev, 0, &priv->in0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Force setting defaults, even before relocation. This is so we can
+	 * set the clock rate for PLL1 before we relocate into aisram.
+	 */
+	if (!(gd->flags & GD_FLG_RELOC))
+		clk_set_defaults(dev, CLK_DEFAULTS_POST_FORCE);
+
+	return 0;
+}
+
+static const struct udevice_id k210_clk_ids[] =3D {
+	{ .compatible =3D "canaan,k210-clk" },
+	{ },
+};
+
+U_BOOT_DRIVER(k210_clk) =3D {
+	.name =3D "k210_clk",
+	.id =3D UCLASS_CLK,
+	.of_match =3D k210_clk_ids,
+	.ops =3D &k210_clk_ops,
+	.probe =3D k210_clk_probe,
+	.priv_auto =3D sizeof(struct k210_clk_priv),
+};
--=20
2.34.1


