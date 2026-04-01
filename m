Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A069A10F6FCC
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 15:01:53 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14874.1775054398713071994
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Apr 2026 07:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FK+ZaWIC;
 spf=pass (domain: linaro.org, ip: 209.85.167.49, mailfrom: casey.connolly@linaro.org)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so9411142e87.3
        for <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775054397; x=1775659197; darn=groups.io;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzL2sauUwr+llsDzghXaGJvUYu2Z/A1MC81/qWtrgGU=;
        b=FK+ZaWICZJ9wUeDs5/FYfufasgLk1tOIo74kSF6Y8vUDsLwf6j+br4CA4V5qZRv9fb
         XYkN2qWfd/scL/oOlBxfcSB334YddjHruntRp5kj2JTDENcBicpF+Llg4W42mJ9P/5gC
         NYeRen9WZqlg+9zu9pWZAAdOOfhhHm8E6jmZS9Bahv4b06nNl0LdYbnyljppTRJAxr+G
         43MzPARfAiplfnUtP2Z0/rlSrxYpWkgRq3G2FQvtdQ8EZz5tq8romeLzijCdBJQgFWtx
         17mTxrWRoX28W/80eeLPMW96uHjpGu6s8LbrqQriEarwiOyZGt31wgVhDX8g4ehfKnj2
         gKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775054397; x=1775659197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UzL2sauUwr+llsDzghXaGJvUYu2Z/A1MC81/qWtrgGU=;
        b=Pk9FqTfis2yo+sQo634AQjPx2uTx13IJF62OUPEXbHFX+k01rsGoc8Rx31seEpxzP5
         faVSXfDggF1rspu77JZzYwOM3+8OkrBxgUTR7HiJA0Ihbg0dsHjwKFaG1xix0wLNXyhy
         WQrfMuV1XFScaZclmXPNLi0mnE7G8cBDm2QxwODkb1tc0eXwO6Cfp4YgB/PZOdirGnrw
         9U1RKTdNPePRH+OAaDdK0KrMDmfmOKQ3tMA/mBPrVu46qWKD9avnx3RyKKo9r4ifehD9
         d55OLy0ngFyW6L1ZDdlGCvm6CDtlfuWSSL+pRasTrfdQAxWnvQeoKu66sG9wnMOm1NQ9
         fQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5pA4v3bQCu4f7rb7oJSk8BdGThmrcpMa3uyZID7e5eokNGnbWk0jicOhiNr0ZQ8t1XRPHK+9hv/PZ94hNOQ==@groups.io
X-Gm-Message-State: AOJu0YzIsXJilGYPeZF/7sRPMBY81LH3iXgQeiih9ACZGh9DOYJX6Uai
	GIezuLcJJNXcVFN8Du83iLscI7nnAEb6lZ9JDhrMBiF3IqS0b7quohfNLzGdDpq82M0ut9X53MB
	cnpnC59w=
X-Gm-Gg: ATEYQzzS2zysU4rT1DP2upROpQHvcu6Wul65RezYTykMlL1vjZyP0Gc/89OCG1+K/TM
	+r8yu80DpSBYx6G178PSv0UBz6FM+w/S+D+wATgFiMq/2UcZ3uu5uHp9i4/P7vA+y83HErRRBUO
	Tk9eESexJp7kh1wTe6/QjKjl6WB7qW1s1IaCqgwC5BMDBqQL2ZGzA5CAZ8X3cegumtRsHoksSQE
	a/Z8nw7+zdg2I8VDDVh+McFjF2o7VnAhbq+hALv5MTjr2ZKul4WDniYA1LPWkBLY7h3beuB+daF
	EV+A5HQyZbru6fBn+Kq0ywww9nYRnSsTolb9zQWILeWdhGEUviwFxmd6C1cNyMT2WvL+SEsBqAt
	UdyNPl/GSThhkiYswHcl4hgw6/ZXiBRAUgEvYREq1h5363uuJgj0SV0BIw9BVswWzfxdFHb/V0V
	XoYVd5z9xhO5sH2oVyKB9c7kJ6ELJZNO0wWy907LsuYTCutRaPBpIirCWvMK6MKriywmnYuSjif
	uOsg3k=
