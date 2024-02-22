Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37239C54E5C
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.9335.1708594594875707140
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:36:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QO0mBzrH;
 spf=pass (domain: linaro.org, ip: 209.85.210.180, mailfrom: sumit.garg@linaro.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e4c359e48aso792631b3a.1
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594594; x=1709199394; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcd+0dfRYZF3OWKud7BcUhBbJZ0BNgm86qOOaiJdKvo=;
        b=QO0mBzrHYJAGiYdYyythYrwzHxWriNvNLncv1ygQKHaJ2r6Ru+JRma8iTB6ZgaejJx
         tx9YiVTzI6fC/1pxXWwCeEyYOXx5yWbtLQDnSsOENXH5fTveav6c+EmlL60U4bxQVuOf
         cPiOqh5cdplBojm5Pf/OXUSVfQ2pcqLu/29KHUijUGySwSg1lLFNKrh4okBfKVvtRDRc
         sanXfCyEBaxBqrcoqpTc662OT1Kjo2Gswz3ygkWc43hPn7z2JuoKcoA3WdwV3dUKfcJb
         oQz3b2a6C9vF97lmbQCWptKI73hi2kBQT/OvQm9Moelmyl5aFj0Xuu8s3i5uOmInUc6I
         KaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594594; x=1709199394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tcd+0dfRYZF3OWKud7BcUhBbJZ0BNgm86qOOaiJdKvo=;
        b=WlhIsf0gnD2wd0PMmuaiYIUcaJVQ3LexCBLKkFhLjn5x1aiygdhuTFSj5wbRAge5r5
         5U6+KK+uSuaWmX/e5HAa8c1yyukoCCuSOiQFZoH9gFOl5hDQLpMMo1pwTqc2v0QCHpsA
         PkWLLQH/kDByk/XiEbtdQh7BfVRtk7RQV/cY5EQkIozO22ZRVXT1o5up7KkKL0xw6Xt3
         W8IRr5geEnLFXFnUIr74x8gZCEEEA95LoXMAjfJXBw9KYKjQq3WECttBfF6Lmng2cv9C
         jZZL32lsqEmoIBcezmQHmOR3fiXum4a/5MNWWDhRFmvV40Kmd3wypBkQWglb0IFGh9nN
         PZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXZHAAGjei/rbk/ia4GR+qeHLDiIvgMVy3HjHlKvg3tYHdQfQZoxww2vcQLGUJbfXbhnf8uwqplbonuFxmmwIq0ntTAVCrqVlI=
X-Gm-Message-State: AOJu0YyvLYPrrCCffd5pUSN3PF1Efo2seXh+sUBLCAS6uWXSiA/WlSTr
	ab0okB5hFEertdN/qwqeUeRk6Ktte9/x7cGJ8HK2xqum2JatmA3eGhbZsnHSJFQ=
X-Google-Smtp-Source: AGHT+IFIEFpzkt9C19vMi3K825MNxYGi2iVl0rjDkbXs1HVxJZ3K0mzr3rFYs6/iQZLCTFYv0ZKS9w==
X-Received: by 2002:a05:6a20:9e4a:b0:19e:3c4e:d0c6 with SMTP id mt10-20020a056a209e4a00b0019e3c4ed0c6mr25897148pzb.59.1708594594245;
        Thu, 22 Feb 2024 01:36:34 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:36:33 -0800 (PST)
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
	ijc@hellion.org.uk,
	paul.barker.ct@bp.renesas.com,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 01/11] CI: Exclude devicetree-rebasing subtree for CONFIG checks
Date: Thu, 22 Feb 2024 15:05:57 +0530
Message-Id: <20240222093607.3085545-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2132

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- None

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


