Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1757E7719B
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 09:27:40 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.56037.1736155660021961488
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Jan 2025 01:27:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=f3NKEzRD;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso11981225f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736155658; x=1736760458; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKyXOnivH4YbjTi+6E4Og4CrAa6lwWJ2S0dBeCJzhhA=;
        b=f3NKEzRDPd+El8L0aJXbu437f4g2aHfQSCCgR7zD2qh1uW3GD3pQFrZ1DElYPOV2fS
         9/n3TVDNYsooq7HpxuQ2G5Pto1T6s66VVkGGnwUMgnOrP9Zswxlx6k8nXNnf+gGWsiTi
         jl2K1l0XgAsdnTBdgG+gKshF+3KDSbedbTn96gKeWlZYJcIwki6wDXQvwo5mdmXjbi5p
         nMC9tefaHISiFhynWujVQClWDzmWQJ7bifAhddlq2Ovhrk0toFmA9tLipiKP0bnhBaG2
         E8rVBHBBTK3FCNdm8PRRq889ll4YtD3hVbARdbemrhtnA6drl1jb8nP7qvjYuwzs7qg0
         RcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155658; x=1736760458;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKyXOnivH4YbjTi+6E4Og4CrAa6lwWJ2S0dBeCJzhhA=;
        b=aVicQ0Vf/9MNLUKjrdcVu8AsTB2quDhBlEd3XyJ7+r1haTMIjNYxm1vZ7nZT1elaJx
         aEfWcXLzC7i+0b6hh1SyiwvWrRvCs0vc8NUJDbea90yW5N6YIdZfgAvkE46olBM7GknW
         /LxqyFkWj+6AiHdCZ5Vf/dXOUeIY6KgClnsUZSFaFenibpoXX+qjFaDr1k6uUs1Sqlqm
         2/U4eCuXheSMwPIt4nEnT6fx3RYHYTffq3X2iDMFRvbw0pObdySmrtqi4UiTk7h4ihrb
         ecz/176jAcAi2QBFOnF0/KabqQQ1PHJwunIZW6mirHCiwrhPjUQpeXRtf6VMrt/6TRd8
         tyBg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0CtUai9BpzgLxhqaG6H+nCFMCqf22MHRkRQsUuwzoBStp2gvr/NdDM1SOSkUQpyPzei3CraITIS9QDKJ0Q==@groups.io
X-Gm-Message-State: AOJu0YxYy7+kvvQTdYjbB9ZTQP0GyBYE41eLX+g+QULH36YIwS73581Y
	DtqxIHfEOHO1voNU+mjUcj9n6T/XiqXsvv9B8DMjP+OH0VYGdm22cQrtSLrudPHCohsBXnKsWGH
	V
X-Gm-Gg: ASbGnctYnZfbunx2jX1S7SvH89FxRW4ktLuOU8rUoEMhg3QGYyqq979NFb9VUui29Pu
	FwyaZmKPFSEioEoGDs3jmRK/N65db4P+wrH9mT5siiowS5iwNVq+ZmK3z7sJTdd+uWVBvfb5eQW
	9fBOl0tG8Vd0aqYQxrSLHSufSSgJS71zFOfztGK2zyCO1uKXRH6I9VUWWJoKiZPJrefjnLL4jQI
	A5qFLGh7/aziE97TL/6xK7KCoMEwMEOfm+c0rJE4TIzLi44pQwTebQ3vwgW3lmtsOFPuaWVZnI0
	ffZGmpYcwbRmk/C7Ak5TsqA6FoCY
X-Google-Smtp-Source: AGHT+IF4LQ1ckak38oN61nDzkaRUWEBYQEVaZHNeo2p8Ty8Xh99C9WOdLkvAGjE4H0kyEoy8qVotwQ==
X-Received: by 2002:a5d:6d84:0:b0:385:f66a:4271 with SMTP id ffacd0b85a97d-38a221e24f4mr48031768f8f.4.1736155658353;
        Mon, 06 Jan 2025 01:27:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:95:e905:1421:811c? ([2a01:e0a:982:cbb0:95:e905:1421:811c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e8asm46770984f8f.37.2025.01.06.01.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 01:27:37 -0800 (PST)
Message-ID: <f06f4ee6-6b47-44e6-992b-a06617f3d237@linaro.org>
Date: Mon, 6 Jan 2025 10:27:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-2-jonas@kwiboo.se>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250103215904.2590769-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 09:27:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2607

On 03/01/2025 22:58, Jonas Karlman wrote:
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
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   MAINTAINERS      |   1 +
>   boot/image.c     |   1 +
>   include/image.h  |   1 +
>   tools/Makefile   |   1 +
>   tools/amlimage.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 250 insertions(+)
>   create mode 100644 tools/amlimage.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba31f86feb6d..6a92daa489da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -181,6 +181,7 @@ F:	drivers/video/meson/
>   F:	drivers/watchdog/meson_gxbb_wdt.c
>   F:	include/configs/meson64.h
>   F:	include/configs/meson64_android.h
> +F:	tools/amlimage*
>   F:	doc/board/amlogic/
>   N:	meson
>   
> diff --git a/boot/image.c b/boot/image.c
> index abac254e0264..814ad182a525 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -183,6 +183,7 @@ static const table_entry_t uimage_type[] = {
>   	{	IH_TYPE_FDT_LEGACY, "fdt_legacy", "legacy Image with Flat Device Tree ", },
>   	{	IH_TYPE_RENESAS_SPKG, "spkgimage", "Renesas SPKG Image" },
>   	{	IH_TYPE_STARFIVE_SPL, "sfspl", "StarFive SPL Image" },
> +	{	IH_TYPE_AMLIMAGE,   "amlimage",   "Amlogic Boot Image" },
>   	{	-1,		    "",		  "",			},
>   };
>   
> diff --git a/include/image.h b/include/image.h
> index 0a61dfd556c5..acad8997d190 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -232,6 +232,7 @@ enum image_type_t {
>   	IH_TYPE_FDT_LEGACY,		/* Binary Flat Device Tree Blob	in a Legacy Image */
>   	IH_TYPE_RENESAS_SPKG,		/* Renesas SPKG image */
>   	IH_TYPE_STARFIVE_SPL,		/* StarFive SPL image */
> +	IH_TYPE_AMLIMAGE,		/* Amlogic Boot Image */
>   
>   	IH_TYPE_COUNT,			/* Number of image types */
>   };
> diff --git a/tools/Makefile b/tools/Makefile
> index ee08a9675df8..0dbc429d6419 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -100,6 +100,7 @@ ROCKCHIP_OBS = generated/lib/rc4.o rkcommon.o rkimage.o rksd.o rkspi.o
>   
>   # common objs for dumpimage and mkimage
>   dumpimage-mkimage-objs := aisimage.o \
> +			amlimage.o \
>   			atmelimage.o \
>   			$(FIT_OBJS-y) \
>   			$(FIT_SIG_OBJS-y) \
> diff --git a/tools/amlimage.c b/tools/amlimage.c
> new file mode 100644
> index 000000000000..9af795602e69
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
> +	/* Header and data is used as input for sha256 digest */
> +	sha256_update(&ctx, (void *)hdr, hdr->header_size);
> +	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
> +	sha256_finish(&ctx, digest);
> +
> +	valid = !memcmp((void *)hdr + hdr->digest_offset,
> +			digest, SHA256_SUM_LEN);
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Via which tree this should be merged ?

Neil

