Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE7FE77198
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 09:28:00 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.56041.1736155680188560206
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Jan 2025 01:28:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=kCslNqIB;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436341f575fso146306525e9.1
        for <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736155678; x=1736760478; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpyDlfdtJP4s/bmYmSnaWEzvafGgynmksLkJCofkDps=;
        b=kCslNqIBehsILVZ9D8MHKEY6DyXVnSG6dvMVzdnsp0o4xhGMOGQLBR8j0kSjZj1Irh
         Tvqahb3t5Om8FFtszrGMMrocagK5h71VlRlHofPRVokoojey+IQzMBnBCQtRLw3xz6Pt
         iktUl43mKgTkUgXZ1Abz8kY2eJ8y7PwszcsjcyNF7VyqCMmy4ubyVqMxfhnusyJ6nmHH
         R+6QLg/zZ6Yl+5Cnk9cdSRc+YTiEu94oxd57Ldqp7ddNIUVN048cy/klncWt/qiXTDkP
         jSMACLYGBUc+Kc/eLTGo0hm15nWFXbogDOQLKuEIp1+o4AOozSnX/aKGAWzsCDcBZQpQ
         BQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155678; x=1736760478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tpyDlfdtJP4s/bmYmSnaWEzvafGgynmksLkJCofkDps=;
        b=UyiUfUNRPJ48l/wFUpO/o3FUzCz5RCpn75Nqh7h9GHzf7UljA1L+ne7+X94AN8LmgQ
         MkXaqlGtv4Gxarb19qcZMxm6uzPvfASNcO0qr1XgeZr23eftuwdnBtim88crAozwLrSF
         SAfzJ2o1juQQVILO5FX44bZ9YKKLlCjpzuBONe/Xf5JbjK8JJz87ERCZiU09OQW2Uttj
         lBGJ2oe6iNkKg8409fBo5+16xDJ9E4HURXpuI1r4F2qHP40AEF81sbKQSk+e2j3ej6mB
         MPst5nB0ltrQwdYMcfPqKjHESNlXr55JW+7lKUIHcjjOsBxbQT9kQqPWAaBY3G4hKNOB
         w9vg==
X-Forwarded-Encrypted: i=1; AJvYcCWk88BuzST0KVAWoHrs3+mwxjqOaBxT/lwSHjbRoJdImEpC0cI6bz9txY9tMGGtpCbEXwAUUVmE0p4KTXt+zA==@groups.io
X-Gm-Message-State: AOJu0YylWyB5iL7058YbmK0ADMkCEJ2TRPvuXN5WOc/eQ3QCBXzuyPlt
	zb6jHwzALvS8ch7qroal6KbKBqfDgDx9tF37QCkwP+sCH54sOwhcs0fHpE2Hwrc=
X-Gm-Gg: ASbGncuspSV/qJ9mFq+GOUWAtLlzIcIf4mbJv/ySZH3xCDyv9mbt2OlH7/uoyDp+qF5
	FM4fQWny4zWn9EXkRjeVmhdRLjU8kWLBfpHpu00qdm7l+raFx0Tzg7XKlfb8sXRsh9Pbkj1UIxN
	HXjyvk0au8rI8oDTHCDxLE2eBlw7Bho0a7kE8/2yLKWmmJjI+C19O4vUqk6SYLhGkHPnlAc2s+p
	z1okQqxuaS+8cMfvuOSkda8NGbM0NCndJpJE+dS2Dlga5es3PFgOUppS4zvEzPTMPHeG28LcFjl
	aUzHkXDHklfYNP2PMe5y9g8G86p2
