Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.15568.1650788532235160335
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788529; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=f/xrZ9j5v4f1Ae1i0PgTc+2kGsjiNvYtN+GyPxvdUfE=;
	b=C74TepAVYZTCC5R4yV8xXvoSvRTa7HOeXcWYxoRyT3Erf2A6mqBbZtNy50q12Lofcf66iw
	aNfXTtz/YvAhDY79jD8pazDKfGJrZTt1xe9F0U2Epph+W55VBRGTVPdq58UWToWyEBfIrZ
	YGBL3/F3FLiRrLZTpc20f+atsVVZWPevcwqKj+Cry4iJePArGIJlHFJpWnb5KzGN7sVfW6
	MU3jmdE5yQFQN77Coksny6/g15suRDbuzUXXJFEhy5GsSNJQkHh789EYN+AkFxWWfjw6iu
	1OO6hv/P798jhr549dIvCPP5p6m+RaT2KdHDwSZXED6CkmvG/Eo0OCA2DdI2+g==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 4/6] adc: meson-saradc: add AXG variant
Date: Sun, 24 Apr 2022 11:21:57 +0300
Message-Id: <20220424082159.757622-5-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Add support for the SARADC variant found on the AXG SoCs family.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
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

