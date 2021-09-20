Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.10696.1632141017949765916
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Sep 2021 05:30:18 -0700
Received: by mail-wr1-f43.google.com with SMTP id d6so29071846wrc.11
        for <u-boot-amlogic@groups.io>; Mon, 20 Sep 2021 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67VR79Hlre0wN9kx4FJ0wVFceujGCiA3ZuQqcTxAtzE=;
        b=O6BDT/Cqq28tH955xAyeHB425MA4rC88b7ZfCNsdtMTYmcvH8faOxdjRhqYgv+uiUF
         Q1JfmDSc7qwLwb+IF/ZVgDiEyENeIA/Xqt4T+aX0M1A/ei4j6id1ssSjaBs/dKIeKe4f
         aBHvDe//xRhFf/lNxfkiJb8r3VglfAZ3n9bruVhDnaFqluS/WrqSd5sMMVuj/rWnRuaf
         yFE2jeQketDnE/pGSIkwlp83D9nXht33vsDuVNp2MlvrH03rrqEKdB5Yj3oqmsYeCHsD
         k32oV33HqjU6BafNYbCUgRs6vD+cizkPhSK8Ch5DJZTzPSjJWYWPG2BB2iwWfj18njfG
         ScnQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 1/3] ARM: amlogic: add JetHub common config header
References: <20210920084016.2536084-1-adeep@lexina.in>
 <20210920084016.2536084-2-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <6047e77a-ae95-7001-44f5-4f838634546b@baylibre.com>
Date: Mon, 20 Sep 2021 14:30:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210920084016.2536084-2-adeep@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 20/09/2021 10:40, Vyacheslav Bocharov wrote:
> JetHub devices uses its own boot sequence with "rescue" button
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  include/configs/jethub.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/configs/jethub.h
> 
> diff --git a/include/configs/jethub.h b/include/configs/jethub.h
> new file mode 100644
> index 0000000000..35f85095ac
> --- /dev/null
> +++ b/include/configs/jethub.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration for JetHome devices
> + * Copyright (C) 2021 Vyacheslav Bocharov
> + * Author: Vyacheslav Bocharov <adeep@lexina.in>
> + */
> +
> +#ifndef __JETHUB_CONFIG_H
> +#define __JETHUB_CONFIG_H
> +
> +#if defined(CONFIG_MESON_AXG)
> +#define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
> +	"bootcmd_rescue=" \
> +		"if gpio input 10; then " \
> +		"run bootcmd_usb0;" \
> +		"fi;\0"
> +#else
> +#define BOOTENV_DEV_RESCUE(devtypeu, devtypel, instance) \
> +	"bootcmd_rescue=" \
> +		"if test \"${userbutton}\" = \"true\"; then " \
> +		"run bootcmd_mmc0; " \
> +		"fi;\0"
> +#endif
> +
> +#define BOOTENV_DEV_NAME_RESCUE(devtypeu, devtypel, instance) \
> +	"rescue "
> +
> +#ifndef BOOT_TARGET_DEVICES
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(RESCUE, rescue, na) \
> +	func(MMC, mmc, 1) \
> +	func(MMC, mmc, 0) \
> +	BOOT_TARGET_DEVICES_USB(func) \
> +	func(PXE, pxe, na) \
> +	func(DHCP, dhcp, na)
> +#endif
> +
> +#include <configs/meson64.h>
> +
> +#endif /* __JETHUB_CONFIG_H */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
