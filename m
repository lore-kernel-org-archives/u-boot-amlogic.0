Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09645C61DB4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.70.1786986991869451156
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=HyDdk+Rq;
 spf=pass (domain: brivo.com, ip: 209.85.222.177, mailfrom: sanderson@brivo.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9349ad9c857so370020385a.1
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986991; x=1787591791; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTKvYffvh/OKCJVMRt5IAEMDDvgNu0n/2vPjP9Y2kPI=;
        b=HyDdk+RqoEcknf0xU+IfocHUGGiiLPNujtlH2FUeV8CupnUVoI/uc7urJL1z7nSlhS
         y8J1SGaRYL5jvpipl9CvZmTgf6X9aROXMfpDp69XQRPX/PZ23+2XFJU55OP7Nj7QuxSX
         ZLQhiK9gPK8co+8RhppopHVkpJrR2rX1NyFAaXqS5zxVsUw5YAng9Lhd/tbOXVqhfGId
         cthE+MvK9feqUf4evaaqfe/MXBqYZ3N3ZKfu9K+OMzUnvCSQ1B8fOrzVR8nu/7mt/H4W
         WjRYXsDvYh8Sy4uTmoLJkNITEh2BPhZhxIC/wWhFWZdATCEXn6D4lNA7sDWY7BBBnElm
         uBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986991; x=1787591791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTKvYffvh/OKCJVMRt5IAEMDDvgNu0n/2vPjP9Y2kPI=;
        b=iksQT8RXj3wpkWUMB7s6YdEFkYn/BIGIR9YMmZBC8NW+LLR9VBmfr3q/ZlYw6fXMQK
         +cQtlPWJqZAvnklBrb5lvhhYeYgdQmDjD8+fzwQrg6kLRdUf8skB834cgG1uaGYQ4SAJ
         n5xJgfdxuRjDyJ/sYgDTopUHCr/pDFP+KHHguuqxrJQZFFh9IlpCc50pRjcbwaey/iwu
         wIzqt9sJn2+OzKSx7WeGDPVS5hGOf0qfed9VIe8SIy+kdPjDvGHiXgcfxh8yG99JsqmQ
         fax5ieiLwzrWncrRufS3/NVmiTKwpoFpWeeSNyTdhHcuZsoaCBDmh/yp+8S9A4zGLHqC
         9JXg==
X-Gm-Message-State: AOJu0YzO3oPk0+SsnJCfAgFYkln22LOy60+YC7BtziznD52LEwZj15nj
	Ej4W91VIWkglDvexhiHl0hIQNi/LBUi2pkkijjJtT97a+bo4GtGpIzcPvhqO40tnbeJNpDhde4/
	r3XNpzQRatlJa623HBvDNJ62lDBlxGan/ouniMEw9ynmQHx0D+HN1rg==
X-Gm-Gg: AR+sD13tl6HitMeUp0ol7VsP5LXzIEQPXtzidg/pdIaCYMluN5N1QNtO7TeVH/LZk5v
	v1D1+Y6RQhFpBHANAKmoBRTZImW/ByI5C/iaDN8OCIaFTjZD3az7fGjyIUcgsSDhYUc2KFPyqAo
	t4EAG6Dfq2LwQe3D2qqRPp+1JZUPKSbV0FEEAXynqdOnmWOzQ6GTnBHViwwSf1o48QxbYZ+laVJ
	xgPrqGVwuAOuVu+gVhHAX4ObPEZvyVtSc9dXCQ+zgKfRRPCHCS6pumW3uBWcqZ6FBImBku3rHnK
	jd+ZnewNkQPS9ywRNfabclCPI3gxKvuo/0zh+xqsSecahNse0QcTZVDVVRcjOKCTcvWO8X5rKeK
	tCAx06eU5i+Ct4Rg6eWTIkbiaXg72+jZ234H6Thr6Y4Ht8z6UhtTuSJDeqgFvHFoKj36L8YEiNv
	eZQQ1mmmHwKwDw+rGd592H3s1dbSGGPAnFUUs1XxTV3p73nFOPmiOO9LqqnMHqylxqLV7GrhUjd
	EkydB2CWQE98Lddr7kkVoc02kI=
X-Received: by 2002:a05:620a:a48e:b0:934:81ae:6d1b with SMTP id af79cd13be357-936d22ce40bmr1826604385a.22.1786986990522;
        Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 6/9] clk: meson: Support fractional fixed-factor clocks
Date: Mon, 17 Aug 2026 13:15:17 -0400
Message-ID: <20260817171623.1943847-7-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3041

One of the s4 clocks has a non-integer divisor (2.5). Add support for
this.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/clk_meson.c |  3 ++-
 drivers/clk/meson/clk_meson.h | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
index de5aa5ae3c9..29615fdae77 100644
--- a/drivers/clk/meson/clk_meson.c
+++ b/drivers/clk/meson/clk_meson.c
@@ -153,7 +153,8 @@ ulong meson_clk_get_rate(struct clk *clk)
 	case MESON_CLK_FIXED_DIV:
 		parent.dev = clk->dev;
 		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent) / info->div;
+		return mult_frac(meson_clk_get_rate(&parent), info->mult,
+				 info->div);
 	case MESON_CLK_EXTERNAL: {
 		int ret;
 		struct clk external_clk;
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index 990e9434126..86b272985ab 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -61,7 +61,7 @@ struct meson_clk {
  * @MESON_CLK_GATE: This clock is a gate
  * @MESON_CLK_MUX: This clock is a multiplexer
  * @MESON_CLK_DIV: This clock is a configurable divider
- * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
  * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
  * @MESON_CLK_PLL: This is a PLL
  */
@@ -87,7 +87,10 @@ struct meson_clk_info {
 	const char *name;
 	union {
 		const struct parm *parm;
-		u8 div;
+		struct {
+			u8 mult;
+			u8 div;
+		};
 	};
 	const unsigned int *parents;
 	const enum meson_clk_type type;
@@ -133,13 +136,16 @@ struct meson_clk_data {
 	})
 
 /* A fixed divider */
-#define CLK_DIV_FIXED(_name, _div, _parent)				\
+#define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
 	(&(struct meson_clk_info){					\
 		.parents = (const unsigned int[]) { (_parent) },	\
+		.mult = (_mult),					\
 		.div = (_div),						\
 		.name = (_name),					\
 		.type = MESON_CLK_FIXED_DIV,				\
 	})
+#define CLK_DIV_FIXED(name, div, parent)				\
+	CLK_DIV_FIXED_FULL(name, 1, div, parent)
 
 /* An external clock */
 #define CLK_EXTERNAL(_name)						\
-- 
2.53.0


