Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94065CCD185
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 16:26:14 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
 by mx.groups.io with SMTP id smtpd.web11.22368.1760545573444250833
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Oct 2025 09:26:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=kU9Pc4Lm;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.183, mailfrom: funderscore@postmarketos.org)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760545571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6oTenigJiI1JMHrHt+j/9TUNy9ElkH/GDaShU1g6fw0=;
	b=kU9Pc4LmQOE1yJIUl2k/QM/k37VH0E9IKpd6/BWtat0reAPMKFXKfbzlJGutm+h1tv4R4t
	GdMrG81peSULlH033L9hA+UOQSPdok2JKMGZKVE86b//dH1ApHx2QCf+NQ57GJdojHRRGg
	pkxxtwogI2+u8PfZrYns1qYZCcfx8r5j4jJVtUrjpqquHxSLZtFBRN/7xLi/DNl9Zvc5CF
	a2mrNFDmax3GG0HM0+r/AZgxk61hfy3xXJceEQEF8hf7Qw/Jmqb+1uogymP5JuO+ABZOjV
	9tSST/gqvahRGCueKbasCraMdT4y5II02aYHpwGMIgZAeXGA6mdqL3mBpcYqsw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:48 +0000
Subject: [PATCH v4 1/8] tools: mkimage: Add Amlogic Boot Image type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-spl-gx-v4-1-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10862;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=f4IcBu4xiLrscVdNFjCp18/IIPJlcqatNyglggzTdyI=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sdOXBumow54O3dH584T1bfyYeA9ruluz0eg
 qo7UGNIcimJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHQAKCRCEr8vQ14ma
 A4fOEACcFGmJjsh8r7gCW//Z0gKUTj4X5DdtUICLX4GkKgEkPDeKBmJMAi4j4jxnmiKAyPZ5W+B
 sQpIlOJExwybJryw1rDwdhYxE8EO3s9+fxKYhLPlyEN9J4CWm8E6rsgJdOUGSFQidbEgd+dY/va
 JcT1rT7iNSsRF3akTFuHJGQKDdF7RRZyDFNZsj78Z5b41xJUx/P6/C7Vf6QQIoDM3NwB7Kff2Pw
 WirrIqu2tCm9b7FJzOzW28VErdbgQMpGnsjqOIvEsaQKvpuvtLLuqklbcupzkFlY8FYHu0vgM40
 s5jtLApedgsy11dZ2s9A01nCUIjhdXAh3SpWgirGrI0KojDMAiJi6yuYI6hLO0EUWIkD+l2qTSy
 iWmILJjORMYTQ0hraHeQSrFe0Q8O8cCL6ieQAa0X7n1SthXlTHgRqK0OGbwhClFOfasxaUEnCN7
 htKH335QkOMR+R5ED+KfiXXXhSdPreoNRrYP+zczbDfWZDR4/OycjfeCFp+SNkxRBstUts2JVXF
 p9/UYux10f+EEjShezjQ39gQ+bCOUJnFm2Qdqeq6f1Ndc1LWRjhrWDIDC/dVsxS/o4TB0PNQ1az
 gN+8k749ZFUXUgCcBI87tkb2Bxf6uFvEswOkamHxgEfw3riDLrgUj+rE2Y/cPzdwiHeNPoiA+s/
 cltMGJPFGZZjKhw==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 15 Oct 2025 16:26:14 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2811

From: Jonas Karlman <jonas@kwiboo.se>

Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
Amlogic AArch64 SoCs.

Images can optionally be signed for secure boot scenario, however
creation of signed images has not been implemented.

Example of how to use it:
  # Create an amlogic boot image
  tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin u-boot-amlogic.bin

  # List boot image header information
  tools/mkimage -l u-boot-amlogic.bin

  # Extract amlogic boot image payload
  tools/dumpimage -T amlimage -o bl2-payload.bin u-boot-amlogic.bin

Or with binman using something like:
  binman {
	u-boot-amlogic {
		filename = "u-boot-amlogic.bin";
		pad-byte = <0xff>;

		mkimage {
			filename = "bl2.bin";
			args = "-n", "gxbb", "-T", "amlimage";

			u-boot-spl {
			};
		};
	};
  };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
[Ferass: check digest type in _print_header, version in _verify_image]
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 MAINTAINERS      |   1 +
 boot/image.c     |   1 +
 include/image.h  |   1 +
 tools/Makefile   |   1 +
 tools/amlimage.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 259 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1db1070d5f8..e6c42bf1c7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -186,6 +186,7 @@ F:	drivers/video/meson/
 F:	drivers/watchdog/meson_gxbb_wdt.c
 F:	include/configs/meson64.h
 F:	include/configs/meson64_android.h
+F:	tools/amlimage*
 F:	doc/board/amlogic/
 N:	meson
 
diff --git a/boot/image.c b/boot/image.c
index abac2c7034b..dd96f712b6f 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -185,6 +185,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
 	{	IH_TYPE_TFA_BL31, "tfa-bl31",  "TFA BL31 Image", },
 	{	IH_TYPE_STM32IMAGE_V2, "stm32imagev2", "STMicroelectronics STM32 Image V2.0" },
