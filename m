Return-Path: <ivprusov@salutedevices.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0FCDB487
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 16:57:20 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.224821.1697561832559102647
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Oct 2023 09:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@sberdevices.ru header.s=mail header.b=HTsJTB7M;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ivprusov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A87FD100009;
	Tue, 17 Oct 2023 19:57:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A87FD100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1697561829;
	bh=7p/bN1DzPCIL/rTdFYGycVLh75cot7xaVTxaPs0zNtc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HTsJTB7MUYwGtGn2yH+BhnC4WQWMzjIA5Vsya1ipSL8V13+GA5PmU5b3TIu+R/uV4
	 BMSOCBUriP6WajvQpLocRNKmfHt2jVuoR5IvgwHHbfj+A2cIicVeKxL0VLJYZeTD87
	 7Oq890nkuPbzTk8lCFCAq5uFEMqtDdjtfZrayr9tftCrJt9o+iS5rLpDqrnlLrE6eJ
	 ObEj3Lm3V/FxizQiJCY3TkPVnCBu4SmtsJuc3gw8TyOiRihktQUQwwrJLrglsf1AvB
	 esrp4ca0eikm6dWndkFS88wDn9ftuEghWHGGjR+bz3wsqhwQ2ZZp8JPtOOAeqaS6HJ
	 WJYjEQJjJFa5g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 17 Oct 2023 19:57:09 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 19:57:09 +0300
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
Subject: [PATCH v4 4/8] clk: amlogic: Move driver and ops structs
Date: Tue, 17 Oct 2023 19:56:45 +0300
Message-ID: <20231017165649.1492-5-ivprusov@sberdevices.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 540 540 2509a3fe0f7fdc802e7154a32be7c2dd394ab987, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1764

Move driver and ops structs to avoid forward declaration after switching
to dump in clk_ops.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 drivers/clk/meson/a1.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 1075ba7333..e3fa9db7d0 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -601,14 +601,6 @@ static int meson_clk_set_parent(struct clk *clk, str=
uct clk *parent_clk)
 	return meson_mux_set_parent_by_id(clk, parent_clk->id);
 }
=20
-static struct clk_ops meson_clk_ops =3D {
-	.disable	=3D meson_clk_disable,
-	.enable		=3D meson_clk_enable,
-	.get_rate	=3D meson_clk_get_rate,
-	.set_rate	=3D meson_clk_set_rate,
-	.set_parent	=3D meson_clk_set_parent,
-};
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv =3D dev_get_priv(dev);
@@ -638,15 +630,6 @@ static const struct udevice_id meson_clk_ids[] =3D {
 	{ }
 };
=20
-U_BOOT_DRIVER(meson_clk) =3D {
-	.name		=3D "meson-clk-a1",
-	.id		=3D UCLASS_CLK,
-	.of_match	=3D meson_clk_ids,
-	.priv_auto	=3D sizeof(struct meson_clk),
-	.ops		=3D &meson_clk_ops,
-	.probe		=3D meson_clk_probe,
-};
-
 static const char *meson_clk_get_name(struct clk *clk, int id)
 {
 	const struct meson_clk_info *info;
@@ -727,3 +710,20 @@ int soc_clk_dump(void)
=20
 	return 0;
 }
+
+static struct clk_ops meson_clk_ops =3D {
+	.disable	=3D meson_clk_disable,
+	.enable		=3D meson_clk_enable,
+	.get_rate	=3D meson_clk_get_rate,
+	.set_rate	=3D meson_clk_set_rate,
+	.set_parent	=3D meson_clk_set_parent,
+};
+
+U_BOOT_DRIVER(meson_clk) =3D {
+	.name		=3D "meson-clk-a1",
+	.id		=3D UCLASS_CLK,
+	.of_match	=3D meson_clk_ids,
+	.priv_auto	=3D sizeof(struct meson_clk),
+	.ops		=3D &meson_clk_ops,
+	.probe		=3D meson_clk_probe,
+};
--=20
2.34.1


