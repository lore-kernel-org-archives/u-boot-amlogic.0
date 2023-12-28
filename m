Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9699C47DBA
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.121681.1703764755985968387
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 03:59:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=cwzZ2chU;
 spf=pass (domain: linaro.org, ip: 209.85.214.173, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e416f303so15929325ad.0
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703764755; x=1704369555; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb3XFZL1wSgCUb0IUdl2uX0NzUG6r5NYkoUBmB8V16g=;
        b=cwzZ2chUntN0mU3iNujlFfiZv4iWLb3T7hptm7hucEsyhoFHQlLk5xvFYr4ssgw6da
         94qqKFycnL9xd5F7gpTASpUnwFMLBQv1kHcDdZ4gwHZFsH7Xe9eqtXuFaE7S4cVKX55X
         +Racp7BvOZwPCHrPZGbRcZHH8AUdK1y5V3q7OKyeBlHPh2lO8nnM3JiX7/JqAdv6XoVP
         SBqGOHkjBXAQ1OoxypGXSfMBgZzab6N2Vy0HiU4sSAAzjLl+pEFHUb6jgMk3No/dfOzv
         mKUH6/GJ/XMtTqOaQVqSQDkFXeHEN81GJFW1mR44ElI/1gQBZCMDKaj5trMn2NKqPkFj
         CJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703764755; x=1704369555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb3XFZL1wSgCUb0IUdl2uX0NzUG6r5NYkoUBmB8V16g=;
        b=q+3b8Ulm4HgMwsdUuxiQJQ1nrnZZosAiSULZrzoSL5gd/93uU2DtBh0gtUU7bIJodG
         mgHl8FxFFH8n9IxwWZN3N2BFDyMyqOxYleQV7PKd4GYU24dgpkwHkMmzKpYBDx980lyp
         6j2SbfvXIWH98pyT3/klejkUHVck00k9hhCcD5dsZuzowmnqc4XTcF6Hf/sm7tVWJUlM
         dXyY/sNvtv4wix99fjBuJ1HVl6G4pz3f3/tHsPY6UXiUZrimkkBHwaM8sHuvd2Lm2zAP
         I/L1SZVs/jJJ4n7MApsWv08suhwi5H2rwFwnQqNberlpH1Y9DC4QfzmZ/lluJjqFf6Ic
         tSkA==
X-Gm-Message-State: AOJu0YyOoNLpUgBaazDt5Aulhm+t1aPMCcuitckZ5O8UlNIrTFDe7wNJ
	c11qWw/hj9N1ei6ixpRI2U/PYMeFkN0MIA==
X-Google-Smtp-Source: AGHT+IG+qwCl9JEvkkwXfKVIdd8GU4hSRu9OFp1L197yJrWbeK5tzFIki33ekqUXMGBBMx+6F+bWJg==
X-Received: by 2002:a17:902:7ec9:b0:1d4:2330:8590 with SMTP id p9-20020a1709027ec900b001d423308590mr3674193plb.40.1703764755514;
        Thu, 28 Dec 2023 03:59:15 -0800 (PST)
Received: from sumit-X1.. ([223.178.209.202])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm13700579plg.124.2023.12.28.03.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:59:15 -0800 (PST)
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
Subject: [PATCH v3 6/8] MAINTAINERS: Add myself as devicetree-rebasing maintainer
Date: Thu, 28 Dec 2023 17:28:02 +0530
Message-Id: <20231228115804.3626579-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228115804.3626579-1-sumit.garg@linaro.org>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1986

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v3:
--------------
- Picked up review tag

Changes in v2:
--------------
- Picked up review tag

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


