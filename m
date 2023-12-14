Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02DBC46CC5
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:38 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.22529.1702561943791906889
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:52:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eYkJyYmt;
 spf=pass (domain: linaro.org, ip: 209.85.215.175, mailfrom: sumit.garg@linaro.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so4065736a12.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561943; x=1703166743; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td8aJIXbMp5JqUrMaHqKAzI/IeFL8/SoXqjrn04NGuE=;
        b=eYkJyYmtL/ibA82BBn7Q3MVfcq0rcQ0pRVSlMzCYXPj51EBVpNrzb6fENDBfwRXEwO
         6dd0uPCE+12yb21CjEDLnxG0VqUnJ5TeVFQYvE4ddx44mfS0hl4um7jlqFCm71Wf3bG0
         az7jfXU2FXr/L2g3rp4BVsjNR+XaG0Wf8IesQsaXdkVBj2MVKr0A6wdjp4CZxnioqyF6
         KlcD/mtIpzIZ7ruAmNldnrPqYSLPNaJQkE7EZRwjGd8ZU09B9Qc+BRcK7XKJ2Epk8oSU
         t8ve1ky+TgX4N3XuPOUBbtuguY1hgDY30WimIwUnwGtHTcu9SPQdqCCSA0sGia57n0jY
         s1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561943; x=1703166743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td8aJIXbMp5JqUrMaHqKAzI/IeFL8/SoXqjrn04NGuE=;
        b=EvVdMP98tge8BN/pw6mm6rupPTXueC2TcCDnZMoJaNh7ZkkNg+/oMZy9vxSlWIJ4ka
         V8f9FYINZkopo8jlHAS4OBEIgJv3boI/BdWPoj23CKVivhj16TsTwewyZoU4fNfjzT8k
         bY9rQkfrHN7+HGUhf4mzauq1991o9XNfCmuUfBkZ6Ze/87JUUXJnQsnFQbmEg55G8/gW
         LkeXCnGzrq0XB6jmUJ7vuWoCAC1WPjqqnAWCYBMVhs+67rCQeP2Om0FWGvbW+2VOec5l
         EQujuhxmVJoL1xxXzUgvCsGG25bxJGvEcieF3vv6veXuJiY9AAtJfrlndQsRxzN1rzsd
         PIyw==
X-Gm-Message-State: AOJu0YzRwnUmGhMn1pMVEZ58mwO/eE7q13uHPDEm5u2Pj1lGrq87Z1pK
	cYPog6C/auj0wTf+G/EpKV1eEQ==
X-Google-Smtp-Source: AGHT+IFlXBG9ffsEU+xaNO9vHp3Hti5/DyLT/Qv6tA/QpsMlCeHMtDqwhRCe04GZhEIPys5K6JnhEw==
X-Received: by 2002:a05:6a21:6da1:b0:18c:346c:d59f with SMTP id wl33-20020a056a216da100b0018c346cd59fmr5433647pzb.62.1702561943252;
        Thu, 14 Dec 2023 05:52:23 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:52:22 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 6/8] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Thu, 14 Dec 2023 19:21:01 +0530
Message-Id: <20231214135103.1606605-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1922

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 969514468cb..253092c345c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -951,6 +951,12 @@ F:	cmd/cyclic.c
 F:	common/cyclic.c
 F:	include/cyclic.h
 
+DEVICETREE REBASING SUBTREE
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	devicetree-rebasing/
+F:	dts/arch/
+
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1


