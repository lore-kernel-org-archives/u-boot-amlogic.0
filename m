Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7DFCA5FB5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2888.1790705248938548487
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=JWd5kRja;
 spf=pass (domain: brivo.com, ip: 74.125.230.233, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c57d36d37so411200185a.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705248; x=1791310048; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
        b=JWd5kRja5KqolEDV9F9JwflOqk5/8HmcVz/c0XZ4pgC/6oz65VDH8dTu5mD1AbbgfF
         D19z4VpgopKiL5A2uiQt/H4lpySeERKViVkymaPd5pKuO7XWQ+VA79Axkk+UXlr1QOWp
         PPSVEpiDamAHOoKnuN/QPX+igF4M1d8KTIEC/s0OWyq1mi5w+1KDxMaiTdIfMZGIxImp
         vZMtRqKQl1Nv8+wQ2JG3iFEQLFXaU9gC6kiHersZzjiDeKm0gjirtujfU1a3OvjWWgoj
         SRcUsf66W8xhTTHUKdEbUCLHZpQt3Y6BRkT0XcPBVuSS/+u7rJZNsRp2ZbfM+cmvPSpG
         W6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705248; x=1791310048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mpZf9zSG4aebIyRGKV83fhGT9psEYBk4ZzeKrNzVGo=;
        b=xhWvHFN9CETvROje/gnR1uVW7q6rtKMVW8q2iYGYiPpIZu++6BabTkJvz1Zo32mZVq
         w0Uj6dqfJIeLdsF9hm090eIBhOPDmKt/k1VmxDJmYKrl54qNf5acuI4e7dP8KEqLroam
         xN5JEdXR6y8nF1orX/1iVI/ga+MYoEq/EEULNivDvVunC5XHk5f6blPuoPV94vWeJLhk
         S2ENMxjJ9z3qLHq+lElBHxqZlOJ/cxznqOa7kUA1zX5A3WHI3OOmmUJ9JfxIQeyce4Xd
         nftbo2LmlKQlkxx0dREKEAbA0pQsNtjyW7ahf+5RfpeT8kzLPtqd201njIyMv3GFtcix
         FTsA==
X-Gm-Message-State: AFuF++k02p9lyL2m6TToZF9G6WP90cXDKhuTeBjs0nONACTxq7ji2tdB
	pDKq86vrcaFrJjR9SFC+dJgpX/CO5Th/ZclYFAaCD7z74oadAXn0cYrjIilSH8nvgWn/r8x1SxC
	N5wIJtft9+nXnN8TMhm2eYyDecnRlaexnEvx9lVzqLRRRUs32fAoOHg==
X-Gm-Gg: AYBFou1jTM3KM8Bwgs6785F/4YKQ27TSJ9UQmpqb33EYMwc49OjZwIk2dRdSvNsqj30
	hfRGc+AxSkCIxBogc+/++b3/lOynX9JNfboA+3O+aSb5AH37hnjAjxGKd6wC+5jMAfr9XMTlMBO
	IxbvhDWvPZNUnO4WEFZBaIPgfvzG6Ki0Akpkc4jVaaV2Y4fWYmI09jGAV6KkvbGD68TFKyE+RMW
	luYK/D9zNs4BJjC3x7yZCWT1bRlevHTbYavCv42AkwSvv/67rFTl6ISg0SqimqlCaUF7ZlGsVAb
	x6HaUb08UelzuNPzQsnmP2eLbK/EXape8q/F2MDenjEgLhIYRfy+hvpwb0nXnDSTX9URtJvT4uX
	4tePnBvQSXqhJVJUA4uEpc8cJ/YmtyHKY+c8wZfk+JOKBXvwcL5KFoe+0/gSuJgasI5ZIdYc3YX
	9DTBteNXA0FEaMnOfvslM4xEypBoYBTsRaCmuJN5j1hT3oMgY1qpXcWh3oy1s0yJZU
X-Received: by 2002:a05:620a:410f:b0:93c:7955:afd9 with SMTP id af79cd13be357-93c9fc84b26mr59232785a.52.1790705247516;
        Tue, 29 Sep 2026 11:07:27 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 4/9] clk: meson: Use soc-specific naming for common functions
