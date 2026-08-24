Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B4C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:29 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16466.1787577922532703044
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 06:25:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@brivo.com header.s=google header.b=x4NGZWea;
 spf=pass (domain: brivo.com, ip: 209.85.219.41, mailfrom: sanderson@brivo.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cabe38a61so6217506d6.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1787577921; x=1788182721; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XyMCBw3wLNIgBFhyd3ayoFM2ZNp5PJyAsiGH3j0vZw=;
        b=x4NGZWeauMetWI9zeal8FMOOmeCxBu8cnyeH+rtHDqsbcfaGtu6t5JJNg0cETue9/l
         d7e3WzaGJ+Ls55imNlyo5nAmlaQoccoOf06aCDJpNC5ABY0WdAP0X65EXVxx9heLEvXM
         uNRI57gbJp+XZ/FzRkBX0mP+LLGs//MKTHBNRsEJG4gSDZLPweJEVW5ncUDty504TJNY
         WsRbvNVrKlvFFZP5NhilVo7gHESTK4pf/uEYPMAEN0zSB9eItLy/o/6MHWQ7VvLzgGiw
         AKzf+MFkGMwgww/DO4m2QOsL97YT/FofVC7KGaS/kk3nFjtnvstZuCtkkWKpkYww97J/
         OsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577921; x=1788182721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XyMCBw3wLNIgBFhyd3ayoFM2ZNp5PJyAsiGH3j0vZw=;
        b=O3ijX95hTlw+4d5VaVuQFFOupfwawNoSXbo7WKoDWN8pOXHxWzuHBjxKp+5kMVwhz7
         3FF0AaA0lvyYnR8tEAPscI8tJYk3L5FdfgF6xvH+7p/9jjsmnsrakAzHNFx1xfRbdBKH
         uv6Cz3YI6Cp5YlV33nsx4TpQfJGSjlq2I9v20sA4HvkpE0dgktAqxC4wL86bkTlo/F85
         EUMdhhY/gW7sLXOu5zhiq9aZUDPexm143bjXQnC0UcIKh8jHK1wNizWOPxbDK7SU97lD
         ksKNesIEYKaBZl6wuRJcb3hEGosZ8DwXVgOeEATkW0LLtgTWFLIORpuTWQgZkLnwmSIQ
         uu4g==
X-Forwarded-Encrypted: i=1; AHgh+Ror6noD9GJe21RFbiKAKhCG42WMfbcU6PgMF2XXcw1K3JzGLHMw+z/cM1hO6wKEMdkZPwiK8D8pR+OCU5tbDQ==@groups.io
X-Gm-Message-State: AFuF++n40/C6Q52x3u+SEAe6BPMajyH1mR+rSwXMnykt1dtn0vYRUdnw
	49wuonz6PuIU3XVrZE4HTsdjfIUInSHPGruVOqivVFtTrvJI2SwFnnJgZRaD1ZpiBEU9fxzWC1O
	iHnLNEHHXFq9PPqqkOnVfqGI3SAXDN/Fb7iv6K5axvVHfF49kx2z2/Q==
X-Gm-Gg: AR+sD11NkGG1YLRIGCegktiQ6u3tMoiwd3wRbaK1vllqFb+3H1mq60wxzRBCUdr3vok
	44LqbZqJPuCc+qBbw7JfvWQ8MFky9xmYLbfRpr9sc3XUX9EntbjMVgOVe9YPCyNlQPDXx325IaP
	67gxxyyH33fw66lNG2O5pyoo1OHfG2zj3z+vTvIGu8ZUBDsp4alP79v6H73sj7WKNKy/kiphsfO
	oLdH3ZrX97jvrIyRrFUK4w//RJ+ZOwdqmwalU1WIoETYTMmyuztVR6LN3hkzkcSKUxYCr9SfU6t
	x3sw2NZckUenQwu73F0U7aIxXb1IBd6PU/b59dD7DZpYdd7nogykNkzRSXW9cN1+5fX578KpzTt
	PvAq13iLCJRRSnkoBYV+XyN2uQrABjjwhAGsJrHgSrEH1meLQ8FzLljTMP3as8dHDj9TovlB13A
	EFVvzZOSgsOr7q+D4TYI5rFbxkDwzWtjrMHWnstnAKOAgFewN/VsV3
X-Received: by 2002:a05:6214:2c0f:b0:90c:281f:e7cd with SMTP id 6a1803df08f44-90c8f9f6fd8mr182720716d6.21.1787577921246;
        Mon, 24 Aug 2026 06:25:21 -0700 (PDT)
Received: from strozzi ([66.193.28.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c939314b7sm61980306d6.30.2026.08.24.06.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:25:20 -0700 (PDT)
From: sanderson@brivo.com
To: Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	Sean Anderson <sanderson@brivo.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] mmc: meson: Parse devicetree properties
Date: Mon, 24 Aug 2026 09:25:05 -0400
Message-ID: <20260824132518.522252-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3064

Parse devicetree properties so things like max-frequency are respected.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

Changes in v2:
- Remove Upstream-Status tag

 drivers/mmc/meson_gx_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 76af3873e15..b5b4e60d8ec 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -351,6 +351,9 @@ static int meson_mmc_probe(struct udevice *dev)
 	cfg->f_max = 40000000; /* 40 MHz */
 	cfg->b_max = 511; /* max 512 - 1 blocks */
 	cfg->name = dev->name;
+	ret = mmc_of_parse(dev, cfg);
+	if (ret)
+		return ret;
 
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
 		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: meson_mmc_dt

-- 
2.53.0


