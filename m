Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA56C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 17:45:54 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.4700.1746812751293355108
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 10:45:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CtKQDsRr;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: linux.amoon@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso3456552a12.3
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746812749; x=1747417549; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NBSCSTW6meVKl4Fzv1V6winQvwSQBMwpZ3Zvm4h6c8=;
        b=CtKQDsRr29gSmgQOhAsl1/TAYEtwQPzOaS4yccAkdwwsgbFGFBZWxWqof/xRHJGeZ6
         6Ypjcvsw6R2OTnEPOZfGCCcJQ1hireXaGZsrDfqNm10rV934f0kHV8NP+1wvf/LsS48H
         68kY7HEQWzMwf9gRg3hvggsbqpmjZ6NdpR6+LcQLvjJNW/2cJ0Q5zW/6vPgjh3m5Qznu
         c+DYbN2JPkKkHTp2AM8CwBRWeKfXZ7RlPqfWlLiWicSazuYViyyFttEhcOVYLOCfR1iA
         l9LYTuEi2wgyF/0lalkKaycrYc0vtjVtVHBeEG+/F7sxAI2ifkVflyS0gpcYUWs3l1ZD
         duPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746812749; x=1747417549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NBSCSTW6meVKl4Fzv1V6winQvwSQBMwpZ3Zvm4h6c8=;
        b=SoE/rIl90pN56y8wifH5bU+27Zr7CnvCjtrjA3ksOOhsrLo+F2vUzNwuIpnLx8TMEg
         5cxHQWtdwQ/f1RjCPiIIDzSGB3quicx3xJOtFAj7LuwC7/Hfgze6Z1SC2PcRJENACdw8
         OFUMzBG0+hLVOSdY+JBIJBtuSU4FgWTg1Uf4phcHxk2nv/+ewHwCL+tOQwmOSRzRFb5L
         O0nz/hAOT88l5zNS7I/BKG1OiXvpT5PA90mWMyTBFc665R6uW/xkvohaZQZzdmpb2XCI
         iafY1zwYu34cLJhKM+rrIjBYU9Ekx0tkyG4kL9nWFO+P21Lk7zyAA/yEtiwRc2Aj2f70
         P1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX+VXFsb2FlJDt0Dx3FKlZd1p8qGNjqEd3lgFkC0tRDzOnKtVVbOBLbDruE6GE4shLKohvMZKNv8DTXFtMK5Q==@groups.io
X-Gm-Message-State: AOJu0YxqbbnHMxuaaQc539F43D5TvJqtA12ohIPtLgFNEYA7NBMU7u1N
	S1Kml3EDeUp0J7dHKwUZU/MkYvVxcd7M9+Z6CIO5A6GHB6BFOu/InXqBIFVVnxRD7xL9aacROyQ
	p1kbv7uy22C4x5hel06Zg78CRzFo=
X-Gm-Gg: ASbGncugdZUTWXI1e6qVsue8/rkSbvEdZ5izOLay8Kbwfo4vQUjbNVmp1RK4YmTIBjm
	cmDw/N8oscbuIrD2W5NeAOgdpUzIPRIzsW49WlH+NXjqW7EFbbDH/vwvnqxCJWN1QIS74qSGjSU
	kgic4WAQqLWnCiafjbK+c=
X-Google-Smtp-Source: AGHT+IFGwwTEiKPaNVX+Np1FMkX8vPYW7aoCUvKtpsrPNPfpLVFLsqXlJ4BmPRgjtJda44UcbSoef14Yaz1NbadyBrU=
X-Received: by 2002:a17:907:9801:b0:ace:dd27:7c68 with SMTP id
 a640c23a62f3a-ad2191697dcmr450227866b.46.1746812749346; Fri, 09 May 2025
 10:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com> <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org> <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
In-Reply-To: <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 23:15:30 +0530
X-Gm-Features: ATxdqUE9EOhFZAxlgmN7b1xq7kE6wu2BT2Dpcv2WjRIyONtSeVH1IBte9NdKUCQ
Message-ID: <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
	Beniamino Galvani <b.galvani@gmail.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
	Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>, 
	"open list:P200" <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 17:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2695

Hi Quentin,

On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Neil, Anand,
>
> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> > On 09/05/2025 09:02, Anand Moon wrote:
> >> Add conditional compilation for the usb5744_i2c_init() function based
> >> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >>
> >>    CC      net/net-common.o
> >>    AR      net/built-in.o
> >>    LDS     u-boot.lds
> >>    LD      u-boot
> >> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> >> `usb5744_i2c_init':
> >> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> >> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> >> reference to `i2c_get_chip'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> >> undefined reference to `dm_i2c_write'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> >> undefined reference to `dm_i2c_write'
> >> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> >> undefined reference to `dm_i2c_write'
> >> Segmentation fault (core dumped)
> >> make: *** [Makefile:1824: u-boot] Error 139
> >> make: *** Deleting file 'u-boot'
> >>
> >> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> ---
> >>   common/usb_onboard_hub.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >> index 1242513c631..92e3f3a92c9 100644
> >> --- a/common/usb_onboard_hub.c
> >> +++ b/common/usb_onboard_hub.c
> >> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >>       int (*init)(struct udevice *dev);
> >>   };
> >> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>   static int usb5744_i2c_init(struct udevice *dev)
> >>   {
> >>       /*
> >> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >>       return 0;
> >>   }
> >> +#endif
> >>   int usb_onboard_hub_reset(struct udevice *dev)
> >>   {
> >> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >>   };
> >>   static const struct onboard_hub_data usb5744_data = {
> >> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>       .init = usb5744_i2c_init,
> >> +#endif
> >>       .power_on_delay_us = 1000,
> >>       .reset_us = 5,
> >>   };
> >
> > I think you should completely disable usb5744_data in this case
> >
>
> I would recommend to go the same route as the Linux kernel which has a
> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> the necessary dependencies.
>
On Linux kernel, it needs to parse the device node with i2c-bus.

> We probably should be careful and figure out which boards are actually
> using the usb5744 and add this symbol to their defconfig so they don't
> regress.
>
From my initial analysis configs/xilinx_zynqmp_kria_defconfig
which use CONFIG_USB_ONBOARD_HUB
I believe using DM_I2C to guard the code is the best approach.
it should be around .init() callback to guard this to work.

> Cheers,
> Quentin
Thanks
-Anand

