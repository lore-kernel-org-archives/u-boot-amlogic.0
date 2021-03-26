Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web12.13194.1616768608127700382
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Mar 2021 07:23:28 -0700
Received: by mail-qv1-f45.google.com with SMTP id 30so2971795qva.9
        for <u-boot-amlogic@groups.io>; Fri, 26 Mar 2021 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO3Q1CKChGmMFL1rtMuUcrAlcxCEXoZkXPtzchAMqZo=;
        b=bZ05uX6KKa3XfdfCXeIZCybh9YkyZT0bAoHcJb//ijNa7RGHsu0Y2ER22KTIO570hk
         PoKhpDd3loFYsTBxWnAxvptxmv9Vydf1uNAgca7nj8h5v6iPYYJ0LLMQA193Jx3KLJna
         ey3Bz5Z9VQa8zvsy7XsDKeqNDvj0EU25P4z9p8A1oWSyN5H5LYnryo9TWzNrvJ5VLqTi
         j+ar17tslINd48c7i3TIp9VPNF4IN6suBzp+sNgIjMPfCcxu4vZGfadrA8rwlZUcTUiB
         oN9AwdiHNr96GP0m3hAs/jqQZz2jQcRgJa6p0cK+5+Y7J3HoBU4quJiNJVEl7q+FK9fz
         Wt4w==
MIME-Version: 1.0
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
 <20210325144921.1791892-2-narmstrong@baylibre.com> <CAJivOr789H28XzQinqAVrZXEfsS4zYYLsE3PPAncCLt4oYS0ZA@mail.gmail.com>
 <CAEUhbmWyXWP5KfvB4izPqq=fEwTyHVXZRoep2vW+m=Mqn6=d2w@mail.gmail.com>
In-Reply-To: <CAEUhbmWyXWP5KfvB4izPqq=fEwTyHVXZRoep2vW+m=Mqn6=d2w@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Fri, 26 Mar 2021 22:23:15 +0800
Message-ID: <CAJivOr6TiyiPj-fGOQsdTrhsWXfhLuo9F6PsVo_2fG1u=E1b7g@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] pci: add common Designware PCIe functions
Content-Type: text/plain; charset="UTF-8"
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, "cc: Lokesh Vutla" <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On Fri, Mar 26, 2021 at 7:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Green,
>
> On Fri, Mar 26, 2021 at 5:21 PM Green Wan <green.wan@sifive.com> wrote:
> >
> > Hi Neil,
> >
> > I rebased my driver and gave it a try today. Add my tested-by.
> > Tested-by: Green Wan <green.wan@sifive.com>
> >
> > Thanks,
> >
> > Hi Bin,
> >
> > Since fu740 support patches include the designware-based driver and
> > also in reviewing, do you prefer me to create the patch based on
> > Neil's pcie_dw_common.c or create a separated PCIE patch after both
> > fu740 and Neil's patches are merged?
>
> There are two options:
>
> 1. Go with the current fu740 series with PCIe, but do a follow-up
> patch to convert the fu740 PCIe driver against Neil's
> 2. Split the PCIe driver out of the fu740 series, and do a follow-up
> patch to add the fu740 PCIe driver based on Neil's
>

Okay, thanks. I'd like to create a fu740 series v4 patch and go with approach 1.
And the follow-up patch will be posted afterward soon as well.

Regards,
Green

> I am fine with either approach.
>
> Regards,
> Bin
