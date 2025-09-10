Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36BECA1016
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:29 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by mx.groups.io with SMTP id smtpd.web10.28616.1757533465858686543
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 12:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@canonical.com header.s=20210705 header.b=oBLbj/oN;
 spf=pass (domain: canonical.com, ip: 185.125.188.123, mailfrom: heinrich.schuchardt@canonical.com)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 640D44196E
	for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757532974;
	bh=l5jUCXnuPHbhk/QtkfYJ9t7rCUJ0YYGJtLc6N9iPBLI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type;
	b=oBLbj/oNHZklBRx5Ktbmd05pYS2eYhGQfTAj+BkTkQm0pRVGZ1KXt4YKgrsH6gl2G
	 qgtjaz/B1ul6TQUSzWM1N9vMW11Nxkehv+8yCj0F0d1o6osMYacbx5HJIqARtXXYLw
	 bM2Ii/7ClWlsWFMFV+jCryLmrqO1WOwtdnwPmLu4PkE+Ni43KyruCkx/T9zN3eErSF
	 XMOGdS099SQYvsSt3UTFjv4U9joFqf15W5u7Cy5kmDjO4wJSrBn0GwktsuAM1xcXJh
	 aHYDYOKRGbWVghhSlXDe3HCbnvFXOiRHG+h4kTnlvZYYIWYSzT4HanL9NyqVVZfAv6
	 VlU2CeQNKMd2A==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso6564505e9.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 12:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532974; x=1758137774;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5jUCXnuPHbhk/QtkfYJ9t7rCUJ0YYGJtLc6N9iPBLI=;
        b=pVw+6xe65SkUFzIoWXDfzqMFyArMZEU/hu30btPIlT7mG2W9LMn41PHMRBIvDEmYsL
         uzkseeF7rgQcncLSFDRTmCnnIkMNPPD/4h5FmrJ0oZiNJypXDPRutBij2khYs1Ly/3lF
         bx51GmlctSkRTnubKLxu9tl/8yIMgcbhsYQpQbHcfOr0jxSzDjOJMCUJRmYFJKAXccn6
         oCCdPojfwC7MZkYtLNKF/gAnNzRLT3qL2TzIxnxrvz8EFIw08Ytmf4yqGlXQ3IZJO+3K
         +pCMdNCGmA0dbTKNd25G3s2RsehvokGwMuELH2fu1rXqk/txOleTSjAd9x5/itR8XtOH
         eknA==
X-Forwarded-Encrypted: i=1; AJvYcCX5S7qcjAwYFc8paAezAsvuPUv7MfGmOTxlZj1eJqWgCKzm7jVot9AI9tkgT3MXiY5reqf85l2LaACm0vi3lw==@groups.io
X-Gm-Message-State: AOJu0YwhUchzsJQfCLHz24RSvoTwRVoJBEl1wNRI7USFVWGVsdhet2cj
	fH0GTe97l1lhGEKjW7+YzaeWSVxYYtwGGs/I1jzY2VMyJJRrSSy2ujF5lOFZfy4MPgeB7ijVCca
	KEjvkFz/nNpu3+WFAhaotM4mApjEkE7pRk8QCQjF99y7G7rfGoLkP+BbmxJMXlgauGpgOLDI76N
	q2
X-Gm-Gg: ASbGncs3dmZ3m6/JqgqcMZJCYlcNAhQ5uLap5BZ0DkXfm8RFzuDA3S8P224VzT3aaNQ
	pEPp76x8wtzjcnfgSvRAXr2HHqHP/ix68h4wIK6MQzE9YoeT4XjdxksSBlrIiYbOfiDQx2C5XOw
	Nfhwv+LKTgVFG4H1yhn11fkJtSYLanj7OfIFmznJYE+IPm9rzc32PII3QektMpbT+49oTMRJfMu
	0Kw9ag/li1ZxDGeZ6tpL7k6QaJPyMcMd9DwrmWHjo+WhDYmt6Do7nun7r4CzAirkVamlZeGzJG6
	lbR6d0fvDCZ22Pf82KQgDNj+0T7+lHtBHqf8FJYOy3oMx2sxdS7Nbg3NqufrqhdOfvWgJY52Bye
	kv7r5neUYcIQyZCFNd6Ft
X-Received: by 2002:a05:600c:a01:b0:45d:98be:eea6 with SMTP id 5b1f17b1804b1-45dfd5b7824mr7049965e9.3.1757532973580;
        Wed, 10 Sep 2025 12:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0/GfHfb7Aqurv2uCTS/DrjvYCCv6sE+9IoLMgKi7gZ+8OjGTDq6gohpIjxDAoCqChcPVAZQ==
