Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDDFC3ABC3
	for <webhook@archiver.kernel.org>; Tue, 13 May 2025 16:15:03 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.80275.1747152896215161313
 for <u-boot-amlogic@groups.io>;
 Tue, 13 May 2025 09:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g5vKYUo3;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: linux.amoon@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fd0d383b32so5311778a12.3
        for <u-boot-amlogic@groups.io>; Tue, 13 May 2025 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747152894; x=1747757694; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwGBom1LGkI5LRN3D+Ri+ZCxA6GAZyDvRIIbYOMA3pc=;
        b=g5vKYUo3gnpHo1qx6jsS0wvg/KI8aW7P8lUId1cWhZjVW5N7+uajUyuoklPXUGc2ZB
         NmUnwxVDdoQSJRiNeCMb7R6NvXRwGjnhY6QdIQdnOFNN8rh0REF/2Eacn2vZJJsOttdg
         BTp24Hf8uYwOQ5tMFIiCAcRhD0NZob9Pe3SXVwmIFCll0TRomEZGFyr0e8xtY/Vwo0jh
         GbMyqqolFzcbOYDppGxpXi7x4KYJ8l8OKSdXIC1AorDEqXrejOLLb2xDJoe421hhVogk
         Jv03y+Wqc1+jLAKzt0W9lnDLe3E/2URVl6dOMy+7xBTnTVphvboPDboq5VmfZfF2wVIR
         tzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747152894; x=1747757694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwGBom1LGkI5LRN3D+Ri+ZCxA6GAZyDvRIIbYOMA3pc=;
        b=VqKtk5fygJpYUL8CAhD+wiyRaTRrCsS6U7fJvYegHv3vJaXCVeunlIj1bkxahE6iQ7
         LjQ5BWY0qNTj/0Gwxv9LtjJ7syZKdXrUBRVNMYhqBPbBXNDm0JQfIr6zp6RjXfUWny1Z
         O5ytL2se1UdSvqaqrKBNEqPsaY8whmaIu305OTOVGsTqk2dKhiwI9OOiWYWn03SkUEw0
         NJL1R1LMOlMmgCvF3TZmGruOCFKJaiF22WudJ4cNoOM85s4rK28NuVTkhKVPr/werlD1
         oYOwGPcSx+39zAjw760/3j4TUmVsuqqDreqSJoAvWbc03CPo7qgB7QK3xdd6a523mcd8
         1A4Q==
X-Gm-Message-State: AOJu0Yy7ZrVpWpQKKMxmWyR/0AyXY+zHrSmfvbJO1ROlkRE0ZQkHnXt4
	fMUW5QNW3zLCt0aZj+oLc2Tfm0AzKReM4P8Dg9BjdtaoMFau7oZrmVIxhmDlAOa+cJPY3R0o3JZ
	LcX93Xqgw2A9/+7zc4vLfVosBCUKqJ2hX
X-Gm-Gg: ASbGnctkSyTDYMovLE3+RIsUzjHTFjSniwp/pdkz24xWE0xVNImzS47aNPwmWxfXgga
	mzxyG6+yMh3cS7ly9di6cwaBAV9fEeuCbTb4C+QsYPb2jDhbeXW9LVO0kmwD1DQsx89Ips2f7WW
	CJpQooDbmJj891gzyQ7FpYTXI8v15osGycwvUMz5Kn7g==
X-Google-Smtp-Source: AGHT+IGfAXjBYeHDCk4gmUNfIJk/2tnqNitSYqB6Tclt8ueLLFijdlQUX+6cGqkwSR3pSuvlgBbvaVy8Jm7OA7GWfhw=
X-Received: by 2002:a17:907:c208:b0:ad2:2f00:175c with SMTP id
 a640c23a62f3a-ad4f74cb660mr14407866b.50.1747152893731; Tue, 13 May 2025
 09:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com> <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org> <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de> <183EB9E9446C2114.11104@groups.io>
In-Reply-To: <183EB9E9446C2114.11104@groups.io>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 13 May 2025 21:44:36 +0530
X-Gm-Features: AX0GCFugUhqUO30uEhdysi0gf_D03yvIvtgCTI0VGXGfrT-lz0PuzHoG-Gzq4tg
Message-ID: <CANAwSgRxLqj+dGH4jDMZFDkAJXe=V7fmKGdEdPU=+cR5NKyg3A@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: u-boot-amlogic@groups.io, linux.amoon@gmail.com
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut <marex@denx.de>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Michal Simek <michal.simek@amd.com>, 
	open list <u-boot@lists.denx.de>, Wayne Schroeder <raz@chewies.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 13 May 2025 16:15:03 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2703

Hi All,

