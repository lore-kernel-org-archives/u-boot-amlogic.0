Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web12.2571.1618460422813398071
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Apr 2021 21:20:22 -0700
Received: by mail-yb1-f174.google.com with SMTP id k73so18369964ybf.3
        for <u-boot-amlogic@groups.io>; Wed, 14 Apr 2021 21:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t51DbyLR0TDYuPKR2TgjDevXAzKbRgeg/V32kinBIGI=;
        b=Hcyrok8fHMtCBvxO2IbSIaDpKnX8puJUSKyLZEB9xvJ8QMhnI6DlrBuDz1ah55dpmJ
         gJ/pFFgdjkYNEzbUb4fkBQCTxSkzOc36jOcq/CGKmAWOZmmWVDHDQWh0B+VWxWl2VwdF
         VU63db4KYpOPwKc1ildOuicCwjrOTudgKioucOfBofzVT1G5smKmYU4i9RTiM7qWLrg6
         vUXDed65vK41JKewqTgKGAhHzFBfqmHx3PWW3YUe8K3YEGUOlLuVHpi6x1eIJGvZYuhj
         NtxubKhP0PvdyC6F7pE4Jl0UoEP+0jaos7HBcOyzmWY8bE9gowZ8q27Wc/KgItAOrSBV
         ijcQ==
MIME-Version: 1.0
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
 <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com> <CAEUhbmWtr93MGjEL9yfEz+ou5v-8y5w8eA+BxNeYLhxjkvZ+Tw@mail.gmail.com>
 <a4cc1629-c2a9-95bf-771e-2c48cec2af4e@baylibre.com> <CAEUhbmXhSZ=WY_P=VAEw20B44WCm0414g4B1jPfqRxGuv_CCvQ@mail.gmail.com>
In-Reply-To: <CAEUhbmXhSZ=WY_P=VAEw20B44WCm0414g4B1jPfqRxGuv_CCvQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 15 Apr 2021 12:20:09 +0800
Message-ID: <CAEUhbmXmRTa10uTpTQw8t1d0cY8QG2e3f3LY=D5NNMCSB8=pTQ@mail.gmail.com>
Subject: Re: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, Green Wan <green.wan@sifive.com>
List-ID: <u-boot-amlogic@groups.io>

On Thu, Apr 15, 2021 at 6:24 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi,
>
> On Thu, Apr 8, 2021 at 3:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > On 08/04/2021 07:29, Bin Meng wrote:
> > > Hi Neil,
> > >
> > > On Tue, Apr 6, 2021 at 8:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >>
> > >> Hi Bin,
> > >>
> > >> On 25/03/2021 15:49, Neil Armstrong wrote:
> > >>> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> > >>> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
> > >>>
> > >>> This introduce a "common" DW PCIe helpers file with common code merged from the
> > >>> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
> > >>>
> > >>> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
> > >>> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
> > >>>
> > >>> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
> > >>> on hardware to validate nothing has been broken.
> > >>
> > >> How should be proceed ? I can't possibly test patches 2 & 3, but Green has tested it
> > >> on Sifive, should patch 1 & 4 be merged then we should wait feedback from the Ti & Rockchip
> > >> owners ?
> > >
> > > This series is not assigned to me in patchwork so I cannot decide anything :)
> >
> > I can switch them to you, but I never know who to assign for these multi-vendor series...
> >
> > >
> > > But my opinion was that let's wait for some more time, and if nobody
> > > jumps out let's merge this series.
> >
> > Fine fore me !
>
> I am going to apply this series via the x86 tree if there are no
> further comments.

series applied to u-boot-x86, thanks!
