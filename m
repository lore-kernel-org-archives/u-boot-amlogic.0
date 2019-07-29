Received: by mail-wr1-f66.google.com with SMTP id r1so61885749wrl.7
        for <u-boot-amlogic@groups.io>; Mon, 29 Jul 2019 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9dw1dqF8aAbWoinwQMv4KUs9iUxf43l5bSM9NBDn2Bs=;
        b=DsmalDwnxP7HhwZkqpKVpLtnsp1FQj/vRoa7kyWcjzNeOjf6p1uuoxQlP01h4A11wN
         bgDq+yf5crq4xbbi5gz2oJgXndUYNiThhdP1ckT8RP0JbyE3YNY+joooGnhITVz7ZwKW
         vZW/Z0ncjeFJsV/KcM896b1ihlVv+eACREmc4WDwipx7rmknpam1Z87BmLRsG2/o6lqy
         XMwj2+oKx1pyAL/5Rh14gQtICexN4Fwhomi3rVSnV20r5t6PHEQ00mPQ9Skju2XHL/+O
         BcEz6OYYCIeKwGmrQmM6Qkrcfh8PMtjod6Q2SmmCWlAJXibtZYPhjexTMYsapB1+cECY
         drMg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH] edid: fix edid_get_timing_validate() mode_valid lookup
Date: Mon, 29 Jul 2019 15:35:18 +0200
Message-Id: <20190729133518.8287-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add a condition to the break in the modes lookup, without this
when the first mode is not valid, then edid_get_timing_validate()
return an error instead of checking the next modes.

Fixes: 1c1ed441b0d1 ("edid: add edid_get_timing_validate() variant to filter out edid modes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 common/edid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/edid.c b/common/edid.c
index f244d26e04..f99f42dc40 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -202,7 +202,9 @@ int edid_get_timing_validate(u8 *buf, int buf_size,
 							 timing);
 			else
 				timing_done = true;
-			break;
+
+			if (timing_done)
+				break;
 		}
 	}
 	if (!timing_done)
-- 
2.22.0

