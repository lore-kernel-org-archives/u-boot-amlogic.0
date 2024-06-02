Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516A2C27C54
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 14:49:43 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.67420.1717359623987469314
 for <u-boot-amlogic@groups.io>;
 Sun, 02 Jun 2024 13:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup mail._domainkey.salutedevices.com on 100.100.100.100:53: no such host" header.i=@salutedevices.com header.s=mail header.b=so9Vw2Tt;
 spf=none, err=permanent DNS error (domain: salutedevices.com, ip: 45.89.224.132, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8E72A120005;
	Sun,  2 Jun 2024 23:20:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8E72A120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1717359619;
	bh=4ugCExJmHF1+tHCj3oOXll10egW6Hh3ePAOXKIoZvRc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=so9Vw2Tt/cF7L6P/U7fShk0d3xyFqINnHbXhBPX5On16VtFrX27dzu7xZzLdN6V6c
	 Ytt5ApP0Keq9T8vtn8ZbLzR/NBlLbbbdEBwsNOhMNdVVfDtQBC5WAf1CWxbqvkWDSn
	 uIb1FppQanBePV2YSrcXXdmWzw24kP+8ZhCxK/Xj+46rmseP5/hp607q+wCPZWJKoT
	 6+V83Rz5JZ36xtcTPSjDDVCbCxOnB9xjnox9gtcUZ0CAFYGUUgXca03fIY3mHyo0bx
	 eU9PBO1tKZ1DZa3MN58kBTORpg4/Ey+yF735hiEHApAJ5z3eRpet4grrkPinCSZPbH
	 TgrhBbrhSv81A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  2 Jun 2024 23:20:19 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 2 Jun 2024 23:20:19 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
	<michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<kernel@sberdevices.ru>, <oxffffaa@gmail.com>, <avkrasnov@salutedevices.com>
Subject: [PATCH v1 2/3] mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
Date: Sun, 2 Jun 2024 23:08:35 +0300
Message-ID: <20240602200836.3949773-3-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185677 [Jun 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/02 16:26:00 #25411153
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 06 Jun 2024 14:49:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2288

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
2.35.0


