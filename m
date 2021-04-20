Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.7629.1618908152294836767
 for <u-boot-amlogic@groups.io>;
 Tue, 20 Apr 2021 01:42:32 -0700
Received: by mail-wm1-f44.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so3560317wmd.3
        for <u-boot-amlogic@groups.io>; Tue, 20 Apr 2021 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IkaK9iisGAwcyQj55uc1H4g47vvqMB926glhDPyhSrw=;
        b=zSQrbK9MlynIW4rFCUzHzpjWUw0Ar6YBjtfLgwQDGFBrfnCTeAkbS58aYX9HVd986e
         UGdRKrxeuPLk5OA4s1OD/o/tVTV1F+VPur7IuGfx9NCZvf9gFHlucnpXUhsNTLxsmpFH
         fsuVqCqiA/+B80pmV1K4SuwsTF/pH+hoU89JccPdUqThH1fu+xdzeNLOeG9jfIvLPkP5
         sNLa1faKaMpM2gdZgaHTcm0tL0St74/9IG/6vsWXdjZbw9KZXoMaa2y6vGb2DmWyhaAO
         n0G/gvD+TfyyAdjRmRqOOpyYVluFQPZmIbe0ZVI1CjuNOCPpZlPXqw1oYufuUGooNA4n
         usBg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] reset: fix reset_get_by_index_nodev index handling
Date: Tue, 20 Apr 2021 10:42:26 +0200
Message-Id: <20210420084226.2996654-3-narmstrong@baylibre.com>
In-Reply-To: <20210420084226.2996654-1-narmstrong@baylibre.com>
References: <20210420084226.2996654-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: sjg@chromium.org
Cc: jagan@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>, B1oHazard <ty3uk@mail.ua>
List-ID: <u-boot-amlogic@groups.io>

This fixes an issue getting resets index 1 and 3+, the spurius "> 0"
made it return the index 0 or 1, whatever index was passed.

The dm_test_reset_base() did not catch it, but the dm_test_reset_base() extension
catches it and this fixes the regression.

This also fixes a reggression on Amlogic G12A/G12B SoCs, where HDMI output was disable
even when Linux was booting.

Fixes: ea9dc35aab ("reset: Get the RESET by index without device")
Reported-by: B1oHazard <ty3uk@mail.ua>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
index 071c389ca0..ac89eaf098 100644
--- a/drivers/reset/reset-uclass.c
+++ b/drivers/reset/reset-uclass.c
@@ -95,7 +95,7 @@ int reset_get_by_index_nodev(ofnode node, int index,
 	int ret;
 
 	ret = ofnode_parse_phandle_with_args(node, "resets", "#reset-cells", 0,
-					     index > 0, &args);
+					     index, &args);
 
 	return reset_get_by_index_tail(ret, node, &args, "resets",
 				       index > 0, reset_ctl);
-- 
2.25.1

