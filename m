Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7521.1794235765491367135
 for <u-boot-amlogic@groups.io>;
 Mon, 09 Nov 2026 06:49:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=IsLtDMdF;
 spf=pass (domain: 0leil.net, ip: 84.16.66.175, mailfrom: foss+uboot@0leil.net)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZw23jnzwrB;
	Mon,  9 Nov 2026 15:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1794235399;
	bh=MQPH4cCVc0C3XntBaiPnwH1k/7rRjqypEm3DVUb3hpw=;
	h=From:Subject:Date:To:Cc:From;
	b=IsLtDMdFTnP1Gi+P8d/ZE5WcHtfwKJHd2Xg3phqYyarZxLnMHYw1WNhXL1vLSrX0/
	 w+TQ8FgJo0CBud+8KjYrosbiQiCp8b+Tp/d+19MmB/jr75P0/YHIXdJvunMKVADyuc
	 jAaauHDmMjeXPhy2LpvKR5kL5YScTHHIbUk3+YAnQOPsbsk2eNBPyf71A+eNlJNHsu
	 t5LNK5WyDh/j8EFgYVs2HJo7uA8gXI96t5D8YOs3TjPCy36mjcBkSi8+6TpNSTwWaT
	 t5c5Oz49TG3s51Nr604374MFg6xPrKbh3fDWIpTNu0t7Y52hYsduwksQ+6tTYiYcaH
	 HuxoFLHeMvdGA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZt4GfkzrQ6;
	Mon,  9 Nov 2026 15:43:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] doc: follow-up to linkcheck fixes series
Date: Mon, 09 Nov 2026 15:43:07 +0100
Message-Id: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMTQ6CMBAG0KtMvjWT0Ab86VUMC61TGWla0oqaE
 O5u1OXbvBVVikqFoxVFnlo1JzgyDcGP53QT1iscwbZ2Z0x75Khp8qP4iUOOMb94mXkfDqGzvfS
 2EzSEuUjQ9289DX/X5XIX//hW2LYPH5ojlncAAAA=
X-Change-ID: 20261109-linkcheck-follow-up-7f8f425e524e
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Viacheslav Bocharov <v@baodeep.com>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <u-boot-amlogic@groups.io>; Mon, 09 Nov 2026 15:41:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3148

I got some feedback on the v1 that I haven't addressed until now, so
here are the two requested changes, sorry for the delay.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      doc: arch/x86: update link to ACPI specs
      doc: board/amlogic: jethub-j80: update shop link to .com

 doc/arch/x86/x86.rst             | 2 +-
 doc/board/amlogic/jethub-j80.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261109-linkcheck-follow-up-7f8f425e524e

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

