Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
 by mx.groups.io with SMTP id smtpd.web11.138929.1680719925800172867
 for <u-boot-amlogic@groups.io>;
 Wed, 05 Apr 2023 11:38:45 -0700
Received: by mail-yb1-f178.google.com with SMTP id d3so15800373ybu.1
        for <u-boot-amlogic@groups.io>; Wed, 05 Apr 2023 11:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680719925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJfLaFzbH/2Ju5QS0EeWlC1yCII1lYGihN/Kimg+OhA=;
        b=hT4MJxMMHD7UI66WcUbX94YmXqOiXNLLU+BBZzVqCx2GtG9UdFoRkDqgDAvhnBTSid
         d3HAUQeAnrHmkkDBnqfevdvMs8cizAZLU+y8smj5leVoHQEkUQvcNfktydu2AMptZUhW
         PKWLX8n3skj3/ZtstukRPitUe9yASVqBYqI3Q=
MIME-Version: 1.0
References: <20230401185458.2280200-1-sjg@chromium.org> <87zg7rb8dd.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ0Js43JOi3xaeY8tYuELSPXWL-PCBq1-iANLs1074MzbQ@mail.gmail.com> <1973D65D-692D-4AA7-B074-942D4E9ADB4B@gmail.com>
In-Reply-To: <1973D65D-692D-4AA7-B074-942D4E9ADB4B@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Apr 2023 06:38:21 +1200
Message-ID: <CAPnjgZ14t6KR5sPzaq9HbLG1ocUHtbpLrwfBPMJZXQdaq2ALRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] meson: Demonstration of using binman to produce the image
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, AML <linux-amlogic@lists.infradead.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi Christian,

On Mon, 3 Apr 2023 at 20:10, Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> > On 2 Apr 2023, at 6:41 am, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Mark,
> >
> > On Sun, 2 Apr 2023 at 09:28, Mark Kettenis <mark.kettenis@xs4all.nl> wr=
ote:
> > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > > Date: Sun,  2 Apr 2023 06:54:57 +1200
> > > >
> > > > The Odroid-C2 is quite a complicated image with many steps. It is a=
n ideal
> > > > example for how Binman can be used.
> > >
> > > You say Odroid-C2, but the patches seem to address the Odroid-C4...
> >
> > Ah, yes. The difference seems to be an Amlogic S905 on the C2 and an S9=
02X3 on the C4. I wonder if that affects the image makeup?
>
> There are currently four different signing recipes that depend on the
> board family that you are building for:
>
> - GXBB
> - GXL/GXM
> - G12A/SM1
> - G12B
>
> The G12A/SM1 and G12B recipes are identical except for a different
> signing binary used. The latest Amlogic boards (S905X4, T7, etc.)
> also have incremental changes, but none are currently supported in
> Linux or u-boot.
>
> One of the challenges for binman will be the signing tools. Currently
> this patchset depends upon Amlogic binaries. Apart from them being
> closed-source and thus undesirable, they are also x86_64 only and
> there are quite a few users (and at least one major distro) needing
> to build on arm64 hardware.
>
> There is an open-source tool called gxlimg which supports GXL and newer
> boards. IMHO it would make a lot of sense for u-boot to absorb the
> functionality of gxlimg (and extend support backwards to GXBB) as this
> would remove the dependency on Amlogic binaries and allow u-boot build
> and binman signing to be done anywhere.
>
> https://github.com/repk/gxlimg

Fair enough, but another option would be to allow 'binman tool -f
gxlimg' to work, which should be easy. Then we can make use of the
existing C code, using binary tools for the unsupported ones.

>
> > The patch is for testing by Christian, who I hope can help get this lan=
ded for all the Amlogic boards.
>
> I will try to find the time to test this, but it=E2=80=99s not something =
I
> could do more with (as only supporting 1/4 of the board families
> that I need to build for, bu I do appreciate it=E2=80=99s a POC).

Yes, it's a start.

>
> In case you=E2=80=99re not aware, Makefile based signing is implemented i=
n
> the amlogic-boot-fip repo that I=E2=80=99m currently tooled around:
>
> https://github.com/LibreELEC/amlogic-boot-fip
>
> This is the =E2=80=9Ccompetition=E2=80=9D so to speak. It=E2=80=99s quite=
 simple and widely
> used by most of the Amlogic supporting distros right now.

Well at least that provides the recipes.

Regards,
Simon
