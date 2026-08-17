Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784AC61DB6
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65.1786986989640803393
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=nMVtkqxp;
 spf=pass (domain: brivo.com, ip: 209.85.219.51, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90a6b298887so17975566d6.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986988; x=1787591788; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIJC71MvXoGSMHM+hoGJCWybiSoBjCDRZKN0lFU7bCI=;
        b=nMVtkqxpScnNcdzGxUSFcR2O8k2egWNXN994mJBDKkJZWCp6rj8esqIygQucRQv/S4
         zWouFliyxRp5K8CjjEUnaKQtFYIJ9prfpPMhxYweOM2kk1Ru7iPiDyZ+Ak42IEjlwwBC
         m2GA1J1BccZ6jwImkw4uAA8ZDL+dtlutHhSDyZ1uEElZmB2YxHr6fM4JfR9SQlu+VAu3
         C1C0iddNrArsdZLzp4yKaySMVdbjtH6TuM4kYh0zKbCYdorDR2/EeAID+XrJAp5w+kow
         z9dbbJhFRORYNEJDZt6zWcyeKGZ7cXb3C+QWvXe+J8jIO87ktDFzXsk0zElvnSVoWPcf
         Z3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986988; x=1787591788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIJC71MvXoGSMHM+hoGJCWybiSoBjCDRZKN0lFU7bCI=;
        b=BJckWzYN7qVBIDqXlszLa8L3YCY+A8lyH0cnCdOr9g3EywW54j4RpKvSQLyTJeF9kH
         p1kI4ZVRFQNpZKaklibEicn+8FlXv5g8c7jwH41oeXwUFqepyuGkcCiZDa+I9PEe28PI
         F2qbnKMmnu19ktxBNN4fGiVr9DflRTfLq6LceRTeF/hmLL4izrBv+QLWfeNPj7d1TEqt
         t9HQAy5kOtc4hFdF1zcwtz1bzQflckP3XOE161y2gTR6+S+6f2QDudi+hQibZmHbk+zt
         eEAbv7ij+xWvHH8Xo7qr9TvVcf718YPg08/m+5bYSo3KrUZkZMxTDqqvE1RcTagAdPMz
         qQRg==
X-Gm-Message-State: AOJu0Yw1M3wB+ZU6bb+silGkhmHU43yel0U7MwBwvPTWy/5H06oG1VjO
	ubVIkqeFcc2kQ1O2NdMDGLOhWkc/KcWkgNnJ5FnqUXI6ujzm+8+MfiAZeYw7cTZPx83uUmwSSjd
	8rZv23QCo16x+XbmIKHiaXFFPPSGw422l3Sp4WzkUaLaRKR1P/XZKcqv4kWFydRHWWwBKxw==
X-Gm-Gg: AR+sD10MoVue/nwmCrUy0kvtqM2qb6jWQcLJ3D1wrQ4Vt22HiOaG8bCTxyeRjHVM6vA
	zXa9jXSXi0FK1dHW7/YALYk+R7C4g4Vi0yYii1+xn/Gkf1GC9VNwhnz/0UnrAUg3aIOXKoLg63p
	qTO53D38FOJ4ET+qsxFlFwliTRyb9kzCaKGMt3JATri/rlUay4jf6Bu/u1rXLO3L6QN5NzRJyqq
	+n/AtslWVcFKH6Kx5S3ftN60w8go2IbUTBSLGNoUdZ22TgRc7KDJSuBlKfg0PHTQhYdNo/g7/+i
	EapdHlKseWw/WD/W/BfRiXim+YEGwG+Vq368ruABsxB0TVwkDeDROHuajIqlIDP2YIwzWJAwLff
	L3FS1CrtLzEv+iUM4mHEDikWcZt4qFqydoESq2Cjw00pVKS2bW1aXx+WoIIS3L2eQWHRuqOp1BL
	kX7FhSrwyrdKsD6wvKrL4Iea3MYnuAN45cHedzWxw4rFggm//xsAkTMEKcJzdIZokUrDqp7k7NL
	4RLlfK4gtOm2aIqpIxNkvG9qyU=
X-Received: by 2002:a05:6214:e89:b0:8cc:d066:54d with SMTP id 6a1803df08f44-90a91d8c3f2mr297402926d6.24.1786986988248;
        Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
Date: Mon, 17 Aug 2026 13:15:14 -0400
Message-ID: <20260817171623.1943847-4-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3038

This function is useful for other drivers, but it's tied to the a1's
meson_mux_set_rate implementation. Convert it to use clk_set_rate so
the drivers's set_rate implementation will be used (no matter what it
is).

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/a1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index d0376663069..422cdf5f4d1 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
-
 static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
@@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 			.id = info->parents[i],
 		};
 
-		ret = meson_clk_set_rate(&parent, rate);
+		ret = clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
-- 
2.53.0


