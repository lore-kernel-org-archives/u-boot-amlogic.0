Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F634D41D5F
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:37:23 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12124.1765467438166072324
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:37:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=G45L/6md;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.176, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765467436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILbUNCSnXyTaNoYPaOSIDMSyyOtGk0iOiYrCLWGNl1E=;
	b=G45L/6mdxa4CJWH5cYWJdRwHYK9iZchZrvBUmZbbabK3ooHb5mpn6SqTLuyKdZkHzH+kIf
	0gtEhHlOjXdbRcPk3BhevBtONwRO6Ma3Nef1LNE8GXnwPfFY+V94+d+kuVh8kgvjourOaF
	6uvZeKUs7hhBw04ZXaaBFD16PmhSnC6V0pnVDblMLxGxLDUBDA6OvIBdynLBqK9Ojt8XUf
	jzcdVMj6+bvvSi2J0sHg1I8mImF+XWKyq497dd0LmrvzBtUS27m9593tZOc9XLonNebels
	TIVLV2aABzz7LV1FBxgJ7OuwEeNg09dE3jLaU+BVP2go5tiCBtP0x8NnYgvEEQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 11 Dec 2025 15:37:01 +0000
Subject: [PATCH v4 2/2] board: libre-computer: use common Amlogic EFI
 capsule support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-meson-capsule-v4-2-59f126ba4115@postmarketos.org>
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=pGecB8zpcy7zi63OWMn2x/h8ilsFDzwbIHRXYOEsaew=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuUoMVYqJkra/dGJzP7jGxiFR4yr6jwWzaxNY
 ARps2nTD66JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrlKAAKCRCEr8vQ14ma
 A9bED/45Yu+bjw44e4XCGj3lR6QEt2Ai4+Hag9Pv2nM6EcAIwcsvjydywRK3ODJgcUUELl1qmdD
 9zcZF1dapRazlgcRvoL25vxkUtEwhxgBAu30rrCCZ0iDIVEv6oskOT5bj1V7NBBFy45d3KwUlzN
 0pYmZCfqlpwKb2Nrr2vAu/3QF/95EMNbGfoRvQHvC+J12nswI4RIFfTsID4Au/Bch7GewRvNOhS
 h7Fu3Xl1fMCAbT7HZHrLJK0+/ysCBo2vXONAlRq3WYEooWptxP/hsNTUVOcG7uzCgsBtZE5mCJH
 TBrhPmG2hilxHpNPZpdKf9OYWMOGAldl3Ww72ENXbeEw+MPJSBsw9lhdkAXn5isUvW12+S6EOM5
 PK6hLAS16DKZidYVGi2By98pHTsFGzDGyUC3oY/wQQjG5mA/Uri89z6g3TwHxAbtPKdPBxDRxuR
 dmWnNsdC47mMgKb5HE68+ONpuLGt8dQivLb1ffs3QBaoSMGYpjjYxQsxEfKjmK1yvXAL/bjtqip
 xQ3206seDO9+SkPAjkYTV4UeXSKQBSGHxINXF7R9C945v4wmrqk6e3jvixAz88XmDLigpseGnsK
 aD12Gyi/+BapGB7+zz1/v5uBfAwzLscbw8hNJV3FTpFdSdDHUdpfpBuVFzVxvrePMfXS/FKywCU
 Rfw4tzK/Bza95VQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:37:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2875

Remove the board-specific capsule support code, as we now support EFI
capsules across multiple Amlogic boards without the need for that.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 14 --------------
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 13 -------------
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 14 --------------
 3 files changed, 41 deletions(-)

diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
index b3b78bfd0ea..760dc740004 100644
--- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
+++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
@@ -12,20 +12,6 @@
 #include <asm/io.h>
 #include <asm/arch/eth.h>
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_A311D_CC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index daece299848..966fd287878 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -20,19 +20,6 @@
 #define EFUSE_MAC_OFFSET	52
 #define EFUSE_MAC_SIZE		6
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_S805X_AC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
index 09a69b090ab..760dc740004 100644
--- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
+++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
@@ -12,20 +12,6 @@
 #include <asm/io.h>
 #include <asm/arch/eth.h>
 
-struct efi_fw_image fw_images[] = {
-	{
-		.fw_name = u"AML_S905D3_CC_BOOT",
-		.image_index = 1,
-	},
-};
-
-struct efi_capsule_update_info update_info = {
-	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
-	.num_images = ARRAY_SIZE(fw_images),
-	.images = fw_images,
-};
-
-
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {

-- 
2.51.2


