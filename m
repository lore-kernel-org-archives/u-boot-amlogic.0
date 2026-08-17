Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B4C5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71.1786986992555873469
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=i3SBG2+w;
 spf=pass (domain: brivo.com, ip: 209.85.160.180, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c2a818fc4so24471591cf.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986991; x=1787591791; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBptooIT71p8XPgjRHWsM8DUnJuwyX8ZHKSSQYgHXAc=;
        b=i3SBG2+wJF9ewe7jBKE9w44DhB4PrT6f+W6u3Xi20WytKYL/+CHag8R8jvk7FiA2nP
         K/4iT7z8wrpLl5pteGAF1YtuDkjTdbBM1BYtEZWIYgzuLT7jt8aeendxsYG7c1r5lwsz
         adiDI2965eSfQxySWFgkJFLZS0dimuOymeJCg6VflBjW6gPBq4oOk3/6pGv35x0H5L2+
         eUPqWtP5HN8Z0iA8TC22OBPRKRfoZfaw7opy1yqOTNzxwW+4x0PzVPpYY+OH1az1/zdP
         C+y5t40WvD4WUuCdbrR0X9y0MjBp4CPMNsTPN/Uk763o+wBovMDe9UByf/4NDP9WD/3i
         5Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986991; x=1787591791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eBptooIT71p8XPgjRHWsM8DUnJuwyX8ZHKSSQYgHXAc=;
        b=WbtGu93RxYduE9mdqP7VJl6Y8gN9plEvPzjMKArM+adX2hp/EhneXwl1ScBO9X5ETO
         bI4fLbzikHvcUfOmlBay1sNeHRraRvsvUdeU9utQTLKp5djFHaVr6LYwWZHTBBU8E0jc
         j4qW79qPH0B1CTZweBwVdP0ECqtfv8ZfOf5QAEyZpUM79YdsdtxxpKZTHGAWuUFSKIOq
         kpgqlZxXbNloim0xTbYzESxiG2hLCW4aFMigAA8kug7VogpJf4cXUnLtd9gSKUunw8EA
         ZoriBfQBG6TDUdv7LCuL5bb/a7ywMtJTZXofQMjUvGjEbSvM6qIWAhcLrZexDwjzITNo
         prLA==
X-Gm-Message-State: AOJu0Yx+Kjh5/yw5cFAWNEWPceonu1ftudI2nrKdsE1AaDtHycO1/T1Q
	vZzdn2bbXQEpB4ODk/WZFHODgVHrhFUHA3uGHKuNNVvfn7C1HLpcM7W5S9p/IweatV+uMbk/iVp
	ZHnVIm4cA/9t3JYER9tOu3+htybJEjsRBM9bUhSHzyVdarlBWJV4qVw==
X-Gm-Gg: AR+sD10JZzvIOnNIJxxDO3V2ywbSfBZWontoPxvdBIkz7RDWXb6YVQ55LeJldyQZ/Xn
	g0FWcXdXSkN+D/A0aA9oseFoYzilurcXljCIzpglm7YLlOl2xHPYxTeH0zUZm7la/IbMzjUgNkA
	PNCJvjvR5oL8np/NLnow9g0ZusemC1hWUp7UhROSlpECWqVDLyBZ0z0kDT/Oqn7vI9yW43DJqIk
	t68cH3ruqsz4Fq+PKiWnlisJCkSqI5fzRUB1mqyitGUHQzdj5wSmeT2DWdZcms0Xg6HdkMMSTv0
	9k83e6Rkv7gZREYJoPViMtDWQ91x7VOSXYq44lDBqsDRxDIfwI4UZ7bbXm7mURK+uB/+38MWmXk
	pU9Izv3ESc0hA0X/pCuFBuLfWX3j19Jbv9qMl4aVIKeo2OJuAV4TZNgYgJLRjy5Af7VJ7j+kO2l
	kKomsYcf/NGFwTWOzf/Mzogt5xa5ShmU7wSIVKBJedRNuzyiB722LLPa+/rsMW5Mv5u9vCn+iL8
	MYMU6bciT1MbI4mZWMGK1luzQ8=
X-Received: by 2002:a05:622a:550e:b0:51c:857f:9c12 with SMTP id d75a77b69052e-52d8530dca8mr305010891cf.4.1786986991245;
        Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 7/9] clk: meson: Support power-of-two dividers
