Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF890C5B547
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.47183.1724653034566853471
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=Uf3WXPEz;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F38F8100005;
	Mon, 26 Aug 2024 09:17:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F38F8100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724653031;
	bh=dn3mYdQz9MZLgQ/01yQmK1zVAN4QGAKbGX5MMJw5v9I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Uf3WXPEzR3scMW5f2W9ZbYQ04OXS+kyIHYPGEscaFHG/yQfIG4J0WXO4ftegDKKFu
	 Y/3UcJhhn8i4q1poDaQ/znrtDlaUpyrB4q7k+nwSP/HwLbceJm3vyGNI5aXtdF85Wk
	 0T6ZNCs0Suavhlz8PlSuy3tBVOWrLNqKBjFANj/p1qpTSWNvZOFkmBh2w8NwBuiD2+
	 kMir56kFdRr1TYJJzj7bClY52/DcUl1bXCrSUoO31Dy3lM3YEacKcacsJfhpI7o/zI
	 +AM4u5/T9ZWcve5ubRtAiRo9o7Onf4bsJ6kpVZ5yUZLksiP7czkKFQtxKjoUIoBdrb
	 ht7/Z/DMUY4hg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 09:17:11 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v2 2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
Date: Mon, 26 Aug 2024 09:04:10 +0300
Message-ID: <20240826060411.3532105-3-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.161.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187287 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/26 02:45:00 #26434133
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2369

Move call 'meson_nfc_cmd_seed()' and check for 'NAND_NEED_SCRAMBLING'
to 'meson_nfc_cmd_access()', thus removing code duplication.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson=
_nand.c
index 5d411c4594..19f005202b 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -229,14 +229,19 @@ static void meson_nfc_cmd_seed(const struct meson_nfc=
 *nfc, u32 seed)
 	       nfc->reg_base + NFC_REG_CMD);
 }
=20
-static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool di=
r,
-				 int scrambler)
+static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool di=
r, int page)
 {
 	struct mtd_info *mtd =3D nand_to_mtd(nand);
 	const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_nand(mtd)=
);
 	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
 	u32 bch =3D meson_chip->bch_mode, cmd;
 	int len =3D mtd->writesize, pagesize, pages;
+	int scrambler;
+
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
+	else
+		scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
=20
 	pagesize =3D nand->ecc.size;
=20
@@ -252,6 +257,9 @@ static void meson_nfc_cmd_access(struct nand_chip *nand=
, bool raw, bool dir,
 	cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
 		       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
=20
+	if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
+		meson_nfc_cmd_seed(nfc, page);
+
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 }
=20
@@ -566,14 +574,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *=
nand,
 		return ret;
 	}
=20
-	if (nand->options & NAND_NEED_SCRAMBLING) {
-		meson_nfc_cmd_seed(nfc, page);
-		meson_nfc_cmd_access(nand, raw, DIRWRITE,
-				     NFC_CMD_SCRAMBLER_ENABLE);
-	} else {
-		meson_nfc_cmd_access(nand, raw, DIRWRITE,
-				     NFC_CMD_SCRAMBLER_DISABLE);
-	}
+	meson_nfc_cmd_access(nand, raw, DIRWRITE, page);
=20
 	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
@@ -644,14 +645,7 @@ static int meson_nfc_read_page_sub(struct nand_chip *n=
and,
 	if (ret)
 		return ret;
=20
-	if (nand->options & NAND_NEED_SCRAMBLING) {
-		meson_nfc_cmd_seed(nfc, page);
-		meson_nfc_cmd_access(nand, raw, DIRREAD,
-				     NFC_CMD_SCRAMBLER_ENABLE);
-	} else {
-		meson_nfc_cmd_access(nand, raw, DIRREAD,
-				     NFC_CMD_SCRAMBLER_DISABLE);
-	}
+	meson_nfc_cmd_access(nand, raw, DIRREAD, page);
=20
 	meson_nfc_wait_dma_finish(nfc);
 	meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
--=20
2.30.1


