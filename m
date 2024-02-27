Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3614FC54E51
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:09 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web10.7172.1709016964383657661
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Feb 2024 22:56:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@lexina.in header.s=dkim header.b=M3SHo7Cn;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4446E12F40C;
	Tue, 27 Feb 2024 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1709016962; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ta3AyTsxEaqnTGHWH/W2ZM+lr0IMFhDKPlBFe92WqCM=;
	b=M3SHo7CngWLRCg0GftNBQWD2LFpEwTque2VSe5akIvv/gainYLFwkWQbqJF2tuY6EDIipB
	pBz7PmTdeD25YmHTnFZe2zWYbFEwvBFUZgVVGWHSZUPebf0UnzFnW/YFuaUrOnV3k1eN7X
	aCqawul9sGzIMhkn87jRBtlMdij02Xd9flmR09a14chQoKbidOLwWayWN9TnXEVzUSz6fV
	sJDKV2tSPMCdA54OR6PsSUAVWFr85HmMa6lDSSQabV+jiT8qlNZBFC49oQbgLS8dWHVHDk
	J4MwK5Hyw797r16NdbDosY0ZgxdsG/uIxVTL9woQLjXKS25ZZ3Oa4txyOvYFRQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/3] board: amlogic: jethubj100: fix common config header
Date: Tue, 27 Feb 2024 09:54:04 +0300
Message-ID: <20240227065551.580199-2-adeep@lexina.in>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2146

Fix JetHub board sequence to read correct gpio for rescue button

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 include/configs/jethub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/jethub.h b/include/configs/jethub.h
index e22db4991de..2c44bfc853e 100644
--- a/include/configs/jethub.h
+++ b/include/configs/jethub.h
@@ -11,7 +11,7 @@
 #if defined(CONFIG_MESON_AXG)
 #define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
 	"bootcmd_rescue=3D" \
-		"if gpio input 10; then " \
+		"if gpio input periphs-banks10; then " \
 		"run bootcmd_mmc0; " \
 		"run bootcmd_usb0;" \
 		"fi;\0"
--=20
2.43.2


