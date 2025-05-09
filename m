Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FF1C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:17:43 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.10122.1746782257366508611
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 02:17:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E9fVQTFZ;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so340692766b.0
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746782256; x=1747387056; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bbJrlLUQ6svsRNkgzM2jlafvPx8bClSRlXDsPrwb1Nc=;
        b=E9fVQTFZSvEIbRmQpVYKkIFdug0q4dmVw2khQ/qXs7KFPPTHN+iXc8AGagjjPI/0jL
         UnbF/1DiyxNYckfN20hBBcmoxp3lMsUkJ9+gSrp1+Qa0emXXnR9fyXXsFAy3i/x9r0SO
         vyvC8yss/8KFnZdSg6guZSeD6tWTr3DutK9oF/cfuwhdQaHlwmDIgckAWnlAWawYKRpG
         pFqBR09hFmo0ocZoc3MttMdMMMaNlOqcgNYfeDsuaUK0ZaCjmsZKEXM01ErkjoIlSZA3
         er3dRhlj3wNTLQTGp85T9D/RipZCMUpneu5g2ThS4/so3rZnyj3e11dwhbdKwqk4hwPB
         sl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746782256; x=1747387056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbJrlLUQ6svsRNkgzM2jlafvPx8bClSRlXDsPrwb1Nc=;
        b=DOIeiCiKnCWWtL2BJl1THp6wmRFynTb966nQRlTpNRuNju4vDIAjkIwb/DLYDwKk7Z
         ggskr/861SWfkN7NNWDdv9XqX83ck2yTEEscifvOyTbx9M+usbrxC5IrBfnQL/j/SjxT
         Je5+JQCncAsPSKERcYiZAJdXecAakBMVMnSd0YBacvXMTt0IPPnczVWua25u8RlV4IgE
         5FUCASBaRcCoNh+8fA+1J2L5kf5J7uvFdwJ+5gC0g/Z+KPpaMt8EXrPNhR8ykI3+bLk6
         4MhGDVb7MWQzcRi4msdlYFxrmRwQ1mBVPNGWEuBRXOm4dkWsnGPegGRsgneEJ6SS+eQG
         XriA==
X-Forwarded-Encrypted: i=1; AJvYcCUW8Z/YmjYLsYqr8OfOZvS2AvaCeVJ8ynHte0I4qQeekjPMVyTVr5l3Y1lumMhc6GZ0WU14MAHtBVnOJHUGrQ==@groups.io
X-Gm-Message-State: AOJu0YyXGskJ2d1sdGxKq9xVpA9zYPvikpWL69Nu/0jeQUjQGyDb6CMW
	0Zwa2H5QffM1wZbbQjdPqNPD426OWp7jjh7vKPKLFCHbCv7VzsMzC4PCDs/56naujGbb/MywXxL
	giiiDZ7fh5loyXQqdgKMSPsOXjjQ=
X-Gm-Gg: ASbGncsrud2OR+MtYhcgkaKSB9GF2PGXIbsuWcPXAnFPQsl9INOqVM5tDQAfpCU/LWX
	hYZml4BydcnFi69MdnD8gts0URRsPgqYvMbvB8YfJe0heZ3D9wxKAF0V/rxTnCuQSe8Mjb1Ei1L
	UaAvkcNvZuDLKf6cImA1ZDV3s1AFAuFw==
X-Google-Smtp-Source: AGHT+IHQuh99vrJvhJTLwK2LgGgSrub0rDyzUox5KYbb8cMg9mFjSDWKKRgmG3CSQjsc00YfVbmD94fQvzasWEmlOS4=
X-Received: by 2002:a17:907:3cd4:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ad218fa9075mr245025266b.33.1746782255461; Fri, 09 May 2025
 02:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com> <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
In-Reply-To: <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 14:47:18 +0530
X-Gm-Features: AX0GCFuDywG-8PbQ9fOy7CRtFOe40AueNo0ZsI_QbLQRlPPSaESCJ6UrsuUEgS8
Message-ID: <CANAwSgTOTCwUKcodWixXKQg4u3nvABrSidSb8iREsqVSaaVg3w@mail.gmail.com>
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut <marex@denx.de>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Michal Simek <michal.simek@amd.com>, 
	open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>, 
	Wayne Schroeder <raz@chewies.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 09:17:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2692

Hi Neil,

On Fri, 9 May 2025 at 13:27, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 09/05/2025 09:02, Anand Moon wrote:
> > Add conditional compilation for the usb5744_i2c_init() function based
> > on the CONFIG_DM_I2C configuration, to avoid compilation failure.
> >
> >    CC      net/net-common.o
> >    AR      net/built-in.o
> >    LDS     u-boot.lds
> >    LD      u-boot
> > aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function `usb5744_i2c_init':
> > /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined reference to `i2c_get_chip'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0): undefined reference to `dm_i2c_write'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8): undefined reference to `dm_i2c_write'
> > aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/usb_onboard_hub.c:104:(.text.usb5744_i2c_init+0x1f0): undefined reference to `dm_i2c_write'
> > Segmentation fault (core dumped)
> > make: *** [Makefile:1824: u-boot] Error 139
> > make: *** Deleting file 'u-boot'
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   common/usb_onboard_hub.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> > index 1242513c631..92e3f3a92c9 100644
> > --- a/common/usb_onboard_hub.c
> > +++ b/common/usb_onboard_hub.c
> > @@ -30,6 +30,7 @@ struct onboard_hub_data {
> >       int (*init)(struct udevice *dev);
> >   };
> >
> > +#if CONFIG_IS_ENABLED(DM_I2C)
> >   static int usb5744_i2c_init(struct udevice *dev)
> >   {
> >       /*
> > @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
> >
> >       return 0;
> >   }
> > +#endif
> >
> >   int usb_onboard_hub_reset(struct udevice *dev)
> >   {
> > @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
> >   };
> >
> >   static const struct onboard_hub_data usb5744_data = {
> > +#if CONFIG_IS_ENABLED(DM_I2C)
> >       .init = usb5744_i2c_init,
> > +#endif
> >       .power_on_delay_us = 1000,
> >       .reset_us = 5,
> >   };
>
> I think you should completely disable usb5744_data in this case
>
Let me check this. I will update it in the next version.
> Neil

Thanks
-Anand

