Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.27541.1610328444363129343
 for <u-boot-amlogic@groups.io>;
 Sun, 10 Jan 2021 17:27:24 -0800
Received: by mail-io1-f45.google.com with SMTP id 81so16148996ioc.13
        for <u-boot-amlogic@groups.io>; Sun, 10 Jan 2021 17:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB61B12rc9d4pex53EFIL1L/cpRD1fEhgNcWPlXL5c8=;
        b=jns2fqZH8zr+w8y0+sRbp9o1TeXucsobn2tVF1qgu5LG4IiuHlD2rEbsNmvj1CcoNk
         ETBSzxdfNt3HnzqruTUvoR82hk7kJR5uj/b5emx/TNzj+1qO5uL5k6eOwiXUnJNlvgyy
         la16AMAeUEKOoba+FXPBFj6pjBQz32vUwklwfUrAtDQ7VCfm6Vfh9UfbG2o9do3D1pl+
         FKlhIpYkJifjFXJIxSk54RtL16qxQaUlsKq2zTYRw1Sc88H7qungIdTuZoK8gSEp90JB
         q8M091hAfezwn1jBpcZYj2AsCVrxBbBkIWuR06dV5pRbeFe+kXoIMF6WmXmC5nTW0Pvx
         rLFQ==
MIME-Version: 1.0
References: <CGME20210108124343epcas1p46dccb0f4dd6dad4bc177a560f4b1cb26@epcas1p4.samsung.com>
 <20210108054323.1449108-1-art@khadas.com> <7675a623-ca60-a071-1add-aa03bfc92216@samsung.com>
In-Reply-To: <7675a623-ca60-a071-1add-aa03bfc92216@samsung.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 11 Jan 2021 09:27:12 +0800
Message-ID: <CAKaHn9+1O1YFigaX-7EUmF_MBgYsOAknn6jZ=D2Nhjx7fAHa3w@mail.gmail.com>
Subject: Re: [PATCH] board: amlogic: vim3: ethernet mac fixed from serial
Content-Type: multipart/alternative; boundary="000000000000dd22b905b895ce70"
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, Christian Hewitt <christianshewitt@gmail.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Artem Lapkin <art@khadas.com>, nick@khadas.com, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

--000000000000dd22b905b895ce70
Content-Type: text/plain; charset="UTF-8"

> AFAIK, it's fixed with Marek's patch
>
https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/

not solve !
because mac which must stored in mcu is empty by default
and by default we have random mac every time

i think i will make new complex patch from both patches

On Mon, Jan 11, 2021 at 6:46 AM Jaehoon Chung <jh80.chung@samsung.com>
wrote:

> Hi,
>
> On 1/8/21 2:43 PM, Artem Lapkin wrote:
> > Fixed randomly generated ethernet mac address!
> >
> > Used meson_generate_serial_ethaddr for generate mac address from
> > board serial number, if ethaddr variable not defined.
>
> AFAIK, it's fixed with Marek's patch
>
>
> https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/
>
> Best Regards,
> Jaehoon CHung
>
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  board/amlogic/vim3/vim3.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> > index 09ef39ff30..0315eaf569 100644
> > --- a/board/amlogic/vim3/vim3.c
> > +++ b/board/amlogic/vim3/vim3.c
> > @@ -133,5 +133,14 @@ int misc_init_r(void)
> >  {
> >       meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
> >
> > +     u8 mac_addr[6];
> > +     if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
> > +             meson_generate_serial_ethaddr();
> > +             eth_env_get_enetaddr("ethaddr", mac_addr);
> > +             printf("[i] serial eth mac
> %02X:%02X:%02X:%02X:%02X:%02X\n",
> > +                     mac_addr[0],mac_addr[1],mac_addr[2],
> > +                     mac_addr[3],mac_addr[4],mac_addr[5]);
> > +     }
> > +
> >       return 0;
> >  }
> >
>
>

--000000000000dd22b905b895ce70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; AFAIK, it&#39;s fixed with Marek&#39;s patch<br><div>
&gt; <a href=3D"https://patchwork.ozlabs.org/project/uboot/patch/2020121707=
2642.1319-1-m.szyprowski@samsung.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.s=
zyprowski@samsung.com/</a></div><div><br></div><div>not solve !<br></div><d=
iv>because mac which must stored in mcu is empty by default <br></div><div>=
and by default we have random mac every time</div><div><br></div><div>i thi=
nk i will make new complex patch from both patches</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 11, 202=
1 at 6:46 AM Jaehoon Chung &lt;<a href=3D"mailto:jh80.chung@samsung.com">jh=
80.chung@samsung.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Hi,<br>
<br>
On 1/8/21 2:43 PM, Artem Lapkin wrote:<br>
&gt; Fixed randomly generated ethernet mac address!<br>
&gt; <br>
&gt; Used meson_generate_serial_ethaddr for generate mac address from<br>
&gt; board serial number, if ethaddr variable not defined.<br>
<br>
AFAIK, it&#39;s fixed with Marek&#39;s patch<br>
<br>
<a href=3D"https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.=
1319-1-m.szyprowski@samsung.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szypro=
wski@samsung.com/</a><br>
<br>
Best Regards,<br>
Jaehoon CHung<br>
<br>
&gt; <br>
&gt; Signed-off-by: Artem Lapkin &lt;<a href=3D"mailto:art@khadas.com" targ=
et=3D"_blank">art@khadas.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 board/amlogic/vim3/vim3.c | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt; <br>
&gt; diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c<br>
&gt; index 09ef39ff30..0315eaf569 100644<br>
&gt; --- a/board/amlogic/vim3/vim3.c<br>
&gt; +++ b/board/amlogic/vim3/vim3.c<br>
&gt; @@ -133,5 +133,14 @@ int misc_init_r(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);=
<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 mac_addr[6];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!eth_env_get_enetaddr(&quot;ethaddr&quot;, ma=
c_addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson_generate_serial=
_ethaddr();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth_env_get_enetaddr(=
&quot;ethaddr&quot;, mac_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;[i] seri=
al eth mac %02X:%02X:%02X:%02X:%02X:%02X\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mac_addr[0],mac_addr[1],mac_addr[2],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mac_addr[3],mac_addr[4],mac_addr[5]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 }<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000dd22b905b895ce70--