X-Google-Smtp-Source: AGHT+IEec6bGgniB4rumdApDAzMNyarW2AiXf7p952d9bwslwv14XqCy4zRnNcRbCOYCO/GP2j8k7w==
X-Received: by 2002:a05:600c:3146:b0:434:f817:4492 with SMTP id 5b1f17b1804b1-43668b5f887mr532411665e9.31.1736155678515;
        Mon, 06 Jan 2025 01:27:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:95:e905:1421:811c? ([2a01:e0a:982:cbb0:95:e905:1421:811c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea42esm571135945e9.9.2025.01.06.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 01:27:58 -0800 (PST)
Message-ID: <766f201c-df5d-4d94-88e9-e1d9b454a39b@linaro.org>
Date: Mon, 6 Jan 2025 10:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
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
In-Reply-To: <20250103215904.2590769-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 09:28:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2608

On 03/01/2025 22:58, Jonas Karlman wrote:
> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
> and SD-card.
> 
> Vendor BL2 have solved the issue with different offsets by considering
> where BL2 was loaded from to adjust the offset where BL3 is read from.
> 
> This provide a different solution to create a boot image that can be
> booted from both eMMC and SD-card and where the offset for reading next
> stage loader can be shared for both boot options.
> 
> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
> to the expected offset of 0x1000, into the padding area at offset 0x200
> when a normal GXBB boot image is created. A special GXBB eMMC header can
> then be created that have the payload offset point to this relocate
> code, BL1 will jump to this relocate code when booted from eMMC instead
> of the normal payload start. One effect of this is that the payload size
> limit must be reduced by 512 bytes on GXBB.
> 
> Example of how to use it:
>    # Create a normal boot image
>    tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
> 
>    # Create a boot image with a special eMMC header
>    tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
> 
>    # Write normal boot image to sector 1 of eMMC/SD-card
>    dd if=bl2.bin of=/path/to/dev bs=512 seek=1
> 
>    # Write eMMC header, 112 bytes, to start of eMMC
>    dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
> 
> Or with binman using something like:
>    binman {
> 	multiple-images;
> 
> 	u-boot-gxbb-sd {
> 		filename = "u-boot-gxbb-sd.bin";
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
> 
> 	u-boot-gxbb-emmc {
> 		filename = "u-boot-gxbb-emmc.bin";
> 		pad-byte = <0xff>;
> 
> 		mkimage {
> 			filename = "bl2-emmc.bin";
> 			args = "-n", "emmc", "-T", "amlimage";
> 
> 			blob-ext {
> 				filename = "bl2.bin";
> 			}
> 		};
> 	};
>    };
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>   tools/amlimage.c               | 37 ++++++++++++++++
>   2 files changed, 116 insertions(+)
>   create mode 100644 tools/amlimage-gxbb-relocate.c
> 
> diff --git a/tools/amlimage-gxbb-relocate.c b/tools/amlimage-gxbb-relocate.c
> new file mode 100644
> index 000000000000..3503805c460e
> --- /dev/null
> +++ b/tools/amlimage-gxbb-relocate.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright Contributors to the U-Boot project.
> +
> +/*
> + * The following commands can be used to reproduce the gxbb_relocate
> + * byte array in amlimage.c
> + *
> + * Start U-Boot CI docker container from U-Boot source code root folder:
> + *  docker run --rm -v $(pwd):/build -u uboot -it docker.io/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
> + *
> + * Run the following commands inside the docker container:
> + *  export PATH=/opt/gcc-13.2.0-nolibc/aarch64-linux/bin:$PATH
> + *  cd /build/tools
> + *
> + * Generate assembly code for the c code in this file:
> + *  aarch64-linux-gcc -nostdlib -ffreestanding -Os -S -o amlimage-gxbb-relocate.S amlimage-gxbb-relocate.c
> + *
> + * Manually remove 'mov x16, x2' and replace 'x16' with 'x2' on the last line.
> + *
> + * Compile assembly code and extract the AArch64 binary code:
> + *  aarch64-linux-as -o amlimage-gxbb-relocate.o amlimage-gxbb-relocate.S
> + *  aarch64-linux-objcopy -O binary -j .text amlimage-gxbb-relocate.o amlimage-gxbb-relocate.bin
> + *
> + * Print binary code as a byte array that can be copied into amlimage.c
> + *  hexdump -ve '1/1 "0x%.2x, "' amlimage-gxbb-relocate.bin | fold -w 72 && echo
> + *
> + * Remember to update assembly code below when byte array is updated.
> + */
> +
> +#include <stdint.h>
> +
> +#define TZRAM_BASE		0xd9000000
> +#define PAYLOAD_OFFSET		0x200
> +#define BL2_OFFSET		0x1000
> +#define BL2_BASE		(void *)(TZRAM_BASE + BL2_OFFSET)
> +#define BL2_SIZE		0xb000
> +
> +void _start(uint64_t x0, uint64_t x1)
> +{
> +	void (*bl2)(uint64_t, uint64_t) = BL2_BASE;
> +	uint64_t i, *dst = BL2_BASE, *src = BL2_BASE + PAYLOAD_OFFSET;
> +
> +	/* memmove payload from 0x1200 to 0x1000 offset in TZRAM */
> +	for (i = 0; i < BL2_SIZE / sizeof(*src); i++)
> +		*(dst + i) = *(src + i);
> +
> +	/* goto entry point with x0 and x1 reg intact */
> +	bl2(x0, x1);
> +}
> +
> +/*
> +	.arch armv8-a
> +	.file	"amlimage-gxbb-relocate.c"
> +	.text
> +	.align	2
> +	.global	_start
> +	.type	_start, %function
> +_start:
> +.LFB0:
> +	.cfi_startproc
> +	mov	x2, 4608
> +	movk	x2, 0xd900, lsl 16
> +	add	x3, x2, 45056
> +.L2:
> +	sub	x4, x2, #32768
> +	add	x2, x2, 8
> +	ldr	x5, [x2, -8]
> +	str	x5, [x4, 32256]
> +	cmp	x2, x3
> +	bne	.L2
> +	mov	x2, 4096
> +	movk	x2, 0xd900, lsl 16
> +	br	x2
> +	.cfi_endproc
> +.LFE0:
> +	.size	_start, .-_start
> +	.ident	"GCC: (GNU) 13.2.0"
> +	.section	.note.GNU-stack,"",@progbits
> +*/
> diff --git a/tools/amlimage.c b/tools/amlimage.c
> index 9af795602e69..43be1636ed11 100644
> --- a/tools/amlimage.c
> +++ b/tools/amlimage.c
> @@ -51,6 +51,7 @@ struct amlimage_variant {
>   		  .payload_size = size, } }
>   
>   static const struct amlimage_variant variants[] = {
> +	VARIANT("emmc", 1, 0, 0xb000 + PAYLOAD_OFFSET),
>   	VARIANT("gxbb", 1, 0, 0xb000),
>   	VARIANT("gxl",  1, 1, 0xb000),
>   	VARIANT("gxm",  1, 1, 0xb000),
> @@ -176,6 +177,17 @@ static void amlimage_set_header(void *buf, struct stat *sbuf, int ifd,
>   	hdr->data_offset = hdr->digest_offset + SHA256_SUM_LEN;
>   	hdr->data_size = hdr->total_size - hdr->data_offset;
>   
> +	/* Adjust offset and size in GXBB eMMC header */
> +	if (!strcmp("emmc", params->imagename)) {
> +		hdr->total_size -= PAYLOAD_OFFSET;
> +		/* Use offset to relocate code relative to eMMC header */
> +		hdr->payload_offset = 0x400 - HEADER_OFFSET;
> +		hdr->payload_size = hdr->total_size - hdr->payload_offset;
> +		/* Use 0x200 offset to exclude MBR from the data range */
> +		hdr->data_offset = 0x200 - HEADER_OFFSET;
> +		hdr->data_size = hdr->total_size - hdr->data_offset;
> +	}
> +
>   	sha256_starts(&ctx);
>   	/* Header and data is used as input for sha256 digest */
>   	sha256_update(&ctx, (void *)hdr, hdr->header_size);
> @@ -203,6 +215,22 @@ static int amlimage_check_image_type(uint8_t type)
>   	return EXIT_FAILURE;
>   }
>   
> +/*
> + * AArch64 binary code to relocate payload when booting from eMMC on GXBB.
> + *
> + * Payload is relocated from offset 0x1200 to 0x1000 in TZRAM, similar to:
> + * memmove(0xd9001000, 0xd9001200, 0xb000)
> + * goto 0xd9001000
> + *
> + * See amlimage-gxbb-relocate.c on how to reproduce the following byte array.
> + */
> +static const uint8_t gxbb_relocate[] = {
> +	0x02, 0x40, 0x82, 0xd2, 0x02, 0x20, 0xbb, 0xf2, 0x43, 0x2c, 0x40, 0x91,
> +	0x44, 0x20, 0x40, 0xd1, 0x42, 0x20, 0x00, 0x91, 0x45, 0x80, 0x5f, 0xf8,
> +	0x85, 0x00, 0x3f, 0xf9, 0x5f, 0x00, 0x03, 0xeb, 0x61, 0xff, 0xff, 0x54,
> +	0x02, 0x00, 0x82, 0xd2, 0x02, 0x20, 0xbb, 0xf2, 0x40, 0x00, 0x1f, 0xd6,
> +};
> +
>   static int amlimage_vrec_header(struct image_tool_params *params,
>   				struct image_type_params *tparams)
>   {
> @@ -213,6 +241,10 @@ static int amlimage_vrec_header(struct image_tool_params *params,
>   	/* Use payload offset as header size, datafile will be appended */
>   	tparams->header_size = PAYLOAD_OFFSET;
>   
> +	/* Only prepend 512 bytes for GXBB eMMC header */
> +	if (!strcmp("emmc", variant->name))
> +		tparams->header_size = 0x200;
> +
>   	tparams->hdr = calloc(1, tparams->header_size);
>   	if (!tparams->hdr) {
>   		fprintf(stderr, "%s: Can't alloc header: %s\n",
> @@ -223,6 +255,11 @@ static int amlimage_vrec_header(struct image_tool_params *params,
>   	/* Start with a copy of the variant header */
>   	memcpy(tparams->hdr + HEADER_OFFSET, hdr, hdr->header_size);
>   
> +	/* Insert relocate code to move payload from 0x1200 to 0x1000 on GXBB */
> +	if (!strcmp("gxbb", variant->name))
> +		memcpy(tparams->hdr + 0x200,
> +		       gxbb_relocate, sizeof(gxbb_relocate));
> +
>   	/* Pad up to payload size of the variant header */
>   	return hdr->payload_size - params->file_size;
>   }

Awesome work !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

