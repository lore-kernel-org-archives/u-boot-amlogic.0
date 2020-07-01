Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
 by mx.groups.io with SMTP id smtpd.web10.23485.1593614593707827587
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 07:43:13 -0700
Received: by mail-io1-f65.google.com with SMTP id i4so25226639iov.11
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiKJUcb/HG0ckXANHkgsK9TQ2rwoGhQ+CD/J2Wzhl0M=;
        b=g8O58K9BTnoCULo38Mh9lVCBxgf+maRY83+6g/w7y+0gZqCS3CfOXCSsSFXK1eNv5h
         tzm6h71uyxwmS2s9aRY0tcyzKl9xdUPaoEtcVo0NyQk3QegQui77tdKzmAdrqO47Y4W3
         AjK5FDtdk3weB5x07/+l48lkafsea7RjCSPXwBbLbxb1XpVBASRqZLS/yunKOjz3fOHU
         DteozUgJfP/yFLhdAVLdBaAPNGnaPCDezw5EeNhES7aTdelX2dIJv8RzD+CWkDlrqjZP
         O77e5Etktl8c1qw0QfSvNnAgg7JAznKFXNGf5Sg4ykXGd3UzDkyejkw+kDZrSBKMhWZN
         AO+Q==
MIME-Version: 1.0
References: <20200505202217.7849-1-b.galvani@gmail.com> <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
 <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com> <CANAwSgR8jX+Z+xZ3EXHQbq80dswn6WjaF-vyJHjyxQREVf+Mfg@mail.gmail.com>
 <eb5df59e-4d45-99d1-c131-bc630fd772d8@baylibre.com> <CANAwSgQu6c0V-ujGk3R3BkZTRY_Z7KPjP1BF2srnYYNQjdb9UA@mail.gmail.com>
 <32f06e45-4425-6970-e173-791ff87ae9e5@baylibre.com>
In-Reply-To: <32f06e45-4425-6970-e173-791ff87ae9e5@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 1 Jul 2020 20:13:02 +0530
Message-ID: <CANAwSgSH-ZzE+TsrjNUp+OL4w3xDg7RMc9HOaKU+Yh-hu=1ZbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 1 Jul 2020 at 18:38, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 01/07/2020 13:31, Anand Moon wrote:
> > Hi Neil,
> >
> > On Wed, 1 Jul 2020 at 13:22, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Hi,
> >>
> >> On 30/06/2020 18:02, Anand Moon wrote:
> >>> Hi Neil,
> >>>
> >>> On Tue, 30 Jun 2020 at 18:30, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 30/06/2020 13:33, Anand Moon wrote:
> >>>>> Hi Beniamino,
> >>>>>
> >>>>> On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> these two patches add initial u-boot support for Hardkernel ODROID-C4.
> >>>>>>
> >>>>>> https://wiki.odroid.com/odroid-c4/odroid-c4
> >>>>>>
> >>>>>> Beniamino Galvani (2):
> >>>>>>   arm: dts: import ODROID-C4 device tree
> >>>>>>   boards: amlogic: add ODROID-C4 support
> >>>>>>
> >>>>>
> >>>>> Can you respin this patches, I would like to see these get merged in
> >>>>> the current u-boot release
> >>>>>
> >>>>> -Anand
> >>>>>
> >>>>
> >>>> The Odroid-C4 could re-use the new Odroid-N2 board support I submitted at [1]
> >>>>
> >>>> Anand, is the MAC address stored stored the same way on the C4 ?
> >>>>
> >>>> Neil
> >>>>
> >>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/
> >>>
> >>> I gave this patches a try on latest u-boot but I cannot make my Odroid
> >>> C4 to boot up uinsg microSD card and eMMC
> >>> Here are the logs.
> >>
> >> The PHY config must be wrong and it misses the -u-boot.dtsi to enable HDMI.
> >>
> >> Can you test my custodian test branch with my C4 support patchset ?
> >>
> >> https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-test
> >>
> >> This one is used in Armbian 5.4 release and our KernelCI lab.
> >>
> >> Neil
> >>
> >
> > Thanks.
> >
> > There seems to be a typo in the build instructions in #
> > doc/board/amlogic/odroid-c4.rst
> > instead of *g12b*, it should be *g12a*
> >
> > See below I get following build warning, which I fix locally,
> >
> > ./buildc4c.sh: line 78:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> > ./buildc4c.sh: line 81:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> > ./buildc4c.sh: line 84:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> > ./buildc4c.sh: line 87:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> > ./buildc4c.sh: line 90:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> > ./buildc4c.sh: line 92:
> > /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> > No such file or directory
> >
> > After that fix I am able to boot my board using eMMC and microSD card.
>
> Thanks for testing, I'll push my serie rebased on v5.8-rc1 and fix this typo.
>
> Neil
>

Thanks, I see the same issue with random mac address just like N2.

-Anand