X-Received: by 2002:a05:600c:1e02:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48883575cc9mr75812185e9.9.1775054061172;
        Wed, 01 Apr 2026 07:34:21 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm161821795e9.3.2026.04.01.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:34:20 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:34:08 +0200
Subject: [PATCH v2 7/7] clk: compat: add clk (un)prepare and associated functions
MIME-Version: 1.0
Message-Id: <20260401-casey-ccf-clk-prep-v2-7-16a78c8c62da@linaro.org>
References: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
In-Reply-To: <20260401-casey-ccf-clk-prep-v2-0-16a78c8c62da@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=IDjDTfUKfPC9O3Xt5VwKw5S4av9GhFWz+Ya5oltXAzA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzOo9ZHsuuWPv1vMOe4KdrTQu1NAVezkic5cPxL9KnK
 XavsvWvjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRl+aMDM3+VaIGy17ZvNxg
 57ir2/ZhVWevn0mn6VXLVX6aqo27khj++ymtlTn4mD2ituSnwrT35qmmvbzFnGumnvR+Lvzf2zI
 nDwA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 01 Apr 2026 15:01:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2945

Introduce clk_prepare/prepare_enable as well as unprepare and bulk
associated functions. These are just stubs but will be used with
CCF_FULL.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c |  7 +++++
 include/clk.h            | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 095329e25f15..e960d2ad2383 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -837,8 +837,15 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 
 	return clk;
 }
 
+int clk_prepare(struct clk *clk)
+{
+	return 0;
+}
+
+void clk_unprepare(struct clk *clk) { }
+
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
 	 * when a clock provider is probed. Call clk_set_defaults()
diff --git a/include/clk.h b/include/clk.h
index 0520032f692c..6ae033259cb1 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -514,8 +514,35 @@ long clk_set_rate(struct clk *clk, ulong rate);
  * Return: new rate, or -ve error code.
  */
 int clk_set_parent(struct clk *clk, struct clk *parent);
 
+/**
+ * clk_prepare - prepare a clock source
+ * @clk: clock source
+ *
+ * This prepares the clock source for use.
+ *
+ * Must not be called from within atomic context.
+ *
+ * U-Boot: this is a no-op unless CCF_FULL is enabled.
+ */
+int clk_prepare(struct clk *clk);
+
+int clk_prepare_bulk(struct clk_bulk *clks);
+
+/**
+ * clk_unprepare - undo preparation of a clock source
+ * @clk: clock source
+ *
+ * This undoes a previously prepared clock.  The caller must balance
+ * the number of prepare and unprepare calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_unprepare(struct clk *clk);
+
+int clk_unprepare_bulk(struct clk_bulk *clks);
+
 /**
  * clk_enable() - Enable (turn on) a clock.
  * @clk:	A clock struct that was previously successfully requested by
  *		clk_request/get_by_*().
@@ -550,8 +577,49 @@ int clk_disable(struct clk *clk);
  * Return: zero on success, or -ve error code.
  */
 int clk_disable_bulk(struct clk_bulk *bulk);
 
+static inline int clk_prepare_enable(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (!ret)
+		ret = clk_enable(clk);
+
+	return ret;
+}
+
+static inline int clk_disable_unprepare(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_disable(clk);
+	if (!ret)
+		clk_unprepare(clk);
+	return ret;
+}
+
+static inline int clk_prepare_enable_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_prepare_bulk(clks);
+	if (!ret)
+		ret = clk_enable_bulk(clks);
+	return ret;
+}
+
+static inline int clk_disable_unprepare_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_disable_bulk(clks);
+	if (!ret)
+		ret = clk_unprepare_bulk(clks);
+	return ret;
+}
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
  * @q: clk compared against p

-- 
2.51.0


