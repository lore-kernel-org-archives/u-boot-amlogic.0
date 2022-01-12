Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web08.2744.1642017904218065913
 for <u-boot-amlogic@groups.io>;
 Wed, 12 Jan 2022 12:05:04 -0800
Received: by mail-ot1-f41.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso3883123otf.0
        for <u-boot-amlogic@groups.io>; Wed, 12 Jan 2022 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7saTJUahMncG8hgPX7KKuNjv2L6J8bhvWx9mXRYD7O8=;
        b=Vk6JWcJMRU5urlRgQRtVKPTpboYYG0xRSJAp6OeweSPfHF7BBJrQhpXhaAkqRdMeFJ
         5sNSINz8qyw+mEAP8VCFCJWZPsy6maGMGLg4mlRAQVUZX9jr8axjD9yLpDagTjWkpclG
         LSEuJ72+JHsjuAfOqetXkCgf4W+yq97fkXnDA=
MIME-Version: 1.0
References: <20220110104639.13744-1-kabel@kernel.org>
In-Reply-To: <20220110104639.13744-1-kabel@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jan 2022 13:04:08 -0700
Message-ID: <CAPnjgZ2Y4p1U8cK6-jng7_8W09FhmoNNEYSz8vviTyFh5ZQ3yg@mail.gmail.com>
Subject: Re: [PATCH u-boot-dm v2] fdt_support: Add fdt_for_each_node_by_compatible() helper macro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, Tom Warren <twarren@nvidia.com>, Aaron Williams <awilliams@marvell.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, York Sun <yorksun@freescale.com>, Priyanka Jain <priyanka.jain@nxp.com>, Oliver Graute <oliver.graute@kococonnector.com>, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Anatolij Gustschin <agust@denx.de>, Neil Armstrong <narmstrong@baylibre.com>, Jagan Teki <jagan@amarulasolutions.com>, Andre Przywara <andre.przywara@arm.com>, Biwen Li <biwen.li@nxp.com>, Chaitanya Sakinam <chaitanya.sakinam@nxp.com>, Anji J <anji.jagarlmudi@nxp.com>, Michael Walle <michael@walle.cc>, Stefan Roese <sr@denx.de>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, Vladimir Oltean <vladimir.oltean@nxp.com>, Bin Meng <bmeng.cn@gmail.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Igal Liberman <igall@marvell.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Marek,

On Mon, 10 Jan 2022 at 03:46, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> From: Marek Beh=C3=BAn <marek.behun@nic.cz>
>
> Add macro fdt_for_each_node_by_compatible() to allow iterating over
> fdt nodes by compatible string.
>
> Convert various usages of
>     off =3D fdt_node_offset_by_compatible(fdt, start, compat);
>     while (off > 0) {
>         code();
>         off =3D fdt_node_offset_by_compatible(fdt, off, compat);
>     }
> and similar, to
>     fdt_for_each_node_by_compatible(off, fdt, start, compat)
>         code();
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> Reviewed-by: Stefan Roese <sr@denx.de>
> ---
> Simon, as in v1, this applies on top of marvell/next and we have another
> patch for marvell/next that depends on this.
> Could we let him apply it there after it is reviewed?
> Thanks.
>
> Changes since v1:
> - removed extra space after macro name:
>     fdt_for_each_node_by_compatible (...)
>   to
>     fdt_for_each_node_by_compatible(...)
>   as requested by Stefan
> ---
>  arch/arm/cpu/armv8/fsl-layerscape/fdt.c    |  9 ++-------
>  arch/arm/cpu/armv8/fsl-layerscape/icid.c   |  5 +----
>  arch/arm/mach-tegra/gpu.c                  |  5 +----
>  arch/mips/mach-octeon/octeon_fdt.c         | 11 ++---------
>  arch/powerpc/cpu/mpc85xx/liodn.c           |  9 ++-------
>  board/Marvell/octeon_ebb7304/board.c       |  9 +++------
>  board/congatec/cgtqmx8/spl.c               |  7 ++-----
>  board/freescale/lx2160a/lx2160a.c          |  5 +----
>  common/fdt_support.c                       | 22 ++++++++--------------
>  drivers/misc/fsl_portals.c                 |  6 +-----
>  drivers/net/fm/fdt.c                       |  3 +--
>  drivers/pci/pcie_layerscape_fixup_common.c | 12 ++----------
>  drivers/phy/marvell/comphy_a3700.c         | 10 +++++-----
>  drivers/video/meson/simplefb_common.c      |  7 ++-----
>  drivers/video/sunxi/simplefb_common.c      |  5 ++---
>  include/fdt_support.h                      |  6 ++++++
>  16 files changed, 41 insertions(+), 90 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

In general we should not be doing this sort of thing. There should be
a driver for each string, so we don't need this kind of ad-hoc code.

Regards,
Simon
