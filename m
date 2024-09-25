Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7CCF64A3
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.6147.1727231054539894064
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Sep 2024 19:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=YJe+pBwW;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 007A788AA7;
	Wed, 25 Sep 2024 04:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727231053;
	bh=ns+ea/3HJpzNdldFfu0LKAozT1na/ixD5afT6mspUuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJe+pBwWNePfejieZbpdgcxwvKRyuSCTvr0rDLqfe+ha3f51+rhlqEHwz4KjO4gF6
	 adYdzGINNtvzmwkbezkuxv8k0qA37tfyypZ7e3LtLLt9gXPZNBm/XeEYJGHSkqU3sj
	 XxZEfiNLcqv7YttRjV55zwGqZOY9SJPMcP3dg2EqsFitXBl9hFjajCNoL/1WiDRfAL
	 Ho0+qUuPV4Jt34ARgpqu09HAX/tMxXzMM+SCUJB0flNYcD45kRRG3XWEvxNETXGM+2
	 FJG6RuP8QHfzshAQ2qvgnfFe+j/RLFfPHPyP5s54IOtE1aomSbVKYlzUXlUboS6VF3
	 2B/XEbXGw8ulQ==
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
Subject: [PATCH v2 3/5] power: regulator: Exit from regulator_set_suspend_value on poorly described regulators
Date: Wed, 25 Sep 2024 04:21:54 +0200
Message-ID: <20240925022314.714285-3-marex@denx.de>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2409

In case the DT regulator node does not contain 'regulator-max-microvolt'
property and does not contain 'regulator-state-mem' subnode (like the
test.dts regul1_scmi: reg@1 {} regulator node), then regulator_pre_probe(=
)
will parse this regulator node and set uc_pdata->suspend_on =3D true and
uc_pdata->suspend_uV =3D uc_pdata->max_uV, where uc_pdata->max_uV is set
to -ENODATA because "regulator-max-microvolt" is missing, and therefore
uc_pdata->suspend_uV is also -ENODATA. In case regulator_autoset() is
used afterward, it will attempt to call regulator_set_suspend_value()
with uV =3D uc_pdata->suspend_uV =3D -ENODATA and fail with -EINVAL. Chec=
k
for this case in regulator_set_suspend_value() and immediately return 0,
because there is no way to set meaningful suspend voltage, so do nothing
and retain the existing settings of the regulator.

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
V2: New patch
---
 drivers/power/regulator/regulator-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
index 14cf3159203..3c05fdf1966 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -85,6 +85,10 @@ int regulator_set_suspend_value(struct udevice *dev, i=
nt uV)
 	const struct dm_regulator_ops *ops =3D dev_get_driver_ops(dev);
 	struct dm_regulator_uclass_plat *uc_pdata;
=20
+	/* Regulator did not set limits, assume already configured. */
+	if (uV =3D=3D -ENODATA)
+		return 0;
+
 	uc_pdata =3D dev_get_uclass_plat(dev);
 	if (uc_pdata->min_uV !=3D -ENODATA && uV < uc_pdata->min_uV)
 		return -EINVAL;
--=20
2.45.2


