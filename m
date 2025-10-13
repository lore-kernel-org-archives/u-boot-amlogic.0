Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E461CCD18F
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 07:40:57 +0000 (UTC)
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
 by mx.groups.io with SMTP id smtpd.web10.48160.1760371613707379100
 for <u-boot-amlogic@groups.io>;
 Mon, 13 Oct 2025 09:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@salutedevices.com header.s=post header.b=oozObr9+;
 spf=pass (domain: salutedevices.com, ip: 176.109.96.46, mailfrom: eabachinin@salutedevices.com)
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 961AE40015;
	Mon, 13 Oct 2025 18:56:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 961AE40015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1760371005;
	bh=7HxfK8wxuYPnZ46+cv43F2A0imFKD7uFbXfw52FrLNI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=oozObr9+2g2XVJu9de8RIaef24Ge+GNwOBODoHRSuDvszYU3mSNyLThOf/x0493zg
	 eFTkaU7tQmpGW2brjFnkPqz9m0O4yNUpZeFI6i+4lpHztRBBXr6PKs3w9o8f9RdF4w
	 halUoOf8eQnj7jTAZQOd542TfVnRZJyoZa6N4zP72cF/Hg8qgeLzNQcImQ9Z2v//8J
	 b5Bdpfj8y8GmA0GMIJ7PfVnpYuO+tP8uYKmrcAL6z71nq1XxZqAVJVGNtQqVi/nUA/
	 KpxEgvehBjP8QOyf61qqjGv/D157Mi/QU/ncrVLRct1nNfG+pxYPmbviGjylQHirB/
	 krCVnTMPgl95A==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R13" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 13 Oct 2025 18:56:42 +0300 (MSK)
Date: Mon, 13 Oct 2025 18:56:41 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>, Tom Rini
	<trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, Viacheslav
 Bocharov <adeep@lexina.in>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Ferass El Hafidi <funderscore@tauchgang.dev>,
	<~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2] arm: meson: add support for EFI capsule updates
Message-ID: <b6d4pmkbz4xjbyj62ytbupledbql2p4ogm3jtvbwzapak5ykyz@varyesq35qq5>
References: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
MIME-Version: 1.0
In-Reply-To: <20251011-meson-capsule-v2-1-53a8be6595ce@postmarketos.org>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.6.129]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/13 15:03:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 71 0.3.71 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1, {Tracking_References_header}, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 197037 [Oct 13 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/13 14:30:00 #27909416
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/13 15:53:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 14 Oct 2025 07:40:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2810


Thank you

On Sat, Oct 11, 2025 at 06:16:23PM +0000, Ferass El Hafidi wrote:
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
> 
> Please note that flashing to the eMMC bootX partitions is not yet
> supported.
> ---
> Changes in v2:
>  - Don't run meson_setup_capsule unless CONFIG_DFU and CONFIG_EFI_LOADER
>    are enabled
>  - Coding style fixes
>  - Return when boot device is unsupported
>  - Link to v1: https://lore.kernel.org/r/20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org
> ---
>  arch/arm/include/asm/arch-meson/boot.h |  2 ++
>  arch/arm/mach-meson/Makefile           |  2 +-
>  arch/arm/mach-meson/board-common.c     |  5 +++
>  arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+), 1 deletion(-)
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
> index 39774c43049a40ed11578086603717571bedd23b..e8012604c33376ee031b89bbfcf16ef34d6dec73 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -145,6 +145,11 @@ int board_late_init(void)
>  {
>  	meson_set_boot_source();
>  
> +	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
> +		/* Generate dfu_string for EFI capsule updates */
> +		meson_setup_capsule();
> +	}
> +
>  	return meson_board_late_init();
>  }
>  
> diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6e968a59c2cf26db179e11caac1eb6c3f76b2d2c
> --- /dev/null
> +++ b/arch/arm/mach-meson/capsule.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
> + */
> +
> +#include <asm/arch/boot.h>
> +#include <dm.h>
> +#include <efi_loader.h>
> +#include <mmc.h>
> +
> +/*
> + * To be able to support multiple devices and flash to the correct one we need
> + * to automatically generate the dfu_string and fw_name to match the device we
> + * are booted from. This is done by meson_setup_capsule() which is then called
> + * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
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
> +	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
> +	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
> +	int boot_device = meson_get_boot_device();
> +
> +	switch (boot_device) {
> +	case BOOT_DEVICE_EMMC:
> +		mmc_devnum = 1; /* mmc1 is always eMMC */
> +		fallthrough;
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
> +		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
> +		return;
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

Reviewed-by: Evgeny Bachinin <EABachinin@salutedevices.com>


