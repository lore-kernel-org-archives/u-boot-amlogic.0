Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94FCA101F
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 19:56:04 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
 by mx.groups.io with SMTP id smtpd.web11.28642.1757534162355615444
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 12:56:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=T3e2AgML;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.178, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757534159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5JVcaE7vCeL61eWvB8tV6Gqo9iihOVqJlmHAGNIAtI=;
	b=T3e2AgMLsQc+NvFvhIaV60x9EKecgZ0BHisVLnZiiYgZBdPDd8FQ03AbHTRUkj8q260tUN
	YeaE+Jy3io1VqHmN01N41pxP/kzkvTlF8/z2HC3x2Ze+ul4RbXN3cIywLw84i+uYYn+EoJ
	MmyIGiMYhmLkm1AlKrx5sTLiRoVuVvVCU4JksdjTIt91pGzvpjukT0+UseS8QleRW209Uw
	Srdkj3qyaUawIF0qgzc9/XuhUcIjN/uxPFtZAavx4NELMY0LGMR82ZvZHMbDAY2o0WOcM4
	VNCumfJOYcFybbe+lmOeicMZ/uww9bMnKL/S15rgxhFQD4SEzBSBqe8EgJEXjw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 19:55:56 +0000
Message-Id: <DCPDV1COJB1M.1GDLXKLJ3GFJ2@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>, "Tom Rini" <trini@konsulko.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng Fan"
 <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino
 Galvani" <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 1/9] tools: mkimage: Add Amlogic Boot Image type
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Ferass El
 Hafidi" <funderscore@postmarketos.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-1-37395d9ff5af@postmarketos.org>
 <52510c5d-e4f5-47f4-9246-d13a5580958a@gmx.de>
In-Reply-To: <52510c5d-e4f5-47f4-9246-d13a5580958a@gmx.de>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 19:56:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2775

On Wed Sep 10, 2025 at 7:36 PM UTC, Heinrich Schuchardt wrote:
> <...>
>> +static void amlimage_print_header(const void *buf,
>> +				  struct image_tool_params *params)
>> +{
>> +	const struct amlimage_header *hdr =3D buf + HEADER_OFFSET;
>> +	uint8_t digest[SHA256_SUM_LEN];
>> +	sha256_context ctx;
>> +	bool valid;
>> +
>> +	printf("Amlogic Boot Image %" PRIu8 ".%" PRIu8 "\n",
>> +	       hdr->version_major, hdr->version_minor);
>> +	printf("Total size: %" PRIu32 "\n", hdr->total_size);
>> +	printf("Digest %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
>> +	       hdr->digest_type, hdr->digest_size, hdr->digest_offset);
>> +	printf("Key %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
>> +	       hdr->key_type, hdr->key_size, hdr->key_offset);
>> +	printf("Payload %" PRIu32 ": %" PRIu32 " @ 0x%" PRIx32 "\n",
>> +	       hdr->payload_type, hdr->payload_size, hdr->payload_offset);
>> +
>> +	sha256_starts(&ctx);
>
> Please, check the digest type before possibly calculating the wrong diges=
t.
>

As far as I know only 2 digest types are possible, from looking quickly at =
the
bootROM dump I have:

* SHA256 checksum =3D normal boot
* RSA signature =3D secure boot

Secure boot is explicitely not supported in amlimage right now.

>> +	/* Header and data is used as input for sha256 digest */
>> +	sha256_update(&ctx, (void *)hdr, hdr->header_size);
>> +	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
>> +	sha256_finish(&ctx, digest);
>> +
>> +	valid =3D !memcmp((void *)hdr + hdr->digest_offset,
>> +			digest, SHA256_SUM_LEN);
>
> Shouldn't the SHA256 check be in amlimage_verify_header()?
>
>> +
>> +	printf("Data: %" PRIu32 " @ 0x%" PRIx32 " - %s\n",
>> +	       hdr->data_size, hdr->data_offset, valid ? "OK" : "BAD");
>> +}
>> +
>> +static void amlimage_set_header(void *buf, struct stat *sbuf, int ifd,
>> +				struct image_tool_params *params)
>> +{
>> +	struct amlimage_header *hdr =3D buf + HEADER_OFFSET;
>> +	sha256_context ctx;
>> +
>> +	/* Use header size as initial size */
>> +	hdr->total_size =3D hdr->header_size;
>> +
>> +	/* Use sha256 digest (normal boot) */
>> +	hdr->digest_type =3D 0;
>> +	/* The sha256 digest is stored directly following the header */
>> +	hdr->digest_offset =3D hdr->total_size;
>> +	/* Unknown if this is used as block size instead of digest size */
>> +	hdr->digest_size =3D 512;
>
> Isn't this simply the SHA512 digest size?
>

As written above, SHA512 does not seem to be supported in the BootROM.

>> +	hdr->total_size +=3D hdr->digest_size;
>> +
>> +	/* Use key as padding so that payload ends up 4K aligned in TZRAM */
>> +	hdr->key_type =3D 0;
>> +	hdr->key_offset =3D hdr->total_size;
>> +	hdr->key_size =3D PAYLOAD_OFFSET - HEADER_OFFSET - hdr->key_offset;
>> +	hdr->total_size +=3D hdr->key_size;
>> +
>> +	/* With padding above payload will have a 0x1000 offset in TZRAM */
>> +	hdr->payload_type =3D 0;
>> +	hdr->payload_offset =3D hdr->total_size;
>> +	/* Payload size has already been copied from the variant header */
>> +	hdr->total_size +=3D hdr->payload_size;
>> +
>> +	/* Set the data range to be used as input for sha256 digest */
>> +	hdr->data_offset =3D hdr->digest_offset + SHA256_SUM_LEN;
>> +	hdr->data_size =3D hdr->total_size - hdr->data_offset;
>> +
>> +	sha256_starts(&ctx);
>> +	/* Header and data is used as input for sha256 digest */
>> +	sha256_update(&ctx, (void *)hdr, hdr->header_size);
>> +	sha256_update(&ctx, (void *)hdr + hdr->data_offset, hdr->data_size);
>> +	/* Write sha256 digest to the 32 bytes directly following the header *=
/
>> +	sha256_finish(&ctx, (void *)hdr + hdr->digest_offset);
>> +}
>> +
>> +static int amlimage_extract_subimage(void *buf,
>> +				     struct image_tool_params *params)
>> +{
>> +	const struct amlimage_header *hdr =3D buf + HEADER_OFFSET;
>> +
>> +	/* Save payload as the subimage */
>> +	return imagetool_save_subimage(params->outfile,
>> +				       (ulong)hdr + hdr->payload_offset,
>> +				       hdr->payload_size);
>> +}
>> +
>> +static int amlimage_check_image_type(uint8_t type)
>> +{
>> +	if (type =3D=3D IH_TYPE_AMLIMAGE)
>> +		return EXIT_SUCCESS;
>
> The image variant should either be checked here or in verify header.
>
> Best regards
>
> Heinrich
>

Thanks.

