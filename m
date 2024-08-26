Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C98C5B54A
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:35 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.52914.1724679011680962929
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Aug 2024 06:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=FDbqxZKS;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2BBF5100006;
	Mon, 26 Aug 2024 16:30:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2BBF5100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724679009;
	bh=Nlg7+ukuJA8FArl2a91SDfgeGmzjGL6czsU1Wa7U53w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FDbqxZKSW6UpsGEv5VUSkmUqoqP1qFT8V69c+xa8/05jJySR9ez0JEFzK/VY0Cqtp
	 S8NlWEYWGYGtkvhna0Q+/hIkOlNdN4uq5ENJUEsBYz2vH6Mv7eZ2Yj2Cwcnt6bdTBb
	 uQZGugaLaUYK9cef8ArvsBKzl2tjiOFkDnoZ6eZfWUgW7jEVEBN25c/NreHzdnQVs5
	 hISjHv482UyM4SKD5+pqJKQUaOlZDKpltdI2sJiBJGxjIW1vlAADLBilAzytLLBoPw
	 6w22btpvQmcGMK8DfXx4UJMSAUNdUveuTp0f1eG3yE9RszwA9r2B9vHnk9YZHc/NKE
	 +dKsSBZwhir2A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 26 Aug 2024 16:30:09 +0300 (MSK)
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v3 2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
Date: Mon, 26 Aug 2024 16:17:09 +0300
Message-ID: <20240826131710.29746-3-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240826131710.29746-1-avkrasnov@salutedevices.com>
References: <20240826131710.29746-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [172.28.225.232]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187326 [Aug 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/26 08:14:00 #26435425
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2374

Move call 'meson_nfc_cmd_seed()' and check for 'NAND_NEED_SCRAMBLING'
to 'meson_nfc_cmd_access()', thus removing code duplication.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 Changelog:                                                            =20
 v2 -> v3:                                                             =20
  * Declare 'scrambler' as 'unsigned int'.

 drivers/mtd/nand/raw/meson_nand.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson=
_nand.c
index 12499a7947..2d77ee51ce 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -228,14 +228,19 @@ static void meson_nfc_cmd_seed(const struct meson_nfc=
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
+	unsigned int scrambler;
+
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
+	else
+		scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
=20
 	pagesize =3D nand->ecc.size;
=20
@@ -251,6 +256,9 @@ static void meson_nfc_cmd_access(struct nand_chip *nand=
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
@@ -565,14 +573,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *=
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
@@ -643,14 +644,7 @@ static int meson_nfc_read_page_sub(struct nand_chip *n=
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


