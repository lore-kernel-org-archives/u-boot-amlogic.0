Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899ECA5FAD
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2886.1790705246676737376
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=Hfz8Ld8V;
 spf=pass (domain: brivo.com, ip: 74.125.230.235, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910c9ff1cso405625385a.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705245; x=1791310045; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
        b=Hfz8Ld8VtsPuUp3gFM8XnIxh3bSkfwKaIgc7QcLGhhcyWF2wtXLkzsyyzXNSkQGa0w
         0GfAnyrlWqG6R9Ogc1OJ9a5uu0ZJ7Dz+zQnxQrEB+AMxIzZa2stMmZrOn96tBFI3PQhI
         amzyF9cAvBwBYc4uvcQgdaJAEcQnvNNEYXTLeXqyHdaYiEPm71oe/ZDH0PTIMjzxvCYv
         Zt4OwR+Xh3kFsK5ws7IOOGtaVQJVkq7+3wdsMi515jgOVGxfRcWVD3tEKSchgtE/HXsq
         NP6exlbKObYG8+uJYYlgxCdfxHto1maK24XS6aVqSiC5BEfN4+jwTIl8icQQEyaowW8n
         xwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705245; x=1791310045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1EuYUFZ2n6coR/6vwHaUSVPjIGS8hMMuUnGoOXDjBrI=;
        b=suMPQA6sFAX0VlCCvqiOuUjST1QoKYQ4BLKbNdnIxe9EXHJX2UpG7ESJI4NYXX3DDV
         +OYoAF+KAbf2+4EVScuegb0DKoPaso8upj7R7Nun57WKNMAbe8+YmvmzvuCgIJva5b03
         TxWsOpCAr1bbXL1RuQxqub3+s3AbGu2+hA03HsDQ4v5HzOLspHRnhudrn3uooaRIdeXH
         ZeFzCUU8voZFjIuzjR1uI4IR5lJxa7cub6+tWfLNDb1dSV0bKe0BjrMj6WeLZTGHcsoB
         b6g0ECvNpjHzgEMIEfaQSf1n/N6mahjF0HHPgpEHP0XJMWDPdAUcSdUCFKV+apDiSJnD
         ao3w==
X-Gm-Message-State: AFuF++ntbHYUO0BtNIkv/k7YS0Jr4A0+Pmt4EdFycOYgOqH9OesqqESB
	UnfDWH8ehJWVOa1Q69vKI2HH75hCA/CxUgb4fM6sfFyiwURRVvq7KY5CbzYkWEke9pvhdW6z4BN
	Ga04MgxE2m4+ia89PQScmNjfzwGfKNRpJ1t08PDsI4+fPu4FMp0Zp3jNAjfOK5Hom/6qI5g==
X-Gm-Gg: AYBFou0hGSeNxsEnCSp7P8BqdnVfLbLEuwgRUu/4LXzzJ1bRMlYSvo8V/S5HoxCpmZ6
	cUZ0tiVHN+Wnn8YfQ4ZINElc2vCXyGGMIlPxxbxBsS/ONGRKH9009us6blsITRbYxtQcxNAtK/R
	17qkazmqOE/Hy31MleFUaeCV0/1BaQIh3FDNCpM6hiM4QX4sVABKTGX9XeJFY8/4kdRSuO9m9zD
	cT0PjsCvytiRlBTkSniGD17oXJOlcRccEDLlZhLjgV6FWtVOftkhnf7QvsI2X7+rIu/3j6htjiG
	TLOA/d1taJkndqKAweOkGgVFwGwb9mQSm8XadH+kQJaMV7RBtgaJHUsV788QDLY4wcbUNfrwl6X
	IThd4xWhVpcVzMGX7iy9JauCJv+wxUACesww8EFTi5IOjzdsldG0RW93t+eblnQBgZ3WlCh4pUt
	xcOxbl/qI9qO6ElqFy5+vHMSKmuiCrzAiXP/VmC6O5eJRIkD+SGNEtw0wVMwmtaTvlOtAoSC+kl
	4Q=
X-Received: by 2002:a05:620a:808c:b0:939:6dea:4f1a with SMTP id af79cd13be357-93c9fa9f5dcmr67532485a.48.1790705245388;
        Tue, 29 Sep 2026 11:07:25 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:24 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/9] clk: meson: a1: Eliminate separate id parameter
Date: Tue, 29 Sep 2026 14:06:24 -0400
Message-ID: <20260929180721.3440839-3-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3105

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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

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


