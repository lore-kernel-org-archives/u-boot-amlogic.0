Received: by mail-qk1-f182.google.com with SMTP id i5so4865311qkd.13
        for <u-boot-amlogic@groups.io>; Mon, 25 Feb 2019 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQAhqerjPrCgIwY4b9PCnTVDjyXZMLHF1Vq1XKLFhxM=;
        b=WDNDKzGcVqDoqj2ae4dSObU9ikuyNqVRei/BFF3B7feB4t48PjMkYXWhdr+sAltqqL
         nG+2oBTH+cVQGF898ytp04C3YskRY+c1918Vb7r7MFLXaguYFo3SYLraFCb7X2nC1aHq
         SiMii7rr426GM0o2IsRtghHJG51brJuKnc26W7XRHAfiPUZhr4b8e0A8BjBXpaQ9l8Av
         XwwsFx+FOPPusEtD9qVqV32uUzS3U5OdrCNt1DwdtLCnBs7lFBR9CKcEN26pYnTpG+a2
         HX2re/RCXzSecGzsH6qTe6V7Bmdr5U72Yz6ilXJiXYGB1Vq48KsoHAINWkMJJ+Xr6bkA
         0Org==
MIME-Version: 1.0
References: <CAJDSL=XkweEsJjzdjqJ6qXjpw7R1FdfEGbm9KqB+sefY--1ndQ@mail.gmail.com>
 <d2062adc-7733-9ae3-a7a4-36d9b4ad7abe@baylibre.com>
In-Reply-To: <d2062adc-7733-9ae3-a7a4-36d9b4ad7abe@baylibre.com>
From: =?UTF-8?B?QW5kcsOpIEJhbHNh?= <andrebalsa@gmail.com>
Date: Mon, 25 Feb 2019 10:58:41 +0100
Message-ID: <CAJDSL=Up4O2eXBfHmyO11seqTj=xGjohen3WvORwuwuQ9MVXcg@mail.gmail.com>
Subject: Re: Error in README.nanopi-k2 in mainline u-boot?
Content-Type: multipart/alternative; boundary="000000000000e5aaa60582b4fcf6"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

--000000000000e5aaa60582b4fcf6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,
Yes, sure. Thanks a bunch. Give me a couple of days to test the
instructions further and I'll mail the u-boot mailing with any fixes that I
find are needed to make compiling u-boot work.
Best regards,
Andr=C3=A9


On Mon, Feb 25, 2019 at 10:32 AM Neil Armstrong <narmstrong@baylibre.com>
wrote:

> Hi Andr=C3=A9,
>
> Only second checkout is needed
>
> Can you send a fix to the u-boot mailing list for that ?
>
> Neil
>
>
> On 24/02/2019 07:51, Andr=C3=A9 Balsa wrote:
> > Hello,
> > A quick introduction: Andr=C3=A9 Derrick Balsa (AndrewDB), Linux hacker=
,
> trying to document step-by-step building u-boot for an Amlogic S905 SBC.
> > On to the point of this mail:
> > In mainline u-boot, in u-boot/board/amlogic/odroid-c2/README.nanopi-k2,
> in the instructions to build the fip dir, we can find two git clone
> commands in sequence and I believe one of them is redundant, but I don't
> dare say which:
> >
> > git clone https://github.com/BayLibre/u-boot.git -b libretech-cc
> amlogic-u-boot
> >
> > git clone https://github.com/friendlyarm/u-boot.git -b
> nanopi-k2-v2015.01 amlogic-u-boot
> >
> > if executed in sequence the second git clone returns a fatal error:
> > fatal: destination path 'amlogic-u-boot' already exists and is not an
> empty directory.
> >
> > Thank you for taking any time for any answer on the subject.
> > Best regards,
> > AndrewDB
>
>
>
>

--000000000000e5aaa60582b4fcf6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Neil,</div><div dir=3D"ltr">Yes, sure.=
 Thanks a bunch. Give me a couple of days to test the instructions further =
and I&#39;ll mail the u-boot mailing with any fixes that I find are needed =
to make compiling u-boot work.</div><div dir=3D"ltr">Best regards,</div><di=
v dir=3D"ltr">Andr=C3=A9<br><div><br></div></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 25, 2019 at 10=
:32 AM Neil Armstrong &lt;<a href=3D"mailto:narmstrong@baylibre.com">narmst=
rong@baylibre.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Andr=C3=A9,<br>
<br>
Only second checkout is needed<br>
<br>
Can you send a fix to the u-boot mailing list for that ?<br>
<br>
Neil<br>
<br>
<br>
On 24/02/2019 07:51, Andr=C3=A9 Balsa wrote:<br>
&gt; Hello,<br>
&gt; A quick introduction: Andr=C3=A9 Derrick Balsa (AndrewDB), Linux hacke=
r, trying to document step-by-step building u-boot for an Amlogic S905 SBC.=
<br>
&gt; On to the point of this mail:<br>
&gt; In mainline u-boot, in u-boot/board/amlogic/odroid-c2/README.nanopi-k2=
, in the instructions to build the fip dir, we can find two git clone comma=
nds in sequence and I believe one of them is redundant, but I don&#39;t dar=
e say which:<br>
&gt; <br>
&gt; git clone <a href=3D"https://github.com/BayLibre/u-boot.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/BayLibre/u-boot.git</a> -b l=
ibretech-cc amlogic-u-boot<br>
&gt; <br>
&gt; git clone <a href=3D"https://github.com/friendlyarm/u-boot.git" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/friendlyarm/u-boot.git</a=
> -b nanopi-k2-v2015.01 amlogic-u-boot<br>
&gt; <br>
&gt; if executed in sequence the second git clone returns a fatal error:<br=
>
&gt; fatal: destination path &#39;amlogic-u-boot&#39; already exists and is=
 not an empty directory.<br>
&gt; <br>
&gt; Thank you for taking any time for any answer on the subject.<br>
&gt; Best regards,<br>
&gt; AndrewDB<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000e5aaa60582b4fcf6--
