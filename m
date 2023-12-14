Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F33C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:38 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.22508.1702561904279442734
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 05:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PolTv5QG;
 spf=pass (domain: linaro.org, ip: 209.85.214.170, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d36a6cec69so1528325ad.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561904; x=1703166704; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0j2/31GU6QT/wHSqzTKTNE2vio2VHGOKx6OYIgJzZs=;
        b=PolTv5QGT5aqnzGARQKsiHfNVFTVFO9FHCPPUWwNeW6MZMbGwkxUmyCQXG+HYfQRYm
         iGSJsH5qO6rgVkkIkv1x27i+w/Q2VpD8ExjsHOOXT5movawBnoXq6WO7qGKoIjAYYs0g
         L26UUgidV/zM3/VV+FmlyEci+YcCm6yPkGNceRS4foJwelo21f4v3tGMGs7bwiJNTMRg
         zkWk9qSpShp+93vDMGQnbanxCNP7kxCqFHeMRN2Wey/jp+YvzduA6FAg+3LfqHcm2lfI
         s46ZTTBJDAN5LXt+uhjcwLi7UprzEYOsEm8grxDO1JtdTPKcvqkyvj12WJ9DcxWpbD40
         w7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561904; x=1703166704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0j2/31GU6QT/wHSqzTKTNE2vio2VHGOKx6OYIgJzZs=;
        b=K9eLBSEIwrr0lrd0iwX/n9GQVJ9vLDzSiN7I6bvtrRF6Av91F3IIOhGQ91tkcBsilq
         G0kqkoh6E5rw6+5Peg9MBlcrYbvL7ZSk7Ewwa/8Iw1mI3lpOOFkrFZt/OlwxDEHyEd6s
         JBE66pBE3QQ/X4sWtAtKcJ8K/uVTHuWLMsDpyhDJwcsSPJEyB6/ap8+9CA4XECqU+rKY
         KBbML6eKnWGsKMDTlYMPY78rBVFAWZYrI865J8Uv+9LuVZ15qpGS+p2WaAbwPGzvAZaq
         Xfq0Z4QGEjsWqmXFmwya0Zff6Tla9LUoml9IVJZ1phO4xsRlg1fBHEsPsqYHgOx7IVNJ
         gYuw==
X-Gm-Message-State: AOJu0YxYjCZA81RO+xFa2Uwr4p4LdBdFH+pxEFkVJR7KSDURqDUuAMr4
	1R8+FdIphccOqoGf9B0IbYwx/erTxgMwg0WRLqYfow==
X-Google-Smtp-Source: AGHT+IH+aLeip+56aFJkGFk4eYCPQZohoZLDWKFRkh2eE7di2zRbpByB8bUpx7N+DqSSoGdYAGhJ5g==
X-Received: by 2002:a17:902:8301:b0:1d0:9e5a:e886 with SMTP id bd1-20020a170902830100b001d09e5ae886mr4491848plb.127.1702561903680;
        Thu, 14 Dec 2023 05:51:43 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c08300b001cfc68125desm12474956pld.203.2023.12.14.05.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:51:43 -0800 (PST)
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
Subject: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
Date: Thu, 14 Dec 2023 19:20:56 +0530
Message-Id: <20231214135103.1606605-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135103.1606605-1-sumit.garg@linaro.org>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1917

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .azure-pipelines.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d6f3fa423c6..f100c4493e6 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -65,7 +65,8 @@ stages:
       # have no matches.
       - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
+                  exit 1 || exit 0
 
   - job: docs
     displayName: 'Build documentation'
-- 
2.34.1


