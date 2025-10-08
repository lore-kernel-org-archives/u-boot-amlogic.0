Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84298CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 18:17:03 +0000 (UTC)
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
 by mx.groups.io with SMTP id smtpd.web11.14495.1759926410994396293
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 05:26:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=post header.b=D8/raX6J;
 spf=pass (domain: salutedevices.com, ip: 176.109.96.46, mailfrom: eabachinin@salutedevices.com)
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id A39AF4002A;
	Wed,  8 Oct 2025 15:20:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru A39AF4002A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1759926039;
	bh=JSxqoBRqdTgikUtPQMYVWsthV0TUGn4NfW/dGLe/zMw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=D8/raX6JTOc2yeLKl1JIzPwIWM5PxEm//49+Tf44ZO9yfSztPmhdsgYz4AbvionFd
	 csN58UCLZC7uccuYDrGlzxnMtm3jPeo/82aDnwvfmikjE6lZhacnfTCwHLHbA6Cp8r
	 hm1ioj/nhZkgebG+BBkIMEmuvjHMg5CDeVvHT8W2iMMZj/1lwqgu4gn9U0cZ5B0IwJ
	 5x5eKNWqrT8g2Pz8MwYFw0IzyxC+4UUIbGv+xXMYPoEDSbVV+chZlD7wdszL4hIA2L
	 UXGC8rZWBWWqpdZ9DJ8SEwIuONOVanGPCB3oCQlKqSkoAt0BZ6EBhcvpKxPcwH7rVU
	 Uwq/z9bYZ7ilQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R13" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 15:20:36 +0300 (MSK)
Date: Wed, 8 Oct 2025 15:20:36 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, Tom Rini
	<trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Viacheslav
 Bocharov <adeep@lexina.in>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Ferass El Hafidi <funderscore@tauchgang.dev>,
	<~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH] arm: meson: add support for EFI capsule updates
Message-ID: <girpxwudgtrs6rhwbttyppyns32ymlilwv22vv5hoyhuzqwa32@xim7uzulsinf>
References: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
MIME-Version: 1.0
In-Reply-To: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.6.129]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/08 09:50:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 69 0.3.69 3c9ee7b2dda8a12f0d3dc9d3a59fa717913bd018, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;docs.u-boot.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Macro_SMTPFROM_NOT_MATCHES_SMTP}, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 196899 [Oct 08 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/08 08:37:00 #27892411
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/08 09:50:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 18:17:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2804

Hello, see below, please

On Tue, Oct 07, 2025 at 07:10:07PM +0000, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
> 
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
> 
> As usual, the capsule UUID is automatically generated.  You can get it
> by enabling CONFIG_CMD_EFIDEBUG and running:
> 
> 	=> efidebug capsule esrt
> 	========================================
> 	ESRT: fw_resource_count=1
> 	ESRT: fw_resource_count_max=1
> 	ESRT: fw_resource_version=1
> 	[entry 0]==============================
> 	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
> 	ESRT: fw_type=unknown
> 	ESRT: fw_version=0
> 	ESRT: lowest_supported_fw_version=0
> 	ESRT: capsule_flags=0
> 	ESRT: last_attempt_version=0
> 	ESRT: last_attempt_status=success
> 	========================================
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
> Currently EFI capsule updates are only supported on the following
> Amlogic-based boards:
> 
>  - Libre Computer AML-S805X-AC
>  - Libre Computer AML-A311D-CC
>  - Libre Computer AML-S905D3-CC
> 
> This is done with board-specific configuration in board/libre-computer/.
> 
> With this patch, EFI capsule updates can now work on most of the other
> Amlogic boards supported by u-boot, such as the Libre Computer
> AML-S905X-CC, without the need for board-specific configuration
> beforehand.
> ---
>  arch/arm/include/asm/arch-meson/boot.h |  2 ++
>  arch/arm/mach-meson/Makefile           |  2 +-
>  arch/arm/mach-meson/board-common.c     |  3 ++
>  arch/arm/mach-meson/capsule.c          | 59 ++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
> index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c01502a72773213b2 100644
> --- a/arch/arm/include/asm/arch-meson/boot.h
> +++ b/arch/arm/include/asm/arch-meson/boot.h
> @@ -21,6 +21,8 @@ int meson_get_boot_device(void);
>  
>  int meson_get_soc_rev(char *buff, size_t buff_len);
>  
> +void meson_setup_capsule(void);
> +

minor: maybe, add kernel-doc description ?
(up to you & maintainers)

>  /**
>   * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
>   *
> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
> index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b212991edea26de2987d4 100644
> --- a/arch/arm/mach-meson/Makefile
> +++ b/arch/arm/mach-meson/Makefile
> @@ -2,7 +2,7 @@
>  #
>  # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
>  
> -obj-y += board-common.o sm.o board-info.o
> +obj-y += board-common.o sm.o board-info.o capsule.o
>  obj-$(CONFIG_MESON_GX) += board-gx.o
>  obj-$(CONFIG_MESON_AXG) += board-axg.o
>  obj-$(CONFIG_MESON_G12A) += board-g12a.o
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 39774c43049a40ed11578086603717571bedd23b..df9f576e7d2a1ce77b9a98259de4c3abf87784ed 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -145,6 +145,9 @@ int board_late_init(void)
>  {
>  	meson_set_boot_source();
>  
> +	/* Generate dfu_string for EFI capsule updates */
> +	meson_setup_capsule();
> +

How many AMlogic boards in the wild support DFU by default and 'EFI
capsule updates'?

I assume the answer: "not all boards", because meson arch does not
select CONFIG_DFU (or similar) for all meson-boards by default in
related Kconfig files. CMIIW, please.

board-common.c - is a common file for any Amlogic board, hence any
board-specific addition must be at least under ifdef guards.
But ifdefs suggest that something wrong is here.

From architecture p.o.v the board specific code should go in a strong
implementation of, say, meson_board_late_init(), residing in your
board_specific.c, where board_specific.c can be actually common for all
your Libre Computer boards.

P.S> sorry, if my assumption about question above is wrong.


>  	return meson_board_late_init();
>  }
>  
> diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a798f8a3e8c3a8807720af4ef89ccfc20f22f2f8
> --- /dev/null
> +++ b/arch/arm/mach-meson/capsule.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +
> +#include <dm.h>
> +#include <asm/arch/boot.h>
> +#include <efi_loader.h>
> +#include <mmc.h>