On Mon, 12 May 2025 at 13:51, Anand Moon via groups.io
<linux.amoon=gmail.com@groups.io> wrote:
>
> Hi Quentin,
>
> On Mon, 12 May 2025 at 12:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >
> > Hi Anand,
> >
> > On 5/9/25 7:45 PM, Anand Moon wrote:
> > > Hi Quentin,
> > >
> > > On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >>
> > >> Hi Neil, Anand,
> > >>
> > >> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> > >>> On 09/05/2025 09:02, Anand Moon wrote:
> > >>>> Add conditional compilation for the usb5744_i2c_init() function based
> > >>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> > >>>>
> > >>>>     CC      net/net-common.o
> > >>>>     AR      net/built-in.o
> > >>>>     LDS     u-boot.lds
> > >>>>     LD      u-boot
> > >>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> > >>>> `usb5744_i2c_init':
> > >>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> > >>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> > >>>> reference to `i2c_get_chip'
> > >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> > >>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> > >>>> undefined reference to `dm_i2c_write'
> > >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> > >>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> > >>>> undefined reference to `dm_i2c_write'
> > >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> > >>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> > >>>> undefined reference to `dm_i2c_write'
> > >>>> Segmentation fault (core dumped)
> > >>>> make: *** [Makefile:1824: u-boot] Error 139
> > >>>> make: *** Deleting file 'u-boot'
> > >>>>
> > >>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > >>>> ---
> > >>>>    common/usb_onboard_hub.c | 4 ++++
> > >>>>    1 file changed, 4 insertions(+)
> > >>>>
> > >>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > >>>> index 1242513c631..92e3f3a92c9 100644
> > >>>> --- a/common/usb_onboard_hub.c
> > >>>> +++ b/common/usb_onboard_hub.c
> > >>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> > >>>>        int (*init)(struct udevice *dev);
> > >>>>    };
> > >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> > >>>>    static int usb5744_i2c_init(struct udevice *dev)
> > >>>>    {
> > >>>>        /*
> > >>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> > >>>>        return 0;
> > >>>>    }
> > >>>> +#endif
> > >>>>    int usb_onboard_hub_reset(struct udevice *dev)
> > >>>>    {
> > >>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> > >>>>    };
> > >>>>    static const struct onboard_hub_data usb5744_data = {
> > >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> > >>>>        .init = usb5744_i2c_init,
> > >>>> +#endif
> > >>>>        .power_on_delay_us = 1000,
> > >>>>        .reset_us = 5,
> > >>>>    };
> > >>>
> > >>> I think you should completely disable usb5744_data in this case
> > >>>
> > >>
> > >> I would recommend to go the same route as the Linux kernel which has a
> > >> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> > >> the necessary dependencies.
> > >>
> > > On Linux kernel, it needs to parse the device node with i2c-bus.
> > >
> >
> > Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with
> > dev_read_phandle_with_args with i2c-bus?
> >
> ok.
> > >> We probably should be careful and figure out which boards are actually
> > >> using the usb5744 and add this symbol to their defconfig so they don't
> > >> regress.
> > >>
> > >  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
> > > which use CONFIG_USB_ONBOARD_HUB
> > > I believe using DM_I2C to guard the code is the best approach.
> > > it should be around .init() callback to guard this to work.
> > >
> >
> > I disagree. The driver clearly supports the USB5744 and the driver is
> > compiled regardless of DM_I2C support which is required (as far as I
> > understood, maybe that's incorrect?) for being able to use USB5744? I
> > don't like hidden dependencies.
> >
> Okay, I will add a new configuration option to guard the code as done
> in the Linux kernel.
> > Also, I believe Neil's point is we shouldn't try to probe the USB5744 if
> > there is no DM_I2C support, simply excluding .init() callback will
> > probably just render this "support" of USB5744 non-functional?
> >
> Let me debug this more, I will update the next version.
> I need to check if this binds correctly to the USB hub reset.

I am trying to get the usb_onboard_hub to bind.
but this driver is not getting probed in the first place,
I am missing some configuration to get this working.

Hit any key to stop autoboot:  0
=> usb start
starting USB...
Register 3000140 NbrPorts 3
Starting the controller
USB XHCI 1.10
Bus usb@ff500000: 4 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
=> dm tree
...
mmc           1  [ + ]   meson_gx_mmc          |   |-- mmc@ffe07000
 blk           1  [   ]   mmc_blk               |   |   |-- mmc@ffe07000.blk
 bootdev       2  [   ]   mmc_bootdev           |   |   `-- mmc@ffe07000.bootdev
 simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
 usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
 usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
 usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
 usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
 usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
 usb_mass_s    0  [ + ]   usb_mass_storage      |
`-- usb_mass_storage
 blk           2  [ + ]   usb_storage_blk       |
 |-- usb_mass_storage.lun0
 partition     0  [ + ]   blk_partition         |
 |   `-- usb_mass_storage.lun0:1
 bootdev       3  [   ]   usb_bootdev           |
 `-- usb_mass_storage.lun0.bootdev
 clk           2  [ + ]   fixed_clock           |-- xtal-clk

Thanks
-Anand

