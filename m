Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D2C54E49
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:09 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web10.7174.1709016966910181153
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Feb 2024 22:56:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=MFsAK/ED;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DC2512F35A;
	Tue, 27 Feb 2024 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1709016965; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MXZ6wHnBKbqx1Q5YHLG9K3YBob6TS5YdsHhBdhVs2oo=;
	b=MFsAK/EDAJOb6msnTQAfeXDYqLP2/UClFWLfspHy9QLu2YT8hGzZGAsIcrLqpQqvKtlapB
	KT1z/M2TRsifmfvlvHvsnZJN/VRKv2O43nbHHzU1VFc18AWuJyZZUW0oFG6us0dOfVZ+Mh
	Gy9DygHFuY3ADpdLYBGsS99BnGu+Z3nV2tgd1zXjgtN8oYuSrDvDMe8+Mrv9n96Zli17O7
	+8YJjM/PoZirv4hikpNo85OIZLZOqSdP+i3DFSgP6IIWBP5fAM+SA+NZWJJyrEl5sooZdL
	UmxC2gGIv1daR00DsyMJLriVvWUqsG/lLIIlY14NOWeqA5dpyR5Jb4mg79HfdA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/3] board: amlogic: jethubj100: update docs
Date: Tue, 27 Feb 2024 09:54:06 +0300
Message-ID: <20240227065551.580199-4-adeep@lexina.in>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2147

Improove documentation, add new revision.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 doc/board/amlogic/jethub-j100.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub=
-j100.rst
index 86acdafa06f..80bed6e919e 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0+
=20
-U-Boot for JetHub J100 (A113X)
+U-Boot for JetHub J100/J110 (A113X)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
-JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation con=
troller device
+JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automatio=
n controller device
 manufactured by JetHome with the following specifications:
=20
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
@@ -23,7 +23,10 @@ manufactured by JetHome with the following specificati=
ons:
=20
 The basic version also has:
=20
- - TI CC2538 + CC2592 Zigbee Wireless with upto 20dBm output power and Z=
igbee 3.0
+ - Zigbee module one from:
+   - TI CC2538 + CC2592 Zigbee 3.0 Wireless
+   - TI CC2652P1 Zigbee 3.0 Wireless
+   - Silicon Labs EFT32MG21 Zigbee 3.0/Thread Wireless
  - 1 x 1-Wire
  - 2 x RS-485
  - 4 x dry contact digital GPIO inputs
--=20
2.43.2


