Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA70CA5FB4
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2889.1790705249961103431
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=CTVe4zFi;
 spf=pass (domain: brivo.com, ip: 74.125.230.232, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f7af3e1so310464485a.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705249; x=1791310049; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
        b=CTVe4zFijtNeklI+Isy+tRsRHDC1AxjdWsHTlH4XmSsz+L4eBDqkpoL/rmgE05ald4
         9Zf5PkRRHTiEPwHWDfw3YKNVuUASz7mcJ4LJz6F9n5hME7XjxypRhfkOW7Fb5nDioeDA
         ad3RzvGdaYN3pzZm6tKx9aCyGFoPO3ZFCixa7CIVRZkdtvBqLoTdHGNPNi2OKFQUxXqV
         nYVbNsA+Ds1Qh9PVGnsofs8crSciZHHunVC8BcsbqIFvCMD5kEtvQrCjXrVqgtgM9X8t
         Evta0ianQvn82jF3P7nXmO5G6nlvsagtRgXtGuyaf5pjOHfIvzwFEY2cKtOF0Ck9GSWo
         npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705249; x=1791310049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
        b=ukeeBGP6jMzu8yjipoSF+xGejw6bEccTuDMJdvtQWjnP5F0goT7OWKcnF/COp7kqYQ
         u8SquVrKhWMtMZh2rANo7B/88fGUvbSE6+bnSgqq708d5dqSPNDj3fkRTEo6YW1VazOa
         +QJul+/388k/SqZJlN6wO3KKHSOUsE5dQtcX1BwgLRU1a8aGf/lrY9acfITX/ubq0m6O
         Hvrj9vu2dB/sFMN1ETTjleufn56c/p4i9/Pb0OYzL0c56CMrDrxeLklWK6pxYkgAIyLn
         ZDORR/nmva7RNZdBVQoz6P2AGlxK20jHe/kXV1DxogKUJ1HdlBqk+FUWUKxvZGzcfrr8
         tY/A==
X-Gm-Message-State: AFuF++lFIGENrjvIvhSMEiafG/3d3kuijwPfsuHpa7iPQ8g6xNO2bU8f
	jk+XNaCa7BcqPCrQ+X90y18OWTNT9kZhhj6dkOdWdir+2Zmz5qFpM618X8FzlGQMkobGSebry01
	ISOy9rH/26/UI44Sait9eVTJIn3jHD5Y4fPRbFR0/iqj4hRunFUwTGw==
X-Gm-Gg: AYBFou0ZfX98awEkl7EaPrm89IztPnEXFGilWSuAtfaXbQLv93DKVLwbs0g6D/hZrij
	XgIxIE6Sx7y/EQDloBI6Z+bAoWzHIqaWuElLQfWGDe/ehDITwwJ7ioZxXOZ9buJpZMZd+swCQiZ
	yKuaOEjOguw1nfoF5QVabkf+t38QFPdK1SJMVq6+ez5vmplKIq+VDtXM+T8Gp0BG+E5izDqx6Xp
	HofvYhIgy4gxXDnRzv4Ui8rH87D+AnRvjtoJKneRLavFCYaKcdEs8sIJQMSEu8+ERFfp1R54WUC
	xRfvbf89fZ1wvRvmzYhEWCw5tffZUcdNCIur1NRVSTGOdZhut619k+9nUhd6UcZc2aBSCHZYKKY
	KGj4eoCD0Y4MFwjDTZW2iC+we20RV/vA1YTvaaoepbEKMWvbKjEwOnyB9mtIsWgYs8N/z7fosyo
	59+/LBJAHlGrN8jQN6JxqByjTjZsVCCWAaXNH1B9LHWNF11KCe73ELimjHlAnz1Qcp
X-Received: by 2002:a05:620a:3724:b0:93c:7211:beee with SMTP id af79cd13be357-93c9fb464e0mr67758785a.28.1790705248321;
        Tue, 29 Sep 2026 11:07:28 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 5/9] clk: meson: Export a1 functions to common file