Date: Mon, 17 Aug 2026 13:15:18 -0400
Message-ID: <20260817171623.1943847-8-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3042

Several s4 clocks use power-of-two dividers. Add support for them.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/clk_meson.c | 49 ++++++++++++++++++++++++++---------
 drivers/clk/meson/clk_meson.h | 44 +++++++++++++++----------------
 2 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
index 29615fdae77..50c72276457 100644
--- a/drivers/clk/meson/clk_meson.c
+++ b/drivers/clk/meson/clk_meson.c
@@ -55,26 +55,49 @@ int meson_clk_disable(struct clk *clk)
 	return meson_set_gate(clk, false);
 }
 
+static ulong meson_div_get_rate_common(struct clk *clk,
+				       enum meson_clk_type type, u16 *n,
+				       ulong *rate)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	struct clk parent;
+
+	info = meson_clk_get_info(clk, type);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	*n = GET_PARM_VALUE(priv, info->parm);
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	*rate = meson_clk_get_rate(&parent);
+	return 0;
+}
+
 static ulong meson_div_get_rate(struct clk *clk)
 {
-	struct meson_clk *priv = dev_get_priv(clk->dev);
+	ulong rate, err;
 	u16 n;
-	ulong rate;
-	const struct meson_clk_info *info;
-	struct clk parent;
 
-	info = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
+	err = meson_div_get_rate_common(clk, MESON_CLK_DIV, &n, &rate);
+	if (err)
+		return err;
 
 	/* Actual divider value is (field value + 1), hence the increment */
-	n = GET_PARM_VALUE(priv, info->parm) + 1;
+	return rate / (n + 1);
+}
 
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	rate = meson_clk_get_rate(&parent);
+static ulong meson_div2_get_rate(struct clk *clk)
+{
+	ulong rate, err;
+	u16 n;
 
-	return rate / n;
+	err = meson_div_get_rate_common(clk, MESON_CLK_DIV2, &n, &rate);
+	if (err)
+		return err;
+
+	return rate >> n;
 }
 
 int meson_clk_get_parent(struct clk *clk)
@@ -150,6 +173,8 @@ ulong meson_clk_get_rate(struct clk *clk)
 		return meson_clk_get_rate(&parent);
 	case MESON_CLK_DIV:
 		return meson_div_get_rate(clk);
+	case MESON_CLK_DIV2:
+		return meson_div2_get_rate(clk);
 	case MESON_CLK_FIXED_DIV:
 		parent.dev = clk->dev;
 		parent.id = meson_clk_get_parent(clk);
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index 86b272985ab..46ee5519410 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -61,6 +61,7 @@ struct meson_clk {
  * @MESON_CLK_GATE: This clock is a gate
  * @MESON_CLK_MUX: This clock is a multiplexer
  * @MESON_CLK_DIV: This clock is a configurable divider
+ * @MESON_CLK_DIV2: This clock is a configurable power-of-two divider
  * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
  * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
  * @MESON_CLK_PLL: This is a PLL
@@ -70,6 +71,7 @@ enum meson_clk_type {
 	MESON_CLK_GATE,
 	MESON_CLK_MUX,
 	MESON_CLK_DIV,
+	MESON_CLK_DIV2,
 	MESON_CLK_FIXED_DIV,
 	MESON_CLK_EXTERNAL,
 	MESON_CLK_PLL,
@@ -122,18 +124,25 @@ struct meson_clk_data {
 		.type = MESON_CLK_MUX,					\
 	})
 
+#define _CLK_REG(_type, _name, _reg, _shift, _width, _parent)		\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = _type,						\
+	})
+
 /* A divider with an integral divisor */
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
+#define CLK_DIV(name, reg, shift, width, parent)			\
+	_CLK_REG(MESON_CLK_DIV, name, reg, shift, width, parent)
+
+/* A divider with a power-of-two divisor */
+#define CLK_DIV2(name, reg, shift, width, parent)			\
+	_CLK_REG(MESON_CLK_DIV2, name, reg, shift, width, parent)
 
 /* A fixed divider */
 #define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
@@ -156,17 +165,8 @@ struct meson_clk_data {
 	})
 
 /* A clock gate */
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
+#define CLK_GATE(name, reg, shift, parent)				\
+	_CLK_REG(MESON_CLK_GATE, name, reg, shift, 1, parent)
 
 /* A PLL clock */
 #define CLK_PLL(_name, _parent, ...)					\
-- 
2.53.0


