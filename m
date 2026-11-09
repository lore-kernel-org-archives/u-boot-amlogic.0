Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7519.1794235763873938542
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2026 06:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=jtJapLX9;
 spf=pass (domain: 0leil.net, ip: 185.125.25.11, mailfrom: foss+uboot@0leil.net)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZx0KXkzy94;
	Mon,  9 Nov 2026 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1794235400;
	bh=+Za2trCwcMzQNuUaTUFlORbUPV/d785x+QRMa5g8rbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jtJapLX9cjf/ui6UB+eHAm/lbWaJVi3Dp0lrk6Rcc8UlX5FSG8ocZydTpmYxocHn5
	 LrwXFix+qdLHdt+D4qcluFUiNSW0jcuD3OLjfQTphOihnWNtxgTij1wRUnryOxz6Br
	 ndnxOJG+yFpIk9XLSoyhoJ/tYPvXeqA7ldhv9GKn490mIB/PMaMNGaEAG4GOHydOAO
	 QrKPebeFbudCd8sZ5x2H82oh2sifJQq0lACjcgWI/qkTAiQf/nsNxPen8uUa1JW2b6
	 is42nd5TAaB1yV0snuEUNqlfxuCKaDKnShIE5ebjolVv9OB2GfV70z9X37SG9Efhcv
	 DVp2xZW6oWcbw==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZw08FHzsGl;
	Mon,  9 Nov 2026 15:43:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:43:08 +0100
Subject: [PATCH 1/2] doc: arch/x86: update link to ACPI specs
MIME-Version: 1.0
Message-Id: <20261109-linkcheck-follow-up-v1-1-64ee7d115a6c@cherry.de>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
In-Reply-To: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2026 15:41:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3145

From: Quentin Schulz <quentin.schulz@cherry.de>

The current link is only for outdated ACPI specs, so update to the link
that shows the latest versions of the specifications.

Fixes: 3b17ef9f7121 ("doc: arch/x86: update link to ACPI")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 9ba5c2893379..e8d753d1c7be 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -486,4 +486,4 @@ TODO List
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
 .. _SeaBIOS: https://www.seabios.org/
-.. _ACPI: https://uefi.org/acpi/specs
+.. _ACPI: https://uefi.org/specifications

-- 
2.56.0

