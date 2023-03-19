Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.web11.21056.1679245454420137117
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfN+L8S424MBjOAEOoUJwQ+EkeFaIsDYW1FIdTpMY5I=;
	b=JGruEuTNE9HpFrUv+abanRrQtn/EG5VaNGNRYRNOvwyJJk2L0atT1pRlpdwp9Q7LRYgt8h
	BReVpeXfQ9d5SCmRkyEZSCeclpqq0w01nqCfD56WffJvHgARg4GCvXIe/xBkCh7Hh+Upoi
	8sYE+AtQQLFjl8GUH/m10dc1XzptVXw3+j+LXeEm0jUkkH/zOhIKtOZ8Y+caL1gTUtK554
	E8HK4EW9gpuYiAhMKginJaxuzjie92u8tSeUyZwCUW7oZlzCRyEIkJESC2TqatBULCT2EJ
	zR4iITp+IGjac6tfx6xWpmEnC0D0mxeR5q/uVfiRhYSEY2xKP2Ag+JUCKzhCdg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KfN+L8S424MBjOAEOoUJwQ+EkeFaIsDYW1FIdTpMY5I=;
	b=eD/Thf8HGRqvFvzYbcFL9DH2sXdFtv4tz5L1InHckMuTdRILq3l9qUxmwaF2/L6wSEjXFp
	B4YOdxWoxWN7srJ3/mEACwNrLluFMDGOwPN0VzJUIxuNZbwIKw8fBFci/Vz5CDB5jpe7Cq
	wTdUVb8ApxtV7RVMPUFyuteufSof2iq1xyuwkp2/dWIt7k9EQCrKZwytFrfzDCU4L6FU/M
	2bRvzIotGVGIOKdW9GZO1i78Gud/ppyU83883aVmAlUffkxY5KGlj2eUngkwG5XClV/8fz
	Gmbkx8uwinjqtq0BjwZ7AfLCtuy65dEhSVAT3NqtOnLaBJh7H4HzOCS4s1nLeg==
Subject: [PATCH 03/41] net: phy: cortina: Staticize PHY driver entries
Date: Sun, 19 Mar 2023 18:02:39 +0100
Message-Id: <20230319170317.27711-3-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/cortina.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index 778d93e609c..df5a73d6112 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -382,7 +382,7 @@ int cs4223_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-struct phy_driver cs4340_driver =3D {
+static struct phy_driver cs4340_driver =3D {
 	.name =3D "Cortina CS4315/CS4340",
 	.uid =3D PHY_UID_CS4340,
 	.mask =3D 0xfffffff0,
@@ -396,7 +396,7 @@ struct phy_driver cs4340_driver =3D {
 	.shutdown =3D &gen10g_shutdown,
 };
=20
-struct phy_driver cs4223_driver =3D {
+static struct phy_driver cs4223_driver =3D {
 	.name =3D "Cortina CS4223",
 	.uid =3D PHY_UID_CS4223,
 	.mask =3D 0x0ffff00f,
--=20
2.39.2

