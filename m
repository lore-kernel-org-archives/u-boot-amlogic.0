Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web09.32583.1612180966149170203
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Feb 2021 04:02:46 -0800
Received: by mail-wm1-f49.google.com with SMTP id o5so2774207wmq.2
        for <u-boot-amlogic@groups.io>; Mon, 01 Feb 2021 04:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wm+aCRnWWPzM4eedcin11dHkwNEYwXtJ2KLHte1YM0=;
        b=drKoGxVOXsyovEiFOi9s5W5cJjWJJ0gQ0B6uN+YKMRlXzikGb1JU2i1n6DLNZ/t6JG
         CVJKHppaQbvc9Qh4dujlgR0xV0ky3DQM6I5CR2i1p486ZexoEOF+YvxnHBGEI7ZVePFK
         ey13MucAfR13NWg8H1IvYbRIwLj7v6G1KYsRo=
MIME-Version: 1.0
References: <20201128174958.4.I07862310b4e40efa2ea158f4f84e0f79dcfec7ed@changeid>
 <20201129005011.2104545-1-sjg@chromium.org> <CAPnjgZ2Ncs4sCFnAzcBobn6zkpeYH=7-OGb6jJbJyuLWuLEFXg@mail.gmail.com>
 <53b0a6c5-fc97-12ff-2468-10e86cba60fd@microchip.com> <CAPnjgZ3p0=fvxHUd1Nf=-rXk-B7nGVMzbCXBB70PndyubiNcHg@mail.gmail.com>
 <5e45863b-9459-0bd4-a43e-c470a6df659e@microchip.com>
In-Reply-To: <5e45863b-9459-0bd4-a43e-c470a6df659e@microchip.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Feb 2021 05:02:31 -0700
Message-ID: <CAPnjgZ0NJgBxdYMPFFnUQctdTjvuzXO1O5Pvpp9f=Ayp-Lqy5A@mail.gmail.com>
Subject: Re: [PATCH 04/11] dm: Remove uses of device_bind_offset()
Content-Type: text/plain; charset="UTF-8"
To: Eugen Hristev <Eugen.Hristev@microchip.com>
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, Claudiu Beznea <Claudiu.Beznea@microchip.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Horatiu Vultur <Horatiu.Vultur@microchip.com>, Icenowy Zheng <icenowy@aosc.io>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>, Lars Povlsen <Lars.Povlsen@microchip.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, Martin Fuzzey <martin.fuzzey@flowbird.group>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matthias Brugger <mbrugger@suse.com>, Neil Armstrong <narmstrong@baylibre.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, Robert Beckett <bob.beckett@collabora.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

Hi Eugen,

On Mon, 1 Feb 2021 at 01:13, <Eugen.Hristev@microchip.com> wrote:
>
> On 31.01.2021 17:37, Simon Glass wrote:
> > Hi Eugen,
> >
> > On Sun, 31 Jan 2021 at 02:18, <Eugen.Hristev@microchip.com> wrote:
> >>
> >> On 10.12.2020 02:26, Simon Glass wrote:
> >>> This function is not needed since the standard device_bind() can be used
> >>> instead.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>    arch/x86/cpu/apollolake/spl.c               |  2 +-
> >>>    drivers/clk/at91/compat.c                   | 20 ++++++++------------
> >>>    drivers/clk/clk.c                           |  2 +-
> >>>    drivers/gpio/mt7621_gpio.c                  |  4 ++--
> >>>    drivers/gpio/s5p_gpio.c                     |  4 ++--
> >>>    drivers/gpio/sunxi_gpio.c                   |  4 ++--
> >>>    drivers/gpio/tegra186_gpio.c                |  4 ++--
> >>>    drivers/gpio/tegra_gpio.c                   |  6 +++---
> >>>    drivers/net/mvpp2.c                         |  4 ++--
> >>>    drivers/pinctrl/broadcom/pinctrl-bcm283x.c  |  5 ++---
> >>>    drivers/pinctrl/meson/pinctrl-meson.c       |  4 +++-
> >>>    drivers/pinctrl/mscc/pinctrl-jr2.c          |  4 ++--
> >>>    drivers/pinctrl/mscc/pinctrl-luton.c        |  4 ++--
> >>>    drivers/pinctrl/mscc/pinctrl-ocelot.c       |  4 ++--
> >>>    drivers/pinctrl/mscc/pinctrl-serval.c       |  4 ++--
> >>>    drivers/pinctrl/mscc/pinctrl-servalt.c      |  4 ++--
> >>>    drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |  8 ++++----
> >>>    drivers/power/regulator/Kconfig             |  2 +-
> >>>    include/dm/device-internal.h                |  4 ++--
> >>>    include/power/regulator.h                   |  2 +-
> >>>    20 files changed, 46 insertions(+), 49 deletions(-)
> >>>
> >>> Applied to u-boot-dm, thanks!
> >>>
> >>
> >>
> >> Hi Simon,
> >>
> >> I bisected the tree and this commit looks to break
> >> sama5d4_xplained_mmc_defconfig :
> >>
> >> <debug_uart>
> >> No serial driver found
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Could not initialize timer (err -19)
> >>
> >> Booting u-boot fails when adding this commit.
> >>
> >> Could you please help or let me know how I can fix it ?
> >
> > I suspect the problem could be in the changes to
> > drivers/clk/at91/compat.c although I cannot see why
> >
> > You could try reverting that change, and just using offset_to_ofnode()
> > in the device_bind_driver_to_node() call. I actually intended to do
> > that at the time due to the risk, but somehow I missed this one.
> >
> > OTOH it would be good to move the code to livetree and stop using fdt offsets.
> >
> > Regards,
> > Simon
> >
>
> I reverted the changes in compat.c and indeed now it boots correctly.
>
> I tried to do the following change on top of your code as you suggested
> but it does not help:
>
>
> --- a/drivers/clk/at91/compat.c
> +++ b/drivers/clk/at91/compat.c
> @@ -67,7 +67,7 @@ int at91_clk_sub_device_bind(struct udevice *dev,
> const char *drv_name)
>          bool pre_reloc_only = !(gd->flags & GD_FLG_RELOC);
>          const char *name;
>          int ret;
> -
> +       int offset = dev_of_offset(dev);
>          ofnode_for_each_subnode(node, parent) {
>                  if (pre_reloc_only && !ofnode_pre_reloc(node))
>                          continue;
> @@ -84,7 +84,7 @@ int at91_clk_sub_device_bind(struct udevice *dev,
> const char *drv_name)
>                  name = ofnode_get_name(node);
>                  if (!name)
>                          return -EINVAL;
> -               ret = device_bind_driver_to_node(dev, drv_name, name, node,
> +               ret = device_bind_driver_to_node(dev, drv_name, name,
> offset_to_ofnode(offset),
>                                                   NULL);
>                  if (ret)
>                          return ret;
>
>
> I have a feeling the 'for loop' for the subnodes misses an essential
> driver and thus it fails booting

Then I think reverting all the changes is the best thing in this file.
Can you send a patch?

Ultimately this should be figured out, but I cannot see what is wrong
and don't have that hardware to try. I do have an old SAM9260/9263 but
I'm not sure if that uses the same driver.

Regards,
Simon