According to coding style, ABC order is needed here
https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

> +
> +/*
> + * To be able to support multiple devices and flash to the correct one we need
> + * to automatically generate the dfu_string and fw_name to match the device we
> + * are booted from.  This is done by meson_setup_capsule() which is then called
> + * in board_late_init().  Right now we support EFI capsule updates on SPI flash,

Extra space after `in board_late_init().  Right...`
and `booted from.  This...`

> + * eMMC and SD cards.
> + */
> +struct efi_fw_image fw_images[] = {
> +	{
> +		.image_index = 1,
> +	},
> +};
> +
> +struct efi_capsule_update_info update_info = {
> +	.dfu_string = NULL, /* to be set in meson_capsule_setup */
> +	.num_images = ARRAY_SIZE(fw_images),
> +	.images = fw_images,
> +};
> +
> +/*
> + * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
> + */
> +void meson_setup_capsule(void)
> +{
> +	static char dfu_string[32] = { 0 };
> +	int mmc_devnum = 0; /* mmc0 => SD card */
> +	static uint32_t max_size = 0x2000; /* 4 MB */

1) JFYI, checkpatch warns:
```
CHECK: Prefer kernel type 'u32' over 'uint32_t'
#125: FILE: arch/arm/mach-meson/capsule.c:37:
+	static uint32_t max_size = 0x2000; /* 4 MB */
```

2) BTW, why is it static? Looks like it could be just local var

3) 0x2000 does not match 4 MB or I did not get.


> +	uint32_t offset = 0x1; /* offset for flashing to eMMC/SD */


```
CHECK: Prefer kernel type 'u32' over 'uint32_t'
#126: FILE: arch/arm/mach-meson/capsule.c:38:
+	uint32_t offset = 0x1; /* offset for flashing to eMMC/SD */
```


> +	int boot_device = meson_get_boot_device();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_EMMC:
> +		mmc_devnum = 1; /* mmc1 is always eMMC */

Is it intentional omission of `break;` here? If yes, I'd suggest to
explicitly write (for readability): /* fall through */


> +	case BOOT_DEVICE_SD:
> +		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
> +		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
> +		break;
> +	case BOOT_DEVICE_SPI:
> +		/* We assume there's only one SPI flash */
> +		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
> +		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
> +		break;
> +	default:
> +		debug("Boot device %d unsupported\n", boot_device);

minor:
is it intended to execute below code in a case when boot device is
unsupported? may be just return, here? or `/* fall through */` ?

> +	}
> +	debug("EFI Capsule DFU string: %s", dfu_string);
> +
> +	update_info.dfu_string = dfu_string;
> +}
> 
> ---
> base-commit: 072264c4b3406aee50dad08355588577a547ab48
> change-id: 20251007-meson-capsule-a19539e0a54e
> 
> Best regards,
> -- 
> Ferass El Hafidi <funderscore@postmarketos.org>
> 

-- 
Best Regards,
Evgeny Bachinin

