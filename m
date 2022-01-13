Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.web10.8646.1642081295451141622
 for <u-boot-amlogic@groups.io>;
 Thu, 13 Jan 2022 05:41:35 -0800
Received: by mail-ua1-f51.google.com with SMTP id u6so11205341uaq.0
        for <u-boot-amlogic@groups.io>; Thu, 13 Jan 2022 05:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+j5u2jp6eytLiDaOm79BeeQwffU0BPWXPKpvrRhfuI=;
        b=Fv59F5L+CHkB41R8o/V4WKZ9ZbG+h1dlTg+oiJmNCVAb0vByfaCCTvjNxOiOVKBjPI
         BW9CsUMbUDzUFlPIkwwHkDsK1v4319Gyw96ADRnTxgViaJcj9tFTu2P9M9xMsUIq0IfJ
         j2DQs/KHLkIUZavO0oQui2So9Zfg2+D31BRrw=
MIME-Version: 1.0
References: <20220110104639.13744-1-kabel@kernel.org> <CAPnjgZ2Y4p1U8cK6-jng7_8W09FhmoNNEYSz8vviTyFh5ZQ3yg@mail.gmail.com>
 <20220112232426.7214a3e4@thinkpad>
In-Reply-To: <20220112232426.7214a3e4@thinkpad>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jan 2022 06:41:23 -0700
Message-ID: <CAPnjgZ3s8N+TaEYZaOkfwXCi8mHrOh_ecAWSR+_KU-yRmJpiMg@mail.gmail.com>
Subject: Re: [PATCH u-boot-dm v2] fdt_support: Add fdt_for_each_node_by_compatible() helper macro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, Tom Warren <twarren@nvidia.com>, Aaron Williams <awilliams@marvell.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, York Sun <yorksun@freescale.com>, Priyanka Jain <priyanka.jain@nxp.com>, Oliver Graute <oliver.graute@kococonnector.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Biwen Li <biwen.li@nxp.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Anji J <anji.jagarlmudi@nxp.com>, Michael Walle <michael@walle.cc>, Stefan Roese <sr@denx.de>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, Vladimir Oltean <vladimir.oltean@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Igal Liberman <igall@marvell.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On Wed, 12 Jan 2022 at 15:24, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> On Wed, 12 Jan 2022 13:04:08 -0700
> Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Marek,
> >
> > On Mon, 10 Jan 2022 at 03:46, Marek Beh=C3=BAn <kabel@kernel.org> wrote=
:
> > >
> > > From: Marek Beh=C3=BAn <marek.behun@nic.cz>
> > >
> > > Add macro fdt_for_each_node_by_compatible() to allow iterating over
> > > fdt nodes by compatible string.
> > >
> > > Convert various usages of
> > >     off =3D fdt_node_offset_by_compatible(fdt, start, compat);
> > >     while (off > 0) {
> > >         code();
> > >         off =3D fdt_node_offset_by_compatible(fdt, off, compat);
> > >     }
> > > and similar, to
> > >     fdt_for_each_node_by_compatible(off, fdt, start, compat)
> > >         code();
> > >
> > > Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> > > Reviewed-by: Stefan Roese <sr@denx.de>
> > > ---
> > > Simon, as in v1, this applies on top of marvell/next and we have anot=
her
> > > patch for marvell/next that depends on this.
> > > Could we let him apply it there after it is reviewed?
> > > Thanks.
> > >
> > > Changes since v1:
> > > - removed extra space after macro name:
> > >     fdt_for_each_node_by_compatible (...)
> > >   to
> > >     fdt_for_each_node_by_compatible(...)
> > >   as requested by Stefan
> > > ---
> > >  arch/arm/cpu/armv8/fsl-layerscape/fdt.c    |  9 ++-------
> > >  arch/arm/cpu/armv8/fsl-layerscape/icid.c   |  5 +----
> > >  arch/arm/mach-tegra/gpu.c                  |  5 +----
> > >  arch/mips/mach-octeon/octeon_fdt.c         | 11 ++---------
> > >  arch/powerpc/cpu/mpc85xx/liodn.c           |  9 ++-------
> > >  board/Marvell/octeon_ebb7304/board.c       |  9 +++------
> > >  board/congatec/cgtqmx8/spl.c               |  7 ++-----
> > >  board/freescale/lx2160a/lx2160a.c          |  5 +----
> > >  common/fdt_support.c                       | 22 ++++++++------------=
--
> > >  drivers/misc/fsl_portals.c                 |  6 +-----
> > >  drivers/net/fm/fdt.c                       |  3 +--
> > >  drivers/pci/pcie_layerscape_fixup_common.c | 12 ++----------
> > >  drivers/phy/marvell/comphy_a3700.c         | 10 +++++-----
> > >  drivers/video/meson/simplefb_common.c      |  7 ++-----
> > >  drivers/video/sunxi/simplefb_common.c      |  5 ++---
> > >  include/fdt_support.h                      |  6 ++++++
> > >  16 files changed, 41 insertions(+), 90 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > In general we should not be doing this sort of thing. There should be
> > a driver for each string, so we don't need this kind of ad-hoc code.
>
> Dear Simon,
>
> you are right for when this is used for U-Boot functionality.
>
> But when we need to fixup devicetree for Linux, this is the right thing
> to do.
>
> I need this macro for ft_board_setup().

Yes, understood. I think some sort of driver interface would be nice,
perhaps using driver model. Another option would be to register
handlers using the compatible string and have a function that works
through those.

See also the event series here:

https://patchwork.ozlabs.org/project/uboot/list/?series=3D278607
https://lore.kernel.org/u-boot/20211228082854.1255732-1-sjg@chromium.org/

Regards,
Simon
