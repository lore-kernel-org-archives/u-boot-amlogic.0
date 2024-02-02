Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C61C48BEB
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.22132.1706879167303665633
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 05:06:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LBn8Um3b;
 spf=pass (domain: linaro.org, ip: 209.85.214.181, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d932f6ccfaso16500195ad.1
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 05:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706879167; x=1707483967; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfNK3eknAcYyOfZsqNMY4CG6zYLXXInt8BiOHB+Nmcs=;
        b=LBn8Um3bYVwRMJaHhAR2vdpujHn9UB4L0L/MZhwp23rIL/SeH3Zv95hPDC2T5JT1m4
         WrJSiu62CAUSiPguObjI443eLq5dr5iXSv6EjRUqKn2sfIKIa4AgFK53/m+GM9Z1UcR8
         VveaWTRboAO/DaTq0g4mL0B5L1AjiFSyBEa/7FV5yac+LlhXZEYRuCbZqD3+DxT6JauD
         A21UpOjeSojEV4GLTO8VjHIERfe0lt7X0MGdOjWzHmRz9xvmma5qQX8eO9RJo7L+gLIl
         phR4/tze+fJKrqWaQRpYw/XuYZ2htr4roH+sjGYVhwWgt+fx0Uds2d19aOisHyM9Lnl5
         Xl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879167; x=1707483967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfNK3eknAcYyOfZsqNMY4CG6zYLXXInt8BiOHB+Nmcs=;
        b=g8Y14R7wC+JG+HoBOnVVRD145Sv+kNeW0+F9Xqfp40Cnl5sFtJS7v/zRWS+rbNmO4p
         7YUdaHydRGJhnwpqtRUVOcPvg+O9KPb6N4pG6MEFezmnhCmxgb0e8kvHnA9+7/MUCCVh
         3JgxleJar+9CodmE5IhWEonxGr57ETOCwEBJUyocqa2SGF+3gbnBhUVBhpje5iIHlwZG
         +fuXhs1Nh6FFO9ApzMaNsRk9BJ/nRYOxLg6UIO/njKT64tT5OjqyGoD9VKRL9tcmX6/i
         emUaV1fjpjbwP+7d3zb5CyMyIMScHBabvnYVZxPlztJ1auySKyhooF08IOJfO4V3XFIx
         tYjg==
X-Gm-Message-State: AOJu0YylQxP7TBr5hV7jA9+78I2PNEub9S0Z2bIoLpSYsEMeX7f7+V9A
	XhTZpsEzckuu7JVvX3fYX6nOjm584JNPE46/+SZNpmfg3nHA/dfPEpAr/VSZIrA=
X-Google-Smtp-Source: AGHT+IEGQLAT+Sq0VgJIdx2rH+Xg+tBhNepB53pXQdTQTP+3lwvE1TvMFcPpaGFu2F56o85L7drj7g==
X-Received: by 2002:a17:902:d2d1:b0:1d9:8222:e723 with SMTP id n17-20020a170902d2d100b001d98222e723mr236050plc.26.1706879166794;
        Fri, 02 Feb 2024 05:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVteO+wGyE7gcguaCKkECiv/k47QJKRmESOXPQ/DkoxXiuP0bq5B+JuJL1tLWpitcuaV/nDETbi1762oxkPmlwwouOSnd1bHvHmFwHOxVb3yBWvu7gqxj8Kti8Yvdim7xlWxHpJTJ4uFFwgw061lMR6NMVY3CPDrku0Bjo7+lXctc4N2YuMjpcUem8dISpVdyIwuYqjlwKd3Sos6riOLmcYpQ090fYPJFEPsz8mKmbuPyrwY0rNJFNsqiG7cU6lVbhiQawgLFo2i2o6N1CwkSMepUjrjZMwSut104qhgll6CuY4rvcOEKGj90+prh6SqstYvMa+Mjx4BLtMA35AeCrRIUwJrBeVeSroRhznKYQobyMSkwTDxsGYnwxG2Mw7ro2Lmkiziu7oKLB0MDaPK+xoOGeXmAzxNzbB3RpNOgvb2Wv8zbnmZvXZaL4d/u2kUweamMhwNTBSTPFzZPZhekT+RtayaiiOW8MToSS6FAeuRgEClmxVHRzfciIhwas6+TSPnAC62bMS79ESOc6WU/Ok923zidvqhKa8w9LoLmNUaa1apKLOWS+PTohULjoEaWhMXbwRLxQDMZJyuy9+LHCdiVl2mvTwxLT4sIQo2N2vG6+1VEoBs2Mp/9Fnv/YOohTd7z50L8UO0p2hbSy9MwzL7YWzhvmWhuE3cXYwCx/xZ5q0zDYeia4tuT3wc9/B59i+CqK00anqxzdH2dcxxMrKmm4maW76EORLjsVhvOfkNghX1wHKb57vuUqOWZVJxTCvZ84b/9ZPPnV9ncXR3XBDN4Ahw+VI3DNYX+Gel+5GtDvDytnKplMqwDBNVVrrcfqpK+f/65R636b/XG2GSBiRQm/BgFvVBOM242Rp32K4YlTNyeybWbwzsgRGoyXu8pCJ0yp/QV/wDEnmS3oyc/BYkooxeNLzQ/dm
Received: from sumit-X1.. ([223.178.213.44])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b001d923684323sm1542407plk.195.2024.02.02.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:06:06 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de,
	u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	neil.armstrong@linaro.org,
	caleb.connolly@linaro.org,
	ff@shokubai.tech,
	daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org,
	pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org,
	b.galvani@gmail.com,
	xypron.glpk@gmx.de,
	michal.simek@amd.com,
	seanga2@gmail.com,
	rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com,
	jh80.chung@samsung.com,
	rfried.dev@gmail.com,
	marex@denx.de,
	mibodhi@gmail.com,
	bb@ti.com,
	mark.kettenis@xs4all.nl,
	festevam@gmail.com,
	nm@ti.com,
	andre.przywara@arm.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG checks
Date: Fri,  2 Feb 2024 18:35:24 +0530
Message-Id: <20240202130534.1051438-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2100

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v5:
- None

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.

Changes in v3:
- Picked up review tags

Changes in v2:
- excluded gitab CI config check and added commit description.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e2646783ee62..1d73215afbae 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 278a2e2bbf31..8bfbadd6c89f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^dts/upstream/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1


