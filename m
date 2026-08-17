Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F9AC61DB7
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:25 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35057.1786984672576965318
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 09:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=LvPFbiby;
 spf=pass (domain: brivo.com, ip: 209.85.219.44, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90a92f5000aso31003476d6.1
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786984671; x=1787589471; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hDoyXp3E5ydoXZqHrsd62dl6LpOZQ19HdygnsWau0U=;
        b=LvPFbibywPndsF0u/hadsrIF61Wq4mHVOzVLO32ZTmnue+kPob8NLMxOdvyxKq21By
         tExu1MSLTN/pZ3fHP0kD1dyOD3m81bUZjTAtvY1h0fcDEDuDRvjjNHa2LRaooEHP37Wd
         1cMzbzRq9DG5M+dNMxDO9KWvfF2r91+HcFjTRWZC+xjUaXqk2cdRQA7LAmAwfUOydWon
         UV1b4zX7EtSVG45dlNqk6jwY0LTNBUtJ4gy1BIc0oX7RIEKVgwUlrRPfolEx4kqyBhPS
         yUex4NMS1864zKU0SjBZbLDglt/nQMMRdot2DczMUurTZStMTVFHJhT9fbr0khSbjzsc
         rw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786984671; x=1787589471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hDoyXp3E5ydoXZqHrsd62dl6LpOZQ19HdygnsWau0U=;
        b=FQZD3J35tc21sSIV7lpqgtrza1AeFvV75sl0DMzV7MVaqKCbOud7NCyVRFTjhbUsq2
         AhRLSMUNiu5kdvkYqWrQo5bf6Zwji2XxBlRHTBk9xiQc1Bo4mvUEN6N1dRdZ+Qtm7TJr
         V+49nrzA6lASqeSlNFjDvAcCAefgJeEScidE8pGPaxYb+na6utFVTmBvgmkfGawmd6qN
         xiag7FjkMBLbxhUL7J08G/RF+QXJhxx8jUnNbK6l218WyM2Rt0OnOYHPvhjT9cdpwrJJ
         kBOjVn2wxYRXLw3j0/KnLxXjGW9K7fZRJ2nVDf4qyj8lOAfAPKl273ksmzFYAKqAiaZB
         tCZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPs8riGwW4BwoTLpxpwIZhAgyNrjV8z76KErFNky97zG8KT/IreaUf5gKnYpa7eRvMlau1ViSAgtSE8ZSVWw==@groups.io
X-Gm-Message-State: AOJu0YzV3eCzJdo+yTJzd6oYwAsIXJlmPX7igB/ftqMEfVYwTPahH8Cr
	xghJe2+rzykCkfjZraCN8tkKBfxCQUuaWfOfMe3NaVjAxvWd6wjpiKi9LZgzTJ2e2rBBcf/EKIm
	h+M/O4GQvBPHd671uvyQDgtsOAA+mHnIidh3ZbTmcbJfEoKVv9hmUCflIj+pQjqpbUUkaiQ==
X-Gm-Gg: AR+sD10jf2Or02UZGpuxA5NDtzH2k2kFjgEUaJi1urlcZqmMX1Nwa83FLjTPWPqZN1K
	3K+74ShKVmCe1WWzTWCCno6rptq6x4cTocmeq+rbNfbuq1dLNfY01+Z7+6QVDLWUoBSBaW9EY/1
	tff9SiJGY7jvHddnDXmUMX+4HwOQW2kCRx+DdHv237GHt+NoYqZNEp/tuGNwCR3YKb8gm2k+Aa6
	XklnOb0t7ckjngduFhRqnzRPHhHZBqBw4D53FVdvBlD1H6W5Vr2U0W33sz4rONDN/ZZWy9BIhAv
	awbpoxciHTX5ZDNzqQzw8wiOfxA8hsAuBgP/5YgJjLM+f1aBuCfx/xYN7T/4ZFO+18rUM9fMLro
	hKaqi0lzkUUKbL6Fn/CsYyMYKnqntyfhl6f8VJTextVTh/C/s3UhNNJAOQxI7EeAA+jvxeHfio1
	400VT3EvWgFm9CqW4NIvyK+C9Fl06UCI60Souq0N3L4Fjfqp39RxMAgfuqBbPMhqH2WX7+ouxfV
	ztLLxmZHh6o4WyVemSrH1oMg8A=
X-Received: by 2002:a05:6214:4b0a:b0:900:6ec7:19d9 with SMTP id 6a1803df08f44-90a91c8ffdfmr340340176d6.3.1786984252544;
        Mon, 17 Aug 2026 09:30:52 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f90csm12515336d6.9.2026.08.17.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 09:30:52 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	Sean Anderson <sanderson@brivo.com>,
	Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH] watchdog: meson_gxbb: Add support for s4/t7 SoCs
