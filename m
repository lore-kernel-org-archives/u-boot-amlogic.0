Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD90CA5FB6
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2893.1790705251621054937
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=aE/jS/vE;
 spf=pass (domain: brivo.com, ip: 74.125.230.233, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c59695cc9so302297485a.3
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705250; x=1791310050; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
        b=aE/jS/vEwgVQ+eFn2ANDB3LXrzR/Nv/xTP27okjplQ/WOBHhU3mmBHnF3W6FdBvNU2
         HzeY2OJDYL7VNxuomLZARKeDIXewNkI/Tyx756UStI4Lipq5wMKRMBfYwn978TYd0Yit
         3LJON/p1Q2sl8FF8z0IN36+8uVoYnMZczT2o1NdearaDWL13xtVjypgb2Z1v32Fon98r
         R5eZv4fgz5O0Av5jzfqhmd2MLUa//7J+UwW8K/tuqSrj5p9q1XTLPxae0GIi8CAqK+JG
         woLl/HkTmL4hCU7rJi7DqTf1NCTLOUG/7Y/E3dTWzU5mYDfVd3NDdf7GgfZF5dlF1Geq
         CJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705250; x=1791310050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGonT6puGsHevu+WwQyWxkFstkTKf/kDVp9AMZCoCAQ=;
        b=hSVs7Yi3uKhawauQ57sjGhYno/4ekdAAbWEGsrw3JCzt7NfQIvZpiJ3GFv9rXwm+Cq
         M0e3y8crduC+cDejGwDbDDN4IcBGNPeCUg1zAMP38pJrgTMoxWpwtYBIv43dEpdtBNug
         zA7ccrfcjwdzFIjP3gZ6QCoAS4AoQ1Vcqilh6tbnjevX8LNO+XQpFktvSrQ4/Sy4P+z8
         uCPCUAjT7zDUU23G9okSHvsit3lc9dNn7lYpWhtr5idMSLUzGILn2rNBecGpu6QRFhKQ
         1axSQl8McrMVRGlfhU0YraG0jZdo6p7lGRou54n4IdXKpl1TJDVcsHQECSljSusPd1QR
         j/0w==
X-Gm-Message-State: AFuF++l8hHx3iVeAG0+wTxA3oKwBCCHTRjAZDqJfB4+0SzLp+GqJd6yn
	DKGlV/3Gbvl4VKORmBTnxFJbJrgoGfyKFqS6tmASGBdzbu5TUbp+9yOGummWs4mxSHvW9WOFt3u
	ZWxODXfHoFQTB2tDV6kTqyGnZZZDP0H+TbpkQH6oiy2Os2kxHcSQSWA==
X-Gm-Gg: AYBFou36xdwWNJRtDSTDGtmOhbgqQ1WSN6sMkBTzIvtUZQZFKMfSWQ4zMuWRs9uAZxH
	EQpn7cWh06c1sLrL5TXSrpTfYCu23XNFs3oD8cAE58528uDkTHKEzIxRuyJdGJdiGLZiLjrKiMq
	pF5r+Im+MU7JGYBRFRnLlWbKyfhgpuFT8VzJjD7NxSp+usXqqGbtaEDnrlyh/+Fryfi8VrIqpVX
	rQxwIoBxgwJraNmAnBYJrTR1WpJrbvlWmKUstEOK740c8iLfqfmnacCSboQGUREGswTuqGULFio
	tH6btGk93f13F/ZZ5wJgO6iYluhJ/0u7+aCq+ccv4F7o3FPPzR0xm7bhNrgcVcHcooJNXJvGzxb
	E07+NQN0EQ+xjUhKZuO70cG9ft6sZ6TQZ4hgbGhy/xqeJFC4F2NYhLY3mXNont+w5WvW1ARF/lv
	+oHQFEyKzKe7y589CKs9+mmZOaG+ht0q+ud7pe/ge5gf/jiOSYBhKVk+xy8BsrcD0k
X-Received: by 2002:a05:620a:a487:b0:93a:1e5d:9aa3 with SMTP id af79cd13be357-93c9f937d1dmr54777085a.6.1790705250255;
        Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 7/9] clk: meson: Support power-of-two dividers
Date: Tue, 29 Sep 2026 14:06:29 -0400
Message-ID: <20260929180721.3440839-8-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3110

Several s4 clocks use power-of-two dividers. Add support for them.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

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


