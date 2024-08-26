Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D9C63685
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:35 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.52224.1724679010973177188
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Aug 2024 06:30:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=LkQ1t7jA;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: avkrasnov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5506B100009;
	Mon, 26 Aug 2024 16:30:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5506B100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724679009;
	bh=GDjaIwbxT+VKOvRr+kMFO67gQV7wATLCRPWCDBLJlas=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LkQ1t7jAAHXwIj7eW1f5/ArZKyVT02Wnd8M/9w6cwrDs5zAa5u1a+loozJgCkm7mB
	 XkNCXySKGHzWDYVsukf2OBjAgQ/RCLfSL0SFHIl3cHdS7SOj98zuQxkOooKMI1UPQ6
	 ayOV0++oaEcctJeK0Em78HJ9OOWfT1MBredUiWXFhMR4mUY2HpRBTrQYECSBPt1Au9
	 kjU6SVosDBP3GvmrkLN4xV+WX6kLja2VxTi0RRmt/JpZvS6BpoF9Ic76Ehd3FuCKh+
	 c7M3UzuFKfDwf1h/65Q8d+WiHFiRnTVWLUKP7oevUt6u9wHOnnHCrijxoVM9jQkEOe
	 GOHuMZ6lka1lQ==
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
Subject: [PATCH v3 3/3] mtd: rawnand: meson: read/write access for boot ROM pages
Date: Mon, 26 Aug 2024 16:17:10 +0300
Message-ID: <20240826131710.29746-4-avkrasnov@salutedevices.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2380

Boot ROM on Meson needs some pages to be read/written in a special mode:
384 byte ECC mode (so called "short" by Amlogic) and with scrambling
enabled. Such pages are located on the chip in the following way (for
example):

[ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
  ^           ^           ^           ^

pX is page number "X". "^" means "special" page used by boot ROM - e.g.
every 2nd page in the range of [0, 7]. Step (2 here) and last page in
range is read from the device tree.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 56 +++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson=
_nand.c
index 2d77ee51ce..28c851f103 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -39,6 +39,7 @@
 #define NFC_CMD_RB			BIT(20)
 #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
 #define NFC_CMD_SCRAMBLER_DISABLE	0
+#define NFC_CMD_SHORTMODE_ENABLE	1
 #define NFC_CMD_SHORTMODE_DISABLE	0
 #define NFC_CMD_RB_INT			BIT(14)
 #define NFC_CMD_RB_INT_NO_PIN		((0xb << 10) | BIT(18) | BIT(16))
@@ -77,6 +78,8 @@
=20
 #define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
=20
+#define NFC_SHORT_MODE_ECC_SZ	384
+
 #define ECC_CHECK_RETURN_FF	-1
=20
 #define NAND_CE0		(0xe << 10)
@@ -140,6 +143,8 @@
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
+	u32 boot_pages;
+	u32 boot_page_step;
=20
 	u32 bch_mode;
 	u8 *data_buf;
@@ -228,33 +233,46 @@ static void meson_nfc_cmd_seed(const struct meson_nfc=
 *nfc, u32 seed)
 	       nfc->reg_base + NFC_REG_CMD);
 }
=20
+static int meson_nfc_is_boot_page(struct nand_chip *nand, int page)
+{
+	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
+
+	return (nand->options & NAND_IS_BOOT_MEDIUM) &&
+	       !(page % meson_chip->boot_page_step) &&
+	       (page < meson_chip->boot_pages);
+}
+
 static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool di=
r, int page)
 {
+	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
 	struct mtd_info *mtd =3D nand_to_mtd(nand);
 	const struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_nand(mtd)=
);
-	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
-	u32 bch =3D meson_chip->bch_mode, cmd;
 	int len =3D mtd->writesize, pagesize, pages;
 	unsigned int scrambler;
+	u32 cmd;
=20
 	if (nand->options & NAND_NEED_SCRAMBLING)
 		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
 	else
 		scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;
=20
-	pagesize =3D nand->ecc.size;
-
 	if (raw) {
 		len =3D mtd->writesize + mtd->oobsize;
 		cmd =3D len | scrambler | DMA_DIR(dir);
-		writel(cmd, nfc->reg_base + NFC_REG_CMD);
-		return;
-	}
+	} else if (meson_nfc_is_boot_page(nand, page)) {
+		pagesize =3D NFC_SHORT_MODE_ECC_SZ >> 3;
+		pages =3D mtd->writesize / 512;
=20
-	pages =3D len / nand->ecc.size;
+		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
+		cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, NFC_ECC_BCH8_1K,
+			       NFC_CMD_SHORTMODE_ENABLE, pagesize, pages);
+	} else {
+		pagesize =3D nand->ecc.size >> 3;
+		pages =3D len / nand->ecc.size;
=20
-	cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
-		       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
+		cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, meson_chip->bch_mode,
+			       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
+	}
=20
 	if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
 		meson_nfc_cmd_seed(nfc, page);
@@ -1131,6 +1149,24 @@ static int meson_nfc_nand_chip_init(struct udevice *=
dev, struct meson_nfc *nfc,
 		goto err_chip_buf_free;
 	}
=20
+	if (nand->options & NAND_IS_BOOT_MEDIUM) {
+		ret =3D ofnode_read_u32(node, "amlogic,boot-pages",
+				      &meson_chip->boot_pages);
+		if (ret) {
+			dev_err(dev, "could not retrieve 'amlogic,boot-pages' property: %d",
+				ret);
+			goto err_chip_buf_free;
+		}
+
+		ret =3D ofnode_read_u32(node, "amlogic,boot-page-step",
+				      &meson_chip->boot_page_step);
+		if (ret) {
+			dev_err(dev, "could not retrieve 'amlogic,boot-page-step' property: %d"=
,
+				ret);
+			goto err_chip_buf_free;
+		}
+	}
+
 	ret =3D nand_register(0, mtd);
 	if (ret) {
 		dev_err(dev, "'nand_register()' failed: %d\n", ret);
--=20
2.30.1


