Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B7C61DB7
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66.1786986990316147871
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:16:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=p7JtiutE;
 spf=pass (domain: brivo.com, ip: 209.85.160.177, mailfrom: sanderson@brivo.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a818fc4so24471221cf.2
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1786986989; x=1787591789; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUghKkS0pC6hSWB+DdCUpP+oMfD81gFBEmYpmO3NR9o=;
        b=p7JtiutE6AsYBa7LJXSA+T69a39Ynb8zicUPmIx0QifIgvvSqrWOp6ZfLVJBkGh3rY
         WeRVaWAsnFCsYPWOEWhqWBz2hD0U55RwVHdhf74vN+LNO+aZdnkXYNljYTTuapgjb+CE
         kIsfSG0ZfmGuAZABaRZO0jElvm6kSyvYAAERYzMSJmkduQvNSsb5/IvssWP8cRDEkoY6
         gUuYflbPq29E5ZKDe+mYPFTu0BCf2I9Y9U0XaSxGK9HZeOYcaRnKGnSRIUKwPG/UhBuh
         J52zEmbSJHM1uSn8/y8v105ath6QvXIC2eH1CntR//UrliMaP71ayQe4x/tA5Bk1qfhP
         2cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986989; x=1787591789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUghKkS0pC6hSWB+DdCUpP+oMfD81gFBEmYpmO3NR9o=;
        b=g2zNVDCheJ7mKH7/jR5sgJDIqKUwNJbWF9/6fDziAf16XJIODLFdGmKIWaeut3ThFZ
         CCzpL2xLFFiK1hIBamqKzwNHHAZZ7DbHyN2ALsu69LxsOG5qFAX3dJQDHb/oZgXA5d98
         EinkIFiN4hMST0a+C+MxbD8c07aLyqlEyad6YP3DEoJqqqk1vXYVSvpHS5GcGlDvuyxI
         nd7G3IkSFmMIHJMuYler5bLVRNmxgZSO8n4r/bRPJt8baC1Dj89+NbaVS6R3AhY3w2S+
         i/0CCFjROFsQkDEbY8hd3uqBg7xU2I2R/LTkzh0CjI7CFP3d2ET4xtX94qkBCIBBdmjT
         chyQ==
X-Gm-Message-State: AOJu0Yz3uIxLD02CjojDdIVlvBYawhZu4e4cERn2VmOL6RD9I3Zww1y0
	tdCo8C6W59KV98DvUJdw6zZoWxYnu9SPj1Jii9HckMstpBqwFGre9sgUT3672UeXwkCg7JGOcBV
	5uWVE6gvrfOJc1dcwZdmYjgYcLn7U9q8L+5OEr05sbA1yFb3QauFqbQ==
X-Gm-Gg: AR+sD12T7ZRmWx6w8I7aNLbGO33z1KDVmt7LiMzbN0d8bM0EHimgS5JvH8Mq5Zm6/FR
	Te8XFusDWTj8cYdOJHKpWA9Cq3XTIIzC3TlcWIBCY9xFs3TezVNQSkh0cMTI1SWPQV9wzC7ZOVy
	Aa83OSYNoHs4TN9u/ytuHLfgjb3/ixz7ePdtIgWwD2V9v7m0Kvww7QNF2cahIpM1ZjYUIZ4muhs
	OPjw/LUHJ2TsYT0Tm9VcVoawvPxEh8cxWIGoMs3WAH19AX4bDVqWebVh2etlwuYNmwlUniJubqA
	B/2tvUGqJXtiWrlkzpqVQ922QT8owRWILPbyPsqHoioPXezfOuUIq7xY8ndv9qhds7IwJewNfgk
	KQ3U6f5GD7Uh0oU8NktgakVQQZCtJDWZbntplpE2mgGeC7kLkKYUqG/STP8sKHTrdCT9HzKBRoP
	c3acNbFclDHreWVhXpSiTRGAYrkDpbx8L2aJaxYGCg4TDMQ6Lxfc875mOWBvyXnct7rZOdg3Ogf
	z8EPyBrGrn1kAIJozDnzcbQsnI=
X-Received: by 2002:ac8:59c8:0:b0:51b:f25c:2896 with SMTP id d75a77b69052e-52d8535e37bmr271776471cf.11.1786986989038;
        Mon, 17 Aug 2026 10:16:29 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com. [54.236.161.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:16:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io,
	Tom Rini <trini@konsulko.com>,
	Sean Anderson <sanderson@brivo.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 4/9] clk: meson: Use soc-specific naming for common functions
Date: Mon, 17 Aug 2026 13:15:15 -0400
Message-ID: <20260817171623.1943847-5-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3040

In preparation for moving a1 versions of several common functions into a
shared file, rename all the conflicting functions to have a soc-specific
component.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

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


