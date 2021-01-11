Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web08.34391.1610374524045528813
 for <u-boot-amlogic@groups.io>;
 Mon, 11 Jan 2021 06:15:24 -0800
Received: by mail-io1-f47.google.com with SMTP id 81so17896355ioc.13
        for <u-boot-amlogic@groups.io>; Mon, 11 Jan 2021 06:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUJwANn3gZI2PtBlNwKndY08GnPoa3M0cZ+8FBlfGqc=;
        b=tc+VuWW4gBxg+V1y9Ag4gsHrKOBbppdAyn746hvJHWGQNIe79+fnRNg7+xBVEHPwIe
         AxxXE+fKdgdBzPxfT3ihHKIHXCRknGEqktm+B/bdbCSEdwDE1qi3upoph6G6Nf+VxrWN
         Jx/1XXYgBVHChWqaeKWOdgJ59hbRABDB8bCiESKYPJNYzsZX4lWMFWT3y0jO3mT+OF0y
         L/oVyFTLQIpNdecQSgBbXl+knm0hIeDyJD1eawVEk9+PMFcwC810CXzlfqhyIYgLpwgD
         ho4kw6LutWaFYcyCvR2Oq8UhOC7+pCHSgIpbpuwgK/sIGJKlBLvvj4rBL8TMiTcTK+pu
         xh7w==
MIME-Version: 1.0
References: <20210111111929.504886-1-art@khadas.com> <406660b1-89fd-e402-6e8d-aa358acce96c@baylibre.com>
In-Reply-To: <406660b1-89fd-e402-6e8d-aa358acce96c@baylibre.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 11 Jan 2021 22:15:12 +0800
Message-ID: <CAKaHn9+GDOaWFEsJBvZBF8oUc-3O99m2gBtc4bv=-rUMTBtFag@mail.gmail.com>
Subject: Re: [PATCH] board: amlogic: vim3: setup ethernet mac from efuse
Content-Type: multipart/alternative; boundary="0000000000006d9ac705b8a08919"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, Christian Hewitt <christianshewitt@gmail.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>, Artem Lapkin <art@khadas.com>, nick@khadas.com, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

--0000000000006d9ac705b8a08919
Content-Type: text/plain; charset="UTF-8"

> So the patch from Marek (
https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/)
doesn't work ?
yes doesnt works properly im sure if we read as raw 6 bytes from efuse we
have

		if (is_valid_ethaddr(mac_addr)) # is always not valid
			eth_env_set_enetaddr("ethaddr", mac_addr);		else    # and always
generated from serial 			meson_generate_serial_ethaddr();

> Are you sure the MAC is stored in ASCII like Odroid-N2 ?
yes im check two times on my vim3 vim3l boards and our amlogic vendor uboot
have same method

On Mon, Jan 11, 2021 at 9:59 PM Neil Armstrong <narmstrong@baylibre.com>
wrote:

> Hi Artem,
>
> On 11/01/2021 12:19, Artem Lapkin wrote:
> > Add the board specific code for reading built-in ethernet MAC address
> from efuse
> >
> > NOTE: MAC is stored in ASCII format, 1bytes = 2characters by 0 offset
> >
> > if mac from efuse not valid we use meson_generate_serial_ethaddr
> >
> > NOTE: remake odroid-n2.c variant from Neil Armstrong <
> narmstrong@baylibre.com>
>
> So the patch from Marek (
> https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/)
> doesn't work ?
> Are you sure the MAC is stored in ASCII like Odroid-N2 ?
>
> Please look at my u-boot-amlogic-next tree I will push this week for the
> next u-boot release:
>
> https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-next
>
> Neil
>
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  board/amlogic/vim3/vim3.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> > index 09ef39ff30..c5d19cc17b 100644
> > --- a/board/amlogic/vim3/vim3.c
> > +++ b/board/amlogic/vim3/vim3.c
> > @@ -11,9 +11,14 @@
> >  #include <net.h>
> >  #include <asm/io.h>
> >  #include <asm/arch/eth.h>
> > +#include <asm/arch/sm.h>
> >  #include <i2c.h>
> >  #include "khadas-mcu.h"
> >
> > +#define EFUSE_MAC_OFFSET     0
> > +#define EFUSE_MAC_SIZE               12
> > +#define MAC_ADDR_LEN         6
> > +
> >  /*
> >   * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
> >   * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
> > @@ -131,7 +136,37 @@ int meson_ft_board_setup(void *blob, struct bd_info
> *bd)
> >
> >  int misc_init_r(void)
> >  {
> > +     u8 mac_addr[MAC_ADDR_LEN];
> > +     char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
> > +     ssize_t len;
> > +
> >       meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
> >
> > +     if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> > +
> > +             len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
> efuse_mac_addr, EFUSE_MAC_SIZE);
> > +             if (len != EFUSE_MAC_SIZE)
> > +                     return 0;
> > +
> > +             /* MAC is stored in ASCII format, 1bytes = 2characters */
> > +             for (int i = 0; i < 6; i++) {
> > +                     tmp[0] = efuse_mac_addr[i * 2];
> > +                     tmp[1] = efuse_mac_addr[i * 2 + 1];
> > +                     tmp[2] = '\0';
> > +                     mac_addr[i] = simple_strtoul(tmp, NULL, 16);
> > +             }
> > +
> > +             if (is_valid_ethaddr(mac_addr))
> > +                     eth_env_set_enetaddr("ethaddr", mac_addr);
> > +             else
> > +                     meson_generate_serial_ethaddr();
> > +
> > +             eth_env_get_enetaddr("ethaddr", mac_addr);
> > +             printf("[i] setup onboard mac
> %02X:%02X:%02X:%02X:%02X:%02X\n",
> > +                     mac_addr[0],mac_addr[1],mac_addr[2],
> > +                     mac_addr[3],mac_addr[4],mac_addr[5]);
> > +
> > +     }
> > +
> >       return 0;
> >  }
> >
>
>