Date: Tue, 29 Sep 2026 14:06:27 -0400
Message-ID: <20260929180721.3440839-6-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3108

Export several useful functions from a1 to a common file. These will be
used for s4 support.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/Makefile    |   1 +
 drivers/clk/meson/a1.c        | 473 ----------------------------------
 drivers/clk/meson/axg-ao.c    |   4 -
 drivers/clk/meson/axg.c       |   4 -
 drivers/clk/meson/clk_meson.c | 350 +++++++++++++++++++++++++
 drivers/clk/meson/clk_meson.h | 143 ++++++++++
 drivers/clk/meson/g12a-ao.c   |   4 -
 drivers/clk/meson/g12a.c      |   4 -
 drivers/clk/meson/gxbb.c      |   4 -
 9 files changed, 494 insertions(+), 493 deletions(-)
 create mode 100644 drivers/clk/meson/clk_meson.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c7a446e86c4..3d1dfcdb640 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,6 +3,7 @@
 # Copyright (c) 2019 Baylibre, SAS
 # Jerome Brunet <jbrunet@baylibre.com>
 
+obj-y += clk_meson.o
 obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 422cdf5f4d1..b6d1887c98a 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -34,138 +34,6 @@
 
 #define EXTERNAL_FIXPLL_IN		(NR_PLL_CLKS + 1)
 