Date: Tue, 29 Sep 2026 14:06:26 -0400
Message-ID: <20260929180721.3440839-5-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3107

In preparation for moving a1 versions of several common functions into a
shared file, rename all the conflicting functions to have a soc-specific
component.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/axg-ao.c  |  8 ++++----
 drivers/clk/meson/axg.c     | 12 ++++++------
 drivers/clk/meson/g12a-ao.c |  8 ++++----
 drivers/clk/meson/g12a.c    | 20 ++++++++++----------
 drivers/clk/meson/gxbb.c    | 20 ++++++++++----------
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 6ccf52127b0..3215391006e 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_axg_ao_clk_disable,
+	.enable		= meson_axg_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index c421a622a58..e20d3feaade 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -69,12 +69,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_axg_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_axg_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -279,7 +279,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_axg_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -305,9 +305,9 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
+	.disable	= meson_axg_clk_disable,
+	.enable		= meson_axg_clk_enable,
+	.get_rate	= meson_axg_clk_get_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index 61d489c6e1c..e89638d65b5 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -35,12 +35,12 @@ static int meson_set_gate(struct clk *clk, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_ao_clk_enable(struct clk *clk)
 {
 	return meson_set_gate(clk, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_ao_clk_disable(struct clk *clk)
 {
 	return meson_set_gate(clk, false);
 }
@@ -65,8 +65,8 @@ static int meson_clk_request(struct clk *clk)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
+	.disable	= meson_g12a_ao_clk_disable,
+	.enable		= meson_g12a_ao_clk_enable,
 	.request	= meson_clk_request,
 };
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index f33938e1419..cc7bfe9e2a2 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -194,12 +194,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_g12a_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_g12a_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -858,7 +858,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_g12a_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
@@ -888,7 +888,7 @@ static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
 	return 100000000;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_g12a_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -958,7 +958,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_g12a_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -1000,11 +1000,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_g12a_clk_disable,
+	.enable		= meson_g12a_clk_enable,
+	.get_rate	= meson_g12a_clk_get_rate,
+	.set_parent	= meson_g12a_clk_set_parent,
+	.set_rate	= meson_g12a_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index bf46f4d50bc..24b5f9b5d40 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -236,12 +236,12 @@ static int meson_set_gate_by_id(struct clk *clk, unsigned long id, bool on)
 	return 0;
 }
 
-static int meson_clk_enable(struct clk *clk)
+static int meson_gxbb_clk_enable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, true);
 }
 
-static int meson_clk_disable(struct clk *clk)
+static int meson_gxbb_clk_disable(struct clk *clk)
 {
 	return meson_set_gate_by_id(clk, clk->id, false);
 }
@@ -840,12 +840,12 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 	return rate;
 }
 
-static ulong meson_clk_get_rate(struct clk *clk)
+static ulong meson_gxbb_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+static int meson_gxbb_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return meson_mux_set_parent(clk, clk->id, parent->id);
 }
@@ -912,7 +912,7 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static ulong meson_gxbb_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
@@ -954,11 +954,11 @@ static int meson_clk_probe(struct udevice *dev)
 }
 
 static struct clk_ops meson_clk_ops = {
-	.disable	= meson_clk_disable,
-	.enable		= meson_clk_enable,
-	.get_rate	= meson_clk_get_rate,
-	.set_parent	= meson_clk_set_parent,
-	.set_rate	= meson_clk_set_rate,
+	.disable	= meson_gxbb_clk_disable,
+	.enable		= meson_gxbb_clk_enable,
+	.get_rate	= meson_gxbb_clk_get_rate,
+	.set_parent	= meson_gxbb_clk_set_parent,
+	.set_rate	= meson_gxbb_clk_set_rate,
 };
 
 static const struct udevice_id meson_clk_ids[] = {
-- 
2.53.0


