Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8E2C47DD6
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.121387.1703764715747215866
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:58:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=V06JFvUI;
 spf=pass (domain: linaro.org, ip: 209.85.215.181, mailfrom: sumit.garg@linaro.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so1716636a12.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764715; x=1704369515; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3W8sVu0jjxpWWQ933Uj3U3rjnY6OkWb8wvQvg7blCM=;
        b=V06JFvUIjVxtoci6GN/nPNNFCCoXxTA5ltkNQlSwNbM8iTwdR57VqLXI+PBgY0x27z
         zS5QCRniwAfge+bisnbm/WsE1WpHNJbqYSWDfYsZ+TusmtSWSqxQX1M4ROrjbtT5eriM
         gFI0eUccC6xDJEkOGWB2bmffZ+ozt1di2wPztgt/l6iepgg2jen9Dz2Iy4OURk/7xZjU
         LnSaOHyqORXFReD/sSOL9tQa62DVvUPJ4r2X6gcxK8sStx4KGwiG0U/ooA9eD1w5aRz+
         sYrcWrg0FA/fwA/RvFGxH8wWKtEsXi6ELuy9Fn6Hqk0c6aUXDI5C+Os1OJbqqKM30iwi
         GiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764715; x=1704369515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3W8sVu0jjxpWWQ933Uj3U3rjnY6OkWb8wvQvg7blCM=;
        b=EcGJ4JTPlNRn3e/lg9zH+UQQx4N7v1O9hxlTV+k8V0xXLYtznwnbGE0Ucg8fcnPS0c
         a3TmJ/3yfNJhgXUpukjQjbKY0dwIOFrV0KgOir4IzqbsvtSGh5xbsyDwlsG3xsxSARQi
         DSGW8J1RxwzzNdU0o1TNmbiMrTcaVTBnH5DDGM7TpFxlsMKlDjJJHUsjNOwzQ/ACmkfR
         OBRZPYMWuqmQWkOYwwHvGCisJl1SF+4iNorhM+HRyq5Tv7QmYcL//v+5ZSbFQ7P659JU
         Fy/VJJt7/fwtON7lW4vIk37hewAgnNB6MfabIK7p3N5yajrKsAQ8GgzzfZ8cLmXsQ7RF
         7o5w==
X-Gm-Message-State: AOJu0YzJDskaRIu94RKufx7sa+J6+pX6l+ObDgi0J9us0IrRYXug7i4v
	g7Jg1Ur6x3ZBbKGZrvScuQBtg2ZDb7PdiQ==
X-Google-Smtp-Source: AGHT+IEPnf+HylEaD69SjNL6H5NDpIh1Qutsch41q0LOQUQWicnXl9IvgAIgsw+41xD5iDycNi2T1g==
X-Received: by 2002:a17:903:28f:b0:1d4:35ad:41de with SMTP id j15-20020a170903028f00b001d435ad41demr4482702plr.60.1703764715137;
        Thu, 28 Dec 2023 03:58:35 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:58:34 -0800 (PST)
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
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG checks
Date: Thu, 28 Dec 2023 17:27:57 +0530
Message-Id: <20231228115804.3626579-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1981

Since devicetree-rebasing is an external repo with its own coding style,
exclude it from Azure and gitlab CI CONFIG checks.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Picked up review tag

Changes in v2:
--------------
- Excluded gitab CI config check and added commit description.

 .azure-pipelines.yml | 3 ++-
 .gitlab-ci.yml       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fee165198ae..96ca9f72bbc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -161,7 +161,8 @@ check for new CONFIG symbols outside Kconfig:
     # have no matches.
     - git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CONFIG_'
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
-        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
+        :^include/linux/kconfig.h :^tools/ :^devicetree-rebasing/ &&
+        exit 1 || exit 0
 
 # build documentation
 docs:
-- 
2.34.1


