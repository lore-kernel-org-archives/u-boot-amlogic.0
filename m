Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web08.11157.1632061236061858864
 for <u-boot-amlogic@groups.io>;
 Sun, 19 Sep 2021 07:20:36 -0700
Received: by mail-wm1-f48.google.com with SMTP id f62-20020a1c1f41000000b0030b42643f72so5225440wmf.3
        for <u-boot-amlogic@groups.io>; Sun, 19 Sep 2021 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3pAuGqEAlJ4vRUPauZFdPnYWJGxULT/CLNlhfIxUAt4=;
        b=vAcrvr0BE2jd4EJG4Lt/9oUc1pWdJgWAOtNp+90UdwlxgTH0WFhiGPJ5l2qLzDW+/P
         F3G92ffqFLxvDUAtZRuu+mVC+pud0QNiY29xE0uK7vhWuPBsicXFY9Pa7XW7EfopDEyx
         DoxdKjtc3D6cLkEc4/F0bR0ZKqqdeFJu8Tb8oJQE9FLD0ZwVHQNPrwWCR+gj8nYI6i7w
         y3JYLAnOuQ1YEZJkFSaT0m50LS1YiZKGLNlpx+g3mnf7ZvO+LCtXEmURw+RBOiXextmb
         DKHmNkiiNNSZx/cRIFIld3F8aRApstBayUdLkIKifv18znaOO4ArQ7FIfGYGCc26q0Uw
         KyAA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/3] ARM: amlogic: add JetHub common config header
References: <20210919081823.2413970-1-adeep@lexina.in>
 <20210919081823.2413970-2-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <737c06df-99c2-57e6-e37f-496660916357@baylibre.com>
Date: Sun, 19 Sep 2021 16:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210919081823.2413970-2-adeep@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: fr
Content-Transfer-Encoding: 8bit
To: Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 19/09/2021 à 10:18, Vyacheslav Bocharov a écrit :
> JetHub devices uses its own boot sequence with "rescue" button.
> Add custom config header file that corrects boot order.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  include/configs/jethub.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/configs/jethub.h
> 
> diff --git a/include/configs/jethub.h b/include/configs/jethub.h
> new file mode 100644
> index 0000000000..09264f91a5
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
> +	func(RESCUE, mmc, 1) \

This should be:
	func(RESCUE, rescue, na) \

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

Neil
