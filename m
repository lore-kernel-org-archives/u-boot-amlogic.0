Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DBCF64A6
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.6122.1727231043506921504
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Sep 2024 19:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=o/wqqaxr;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EAB7E88A29;
	Wed, 25 Sep 2024 04:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727231041;
	bh=fDgpgF11PRcuiwsFA2Om9iJn3tB//aCskc7TKnuiNbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/wqqaxrWN+jMhp+JnK036hWv/uM/Szq0GG0nOYbfKtmhLY45Zhs9jNLwIa7XyPfT
	 Cp/utkOEorBpDvISHv9LUMJdHfQi+ZFZmtuW8A14LXaRFOdMqHJ5YgHnpFX7ZnajLa
	 l5msNLHPkkbi45+PmGj/dod65EOqi0r0RS4wVLmBcW+9ZuEZX1/w1dRSvVApu8WCJp
	 jUEBnTA50q7XbmYFZzz/OAUee3CElK/4y/Ab9XliG7oJdMb0ej0B3rU1wBLW4z8GwI
	 aOCCy2IH6BDrqclSGE5sLoddzV/pKPngUZsTo4QyYU2n8rbHRpTQ3fRxZMbVlaqjKO
	 9b9OFzOS/B+1g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
	Ben Wolsieffer <benwolsieffer@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Kever Yang <kever.yang@rock-chips.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sam Day <me@samcday.com>,
	Simon Glass <sjg@chromium.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Tom Rini <trini@konsulko.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	u-boot-amlogic@groups.io,
	u-boot-qcom@groups.io,
	u-boot@dh-electronics.com,
	uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 2/5] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
Date: Wed, 25 Sep 2024 04:21:53 +0200
Message-ID: <20240925022314.714285-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925022314.714285-1-marex@denx.de>
References: <20240925022314.714285-1-marex@denx.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2406

Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
empty functions. Implement matching functionality in regulator_post_probe=
()
instead. The regulator_post_probe() is called for all regulators after th=
ey
probe, and regulators that have regulator-always-on or regulator-boot-on =
DT
properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
such regulators in regulator_post_bind().

Finally, fold regulator_unset() functionality into regulator_autoset().

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Chris Morgan <macromorgan@hotmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Rebase on current u-boot/next
---
 drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
 1 file changed, 19 insertions(+), 41 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
index e2f703702e3..14cf3159203 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -308,6 +308,11 @@ int regulator_autoset(struct udevice *dev)
 			return ret;
 	}
=20
+	if (uc_pdata->force_off) {
+		ret =3D regulator_set_enable(dev, false);
+		goto out;
+	}
+
 	if (!uc_pdata->always_on && !uc_pdata->boot_on) {
 		ret =3D -EMEDIUMTYPE;
 		goto out;
@@ -512,56 +517,28 @@ static int regulator_pre_probe(struct udevice *dev)
 	return 0;
 }
=20
-int regulators_enable_boot_on(bool verbose)
+static int regulator_post_probe(struct udevice *dev)
 {
-	struct udevice *dev;
-	struct uclass *uc;
 	int ret;
=20
-	ret =3D uclass_get(UCLASS_REGULATOR, &uc);
-	if (ret)
+	ret =3D regulator_autoset(dev);
+	if (ret && ret !=3D -EMEDIUMTYPE && ret !=3D -EALREADY && ret !=3D ENOS=
YS)
 		return ret;
-	for (uclass_first_device(UCLASS_REGULATOR, &dev);
-	     dev;
-	     uclass_next_device(&dev)) {
-		ret =3D regulator_autoset(dev);
-		if (ret =3D=3D -EMEDIUMTYPE || ret =3D=3D -EALREADY) {
-			ret =3D 0;
-			continue;
-		}
-		if (verbose)
-			regulator_show(dev, ret);
-		if (ret =3D=3D -ENOSYS)
-			ret =3D 0;
-	}
=20
-	return ret;
+	if (_DEBUG)
+		regulator_show(dev, ret);
+
+	return 0;
 }
=20
-int regulators_enable_boot_off(bool verbose)
+int regulators_enable_boot_on(bool verbose)
 {
-	struct udevice *dev;
-	struct uclass *uc;
-	int ret;
-
-	ret =3D uclass_get(UCLASS_REGULATOR, &uc);
-	if (ret)
-		return ret;
-	for (uclass_first_device(UCLASS_REGULATOR, &dev);
-	     dev;
-	     uclass_next_device(&dev)) {
-		ret =3D regulator_unset(dev);
-		if (ret =3D=3D -EMEDIUMTYPE) {
-			ret =3D 0;
-			continue;
-		}
-		if (verbose)
-			regulator_show(dev, ret);
-		if (ret =3D=3D -ENOSYS)
-			ret =3D 0;
-	}
+	return 0;
+}
=20
-	return ret;
+int regulators_enable_boot_off(bool verbose)
+{
+	return 0;
 }
=20
 UCLASS_DRIVER(regulator) =3D {
@@ -569,5 +546,6 @@ UCLASS_DRIVER(regulator) =3D {
 	.name		=3D "regulator",
 	.post_bind	=3D regulator_post_bind,
 	.pre_probe	=3D regulator_pre_probe,
+	.post_probe	=3D regulator_post_probe,
 	.per_device_plat_auto	=3D sizeof(struct dm_regulator_uclass_plat),
 };
--=20
2.45.2


