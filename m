Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146FC54E5A
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:58 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.9323.1708594641921426935
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Feb 2024 01:37:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=S+5qMaUa;
 spf=pass (domain: linaro.org, ip: 209.85.219.174, mailfrom: sumit.garg@linaro.org)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc745927098so1569793276.3
        for <u-boot-amlogic@groups.io>; Thu, 22 Feb 2024 01:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708594641; x=1709199441; darn=groups.io;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0eINnUSle7kphQXYYJjZQ3WtQtSVqGbbOBtJCnAd90=;
        b=S+5qMaUaoyFy3uLG7GFzahcHlPvWrDRYsgOlPZ95IWxtSmGJO2P/xfedte14TSWaec
         bWuy9+bEZL/MALx0+6zGMA5JWyvVVvHmIbpEPig7AiSPYmi5xsID6fnCPJ6hgf068eNb
         8ebEpdiuT8y8VfhUvke3EkKVs9cb6aZJ4yTN9gW76gGfZOAVMRhbYa7qUpcio0vRgsZb
         cngasL8IjdvJ3PgPrzb+P75oFqhrt+5R0WN4J4K0iEWveMnhMBCROmcBOzVEYjVTgrxf
         eq4PSJ768p3zy94AdI2tKjOmWBpcLaVH+iJ3+6JKl55Vb5BYxE9Py2ZzF7ifa9wThve8
         9/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594641; x=1709199441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0eINnUSle7kphQXYYJjZQ3WtQtSVqGbbOBtJCnAd90=;
        b=iI2zW8T+Z/r0mngIT9abIroA27IiNedyxBMAMfLYqUWdjt8d1clX4MJMr4EPz4VsQP
         TWWwj//gm2c44FExpWQDcbUMq+wxPfdqI4622pmBEzTZtcytJRMFXUVXQuqgXrXiz0Tv
         AFwkgA/nTw/8Z9Pzm/ucGZJku8UsoQ2XBgvQ0OP3KS8/GnjQHekzXzULQUvoj+4MotJP
         Qr55TFgN53w6mRC/x4f4L4LIW8U+3xNgcigaC7NE1S4JcffJ3WJpguhO5SOyFAkxqmEU
         59CRy8NRlcPZaOkYxM+TovQrXU3b/B8IcgczueHciyJYEPLpRzthp+UOifAFVMEaaqS9
         CWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOzcacKqQfj/+rX1D2XOuLzO1dVuGKdJhuoBSf1OibF000rWWTwFmCB6bkryUQIEU0LULl4gQQo1tX76nKTN3mtHxHZOk2zKY=
X-Gm-Message-State: AOJu0YzUUf0Y5dDiZhBngcMbk4/0Ixbqf+zS9x9/ogdESSPdl5XDPYaR
	AbBiXYRvPv7/rTR/Z+28mYPcKjGa9QSTZ3Rjp+wDEoIDzj0JVmcUNh+F0VA969A=
X-Google-Smtp-Source: AGHT+IEweK2J/tELagfFflo8hp0PFQw00OrWlIRqkKjUl/PIJ0evxnd7tl9l4oweJIoKkFazd5J02A==
X-Received: by 2002:a25:b946:0:b0:dcb:d0cb:651d with SMTP id s6-20020a25b946000000b00dcbd0cb651dmr1976527ybm.17.1708594641055;
        Thu, 22 Feb 2024 01:37:21 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.115])
        by smtp.gmail.com with ESMTPSA id u20-20020a056a00099400b006e47300e4edsm6208404pfg.183.2024.02.22.01.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:37:20 -0800 (PST)
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
Subject: [PATCH v6 06/11] dts: Add script to uprev dts/upstream subtree
Date: Thu, 22 Feb 2024 15:06:02 +0530
Message-Id: <20240222093607.3085545-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 26 Feb 2024 08:49:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2137

dts/update-dts-subtree.sh is just a wrapper around git subtree commands.
Usage from the top level U-Boot source tree, run:

$ ./dts/update-dts-subtree.sh pull <release-tag>
$ ./dts/update-dts-subtree.sh pick <commit-id>

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v6:
- Incorporate shell script comments from Marek.

Changes in v5:
- Added support to cherry-pick fixes in subtree update script. Also, used
  https:// instead of git://.

Changes in v4:
- New patch to add script dts/update-dts-subtree.sh as per Rob's comments.

 dts/update-dts-subtree.sh | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 dts/update-dts-subtree.sh

diff --git a/dts/update-dts-subtree.sh b/dts/update-dts-subtree.sh
new file mode 100755
index 000000000000..a57b78a41d34
--- /dev/null
+++ b/dts/update-dts-subtree.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2024 Linaro Ltd.
+#
+# Usage: from the top level U-Boot source tree, run:
+# $ ./dts/update-dts-subtree.sh pull <release-tag>
+# $ ./dts/update-dts-subtree.sh pick <commit-id>
+#
+# The script will pull changes from devicetree-rebasing repo into U-Boot
+# as a subtree located as <U-Boot>/dts/upstream sub-directory. It will
+# automatically create a squash/merge commit listing the commits imported.
+
+set -e
+
+merge_commit_msg=$(cat << EOF
+Subtree merge tag '$2' of devicetree-rebasing repo [1] into dts/upstream
+
+[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
+EOF
+)
+
+remote_add_and_fetch() {
+    if ! git remote get-url devicetree-rebasing 2>/dev/null
+    then
+        echo "Warning: Script automatically adds new git remote via:"
+        echo "    git remote add devicetree-rebasing \\"
+        echo "        https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git"
+        git remote add devicetree-rebasing \
+            https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
+    fi
+    git fetch devicetree-rebasing master
+}
+
+if [ "$1" = "pull" ]
+then
+    remote_add_and_fetch
+    git subtree pull --prefix dts/upstream devicetree-rebasing \
+        "$2" --squash -m "${merge_commit_msg}"
+elif [ "$1" = "pick" ]
+then
+    remote_add_and_fetch
+    git cherry-pick -x --strategy=subtree -Xsubtree=dts/upstream/ "$2"
+else
+    echo "usage: $0 <op> <ref>"
+    echo "  <op>     pull or pick"
+    echo "  <ref>    release tag [pull] or commit id [pick]"
+fi
-- 
2.34.1


