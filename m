Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web10.21155.1618439059782372501
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Apr 2021 15:24:19 -0700
Received: by mail-yb1-f169.google.com with SMTP id v3so21552383ybi.1
        for <u-boot-amlogic@groups.io>; Wed, 14 Apr 2021 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzRi5U/FotUc3ZVzzNwsVMzpKzAKTE6f7e7V9pgMI7M=;
        b=c+KTiybqeyDwPMaaMk2PFtOVzrnCMEIewIRPi9yRdYVmV2exm8xTobMvxuzITkB/1N
         30zJxvTPpQBQxi0cVgCwf7O5WH3RY8iDC3sS0f2k90aCvAAeNubVvPyaJ68rP2yoIBY7
         8iRQwKpZyr0/wK0PSJtWPGFWX8D0WhCvxjieUAV0lhebvT/TLgWVyUB7iSuh93LQeao2
         Q4LOlJJ9W9qy0A/2aPPowgtYPkhBmJQF62HXSLy6lsQJGW1ZyTu6PheBZesKrAqZIJuV
         WtC4VnqGcODcphVacNvh/Cs7XQu7kmi4fGpDal6ojbad/AoiTT21IptOA0foIdZDps9W
         6cYg==
MIME-Version: 1.0
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
 <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com> <CAEUhbmWtr93MGjEL9yfEz+ou5v-8y5w8eA+BxNeYLhxjkvZ+Tw@mail.gmail.com>
 <a4cc1629-c2a9-95bf-771e-2c48cec2af4e@baylibre.com>
In-Reply-To: <a4cc1629-c2a9-95bf-771e-2c48cec2af4e@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 15 Apr 2021 06:24:07 +0800
Message-ID: <CAEUhbmXhSZ=WY_P=VAEw20B44WCm0414g4B1jPfqRxGuv_CCvQ@mail.gmail.com>
Subject: Re: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, Green Wan <green.wan@sifive.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, Apr 8, 2021 at 3:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 08/04/2021 07:29, Bin Meng wrote:
> > Hi Neil,
> >
> > On Tue, Apr 6, 2021 at 8:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Hi Bin,
> >>
> >> On 25/03/2021 15:49, Neil Armstrong wrote:
> >>> With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> >>> Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
> >>>
> >>> This introduce a "common" DW PCIe helpers file with common code merged from the
> >>> dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
> >>>
> >>> The following changes will switch the dw_ti and dw_rockchip, and introduce a new
> >>> driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
> >>>
> >>> The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
> >>> on hardware to validate nothing has been broken.
> >>
> >> How should be proceed ? I can't possibly test patches 2 & 3, but Green has tested it
> >> on Sifive, should patch 1 & 4 be merged then we should wait feedback from the Ti & Rockchip
> >> owners ?
> >
> > This series is not assigned to me in patchwork so I cannot decide anything :)
>
> I can switch them to you, but I never know who to assign for these multi-vendor series...
>
> >
> > But my opinion was that let's wait for some more time, and if nobody
> > jumps out let's merge this series.
>
> Fine fore me !

I am going to apply this series via the x86 tree if there are no
further comments.

Regards,
Bin
