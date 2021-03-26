Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.11400.1616759317333437812
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Mar 2021 04:48:37 -0700
Received: by mail-yb1-f174.google.com with SMTP id o66so5539361ybg.10
        for <u-boot-amlogic@groups.io>; Fri, 26 Mar 2021 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IiMprGdA1t4EJFVHw2eeKGI9z15rM0KMwy1bcMcN4g=;
        b=kVAoA9vIx0UPLbRlxF0mC9kUI+CitCUxZ2BwvwsW7aA6vF1NbYSWfSjJeDd6zqDP0+
         7KI98GOUGTqWPF70h60ZCT8uTTPIaneb2ZsR6RT1+DRgT5zhZ7WX6IySYxBlj1lqwDN7
         mor9RsPjXJLhpy9IS/1j45iB7ULaZjTw1TH7pg9voTd1j5nGPy9MUEiM9liCxQjO7kcd
         l4zlBYu/OuFkLp6bLTYm88Gn3EFr2/kA0zIxDDaqJ91Gt5p/O/t/kNcDmJdwCfmyrOeC
         1pWUDfFwtFJQx6kMqrp63+zE1OBq8gU2tAvYyM8QUOuTG/NNBjiPd1IPgr5P8dKU/8jp
         bCrg==
MIME-Version: 1.0
References: <20210325144921.1791892-1-narmstrong@baylibre.com>
 <20210325144921.1791892-2-narmstrong@baylibre.com> <CAJivOr789H28XzQinqAVrZXEfsS4zYYLsE3PPAncCLt4oYS0ZA@mail.gmail.com>
In-Reply-To: <CAJivOr789H28XzQinqAVrZXEfsS4zYYLsE3PPAncCLt4oYS0ZA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 26 Mar 2021 19:48:27 +0800
Message-ID: <CAEUhbmWyXWP5KfvB4izPqq=fEwTyHVXZRoep2vW+m=Mqn6=d2w@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/4] pci: add common Designware PCIe functions
Content-Type: text/plain; charset="UTF-8"
To: Green Wan <green.wan@sifive.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, "cc: Lokesh Vutla" <lokeshvutla@ti.com>, Sekhar Nori <nsekhar@ti.com>, shawn.lin@rock-chips.com, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi Green,

On Fri, Mar 26, 2021 at 5:21 PM Green Wan <green.wan@sifive.com> wrote:
>
> Hi Neil,
>
> I rebased my driver and gave it a try today. Add my tested-by.
> Tested-by: Green Wan <green.wan@sifive.com>
>
> Thanks,
>
> Hi Bin,
>
> Since fu740 support patches include the designware-based driver and
> also in reviewing, do you prefer me to create the patch based on
> Neil's pcie_dw_common.c or create a separated PCIE patch after both
> fu740 and Neil's patches are merged?

There are two options:

1. Go with the current fu740 series with PCIe, but do a follow-up
patch to convert the fu740 PCIe driver against Neil's
2. Split the PCIe driver out of the fu740 series, and do a follow-up
patch to add the fu740 PCIe driver based on Neil's

I am fine with either approach.

Regards,
Bin
