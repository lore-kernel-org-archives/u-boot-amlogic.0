Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29455C54E55
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:09 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web10.7173.1709016965481757097
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Feb 2024 22:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=ko09HVhL;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9014912F3B9;
	Tue, 27 Feb 2024 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1709016963; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=W4RGjUAKsNAa4xf53OqC3zdGKEmTCCb+L/N/V+hTqbs=;
	b=ko09HVhLTVJ43yq2xRyq1x2DAboszauWbW3LSJxkfz40kRWF4IB2ZYrQFfAqNhw4nSsETZ
	Z3ItR6TsUyIXngVs/teY5RJPykgwx8r/zO5rAXinE+vY3b/9DyOsFBOmAHA8t5jt9wQRth
	jWl1a3IW4SAA0tvJzRe6Gs3rlC4Ajj54uGWQ5Bn/BWgUY3M1nfLHEWjCD8jkHHOCvFEV6C
	uFUQqhiCQVcYRT8KoXYHuG6tXc77snOFm+quez4XrO7B6iwYkhpJqc9+kjcgf41IcJhvPz
	9yhm9I4MkjPo5Kb7bUs6oVUpuTNyVNS1xK5d1xiVm3nClsO842p1lXrxzke7aQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/3] board: amlogic: jethubj100: update MAINTAINERS
Date: Tue, 27 Feb 2024 09:54:05 +0300
Message-ID: <20240227065551.580199-3-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
References: <20240227065551.580199-1-adeep@lexina.in>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 27 Feb 2024 06:56:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2144

Fix mispell in maintainer name for jethub j100 board files

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 board/amlogic/jethub-j100/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jethub=
-j100/MAINTAINERS
index 43f6a5fc86b..3edc5d8865c 100644
--- a/board/amlogic/jethub-j100/MAINTAINERS
+++ b/board/amlogic/jethub-j100/MAINTAINERS
@@ -1,5 +1,5 @@
 JetHome JetHub
-M:	Vyacheslav Bocharov <adeep@lexina.in>
+M:	Viacheslav Bocharov <adeep@lexina.in>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/jethub-j100/
--=20
2.43.2


