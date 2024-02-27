Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E5C5478C
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:09 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web10.7171.1709016962521544570
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Feb 2024 22:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=QPWK1k6M;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B61B12F409;
	Tue, 27 Feb 2024 06:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1709016959; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=qgrCfXuZ6pja7HVHgjnddHuR/6bmuAOHKTyxsDbUjuY=;
	b=QPWK1k6MEIn1ediXslHfd/hq2KsN1Wg7XWxGm+uiJCTnDCo938T2+vJ6ZLYQdrtQH9vmtd
	OoTzcINP4c/iwNdwF6E1xKLl6gs/gaodrlkM3xiD2m0scGx5hAfBPmO7uQOMmMEJniG+R5
	km5dnQ8mYXUHLTRY5Tm0vjRD4FleQy+KExEu75s4vnoWdQlldiLrCwlYgoPzcc0RSlMGmb
	QVf6qNXnai54ZEkki3TU9/IDogt49g9lK3v/05H8y2EKxJE+OzHNve2iLtCGexFseWQ6ye
	JTAK3wDXGcvSbehB/ITQtnHBZvOX1XynALb8Y06F5liS237stJtS3bzQq0BieA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
Date: Tue, 27 Feb 2024 09:54:03 +0300
Message-ID: <20240227065551.580199-1-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 27 Feb 2024 06:56:09 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2145

Update JetHub D1/D1+ board support files.

Viacheslav Bocharov (3):
  board: amlogic: jethubj100: fix common config header
  board: amlogic: jethubj100: update MAINTAINERS
  board: amlogic: jethubj100: update docs

 board/amlogic/jethub-j100/MAINTAINERS | 2 +-
 doc/board/amlogic/jethub-j100.rst     | 9 ++++++---
 include/configs/jethub.h              | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)


base-commit: d49fa3defa50c6d3f04acbb52fd486c13c14ab6a
--=20
2.43.2