-#define SET_PARM_VALUE(_priv, _parm, _val)				\
-	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
-			   SETPMASK((_parm)->width, (_parm)->shift),	\
-			   (_val) << (_parm)->shift)
-
-#define GET_PARM_VALUE(_priv, _parm)					\
-({									\
-	uint _reg;							\
-	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
-	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
-})
-
-struct meson_clk {
-	struct regmap *map;
-};
-
-/**
- * enum meson_clk_type - The type of clock
- * @MESON_CLK_ANY: Special value that matches any clock type
- * @MESON_CLK_GATE: This clock is a gate
- * @MESON_CLK_MUX: This clock is a multiplexer
- * @MESON_CLK_DIV: This clock is a configurable divider
- * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
- * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
- * @MESON_CLK_PLL: This is a PLL
- */
-enum meson_clk_type {
-	MESON_CLK_ANY = 0,
-	MESON_CLK_GATE,
-	MESON_CLK_MUX,
-	MESON_CLK_DIV,
-	MESON_CLK_FIXED_DIV,
-	MESON_CLK_EXTERNAL,
-	MESON_CLK_PLL,
-};
-
-/**
- * struct meson_clk_info - The parameters defining a clock
- * @name: Name of the clock
- * @parm: Register bits description for muxes and dividers
- * @div: Fixed divider value
- * @parents: List of parent clock IDs
- * @type: Clock type
- */
-struct meson_clk_info {
-	const char *name;
-	union {
-		const struct parm *parm;
-		u8 div;
-	};
-	const unsigned int *parents;
-	const enum meson_clk_type type;
-};
-
-/**
- * struct meson_clk_data - Clocks supported by clock provider
- * @num_clocks: Number of clocks
- * @clocks: Array of clock descriptions
- *
- */
-struct meson_clk_data {
-	const u8 num_clocks;
-	const struct meson_clk_info **clocks;
-};
-
-/* Clock description initialization macros */
-
-/* A multiplexer */
-#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[])__VA_ARGS__,		\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = (_width),				\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_MUX,					\
-	})
-
-/* A divider with an integral divisor */
-#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = (_width),				\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_DIV,					\
-	})
-
-/* A fixed divider */
-#define CLK_DIV_FIXED(_name, _div, _parent)				\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.div = (_div),						\
-		.name = (_name),					\
-		.type = MESON_CLK_FIXED_DIV,				\
-	})
-
-/* An external clock */
-#define CLK_EXTERNAL(_name)						\
-	(&(struct meson_clk_info){					\
-		.name = (_name),					\
-		.parents = (const unsigned int[]) { -ENOENT },		\
-		.type = MESON_CLK_EXTERNAL,				\
-	})
-
-/* A clock gate */
-#define CLK_GATE(_name, _reg, _shift, _parent)				\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = 1,					\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_GATE,					\
-	})
-
-/* A PLL clock */
-#define CLK_PLL(_name, _parent, ...)					\
-	(&(struct meson_clk_info){					\
-		.name = (_name),					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = (const struct parm[])__VA_ARGS__,		\
-		.type = MESON_CLK_PLL,					\
-	})
-
 /* A1 peripherals clocks */
 static const struct meson_clk_info *meson_clocks[] = {
 	[CLKID_SPIFC_SEL] = CLK_MUX("spifc_sel", A1_SPIFC_CLK_CTRL, 9, 2, {
@@ -302,254 +170,6 @@ static const struct meson_clk_info *meson_pll_clocks[] = {
 	),
 };
 
-static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
-						       enum meson_clk_type type)
-{
-	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
-	const struct meson_clk_info *info;
-
-	if (clk->id >= data->num_clocks)
-		return ERR_PTR(-EINVAL);
-
-	info = data->clocks[clk->id];
-	if (!info)
-		return ERR_PTR(-ENOENT);
-
-	if (type != MESON_CLK_ANY && type != info->type)
-		return ERR_PTR(-EINVAL);
-
-	return info;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk);
-
-static int meson_set_gate(struct clk *clk, bool on)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	SET_PARM_VALUE(priv, info->parm, on);
-
-	return 0;
-}
-
-static int meson_clk_enable(struct clk *clk)
-{
-	return meson_set_gate(clk, true);
-}
-
-static int meson_clk_disable(struct clk *clk)
-{
-	return meson_set_gate(clk, false);
-}
-
-static ulong meson_div_get_rate(struct clk *clk)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	u16 n;
-	ulong rate;
-	const struct meson_clk_info *info;
-	struct clk parent;
-
-	info = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	/* Actual divider value is (field value + 1), hence the increment */
-	n = GET_PARM_VALUE(priv, info->parm) + 1;
-
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	rate = meson_clk_get_rate(&parent);
-
-	return rate / n;
-}
-
-static int meson_clk_get_parent(struct clk *clk)
-{
-	uint reg = 0;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	/* For muxes we read currently selected parent from register,
-	 * for other types there is always only one element in parents array.
-	 */
-	if (info->type == MESON_CLK_MUX) {
-		reg = GET_PARM_VALUE(priv, info->parm);
-		if (IS_ERR_VALUE(reg))
-			return reg;
-	}
-
-	return info->parents[reg];
-}
-
-static ulong meson_pll_get_rate(struct clk *clk)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-	const struct parm *pm, *pn;
-	ulong parent_rate_mhz;
-	struct clk parent;
-	u16 n, m;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	pm = &info->parm[0];
-	pn = &info->parm[1];
-
-	n = GET_PARM_VALUE(priv, pn);
-	m = GET_PARM_VALUE(priv, pm);
-
-	if (n == 0)
-		return -EINVAL;
-
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
-
-	return parent_rate_mhz * m / n * 1000000;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk)
-{
-	struct clk parent;
-	const struct meson_clk_info *info;
-
-	if (IS_ERR_VALUE(clk->id))
-		return clk->id;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	switch (info->type) {
-	case MESON_CLK_PLL:
-		return meson_pll_get_rate(clk);
-	case MESON_CLK_GATE:
-	case MESON_CLK_MUX:
-		parent.dev = clk->dev;
-		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent);
-	case MESON_CLK_DIV:
-		return meson_div_get_rate(clk);
-	case MESON_CLK_FIXED_DIV:
-		parent.dev = clk->dev;
-		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent) / info->div;
-	case MESON_CLK_EXTERNAL: {
-		int ret;
-		struct clk external_clk;
-
-		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
-		if (ret)
-			return ret;
-
-		return clk_get_rate(&external_clk);
-	}
-	default:
-		return -EINVAL;
-	}
-}
-
-/* This implements rate propagation for dividers placed after multiplexer:
- *  ---------|\
- *     ..... | |---DIV--
- *  ---------|/
- */
-static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
-{
-	unsigned int i, best_div_val;
-	unsigned long best_delta, best_parent;
-	const struct meson_clk_info *div;
-	const struct meson_clk_info *mux;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	struct clk mux_clk;
-
-	div = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(div))
-		return PTR_ERR(div);
-
-	mux_clk.dev = clk->dev;
-	mux_clk.id = div->parents[0];
-	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
-	if (IS_ERR(mux))
-		return PTR_ERR(mux);
-
-	best_parent = -EINVAL;
-	best_delta = ULONG_MAX;
-	for (i = 0; i < (1 << mux->parm->width); i++) {
-		unsigned long parent_rate, delta;
-		unsigned int div_val;
-		struct clk parent = {
-			.dev = clk->dev,
-			.id =  mux->parents[i],
-		};
-
-		parent_rate = meson_clk_get_rate(&parent);
-		if (IS_ERR_VALUE(parent_rate))
-			continue;
-
-		/* If overflow, try to use max divider value */
-		div_val = min(DIV_ROUND_CLOSEST(parent_rate, rate),
-			      (1UL << div->parm->width));
-
-		delta = abs(rate - (parent_rate / div_val));
-		if (delta < best_delta) {
-			best_delta = delta;
-			best_div_val = div_val;
-			best_parent = i;
-		}
-	}
-
-	if (IS_ERR_VALUE(best_parent))
-		return best_parent;
-
-	SET_PARM_VALUE(priv, mux->parm, best_parent);
-	/* Divider is set to (field value + 1), hence the decrement */
-	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
-
-	return 0;
-}
-
-static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
-{
-	int i;
-	ulong ret = -EINVAL;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_MUX);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	for (i = 0; i < (1 << info->parm->width); i++) {
-		struct clk parent = {
-			.dev = clk->dev,
-			.id = info->parents[i],
-		};
-
-		ret = clk_set_rate(&parent, rate);
-		if (!ret) {
-			SET_PARM_VALUE(priv, info->parm, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-
 /* Rate propagation is implemented for a subcection of a clock tree, that is
  * required at boot stage.
  */
@@ -575,32 +195,6 @@ static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
 	return -EINVAL;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned int i, parent_index;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_MUX);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	parent_index = -EINVAL;
-	for (i = 0; i < (1 << info->parm->width); i++) {
-		if (parent->id == info->parents[i]) {
-			parent_index = i;
-			break;
-		}
-	}
-
-	if (IS_ERR_VALUE(parent_index))
-		return parent_index;
-
-	SET_PARM_VALUE(priv, info->parm, parent_index);
-
-	return 0;
-}
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -630,73 +224,6 @@ static const struct udevice_id meson_clk_ids[] = {
 	{ }
 };
 
-#if IS_ENABLED(CONFIG_CMD_CLK)
-static const char *meson_clk_get_name(struct clk *clk)
-{
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-
-	return IS_ERR(info) ? "unknown" : info->name;
-}
-
-static int meson_clk_dump_single(struct clk *clk)
-{
-	const struct meson_clk_info *info;
-	struct meson_clk *priv;
-	unsigned long rate;
-	char *state, frequency[80];
-	struct clk parent;
-
-	priv = dev_get_priv(clk->dev);
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info) || !info->name)
-		return -EINVAL;
-
-	rate = clk_get_rate(clk);
-	if (IS_ERR_VALUE(rate))
-		sprintf(frequency, "unknown");
-	else
-		sprintf(frequency, "%lu", rate);
-
-	if (info->type == MESON_CLK_GATE)
-		state = GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
-	else
-		state = "N/A";
-
-	parent.dev = clk->dev;
-	parent.id = meson_clk_get_parent(clk);
-	printf("%15s%20s%20s%15s\n",
-	       info->name,
-	       frequency,
-	       meson_clk_get_name(&parent),
-	       state);
-
-	return 0;
-}
-
-static void meson_clk_dump(struct udevice *dev)
-{
-	int i;
-	struct meson_clk_data *data;
-	const char *sep = "--------------------";
-
-	printf("%s:\n", dev->name);
-	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
-	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
-	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
-
-	data = (struct meson_clk_data *)dev_get_driver_data(dev);
-	for (i = 0; i < data->num_clocks; i++) {
-		meson_clk_dump_single(&(struct clk){
-			.dev = dev,
-			.id = i
-		});
-	}
-}
-#endif
-
 static struct clk_ops meson_clk_ops = {
 	.disable	= meson_clk_disable,
 	.enable		= meson_clk_enable,
diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 3215391006e..5f897d89e9b 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -10,10 +10,6 @@
 
 #include "clk_meson.h"
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 #define AO_CLK_GATE0		0x40
 #define AO_SAR_CLK		0x90
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index e20d3feaade..3b5f4af9f4c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -20,10 +20,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
 
 static struct meson_gate gates[] = {
diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
new file mode 100644
index 00000000000..de5aa5ae3c9
--- /dev/null
+++ b/drivers/clk/meson/clk_meson.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+
+#include "clk_meson.h"
+
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
+						       enum meson_clk_type type)
+{
+	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
+	const struct meson_clk_info *info;
+
+	if (clk->id >= data->num_clocks)
+		return ERR_PTR(-EINVAL);
+
+	info = data->clocks[clk->id];
+	if (!info)
+		return ERR_PTR(-ENOENT);
+
+	if (type != MESON_CLK_ANY && type != info->type)
+		return ERR_PTR(-EINVAL);
+
+	return info;
+}
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	SET_PARM_VALUE(priv, info->parm, on);
+
+	return 0;
+}
+
+int meson_clk_enable(struct clk *clk)
+{
+	return meson_set_gate(clk, true);
+}
+
+int meson_clk_disable(struct clk *clk)
+{
+	return meson_set_gate(clk, false);
+}
+
+static ulong meson_div_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	u16 n;
+	ulong rate;
+	const struct meson_clk_info *info;
+	struct clk parent;
+
+	info = meson_clk_get_info(clk, MESON_CLK_DIV);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* Actual divider value is (field value + 1), hence the increment */
+	n = GET_PARM_VALUE(priv, info->parm) + 1;
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	rate = meson_clk_get_rate(&parent);
+
+	return rate / n;
+}
+
+int meson_clk_get_parent(struct clk *clk)
+{
+	uint reg = 0;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* For muxes we read currently selected parent from register,
+	 * for other types there is always only one element in parents array.
+	 */
+	if (info->type == MESON_CLK_MUX) {
+		reg = GET_PARM_VALUE(priv, info->parm);
+		if (IS_ERR_VALUE(reg))
+			return reg;
+	}
+
+	return info->parents[reg];
+}
+
+static ulong meson_pll_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	const struct parm *pm, *pn;
+	ulong parent_rate_mhz;
+	struct clk parent;
+	u16 n, m;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	pm = &info->parm[0];
+	pn = &info->parm[1];
+
+	n = GET_PARM_VALUE(priv, pn);
+	m = GET_PARM_VALUE(priv, pm);
+
+	if (n == 0)
+		return -EINVAL;
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
+
+	return parent_rate_mhz * m / n * 1000000;
+}
+
+ulong meson_clk_get_rate(struct clk *clk)
+{
+	struct clk parent;
+	const struct meson_clk_info *info;
+
+	if (IS_ERR_VALUE(clk->id))
+		return clk->id;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	switch (info->type) {
+	case MESON_CLK_PLL:
+		return meson_pll_get_rate(clk);
+	case MESON_CLK_GATE:
+	case MESON_CLK_MUX:
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent);
+	case MESON_CLK_DIV:
+		return meson_div_get_rate(clk);
+	case MESON_CLK_FIXED_DIV:
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent) / info->div;
+	case MESON_CLK_EXTERNAL: {
+		int ret;
+		struct clk external_clk;
+
+		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
+		if (ret)
+			return ret;
+
+		return clk_get_rate(&external_clk);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+/* This implements rate propagation for dividers placed after multiplexer:
+ *  ---------|\
+ *     ..... | |---DIV--
+ *  ---------|/
+ */
+ulong meson_composite_set_rate(struct clk *clk, ulong rate)
+{
+	unsigned int i, best_div_val;
+	unsigned long best_delta, best_parent;
+	const struct meson_clk_info *div;
+	const struct meson_clk_info *mux;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct clk mux_clk;
+
+	div = meson_clk_get_info(clk, MESON_CLK_DIV);
+	if (IS_ERR(div))
+		return PTR_ERR(div);
+
+	mux_clk.dev = clk->dev;
+	mux_clk.id = div->parents[0];
+	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
+	if (IS_ERR(mux))
+		return PTR_ERR(mux);
+
+	best_parent = -EINVAL;
+	best_delta = ULONG_MAX;
+	for (i = 0; i < (1 << mux->parm->width); i++) {
+		unsigned long parent_rate, delta;
+		unsigned int div_val;
+		struct clk parent = {
+			.dev = clk->dev,
+			.id =  mux->parents[i],
+		};
+
+		parent_rate = meson_clk_get_rate(&parent);
+		if (IS_ERR_VALUE(parent_rate))
+			continue;
+
+		/* If overflow, try to use max divider value */
+		div_val = min(DIV_ROUND_CLOSEST(parent_rate, rate),
+			      (1UL << div->parm->width));
+
+		delta = abs(rate - (parent_rate / div_val));
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_div_val = div_val;
+			best_parent = i;
+		}
+	}
+
+	if (IS_ERR_VALUE(best_parent))
+		return best_parent;
+
+	SET_PARM_VALUE(priv, mux->parm, best_parent);
+	/* Divider is set to (field value + 1), hence the decrement */
+	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
+
+	return 0;
+}
+
+ulong meson_mux_set_rate(struct clk *clk, ulong rate)
+{
+	int i;
+	ulong ret = -EINVAL;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = info->parents[i],
+		};
+
+		ret = clk_set_rate(&parent, rate);
+		if (!ret) {
+			SET_PARM_VALUE(priv, info->parm, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned int i, parent_index;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	parent_index = -EINVAL;
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		if (parent->id == info->parents[i]) {
+			parent_index = i;
+			break;
+		}
+	}
+
+	if (IS_ERR_VALUE(parent_index))
+		return parent_index;
+
+	SET_PARM_VALUE(priv, info->parm, parent_index);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static const char *meson_clk_get_name(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+
+	return IS_ERR(info) ? "unknown" : info->name;
+}
+
+static int meson_clk_dump_single(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+	struct meson_clk *priv;
+	unsigned long rate;
+	char *state, frequency[80];
+	struct clk parent;
+
+	priv = dev_get_priv(clk->dev);
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info) || !info->name)
+		return -EINVAL;
+
+	rate = clk_get_rate(clk);
+	if (IS_ERR_VALUE(rate))
+		sprintf(frequency, "unknown");
+	else
+		sprintf(frequency, "%lu", rate);
+
+	if (info->type == MESON_CLK_GATE)
+		state = GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
+	else
+		state = "N/A";
+
+	parent.dev = clk->dev;
+	parent.id = meson_clk_get_parent(clk);
+	printf("%15s%20s%20s%15s\n",
+	       info->name,
+	       frequency,
+	       meson_clk_get_name(&parent),
+	       state);
+
+	return 0;
+}
+
+void meson_clk_dump(struct udevice *dev)
+{
+	int i;
+	struct meson_clk_data *data;
+	const char *sep = "--------------------";
+
+	printf("%s:\n", dev->name);
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+
+	data = (struct meson_clk_data *)dev_get_driver_data(dev);
+	for (i = 0; i < data->num_clocks; i++) {
+		meson_clk_dump_single(&(struct clk){
+			.dev = dev,
+			.id = i
+		});
+	}
+}
+#endif
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index ef72a416c15..990e9434126 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -39,10 +39,153 @@ struct parm {
 #define PARM_SET(width, shift, reg, val)                                \
 	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
 
+#define SET_PARM_VALUE(_priv, _parm, _val)				\
+	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
+			   SETPMASK((_parm)->width, (_parm)->shift),	\
+			   (_val) << (_parm)->shift)
+
+#define GET_PARM_VALUE(_priv, _parm)					\
+({									\
+	uint _reg;							\
+	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
+	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
+})
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+/**
+ * enum meson_clk_type - The type of clock
+ * @MESON_CLK_ANY: Special value that matches any clock type
+ * @MESON_CLK_GATE: This clock is a gate
+ * @MESON_CLK_MUX: This clock is a multiplexer
+ * @MESON_CLK_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
+ * @MESON_CLK_PLL: This is a PLL
+ */
+enum meson_clk_type {
+	MESON_CLK_ANY = 0,
+	MESON_CLK_GATE,
+	MESON_CLK_MUX,
+	MESON_CLK_DIV,
+	MESON_CLK_FIXED_DIV,
+	MESON_CLK_EXTERNAL,
+	MESON_CLK_PLL,
+};
+
+/**
+ * struct meson_clk_info - The parameters defining a clock
+ * @name: Name of the clock
+ * @parm: Register bits description for muxes and dividers
+ * @div: Fixed divider value
+ * @parents: List of parent clock IDs
+ * @type: Clock type
+ */
+struct meson_clk_info {
+	const char *name;
+	union {
+		const struct parm *parm;
+		u8 div;
+	};
+	const unsigned int *parents;
+	const enum meson_clk_type type;
+};
+
+/**
+ * struct meson_clk_data - Clocks supported by clock provider
+ * @num_clocks: Number of clocks
+ * @clocks: Array of clock descriptions
+ *
+ */
+struct meson_clk_data {
+	const u8 num_clocks;
+	const struct meson_clk_info **clocks;
+};
+
+/* Clock description initialization macros */
+
+/* A multiplexer */
+#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[])__VA_ARGS__,		\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_MUX,					\
+	})
+
+/* A divider with an integral divisor */
+#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_DIV,					\
+	})
+
+/* A fixed divider */
+#define CLK_DIV_FIXED(_name, _div, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.div = (_div),						\
+		.name = (_name),					\
+		.type = MESON_CLK_FIXED_DIV,				\
+	})
+
+/* An external clock */
+#define CLK_EXTERNAL(_name)						\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { -ENOENT },		\
+		.type = MESON_CLK_EXTERNAL,				\
+	})
+
+/* A clock gate */
+#define CLK_GATE(_name, _reg, _shift, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = 1,					\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_GATE,					\
+	})
+
+/* A PLL clock */
+#define CLK_PLL(_name, _parent, ...)					\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = (const struct parm[])__VA_ARGS__,		\
+		.type = MESON_CLK_PLL,					\
+	})
+
 /* MPLL Parameters */
 
 #define SDM_DEN 16384
 #define N2_MIN  4
 #define N2_MAX  511
 
+int meson_clk_enable(struct clk *clk);
+int meson_clk_disable(struct clk *clk);
+int meson_clk_get_parent(struct clk *clk);
+ulong meson_clk_get_rate(struct clk *clk);
+ulong meson_composite_set_rate(struct clk *clk, ulong rate);
+ulong meson_mux_set_rate(struct clk *clk, ulong rate);
+int meson_clk_set_parent(struct clk *clk, struct clk *parent);
+#if IS_ENABLED(CONFIG_CMD_CLK)
+void meson_clk_dump(struct udevice *dev);
+#endif
+
 #endif
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index e89638d65b5..d9425f900f3 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -10,10 +10,6 @@
 
 #include "clk_meson.h"
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 #define AO_CLK_GATE0		0x4c
 #define AO_SAR_CLK		0x90
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index cc7bfe9e2a2..b1ba5881904 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -91,10 +91,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
 static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 24b5f9b5d40..62c1e0eed4f 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -70,10 +70,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
 static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
-- 
2.53.0


