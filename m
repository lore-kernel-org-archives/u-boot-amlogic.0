Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9198DC3ABCC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 08:22:01 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.45309.1747038116619349735
 for <u-boot-amlogic@groups.io>;
 Mon, 12 May 2025 01:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RWWjQTSb;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad24ee085a8so148628866b.0
        for <u-boot-amlogic@groups.io>; Mon, 12 May 2025 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747038115; x=1747642915; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SqCXjGOaOyRmuJ2LM1ogFVqI2c0WVm4Zk9Cf68+F7j0=;
        b=RWWjQTSbr2zYVVDVXqILI5+hEXsNniKgymQkI47zSDpX9zHH+/CHtymyEOXwLfdqGZ
         LsjLlSMxkS0L0PWCH9prlnfG/e1z5OKHXad8ZJv5kxhB6/mOhgkLKYamTAI06eL5VuJ9
         PiYhq/LlSF3X3CMayKiyFkbEJCwfNkJakxxCAzP77UbASHzLGlZuBHNoyVr0JwSqAquY
         ShYzBuLn5J5W3GWFDyIDCLakP6VO76+9xiMmk+QddHp8v0qj7e4E2T2iQ/xIsmYlpmPl
         w2yXdcm5VaI8SiZ9cGjUIuPMzOfYxtYDkuLaYJaeicMKnTbqnMt1D70XGJemrMI0E7Ce
         nNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038115; x=1747642915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqCXjGOaOyRmuJ2LM1ogFVqI2c0WVm4Zk9Cf68+F7j0=;
        b=mjp+H9HGGcOkvVypFVHqu4RVUoU2LOEgHigDoOBzkCyDor3e5fjKJo6h07fsJIMq4i
         xOxaZAxTk9iONI1V30VkiO8mCvopXgAFSjBaWrlb+NFogvijcswS5Pg6o3TISh6vQUvg
         Nx4r9Kpvkc3YNrn4T1rKTneEV8OJzJ3LAqKVAMo+DnSvz+qD0KN99NdIv8x+GyntPpUA
         qqHVbk7nwMF6uCQEEsqn/NurK4KMAQ6ifG5Qkq3wPF1zkauYhVSTFrX2k8vq++33n6by
         QUCMeXc70iG0UxSkdR/hzYIe2zRTr3B1XjLOiY4KNceZIJnH/kINjFfsaEorwN8CN1bU
         b9FA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bojmyA3fKvas0odxIsm69lzXBV+Ewe4ltRE/Xpu7PFHELPqEg2j4oUTt/um5JfEDlfMt1kTyC4t2T7CCDA==@groups.io
X-Gm-Message-State: AOJu0YzeDgSVpI8dY0jva09uzteqGF7VDOw+COEZ67hVx8nC15NBFLk4
	q8KRMQ1m5ukLenodL3OGMeHLq0u/D43X/MENnt1EeSsszxW1DtbZo3QmgTrIUUXuP20VzdJ2hlL
	/91vLQYJzhMEy/vKTfg8zF/Zo4Mc=
X-Gm-Gg: ASbGncvT1gEe2ndyFeT+lJtleBXvtRSb/QpBcDHnSoln/MVO6HAP34NO9Z8WZvWzwLM
	0/N/lIlyRdsgQycqLfCGMjxpg3BmfsKl60h5Ofh/47gkuwbbftqJzp5/dBQjF7jxuQnHU39szqr
	PK+mxYxuObTHnF7lMHH/IKdd3N2F5CKa4=
X-Google-Smtp-Source: AGHT+IEWIKijUTwMIiigL/EJ3c6UQ7gcBPPvilcngKePbm88GEeM2UTF9NXvrXv4MUS/40Ec+LHi8i9Vi3Zf9nvuYaY=
X-Received: by 2002:a17:907:9448:b0:ad2:532e:abe9 with SMTP id
 a640c23a62f3a-ad2532eb047mr300419866b.1.1747038114696; Mon, 12 May 2025
 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com> <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org> <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com> <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
