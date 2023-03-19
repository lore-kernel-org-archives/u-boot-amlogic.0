Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by mx.groups.io with SMTP id smtpd.web10.21360.1679245450877753908
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaUTZhBqUzHJsWL4TYyJBN3VMkKy20W7m+jrZi3g6A8=;
	b=ZEmzvNj73Wv0nwetpsboyv8gTGnGDuBXtFP7VuQVZLqMcJckI/LNBk+GOwyKKpIk3NjbZA
	5ippVny6/OrivybVqwBeN19/dLzuhcDSvsA9eUUfKfFHgdVDAXFRSDEozw8OmIJJZ4fs6Y
	RVeALpnIJAxgzjpMn2k45saBJ+OUb9dB1It9Pfy2677vuCZ2vhpQt21EpDGfW6JpBRvoTF
	mDpsbTN+VywTX+vvc3cZoORpLKm/FNTG1i7Sz1y2HFBlcI42fK6mn7nfK9eCEkK5tVjdEs
	G0auqo6bam8jjYEj93trdt2LvFKdCPCGnMJ3PnZrZTcrpLyY6yRJLLDxE0gF/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QaUTZhBqUzHJsWL4TYyJBN3VMkKy20W7m+jrZi3g6A8=;
	b=gFSH/BvAvevVw0xx2dxpbEftANda4ufILErhnUxLIlBwDerYLiJ7UZKCBiWqU3Vg0q8+Mf
	KouNRwPConhi5SNX74OgP8PTTyqiE+r5XRWVlA8CqPaLSmzY0c/d8N3XdjjwuPp5d8vY1f
	+QiHznZXh0+vltmgXP6x4sf2bNxP484GbpqzjIKlLbuo/iGAMmQEWj5z7UzO7+btUpfhax
	Ckb9C71ldyNYjxIVdQmHVlXaUoRLeNhql1H5KR+RjdYvle6+0BndZM+ZSwbPHaQRsqWJLg
	nv4pgzAD3QqcWL3PN4S0Z86vTRW9bik6mPMV4X+pdylDmZLK3w1tNNGCDx3oxg==
Subject: [PATCH 02/41] net: phy: ca_phy: Staticize PHY driver entries
Date: Sun, 19 Mar 2023 18:02:38 +0100
Message-Id: <20230319170317.27711-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
References: <20230319170317.27711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ariel D'Alessandro <ariel.dalessandro@collabora.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, Haolin Li <li.haolin@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Joe Hershberger <joe.hershberger@ni.com>, Joel Stanley <joel@jms.id.au>, Josua Mayer <josua@solid-run.com>, Michael Trimarchi <michael@amarulasolutions.com>, Michal Simek <michal.simek@amd.com>, Nate Drude <nate.d@variscite.com>, Neil Armstrong <neil.armstrong@linaro.org>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, Ramon Fried <rfried.dev@gmail.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>, Stefan Roese <sr@denx.de>, T Karthik Reddy <t.karthik.reddy@xilinx.com>, Tim Harvey <tharvey@gateworks.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

These struct phy_driver ... instances are local to this source code
file, staticize them. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: "C=C3=A9dric Le Goater" <clg@kaod.org>
Cc: "Marek Beh=C3=BAn" <kabel@kernel.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Haolin Li <li.haolin@qq.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Josua Mayer <josua@solid-run.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nate Drude <nate.d@variscite.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Stefan Roese <sr@denx.de>
Cc: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: u-boot-amlogic@groups.io
---
 drivers/net/phy/ca_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/ca_phy.c b/drivers/net/phy/ca_phy.c
index 16851a6820f..9180a41111c 100644
--- a/drivers/net/phy/ca_phy.c
+++ b/drivers/net/phy/ca_phy.c
@@ -104,7 +104,7 @@ static int rtl8211_probe(struct phy_device *phydev)
 }
=20
 /* Support for RTL8211 External PHY */
-struct phy_driver rtl8211_external_driver =3D {
+static struct phy_driver rtl8211_external_driver =3D {
 	.name =3D "Cortina RTL8211 External",
 	.uid =3D PHY_ID_RTL8211_EXT,
 	.mask =3D PHY_ID_MASK,
@@ -115,7 +115,7 @@ struct phy_driver rtl8211_external_driver =3D {
 };
=20
 /* Support for RTL8211 Internal PHY */
-struct phy_driver rtl8211_internal_driver =3D {
+static struct phy_driver rtl8211_internal_driver =3D {
 	.name =3D "Cortina RTL8211 Inrernal",
 	.uid =3D PHY_ID_RTL8211_INT,
 	.mask =3D PHY_ID_MASK,
--=20
2.39.2

