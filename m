Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web10.230.1582739966428344440
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 09:59:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1582739963;
	bh=qSLUQzv4tfZEM/K832jtxaEisGmCCd58bjRAqkc8WNc=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=bvi1oP0diDYgGOnwZsnzJEI1EKDFj1YrJZzuY5PLtnuTOA/ffEPOSf6DQCz3zi4G/
	 jV4XNkQISqfbsrGzPl4cJedRn/a8VeBVC5Pg9xDYNHjL1WThRGEBZx+8d+B7TsbbFy
	 WUyFIgN8f47Jzofpjl2I5PACOok0MkwvjLTX6ou4=
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
References: <20200224222133.972-1-xypron.glpk@gmx.de>
 <CADg8p96jRVN0LwNh10GFLpxFE2=8JRp6utApiQ40YeDC9_uUjg@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <695a5210-f697-54bf-5d17-4e7d239dd8f4@gmx.de>
Date: Wed, 26 Feb 2020 18:59:18 +0100
MIME-Version: 1.0
In-Reply-To: <CADg8p96jRVN0LwNh10GFLpxFE2=8JRp6utApiQ40YeDC9_uUjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 2/26/20 11:51 AM, Sughosh Ganu wrote:
>
> On Tue, 25 Feb 2020 at 03:56, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>
>     Add support for the hardware random number generator of Amlogic SOCs=
.
>
>     Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de
>     <mailto:xypron.glpk@gmx.de>>
>     ---
>      =C2=A0drivers/rng/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +++
>      =C2=A0drivers/rng/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +
>      =C2=A0drivers/rng/meson-rng.c | 120 +++++++++++++++++++++++++++++++=
+++++++++
>      =C2=A03 files changed, 129 insertions(+)
>      =C2=A0create mode 100644 drivers/rng/meson-rng.c
>
>     diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
>     index c1aa43b823..edb6152bb9 100644
>     --- a/drivers/rng/Kconfig
>     +++ b/drivers/rng/Kconfig
>     @@ -8,6 +8,14 @@ config DM_RNG
>
>      =C2=A0if DM_RNG
>
>     +config RNG_MESON
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Amlogic Meson Random Number Genera=
tor support"
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_MESON
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0default y
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0help
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for hardware rando=
m number generator
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of Amlogic Meson SoCs.
>     +
>      =C2=A0config RNG_SANDBOX
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool "Sandbox random number generator"
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on SANDBOX
>     diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
>     index 3517005541..6a8a66779b 100644
>     --- a/drivers/rng/Makefile
>     +++ b/drivers/rng/Makefile
>     @@ -4,5 +4,6 @@
>      =C2=A0#
>
>      =C2=A0obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o
>     +obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o
>      =C2=A0obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o
>      =C2=A0obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp1_rng.o
>     diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
>     new file mode 100644
>     index 0000000000..4b81a62353
>     --- /dev/null
>     +++ b/drivers/rng/meson-rng.c
>     @@ -0,0 +1,120 @@
>     +// SPDX-License-Identifier: GPL-2.0-or-later
>     +/*
>     + * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de
>     <mailto:xypron.glpk@gmx.de>>
>     + *
>     + * Driver for Amlogic hardware random number generator
>     + */
>     +
>     +#include <common.h>
>     +#include <clk.h>
>     +#include <dm.h>
>     +#include <rng.h>
>     +#include <asm/io.h>
>     +
>     +struct meson_rng_platdata {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_addr_t base;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk clk;
>     +};
>     +
>     +/**
>     + * meson_rng_read() - fill buffer with random bytes
>     + *
>     + * @buffer:=C2=A0 =C2=A0 buffer to receive data
>     + * @size:=C2=A0 =C2=A0 =C2=A0 size of buffer
>     + *
>     + * Return:=C2=A0 =C2=A0 =C2=A00
>     + */
>     +static int meson_rng_read(struct udevice *dev, void *data, size_t l=
en)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev=
_get_platdata(dev);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *buffer =3D (char *)data;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rand =3D=
 readl(pdata->base);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t step;
>
>
> I believe declaration of variables in the middle of the function is
> frowned upon. Can be moved to the start of the function.

rand is defined at the top of the smallest possible code block
delineated by braces.

C compilers before C99 required you to put definitions at the top of
functions. This led to the unsafe coding practice to reuse the same
variable for different purposes in the same function. Currently we are
using -std=3Dgnu11.

U-Boot uses cppcheck in Gitlab CI. Cppcheck gives you a warning if you
could reduce the scope of a variable.

Neither the U-Boot coding style guide
https://www.denx.de/wiki/U-Boot/CodingStyle
nor the Linux kernel coding style guide
https://www.kernel.org/doc/html/v4.10/process/coding-style.html
recommend such unsafe practice.

If you look at other parts of the U-Boot code, you will find that in
lots of places variables are defined in the smallest possible code block
(e.g. fs/fat/fat.c, fs/ext4/ext4_common.c). Due to our legacy we still
carry a lot of code lines not following this rule.

But anyway if you still want it in a different way, I will resubmit.

Best regards

Heinrich

>
> Other than that,
> Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org
> <mailto:sughosh.ganu@linaro.org>>
>
> -sughosh
>
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len >=3D=
 4)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0step =3D 4;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0step =3D len;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buffe=
r, &rand, step);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer +=3D =
step;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D ste=
p;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     +}
>     +
>     +/**
>     + * meson_rng_probe() - probe rng device
>     + *
>     + * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device
>     + * Return:=C2=A0 =C2=A0 =C2=A00 if ok
>     + */
>     +static int meson_rng_probe(struct udevice *dev)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev=
_get_platdata(dev);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D clk_enable(&pdata->clk);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     +}
>     +
>     +/**
>     + * meson_rng_remove() - deinitialize rng device
>     + *
>     + * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device
>     + * Return:=C2=A0 =C2=A0 =C2=A00 if ok
>     + */
>     +static int meson_rng_remove(struct udevice *dev)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev=
_get_platdata(dev);
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return clk_disable(&pdata->clk);
>     +}
>     +
>     +/**
>     + * meson_rng_ofdata_to_platdata() - transfer device tree data to
>     plaform data
>     + *
>     + * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device
>     + * Return:=C2=A0 =C2=A0 =C2=A00 if ok
>     + */
>     +static int meson_rng_ofdata_to_platdata(struct udevice *dev)
>     +{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev=
_get_platdata(dev);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0pdata->base =3D dev_read_addr(dev);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pdata->base)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOD=
EV;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D clk_get_by_name(dev, "core", &pd=
ata->clk);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
>     +
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>     +}
>     +
>     +static const struct dm_rng_ops meson_rng_ops =3D {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.read =3D meson_rng_read,
>     +};
>     +
>     +static const struct udevice_id meson_rng_match[] =3D {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0{
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =
=3D "amlogic,meson-rng",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0},
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0{},
>     +};
>     +
>     +U_BOOT_DRIVER(meson_rng) =3D {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D "meson-rng",
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.id =3D UCLASS_RNG,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match =3D meson_rng_match,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.ops =3D &meson_rng_ops,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D meson_rng_probe,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D meson_rng_remove,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.platdata_auto_alloc_size =3D sizeof(str=
uct meson_rng_platdata),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0.ofdata_to_platdata =3D meson_rng_ofdata=
_to_platdata,
>     +};
>     --
>     2.20.1
>

