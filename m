Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6763C87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 08:00:04 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.18440.1754645686429961212
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Aug 2025 02:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=l3Dzy+xX;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: andrew.goodbody@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00339c8so12262525e9.3
        for <u-boot-amlogic@groups.io>; Fri, 08 Aug 2025 02:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754645685; x=1755250485; darn=groups.io;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHZdllu1/8epQ/AqnTK/iH+No+R+8tN+24QaooJoVu8=;
        b=l3Dzy+xXEEgfHNRR8duPP/KSYL1PmjrfHyOLpUcx0I5/fb3kDadSSbYH7mmUG7oOF5
         RWJGkc78Vf3ufhudL2LFrU6iJcx8Tw6EwnzZMb1XqkxGXFuMIfRgFhF6MaGIAZ8v7tDe
         7ImyxgjklsKyiEGEIr+hDe1+9xZ9LTJQw2Ci20bkqTOlcHBRqztBz8LiSI/8rniPwyo2
         FChJAQj44uIa69QDRxkmV7/iUesNEn/DrlLEW6idnFKetFlukXklvEH1+khx7VPELgf5
         BE4kF4QARf1oFFJYePb2TeQd/LDqn5ebwzZyzjd+6JmwOa6TD34oNfiwSkavPVnxRFG1
         3tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754645685; x=1755250485;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHZdllu1/8epQ/AqnTK/iH+No+R+8tN+24QaooJoVu8=;
        b=pw8yRRCHDijSOpEIfaxViphW2iBuMr3GI5pMx6bIKpp+2AtjSZo6+1+3lEt88PR6RR
         e1iUMT6ERLLiWWyzIhkBH6yH9RAobsrJJMR5A4KvBhYeP+CJIpFKGFo9ChmKP4Y2YTv5
         NBUGi2BGaVTKqKuRGI2N/iQeo42ptNMgLiNZxkBziuEaRUkBnCZFvPhjeyLKSklq0tda
         0AqQGcRylDDR6RHvujyXhDwhMjPkHB8I935L5WCiGkVZCfHBqA0LTjTh7cmYP3TREu86
         f4QHpJQcekuIzh+gr21WdVIg0Ccieb1Qp6ucH65TIdXY1Oz/h+XsTR5oueBQ6aXG8cw2
         MwTw==
X-Gm-Message-State: AOJu0YwAxytCMycMyBz8FPN2NVBCmB6sZNsq9r5fQernnYRUR0FuC1uF
	HkxkvMl8B0SeVz/HZ4nOflYcoMlzFXwvu6ojRfRVRVVnx4vc8ujnpqMrgFndxWo9mZ8=
X-Gm-Gg: ASbGncvBkYn6QkBxeHVzqGs34Od3u03CRff7yU04TrxNpG68sHTfHdtcED/OrmPfs77
	XlN+ZpqNaGTiAENQTgO96kViryl43o8q9eILW94rGfsCLVwfMfOUljfTKwNZZDedIWJQGEYIT5b
	OloIau5X2Z71HDQzvnTtvWWRmumFgDWR/jA7rQr2kqU8sCub0oztboh2wSvUAXBlvY8KM68Ezqd
	OYyc/IwhJRQKig9zqdLKcQI3XImDhVvkVrIl8so8J3yt0EX1VSGR4QyDEXqUOcVYfsV4CiO7ya4
	nPZNIylBgQRUWIC5gIhfwJ3+3T3NsrPwUTtHHH9u7p0pZlC8QQfqlsCTfZThRApuiKPRtm+9H28
	ydGbfLxQUoNNPpjFslE1IlfVpEnGxpP1wTAhuCFCP0FQSxeK3Cv8=
X-Google-Smtp-Source: AGHT+IE25h1Iy5OfzdsuVUh/G3b7rPeooK4yjmI/zyR/2PgT7WVdJkzPQ5pePNsQsHqInUB1nkCD/A==
X-Received: by 2002:a05:600c:b8d:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-459f4f3e76emr18961695e9.12.1754645684541;
        Fri, 08 Aug 2025 02:34:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:f9e:3c01:e7fc:9a8d:4024:d186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm124063005e9.6.2025.08.08.02.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:34:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 08 Aug 2025 10:34:43 +0100
Subject: [PATCH] pwm: meson: Stop premature exit from for loop
MIME-Version: 1.0
Message-Id: <20250808-pwm_meson-v1-1-cddb7e5f76bd@linaro.org>
X-B4-Tracking: v=1; b=H4sIALLElWgC/x2N0QrCMBAEf6Xcs4EYGq3+iohc2tXeQ9JyV1Qo/
 XdTH4edZVYyqMDo2qykeIvJVCocDw31I5cXnAyVKfgQfec7N3/yI8Om4k4xthech9ByouonNri
 kXPpxf2S2BboPs+Ip33/kdt+2H6Q4V850AAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Aug 2025 08:00:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2735

In meson_pwm_probe the for loop attempts to get the name of a clock but
the following if..else statements only perform useful work if -ENODATA
is returned from clk_get_by_name. If clk_get_by_name simply succeeds
then this results in a premature exit from the for loop and the
following code can never be reached. Make the else clause only apply for
an error return from clk_get_by_name.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pwm/pwm-meson.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c2597d8b669..caa7af085fa 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -359,8 +359,9 @@ static int meson_pwm_probe(struct udevice *dev)
 
 			/* We have our source clock, do not alter HW clock mux */
 			continue;
-		} else
+		} else if (err) {
 			return err;
+		}
 
 		/* Get id in list */
 		for (p = 0 ; p < data->num_parents ; ++p) {

---
base-commit: 123cd77122a13288e1552b5d9b7c22a6f19e2e02
change-id: 20250808-pwm_meson-65549e7d24ab

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


