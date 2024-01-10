Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1277C47DB7
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.8928.1704883017119775822
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 02:36:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=UzWShN0i;
 spf=pass (domain: linaro.org, ip: 209.85.214.180, mailfrom: sumit.garg@linaro.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3f8af8297so18900935ad.2
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 02:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883016; x=1705487816; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzTBFBuuEV3jHwA8W0Ga4EzsnN4VTGx3NOQxj35ln4A=;
        b=UzWShN0i565lTu/sxFPd6MCPy+GNZIWYt613YMKAfrM9FeC84yqlbet6XVPvH6UlUU
         3Ell3aAK+5VyduyTFD3j3em4+MA1RDByOSXdKTZtSPJqiU7UoMFKJeytBScmDLEsz+oX
         Fnmr3uKW6I9wVArnF+QHkp+Fg+uCByPW0RHufbQc/7XUNYIazKjTbTEf5z9YUDP8Mz5b
         jFWKzLv9FuulDOvkjffvzmwF1lqCWMBgICBQZMbo08w4VflrtQuRYNGRKtocPJo+QtWY
         vncQEd5vt7UHGVXc9kWU/5yrCE2hQT1FhA8VJikN37bYpzY43wHr49MQLbArKzJSOBpn
         8RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883016; x=1705487816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzTBFBuuEV3jHwA8W0Ga4EzsnN4VTGx3NOQxj35ln4A=;
        b=qNlUsOjBenmk8zj4Bkp18/1kkFNDWxhJDMPmJ+ivSNiZecI+LeEMFLW0H7OsIsU1fR
         BjLODPGl2umB4D/Iq6skT3ztaiBnJ5wtDd2AeWeXpXoCL0gwyILLDO23PmgQMnSic4g1
         TSdtprKOwTXYafM35E1PAb1vTJzAELjj3hFzhqIoIBFv4XdoVIGefiHMabMsXKjWHubO
         FgXDZQEGrvX9+hVqhzKtFGxm4r6Lmkb0izYUgIGEid9+XHN5dXzg6CiOf5+uUkz8Ywq4
         dP2uNBI9RZ6pc3Y12ZRhw0s8asFCdA8KrYdmgxO90hK0Yi3bdEFkQukjd7uq2EGMAmHe
         kAeg==
X-Gm-Message-State: AOJu0YwWXqeR0IhTXLqZGrwXy07meO9i8Yuz4NrSYndGXHobEv+1nSbd
	h5x0MhqZEqpi7n2HNQXjkbWCMn5BW+RaLnPq4JCheeyG9ZU=
X-Google-Smtp-Source: AGHT+IF25r576iJdYtL63mGj6GoItMqOOmVtntCBjbG9jPFPF95xZWc9PRQne1NyaaQ7B9a78qAZUw==
X-Received: by 2002:a17:903:22d2:b0:1d5:4b75:f2da with SMTP id y18-20020a17090322d200b001d54b75f2damr642425plg.108.1704883016638;
        Wed, 10 Jan 2024 02:36:56 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:36:56 -0800 (PST)
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
Subject: [PATCH v4 06/11] dts: Add script to uprev dts/upstream subtree
Date: Wed, 10 Jan 2024 16:05:42 +0530
Message-Id: <20240110103547.719757-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2063

dts/update-dts-subtree.sh is just a wrapper around git subtree pull
command. Usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh <release-tag>

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- New patch to add script dts/update-dts-subtree.sh as per Rob's comments.

 dts/update-dts-subtree.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100755 dts/update-dts-subtree.sh

diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
new file mode 100755
index 00000000000..2077094d0d2
--- /dev/null
+++ b/dts/update-dts-subtree.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./dts/update-dts-subtree.sh <release-tag>
+#
+# The script will pull changes from devicetree-rebasing repo into U-Boot
+# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
+# automatically create a squash/merge commit listing the commits imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$1' of devicetree-rebasing repo [1] into dts/upstream
+
+[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
+EOF
+)
+
+git subtree pull --prefix dts/upstream \
+    git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
+    $1 --squash -m "${merge_commit_msg}"
-- 
2.34.1


