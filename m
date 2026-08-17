Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332BAC61DBD
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67.1786986988889237933
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=Z3Riv90c;
 spf=pass (domain: brivo.com, ip: 209.85.160.176, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-529a1ee0e62so26083651cf.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986988; x=1787591788; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oRDXAE0MI20Zf0t2wNM49MT6dswoxNTo5thXVzk6l4M=;
        b=Z3Riv90cumQaEU14FCZFazRltfCLYw8FJLcMK0Evvu/0B35M8eaFICk0jzUXOpetKp
         pH+zo569u7bhxDTjvggHC6rOTy6WaNYI72CdeAERJDmQfowXo6xY4fp2kjKCzpxHgnp/
         jzoyEnvYtUZdOUqRzmCZmvem8RUnVQwtGc24fETFiaMEihTHDgB9SQs3a1NchbeB9EwM
         H7A3RHaZOo2TsXsdwY87IWGAKakZTVwwwox2dw2urdvf6pbJPc+wvBFbXOovAPm4nPBc
         QlsQZmfCptQW/y6d//6vC+ouZb02352w2SOKXtVp0xoMXOibqVYmmIzRA4JJNiaKbeMu
         59Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986988; x=1787591788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oRDXAE0MI20Zf0t2wNM49MT6dswoxNTo5thXVzk6l4M=;
        b=UxlXX6aZBo/xN7nK61jYFnAZ2Z0V7AMTdLY4l+39lJk3CkMePTd0jgr4VN0qmAbo4S
         NjuIPkbNsMzMURt4lHeY2JaS7mAKUGNH2DmuCb+sn5BPYLauH0KBzS1vh0gcpL5eouyN
         UFf+DaG2wQ4gtF1xxH3unibpCIop8knPea2EoNK8oL9KB3MkNx/LieO26JKgX0bErYOI
         c/Zbz2Fyefwf1/0O3m5DnEqlG1p6RAdMNERhDLBXdbeLlzboHb/TCD4R0EMr8SYyE71q
         wT8p+D1n30pFMydIMk5NJz9FHsRk+bPCBS4LG1scP4/E3awAuryrAEeF26mUSWOAzGeD
         BdVw==
X-Gm-Message-State: AOJu0YzUdvnGpfWvZ5g5K7KoptX2mbqnwPlqcniVeFpny7ShpQQan8Vv
	i5DJEN/VX+MK0GklMh8XLJ1HTp5lm5d8VcYMQAjmwo/ydaZ6X82lbssgQBI/ls3aqnlLqFE0bgA
	gZM1bjwwP0J3S+a1TlhYj6vhG0CpZqTt2WVmvuTWZkAgkT0wuse8OFQ==
X-Gm-Gg: AR+sD12cYvucLbkOwU8l9KTbDGa0s31NcyJC76NzOxPRXvGEArsg+DrckVuPZYnzm6z
	henO+gikDv/pmqvkVwf2jHom4/kumboRYmtPpaZi2Hc5JzUcOhPennsO8P1++0zuqIXP9vjx+m2
	SZHH+K2oKdf5eez0QZLg9mbofP6tnBU4rhsq50uE9OOltZvpGj89v5+x7HOoIlBwcorNbh9HzPh
	5w8TuYQ3HsHJJnwvIkWOqrivCGX3+KInTu4d7MuCp77mZ8g27+Q6gYslrS6rqdqTSLQHIbmLE/Y
	WMbL4IgbKXtHSNCgywqq90Sc1FYiOvcOBvbKU5OouCyg+/BHvD+YtLg46pLHfdYASqd9Rir1X3t
	lmpOpmVdInXscAHVs/LQecvRrup26Rx13L/usTmpci2c/Z605qAR+iABWf4PHHkJPvXbqv92nDU
	kaUJ5WZOzycOd9y+QLNUOYRje1WtFlvYSAS/nQWq81F6Ro7/XCQRJH0TdkqGDfceA7mUTD3ZG9X
	bx8q7n/eVy5qd6IPYdSyB4eEtY=
X-Received: by 2002:a05:622a:2b49:b0:51c:b98a:2448 with SMTP id d75a77b69052e-52dbd5fed58mr29129911cf.9.1786986987473;
        Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/9] clk: meson: a1: Eliminate separate id parameter
Date: Mon, 17 Aug 2026 13:15:13 -0400
Message-ID: <20260817171623.1943847-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3037

Instead of passing a struct clk (containing the device and an unrelated
id) and a separate id parameter to most functions, just pass a single
struct clk with the correct id. This is in preparation for converting
some instances of meson_clk_* functions to clk_* functions to allow for
greater extensibility.

