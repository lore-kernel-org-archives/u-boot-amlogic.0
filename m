Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mx.groups.io with SMTP id smtpd.web12.7925.1604642258367459665
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 21:57:38 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201106055736epoutp0265094243c6b77bc4043d9d110fe9664c~E1aFWXmeP0610406104epoutp026
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 05:57:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201106055736epoutp0265094243c6b77bc4043d9d110fe9664c~E1aFWXmeP0610406104epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604642256;
	bh=slJ8mZ6WSivNRU2NyaG3479AobUhwAE8rMEsvk7hFgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCr6X6dcXsBMigQaEkaZWrMEUvXwwfV6jwF1Yx96qW/MQUWS+Lt08u9JYBsGy0Ipd
	 4U2a8KQm6QOa0coH6MpjccFTe9q/iLvLn3CbrjVZFNeKxwSSU9W0NB/go72mKq/AJo
	 0Y76l92RDNsmPElk/efRphYtnUhLOacu+Hfvyahg=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] video: meson: meson_dw_hdmi: fix the potential build warning
Date: Fri,  6 Nov 2020 14:57:48 +0900
Message-Id: <20201106055748.20042-3-jh80.chung@samsung.com>
In-Reply-To: <20201106055748.20042-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <20201106055748.20042-1-jh80.chung@samsung.com>
	<CGME20201106055729epcas1p261694150d79d3a6d58c25ff22c9d8be3@epcas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: narmstrong@baylibre.com, agust@denx.de, u-boot-amlogic@groups.io, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Fix the potential build warning.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/video/meson/meson_dw_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/me=
son_dw_hdmi.c
index 7b2ff94eba58..5d74f7f1a740 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -379,7 +379,9 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 	struct meson_dw_hdmi *priv =3D dev_get_priv(dev);
 	struct reset_ctl_bulk resets;
 	struct clk_bulk clocks;
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice *supply;
+#endif
 	int ret;
=20
 	priv->dev =3D dev;
--=20
2.29.0

