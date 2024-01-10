Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A3C47DA7
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.8919.1704883041191989200
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=v5u8RbUr;
 spf=pass (domain: linaro.org, ip: 209.85.214.182, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ec3db764so14848325ad.2
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883040; x=1705487840; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/j3oePBQR84as2zQnDxAbAdq5Q8yrkNIOyW+4r44PA=;
        b=v5u8RbUr1Al2gNFypy5NlWr2507kc6Umck/lxO2rPvTmE18NhE8VunbgW+9X9NqD2s
         huc3Z7B43uaiC/VrHHwz62Jh7rY5p0ugjHpDM9nWk/Nla2vslxWyY/Khfy+3s9Hx23S4
         xL8XnJQZ1kD8U1K8oh37IyklrFUDExhPrE0omZsojxlTk+Azi4m3hm3pQwNwOc8cpX9E
         V31a5u25MPgc4tb1kvLXubF7bmldntMIvUAAOlxDZTOBHjTogmnX8UT4BBQUnAs5rZaM
         HWhabCX/MKh2dhvg14vTMm0zlWQJEsU1c9vS4z0J0VY8XTo5VvLbwbon1t6DYNuqpG/e
         oarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883040; x=1705487840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/j3oePBQR84as2zQnDxAbAdq5Q8yrkNIOyW+4r44PA=;
        b=M4wQ47acBg+Nce9mXoXx/YELk+hss6Wd996yHoO4Zb8J/bHvWuO+jfVLa+Lh2Cxa/o
         I+OrBibW8E7KAWORQp3bWC3B6+rmB9dgfsyVoDwXSUgKkT6ZOonFu09MqfD/49KzFHgU
         3iF9Bg7pxcJS5NFKn5XfcCAVjpWriyXhxh4D+BK9FCIQzGnVnsno+IvUYs0ktCntO914
         KxED6fgho9AOXv4rmRqHl7kNnbl1kCx4EYjaLgZnGBgqttspOz6BMOG7KpQQNJxBxV7q
         3f6vxnsrLYj84+SaSI7d4qglU2nJFMx5s0kD7xlgJVIpAXgQKMYXnvcdkCwEFUVruJ5J
         N5+g==
X-Gm-Message-State: AOJu0YzSHtJSGyNtwO07yvSE0zosiEP3yPRKTbY3QIPpgg7xp31+MoUQ
	w8jgwEAMiAkMEEQueDlMpibFmjPRwlYpyw==
X-Google-Smtp-Source: AGHT+IFiObXCVrHD2z5lNvrlGWOJo/TLVnEZxQPPWj2/OgQVfNjHSDUV6NniK4OijjLPgOBUWiZXTQ==
X-Received: by 2002:a17:902:e888:b0:1d4:faae:885d with SMTP id w8-20020a170902e88800b001d4faae885dmr657350plg.123.1704883040701;
        Wed, 10 Jan 2024 02:37:20 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:37:20 -0800 (PST)
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
	maxim.uvarov@linaro.org,
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 09/11] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Wed, 10 Jan 2024 16:05:45 +0530
Message-Id: <20240110103547.719757-10-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2066

Add myself as devicetree-rebasing maintainer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Switched subtree to be imported as dts/upstream sub-directory rather
  than devicetree-rebasing sub-directory to better suite U-Boot
  directory structure.
- Added commit description.

Changes in v3:
- Picked up review tags

Changes in v2:
- Picked up review tags

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fec063a242..39b5c01a5e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -957,6 +957,11 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	dts/upstream/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1


