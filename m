Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
 by mx.groups.io with SMTP id smtpd.web12.6974.1574865850463755936
 for <u-boot-amlogic@groups.io>;
 Wed, 27 Nov 2019 06:44:10 -0800
Received: by mail-io1-f65.google.com with SMTP id k1so25120441ioj.6
        for <u-boot-amlogic@groups.io>; Wed, 27 Nov 2019 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkLgzNFLa0OyIlsckRuOVSoCoEZE5xRSceyMvdquYME=;
        b=GAOL0JeAFPao9jiwRQJTCDCAvFgmdYVwhxEV7QvftqrCKeVGLh8zbWwgSk+Sc22fBT
         WPfJmR95BNJ606AwjYdRina0vKdFmCEFCEtfQp2mC31MUZAB14gSWTD+5tuqK1KQ07j5
         tUYMPOm7b9fiSzYlUAmDbM75o88bixVofFWCDesHHdKeUhs0Wn/gOZISCsbX7WE4lUpo
         7r2VBwjduI4EvakrqAJjEfeTAzXhhZ5Xa38K5UaVHGGp+KK14+aTJOkT4ZO5myclwBSo
         CIlqt4AWaYHpSt0+6E2W2ks4lDe+103Yvl0sDrGFyTvHRmM1Zj1Oyz6LY+Hc3SQg4vsq
         kZJw==
MIME-Version: 1.0
References: <20191126211206.4537-1-linux.amoon@gmail.com> <20191126211206.4537-5-linux.amoon@gmail.com>
 <455903af-cba5-6ff5-d1af-b2367626d309@baylibre.com>
In-Reply-To: <455903af-cba5-6ff5-d1af-b2367626d309@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 27 Nov 2019 20:13:58 +0530
Message-ID: <CANAwSgSf41hDs1v1qg+c9kjmNr5eMPhvWPsjvpsvNCnLeK315Q@mail.gmail.com>
Subject: Re: [U-Boot] [PATCH 4/4] board: amlogic: Add missing config option
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Wed, 27 Nov 2019 at 18:25, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 26/11/2019 22:12, Anand Moon wrote:
> > Add missing config option CONFIG_MESON_GXBB and CONFIG_SYS_BOARD,
> > for odroid-c2 and nanopi k2 board
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  configs/nanopi-k2_defconfig | 2 ++
> >  configs/odroid-c2_defconfig | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> > index 7bdeb7906a..3d6265c587 100644
> > --- a/configs/nanopi-k2_defconfig
> > +++ b/configs/nanopi-k2_defconfig
> > @@ -1,6 +1,8 @@
> >  CONFIG_ARM=y
> > +CONFIG_SYS_BOARD="p200"
> >  CONFIG_ARCH_MESON=y
> >  CONFIG_SYS_TEXT_BASE=0x01000000
> > +CONFIG_MESON_GXBB=y
> >  CONFIG_ENV_SIZE=0x2000
> >  CONFIG_NR_DRAM_BANKS=1
> >  CONFIG_DEBUG_UART_BASE=0xc81004c0
> > diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> > index 1f5a52c57c..700c871918 100644
> > --- a/configs/odroid-c2_defconfig
> > +++ b/configs/odroid-c2_defconfig
> > @@ -1,6 +1,8 @@
> >  CONFIG_ARM=y
> > +CONFIG_SYS_BOARD="p200"
> >  CONFIG_ARCH_MESON=y
> >  CONFIG_SYS_TEXT_BASE=0x01000000
> > +CONFIG_MESON_GXBB=y
> >  CONFIG_ENV_SIZE=0x2000
> >  CONFIG_NR_DRAM_BANKS=1
> >  CONFIG_DEBUG_UART_BASE=0xc81004c0
> >
>
> These are not present since they are the default values, thus not exported in savedefconfig.
>
> Neil

You can ignore and drop this changes.

-Anand
