Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C20D41D5F
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:31:03 +0000 (UTC)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12027.1765467055255601177
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:30:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=UyLcgXJL;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.184, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765467052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d8Syjthhi6f4g+ZUqaQk6KvJXVdBOtGoRJrcxPqoc1k=;
	b=UyLcgXJLaBUxEJrcTU96k9/aiWbRzf7FQRYcPSSJ1O3BzvamXrViLUjAvrGYOvJhpKAXh7
	R2wMF/keSmkqO13F02CrpagRzFHoVzrixsXsxfDWj9BAjkRS5CYszNfpYWdaWfWHqaowrS
	OVZQ55nKKjXd973wGRUYMUZMIRJf8KnZgVga41agH4/Za5qM7Zdm5fB2fUEGHR3+brjF8b
	/Ly9qdxeax4HTa/HJC4D1lE9gpUIrLoBT/VFgAXU1//02hA4oZiEJWypvaOeUvQffSunFN
	RPeTC9ODayzzBi9aVStljoJX95KiwI+uau323v7ZowwKXVvqJYUycWo8X2zM9g==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v3 0/2] Support EFI capsule updates across Amlogic boards
Date: Thu, 11 Dec 2025 15:30:40 +0000
Message-Id: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDjOmkC/3XMQQ6CMBCF4auQrq3pFArWlfcwLkodoFEo6WCjI
 dzdwsoYXf4ved/MCINDYsdsZgGjI+eHFPkuY7YzQ4vcXVMzKaQCISreI/mBWzPS447cgFa5RmF
 UgSx9xoCNe27e+ZK6czT58Nr4COv6T4rAgZdQqaaqC9toPI2ept6EG06e9j60bAWj/EAAvhGZE
 JWbQ42l0sr+QpZleQMOxq4h9gAAAA==
X-Change-ID: 20251007-meson-capsule-a19539e0a54e
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=sPlCRoXdB7zx+wHiXJ8/Q1cHN5lYdxSCXJx7QlHZTQk=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuOkkQ4LAPSB47hKx5sMUOfqfDUdt37HCBYAe
 T1ArqgDQ4OJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrjpAAKCRCEr8vQ14ma
 A31PD/4mdwTiTj73jfnHmVPTO+7WPQ+QdSDWCkMRmoB1Y2WFGQ3c9r8dOvHDscNVUtfToeYvHkk
 zdnMLLuuJPHjxNKFXEg/j4JFXb+NDN0w6EVXGd/vUJsKAfrZsaChVtJJ/poseyj7VOqvSsRIpkF
 WkMHAuVYw8m6cVYg2h4oIUQfqVkha1bsAO0j593ZJtbnzDETSV1dzL+3HapYxAFZpQE4/9bx1KO
 o+9wPg6Gq0pSrFlTvo7GBqyKywnT/SYRSIRYOt613Ro1SGPbhzt+PSmbNbStwu30DROp2PCevy8
 POHhq7DEpwYvJoyLi+dF2x0yLQtEX0YtwccUYxnqMXXMJZUq61TqGVUv6Qn5TONn4IA//baF0aY
 jObqJMu0+T7hH5Ium/wMqQ3hgfCDR6rubFrXpQHscFRCuAj8GekZeoD5KivSjalbcJnq2KStGrA
 YdFCF+KIB1lVz8TsGZB5W2+HBBOHU/V1ZlNTmttnG+UYywNmcjEa1008c/4kAX0LJV5MBB7SGxr
 LLvB5z7TEtGGuu7dW4ayUvMefltZx4/tppwaXXgVL76+sNWlOxwhPugs7GVpCkAyTMs40oyQ6/7
 0Lheyj9oDHBrRI+Vdp2eMoP5BLRwVBvBe5t3WBBZ6CHBXZZz1Y1hLzqASMmrqqviano8HZwYEXo
 YbsGhDj8wOaj+9Q==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:31:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2869

Currently EFI capsule updates are only supported on the following
Amlogic-based boards:

 - Libre Computer AML-S805X-AC
 - Libre Computer AML-A311D-CC
 - Libre Computer AML-S905D3-CC

This is done with board-specific configuration in board/libre-computer/.

With this patch, EFI capsule updates can now work on most of the other
Amlogic boards supported by u-boot, such as the Libre Computer
AML-S905X-CC, without the need for board-specific configuration
beforehand.

Please note that flashing to the eMMC bootX partitions is not yet
supported.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v3:
 - Remove board-specific Libre Computer EFI capsule support and use the
   common EFI capsule support code
 - Link to v2: https://lore.kernel.org/r/20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org

Changes in v2:
 - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
   are enabled
 - Coding style fixes
 - Return when boot device is unsupported
 - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org

---
Ferass El Hafidi (2):
      arm: meson: add support for EFI capsule updates
      board: libre-computer: use common Amlogic EFI capsule support

 arch/arm/include/asm/arch-meson/boot.h             |  2 +
 arch/arm/mach-meson/Makefile                       |  2 +-
 arch/arm/mach-meson/board-common.c                 |  5 ++
 arch/arm/mach-meson/capsule.c                      | 61 ++++++++++++++++++++++
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 14 -----
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 13 -----
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 14 -----
 7 files changed, 69 insertions(+), 42 deletions(-)
---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20251007-meson-capsule-a19539e0a54e

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>