In general, this transformation requires constructing a synthetic
struct clk wherever we used to call a function with an id different from
clk->id. We don't bother to call clk_request since we don't implement it
ourselves.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/a1.c | 150 ++++++++++++++++++++---------------------
 1 file changed, 74 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 669247a9a09..d0376663069 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -302,17 +302,16 @@ static const struct meson_clk_info *meson_pll_clocks[] = {
 	),
 };
 
-static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id,
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
 						       enum meson_clk_type type)
 {
-	struct meson_clk_data *data;
+	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
 	const struct meson_clk_info *info;
 
-	data = (struct meson_clk_data *)dev_get_driver_data(clk->dev);
-	if (id >= data->num_clocks)
+	if (clk->id >= data->num_clocks)
 		return ERR_PTR(-EINVAL);
 
-	info = data->clocks[id];
+	info = data->clocks[clk->id];
 	if (!info)
 		return ERR_PTR(-ENOENT);
 
@@ -322,7 +321,7 @@ static const struct meson_clk_info *meson_clk_get_info(struct clk *clk, ulong id
 	return info;
 }
 
-static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
+static ulong meson_clk_get_rate(struct clk *clk);
 
 static int meson_set_gate(struct clk *clk, bool on)
 {
@@ -331,7 +330,7 @@ static int meson_set_gate(struct clk *clk, bool on)
 
 	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -350,32 +349,35 @@ static int meson_clk_disable(struct clk *clk)
 	return meson_set_gate(clk, false);
 }
 
-static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
+static ulong meson_div_get_rate(struct clk *clk)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	u16 n;
 	ulong rate;
 	const struct meson_clk_info *info;
+	struct clk parent;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	info = meson_clk_get_info(clk, MESON_CLK_DIV);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	/* Actual divider value is (field value + 1), hence the increment */
 	n = GET_PARM_VALUE(priv, info->parm) + 1;
 
-	rate = meson_clk_get_rate_by_id(clk, info->parents[0]);
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	rate = meson_clk_get_rate(&parent);
 
 	return rate / n;
 }
 
-static int meson_clk_get_parent(struct clk *clk, unsigned long id)
+static int meson_clk_get_parent(struct clk *clk)
 {
 	uint reg = 0;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -391,16 +393,16 @@ static int meson_clk_get_parent(struct clk *clk, unsigned long id)
 	return info->parents[reg];
 }
 
-static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
+static ulong meson_pll_get_rate(struct clk *clk)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 	const struct parm *pm, *pn;
 	ulong parent_rate_mhz;
-	unsigned int parent;
+	struct clk parent;
 	u16 n, m;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
@@ -413,40 +415,39 @@ static ulong meson_pll_get_rate(struct clk *clk, unsigned long id)
 	if (n == 0)
 		return -EINVAL;
 
-	parent = info->parents[0];
-	parent_rate_mhz = meson_clk_get_rate_by_id(clk, parent) / 1000000;
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
 
 	return parent_rate_mhz * m / n * 1000000;
 }
 
-static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
+static ulong meson_clk_get_rate(struct clk *clk)
 {
-	ulong rate, parent;
+	struct clk parent;
 	const struct meson_clk_info *info;
 
-	if (IS_ERR_VALUE(id))
-		return id;
+	if (IS_ERR_VALUE(clk->id))
+		return clk->id;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	switch (info->type) {
 	case MESON_CLK_PLL:
-		rate = meson_pll_get_rate(clk, id);
-		break;
+		return meson_pll_get_rate(clk);
 	case MESON_CLK_GATE:
 	case MESON_CLK_MUX:
-		parent = meson_clk_get_parent(clk, id);
-		rate = meson_clk_get_rate_by_id(clk, parent);
-		break;
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent);
 	case MESON_CLK_DIV:
-		rate = meson_div_get_rate(clk, id);
-		break;
+		return meson_div_get_rate(clk);
 	case MESON_CLK_FIXED_DIV:
-		parent = meson_clk_get_parent(clk, id);
-		rate = meson_clk_get_rate_by_id(clk, parent) / info->div;
-		break;
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent) / info->div;
 	case MESON_CLK_EXTERNAL: {
 		int ret;
 		struct clk external_clk;
@@ -455,20 +456,11 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
 		if (ret)
 			return ret;
 
-		rate = clk_get_rate(&external_clk);
-		break;
+		return clk_get_rate(&external_clk);
 	}
 	default:
