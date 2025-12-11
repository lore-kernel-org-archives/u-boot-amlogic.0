Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B20D41D5E
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:31:03 +0000 (UTC)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12033.1765467058407363457
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:30:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=aAR4RKGf;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.172, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765467056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILbUNCSnXyTaNoYPaOSIDMSyyOtGk0iOiYrCLWGNl1E=;
	b=aAR4RKGfPcsJKmz8NsI5yhcq35Bx9acQgDOONruSkJj8pS6CBjFtIuaoLo/ITTFHPx+RVe
	r/nxfxhKq+m3alTErfe94qgLN0orJ9lxICZKLm56dXtJ15TQiGSFFGGFtPBIo/CZ5fCx4P
	mANlHjPEpWGLw9eIVjIILZwpHxUlSxm/+ruNq00iSA3DnEA3UlJfZpj/3yDd8VAFoaAGh8
	+K35ZRexMGYevV80D+KCc2NYxZ/Z62AqHpV/xgYXHffe/Y8KJpQNeFa4JyMH87g5hK1lzv
	YBVAHfqYolBUF6uO+WowJtpgADYpMaaGKRDle9tpwOZ4pu+4FvAZgbjYJqZPiA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 11 Dec 2025 15:30:42 +0000
Subject: [PATCH v3 2/2] board: libre-computer: use common Amlogic EFI
 capsule support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-meson-capsule-v3-2-1cf15a2d2498@postmarketos.org>
References: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
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
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuOq1h5CwdBWr0S5H61zqKY2JJb7JalLHSbNI
 S6tocyeUhyJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrjqgAKCRCEr8vQ14ma
 AwiAD/95h/c5ZGCO8Xg70unzR3VLgZr5+Z4Rjn0Ye4FuPSX0gNWMQSkvFM6BSOfhWRLJhX3vtsf
 tXZqaw25RlO+urw6ceaWGpKGjv+YjPeQzlPYTAUckO9uXoz6VwuSVOrtOLJzp6sgqeWnFL95mlq
 4SHlIyExCHtM6TBzZJHBFFR4F6WX2H6HjGdfkKpFPopeGgk4ci1kS4dnglDTLRhZ5aKaPd0gFmR
 Tyxc0UzkHhOqxKYO9KcbeaN5p5z9oFsED/cqbMmLjxevja95wxQccMwuttR4H5aVmPf4meKKaNR
 5PxmpvvGRfQBVkUVc/ElY/57Uy2M9EaWcr/Caqqvh6iw+22y8LAdY1P6x5ByPPODLIRvwmUfI/L
 nWd7iSZfoKQ4I45cllvlHoiTOC0IlC6T3rfIETgKKUJvLqZaw668eKsrEcp2XV5Vn8+MFdILis7
 hgKkgySiQAQZvhSXEauRROXU1yH1OwS4Oz96AXfmGKNXa4VCTHl+o/EdkPIlpBWrtPrJKnaxErv
 p0K9VC7rTcSInyKNjB8UfcumUfjnQh66nc2faqTZAnFYTL5IzN0+3Zd3NcmD6s6SvP16YlyT6zZ
 5YhjGzjtm6WBxF/if2tJECYxKMajKVC18awBMcuyu8//tHjlQ0dSVD6lbyH2g1XwlUpaOb2MHqZ
 qN8Z/SbvsSHnlfg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:31:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2871

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


