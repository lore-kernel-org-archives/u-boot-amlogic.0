Return-Path: <sanderson@brivo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E2CA5FB8
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 18:07:35 +0000 (UTC)
Received: from mail-qk2-f26.google.com (mail-qk2-f26.google.com [74.125.230.218])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2890.1790705250521733626
 for <u-boot-amlogic@groups.io>;
 Tue, 29 Sep 2026 11:07:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=EPb4KVaK;
 spf=pass (domain: brivo.com, ip: 74.125.230.218, mailfrom: sanderson@brivo.com)
Received: by mail-qk2-f26.google.com with SMTP id af79cd13be357-93a0299c787so274081085a.1
        for <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790705249; x=1791310049; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
        b=EPb4KVaKcw38y4Ftas5jR2CbObr3ZPYrRLpct/9O+kaQYt3taUD+E3S7uuVWut3dC5
         5B/ulRMN+VKyGgkBsFkx7SVAno7AU5O8EjJiuxOrRI6wh4yqOA8BcOMZxTHNA7+JOwKK
         XXcQLJ82yeapU9Y/Ywff+NwJbtLUbev0WCMb9++opgHKXbRNgRn3m1iapU/sexJOVZ6M
         FBlzn7qQ5YuOfMNdpb6dj9pqdtaXI71cjL3lWSejDn2BghruloxdbjDd7Qguy49D3eZU
         y6i2rAg5dsnKH54k5Q3lu0KF+Z+yEU7kzfx1UOGowGBAzkHafSYWqybLL9vEZR19ikGx
         ixTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790705249; x=1791310049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
        b=xFCQTBb9YHGGgQj945evFY+KztlOIbJCnkqBhdNuLMKN1b6ru30b/dX/oRPFXfzvue
         0Vb4nyslM6lN84yz7jM7HyXRjU6SSILRKJ+phh8hRlxYAPihtADYDIMjKXvby1VAwHkf
         QOUuFXlb0KM8Rk0109bZGohmQN0TWQhSQCDZ6Ba5IWfRHjl5R3Kxi/ixyqCJvYoYa/Ts
         9SzDxjk0fctp3J93CxPNiWIbKsk8/ssuVh19Cwxlp52vzvmXZZts6/Ipn3X7+X1FdtGE
         3NpxISYYtxHSgafJ4+LwNBBh55yOhUbQm5ycssWEPyAPLk8RDt9kX/ugBISGWywbVkjo
         pouA==
X-Gm-Message-State: AFuF++lhPR6kIiMmxyd+Kj/tCQVJR3hKiGxavekXVcjV9qRCTMyeTJDp
	RLR1LfkmWKGW6Zsea5tdIzX8AAXECpMmDMHyHSbLFktvlgHqrz2ReR3MrQLoSXyAs7Oko2wax+c
	sz0ZyVeihVGNuVMxvNHcEzK2ETMmWuGkAGKw1wYeYvdhmoO2oEQp6ppjKpHZs11D5xHUOjw==
X-Gm-Gg: AYBFou3pN6x8SbNcwWiBfUR/cI8qz0cqowS95njZi1SJGvnd/WgEtaUswxGUixQbBBP
	G/m47cN07h4HxAWqknBI1LVTOxw4TyLnmPEzx6yncCAb+3bKXDCJG+84kLzjurz8Wm+seoeBrJQ
	mCKl+2lAOjOzzsmb8vONtFDtvvSrIzIGEuBClEGeFzLkZNehildD6E0S8oTWx4u+XxZvOuhi1cd
	4ySYHXHgxGgE9wS3jHoYjBXfmcj802dzY19pujYy2lylpoEOecfWEFLVAoG3a08dhVixmjKT9P3
	eK11gGDoHmxrvMI0PrSCkmw/wumLV7mMZygwky/67H9+e2pt9ynht9dCUNWPFjgkdyWA91odokw
	SnsdNDaoALbWjNacMyHzMRd5kd2cu0fEvT1MJwsMq1VlT8gcGNeFAZsizE378lSIPZLbdVVH4xB
	JO9SUzahs+uVxAR8EwLabwbyQ8ap+12q22ZVMuU13wNJt4h/0xSmMXJIP2gJned4ez
X-Received: by 2002:a05:620a:1728:b0:93c:65f2:7d63 with SMTP id af79cd13be357-93c9fa23772mr66834885a.31.1790705249285;
        Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
Received: from strozzi ([71.163.254.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 6/9] clk: meson: Support fractional fixed-factor clocks
Date: Tue, 29 Sep 2026 14:06:28 -0400
Message-ID: <20260929180721.3440839-7-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 29 Sep 2026 18:07:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3109

One of the s4 clocks has a non-integer divisor (2.5). Add support for
this.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

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


