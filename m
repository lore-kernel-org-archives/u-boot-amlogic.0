Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E40CCD186
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 12:40:55 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
 by mx.groups.io with SMTP id smtpd.web10.14920.1759927245106020033
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 05:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=gAwBcW4t;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.187, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759927242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0uZUSuoN1NuMS8NEtYsqFJ6GI6IyRWWOKXp7U3/IMU=;
	b=gAwBcW4tP3iUNMDOcridwxP80zZ9lIPbr4riJAE/atdn+y09Q5f2xRww2KLKg+qq1zul4U
	po398E+fJ8blhdi9wyq1gj7agy0vMO3ADHyzGnOvoQuv5dJdzcQ+cYCvgX4wjl9Kr2DzJg
	wpLod5Ie4S6KXuArshUy4eYGtjoAc8o+IFZPWe0e3wTQvC6mA5gmVuqKyfmxzyH+LdyQpS
	XW2BWXtGiHd5IrPTZl2pfG8qv3n4ycQJpU6WhwwACMhqqthKc5xs/kTpBULY/YO9++n/2G
	eJ6eOqHgvg0C/kk4cgT3BbWsg9yTabDv1h4ZzWEZOlSNLLMZqPn8C4hBSAh+Ow==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 12:40:35 +0000
Message-Id: <DDCY4YMCYP90.3MQKZ9EDE3BFD@postmarketos.org>
Cc: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Viacheslav Bocharov" <adeep@lexina.in>, "Arseniy Krasnov"
 <avkrasnov@salutedevices.com>, "Ferass El Hafidi"
 <funderscore@tauchgang.dev>, <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH] arm: meson: add support for EFI capsule updates
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Evgeny Bachinin" <eabachinin@salutedevices.com>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>
References: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
 <girpxwudgtrs6rhwbttyppyns32ymlilwv22vv5hoyhuzqwa32@xim7uzulsinf>
In-Reply-To: <girpxwudgtrs6rhwbttyppyns32ymlilwv22vv5hoyhuzqwa32@xim7uzulsinf>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 12:40:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2799

On Wed Oct 8, 2025 at 12:20 PM UTC, Evgeny Bachinin wrote:
> <...>
>> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/a=
sm/arch-meson/boot.h
>> index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c=
01502a72773213b2 100644
>> --- a/arch/arm/include/asm/arch-meson/boot.h
>> +++ b/arch/arm/include/asm/arch-meson/boot.h
>> @@ -21,6 +21,8 @@ int meson_get_boot_device(void);
>> =20
>>  int meson_get_soc_rev(char *buff, size_t buff_len);
>> =20
>> +void meson_setup_capsule(void);
>> +
>
> minor: maybe, add kernel-doc description ?
> (up to you & maintainers)
>
>>  /**
>>   * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
>>   *
>> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
>> index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b2129=
91edea26de2987d4 100644
>> --- a/arch/arm/mach-meson/Makefile
>> +++ b/arch/arm/mach-meson/Makefile
>> @@ -2,7 +2,7 @@
>>  #
>>  # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
>> =20
>> -obj-y +=3D board-common.o sm.o board-info.o
>> +obj-y +=3D board-common.o sm.o board-info.o capsule.o
>>  obj-$(CONFIG_MESON_GX) +=3D board-gx.o
>>  obj-$(CONFIG_MESON_AXG) +=3D board-axg.o
>>  obj-$(CONFIG_MESON_G12A) +=3D board-g12a.o
>> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/bo=
ard-common.c
>> index 39774c43049a40ed11578086603717571bedd23b..df9f576e7d2a1ce77b9a9825=
9de4c3abf87784ed 100644
>> --- a/arch/arm/mach-meson/board-common.c
>> +++ b/arch/arm/mach-meson/board-common.c
>> @@ -145,6 +145,9 @@ int board_late_init(void)
>>  {
>>  	meson_set_boot_source();
>> =20
>> +	/* Generate dfu_string for EFI capsule updates */
>> +	meson_setup_capsule();
>> +
>
> How many AMlogic boards in the wild support DFU by default and 'EFI
> capsule updates'?
>
> I assume the answer: "not all boards", because meson arch does not
> select CONFIG_DFU (or similar) for all meson-boards by default in
> related Kconfig files. CMIIW, please.
>

As far as I know, many of the Amlogic boards' defconfigs enable
CONFIG_DFU...

> board-common.c - is a common file for any Amlogic board, hence any
> board-specific addition must be at least under ifdef guards.
> But ifdefs suggest that something wrong is here.
>

... but just to make sure, I think guarding this inside an #ifdef is a
good idea, just in case.

