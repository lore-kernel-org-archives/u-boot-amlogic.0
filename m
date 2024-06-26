Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C8C30658
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 08:00:11 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.228.1719446275320206270
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Jun 2024 16:57:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=COSdsZQA;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 98CCA88495;
	Thu, 27 Jun 2024 01:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719446272;
	bh=j9+gNS0RvBKJupbfHAroI1F5otxQD2cptbmul1pdCUM=;
	h=From:To:Cc:Subject:Date:From;
	b=COSdsZQAdkVFtgDBSrlF5Gijkt24B+EwJUTAil4EgCGlSPK7tKKQNMBhS1LeEPzgB
	 FVedUPKHF/6hNGCHFTGVcDYW9CMWiWaxUTVPyNmXPoKI6XzBO9SfZcGLVDDQKGE5YL
	 cvveotTcSSuvFePkTqGuWWBwwsqKcopsyFCLUNz6eL8CIFsR31okrjZCoUKk/im+Zj
	 RZhSEdj/vWwbWFPkgdJ8Wow9SALESRiFy/AhGjqfA3VB3/vnE/4m1Sc+GIlCODkGGw
	 eY8mzKd06viDAMPdaT+WEr/Hk5zGCewjRHlgcbgcVrIaMq8oGUc3FUV0avjIhpgt/y
	 S7RNug7vFx9mA==
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
	Kostya Porotchkin <kostap@marvell.com>,
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
Subject: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
Date: Thu, 27 Jun 2024 01:55:41 +0200
Message-ID: <20240626235717.272219-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 08:00:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2332

In case a regulator DT node contains regulator-always-on or regulator-boo=
t-on
property, make sure the regulator gets correctly configured by U-Boot on =
start
up. Unconditionally probe such regulator drivers. This is a preparatory p=
atch
for introduction of .regulator_post_probe() which would trigger the regul=
ator
configuration.

Parsing of regulator-always-on and regulator-boot-on DT property has been
moved to regulator_post_bind() as the information is required early, the
rest of the DT parsing has been kept in regulator_pre_probe() to avoid
slowing down the boot process.

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
Cc: Kostya Porotchkin <kostap@marvell.com>
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
 drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
index 66fd531da04..ccc4ef33d83 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
 	const char *property =3D "regulator-name";
=20
 	uc_pdata =3D dev_get_uclass_plat(dev);
+	uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on");
+	uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
=20
 	/* Regulator's mandatory constraint */
 	uc_pdata->name =3D dev_read_string(dev, property);
@@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
 			return -EINVAL;
 	}
=20
-	if (regulator_name_is_unique(dev, uc_pdata->name))
-		return 0;
+	if (!regulator_name_is_unique(dev, uc_pdata->name)) {
+		debug("'%s' of dev: '%s', has nonunique value: '%s\n",
+		      property, dev->name, uc_pdata->name);
+		return -EINVAL;
+	}
=20
-	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
-	      property, dev->name, uc_pdata->name);
+	/*
+	 * In case the regulator has regulator-always-on or
+	 * regulator-boot-on DT property, trigger probe() to
+	 * configure its default state during startup.
+	 */
+	if (uc_pdata->always_on && uc_pdata->boot_on)
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
=20
-	return -EINVAL;
+	return 0;
 }
=20
 static int regulator_pre_probe(struct udevice *dev)
@@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
 						-ENODATA);
 	uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-max-microamp"=
,
 						-ENODATA);
-	uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on");
-	uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
 	uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regulator-ramp-dela=
y",
 						    0);
 	uc_pdata->force_off =3D dev_read_bool(dev, "regulator-force-boot-off");
--=20
2.43.0


