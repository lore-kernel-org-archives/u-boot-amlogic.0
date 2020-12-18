Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.7492.1608284567134987081
 for <u-boot-amlogic@groups.io>;
 Fri, 18 Dec 2020 01:42:47 -0800
Received: by mail-wr1-f54.google.com with SMTP id t30so1454551wrb.0
        for <u-boot-amlogic@groups.io>; Fri, 18 Dec 2020 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rWjAeEtOXDa5d8yW88uulTvw7F7U7U+z+Rg+Cla3MVo=;
        b=xcn0o9ykZ/E6vWcG+b3B2Eu+/1IRL6OLOVkAGkhpRB3EBrfmyWPol4t2HSAcy1ueOg
         rBuYswIp61jvcMc7qUGVxeDL7DE9ACO6uTFA+oa8sBTgFK8RztZs0WHoPS/0v5DBWVTO
         extC4XYQJSZ2x4MOhFnBMIHTi+ZvBkFfxsKR1whbC1PS2ykFMXVOEkEUc0vKzwWx5yl/
         YSL9ZlxStxdHw8u5mVpZ0pMtdSyOeTuHUz1WSrIdo1knv0j38xdtnWAViOhN7ckxKNMv
         6jHXCZ+0dEUux0iQiLdXzzgVrIUaFlL+mSQyvVJ+rLR317uZdWtp9OwifAdIPRtjS/F7
         Fs2Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/5] boards: amlogic: add Beelink S922X board family support
References: <20201218084545.29135-1-christianshewitt@gmail.com>
 <20201218084545.29135-3-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9cc2d431-9bc1-fef4-eb4b-a726e9c9b6fb@baylibre.com>
Date: Fri, 18 Dec 2020 10:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <20201218084545.29135-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 18/12/2020 09:45, Christian Hewitt wrote:
> Copied from Odroid N2. Add myself as maintainer.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  board/amlogic/beelink-s922x/MAINTAINERS     |  9 ++++
>  board/amlogic/beelink-s922x/Makefile        |  6 +++
>  board/amlogic/beelink-s922x/beelink-s922x.c | 54 +++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 board/amlogic/beelink-s922x/MAINTAINERS
>  create mode 100644 board/amlogic/beelink-s922x/Makefile
>  create mode 100644 board/amlogic/beelink-s922x/beelink-s922x.c
> 
> diff --git a/board/amlogic/beelink-s922x/MAINTAINERS b/board/amlogic/beelink-s922x/MAINTAINERS
> new file mode 100644
> index 0000000000..7f223df4ae
> --- /dev/null
> +++ b/board/amlogic/beelink-s922x/MAINTAINERS
> @@ -0,0 +1,9 @@
> +BEELINK-S922X
> +M:	Christian Hewitt <christianshewitt@gmail.com>
> +S:	Maintained
> +L:	u-boot-amlogic@groups.io
> +F:	board/amlogic/beelink-s922x/
> +F:	configs/beelink-gtking_defconfig
> +F:	configs/beelink-gtkingpro_defconfig
> +F:	doc/board/amlogic/beelink-gtking.rst
> +F:	doc/board/amlogic/beelink-gtkingpro.rst
> diff --git a/board/amlogic/beelink-s922x/Makefile b/board/amlogic/beelink-s922x/Makefile
> new file mode 100644
> index 0000000000..27b1a74105
> --- /dev/null
> +++ b/board/amlogic/beelink-s922x/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2020 BayLibre, SAS
> +# Author: Neil Armstrong <narmstrong@baylibre.com>
> +
> +obj-y	:= beelink-s922x.o
> diff --git a/board/amlogic/beelink-s922x/beelink-s922x.c b/board/amlogic/beelink-s922x/beelink-s922x.c
> new file mode 100644
> index 0000000000..dc0d933a39
> --- /dev/null
> +++ b/board/amlogic/beelink-s922x/beelink-s922x.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2020 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <init.h>
> +#include <net.h>
> +#include <asm/io.h>
> +#include <asm/arch/sm.h>
> +#include <asm/arch/eth.h>
> +#include <asm/arch/boot.h>
> +
> +#define EFUSE_MAC_OFFSET	20
> +#define EFUSE_MAC_SIZE		12
> +#define MAC_ADDR_LEN		6
> +
> +int misc_init_r(void)
> +{
> +	u8 mac_addr[MAC_ADDR_LEN];
> +	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
> +	ssize_t len;
> +
> +	if (IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG) &&
> +	    meson_get_soc_rev(tmp, sizeof(tmp)) > 0)
> +		env_set("soc_rev", tmp);
> +
> +	meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
> +
> +	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> +		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> +					  efuse_mac_addr, EFUSE_MAC_SIZE);
> +		if (len != EFUSE_MAC_SIZE)
> +			return 0;
> +
> +		/* MAC is stored in ASCII format, 1bytes = 2characters */
> +		for (int i = 0; i < 6; i++) {
> +			tmp[0] = efuse_mac_addr[i * 2];
> +			tmp[1] = efuse_mac_addr[i * 2 + 1];
> +			tmp[2] = '\0';
> +			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
> +		}
> +
> +		if (is_valid_ethaddr(mac_addr))
> +			eth_env_set_enetaddr("ethaddr", mac_addr);
> +		else
> +			meson_generate_serial_ethaddr();
> +	}
> +
> +	return 0;
> +}
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
