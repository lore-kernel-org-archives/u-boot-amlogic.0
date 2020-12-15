Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web09.130.1608051315339527950
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 08:55:16 -0800
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201215165457euoutp023e947903729e8b7c70c44aa32f70d4f8~Q8iKv4WKi2696626966euoutp02L
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 16:54:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201215165457euoutp023e947903729e8b7c70c44aa32f70d4f8~Q8iKv4WKi2696626966euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608051297;
	bh=25f9K14ba99a3g1qYAViGnEi+v2MiDNaZ0KcW6aa4SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eejOQWWy3BY3ELcUGgYcOAH+ULzqRhup1dLNDkJHJmiLqcrITDrmQxt8qUgMPIE4p
	 /pOFDU9yL2wlcpK7+J+2JJwpCoAd63IMHWTI9aSuHSjVQ/3bMg7xl6rw8SUNYYvpgO
	 qCMt0bT3GatFc87Z1koBkfoMavUR4WSSklNRkZQ4=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 6/7 RESEND] cmd: button: store button state in the 'button' env
Date: Tue, 15 Dec 2020 17:54:39 +0100
Message-Id: <20201215165439.13165-1-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-7-m.szyprowski@samsung.com>
References: <20201215144230.9235-7-m.szyprowski@samsung.com>
	<CGME20201215165446eucas1p1c627adde04ee9da682e665756c5e934c@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Save examined button state in 'button' environment variable to enable
checking button state in the scripts.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Resend reason: get rid of the Change-Id tag, that was still in v2.
---
 cmd/button.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/button.c b/cmd/button.c
index 64c5a8fa04..8da911068a 100644
--- a/cmd/button.c
+++ b/cmd/button.c
@@ -23,8 +23,10 @@ static int show_button_state(struct udevice *dev)
 	ret = button_get_state(dev);
 	if (ret >= BUTTON_COUNT)
 		ret = -EINVAL;
-	if (ret >= 0)
+	if (ret >= 0) {
 		printf("%s\n", state_label[ret]);
+		env_set("button", state_label[ret]);
+	}
 
 	return ret;
 }
-- 
2.17.1

