Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web11.5117.1650605367241406728
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605364; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3HDYPTv2ZrEdESFqdHyi6VUpGcIr9xRdeG+VE+zgwhw=;
	b=bvSU2Qxx+OrVGcr0PJgfVCWSdqFJ4cRaLliPhlDMCG8rQPD7XJtMsc1kN85flpMkMFc979
	y/0nEqF24cmzWHuBmFZdXol3FCey08m3joDpeaVA1/GkEFdj0I+5pka9Op8jQxJBUa3epF
	lJj1u4Qf3mIPnZ438OGbc62bCFBg0ma6nP2F2MlBmDv59zhbqkHpSmo3q9ndiW56zTXggx
	JuSXViRGWAlOCqB9Qd7VjLbT9I3rtv8Ptj/PqmYB5bVIoaMBNckkC2N1I1nqMdLQ1UtI6u
	wSHAotClWgMozCjS9cTlGJ/MuWzUaHYmRYtnsjtDzx6+S6FIMjAdrU8rvyqDUQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 4/6] adc: meson-saradc: add AXG variant
Date: Fri, 22 Apr 2022 08:29:12 +0300
Message-Id: <20220422052914.1836694-5-adeep@lexina.in>
In-Reply-To: <20220422052914.1836694-1-adeep@lexina.in>
References: <20220422052914.1836694-1-adeep@lexina.in>
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

