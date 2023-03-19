Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.web11.21057.1679245457157829070
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Mar 2023 10:04:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dutRxJrY3pIRDEn8Vsej7etzs9Nglz5FeMUvHdzq3w=;
	b=s4MRI5hr8TUzK+JWJskFn6U/PhrdHRfKHUB1qE5Ev0zg5VMLsKTrCQgWIaVlEsI/zTOf8n
	GL0gT3Fs91qEPs9hTHCGRbQpJMCf+uFGn64Ej490YFM4gqzNsEqNynW0Q4ENPPNkvoISsd
	PtvAJikxObfFH03RMhxY0tsJhBoVHwW8ojZJKvpMv+clS8puv0EcEq0oP7148J88mdY091
	XZJTUsYU0vPcSq70nVPROyxS8gSsjBL0qZa68T2RLIdPlgLxk++Gvle0OTDc881ic3GcYS
	MB+Yf4E5jHWrGl3xvT9zQvQsav+US841FQiYvfqTSQ2cN+T9oU/5YgZQc+hA+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1679245450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dutRxJrY3pIRDEn8Vsej7etzs9Nglz5FeMUvHdzq3w=;
	b=RkjlitGhSMEIAQDXmJ0t5FKbbyI2O9MUJJrBI2WNQSUhMaAnBZWaA3/igXokED3vExci2U
	R9r4RCwmhVKGVzuzsUCa0rqDFLMDzHR9k1splA/JYrcG8YvkQfwZrTIDmCjSu3mjbosu/B
	vaeQpOOuB8xVQQsqJI9ZrMVLkJAPIlj+TQfdtRDMQjXkpiuPMit3h5dUr1m2OJDq9vzRGR
	v32tpL1dhXugPTnkaGIvnKwAttaSuMCsk9O7pZJ0yqa1NGq4xCkFP3wVM3SImVTyfBapew
	ocuG9nTvjKRHHwG45ye9aenHsTjOXryksD01z3IxLjnK0k4oElN4DhlwLihEEQ==
Subject: [PATCH 04/41] net: phy: teranetics: Staticize PHY driver entries
Date: Sun, 19 Mar 2023 18:02:40 +0100
Message-Id: <20230319170317.27711-4-marek.vasut+renesas@mailbox.org>
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
 drivers/net/phy/teranetics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index 60049c2074f..c402bad88c6 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -90,7 +90,7 @@ int tn2020_startup(struct phy_device *phydev)
 	return 0;
 }
=20
-struct phy_driver tn2020_driver =3D {
+static struct phy_driver tn2020_driver =3D {
 	.name =3D "Teranetics TN2020",
 	.uid =3D PHY_UID_TN2020,
 	.mask =3D 0xfffffff0,
--=20
2.39.2

