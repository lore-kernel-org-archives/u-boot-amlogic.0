Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867BCE7719C
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.7576.1735941556519116260
 for <u-boot-amlogic@groups.io>;
 Fri, 03 Jan 2025 13:59:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=T1srsu5w;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=4402=t4=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1735941556; bh=JVrEO2ruGJmIJTTMe6T7ZoChM1biPPXfUeFUoMULAQE=;
 b=T1srsu5wkxjIajPzBmT+IsFUS5nCdUR0KamP4Lxfoi++ubmUtKwAWGKI7xBIhJHyBe6edITxl
 be6py75nT57dKF3ZgyCz1uuB+KRHKabvJosOfU5WL8WwOPg+SPhznBjTEl9BHVaYQ//1kfSRsHI
 YQM06qtvrRkfJUykvGLy+myCPLSYhoMHfR1KrULiJuFWyry0Exax3kI6us6LyPM8KOm7NzUW4JN
 0kg9yZ9iR0859nnJ0UBkDZ8uCHZ+0fcxFCYAckXYrfPBbEyxL16m2TVICgY2jZEGAz+sNx9CNUv
 u5/Y3/QztESiL0kduOdQd2u3EPBRo5sEGvlX3TRuhH2g==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Fri,
 03 Jan 2025 21:59:06 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
	u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
Date: Fri,  3 Jan 2025 21:58:58 +0000
Message-ID: <20250103215904.2590769-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103215904.2590769-1-jonas@kwiboo.se>
References: <20250103215904.2590769-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67785db1053722097e3f1003
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2601

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

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 MAINTAINERS      |   1 +
 boot/image.c     |   1 +
 include/image.h  |   1 +
 tools/Makefile   |   1 +
 tools/amlimage.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 250 insertions(+)
 create mode 100644 tools/amlimage.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6d..6a92daa489da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -181,6 +181,7 @@ F:	drivers/video/meson/
 F:	drivers/watchdog/meson_gxbb_wdt.c
 F:	include/configs/meson64.h
 F:	include/configs/meson64_android.h
+F:	tools/amlimage*
 F:	doc/board/amlogic/
 N:	meson
 
diff --git a/boot/image.c b/boot/image.c
index abac254e0264..814ad182a525 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
 	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
 	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
 	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
+	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
 	{	-1,		    "",		  "",			},
 };
 
diff --git a/include/image.h b/include/image.h
index 0a61dfd556c5..acad8997d190 100644
--- a/include/image.h
+++ b/include/image.h
@@ -232,6 +232,7 @@ enum image_type_t {
 	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a Legacy Image */
 	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
 	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
+	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
 
 	IH_TYPE_COUNT,			/* Number of image types */
 };
diff --git a/tools/Makefile b/tools/Makefile
index ee08a9675df8..0dbc429d6419 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -100,6 +100,7 @@ ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
 
 # common objs for dumpimage and mkimage
 dumpimage-mkimage-objs := aisimage.o \
+			amlimage.o \
 			atmelimage.o \
 			$(FIT_OBJS-y) \
 			$(FIT_SIG_OBJS-y) \
diff --git a/tools/amlimage.c b/tools/amlimage.c
new file mode 100644
index 000000000000..9af795602e69
--- /dev/null
+++ b/tools/amlimage.c
@@ -0,0 +1,246 @@
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
+	    hdr->magic == HEADER_MAGIC && hdr->header_size == HEADER_SIZE)
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
+	sha256_starts(&ctx);
+	/* Header and data is used as input for sha256 digest */
+	sha256_update(&ctx, (void *)hdr, hdr->header_size);
+	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
+	sha256_finish(&ctx, digest);
+
+	valid = !memcmp((void *)hdr + hdr->digest_offset,
+			digest, SHA256_SUM_LEN);
+
+	printf("Data: %" PRIu32 " @ 0x%" PRIx32 " - %s\n",
+	       hdr->data_size, hdr->data_offset, valid ? "OK" : "BAD");
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
2.47.1


