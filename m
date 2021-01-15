Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web08.1393.1610699994177505019
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Jan 2021 00:39:54 -0800
Received: by mail-io1-f46.google.com with SMTP id q2so15032009iow.13
        for <u-boot-amlogic@groups.io>; Fri, 15 Jan 2021 00:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P7dQmP9rFSsFhCLAYBYJOdPh2opkR1oUhVhRsR5VyWM=;
        b=Ep2YCboA67gUXCqXXJEnAjoelI+WPGTNwZ1mxQvy7yBYfwXQDcR/MC/c82DxbmU3F7
         Kh+8mufsUCXyX3bPeIdkoyzyQsx5b3okhDwg3rmjwqvBMYRRPub0P3j0MkTyfDjEbYao
         HAIaKscg7LU/z2kKtZVPlhCk9hHvUfxk/57Ceol4+4/TFG2rG7/l/LAjxbjQbZryr5LE
         UkdQ8R5LMYIEdU9sqwXFYaV1EztW6hDe2aeh0BGJj/tMUnRwcJDYJsqZPV7l2r3kdNzx
         03/AS1Me6LQtH4fKixTchbNF9fK9RVp+6lglYTBWw/cynV5eAwrNjMGjjJS4PHVnmIUu
         jplQ==
MIME-Version: 1.0
References: <20210115051558.469734-1-art@khadas.com> <20210115051558.469734-3-art@khadas.com>
 <0aa51879-43da-d249-09c3-b32e601224b6@baylibre.com>
In-Reply-To: <0aa51879-43da-d249-09c3-b32e601224b6@baylibre.com>
From: Art Nikpal <email2tema@gmail.com>
Date: Fri, 15 Jan 2021 16:39:42 +0800
Message-ID: <CAKaHn9+946XJ5S3e8hQRJukpZ3X5EQqn0TYMQdSgth4KxwbKbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: fix meson-khadas-vim3-u-boot.dtsi
Content-Type: multipart/alternative; boundary="000000000000f5ad3d05b8ec505d"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>, hs@denx.de, Artem Lapkin <art@khadas.com>, nick@khadas.com, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

--000000000000f5ad3d05b8ec505d
Content-Type: text/plain; charset="UTF-8"

> It's not necessary since already included in:

Yes u right !  Sorry !


On Fri, Jan 15, 2021 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com>
wrote:

> Hi,
>
>
> On 15/01/2021 06:15, Artem Lapkin wrote:
> > Add missed include meson-g12-common-u-boot.dtsi
> >
> > PROBLEM: missed hdmi video setup for VIM3 and VIM3L boards
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
> > ---
> >  arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> > index 81fd5be378..5d6444cbac 100644
> > --- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> > +++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi
> > @@ -10,6 +10,8 @@
> >       };
> >  };
> >
> > +#include "meson-g12-common-u-boot.dtsi"
> > +
>
> It's not necessary since already included in:
> arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi:#include
> "meson-g12-common-u-boot.dtsi"
> and
> arch/arm/dts/meson-sm1-u-boot.dtsi:#include "meson-g12-common-u-boot.dtsi"
>
> What u-boot version are you using ?
> Please check u-boot-master and my u-boot-amlogic and u-boot-amlogic-next
> branches on https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic
> before posting !
>
> Thanks,
> Neil
>

--000000000000f5ad3d05b8ec505d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span class=3D"gmail-im"><br>
<br></span><div>
&gt; It&#39;s not necessary since already included in:</div><div><br></div>=
<div>Yes u right !=C2=A0 Sorry !<br></div><div><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 15, 20=
21 at 4:15 PM Neil Armstrong &lt;<a href=3D"mailto:narmstrong@baylibre.com"=
>narmstrong@baylibre.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hi,<br>
<br>
<br>
On 15/01/2021 06:15, Artem Lapkin wrote:<br>
&gt; Add missed include meson-g12-common-u-boot.dtsi<br>
&gt; <br>
&gt; PROBLEM: missed hdmi video setup for VIM3 and VIM3L boards<br>
&gt; <br>
&gt; Signed-off-by: Artem Lapkin &lt;<a href=3D"mailto:art@khadas.com" targ=
et=3D"_blank">art@khadas.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/arm/dts/meson-khadas-vim3-u-boot.dtsi | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt; <br>
&gt; diff --git a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi b/arch/arm/dts=
/meson-khadas-vim3-u-boot.dtsi<br>
&gt; index 81fd5be378..5d6444cbac 100644<br>
&gt; --- a/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi<br>
&gt; +++ b/arch/arm/dts/meson-khadas-vim3-u-boot.dtsi<br>
&gt; @@ -10,6 +10,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; +#include &quot;meson-g12-common-u-boot.dtsi&quot;<br>
&gt; + <br>
<br>
It&#39;s not necessary since already included in:<br>
arch/arm/dts/meson-g12b-a311d-khadas-vim3-u-boot.dtsi:#include &quot;meson-=
g12-common-u-boot.dtsi&quot;<br>
and<br>
arch/arm/dts/meson-sm1-u-boot.dtsi:#include &quot;meson-g12-common-u-boot.d=
tsi&quot;<br>
<br>
What u-boot version are you using ?<br>
Please check u-boot-master and my u-boot-amlogic and u-boot-amlogic-next br=
anches on <a href=3D"https://gitlab.denx.de/u-boot/custodians/u-boot-amlogi=
c" rel=3D"noreferrer" target=3D"_blank">https://gitlab.denx.de/u-boot/custo=
dians/u-boot-amlogic</a> before posting !<br>
<br>
Thanks,<br>
Neil<br>
</blockquote></div>

--000000000000f5ad3d05b8ec505d--
