Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1BBC61DB4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:24 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34655.1786984485693084795
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 09:34:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=b+IpnYya;
 spf=pass (domain: brivo.com, ip: 209.85.222.173, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930c0f9c1b1so196283585a.1
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786984485; x=1787589285; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kCIFlfBQ4qcYVxTjUHXCXmdkk+hDhU/r6JNSGGTwTEA=;
        b=b+IpnYyakN8VMznvKKUHUXi4hq858/A9JMq5deNKteA9bYySDuqOeS++VokNlkfjmw
         NxBnVVYcE2NN8BdBjXDOzYKjuIoRdFDS4Q+4wlgeslwg7Y/6zkr1fMYEGWKZ9nXf9DzT
         /+uycK0OpxRxbJmvbOD2PnxaGiOb97RrZTHpm6qMfqm8Hvvw8nlvQci1Sx+wKWO5EM58
         LNZKKsSZJ5fBeMACMCuxiurMPzK5FnY5mCEvj127U2ZNy236DaC61S2asROmi2DR1neK
         GTW7e420G5e33is48AMYnqSWraXajoswY59wS8BRuYFPFj9mN92n25oxeh6QAg/LJ8x6
         agtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984485; x=1787589285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kCIFlfBQ4qcYVxTjUHXCXmdkk+hDhU/r6JNSGGTwTEA=;
        b=Oi5cR8qdKB20t5EwRDMd3byRjSUCPSn5Du81/mb2uszu+3sFQB/kFR3IErmch07NBJ
         wIRpoMautBdlchXEhPJV6TmQ2igoqypYehEQG+as2ZQKJe3M+Ie9GFUoEhL1CshBs1fo
         PkrXe095izNse4KxH+gtdgpB+Cx21eR7N41T5DVrPmxzz3CJwNAuMVa3R0/MTiqGlgpF
         MogQq59OyaXa7ZHL2OzpDmk2WcrRi3T348ay9MbTbpg72X2iILxKUC+8kwKpEH8OFbmQ
         AQh7LLioU12JVe7qb977y5eqsUj6YK+FrIwNkeM7SeK0vJZjJ6rBc7WnSlriUDp/tqUG
         /M1Q==
X-Gm-Message-State: AOJu0YwVuNgTL/O70VZpnvb3ajlJ08V2zttoQy5O3Q2GJoJtKHSZaVTy
	OJBJoigPBiTYKbmThgzrAK9OzS/gcNRcq48NolPEymQ+n70M5NdJbsjEVkXDkSToO56dGGLsmKg
	3MxxZM3+80uX4Nhvh+x0cIPMTZRUvUjcijzGottVGIvrcRCbaXdl8tg==
X-Gm-Gg: AR+sD13+RdSXDagOYRLFU3cCc0jSEfimH7+DbbjL4eCvjAMO1holcV39ZoP+uPQ5Rby
	ak1zHW/WzFxmiOOZNTeecZqdLvQCLIcrY28jR8yW+1A/FhLtkdH+lX1KjKFZc0xwmV7x8U+t5be
	5crMCAvYwEGhjVDDX179hRV/EF3IvOGXJ65u6JLvREXkUiOCK3g+H5WiUelrHkwpClsxHKZnYH1
	+1dQ1CXEcRvdA9/nzFC8ECXciIM3NnRgDipprz4EbKRnhYdOabbwm7t11NTPJKId61Vbcs5tQSh
	1ehRJUZOPZSMOwGiuSR2YyUNyKObEpIHYUw0Y7HV6XtF+iW2C1RKtVPv/zj1rHSJGoj0BBDYtN6
	CzNwx1h4M8uhsqoXQLy1mAK6kATui5ZaqAdgd3vEfhLA9iBQah2x9VWkV6+fLy3x1pHxgDm9ZvZ
	m6YkQOD4C+uyPQ+ImrL98RNapDlPo9PQ0uV79oaeajYVfidZn1xSKy7EKZppnBAIZKDoye2v0gO
	dZVssRI7ttIZdfBdALs14jZCZk=
X-Received: by 2002:a05:620a:4143:b0:930:f337:ebeb with SMTP id af79cd13be357-93704b12d66mr197540185a.12.1786984484574;
        Mon, 17 Aug 2026 09:34:44 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ce78csm83874085a.31.2026.08.17.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:34:44 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH] serial: meson: Add s4 support
Date: Mon, 17 Aug 2026 12:34:36 -0400
Message-ID: <20260817163438.1893025-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3029

No new features, just a different compatible.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/serial/serial_meson.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index cc71381f87e..336ca552ead 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -244,6 +244,7 @@ static const struct udevice_id meson_serial_ids[] = {
 	{ .compatible = "amlogic,meson-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
 	{ .compatible = "amlogic,meson-a1-uart" },
+	{ .compatible = "amlogic,meson-s4-uart" },
 	{ }
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_serial

-- 
2.53.0


