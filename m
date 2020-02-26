Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web11.1062.1582745577478205106
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 11:32:57 -0800
Received: by mail-pl1-f196.google.com with SMTP id g6so94437plp.6
        for <u-boot-amlogic@groups.io>; Wed, 26 Feb 2020 11:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDmBCNgtULs0fK3UYmVp4edsy3TorqyGzweQVq+2kRQ=;
        b=yiZCLmVIT7bSQQw1d1Y+3wTNwfgD6797M2xXSR1jmm+063OefLcTIfl7OXn4XekSU0
         bqA4mHn1EZhNEy8zlT2UvgSMZk4AW4z9A6TMQ5TzQmdoVF4pdRBBfhYyQDNP0aJRylte
         ItaUPHCoyeZBJxxJN6HUuYBTP5ic3VVms8bH5djeKLVRk7+C1ChfWKdlmqlloRmFQavG
         CcPjbUyMAmMUBQmgupZEs3CFEkoyE4THxvG3N+MVYo7W3q7XTXsoGXdV5nxCaFyy/Osf
         pZSrRImF8+AW/R8LwPtno+B8WOoSxfrl+88/bwQwZDdvYVU56/wme7nptBWsHZN0MiiH
         b+nw==
MIME-Version: 1.0
References: <20200224222133.972-1-xypron.glpk@gmx.de> <CADg8p96jRVN0LwNh10GFLpxFE2=8JRp6utApiQ40YeDC9_uUjg@mail.gmail.com>
 <695a5210-f697-54bf-5d17-4e7d239dd8f4@gmx.de>
