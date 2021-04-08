Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.3989.1617859778537118232
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Apr 2021 22:29:38 -0700
Received: by mail-yb1-f170.google.com with SMTP id c195so1284961ybf.9
        for <u-boot-amlogic@groups.io>; Wed, 07 Apr 2021 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6xogdl6FzDcmbWexf6BHghDYF7Fb4gLVG34uSJUCYM=;
        b=UN5bYNL0z9jE7/looQNN+aHSUcAIMxm7tC/OvMoz6PD2AKfVZsXDg/5s/VINqujOJM
         CLd9ptysc9IjwaUnlZKcdOs5sb1+wjvG0zH2TGeDKfDhBuY70zrulFguPTAtU8FBat/s
         OfNIaF6/B9lVcYTuMhuWT3Q0vVJCGqNN9wsswiGP2wpGrsk81w+X/qaw5e0tH2hDc2rf
         1TKAaeeNOWQsWxHHiqQl2eJvY7f0i1e1/j7Byf0Axw6kuQlIZoqgKJHihaQEGYnAcKSx
         NhSxmMSEwikg503FLmkQXP6H+lucgTWvzBYMqwssjHwpH5uzR3K7vjPcwvysSR4sAY73
         jTNQ==
MIME-Version: 1.0
References: <20210325144921.1791892-1-narmstrong@baylibre.com> <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com>
In-Reply-To: <d5f05f02-22e8-1faf-5754-715cd8dcfebd@baylibre.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Apr 2021 13:29:26 +0800
Message-ID: <CAEUhbmWtr93MGjEL9yfEz+ou5v-8y5w8eA+BxNeYLhxjkvZ+Tw@mail.gmail.com>
Subject: Re: [PATCH RFT v2 0/4] pci: add common Designware PCIe functions and support Amlogic Meson PCIe controller
Content-Type: text/plain; charset="UTF-8"
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Lokesh Vutla <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, Green Wan <green.wan@sifive.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Neil,

On Tue, Apr 6, 2021 at 8:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Bin,
>
> On 25/03/2021 15:49, Neil Armstrong wrote:
> > With the introduction of pcie_dw_rockchip, and need to support the DW PCIe in the
> > Amlogic AXG & G12 SoCs, most of the DW PCIe helpers would be duplicated.
> >
> > This introduce a "common" DW PCIe helpers file with common code merged from the
> > dw_ti and dw_rockchip drivers and adapted to fit with the upcoming dw_meson.
> >
> > The following changes will switch the dw_ti and dw_rockchip, and introduce a new
> > driver to support the Amlogic AXG & G12 SoCs using these new common helpers.
> >
> > The dw_meson has been validated, but the dw_ti and dw_rockchip would need testing
> > on hardware to validate nothing has been broken.
>
> How should be proceed ? I can't possibly test patches 2 & 3, but Green has tested it
> on Sifive, should patch 1 & 4 be merged then we should wait feedback from the Ti & Rockchip
> owners ?

This series is not assigned to me in patchwork so I cannot decide anything :)

But my opinion was that let's wait for some more time, and if nobody
jumps out let's merge this series.

Regards,
Bin
