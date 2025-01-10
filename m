Return-Path: <christianshewitt@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C6E7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 04:04:07 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.11657.1736481838379096668
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Jan 2025 20:03:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Iy2zQM5F;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: christianshewitt@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e0e224cbso866191f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 09 Jan 2025 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736481837; x=1737086637; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9Bo1wufBfvDp17xEGdBsgVq8YY1KmqG+B+4M+rmsTk=;
        b=Iy2zQM5FYE5AqxNnwAU9QnrmIQbFIfkpjUy1sLlmPAbElgHxXVtjCQ99jvN1Ur3/ph
         NkuvW6i1CWXQKRgmd+eAXAxDI6ENlC8FAglcvzdLU1cjpQPwHwmFIInOCue9N9jcQ4RN
         aIhDJYScI8syggK0/HOVdeuxINRo81s62WwF7YF7E7z0L978x94nJvn5sTfwdKgRkTsV
         7M52CEtb0J7GqUpNoARp49WC3nOboA1yjPaPQhLJAvYMrRZzfrpvNIgeKvC5Ug+UpmFR
         5dmpuvzsqtdhp76hHQmpLwPE0xT+CwdG4Xa1tgh+tBVRkNVfjSRSzgut3c1IV7sajgfT
         81DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736481837; x=1737086637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9Bo1wufBfvDp17xEGdBsgVq8YY1KmqG+B+4M+rmsTk=;
        b=seA6N5wY92emBvmUDMqgo0NNMtF+Usij0ihjyl3VMsdSTjoaldhZZq7Hg1GqOzj/xG
         ra/EbtoS0XNhqf3aZjIbb0mX+QtCMJAbF1QO/MRJv7Cz2vXU5iv2XogRvGXeBjgJxoou
         1Tbkj6I0r4SXbkJENlyiFuXyQzYILH+J72FvmIjJHWOVEnKjdeSYLQms3UsvZCo/dDTd
         7Nvwvl4C7SzH4v58tsaMVrWNwtRsY1Ljj7FsG9u4rmYHwRLb4rmvZh1ZlapxUUni0TVw
         6/9/zfNOYlF3jkk/egqQBrDFIgFkVAd3ui4cdRJqcKUD0HNOlMm2kkSPBiixkLJIJu/F
         u9jg==
X-Forwarded-Encrypted: i=1; AJvYcCUt+78E2aLT8wiqwM0kFoJSGqiQQoakfLRSPPaKU6rGOYo5+zghlU3NHwJawu4zs23pMaKqUTaSY/PwjTec9A==@groups.io
X-Gm-Message-State: AOJu0YyIy7FkHisD9BxOXIZzqy3BdhULUqbOfcsy7Rv/ZwoIVJdS/UsJ
	G8/wk2MPO7gAtAhRHXTMIIrAFuBLTE5MrOpzF+0U5+QQc06vnDYQ
X-Gm-Gg: ASbGnctJuZ9SUhVnqG5Sg3VJw1Gm8AtxG+QzT6PSghuu3AnPNh1q2LaRPlQKSB+Stgs
	p5QiXyX/BfPNk8p+nTggDVy4uUEOUyiAx6t1ykPoRRyG90l64qZVpJ02MfNDBMyN54TfTxREY9h
	yu8T2UU/4icLMVAcjRvFmhW6xr845PgVq+XDw/Kqo4icDvqgVGkYbB77U0mED6CVxhqAS/Wgkrh
	Vv3zx2gjQ027ypNLKDUh742IcttT432Hu4h3Dan/wVtZ2wMplTi+d2WlKdpzA==
X-Google-Smtp-Source: AGHT+IHiy+F2Jl4v5xbpj+sHo2KV7tlexhqY548aspvjHj4DdDRLp+zVYDo51bSm0OoUyQn9/eyrcw==
X-Received: by 2002:adf:b1dc:0:b0:38a:88bc:ace1 with SMTP id ffacd0b85a97d-38a88bcadc9mr5438179f8f.34.1736481836597;
        Thu, 09 Jan 2025 20:03:56 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d69sm38686505e9.30.2025.01.09.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 20:03:56 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] board: amlogic: odroid-n2: remove amlogic prefix from fdtdir path
Date: Fri, 10 Jan 2025 04:03:53 +0000
Message-Id: <20250110040353.3424412-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 04:04:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2610

Commit 834e7c8136c6 ("dts: meson-g12a: Switch to using upstream DT")
changed Amlogic configs to contain the default /amlogic device-tree
path prefix, e.g. for odroid-n2:

CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-g12b-odroid-n2"

The board files also prefix amlogic when using fdtdir resulting in
an /amlogic/amlogic/meson-g12b-odroid-n2.dtb path which is invalid
with most distro packaging. Drop the prefix here to align with the
board configs. This resolves fdtdir boot on Odroid N2/C4/HC4.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/odroid-n2/odroid-n2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index ae953d0e4ba..e98580631ec 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -62,7 +62,7 @@ static void odroid_set_fdtfile(char *soc, char *variant)
 {
 	char s[128];
 
-	snprintf(s, sizeof(s), "amlogic/meson-%s-odroid-%s.dtb", soc, variant);
+	snprintf(s, sizeof(s), "meson-%s-odroid-%s.dtb", soc, variant);
 	env_set("fdtfile", s);
 }
 
-- 
2.34.1


