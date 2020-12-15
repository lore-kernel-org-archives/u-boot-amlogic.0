Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web11.12710.1608043387224363092
 for <u-boot-amlogic@groups.io>;
 Tue, 15 Dec 2020 06:43:07 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201215144250euoutp027b0cbdcd906048eb8c69a83de30d39fe~Q6u0OsmhC1507615076euoutp02m
	for <u-boot-amlogic@groups.io>; Tue, 15 Dec 2020 14:42:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201215144250euoutp027b0cbdcd906048eb8c69a83de30d39fe~Q6u0OsmhC1507615076euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1608043370;
	bh=JjCbe7dJUMYOKHef9/EJ+A4k4tBdZY2KTbt99YPqGHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aP2bQeOkrxqxwm8HPySEMFwX2S8GqgP1uH/q+NORys9lrDm2lzLpG6t6vRios6fDi
	 kHRBmZphiXdVDmzCn6KjESn3WRexhw/6Yz9w0on/B5U2/dT/MOZwHl9mgkS7LXlInM
	 QRGXMcxBINKDjA5B5H2wr9W5TbINNYCA8dpTcQ3Y=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 6/7] cmd: button: store button state in the 'button' env
Date: Tue, 15 Dec 2020 15:42:29 +0100
Message-Id: <20201215144230.9235-7-m.szyprowski@samsung.com>
In-Reply-To: <20201215144230.9235-1-m.szyprowski@samsung.com>
References: <20201215144230.9235-1-m.szyprowski@samsung.com>
	<CGME20201215144245eucas1p174ae2f6945b84f7f67528f76d0ff5939@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Philippe Reynes <philippe.reynes@softathome.com>, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Save examined button state in 'button' environment variable to enable
checking button state in the scripts.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Change-Id: I78b539e1516573fcfea4401f75469291844daae4
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

