Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web09.6309.1582714286789568084
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Feb 2020 02:51:26 -0800
Received: by mail-pg1-f196.google.com with SMTP id t24so1111993pgj.7
        for <u-boot-amlogic@groups.io>; Wed, 26 Feb 2020 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi5HKvZsEDYGNaFgArbI3p6mfswWYN0kbkPCjFdvAHE=;
        b=NVpe8R9nVyUykqrMTcodxCxEDYIqKwGI6C2Ph/D574LVQMNpTRL3z8OdmPoaeEkfY/
         EarLahkaXVUKva8DvYBXsJCCkMy7CIlYb7i5I17y7CicP4XI1pZDa3Os/mhvCcdP30K3
         jbC5CH2buQgMyQ9W3wkilkoSjTi31UeVWUXrw/l4XPOlNBFnQb/GmBBkwCzY0H1WeXqE
         Foc7QYQl2goRncm2J+u26jTKokwOe0C3c9NPqA8x/CsA3Cpk8FXLSldQrshRB+Sty4nV
         tbDAnpiEKwF5MnciBoIwE63QcfEG3CRQ+XyI/EcaMCm4doBXno5TFRE8l3KLFqkgd+TD
         tsxA==
MIME-Version: 1.0
References: <20200224222133.972-1-xypron.glpk@gmx.de>
In-Reply-To: <20200224222133.972-1-xypron.glpk@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 26 Feb 2020 16:21:14 +0530
Message-ID: <CADg8p96jRVN0LwNh10GFLpxFE2=8JRp6utApiQ40YeDC9_uUjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers/rng: add Amlogic hardware RNG driver
Content-Type: multipart/alternative; boundary="000000000000cae216059f786283"
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--000000000000cae216059f786283
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2020 at 03:56, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> Add support for the hardware random number generator of Amlogic SOCs.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/rng/Kconfig     |   8 +++
>  drivers/rng/Makefile    |   1 +
>  drivers/rng/meson-rng.c | 120 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/rng/meson-rng.c
>
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index c1aa43b823..edb6152bb9 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -8,6 +8,14 @@ config DM_RNG
>
>  if DM_RNG
>
> +config RNG_MESON
> +       bool "Amlogic Meson Random Number Generator support"
> +       depends on ARCH_MESON
> +       default y
> +       help
> +         Enable support for hardware random number generator
> +         of Amlogic Meson SoCs.
> +
>  config RNG_SANDBOX
>         bool "Sandbox random number generator"
>         depends on SANDBOX
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 3517005541..6a8a66779b 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -4,5 +4,6 @@
>  #
>
>  obj-$(CONFIG_DM_RNG) += rng-uclass.o
> +obj-$(CONFIG_RNG_MESON) += meson-rng.o
>  obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
>  obj-$(CONFIG_RNG_STM32MP1) += stm32mp1_rng.o
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
> +       fdt_addr_t base;
> +       struct clk clk;
> +};
> +
> +/**
> + * meson_rng_read() - fill buffer with random bytes
> + *
> + * @buffer:    buffer to receive data
> + * @size:      size of buffer
> + *
> + * Return:     0
> + */
> +static int meson_rng_read(struct udevice *dev, void *data, size_t len)
> +{
> +       struct meson_rng_platdata *pdata = dev_get_platdata(dev);
> +       char *buffer = (char *)data;
> +
> +       while (len) {
> +               u32 rand = readl(pdata->base);
> +               size_t step;
>

I believe declaration of variables in the middle of the function is frowned
upon. Can be moved to the start of the function.

Other than that,
Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh



> +
> +               if (len >= 4)
> +                       step = 4;
> +               else
> +                       step = len;
> +               memcpy(buffer, &rand, step);
> +               buffer += step;
> +               len -= step;
> +       }
> +       return 0;
> +}
> +
> +/**
> + * meson_rng_probe() - probe rng device
> + *
> + * @dev:       device
> + * Return:     0 if ok
> + */
> +static int meson_rng_probe(struct udevice *dev)
> +{
> +       struct meson_rng_platdata *pdata = dev_get_platdata(dev);
> +       int err;
> +
> +       err = clk_enable(&pdata->clk);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +/**
> + * meson_rng_remove() - deinitialize rng device
> + *
> + * @dev:       device
> + * Return:     0 if ok
> + */
> +static int meson_rng_remove(struct udevice *dev)
> +{
> +       struct meson_rng_platdata *pdata = dev_get_platdata(dev);
> +
> +       return clk_disable(&pdata->clk);
> +}
> +
> +/**
> + * meson_rng_ofdata_to_platdata() - transfer device tree data to plaform
> data
> + *
> + * @dev:       device
> + * Return:     0 if ok
> + */
> +static int meson_rng_ofdata_to_platdata(struct udevice *dev)
> +{
> +       struct meson_rng_platdata *pdata = dev_get_platdata(dev);
> +       int err;
> +
> +       pdata->base = dev_read_addr(dev);
> +       if (!pdata->base)
> +               return -ENODEV;
> +
> +       err = clk_get_by_name(dev, "core", &pdata->clk);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static const struct dm_rng_ops meson_rng_ops = {
> +       .read = meson_rng_read,
> +};
> +
> +static const struct udevice_id meson_rng_match[] = {
> +       {
> +               .compatible = "amlogic,meson-rng",
> +       },
> +       {},
> +};
> +
> +U_BOOT_DRIVER(meson_rng) = {
> +       .name = "meson-rng",
> +       .id = UCLASS_RNG,
> +       .of_match = meson_rng_match,
> +       .ops = &meson_rng_ops,
> +       .probe = meson_rng_probe,
> +       .remove = meson_rng_remove,
> +       .platdata_auto_alloc_size = sizeof(struct meson_rng_platdata),
> +       .ofdata_to_platdata = meson_rng_ofdata_to_platdata,
> +};
> --
> 2.20.1
>
>

--000000000000cae216059f786283
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, 25 Feb 2020 at 03:56, Heinrich Sc=
huchardt &lt;<a href=3D"mailto:xypron.glpk@gmx.de">xypron.glpk@gmx.de</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add su=
pport for the hardware random number generator of Amlogic SOCs.<br>
<br>
Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"mailto:xypron.glpk@gmx.de=
" target=3D"_blank">xypron.glpk@gmx.de</a>&gt;<br>
---<br>
=C2=A0drivers/rng/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +++<br>
=C2=A0drivers/rng/Makefile=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0drivers/rng/meson-rng.c | 120 +++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 129 insertions(+)<br>
=C2=A0create mode 100644 drivers/rng/meson-rng.c<br>
<br>
diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig<br>
index c1aa43b823..edb6152bb9 100644<br>
--- a/drivers/rng/Kconfig<br>
+++ b/drivers/rng/Kconfig<br>
@@ -8,6 +8,14 @@ config DM_RNG<br>
<br>
=C2=A0if DM_RNG<br>
<br>
+config RNG_MESON<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Amlogic Meson Random Number Generato=
r support&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_MESON<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default y<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for hardware random numbe=
r generator<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of Amlogic Meson SoCs.<br>
+<br>
=C2=A0config RNG_SANDBOX<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Sandbox random number generator&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on SANDBOX<br>
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile<br>
index 3517005541..6a8a66779b 100644<br>
--- a/drivers/rng/Makefile<br>
+++ b/drivers/rng/Makefile<br>
@@ -4,5 +4,6 @@<br>
=C2=A0#<br>
<br>
=C2=A0obj-$(CONFIG_DM_RNG) +=3D rng-uclass.o<br>
+obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o<br>
=C2=A0obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o<br>
=C2=A0obj-$(CONFIG_RNG_STM32MP1) +=3D stm32mp1_rng.o<br>
diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c<br>
new file mode 100644<br>
index 0000000000..4b81a62353<br>
--- /dev/null<br>
+++ b/drivers/rng/meson-rng.c<br>
@@ -0,0 +1,120 @@<br>
+// SPDX-License-Identifier: GPL-2.0-or-later<br>
+/*<br>
+ * Copyright 2020, Heinrich Schuchardt &lt;<a href=3D"mailto:xypron.glpk@g=
mx.de" target=3D"_blank">xypron.glpk@gmx.de</a>&gt;<br>
+ *<br>
+ * Driver for Amlogic hardware random number generator<br>
+ */<br>
+<br>
+#include &lt;common.h&gt;<br>
+#include &lt;clk.h&gt;<br>
+#include &lt;dm.h&gt;<br>
+#include &lt;rng.h&gt;<br>
+#include &lt;asm/io.h&gt;<br>
+<br>
+struct meson_rng_platdata {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fdt_addr_t base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct clk clk;<br>
+};<br>
+<br>
+/**<br>
+ * meson_rng_read() - fill buffer with random bytes<br>
+ *<br>
+ * @buffer:=C2=A0 =C2=A0 buffer to receive data<br>
+ * @size:=C2=A0 =C2=A0 =C2=A0 size of buffer<br>
+ *<br>
+ * Return:=C2=A0 =C2=A0 =C2=A00<br>
+ */<br>
+static int meson_rng_read(struct udevice *dev, void *data, size_t len)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev_get_pl=
atdata(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *buffer =3D (char *)data;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 rand =3D readl(=
pdata-&gt;base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t step;<br></b=
lockquote><div><br></div><div>I believe declaration of variables in the mid=
dle of the function is frowned upon. Can be moved to the start of the funct=
ion.</div><div><br></div><div>Other than that,</div><div>Reviewed-by: Sugho=
sh Ganu &lt;<a href=3D"mailto:sughosh.ganu@linaro.org">sughosh.ganu@linaro.=
org</a>&gt;</div><div><br></div><div>-sughosh</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt;=3D 4)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0step =3D 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0step =3D len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(buffer, &amp=
;rand, step);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buffer +=3D step;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len -=3D step;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/**<br>
+ * meson_rng_probe() - probe rng device<br>
+ *<br>
+ * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device<br>
+ * Return:=C2=A0 =C2=A0 =C2=A00 if ok<br>
+ */<br>
+static int meson_rng_probe(struct udevice *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev_get_pl=
atdata(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D clk_enable(&amp;pdata-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+/**<br>
+ * meson_rng_remove() - deinitialize rng device<br>
+ *<br>
+ * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device<br>
+ * Return:=C2=A0 =C2=A0 =C2=A00 if ok<br>
+ */<br>
+static int meson_rng_remove(struct udevice *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev_get_pl=
atdata(dev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return clk_disable(&amp;pdata-&gt;clk);<br>
+}<br>
+<br>
+/**<br>
+ * meson_rng_ofdata_to_platdata() - transfer device tree data to plaform d=
ata<br>
+ *<br>
+ * @dev:=C2=A0 =C2=A0 =C2=A0 =C2=A0device<br>
+ * Return:=C2=A0 =C2=A0 =C2=A00 if ok<br>
+ */<br>
+static int meson_rng_ofdata_to_platdata(struct udevice *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct meson_rng_platdata *pdata =3D dev_get_pl=
atdata(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pdata-&gt;base =3D dev_read_addr(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pdata-&gt;base)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D clk_get_by_name(dev, &quot;core&quot;, =
&amp;pdata-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static const struct dm_rng_ops meson_rng_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.read =3D meson_rng_read,<br>
+};<br>
+<br>
+static const struct udevice_id meson_rng_match[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compatible =3D &qu=
ot;amlogic,meson-rng&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{},<br>
+};<br>
+<br>
+U_BOOT_DRIVER(meson_rng) =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;meson-rng&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.id =3D UCLASS_RNG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match =3D meson_rng_match,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.ops =3D &amp;meson_rng_ops,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D meson_rng_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D meson_rng_remove,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.platdata_auto_alloc_size =3D sizeof(struct mes=
on_rng_platdata),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.ofdata_to_platdata =3D meson_rng_ofdata_to_pla=
tdata,<br>
+};<br>
--<br>
2.20.1<br>
<br>
</blockquote></div></div>

--000000000000cae216059f786283--
