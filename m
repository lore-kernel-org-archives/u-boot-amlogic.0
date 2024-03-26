Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD5C54E58
	for <webhook@archiver.kernel.org>; Tue, 26 Mar 2024 08:20:28 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web11.3609.1711441216479109454
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Mar 2024 01:20:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=iIk//Qsy;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B126147691;
	Tue, 26 Mar 2024 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1711441211; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=RoohcvTaeaEsfAtvUQCsbgNJ/d690KMYYqkAfXKjf8Y=;
	b=iIk//QsygetxvoA8wmiIb7dPVh7kpmrx7vdDOr870mNGKV1ZFLjeWw7FU+VCEdfM8tXyJi
	FfxfMSoFkUtA5Q2yrzvTO2CiZwHj1qoeBfJTvrGEnDXyVKvdk7XGx0S98oj4AWaAwb5D08
	llokb0sRkWoEstUZZPUqY666/uYn47ML1/6PgCP/m8uOZ373g4OXzLhV9V8PLpXlixvNsQ
	AqY6f+/ayzxCr/jCQ7xmP4gnCmmwjlsZe2rh6jgIRfKjKC/4lla6wr9eyra3VuPFLAarUp
	jyIgIibRisIjLbYhRnay5SKxDuiVD2wHnCH93IlGq+MN2syZ5atuiBYIPwxmtQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: amlogic: jethubj100: fix update docs
Date: Tue, 26 Mar 2024 11:19:58 +0300
Message-ID: <20240326082004.1651782-1-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Mar 2024 08:20:28 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2248

Fix linter errors

Fixes: 2fc5e3c1668cffdb4b894986e98c1ee10f6e9955

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/jethub-j100.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub=
-j100.rst
index 80bed6e919e..cbf1ea76107 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0+
=20
 U-Boot for JetHub J100/J110 (A113X)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automatio=
n controller device
 manufactured by JetHome with the following specifications:
--=20
2.43.2


