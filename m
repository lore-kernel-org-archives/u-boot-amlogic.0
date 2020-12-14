Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
 by mx.groups.io with SMTP id smtpd.web12.33289.1607945109116227186
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Dec 2020 03:25:09 -0800
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201214112452euoutp02b5f7d8f9f8033962f2284d8965f5e721~QkYrYgq1R2239122391euoutp02U
	for <u-boot-amlogic@groups.io>; Mon, 14 Dec 2020 11:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201214112452euoutp02b5f7d8f9f8033962f2284d8965f5e721~QkYrYgq1R2239122391euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1607945092;
	bh=R7mNm5ML53RHW9zx3apeGR+lOQFHGzETqEb+IveRrCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApqfuTFR1PaQmppypk8eD63YqcGAlU3tpRCoDPESQU0zsjxoLf/8+qbqma+TES84U
	 aBmq47Ik80/Qj7cuiTlwWIoldUFkiZs284Tvld3m9oBBJZxoLYQVmLiwuA99xMoHCR
	 JqagSMRz/5g3leQS/Q8kNTe7tQbdef2+FMkMHnos=
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/6] cmd: button: store button state in the 'button' env
Date: Mon, 14 Dec 2020 12:24:36 +0100
Message-Id: <20201214112437.18757-6-m.szyprowski@samsung.com>
In-Reply-To: <20201214112437.18757-1-m.szyprowski@samsung.com>
References: <20201214112437.18757-1-m.szyprowski@samsung.com>
	<CGME20201214112451eucas1p2ace7794301c6791761fd130c158f3d08@eucas1p2.samsung.com>
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
index 64c5a8fa046..8da911068a4 100644
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