> From architecture p.o.v the board specific code should go in a strong
> implementation of, say, meson_board_late_init(), residing in your
> board_specific.c, where board_specific.c can be actually common for all
> your Libre Computer boards.
>

The goal of this patch is to make it unnecessary to add "board-specific"
code to support EFI capsule updates, which, chances are, would be mostly
copy-paste.  So that just enabling the required kconfigs would make
things work OOTB.

> P.S> sorry, if my assumption about question above is wrong.
>

No worries, I'm glad you took the time to review my patch in any case. :)

>
>>  	return meson_board_late_init();
>>  }
>> =20
>> diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule=
.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a798f8a3e8c3a8807720af4e=
f89ccfc20f22f2f8
>> --- /dev/null
>> +++ b/arch/arm/mach-meson/capsule.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
>> + */
>> +
>> +#include <dm.h>
>> +#include <asm/arch/boot.h>
>> +#include <efi_loader.h>
>> +#include <mmc.h>
>
> According to coding style, ABC order is needed here
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>

Overlooked, sorry!  I'll fix this for next revision

>> +
>> +/*
>> + * To be able to support multiple devices and flash to the correct one =
we need
>> + * to automatically generate the dfu_string and fw_name to match the de=
vice we
>> + * are booted from.  This is done by meson_setup_capsule() which is the=
n called
>> + * in board_late_init().  Right now we support EFI capsule updates on S=
PI flash,
>
> Extra space after `in board_late_init().  Right...`
> and `booted from.  This...`
>

As far as I know it's common in english to separate sentences with two
spaces.  So that's what I did there.

>> + * eMMC and SD cards.
>> + */
>> +struct efi_fw_image fw_images[] =3D {
>> +	{
>> +		.image_index =3D 1,
>> +	},
>> +};
>> +
>> +struct efi_capsule_update_info update_info =3D {
>> +	.dfu_string =3D NULL, /* to be set in meson_capsule_setup */
>> +	.num_images =3D ARRAY_SIZE(fw_images),
>> +	.images =3D fw_images,
>> +};
>> +
>> +/*
>> + * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
>> + */
>> +void meson_setup_capsule(void)
>> +{
>> +	static char dfu_string[32] =3D { 0 };
>> +	int mmc_devnum =3D 0; /* mmc0 =3D> SD card */
>> +	static uint32_t max_size =3D 0x2000; /* 4 MB */
>
> 1) JFYI, checkpatch warns:
> ```
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> #125: FILE: arch/arm/mach-meson/capsule.c:37:
> +	static uint32_t max_size =3D 0x2000; /* 4 MB */
> ```
>

I think uint32_t is fine here, but I can use u32 instead.

> 2) BTW, why is it static? Looks like it could be just local var
>
> 3) 0x2000 does not match 4 MB or I did not get.
>

0x2000 is 4 MB in MMC sectors.  If you multiply it by 512 bytes, you
will get 4 MB.

(I should mention that in the comment, this is only used for eMMC/SD
flashing)

>
>> +	uint32_t offset =3D 0x1; /* offset for flashing to eMMC/SD */
>
>
> ```
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> #126: FILE: arch/arm/mach-meson/capsule.c:38:
> +	uint32_t offset =3D 0x1; /* offset for flashing to eMMC/SD */
> ```
>
>
>> +	int boot_device =3D meson_get_boot_device();
>> +
>> +	switch (boot_device) {
>> +	case BOOT_DEVICE_EMMC:
>> +		mmc_devnum =3D 1; /* mmc1 is always eMMC */
>
> Is it intentional omission of `break;` here? If yes, I'd suggest to
> explicitly write (for readability): /* fall through */
>

Here it is intentional, yes.  I should make that clearer.

>
>> +	case BOOT_DEVICE_SD:
>> +		snprintf(dfu_string, 32, "mmc %d=3Du-boot.bin raw %d %d", mmc_devnum,=
 offset, max_size);
>> +		fw_images[0].fw_name =3D u"U_BOOT_MESON_MMC";
>> +		break;
>> +	case BOOT_DEVICE_SPI:
>> +		/* We assume there's only one SPI flash */
>> +		fw_images[0].fw_name =3D u"U_BOOT_MESON_SPI";
>> +		snprintf(dfu_string, 32, "sf 0:0=3Du-boot.bin raw 0 %d", max_size);
>> +		break;
>> +	default:
>> +		debug("Boot device %d unsupported\n", boot_device);
>
> minor:
> is it intended to execute below code in a case when boot device is
> unsupported? may be just return, here? or `/* fall through */` ?
>

I could return there, but this is quite minor, because if there's no
return there it'll just do `update_info.dfu_string =3D NULL` essentially.

But for clarity I'll add a return on the next revision.

Best regards,
Ferass