In-Reply-To: <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 May 2025 13:51:40 +0530
X-Gm-Features: AX0GCFtNQncvN1aV-AXS1b-FEVMEFAwQVnI_E3jnIh4qArk3RODuc2xdg3-UUrc
Message-ID: <CANAwSgTH3n3=9vAs5XFBcPLHhfyuwTUFKnBMU2sB=HEuRO24ZQ@mail.gmail.com>
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
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 08:22:01 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2697

Hi Quentin,

On Mon, 12 May 2025 at 12:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/9/25 7:45 PM, Anand Moon wrote:
> > Hi Quentin,
> >
> > On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Neil, Anand,
> >>
> >> On 5/9/25 9:57 AM, Neil Armstrong wrote:
> >>> On 09/05/2025 09:02, Anand Moon wrote:
> >>>> Add conditional compilation for the usb5744_i2c_init() function based
> >>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >>>>
> >>>>     CC      net/net-common.o
> >>>>     AR      net/built-in.o
> >>>>     LDS     u-boot.lds
> >>>>     LD      u-boot
> >>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
> >>>> `usb5744_i2c_init':
> >>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
> >>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
> >>>> reference to `i2c_get_chip'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
> >>>> undefined reference to `dm_i2c_write'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
> >>>> undefined reference to `dm_i2c_write'
> >>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
> >>>> maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0):
> >>>> undefined reference to `dm_i2c_write'
> >>>> Segmentation fault (core dumped)
> >>>> make: *** [Makefile:1824: u-boot] Error 139
> >>>> make: *** Deleting file 'u-boot'
> >>>>
> >>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>>> ---
> >>>>    common/usb_onboard_hub.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> >>>> index 1242513c631..92e3f3a92c9 100644
> >>>> --- a/common/usb_onboard_hub.c
> >>>> +++ b/common/usb_onboard_hub.c
> >>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >>>>        int (*init)(struct udevice *dev);
> >>>>    };
> >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>    static int usb5744_i2c_init(struct udevice *dev)
> >>>>    {
> >>>>        /*
> >>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >>>>        return 0;
> >>>>    }
> >>>> +#endif
> >>>>    int usb_onboard_hub_reset(struct udevice *dev)
> >>>>    {
> >>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >>>>    };
> >>>>    static const struct onboard_hub_data usb5744_data = {
> >>>> +#if CONFIG_IS_ENABLED(DM_I2C)
> >>>>        .init = usb5744_i2c_init,
> >>>> +#endif
> >>>>        .power_on_delay_us = 1000,
> >>>>        .reset_us = 5,
> >>>>    };
> >>>
> >>> I think you should completely disable usb5744_data in this case
> >>>
> >>
> >> I would recommend to go the same route as the Linux kernel which has a
> >> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
> >> the necessary dependencies.
> >>
> > On Linux kernel, it needs to parse the device node with i2c-bus.
> >
>
> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with
> dev_read_phandle_with_args with i2c-bus?
>
ok.
> >> We probably should be careful and figure out which boards are actually
> >> using the usb5744 and add this symbol to their defconfig so they don't
> >> regress.
> >>
> >  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
> > which use CONFIG_USB_ONBOARD_HUB
> > I believe using DM_I2C to guard the code is the best approach.
> > it should be around .init() callback to guard this to work.
> >
>
> I disagree. The driver clearly supports the USB5744 and the driver is
> compiled regardless of DM_I2C support which is required (as far as I
> understood, maybe that's incorrect?) for being able to use USB5744? I
> don't like hidden dependencies.
>
Okay, I will add a new configuration option to guard the code as done
in the Linux kernel.
> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if
> there is no DM_I2C support, simply excluding .init() callback will
> probably just render this "support" of USB5744 non-functional?
>
Let me debug this more, I will update the next version.
I need to check if this binds correctly to the USB hub reset.
> Cheers,
> Quentin
Thanks
-Anand

