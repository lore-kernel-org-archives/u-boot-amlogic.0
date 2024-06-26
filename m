Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17BC2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 08:00:11 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.199.1719446276628469063
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Jun 2024 16:57:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=IHa6JF28;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0788B884C6;
	Thu, 27 Jun 2024 01:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719446275;
	bh=3gCdnmaEq/A5rNzbrOeZjnrXzj+5+0Z0K1hcJkDfqvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHa6JF28Q8n7jzruuP1ByJYYnhooVitLDKmfn7Fg40CxGrIJuXC3TN+o4yISyMARo
	 DmLcDbitZ9ChH/rpMnkzWghQqYNhr3/m4P58edKRDUMz4NGuXAYd3mz/8SULUXk0L4
	 WmU3tmqmfSd3uMlflxcQVPozVnmMObH9luRwVHCbWBV+73KqF4gZ6XTY9Nzm1S4LEy
	 XyKV+mQk1Eu9dixBzP36qYwQg5OoOf8lIbZarTuPeKEgJnXZSe0d1G6tmxLoMu+Hpg
	 0rESjDFiNZoY+Vo/V9FvpSlVRQl9ry9W1c+/HB+dgJGopNfcwmNdAjPx4BYyA5V6pl
	 WJEI1LsHKowFw==
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
Subject: [PATCH 3/4] power: regulator: Drop regulator_unset()
Date: Thu, 27 Jun 2024 01:55:43 +0200
Message-ID: <20240626235717.272219-3-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626235717.272219-1-marex@denx.de>
References: <20240626235717.272219-1-marex@denx.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 08:00:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2334

This function is never called, drop it.

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
 drivers/power/regulator/regulator-uclass.c | 11 -----------
 include/power/regulator.h                  | 14 +-------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
index d52f273042f..bcbcec1567e 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -339,17 +339,6 @@ out:
 	return ret;
 }
=20
-int regulator_unset(struct udevice *dev)
-{
-	struct dm_regulator_uclass_plat *uc_pdata;
-
-	uc_pdata =3D dev_get_uclass_plat(dev);
-	if (uc_pdata && uc_pdata->force_off)
-		return regulator_set_enable(dev, false);
-
-	return -EMEDIUMTYPE;
-}
-
 static void regulator_show(struct udevice *dev, int ret)
 {
 	struct dm_regulator_uclass_plat *uc_pdata;
diff --git a/include/power/regulator.h b/include/power/regulator.h
index bb07a814c79..5363483d02a 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -430,7 +430,7 @@ int regulators_enable_boot_on(bool verbose);
  *
  * This disables all regulators which are marked to be off at boot time.
  *
- * This effectively calls regulator_unset() for every regulator.
+ * This effectively does nothing.
  */
 int regulators_enable_boot_off(bool verbose);
=20
@@ -453,18 +453,6 @@ int regulators_enable_boot_off(bool verbose);
  */
 int regulator_autoset(struct udevice *dev);
=20
-/**
- * regulator_unset: turn off a regulator
- *
- * The setup depends on constraints found in device's uclass's platform =
data
- * (struct dm_regulator_uclass_platdata):
- *
- * - Disable - will set - if  'force_off' is set to true,
- *
- * The function returns on the first-encountered error.
- */
-int regulator_unset(struct udevice *dev);
-
 /**
  * regulator_autoset_by_name: setup the regulator given by its uclass's
  * platform data name field. The setup depends on constraints found in d=
evice's
--=20
2.43.0


