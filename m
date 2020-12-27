Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web09.30616.1609058814458543594
 for <u-boot-amlogic@groups.io>;
 Sun, 27 Dec 2020 00:46:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1609058811;
	bh=mxNFSirUVDTJ8JV+KysqrHjWYLmjYimaUkj0fZ5Akqo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=TYg1gGCa41a+ZfaT8a+64TeTNHY/wwvVibqkWKpZviOLC7oX7YdUybkPi7E79RHso
	 MG5E7/68z0stXIUez3Ku2Lxq6p4DvG2HJO9pM/PSQiFCSXwP9yrJ49Yi5Fwj7Y98c0
	 Ag8GmWqo6ZlyONUISmpeBQv9BEBFKfL+uY/VbiJE=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] adc: meson-saradc: use correct printf code
Date: Sun, 27 Dec 2020 09:46:46 +0100
Message-Id: <20201227084646.4172-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

For printing unsigned int we have to use %u not %d.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/adc/meson-saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
index 13a8f49dc5..406583e474 100644
=2D-- a/drivers/adc/meson-saradc.c
+++ b/drivers/adc/meson-saradc.c
@@ -282,7 +282,7 @@ static int meson_saradc_read_raw_sample(struct meson_s=
aradc_priv *priv,
 	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
 	fifo_chan =3D FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
 	if (fifo_chan !=3D channel) {
-		printf("ADC FIFO entry belongs to channel %d instead of %d\n",
+		printf("ADC FIFO entry belongs to channel %u instead of %u\n",
 		       fifo_chan, channel);
 		return -EINVAL;
 	}
=2D-
2.29.2

