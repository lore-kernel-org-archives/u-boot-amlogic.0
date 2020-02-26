Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mx.groups.io with SMTP id smtpd.web11.1707.1582748296281929884
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 12:18:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1582748293;
	bh=ey5ja7Bdq67bpBqASQk0qYVp1iJNyANZd54sLGDB3FY=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=KYTjP2DINGrR5uPw/iglYQYtLWF0jzEJd1j+aLknUeanRDIIx6/3N3NPZFivLHSV2
	 g1pdKI209TIdhc/yXZoYKNGlk9YPWfgq1H5bUybh+L6HY4eQgXDh0rXCPOWKWfeY6M
	 deretbyX/yUWhbhQi6iUWnu5QH/I6alTPbD3mW+8=
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
References: <20200224222133.972-1-xypron.glpk@gmx.de>
 <CADg8p96jRVN0LwNh10GFLpxFE2=8JRp6utApiQ40YeDC9_uUjg@mail.gmail.com>
 <695a5210-f697-54bf-5d17-4e7d239dd8f4@gmx.de>
 <CADg8p94LWcYv1K_yPruXPApp3JTJFPoNr_Wdh3VVUSp3J2fx2w@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <fcea08b0-7bb6-1aeb-50c3-926686998533@gmx.de>
Date: Wed, 26 Feb 2020 21:18:08 +0100
MIME-Version: 1.0
In-Reply-To: <CADg8p94LWcYv1K_yPruXPApp3JTJFPoNr_Wdh3VVUSp3J2fx2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 2/26/20 8:32 PM, Sughosh Ganu wrote:
>
>
> On Wed, 26 Feb 2020 at 23:34, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>
>     On 2/26/20 11:51 AM, Sughosh Ganu wrote:
>      >
>      > On Tue, 25 Feb 2020 at 03:56, Heinrich Schuchardt
>     <xypron.glpk@gmx.de <mailto:xypron.glpk@gmx.de>
>      > <mailto:xypron.glpk@gmx.de <mailto:xypron.glpk@gmx.de>>> wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0Add support for the hardware random number gen=
erator of
>     Amlogic SOCs.
>      >
>      >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Heinrich Schuchardt <xypron.glp=
k@gmx.de
>     <mailto:xypron.glpk@gmx.de>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:xypron.glpk@gmx.de <mailto:xypron.glpk=
@gmx.de>>>
>      >=C2=A0 =C2=A0 =C2=A0---
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/Kconfig=C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A08 +++
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/Makefile=C2=A0 =C2=A0 |=C2=
=A0 =C2=A01 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/meson-rng.c | 120
>     ++++++++++++++++++++++++++++++++++++++++
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A03 files changed, 129 insertions(+)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 drivers/rng/meson-rn=
g.c
>      >
>      >=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/Kconfig b/drivers/rng=
/Kconfig
>      >=C2=A0 =C2=A0 =C2=A0index c1aa43b823..edb6152bb9 100644
>      >=C2=A0 =C2=A0 =C2=A0--- a/drivers/rng/Kconfig
>      >=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/Kconfig
>      >=C2=A0 =C2=A0 =C2=A0@@ -8,6 +8,14 @@ config DM_RNG
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if DM_RNG
>      >
>      >=C2=A0 =C2=A0 =C2=A0+config RNG_MESON
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Amlogic Meso=
n Random Number Generator support"
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_ME=
SON
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0default y
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0help
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable supp=
ort for hardware random number generator
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of Amlogic =
Meson SoCs.
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0config RNG_SANDBOX
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool "Sandbox ran=
dom number generator"
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on SANDBO=
X
>      >=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/Makefile b/drivers/rn=
g/Makefile
>      >=C2=A0 =C2=A0 =C2=A0index 3517005541..6a8a66779b 100644
>      >=C2=A0 =C2=A0 =C2=A0--- a/drivers/rng/Makefile
>      >=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/Makefile
>      >=C2=A0 =C2=A0 =C2=A0@@ -4,5 +4,6 @@
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0#
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o
>      >=C2=A0 =C2=A0 =C2=A0+obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_=
rng.o
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp=
1_rng.o
>      >=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/meson-rng.c b/drivers=
/rng/meson-rng.c
>      >=C2=A0 =C2=A0 =C2=A0new file mode 100644
>      >=C2=A0 =C2=A0 =C2=A0index 0000000000..4b81a62353
>      >=C2=A0 =C2=A0 =C2=A0--- /dev/null
>      >=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/meson-rng.c
>      >=C2=A0 =C2=A0 =C2=A0@@ -0,0 +1,120 @@
>      >=C2=A0 =C2=A0 =C2=A0+// SPDX-License-Identifier: GPL-2.0-or-later
>      >=C2=A0 =C2=A0 =C2=A0+/*
>      >=C2=A0 =C2=A0 =C2=A0+ * Copyright 2020, Heinrich Schuchardt <xypro=
n.glpk@gmx.de
>     <mailto:xypron.glpk@gmx.de>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:xypron.glpk@gmx.de <mailto:xypron.glpk=
@gmx.de>>>
>      >=C2=A0 =C2=A0 =C2=A0+ *
>      >=C2=A0 =C2=A0 =C2=A0+ * Driver for Amlogic hardware random number =
generator
>      >=C2=A0 =C2=A0 =C2=A0+ */
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0+#include <common.h>
>      >=C2=A0 =C2=A0 =C2=A0+#include <clk.h>
>      >=C2=A0 =C2=A0 =C2=A0+#include <dm.h>
>      >=C2=A0 =C2=A0 =C2=A0+#include <rng.h>
>      >=C2=A0 =C2=A0 =C2=A0+#include <asm/io.h>
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0+struct meson_rng_platdata {
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_addr_t base;
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk clk;
>      >=C2=A0 =C2=A0 =C2=A0+};
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0+/**
>      >=C2=A0 =C2=A0 =C2=A0+ * meson_rng_read() - fill buffer with random=
 bytes
>      >=C2=A0 =C2=A0 =C2=A0+ *
>      >=C2=A0 =C2=A0 =C2=A0+ * @buffer:=C2=A0 =C2=A0 buffer to receive da=
ta
>      >=C2=A0 =C2=A0 =C2=A0+ * @size:=C2=A0 =C2=A0 =C2=A0 size of buffer
>      >=C2=A0 =C2=A0 =C2=A0+ *
>      >=C2=A0 =C2=A0 =C2=A0+ * Return:=C2=A0 =C2=A0 =C2=A00
>      >=C2=A0 =C2=A0 =C2=A0+ */
>      >=C2=A0 =C2=A0 =C2=A0+static int meson_rng_read(struct udevice *dev=
, void *data,
>     size_t len)
>      >=C2=A0 =C2=A0 =C2=A0+{
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_p=
latdata *pdata =3D dev_get_platdata(dev);
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *buffer =3D (=
char *)data;
>      >=C2=A0 =C2=A0 =C2=A0+
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0u32 rand =3D readl(pdata->base);
>      >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0size_t step;
>      >
>      >
>      > I believe declaration of variables in the middle of the function =
is
>      > frowned upon. Can be moved to the start of the function.
>
>     rand is defined at the top of the smallest possible code block
>     delineated by braces.
>
>     C compilers before C99 required you to put definitions at the top of
>     functions. This led to the unsafe coding practice to reuse the same
>     variable for different purposes in the same function. Currently we a=
re
>     using -std=3Dgnu11.
>
>     U-Boot uses cppcheck in Gitlab CI. Cppcheck gives you a warning if y=
ou
>     could reduce the scope of a variable.
>
>     Neither the U-Boot coding style guide
>     https://www.denx.de/wiki/U-Boot/CodingStyle
>     nor the Linux kernel coding style guide
>     https://www.kernel.org/doc/html/v4.10/process/coding-style.html
>     recommend such unsafe practice.
>
>
> Yes, I had checked that this is not mentioned in the coding style
> guides. But i have seen Wolfgang mention this on multiple occasions as
> part of his review comments earlier, one example being [1].

https://lists.denx.de/pipermail/u-boot/2020-January/397651.html
has a variable definition which is not at the start of code block
delineated by {} but in the middle of the code block. I agree with
Wolfgang that this is not advisable.

Best regards

Heinrich

>
>
>     If you look at other parts of the U-Boot code, you will find that in
>     lots of places variables are defined in the smallest possible code b=
lock
>     (e.g. fs/fat/fat.c, fs/ext4/ext4_common.c). Due to our legacy we sti=
ll
>     carry a lot of code lines not following this rule.
>
>     But anyway if you still want it in a different way, I will resubmit.
>
>
> I don't have a strong opinion on this. I was simply stating what I
> thought to be a coding style in u-boot based on some earlier review
> comments that I have seen.
>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2020-January/397651.html

