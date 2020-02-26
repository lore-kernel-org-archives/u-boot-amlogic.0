Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.6030.1582712377304276124
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 02:19:38 -0800
Received: by mail-wr1-f66.google.com with SMTP id e8so2256720wrm.5
        for <u-boot-amlogic@groups.io>; Wed, 26 Feb 2020 02:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KuSTsbSjqiu2Uchv7CLVBvSZSxoEPwZKB4RcdX/N8kw=;
        b=qO1HQ0ocgsnn46JStdl5IAVRnVi0VeGUuMmAmZ99J9lyCb6hP2t/yG2sdzfDsS+cKf
         p2QwT70UZf2hR9Y82EEbOg3/naR28Fb1enxtI9CLh6FNjuZHv3H6i6OBlACVxCkllyeh
         HLS/7x5n5scQHdASSHKs4cTQd0woZK9OFaOoj0eyJfBtTG5BRyzKAL1OMd9sf1qIMSE9
         naRdENcM0ecKjgorzvY7+BX54XZM5UhFimSYDzHaQ97lsIqb0Eo5edvKFHJDYaWfLTBR
         MpCPgnSPwT1krAyWxd4HbdsP0H5rS0PxeNAy7kN6iM22YgI/xL3KcJwP9+WX33EyuAc1
         J24g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
References: <20200224222133.972-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bf360136-3bbc-42bd-ddf8-c48557ecd557@baylibre.com>
Date: Wed, 26 Feb 2020 11:19:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200224222133.972-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 24/02/2020 =E0 23:21, Heinrich Schuchardt a =E9crit :
> Add support for the hardware random number generator of Amlogic SOCs.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/rng/Kconfig     |   8 +++
>  drivers/rng/Makefile    |   1 +
>  drivers/rng/meson-rng.c | 120 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/rng/meson-rng.c
>=20
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index c1aa43b823..edb6152bb9 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -8,6 +8,14 @@ config DM_RNG
>=20
>  if DM_RNG
>=20
> +config RNG_MESON
> +	bool "Amlogic Meson Random Number Generator support"
> +	depends on ARCH_MESON
> +	default y
> +	help
> +	  Enable support for hardware random number generator
> +	  of Amlogic Meson SoCs.
> +
>  config RNG_SANDBOX
>  	bool "Sandbox random number generator"
>  	depends on SANDBOX
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 3517005541..6a8a66779b 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -4,5 +4,6 @@
>  #
>=20
>  obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o
> +obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o
>  obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o
>  obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp1_rng.o
> diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> new file mode 100644
> index 0000000000..4b81a62353
> --- /dev/null
> +++ b/drivers/rng/meson-rng.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
> + *
> + * Driver for Amlogic hardware random number generator
> + */
> +
> +#include <common.h>
> +#include <clk.h>
> +#include <dm.h>
> +#include <rng.h>
> +#include <asm/io.h>
> +
> +struct meson_rng_platdata {
> +	fdt_addr_t base;
> +	struct clk clk;
> +};
> +
> +/**
> + * meson_rng_read() - fill buffer with random bytes
> + *
> + * @buffer:	buffer to receive data
> + * @size:	size of buffer
> + *
> + * Return:	0
> + */
> +static int meson_rng_read(struct udevice *dev, void *data, size_t len)
> +{
> +	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
> +	char *buffer =3D (char *)data;
> +
> +	while (len) {
> +		u32 rand =3D readl(pdata->base);
> +		size_t step;
> +
> +		if (len >=3D 4)
> +			step =3D 4;
> +		else
> +			step =3D len;
> +		memcpy(buffer, &rand, step);
> +		buffer +=3D step;
> +		len -=3D step;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * meson_rng_probe() - probe rng device
> + *
> + * @dev:	device
> + * Return:	0 if ok
> + */
> +static int meson_rng_probe(struct udevice *dev)
> +{
> +	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
> +	int err;
> +
> +	err =3D clk_enable(&pdata->clk);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/**
> + * meson_rng_remove() - deinitialize rng device
> + *
> + * @dev:	device
> + * Return:	0 if ok
> + */
> +static int meson_rng_remove(struct udevice *dev)
> +{
> +	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
> +
> +	return clk_disable(&pdata->clk);
> +}
> +
> +/**
> + * meson_rng_ofdata_to_platdata() - transfer device tree data to plaform=
 data
> + *
> + * @dev:	device
> + * Return:	0 if ok
> + */
> +static int meson_rng_ofdata_to_platdata(struct udevice *dev)
> +{
> +	struct meson_rng_platdata *pdata =3D dev_get_platdata(dev);
> +	int err;
> +
> +	pdata->base =3D dev_read_addr(dev);
> +	if (!pdata->base)
> +		return -ENODEV;
> +
> +	err =3D clk_get_by_name(dev, "core", &pdata->clk);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static const struct dm_rng_ops meson_rng_ops =3D {
> +	.read =3D meson_rng_read,
> +};
> +
> +static const struct udevice_id meson_rng_match[] =3D {
> +	{
> +		.compatible =3D "amlogic,meson-rng",
> +	},
> +	{},
> +};
> +
> +U_BOOT_DRIVER(meson_rng) =3D {
> +	.name =3D "meson-rng",
> +	.id =3D UCLASS_RNG,
> +	.of_match =3D meson_rng_match,
> +	.ops =3D &meson_rng_ops,
> +	.probe =3D meson_rng_probe,
> +	.remove =3D meson_rng_remove,
> +	.platdata_auto_alloc_size =3D sizeof(struct meson_rng_platdata),
> +	.ofdata_to_platdata =3D meson_rng_ofdata_to_platdata,
> +};
> --
> 2.20.1
>=20

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks, looks fine.

I suspect this will help adding EFI RNG data for Linux early random seed, r=
ight ?

Is there a RNG maintainer or should I apply it myself ?

Neil