Date: Mon, 17 Aug 2026 12:30:46 -0400
Message-ID: <20260817163048.1892107-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3026

These SoCs have an almost identical watchdog to other meson SoCs, except
the reset bit has moved. Add a new compatible and driver data.

This commit is based off of Linux commits 55908e388b5da ("watchdog: Add
a new struct for Amlogic-GXBB driver") and 8c776a0401f1d ("watchdog: Add
support for Amlogic-T7 SoCs")

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/watchdog/meson_gxbb_wdt.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index fced8f3686b..30694936c93 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -18,7 +18,6 @@
 #define GXBB_WDT_CTRL_SYS_RESET_NOW		BIT(26)
 #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
 #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
-#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
 #define GXBB_WDT_CTRL_EN			BIT(18)
 
 #define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
@@ -28,6 +27,10 @@ struct amlogic_wdt_priv {
 	void __iomem *reg_base;
 };
 
+struct wdt_params {
+	u32 rst;
+};
+
 static int amlogic_wdt_set_timeout(struct udevice *dev, u64 timeout_ms)
 {
 	struct amlogic_wdt_priv *data = dev_get_priv(dev);
@@ -84,14 +87,14 @@ static int amlogic_wdt_expire_now(struct udevice *dev, ulong flags)
 static int amlogic_wdt_probe(struct udevice *dev)
 {
 	struct amlogic_wdt_priv *data = dev_get_priv(dev);
+	struct wdt_params *params = (void *)dev_get_driver_data(dev);
+	struct clk clk;
 	int ret;
 
 	data->reg_base = dev_remap_addr(dev);
 	if (!data->reg_base)
 		return -EINVAL;
 
-	struct clk clk;
-
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
 		return ret;
@@ -102,7 +105,7 @@ static int amlogic_wdt_probe(struct udevice *dev)
 
 	/* Setup with 1ms timebase */
 	writel(((clk_get_rate(&clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
-	       GXBB_WDT_CTRL_EE_RESET |
+	       params->rst |
 	       GXBB_WDT_CTRL_CLK_EN |
 	       GXBB_WDT_CTRL_CLKDIV_EN,
 	       data->reg_base + GXBB_WDT_CTRL_REG);
@@ -117,8 +120,17 @@ static const struct wdt_ops amlogic_wdt_ops = {
 	.expire_now = amlogic_wdt_expire_now,
 };
 
+static const struct wdt_params gxbb_params = {
+	.rst = BIT(21),
+};
+
+static const struct wdt_params t7_params = {
+	.rst = BIT(22),
+};
+
 static const struct udevice_id amlogic_wdt_ids[] = {
-	{ .compatible = "amlogic,meson-gxbb-wdt" },
+	{ .compatible = "amlogic,meson-gxbb-wdt", .data = (ulong)&gxbb_params, },
+	{ .compatible = "amlogic,t7-wdt", .data = (ulong)&t7_params, },
 	{}
 };
 
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_wdt

-- 
2.53.0


