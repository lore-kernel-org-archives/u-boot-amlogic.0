Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web10.4562.1635925304401414339
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Nov 2021 00:41:44 -0700
Received: by mail-il1-f176.google.com with SMTP id i9so1628095ilu.8
        for <u-boot-amlogic@groups.io>; Wed, 03 Nov 2021 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEKefpCihTmG8BzY1mCdS5xpg/kClNms6rjOSyCKgAY=;
        b=IBjTDQDyvU8wOgsQeAnbYPbdbJF05IjL1TTBSgCzoHniBAEXmjLVnHNc9cmQYjWspT
         gTf4YUxmshKYBn6zxMZ9wlbuhYBwMSgKmS93NmvMfPjFIdoIlGmTpZXeDOq2TgMuGc+n
         87PPf1p0WLQyDkQiJreJ2HXWjmNYZT0xOtjmvoPHRsl/6IG8RdFnGJ8EYvEOs7DwUST4
         DnAPG/1OQEAoXcU6tAo1RMZlhcYQYDyoXNauJ0xPwxBH7OpuVlIeOIZVi4zIRdzkT1Bw
         gAAXprwYXvZiimzVHEyebRuDMReSyuwNNcEyQV+ZsgZoNiVuPHZC+ZxBHlDqIsohSpDj
         ab+w==
MIME-Version: 1.0
References: <20211102071914.696963-1-art@khadas.com> <20211102164454.GQ24579@bill-the-cat>
In-Reply-To: <20211102164454.GQ24579@bill-the-cat>
From: Art Nikpal <email2tema@gmail.com>
Date: Wed, 3 Nov 2021 15:41:32 +0800
Message-ID: <CAKaHn9LVEoiJDtCVdyHzYoi-0yQsFnJ5+jXVw-YYXznTsjdKMw@mail.gmail.com>
Subject: Re: [PATCH v1] env: setenv add resolve value option
Content-Type: text/plain; charset="UTF-8"
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, marek.behun@nic.cz, Neil Armstrong <narmstrong@baylibre.com>, Tom Warren <twarren@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Artem Lapkin <art@khadas.com>, Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

> The high level problem I have with this patch is that we keep going back
> to "we really need to update to a modern hush (or other shell) rather
> than patching new features in to our ancient fork".

Yes it will be fine ! Does anybody have information about these plans ?
but in any case my patch didn't broke  compatibility like next patch

> See also this old patch:
> https://patchwork.ozlabs.org/project/uboot/patch/1449255744-25787-1-git-send-email-nm@ti.com/

> Can you please add to the env tests?
> please add function comment
> ...

tnx for suggestions ...
i can make v2 variant for my patch , if no one is against this idea

On Wed, Nov 3, 2021 at 12:44 AM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 02, 2021 at 03:19:14PM +0800, Artem Lapkin wrote:
>
> > Add possibility setup env variable with additional resolving vars inside
> > value.
> >
> > Usage examples
> >
> > => setenv a hello
> > => setenv b world
> > => setenv c '${a} ${b}'
> > => setenv -r d '${c}! ${a}...'
> > => printenv d
> > d=hello world! hello...
> >
> > /* internal usage example */
> > env_resolve("d", "${c}! ${a}...");
> > /* d="hello world! hello..." */
> >
> > Notes
> >
> > Resolving works only for ${var} "bracket" and didn't workd for
> > "unbracket" $var
> >
> > => setenv -r d '$c! $a...'
> > => printenv d
> > d=$c! $a...
> >
> > Signed-off-by: Artem Lapkin <art@khadas.com>
>
> The high level problem I have with this patch is that we keep going back
> to "we really need to update to a modern hush (or other shell) rather
> than patching new features in to our ancient fork".
>
> --
> Tom
