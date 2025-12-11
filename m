Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF4D41D62
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 15:37:23 +0000 (UTC)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12195.1765467436723887682
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 07:37:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=VlOV6xHC;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.171, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1765467434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fnKm8RN8rjH9h6jlYjGbS9Agm0/wxPgDx40G7atpYqM=;
	b=VlOV6xHCGAFwQwB4GvfuTj/Lcer0o4DyZszpuHm8zNNww1fCQiJCeUQycFRCzlBee/BIQO
	lhBORKP8pPGsAvFfy5ODJ3Pjw2tTvlzk5Lv/99aT9kW3KdkgB5e0gZ1V6YxiWmBfetlZPx
	6pnkFoWXOCsnUzGIMOtVPoTq8eMHRIBuy2ofgWbqh4kZT+uwXH1Jc8dm/IyJjW6a/WfeUB
	h+Rm94YsJE/OGC5HcOZPOZYGcnmdOI+4pus1RCsboRil4eWizVCFcsWfcitAeVG5nMWuGb
	dp7Rk8WGn40dqt3L/TbxE2ul6fAOTWJZ9oS3GvEOXKcbKKtBoUMLur0ypGmhww==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 11 Dec 2025 15:37:00 +0000
Subject: [PATCH v4 1/2] arm: meson: add support for EFI capsule updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-meson-capsule-v4-1-59f126ba4115@postmarketos.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5083;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=tJzB8Nom5/x5krL8NHP7Yxt0YJhDtSo090pUUu98Mng=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuUoM/aWRjm1Y9jIGhvAgAto7glrz0aPXgcNS
 26+GEhGdGiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrlKAAKCRCEr8vQ14ma
 A/NXEACgJ/w9Xg/1lMG0I7lwoBsp6HkZNTVeJ54KpDx5+0Q1xGqq62R+pPcf1PZIsPfPw6yLxi+
 mxhBeawQmIuLYbvYTvHIlkAJhQfqCguqUgJLXwm1iRLNiGPTET4XDWAszzJUMjMdCjNB/OnUqRC
 j9hplWVItvHE+9HlaIg8hCgrTP7l0Yfk/EMU5T1oFu5MoqyBrRKF8WkqV1k+klCyNPwElGuQWVa
 jvB0aKrhwJps33iME1X0gvKDpuJwvSp5MzvEWV8isU4i1utvYXedbD8iBvhf5nAIUkWm3d0KyqQ
 M79WUzTZJ7sqYk4HSXy3cgJ1y4o87a8gJ9GIEROYsohIw21QEI5zorE0OCrz9aSpoLq3vj3+7bc
 4iq33u33mFtX8ST4GWQWkkluFMJBEPtGUUPiE/QGC2f0uFmkREzy192Cjz9/ukQsdtGsqaMp429
 usa7qJjGvfvF+nAh8uMLaXahKMnXSJZbAukh7XG6poEemYp4XNfeocw6xaUusmLD36jQWCuNFL2
 lZKg7MqcXfAhuK+UuBkxf/URqbGNP9E/5ZjbaRRxx9SUVHz6hSipbmWdYU252+cqd1pqdUaY8gM
 x+Slshaslhpnm3J/VpvsrSRmC7hoafI3v6I+YowmP88xjKLLUYmgKZ6RXGy3suNDT56NjqsaPDA
 AYLWnpsbJOVAxQQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 15:37:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2874

Previously, few Amlogic devices supported EFI capsule updates.
Generally only the Libre Computer ones with SPI flash supported it,
thanks to board-specific code.

This commit commonises capsule update support across supported
Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
and firmware name is automatically generated at runtime depending on
which device we are booted from.  Right now this supports flashing to
the eMMC/SD and SPI flash.

As usual, the capsule UUID is automatically generated.  You can get it
by enabling CONFIG_CMD_EFIDEBUG and running:

	=> efidebug capsule esrt
	========================================
	ESRT: fw_resource_count=1
	ESRT: fw_resource_count_max=1
	ESRT: fw_resource_version=1
	[entry 0]==============================
	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
	ESRT: fw_type=unknown
	ESRT: fw_version=0
	ESRT: lowest_supported_fw_version=0
	ESRT: capsule_flags=0
	ESRT: last_attempt_version=0
	ESRT: last_attempt_status=success
	========================================

Reviewed-by: Evgeny Bachinin <EABachinin@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/include/asm/arch-meson/boot.h |  2 ++
 arch/arm/mach-meson/Makefile           |  2 +-
 arch/arm/mach-meson/board-common.c     |  5 +++
 arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
index a11dfde719e..e66b45983fe 100644
--- a/arch/arm/include/asm/arch-meson/boot.h
+++ b/arch/arm/include/asm/arch-meson/boot.h
@@ -21,6 +21,8 @@ int meson_get_boot_device(void);
 
 int meson_get_soc_rev(char *buff, size_t buff_len);
 
+void meson_setup_capsule(void);
+
 /**
  * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
  *
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b91..640921e2b8e 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
 
-obj-y += board-common.o sm.o board-info.o
+obj-y += board-common.o sm.o board-info.o capsule.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 39774c43049..e8012604c33 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -145,6 +145,11 @@ int board_late_init(void)
 {
 	meson_set_boot_source();
 
+	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
+		/* Generate dfu_string for EFI capsule updates */
+		meson_setup_capsule();
+	}
+
 	return meson_board_late_init();
 }
 
diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
new file mode 100644
index 00000000000..6e968a59c2c
--- /dev/null
+++ b/arch/arm/mach-meson/capsule.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+
+#include <asm/arch/boot.h>
+#include <dm.h>
+#include <efi_loader.h>
+#include <mmc.h>
+
+/*
+ * To be able to support multiple devices and flash to the correct one we need
+ * to automatically generate the dfu_string and fw_name to match the device we
+ * are booted from. This is done by meson_setup_capsule() which is then called
+ * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
+ * eMMC and SD cards.
+ */
+struct efi_fw_image fw_images[] = {
+	{
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = NULL, /* to be set in meson_capsule_setup */
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+/*
+ * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
+ */
+void meson_setup_capsule(void)
+{
+	static char dfu_string[32] = { 0 };
+	int mmc_devnum = 0; /* mmc0 => SD card */
+	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
+	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
+	int boot_device = meson_get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_EMMC:
+		mmc_devnum = 1; /* mmc1 is always eMMC */
+		fallthrough;
+	case BOOT_DEVICE_SD:
+		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
+		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
+		break;
+	case BOOT_DEVICE_SPI:
+		/* We assume there's only one SPI flash */
+		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
+		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
+		break;
+	default:
+		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
+		return;
+	}
+	debug("EFI Capsule DFU string: %s", dfu_string);
+
+	update_info.dfu_string = dfu_string;
+}

-- 
2.51.2