--0000000000006d9ac705b8a08919
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; So the patch from Marek (<a href=3D"https://patchwork=
.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.=
com/" rel=3D"noreferrer" target=3D"_blank">https://patchwork.ozlabs.org/pro=
ject/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/</a>) doesn=
&#39;t work ?<br><div>yes doesnt works properly im sure if we read as raw 6=
 bytes from efuse we have<br></div><div><pre class=3D"gmail-content"><span =
class=3D"gmail-p_add">		if (is_valid_ethaddr(mac_addr))</span> # is always =
not valid<br><span class=3D"gmail-p_add">			eth_env_set_enetaddr(&quot;etha=
ddr&quot;, mac_addr);</span>
<span class=3D"gmail-p_add">		else</span>    # and always generated from se=
rial=20
<span class=3D"gmail-p_add">			meson_generate_serial_ethaddr();</span></pre=
>
</div><div>&gt; Are you sure the MAC is stored in ASCII like Odroid-N2 ?</d=
iv><div>yes im check two times on my vim3 vim3l boards and our amlogic vend=
or uboot have same method <br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 11, 2021 at 9:59 PM Neil Ar=
mstrong &lt;<a href=3D"mailto:narmstrong@baylibre.com">narmstrong@baylibre.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hi Artem,<br>
<br>
On 11/01/2021 12:19, Artem Lapkin wrote:<br>
&gt; Add the board specific code for reading built-in ethernet MAC address =
from efuse<br>
&gt; <br>
&gt; NOTE: MAC is stored in ASCII format, 1bytes =3D 2characters by 0 offse=
t<br>
&gt; <br>
&gt; if mac from efuse not valid we use meson_generate_serial_ethaddr<br>
&gt; <br>
&gt; NOTE: remake odroid-n2.c variant from Neil Armstrong &lt;<a href=3D"ma=
ilto:narmstrong@baylibre.com" target=3D"_blank">narmstrong@baylibre.com</a>=
&gt;<br>
<br>
So the patch from Marek (<a href=3D"https://patchwork.ozlabs.org/project/ub=
oot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/" rel=3D"noreferre=
r" target=3D"_blank">https://patchwork.ozlabs.org/project/uboot/patch/20201=
217072642.1319-1-m.szyprowski@samsung.com/</a>) doesn&#39;t work ?<br>
Are you sure the MAC is stored in ASCII like Odroid-N2 ?<br>
<br>
Please look at my u-boot-amlogic-next tree I will push this week for the ne=
xt u-boot release:<br>
<a href=3D"https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u=
-boot-amlogic-next" rel=3D"noreferrer" target=3D"_blank">https://gitlab.den=
x.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-next</a><br>
<br>
Neil<br>
<br>
&gt; <br>
&gt; Signed-off-by: Artem Lapkin &lt;<a href=3D"mailto:art@khadas.com" targ=
et=3D"_blank">art@khadas.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 board/amlogic/vim3/vim3.c | 35 +++++++++++++++++++++++++++++++++=
++<br>
&gt;=C2=A0 1 file changed, 35 insertions(+)<br>
&gt; <br>
&gt; diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c<br>
&gt; index 09ef39ff30..c5d19cc17b 100644<br>
&gt; --- a/board/amlogic/vim3/vim3.c<br>
&gt; +++ b/board/amlogic/vim3/vim3.c<br>
&gt; @@ -11,9 +11,14 @@<br>
&gt;=C2=A0 #include &lt;net.h&gt;<br>
&gt;=C2=A0 #include &lt;asm/io.h&gt;<br>
&gt;=C2=A0 #include &lt;asm/arch/eth.h&gt;<br>
&gt; +#include &lt;asm/arch/sm.h&gt;<br>
&gt;=C2=A0 #include &lt;i2c.h&gt;<br>
&gt;=C2=A0 #include &quot;khadas-mcu.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +#define EFUSE_MAC_OFFSET=C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define EFUSE_MAC_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A012<br>
&gt; +#define MAC_ADDR_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* The VIM3 on-board=C2=A0 MCU can mux the PCIe/USB3.0 shar=
ed differential<br>
&gt;=C2=A0 =C2=A0* lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch =
between<br>
&gt; @@ -131,7 +136,37 @@ int meson_ft_board_setup(void *blob, struct bd_in=
fo *bd)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int misc_init_r(void)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 mac_addr[MAC_ADDR_LEN];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ssize_t len;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);=
<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!eth_env_get_enetaddr(&quot;ethaddr&quot;, ma=
c_addr)) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D meson_sm_read=
_efuse(EFUSE_MAC_OFFSET, efuse_mac_addr, EFUSE_MAC_SIZE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D EFUSE_MA=
C_SIZE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MAC is stored in A=
SCII format, 1bytes =3D 2characters */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &=
lt; 6; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp[0] =3D efuse_mac_addr[i * 2];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp[1] =3D efuse_mac_addr[i * 2 + 1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tmp[2] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mac_addr[i] =3D simple_strtoul(tmp, NULL, 16);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_valid_ethaddr(=
mac_addr))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0eth_env_set_enetaddr(&quot;ethaddr&quot;, mac_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0meson_generate_serial_ethaddr();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth_env_get_enetaddr(=
&quot;ethaddr&quot;, mac_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;[i] setu=
p onboard mac %02X:%02X:%02X:%02X:%02X:%02X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mac_addr[0],mac_addr[1],mac_addr[2],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mac_addr[3],mac_addr[4],mac_addr[5]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000006d9ac705b8a08919--
