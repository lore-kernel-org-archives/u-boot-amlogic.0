Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web09.27900.1610329341815777101
 for <u-boot-amlogic@groups.io>;
 Sun, 10 Jan 2021 17:42:21 -0800
Received: by mail-il1-f180.google.com with SMTP id w17so16739129ilj.8
        for <u-boot-amlogic@groups.io>; Sun, 10 Jan 2021 17:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3u8qcW9CJ9u6biCVGB00QDtHOARW252ncysxXeQx8Dg=;
        b=c+eYP3M6SSgi6aR+jzLtEmPYjfIgUF59LMp6zxQwSWZbF0enrS5s2ROGJZN8cNg6uT
         KWeAuYtqX9aBwXAADCxtGS7nb77+wYyuhc/A/X1kaWCzPDS2kTQVBNr8Hq0j/0M+zl2t
         BfMGDGIZwr+1hDJHq/l+HYntxO25XbRkSSIFPiEm5WGRz8u95+OIwiDHIUNU0We8cWz8
         Ee2O9sbuql51so18otngWH/UMEs1OEkmEN8Oj/D/bq//oEKXK3+y4pUy6WozSPNjyO5R
         W0lMqGMW0WbZqg4psmLwaY8yTJcFVtepnoGu32nX0QWEEISHgPRosVAfBoq1hNxvWSHD
         nQxg==
MIME-Version: 1.0
References: <CGME20210108124343epcas1p46dccb0f4dd6dad4bc177a560f4b1cb26@epcas1p4.samsung.com>
 <20210108054323.1449108-1-art@khadas.com> <7675a623-ca60-a071-1add-aa03bfc92216@samsung.com>
 <CAKaHn9+1O1YFigaX-7EUmF_MBgYsOAknn6jZ=D2Nhjx7fAHa3w@mail.gmail.com>
In-Reply-To: <CAKaHn9+1O1YFigaX-7EUmF_MBgYsOAknn6jZ=D2Nhjx7fAHa3w@mail.gmail.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Mon, 11 Jan 2021 09:42:10 +0800
Message-ID: <CAKaHn9JzNReCax8=46ZhRtx7gh+xdFuaBkNK7LdGs_X-6N=ibQ@mail.gmail.com>
Subject: Re: [PATCH] board: amlogic: vim3: ethernet mac fixed from serial
Content-Type: multipart/alternative; boundary="0000000000005beffe05b89604de"
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, khilman@baylibre.com, Christian Hewitt <christianshewitt@gmail.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Artem Lapkin <art@khadas.com>, nick@khadas.com, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

--0000000000005beffe05b89604de
Content-Type: text/plain; charset="UTF-8"

plz ignore my prev emails

> AFAIK, it's fixed with Marek's patch
>
https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/

look like yes ! u right

Best regards Art


On Mon, Jan 11, 2021 at 9:27 AM Art Nikpal <email2tema@gmail.com> wrote:

> > AFAIK, it's fixed with Marek's patch
> >
> https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/
>
> not solve !
> because mac which must stored in mcu is empty by default
> and by default we have random mac every time
>
> i think i will make new complex patch from both patches
>
> On Mon, Jan 11, 2021 at 6:46 AM Jaehoon Chung <jh80.chung@samsung.com>
> wrote:
>
>> Hi,
>>
>> On 1/8/21 2:43 PM, Artem Lapkin wrote:
>> > Fixed randomly generated ethernet mac address!
>> >
>> > Used meson_generate_serial_ethaddr for generate mac address from
>> > board serial number, if ethaddr variable not defined.
>>
>> AFAIK, it's fixed with Marek's patch
>>
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.szyprowski@samsung.com/
>>
>> Best Regards,
>> Jaehoon CHung
>>
>> >
>> > Signed-off-by: Artem Lapkin <art@khadas.com>
>> > ---
>> >  board/amlogic/vim3/vim3.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
>> > index 09ef39ff30..0315eaf569 100644
>> > --- a/board/amlogic/vim3/vim3.c
>> > +++ b/board/amlogic/vim3/vim3.c
>> > @@ -133,5 +133,14 @@ int misc_init_r(void)
>> >  {
>> >       meson_eth_init(PHY_INTERFACE_MODE_RGMII, 0);
>> >
>> > +     u8 mac_addr[6];
>> > +     if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
>> > +             meson_generate_serial_ethaddr();
>> > +             eth_env_get_enetaddr("ethaddr", mac_addr);
>> > +             printf("[i] serial eth mac
>> %02X:%02X:%02X:%02X:%02X:%02X\n",
>> > +                     mac_addr[0],mac_addr[1],mac_addr[2],
>> > +                     mac_addr[3],mac_addr[4],mac_addr[5]);
>> > +     }
>> > +
>> >       return 0;
>> >  }
>> >
>>
>>

--0000000000005beffe05b89604de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>plz ignore my prev emails</div><div><span class=3D"gm=
ail-im"><br></span></div><div><span class=3D"gmail-im">&gt; AFAIK, it&#39;s=
 fixed with Marek&#39;s patch<br><div>
&gt; <a href=3D"https://patchwork.ozlabs.org/project/uboot/patch/2020121707=
2642.1319-1-m.szyprowski@samsung.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.s=
zyprowski@samsung.com/</a></div><div><br></div><div>look like yes ! u right=
 <br></div><div><br></div><div>Best regards Art <br></div></span></div><br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Jan 11, 2021 at 9:27 AM Art Nikpal &lt;<a href=3D"mailto:email2tema=
@gmail.com">email2tema@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr">&gt; AFAIK, it&#39;s fixe=
d with Marek&#39;s patch<br><div>
&gt; <a href=3D"https://patchwork.ozlabs.org/project/uboot/patch/2020121707=
2642.1319-1-m.szyprowski@samsung.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchwork.ozlabs.org/project/uboot/patch/20201217072642.1319-1-m.s=
zyprowski@samsung.com/</a></div><div><br></div><div>not solve !<br></div><d=
iv>because mac which must stored in mcu is empty by default <br></div><div>=
and by default we have random mac every time</div><div><br></div><div>i thi=
nk i will make new complex patch from both patches</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 11, 202=
1 at 6:46 AM Jaehoon Chung &lt;<a href=3D"mailto:jh80.chung@samsung.com" ta=
rget=3D"_blank">jh80.chung@samsung.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Hi,<br>
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
</blockquote></div>

--0000000000005beffe05b89604de--
