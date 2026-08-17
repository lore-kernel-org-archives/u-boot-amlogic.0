Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404D6C61DC2
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69.1786986991469626257
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=SGdV+HcW;
 spf=pass (domain: brivo.com, ip: 209.85.219.51, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efec2c28f8so20996306d6.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986990; x=1787591790; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXAJB/gHjpHBMzuGyk1RJrUOlorMTAMSCKjzBrMWZK0=;
        b=SGdV+HcWm9yxAajmfXPrTK1WeZ3Pvy4YqWnZ8U2aOSivLIUK2cFt6hO3S00GeB7LjN
         Wb/5+XRcoFj033tecTNIEgSFbBOTg5UlkwID5fPOpFAfAUqp6Mqedva2kc+a887IhuJm
         rmoZ/Wrqy3OpWv9UQsvTXTIOUSK8lfYoBMkE05Adbv7bzsEMCW9un0T25YsBkhzcb/FP
         Zh/x5yFh3ImLyEhJBouOgppKYZKiKOjibVkENZxSAL7CcY/rQn9Rwz55DkK0iUx4cWeP
         1pyN9MCXCkG61y+HhPenHtzfenDJRedAz9sok0KITtob6MFzh9XrkuldOGh/4MQhh51M
         Ljzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986990; x=1787591790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kXAJB/gHjpHBMzuGyk1RJrUOlorMTAMSCKjzBrMWZK0=;
        b=sogQvU17WSjg2uAXHUhHUMrDiI6zmfKrAFIN8Jb1FHuS4ULqo6BmetRTm7+jRdSiCD
         wkAAzUzXzBHCvYlWkWMFY+NiMR6xzpUCrms1L3u2t7SevniF4Q1Phdf8yHWk8ky8PLCQ
         HJJRf94vSo9bMUGaaGvmig3ip7Sdhc9VKlaeo+fzGPNjZNQCoizX/dfiHnjtTck3WAO0
         4QmQgq7hwatNTlrmcDUsxx3OFjIs54/ejZ8/LmaJLLb1dDclaPhjy2vFZxf2s+MVJaTL
         Yln9sJRlI6QXZXLMkZoQXqfGeajIXOG/BLNhhC7xsW3QyZZufM/5MP4Q7M0dybxI5L+U
         OhzA==
X-Gm-Message-State: AOJu0YwxOjl13zNRyU8XLrK/5Ufj8FDDNM/cExe5vs5INKiRMP9RDL6E
	CBQ4Cmsb7nQTT+rQqNYzUMK0MdRZsjtUfgm3e3H5vVuDFS7IXUFwbgI0EUjoIkYxWDztK2poUYX
	2wpsNuxXWfXVYYJcO3wMSDGr16yZTV8XVpPurRLVq+0sYLAjSEHSTc1UEEWjiCV0P4arZbg==
X-Gm-Gg: AR+sD12ittZEZWQTSgrxKMp+5CL5Zpk7Np/w9xrexR+z2XoY4E3GlLyOiRiZXqKnLyb
	2Kq2IyXoSYG/K8+Nj/lTwAFtW/HHnGE4a0bsPpN1FQDx3WG/Zq1XJ57oTH2jDu0Qz+6+Ltt1RA6
	JEDE1PyaQkwTkge9sWFae4Z90dx1jy6gynyLiKh6KAnZTYAZRO464KEB9LEVAM7M5R5/4Zxy4lE
	Fk+GmISx0bWT6406LZcSB0E5o7k8OIZJ1/WJZ5skoUvy4A/Gb2BMAhT4ro8QDH2zeNH/Jy2z1l9
	f+lYGK6wPVNYclwE8swWelbFHlXA9foR1DaaIZk6KfjjY8BlyIZwo4DRshBgQrdcacoW/8vWV3E
	NcqiDTlUUulaeD9AncwrOI8VINyLw+oEpSRz6JR3sxSmt333Q4806i1L8cAOQhuW6wFD51Aem1u
	5mzQgqlusDa/9YSf79rX/ZsaizTPGdoypqEfIlJSDi3x0AqRU6VPxX7AvN1H9z/qIIa490sMy6B
	y81zIMvyZowKl2I6ltNiQGSjATmZ/NxhdeA8kY=
X-Received: by 2002:ac8:5cd1:0:b0:52d:6c37:6853 with SMTP id d75a77b69052e-52d85354689mr309389491cf.16.1786986989770;
        Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 5/9] clk: meson: Export a1 functions to common file
Date: Mon, 17 Aug 2026 13:15:16 -0400
Message-ID: <20260817171623.1943847-6-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3039

Export several useful functions from a1 to a common file. These will be
used for s4 support.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

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