In-Reply-To: <695a5210-f697-54bf-5d17-4e7d239dd8f4@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 27 Feb 2020 01:02:46 +0530
Message-ID: <CADg8p94LWcYv1K_yPruXPApp3JTJFPoNr_Wdh3VVUSp3J2fx2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
Content-Type: multipart/alternative; boundary="000000000000e12e6a059f7fabff"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--000000000000e12e6a059f7fabff
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2020 at 23:34, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 2/26/20 11:51 AM, Sughosh Ganu wrote:
> >
> > On Tue, 25 Feb 2020 at 03:56, Heinrich Schuchardt <xypron.glpk@gmx.de
> > <mailto:xypron.glpk@gmx.de>> wrote:
> >
> >     Add support for the hardware random number generator of Amlogic SOCs.
> >
> >     Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de
> >     <mailto:xypron.glpk@gmx.de>>
> >     ---
> >       drivers/rng/Kconfig     |   8 +++
> >       drivers/rng/Makefile    |   1 +
> >       drivers/rng/meson-rng.c | 120
> ++++++++++++++++++++++++++++++++++++++++
> >       3 files changed, 129 insertions(+)
> >       create mode 100644 drivers/rng/meson-rng.c
> >
> >     diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> >     index c1aa43b823..edb6152bb9 100644
> >     --- a/drivers/rng/Kconfig
> >     +++ b/drivers/rng/Kconfig
> >     @@ -8,6 +8,14 @@ config DM_RNG
> >
> >       if DM_RNG
> >
> >     +config RNG_MESON
> >     +       bool "Amlogic Meson Random Number Generator support"
> >     +       depends on ARCH_MESON
> >     +       default y
> >     +       help
> >     +         Enable support for hardware random number generator
> >     +         of Amlogic Meson SoCs.
> >     +
> >       config RNG_SANDBOX
> >              bool "Sandbox random number generator"
> >              depends on SANDBOX
> >     diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> >     index 3517005541..6a8a66779b 100644
> >     --- a/drivers/rng/Makefile
> >     +++ b/drivers/rng/Makefile
> >     @@ -4,5 +4,6 @@
> >       #
> >
> >       obj-$(CONFIG_DM_RNG) += rng-uclass.o
> >     +obj-$(CONFIG_RNG_MESON) += meson-rng.o
> >       obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
> >       obj-$(CONFIG_RNG_STM32MP1) += stm32mp1_rng.o
> >     diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
> >     new file mode 100644
> >     index 0000000000..4b81a62353
> >     --- /dev/null
> >     +++ b/drivers/rng/meson-rng.c
> >     @@ -0,0 +1,120 @@
> >     +// SPDX-License-Identifier: GPL-2.0-or-later
> >     +/*
> >     + * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de
> >     <mailto:xypron.glpk@gmx.de>>
> >     + *
> >     + * Driver for Amlogic hardware random number generator
> >     + */
> >     +
> >     +#include <common.h>
> >     +#include <clk.h>
> >     +#include <dm.h>
> >     +#include <rng.h>
> >     +#include <asm/io.h>
> >     +
> >     +struct meson_rng_platdata {
> >     +       fdt_addr_t base;
> >     +       struct clk clk;
> >     +};
> >     +
> >     +/**
> >     + * meson_rng_read() - fill buffer with random bytes
> >     + *
> >     + * @buffer:    buffer to receive data
> >     + * @size:      size of buffer
> >     + *
> >     + * Return:     0
> >     + */
> >     +static int meson_rng_read(struct udevice *dev, void *data, size_t
> len)
> >     +{
> >     +       struct meson_rng_platdata *pdata = dev_get_platdata(dev);
> >     +       char *buffer = (char *)data;
> >     +
> >     +       while (len) {
> >     +               u32 rand = readl(pdata->base);
> >     +               size_t step;
> >
> >
> > I believe declaration of variables in the middle of the function is
> > frowned upon. Can be moved to the start of the function.
>
> rand is defined at the top of the smallest possible code block
> delineated by braces.
>
> C compilers before C99 required you to put definitions at the top of
> functions. This led to the unsafe coding practice to reuse the same
> variable for different purposes in the same function. Currently we are
> using -std=gnu11.
>
> U-Boot uses cppcheck in Gitlab CI. Cppcheck gives you a warning if you
> could reduce the scope of a variable.
>
> Neither the U-Boot coding style guide
> https://www.denx.de/wiki/U-Boot/CodingStyle
> nor the Linux kernel coding style guide
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html
> recommend such unsafe practice.
>

Yes, I had checked that this is not mentioned in the coding style guides.
But i have seen Wolfgang mention this on multiple occasions as part of his
review comments earlier, one example being [1].


>
> If you look at other parts of the U-Boot code, you will find that in
> lots of places variables are defined in the smallest possible code block
> (e.g. fs/fat/fat.c, fs/ext4/ext4_common.c). Due to our legacy we still
> carry a lot of code lines not following this rule.
>
> But anyway if you still want it in a different way, I will resubmit.
>

I don't have a strong opinion on this. I was simply stating what I thought
to be a coding style in u-boot based on some earlier review comments that I
have seen.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2020-January/397651.html

--000000000000e12e6a059f7fabff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, 26 Feb 2020 at 23:34, Heinric=
h Schuchardt &lt;<a href=3D"mailto:xypron.glpk@gmx.de">xypron.glpk@gmx.de</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 2/26/20 11:51 AM, Sughosh Ganu wrote:<br>
&gt;<br>
&gt; On Tue, 25 Feb 2020 at 03:56, Heinrich Schuchardt &lt;<a href=3D"mailt=
o:xypron.glpk@gmx.de" target=3D"_blank">xypron.glpk@gmx.de</a><br>
&gt; &lt;mailto:<a href=3D"mailto:xypron.glpk@gmx.de" target=3D"_blank">xyp=
ron.glpk@gmx.de</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Add support for the hardware random number generato=
r of Amlogic SOCs.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"m=
ailto:xypron.glpk@gmx.de" target=3D"_blank">xypron.glpk@gmx.de</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:xypron.glpk@gmx.de" ta=
rget=3D"_blank">xypron.glpk@gmx.de</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A08 +++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/Makefile=C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0drivers/rng/meson-rng.c | 120 ++++++++++++++=
++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A03 files changed, 129 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 drivers/rng/meson-rng.c<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/Kconfig b/drivers/rng/Kcon=
fig<br>
&gt;=C2=A0 =C2=A0 =C2=A0index c1aa43b823..edb6152bb9 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/rng/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/Kconfig<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -8,6 +8,14 @@ config DM_RNG<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if DM_RNG<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+config RNG_MESON<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Amlogic Meso=
n Random Number Generator support&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_MESON<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0default y<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support f=
or hardware random number generator<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of Amlogic Meson=
 SoCs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0config RNG_SANDBOX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Sandbox ran=
dom number generator&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on SANDBOX<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/Makefile b/drivers/rng/Mak=
efile<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 3517005541..6a8a66779b 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/rng/Makefile<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/Makefile<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -4,5 +4,6 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0+obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp1_rng=
.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/rng/meson-rng.c b/drivers/rng/=
meson-rng.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 0000000000..4b81a62353<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/rng/meson-rng.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -0,0 +1,120 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0+// SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Copyright 2020, Heinrich Schuchardt &lt;<a href=
=3D"mailto:xypron.glpk@gmx.de" target=3D"_blank">xypron.glpk@gmx.de</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:xypron.glpk@gmx.de" ta=
rget=3D"_blank">xypron.glpk@gmx.de</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Driver for Amlogic hardware random number gener=
ator<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#include &lt;common.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#include &lt;clk.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#include &lt;dm.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#include &lt;rng.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#include &lt;asm/io.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+struct meson_rng_platdata {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_addr_t base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk clk;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/**<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * meson_rng_read() - fill buffer with random byte=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @buffer:=C2=A0 =C2=A0 buffer to receive data<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @size:=C2=A0 =C2=A0 =C2=A0 size of buffer<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Return:=C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static int meson_rng_read(struct udevice *dev, voi=
d *data, size_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platda=
ta *pdata =3D dev_get_platdata(dev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *buffer =3D (char =
*)data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0u32 rand =3D readl(pdata-&gt;base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0size_t step;<br>
&gt;<br>
&gt;<br>
&gt; I believe declaration of variables in the middle of the function is<br=
>
&gt; frowned upon. Can be moved to the start of the function.<br>
<br>
rand is defined at the top of the smallest possible code block<br>
delineated by braces.<br>
<br>
C compilers before C99 required you to put definitions at the top of<br>
functions. This led to the unsafe coding practice to reuse the same<br>
variable for different purposes in the same function. Currently we are<br>
using -std=3Dgnu11.<br>
<br>
U-Boot uses cppcheck in Gitlab CI. Cppcheck gives you a warning if you<br>
could reduce the scope of a variable.<br>
<br>
Neither the U-Boot coding style guide<br>
<a href=3D"https://www.denx.de/wiki/U-Boot/CodingStyle" rel=3D"noreferrer" =
target=3D"_blank">https://www.denx.de/wiki/U-Boot/CodingStyle</a><br>
nor the Linux kernel coding style guide<br>
<a href=3D"https://www.kernel.org/doc/html/v4.10/process/coding-style.html"=
 rel=3D"noreferrer" target=3D"_blank">https://www.kernel.org/doc/html/v4.10=
/process/coding-style.html</a><br>
recommend such unsafe practice.<br></blockquote><div><br></div><div>Yes, I =
had checked that this is not mentioned in the coding style guides. But i ha=
ve seen Wolfgang mention this on multiple occasions as part of his review c=
omments earlier, one example being [1].</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
If you look at other parts of the U-Boot code, you will find that in<br>
lots of places variables are defined in the smallest possible code block<br=
>
(e.g. fs/fat/fat.c, fs/ext4/ext4_common.c). Due to our legacy we still<br>
carry a lot of code lines not following this rule.<br>
<br>
But anyway if you still want it in a different way, I will resubmit.<br></b=
lockquote><div><br></div><div>I don&#39;t have a strong opinion on this. I =
was simply stating what I thought to be a coding style in u-boot based on s=
ome earlier review comments that I have seen.</div><div><br></div><div>-sug=
hosh</div><div><br></div><div>[1] -=C2=A0<a href=3D"https://lists.denx.de/p=
ipermail/u-boot/2020-January/397651.html">https://lists.denx.de/pipermail/u=
-boot/2020-January/397651.html</a></div></div></div>

--000000000000e12e6a059f7fabff--
