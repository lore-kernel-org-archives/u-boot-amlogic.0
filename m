Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA5EC47DDF
	for <webhook@archiver.kernel.org>; Wed, 24 Jan 2024 12:47:38 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.21489.1706100449002756195
 for <u-boot-amlogic@groups.io>;
 Wed, 24 Jan 2024 04:47:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=m2ZErRdH;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so4404758f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706100447; x=1706705247; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PS6AjdPWBzKVqYOhBMydmkOHJ51S3TlLpazatsIz2lg=;
        b=m2ZErRdH5Miil88FetJ5rjcwZf+lBD3M9v2DZ+okrFK9QsOAKiNLgeSEFCRGWEmrgb
         whyfAmt+cP5MiIRwtzMpotDNmupQhjLJhTYmBYKZPOvtswMy3qg24taZPTpn1Ze9U+m+
         Dd/MRga4TrGlM3OFd661n7QL7Xx9FmmTjxVjMONJD0OL3nBKC0N2OBRfk/o92iZld4sE
         oPE4LFKSk926saxrZd6/+o+jCYOyTr/6MHU4IVQIHful4upQaGK9CJGcJAQLksKUlei4
         S9gK5JJ1QBAoNveY+55wDEGxXSzCD6Rxvky8TmSx9zaSkHXFQiJyZuXhhAP8NE22YJxl
         30kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100447; x=1706705247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS6AjdPWBzKVqYOhBMydmkOHJ51S3TlLpazatsIz2lg=;
        b=XOYlDEujD3xJ25fbxuoDbhmQamrHONvjW1dejNJm/u6QhXKwwPI+tApJCKQMmX4Hn+
         MlDaWnmZdhNcX3LyZY81+DlJy3bN8EdI8Mz17q28NRYGD8jkKqszFjsaJLyQZ3664iWP
         5nB+cYBQBynz5YPBuf7e02iRYVzClPY2fKNfMh/o2LZlAJ3vBMVj57RjtObtaJ+8fYDl
         ogq+65LpvmKUDNM5hTMTaZ9kvamc+QFxUoeSMJrBzRouQ8X4HBPPxKBBWEdFxFe5USgC
         wwjKNxDNFeLYavvfSfO7LJ5K7iyHfnBGuJHd2uUU6lK2RdrizSK7dA4BDlKAYeUsnAZk
         vqlQ==
X-Gm-Message-State: AOJu0YznPinveQKN/Me5B5w6OycgA8pPwa12zyXLowxPvKwg/g101WFK
	a0xMUs0XpGZoq9s9fdMJGXTg6vcJXdtblpa8R6hkp6efWWICYKPLTs1lLhtef9w=
X-Google-Smtp-Source: AGHT+IE+TxL1U/FUABslv/x1K0v4nmNHquDwuz6r+ngtl5UaXKKrx71KBVLgc/RLKeAqafTwKyXQZQ==
X-Received: by 2002:a05:600c:3ba1:b0:40e:ccde:8a2b with SMTP id n33-20020a05600c3ba100b0040eccde8a2bmr26991wms.119.1706100447304;
        Wed, 24 Jan 2024 04:47:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p30-20020a05600c1d9e00b0040ec8330c8esm546060wms.30.2024.01.24.04.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 04:47:26 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jan 2024 13:47:25 +0100
Subject: [PATCH] ARM: meson: stop printing board model after sysinfo update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
X-B4-Tracking: v=1; b=H4sIANwGsWUC/x2MSQqAMAwAvyI5G2iDC/oV8aA2akBbaVWE4t8tH
 mdgJkJgLxygzSJ4viWIswl0nsG0DnZhFJMYSFGhNBV44ejcibszvOHhxZ44y4OTIW5KU9VMGlJ
 8eE76H3f9+35dc7NhaAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jlYHdtqMwvyt6WVSzocgomE9PmyhY7ElSsh3ssl7e9I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlsQbe5GMhrWfEXmtWiWFJ/gzUnG2JVLn0NOmfZ3FJ
 lTw0+TOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbEG3gAKCRB33NvayMhJ0TMREA
 CbsXY9V8/BB0KmEw1IGEmYbqtacp9LFE7MA30fOfJch7+VWQLBrn8YbwZonJC88g5kPI2rqKWzdODc
 Z9NY1VxW9dmylHR9Ik37CeV2p8pM5lO2KqX9oyFZGy5YZubFYOOTwlwFxhpBdQbZ9TP0Mj9ASymhQh
 QuskkCnIvseKvLqlyiwPaaOdjEdcQfC4mRXIJ2oZIt5vxICaECchHs4UlPJ5PlTRUwwA5WDJxbneW1
 cKW3koKjGXLH2zUt0mEMsNZXSVCBy4zz3h3ev67ydtMpumQ66eW0ecPhYQpmjn+H8DJDER5Zh0BgkV
 FBEwJnlVz79ZV8r78f6Nyg2FFUuPb/vIoiKgbagNkqJGkhTZKT+JyCs/uBtj+y8lYDIVD3UcPI68HD
 Jzf9GtMkSiQmVK6qmGubarWzgIkX6h/cljgQjvdxDADZLloeyutcrE5w1xMrPqpDIJxoDyqoXcud36
 D/L5MsgDQrymoxXWVSQUKdMLAK2RQNqHORB56XGvzkyHhM/t/yir+2ASSK//ruSRXYtF2Om3mYOTPN
 0iAOHIDYL4bW7WRmEup2VhiQdtKuim1uW4bCZkkRuoSDMoI2HRLhVN0VxJtK6vlOPqGZS9FEe7sq7H
 C5+u+U9rjsxzfjJN8vVZZq7ivPvyTUcBmgMZWrBnlz/DY7FDYNqFYgn++3oQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 24 Jan 2024 12:47:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2079

After the sysinfo update, Model is printed twice, remove
the now duplicate Model print from mach-meson/board-info.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/board-info.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 95a29da072..d51d9b8f06 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -126,13 +126,6 @@ static const char *socinfo_to_soc_id(u32 socinfo)
 	return "Unknown";
 }
 
-static void print_board_model(void)
-{
-	const char *model;
-	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
-	printf("Model: %s\n", model ? model : "Unknown");
-}
-
 static unsigned int get_socinfo(void)
 {
 	struct regmap *regmap;
@@ -172,9 +165,6 @@ int checkboard(void)
 {
 	unsigned int socinfo;
 
-	/* print board information */
-	print_board_model();
-
 	socinfo = get_socinfo();
 	if (!socinfo)
 		return 0;

---
base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe
change-id: 20240124-u-boot-model-print-fix-cd2e95d67e21

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


