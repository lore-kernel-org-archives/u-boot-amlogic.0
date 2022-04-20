Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.11023.1650477314258164016
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 10:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650477312; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3HDYPTv2ZrEdESFqdHyi6VUpGcIr9xRdeG+VE+zgwhw=;
	b=qiEAdJ0keFyRj8kFF3H8McXxkL32jxsmsdvq/FUPqnPpfhsxj84NYP7R96XsiVl4YiWjM8
	oT5Wziihe5zXkznEUZJv2j5WsKLk6Iz64xwtgzdDK95YDK9Aeftsh7H849dVPA4cfqjX4e
	/Q+vrRoClIpdT95gsXAOf9qQgWHhMWJF9acVq64pWST4AiML1czEC8u7NMZ8Se50rqPgY3
	PHRoyz80TJmZRtXyRIbcURHxdOJfjMI27p1R+2elpfbt1R5io8Nz/33RIrz8SGZA4V7H62
	R8t7yDjDEMayus84jsfA0Sy4FLiIw/ws/JmnianxA/SlqLVYNv+VL7bhzE0swg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 3/5] adc: meson-saradc: add AXG variant
Date: Wed, 20 Apr 2022 20:55:00 +0300
Message-Id: <20220420175502.2449249-4-adeep@lexina.in>
In-Reply-To: <20220420175502.2449249-1-adeep@lexina.in>
References: <20220420175502.2449249-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add support for the SARADC variant found on the AXG SoCs family.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/adc/meson-saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 1a45a3a265..37023512f0 100644
--- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -737,6 +737,8 @@ static const struct udevice_id meson_saradc_ids[] =3D=
 {
 	  .data =3D (ulong)&gxl_saradc_data },
 	{ .compatible =3D "amlogic,meson-g12a-saradc",
 	  .data =3D (ulong)&gxl_saradc_data },
+	{ .compatible =3D "amlogic,meson-axg-saradc",
+	  .data =3D (ulong)&gxl_saradc_data },
 	{ }
 };
=20
--=20
2.30.2

