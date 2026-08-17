Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD50C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:24 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34687.1786984568957422596
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 09:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=25iEnPYw;
 spf=pass (domain: brivo.com, ip: 209.85.222.180, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed19f4d60so6415385a.0
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786984568; x=1787589368; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBe8CcsQxm8wIR39y8TD1tkkfesQbMZhbUDiCeLvjls=;
        b=25iEnPYwjjd7Ja28jeAILomhPx0BRmUfVn9xd4gB2IY3tpfsyEISEDsJYHbVkh+q+4
         at9Us8d+ZkwdKiEOn05iIrw/7eQyQfKFwM9oNBBXQ1PjcNU03xzGlbNTz6inBnJuqYvU
         6jV7Bvd2ZWLxrAAWEa+XapwGl/EWwltdaVarz6Z3L6i5JXREGFSHbDCn8bxrDecKH4lN
         17Gjgg8wSDrQZTyKYsVeztiOpC+iuHGKhqZWJFGfLXCgXxeix1BwwS83mXhOhCiUR7mK
         1xHmvlM6emYoOU5x2vSBu5ezOQqxQOpEsaxqhj1rKsor8XmVG7crUT25qwiB1e3BkYmp
         vKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984568; x=1787589368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBe8CcsQxm8wIR39y8TD1tkkfesQbMZhbUDiCeLvjls=;
        b=lXJV3rvweeTK4BUZL4yqQONyox1qlla7cB7jmCR+OSHY8VXhE8e6oEOSrtLo81F4O5
         YcZGcyZM1KHXm4SKV3QhSbYMYjoq+MUKbXQwLJf0R7lYQB0BNNf1dU/UGGpgoIPtona6
         00mxbGfhDvm09an743392BuecHmIMMQZ58brwK5mrvZzGCFuJjHpWsl2YlCxbTk1yTuD
         NIdwxayyzd4fxNdBp2HgNFJzygmKvebkr7mfWYPjkx/vUdR+FQpNwafw6bXjKwTfQUVR
         xYNPmxEwyQfT7HbV+IrxROkCdRsIRm6YdqdPoENmTq1nVuun3yL9kP2D3NIrObH2kcFA
         77rg==
X-Gm-Message-State: AOJu0YzwbCkJCnzwPu95Q2eEFJVUNM0yxKMPOgtGPwaf20Ggyhjol87v
	nX386FMCtClz9VGAUefVeJ2ydi309X57A/KKWys872AUmJhaSI8nYWYoPZJqo19ZfRmabU8mnZo
	XupOUjrEbAlgMDFVYHr0AGZhhaB1ctG0m2mqjtjyBQb7Khc4ddqoEKA==
X-Gm-Gg: AR+sD12iQvReYuULpifw3VUi1D+eag2Fi82MOB5/C8gIrjvviTJNW0+dbHtY57Wk9r1
	fQy1goFWfx9W7tuRZL5lkoZvk94g02V4xKxzNVuvqqObf2LfqlK2OvMjQES0TJY/wNfP4k+jMZc
	svnvqIvn67xwgSHuDggC+ejbpXsOBEHKQZj821uKYUM+1wRelLI7+euGXD4vVLll6wzh0DRpryt
	QTwuWwlfMVHoH2U1CEjsDGt1tdjl8BstfSbm5lCTOpfqb1Y0smCPelUUyLHtHKpML3nN5ZDuQh2
	j2zPGig0r9UXTxawKkpWOZoPQqn5hFma2RNJS2urC/jpK3908SIk/7D2d0yzgojtf4sjHXc8VEn
	/6HdIOAzp/hnKmETtf5sD5WOh7WV9GqAVHHdBwZGlXfY6f1NDmM1L2d6CGwCNZZGeBEwKw0PQ6U
	Ifs6G/AfndmAB6AlBLCEmlDzOA5xoD+jlPoNzTWvgSVCO5bJK1xRaXnJrj66q2qSSHnjqeggAkk
	VlQLV1nwxLU2iiT0tjWS13LdAY=
X-Received: by 2002:a05:620a:284c:b0:936:ce17:7792 with SMTP id af79cd13be357-9370657a3bdmr50009285a.8.1786984567702;
        Mon, 17 Aug 2026 09:36:07 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010c3785sm122431685a.2.2026.08.17.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:36:07 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>
Subject: [PATCH] reset: meson: Add s4 support
Date: Mon, 17 Aug 2026 12:35:56 -0400
Message-ID: <20260817163604.1893382-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3028

Add s4 support. There are no new features, so just define the layout
info.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/reset/reset-meson.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 8c27563ce23..16d2dc19898 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -82,6 +82,11 @@ static const struct meson_reset_drvdata meson_a1_data = {
 	.level_offset = 0x40,
 };
 
+static const struct meson_reset_drvdata meson_s4_data = {
+	.reg_count = 6,
+	.level_offset = 0x40,
+};
+
 static const struct udevice_id meson_reset_ids[] = {
 	{
 		.compatible = "amlogic,meson-gxbb-reset",
@@ -95,6 +100,10 @@ static const struct udevice_id meson_reset_ids[] = {
 		.compatible = "amlogic,meson-a1-reset",
 		.data = (ulong)&meson_a1_data,
 	},
+	{
+		.compatible = "amlogic,meson-s4-reset",
+		.data = (ulong)&meson_s4_data,
+	},
 	{ }
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_reset

-- 
2.53.0