-		rate = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	return rate;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk)
-{
-	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
 /* This implements rate propagation for dividers placed after multiplexer:
@@ -476,19 +468,22 @@ static ulong meson_clk_get_rate(struct clk *clk)
  *     ..... | |---DIV--
  *  ---------|/
  */
-static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
+static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
 {
 	unsigned int i, best_div_val;
 	unsigned long best_delta, best_parent;
 	const struct meson_clk_info *div;
 	const struct meson_clk_info *mux;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct clk mux_clk;
 
-	div = meson_clk_get_info(clk, id, MESON_CLK_DIV);
+	div = meson_clk_get_info(clk, MESON_CLK_DIV);
 	if (IS_ERR(div))
 		return PTR_ERR(div);
 
-	mux = meson_clk_get_info(clk, div->parents[0], MESON_CLK_MUX);
+	mux_clk.dev = clk->dev;
+	mux_clk.id = div->parents[0];
+	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
 	if (IS_ERR(mux))
 		return PTR_ERR(mux);
 
@@ -497,8 +492,12 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 	for (i = 0; i < (1 << mux->parm->width); i++) {
 		unsigned long parent_rate, delta;
 		unsigned int div_val;
+		struct clk parent = {
+			.dev = clk->dev,
+			.id =  mux->parents[i],
+		};
 
-		parent_rate = meson_clk_get_rate_by_id(clk, mux->parents[i]);
+		parent_rate = meson_clk_get_rate(&parent);
 		if (IS_ERR_VALUE(parent_rate))
 			continue;
 
@@ -524,21 +523,26 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 	return 0;
 }
 
-static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate);
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
 
-static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
+static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
 {
 	int i;
 	ulong ret = -EINVAL;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_MUX);
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	for (i = 0; i < (1 << info->parm->width); i++) {
-		ret = meson_clk_set_rate_by_id(clk, info->parents[i], rate);
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = info->parents[i],
+		};
+
+		ret = meson_clk_set_rate(&parent, rate);
 		if (!ret) {
 			SET_PARM_VALUE(priv, info->parm, i);
 			break;
@@ -551,43 +555,41 @@ static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
 /* Rate propagation is implemented for a subcection of a clock tree, that is
  * required at boot stage.
  */
-static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate)
+static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
 {
-	switch (id) {
+	switch (clk->id) {
 	case CLKID_SPIFC_DIV:
 	case CLKID_USB_BUS_DIV:
-		return meson_composite_set_rate(clk, id, rate);
+		return meson_composite_set_rate(clk, rate);
 	case CLKID_SPIFC:
 	case CLKID_USB_BUS: {
-		unsigned long parent = meson_clk_get_parent(clk, id);
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = meson_clk_get_parent(clk),
+		};
 
-		return meson_clk_set_rate_by_id(clk, parent, rate);
+		return meson_clk_set_rate(&parent, rate);
 	}
 	case CLKID_SPIFC_SEL2:
-		return meson_mux_set_rate(clk, id, rate);
+		return meson_mux_set_rate(clk, rate);
 	}
 
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
-{
-	return meson_clk_set_rate_by_id(clk, clk->id, rate);
-}
-
-static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
+static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	unsigned int i, parent_index;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_MUX);
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
 	parent_index = -EINVAL;
 	for (i = 0; i < (1 << info->parm->width); i++) {
-		if (parent_id == info->parents[i]) {
+		if (parent->id == info->parents[i]) {
 			parent_index = i;
 			break;
 		}
@@ -601,11 +603,6 @@ static int meson_mux_set_parent_by_id(struct clk *clk, unsigned int parent_id)
 	return 0;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent_clk)
-{
-	return meson_mux_set_parent_by_id(clk, parent_clk->id);
-}
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -636,11 +633,11 @@ static const struct udevice_id meson_clk_ids[] = {
 };
 
 #if IS_ENABLED(CONFIG_CMD_CLK)
-static const char *meson_clk_get_name(struct clk *clk, int id)
+static const char *meson_clk_get_name(struct clk *clk)
 {
 	const struct meson_clk_info *info;
 
-	info = meson_clk_get_info(clk, id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 
 	return IS_ERR(info) ? "unknown" : info->name;
 }
@@ -651,11 +648,11 @@ static int meson_clk_dump_single(struct clk *clk)
 	struct meson_clk *priv;
 	unsigned long rate;
 	char *state, frequency[80];
-	int parent;
+	struct clk parent;
 
 	priv = dev_get_priv(clk->dev);
 
-	info = meson_clk_get_info(clk, clk->id, MESON_CLK_ANY);
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
 	if (IS_ERR(info) || !info->name)
 		return -EINVAL;
 
@@ -670,11 +667,12 @@ static int meson_clk_dump_single(struct clk *clk)
 	else
 		state = "N/A";
 
-	parent = meson_clk_get_parent(clk, clk->id);
+	parent.dev = clk->dev;
+	parent.id = meson_clk_get_parent(clk);
 	printf("%15s%20s%20s%15s\n",
 	       info->name,
 	       frequency,
-	       meson_clk_get_name(clk, parent),
+	       meson_clk_get_name(&parent),
 	       state);
 
 	return 0;
-- 
2.53.0