+	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index b695cc39447..be6356c93d6 100644
--- a/include/image.h
+++ b/include/image.h
@@ -234,6 +234,7 @@ enum image_type_t {
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
 	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
 	IH_TYPE_STM32IMAGE_V2,		/* STMicroelectronics STM32 Image V2.0 */
+	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
diff --git a/tools/Makefile b/tools/Makefile
index 02297e8c93a..59e1b2285fe 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -110,6 +110,7 @@ ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
 
 # common objs for dumpimage and mkimage
 dumpimage-mkimage-objs := aisimage.o \
+			amlimage.o \
 			atmelimage.o \
 			$(FIT_OBJS-y) \
 			$(FIT_SIG_OBJS-y) \
diff --git a/tools/amlimage.c b/tools/amlimage.c
new file mode 100644
index 00000000000..ecb06bc535b
--- /dev/null
+++ b/tools/amlimage.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright Contributors to the U-Boot project.
+
+#include "imagetool.h"
+#include <u-boot/sha256.h>
+
+/*
+ * Image contain data in the following order:
+ *  Nonce	16 byte
+ *  Header	64 byte
+ *  Digest	32 byte
+ *  Padding	align up to 4K
+ *  Payload
+ */
+
+#define HEADER_MAGIC		0x4c4d4140	/* @AML */
+#define HEADER_OFFSET		0x10		/* 16 */
+#define HEADER_SIZE		0x40		/* 64 */
+#define PAYLOAD_OFFSET		0x1000		/* 4096 */
+
+struct amlimage_header {
+	uint32_t magic;
+	uint32_t total_size;
+	uint8_t header_size;
+	uint8_t root_key_index;
+	uint8_t version_major;
+	uint8_t version_minor;
+	uint32_t padding1;
+	uint32_t digest_type;
+	uint32_t digest_offset;
+	uint32_t digest_size;
+	uint32_t data_offset;
+	uint32_t key_type;
+	uint32_t key_offset;
+	uint32_t key_size;
+	uint32_t data_size;
+	uint32_t payload_type;
+	uint32_t payload_offset;
+	uint32_t payload_size;
+	uint32_t padding2;
+} __packed;
+
+struct amlimage_variant {
+	const char *name;
+	const struct amlimage_header hdr;
+};
+
+#define VARIANT(name, major, minor, size)	\
+	{ name, { .magic = HEADER_MAGIC, .header_size = HEADER_SIZE, \
+		  .version_major = major, .version_minor = minor, \
+		  .payload_size = size, } }
+
+static const struct amlimage_variant variants[] = {
+	VARIANT("gxbb", 1, 0, 0xb000),
+	VARIANT("gxl",  1, 1, 0xb000),
+	VARIANT("gxm",  1, 1, 0xb000),
+	VARIANT("axg",  1, 1, 0xb000),
+	VARIANT("g12a", 1, 1, 0xf000),
+	VARIANT("g12b", 1, 1, 0xf000),
+	VARIANT("sm1",  1, 1, 0xf000),
+};
+
+static const struct amlimage_variant *amlimage_get_variant(const char *name)
+{
+	if (!name)
+		return NULL;
+
+	for (int i = 0; i < ARRAY_SIZE(variants); i++)
+		if (!strcmp(name, variants[i].name))
+			return &variants[i];
+
+	return NULL;
+}
+
+static int amlimage_check_params(struct image_tool_params *params)
+{
+	const struct amlimage_variant *variant =
+		amlimage_get_variant(params->imagename);
+	int datafile_size;
+
+	if (params->lflag || params->iflag)
+		return EXIT_SUCCESS;
+
+	if (!variant) {
+		fprintf(stderr, "%s: unsupported image name: %s\n",
+			params->cmdname, params->imagename);
+		exit(EXIT_FAILURE);
+	}
+
+	datafile_size = imagetool_get_filesize(params, params->datafile);
+	if (datafile_size < 0) {
+		exit(EXIT_FAILURE);
+	} else if (datafile_size > variant->hdr.payload_size) {
+		fprintf(stderr, "%s: datafile is too large (%#x > %#x)\n",
+			params->cmdname, datafile_size,
+			variant->hdr.payload_size);
+		exit(EXIT_FAILURE);
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static int amlimage_verify_header(unsigned char *buf, int size,
+				  struct image_tool_params *params)
+{
+	const struct amlimage_header *hdr = (void *)buf + HEADER_OFFSET;
+
+	if (size >= HEADER_OFFSET + HEADER_SIZE + SHA256_SUM_LEN &&
+	    hdr->magic == HEADER_MAGIC && hdr->header_size == HEADER_SIZE &&
+	    hdr->version_major == 1 && hdr->version_minor <= 1)
+		return 0;
+
+	return -1;
+}
+
+static void amlimage_print_header(const void *buf,
+				  struct image_tool_params *params)
+{
+	const struct amlimage_header *hdr = buf + HEADER_OFFSET;
+	uint8_t digest[SHA256_SUM_LEN];
+	sha256_context ctx;
+	bool valid;
+
+	printf("Amlogic Boot Image %" PRIu8 ".%" PRIu8 "\n",
+	       hdr->version_major, hdr->version_minor);
+	printf("Total size: %" PRIu32 "\n", hdr->total_size);
+	printf("Digest %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
+	       hdr->digest_type, hdr->digest_size, hdr->digest_offset);
+	printf("Key %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
+	       hdr->key_type, hdr->key_size, hdr->key_offset);
+	printf("Payload %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
+	       hdr->payload_type, hdr->payload_size, hdr->payload_offset);
+
+	if (hdr->digest_type == 0) {
+		/* sha256 digest (normal boot) */
+		sha256_starts(&ctx);
+
+		/* Header and data is used as input for sha256 digest */
+		sha256_update(&ctx, (void *)hdr, hdr->header_size);
+		sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
+		sha256_finish(&ctx, digest);
+
+		valid = !memcmp((void *)hdr + hdr->digest_offset,
+				digest, SHA256_SUM_LEN);
+
+		printf("Data: %" PRIu32 " @ 0x%" PRIx32 " - %s\n",
+		       hdr->data_size, hdr->data_offset, valid ? "OK" : "BAD");
+	} else {
+		/* RSA (secure boot) */
+		printf("Data: %" PRIu32 " @ 0x%" PRIx32 " - Secure Boot\n",
+		       hdr->data_size, hdr->data_offset);
+	}
+}
+
+static void amlimage_set_header(void *buf, struct stat *sbuf, int ifd,
+				struct image_tool_params *params)
+{
+	struct amlimage_header *hdr = buf + HEADER_OFFSET;
+	sha256_context ctx;
+
+	/* Use header size as initial size */
+	hdr->total_size = hdr->header_size;
+
+	/* Use sha256 digest (normal boot) */
+	hdr->digest_type = 0;
+	/* The sha256 digest is stored directly following the header */
+	hdr->digest_offset = hdr->total_size;
+	/* Unknown if this is used as block size instead of digest size */
+	hdr->digest_size = 512;
+	hdr->total_size += hdr->digest_size;
+
+	/* Use key as padding so that payload ends up 4K aligned in TZRAM */
+	hdr->key_type = 0;
+	hdr->key_offset = hdr->total_size;
+	hdr->key_size = PAYLOAD_OFFSET - HEADER_OFFSET - hdr->key_offset;
+	hdr->total_size += hdr->key_size;
+
+	/* With padding above payload will have a 0x1000 offset in TZRAM */
+	hdr->payload_type = 0;
+	hdr->payload_offset = hdr->total_size;
+	/* Payload size has already been copied from the variant header */
+	hdr->total_size += hdr->payload_size;
+
+	/* Set the data range to be used as input for sha256 digest */
+	hdr->data_offset = hdr->digest_offset + SHA256_SUM_LEN;
+	hdr->data_size = hdr->total_size - hdr->data_offset;
+
+	sha256_starts(&ctx);
+	/* Header and data is used as input for sha256 digest */
+	sha256_update(&ctx, (void *)hdr, hdr->header_size);
+	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
+	/* Write sha256 digest to the 32 bytes directly following the header */
+	sha256_finish(&ctx, (void *)hdr + hdr->digest_offset);
+}
+
+static int amlimage_extract_subimage(void *buf,
+				     struct image_tool_params *params)
+{
+	const struct amlimage_header *hdr = buf + HEADER_OFFSET;
+
+	/* Save payload as the subimage */
+	return imagetool_save_subimage(params->outfile,
+				       (ulong)hdr + hdr->payload_offset,
+				       hdr->payload_size);
+}
+
+static int amlimage_check_image_type(uint8_t type)
+{
+	if (type == IH_TYPE_AMLIMAGE)
+		return EXIT_SUCCESS;
+
+	return EXIT_FAILURE;
+}
+
+static int amlimage_vrec_header(struct image_tool_params *params,
+				struct image_type_params *tparams)
+{
+	const struct amlimage_variant *variant =
+		amlimage_get_variant(params->imagename);
+	const struct amlimage_header *hdr = &variant->hdr;
+
+	/* Use payload offset as header size, datafile will be appended */
+	tparams->header_size = PAYLOAD_OFFSET;
+
+	tparams->hdr = calloc(1, tparams->header_size);
+	if (!tparams->hdr) {
+		fprintf(stderr, "%s: Can't alloc header: %s\n",
+			params->cmdname, strerror(errno));
+		exit(EXIT_FAILURE);
+	}
+
+	/* Start with a copy of the variant header */
+	memcpy(tparams->hdr + HEADER_OFFSET, hdr, hdr->header_size);
+
+	/* Pad up to payload size of the variant header */
+	return hdr->payload_size - params->file_size;
+}
+
+/*
+ * amlimage parameters
+ */
+U_BOOT_IMAGE_TYPE(
+	amlimage,
+	"Amlogic Boot Image",
+	0,
+	NULL,
+	amlimage_check_params,
+	amlimage_verify_header,
+	amlimage_print_header,
+	amlimage_set_header,
+	amlimage_extract_subimage,
+	amlimage_check_image_type,
+	NULL,
+	amlimage_vrec_header
+);

-- 
2.51.0


