Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7531.1794235801975141240
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2026 06:50:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=PzRNVR9R;
 spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+uboot@0leil.net)
Received: from smtp-4-0001 (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZx4yk9z19JM;
	Mon,  9 Nov 2026 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1794235401;
	bh=079j4EZGhGYJAfatqnkt9CTx14T3J3oQavVkPsyNO1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PzRNVR9RaDv1oiDZX8SJTDdi0zT96bTLEtgA7/vmURk5f6iC+EV3tvLO5KcADv342
	 LY1JvB6kzhpq7zgHDkQc9Ff7GrQ5xzY9/ODpiKkxjFeP44wsK2P17RwbVyJz1k4Hjc
	 PdUBpYGA2FTeGRcwEoCL049lJlnmcmie2r88hXbVv/koP85GC6vJE7My8PoKk4x2vE
	 /q/4RJhZ1p56DpCNluK+okU5u/kqR7OkDcusgZ2DynFF9vvE9nCnUjctTm1Zlk58Xs
	 SJYwkJIUcIFRFgS2peazRklkKXtsILpkmx+AGl/Ili6IYFA01JFk2Qg7BA+pMExYxg
	 Sg4+j3vPPZzQQ==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZw6LhXzsQ5;
	Mon,  9 Nov 2026 15:43:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:43:09 +0100
Subject: [PATCH 2/2] doc: board/amlogic: jethub-j80: update shop link to .com
MIME-Version: 1.0
Message-Id: <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
In-Reply-To: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Viacheslav Bocharov <v@baodeep.com>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2026 15:41:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3146

From: Quentin Schulz <quentin.schulz@cherry.de>

Use .com domain as suggested by Viacheslav.

Fixes: 1a33ee41ecd2 ("doc: board/amlogic: jethub-j80: use redirect link directly")
Suggested-by: Viacheslav Bocharov <v@baodeep.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/amlogic/jethub-j80.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index c3800f9588aa..2e8b9a5dddb8 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -3,7 +3,7 @@
 U-Boot for JetHub J80 (S905W)
 =============================
 
-JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device
+JetHome Jethub H1 (https://jethome.com/h1) is a home automation controller device
 manufactured by JetHome with the following specifications:
 
  - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz

-- 
2.56.0