X-Received: by 2002:a05:600c:a01:b0:45d:98be:eea6 with SMTP id 5b1f17b1804b1-45dfd5b7824mr7049725e9.3.1757532973093;
        Wed, 10 Sep 2025 12:36:13 -0700 (PDT)
Received: from [192.168.103.116] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224cd1dsm7977734f8f.56.2025.09.10.12.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:36:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <52510c5d-e4f5-47f4-9246-d13a5580958a@gmx.de>
Date: Wed, 10 Sep 2025 21:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/9] tools: mkimage: Add Amlogic Boot Image type
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-1-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-1-37395d9ff5af@postmarketos.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Sep 2025 12:15:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2778

On 9/7/25 16:36, Ferass El Hafidi wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> Amlogic AArch64 SoCs.
> 
> Images can optionally be signed for secure boot scenario, however
> creation of signed images has not been implemented.
> 
> Example of how to use it:
>    # Create an amlogic boot image
>    tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin u-boot-amlogic.bin
> 
>    # List boot image header information
>    tools/mkimage -l u-boot-amlogic.bin
> 
>    # Extract amlogic boot image payload
>    tools/dumpimage -T amlimage -o bl2-payload.bin u-boot-amlogic.bin
> 
> Or with binman using something like:
>    binman {
> 	u-boot-amlogic {
> 		filename = "u-boot-amlogic.bin";
> 		pad-byte = <0xff>;
> 
> 		mkimage {
> 			filename = "bl2.bin";
> 			args = "-n", "gxbb", "-T", "amlimage";
> 
> 			u-boot-spl {
> 			};
> 		};
> 	};
>    };

Thanks for adding the Amlogic image creation support to U-Boot.

What is the basis of the patch?
Documentation, reverse engineering, or existing code?

> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   MAINTAINERS      |   1 +
>   boot/image.c     |   1 +
>   include/image.h  |   1 +
>   tools/Makefile   |   1 +
>   tools/amlimage.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 250 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fb163aa1db1dba249e60b40ab3e785db4fde5d3..8ab16ea7fed9bf15733d9d4eff78e4c8a9d22420 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -186,6 +186,7 @@ F:	drivers/video/meson/
>   F:	drivers/watchdog/meson_gxbb_wdt.c
>   F:	include/configs/meson64.h
>   F:	include/configs/meson64_android.h
> +F:	tools/amlimage*
>   F:	doc/board/amlogic/
>   N:	meson
>   
> diff --git a/boot/image.c b/boot/image.c
> index abac2c7034b22b8a638d93899aff1d5465f938f1..dd96f712b6fbe6ba9f0de8739b37b6868bc14a25 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -185,6 +185,7 @@ static const table_entry_t uimage_type[] = {
>   	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
>   	{	IH_TYPE_TFA_BL31, "tfa-bl31",  "TFA BL31 Image", },
>   	{	IH_TYPE_STM32IMAGE_V2, "stm32imagev2", "STMicroelectronics STM32 Image V2.0" },
> +	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
>   	{	-1,		    "",		  "",			},
>   };
>   
> diff --git a/include/image.h b/include/image.h
> index b695cc39447b2ac86231f5eaf6ed20de3ced2543..be6356c93d6ec7b2daca226301546678c00faf4d 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -234,6 +234,7 @@ enum image_type_t {
>   	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
>   	IH_TYPE_TFA_BL31,		/* TFA BL31 image */
>   	IH_TYPE_STM32IMAGE_V2,		/* STMicroelectronics STM32 Image V2.0 */
> +	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
>   
>   	IH_TYPE_COUNT,			/* Number of image types */
>   };
> diff --git a/tools/Makefile b/tools/Makefile
> index 02297e8c93a3c8d00ad165639d5f070804e17ec2..59e1b2285fe3d8015ef0fd7d8b8597e7294233ab 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -110,6 +110,7 @@ ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
>   
>   # common objs for dumpimage and mkimage
>   dumpimage-mkimage-objs := aisimage.o \
> +			amlimage.o \
>   			atmelimage.o \
>   			$(FIT_OBJS-y) \
>   			$(FIT_SIG_OBJS-y) \
> diff --git a/tools/amlimage.c b/tools/amlimage.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9af795602e69bdd690db32ab3108cbde07f128a5
> --- /dev/null
> +++ b/tools/amlimage.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright Contributors to the U-Boot project.
> +
> +#include "imagetool.h"
> +#include <u-boot/sha256.h>
> +
> +/*
> + * Image contain data in the following order:
> + *  Nonce	16 byte
> + *  Header	64 byte
> + *  Digest	32 byte
> + *  Padding	align up to 4K
> + *  Payload
> + */
> +
> +#define HEADER_MAGIC		0x4c4d4140	/* @AML */
> +#define HEADER_OFFSET		0x10		/* 16 */
> +#define HEADER_SIZE		0x40		/* 64 */
> +#define PAYLOAD_OFFSET		0x1000		/* 4096 */
> +
> +struct amlimage_header {
> +	uint32_t magic;
> +	uint32_t total_size;
> +	uint8_t header_size;
> +	uint8_t root_key_index;
> +	uint8_t version_major;
> +	uint8_t version_minor;
> +	uint32_t padding1;
> +	uint32_t digest_type;
> +	uint32_t digest_offset;
> +	uint32_t digest_size;
> +	uint32_t data_offset;
> +	uint32_t key_type;
> +	uint32_t key_offset;
> +	uint32_t key_size;
> +	uint32_t data_size;
> +	uint32_t payload_type;
> +	uint32_t payload_offset;
> +	uint32_t payload_size;
> +	uint32_t padding2;
> +} __packed;
> +
> +struct amlimage_variant {
> +	const char *name;
> +	const struct amlimage_header hdr;
> +};
> +
> +#define VARIANT(name, major, minor, size)	\
> +	{ name, { .magic = HEADER_MAGIC, .header_size = HEADER_SIZE, \
> +		  .version_major = major, .version_minor = minor, \
> +		  .payload_size = size, } }
> +
> +static const struct amlimage_variant variants[] = {
> +	VARIANT("gxbb", 1, 0, 0xb000),
> +	VARIANT("gxl",  1, 1, 0xb000),
> +	VARIANT("gxm",  1, 1, 0xb000),
> +	VARIANT("axg",  1, 1, 0xb000),
> +	VARIANT("g12a", 1, 1, 0xf000),
> +	VARIANT("g12b", 1, 1, 0xf000),
> +	VARIANT("sm1",  1, 1, 0xf000),
> +};
> +
> +static const struct amlimage_variant *amlimage_get_variant(const char *name)
> +{
> +	if (!name)
> +		return NULL;
> +
> +	for (int i = 0; i < ARRAY_SIZE(variants); i++)
> +		if (!strcmp(name, variants[i].name))
> +			return &variants[i];
> +
> +	return NULL;
> +}
> +
> +static int amlimage_check_params(struct image_tool_params *params)
> +{
> +	const struct amlimage_variant *variant =
> +		amlimage_get_variant(params->imagename);
> +	int datafile_size;
> +
> +	if (params->lflag || params->iflag)
> +		return EXIT_SUCCESS;
> +
> +	if (!variant) {
> +		fprintf(stderr, "%s: unsupported image name: %s\n",
> +			params->cmdname, params->imagename);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	datafile_size = imagetool_get_filesize(params, params->datafile);
> +	if (datafile_size < 0) {
> +		exit(EXIT_FAILURE);
> +	} else if (datafile_size > variant->hdr.payload_size) {
> +		fprintf(stderr, "%s: datafile is too large (%#x > %#x)\n",
> +			params->cmdname, datafile_size,
> +			variant->hdr.payload_size);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static int amlimage_verify_header(unsigned char *buf, int size,
> +				  struct image_tool_params *params)
> +{
> +	const struct amlimage_header *hdr = (void *)buf + HEADER_OFFSET;
> +
> +	if (size >= HEADER_OFFSET + HEADER_SIZE + SHA256_SUM_LEN &&
> +	    hdr->magic == HEADER_MAGIC && hdr->header_size == HEADER_SIZE)
> +		return 0;
> +
> +	return -1;
> +}
> +
> +static void amlimage_print_header(const void *buf,
> +				  struct image_tool_params *params)
> +{
> +	const struct amlimage_header *hdr = buf + HEADER_OFFSET;
> +	uint8_t digest[SHA256_SUM_LEN];
> +	sha256_context ctx;
> +	bool valid;
> +
> +	printf("Amlogic Boot Image %" PRIu8 ".%" PRIu8 "\n",
> +	       hdr->version_major, hdr->version_minor);
> +	printf("Total size: %" PRIu32 "\n", hdr->total_size);
> +	printf("Digest %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
> +	       hdr->digest_type, hdr->digest_size, hdr->digest_offset);
> +	printf("Key %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
> +	       hdr->key_type, hdr->key_size, hdr->key_offset);
> +	printf("Payload %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
> +	       hdr->payload_type, hdr->payload_size, hdr->payload_offset);
> +
> +	sha256_starts(&ctx);

Please, check the digest type before possibly calculating the wrong digest.

> +	/* Header and data is used as input for sha256 digest */
> +	sha256_update(&ctx, (void *)hdr, hdr->header_size);
> +	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
> +	sha256_finish(&ctx, digest);
> +
> +	valid = !memcmp((void *)hdr + hdr->digest_offset,
> +			digest, SHA256_SUM_LEN);

Shouldn't the SHA256 check be in amlimage_verify_header()?

> +
> +	printf("Data: %" PRIu32 " @ 0x%" PRIx32 " - %s\n",
> +	       hdr->data_size, hdr->data_offset, valid ? "OK" : "BAD");
> +}
> +
> +static void amlimage_set_header(void *buf, struct stat *sbuf, int ifd,
> +				struct image_tool_params *params)
> +{
> +	struct amlimage_header *hdr = buf + HEADER_OFFSET;
> +	sha256_context ctx;
> +
> +	/* Use header size as initial size */
> +	hdr->total_size = hdr->header_size;
> +
> +	/* Use sha256 digest (normal boot) */
> +	hdr->digest_type = 0;
> +	/* The sha256 digest is stored directly following the header */
> +	hdr->digest_offset = hdr->total_size;
> +	/* Unknown if this is used as block size instead of digest size */
> +	hdr->digest_size = 512;

Isn't this simply the SHA512 digest size?

> +	hdr->total_size += hdr->digest_size;
> +
> +	/* Use key as padding so that payload ends up 4K aligned in TZRAM */
> +	hdr->key_type = 0;
> +	hdr->key_offset = hdr->total_size;
> +	hdr->key_size = PAYLOAD_OFFSET - HEADER_OFFSET - hdr->key_offset;
> +	hdr->total_size += hdr->key_size;
> +
> +	/* With padding above payload will have a 0x1000 offset in TZRAM */
> +	hdr->payload_type = 0;
> +	hdr->payload_offset = hdr->total_size;
> +	/* Payload size has already been copied from the variant header */
> +	hdr->total_size += hdr->payload_size;
> +
> +	/* Set the data range to be used as input for sha256 digest */
> +	hdr->data_offset = hdr->digest_offset + SHA256_SUM_LEN;
> +	hdr->data_size = hdr->total_size - hdr->data_offset;
> +
> +	sha256_starts(&ctx);
> +	/* Header and data is used as input for sha256 digest */
> +	sha256_update(&ctx, (void *)hdr, hdr->header_size);
> +	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
> +	/* Write sha256 digest to the 32 bytes directly following the header */
> +	sha256_finish(&ctx, (void *)hdr + hdr->digest_offset);
> +}
> +
> +static int amlimage_extract_subimage(void *buf,
> +				     struct image_tool_params *params)
> +{
> +	const struct amlimage_header *hdr = buf + HEADER_OFFSET;
> +
> +	/* Save payload as the subimage */
> +	return imagetool_save_subimage(params->outfile,
> +				       (ulong)hdr + hdr->payload_offset,
> +				       hdr->payload_size);
> +}
> +
> +static int amlimage_check_image_type(uint8_t type)
> +{
> +	if (type == IH_TYPE_AMLIMAGE)
> +		return EXIT_SUCCESS;

The image variant should either be checked here or in verify header.

Best regards

Heinrich

> +
> +	return EXIT_FAILURE;
> +}
> +
> +static int amlimage_vrec_header(struct image_tool_params *params,
> +				struct image_type_params *tparams)
> +{
> +	const struct amlimage_variant *variant =
> +		amlimage_get_variant(params->imagename);
> +	const struct amlimage_header *hdr = &variant->hdr;
> +
> +	/* Use payload offset as header size, datafile will be appended */
> +	tparams->header_size = PAYLOAD_OFFSET;
> +
> +	tparams->hdr = calloc(1, tparams->header_size);
> +	if (!tparams->hdr) {
> +		fprintf(stderr, "%s: Can't alloc header: %s\n",
> +			params->cmdname, strerror(errno));
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* Start with a copy of the variant header */
> +	memcpy(tparams->hdr + HEADER_OFFSET, hdr, hdr->header_size);
> +
> +	/* Pad up to payload size of the variant header */
> +	return hdr->payload_size - params->file_size;
> +}
> +
> +/*
> + * amlimage parameters
> + */
> +U_BOOT_IMAGE_TYPE(
> +	amlimage,
> +	"Amlogic Boot Image",
> +	0,
> +	NULL,
> +	amlimage_check_params,
> +	amlimage_verify_header,
> +	amlimage_print_header,
> +	amlimage_set_header,
> +	amlimage_extract_subimage,
> +	amlimage_check_image_type,
> +	NULL,
> +	amlimage_vrec_header
> +);
> 


