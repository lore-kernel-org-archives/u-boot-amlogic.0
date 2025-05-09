Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD92C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 08:01:42 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.9255.1746777701971934398
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 01:01:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QESVHv9a;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad220f139adso64531066b.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746777700; x=1747382500; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvKKjj7REexYcAru0oi/34BOYSDHPpu48wPY8e1wtwQ=;
        b=QESVHv9aX2aj/SfumHPGoeYceY7WsufQ34JvhtUEUBA9/7d8V9o2811XyL+fQc7k//
         r9CqTs3oCthDWqIkWGhPcTFj8vxzEepnNt0ajoIztmUBHaXGObP4ya1yXM2BnSlDwwsT
         ZOdNxMxwfvccUGBMAYtC9Ri4exzsSXt6U7dxOEQG7geDYPUtcWwA8m3cx9wRhzBMw7Zy
         cB6Bf41DQ7yXwSp8ssFFRcDnh0PiEaZ9Ma4c837aWi3v/8glRjbk0zh7/3w25AIozVnq
         KWynxPSI1nmkbDTGTpuJrKTWSxNQ3BE6aFPChRm01n7RPJWhA8D9axCDy6VZGqmnuDIE
         LhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777700; x=1747382500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvKKjj7REexYcAru0oi/34BOYSDHPpu48wPY8e1wtwQ=;
        b=WH4TxewoEhuLvf0dgjxqJYNfntoxYStM8HnHBEi63jZdYmw5TXUa6dQn2tlTEgBo15
         tMPPOVubDG+AdU/zCmpi3fi+WGzrXVNV/kiNsqdC4p0A/zZyRKIj0KVIEMgjXYCzLQsg
         5XbWXRNV+QS43+mIaqwvVzWZLGWg2DEsL82/5SvdnikCZuPoAU5FJzSt/bSbKCCWX6+p
         YoDzvD944vF7g23+SVpmDoC9YXKMYu54gnP/ppXSwRkKYjoTJ22sjeRKrEyScRMj9tAY
         Q0zED7xOOxZ5JkPA7BLXoRCSo6eDmwWbyRvqYBU3xtU1TqkflNSt0lQLD0T1p1RJV1vp
         6EgA==
X-Forwarded-Encrypted: i=1; AJvYcCUhHD9bCIWstvU88sC++8iLRTfilGolM4DcGQQgetNTEgYDKgLz0w1Sie0AYEFRYhe0MjYskHQ11+FwCP7gOQ==@groups.io
X-Gm-Message-State: AOJu0Yzt24JS4/A8B/bDxrgvq1bdDp6dUQFSmrbC/3XTKCwnNZKsGFit
	uJNf6y5pQbcAgwPAKJXnVpS8TgmMN83h5AeTstNCmEiMUkUPSLOdfyD5R3G+4DWglElb4aJhtgn
	FGvy6cWdqVFDgz8tEULfI6DvRVGI=
X-Gm-Gg: ASbGnctBg6BBAK77xu20oKWnb2NX84WJA2C0yXJxukUFEVNpDe9j6mPDmj2kqPyupeg
	mX5ETMJKhUsIKago2p63uNn6lPnkoTP+LnRg4t0RWA4LrXq3Q6R1fJtxTtwKoXwFbttvsEMqwfD
	V4P8K8crGdkcZeDYfRGIk=
X-Google-Smtp-Source: AGHT+IG2ooyDLhyn7mlehr56CLKn+5eleiSBtoKgIMzx+BU+mf7Zf7x4TGC+U3neRcdRtjmwH/JsU/8eAslN2teJK0M=
X-Received: by 2002:a17:907:a4ca:b0:ad2:e08:ea00 with SMTP id
 a640c23a62f3a-ad218ea4581mr228337566b.9.1746777700217; Fri, 09 May 2025
 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com> <20250509070258.5077-3-linux.amoon@gmail.com>
 <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
In-Reply-To: <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 13:31:24 +0530
X-Gm-Features: ATxdqUFEfQNmoSMowzLbybd0Y0sOjHo3nlzlCzInA1TAnVlCPDoz18pOrAFitcs
Message-ID: <CANAwSgTCkO_5iezh8KQ=gYPTALfXbXNSuC4nY9=o-76n4CepNQ@mail.gmail.com>
Subject: Re: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut <marex@denx.de>, 
	Michal Simek <michal.simek@amd.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>, 
	Wayne Schroeder <raz@chewies.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 08:01:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2691

Hi Neil,

On Fri, 9 May 2025 at 13:26, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> s/odorid-c2/odroid-c2/ in the subject
>
Oops, I will fix this in the next version.
> On 09/05/2025 09:02, Anand Moon wrote:
> > Enable the onboard USB HUB driver to power the
> > USB_HUB_GL852G-OHG on the Odroid C2.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   configs/odroid-c2_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> > index bcaab46f8bc..f8a66a923c9 100644
> > --- a/configs/odroid-c2_defconfig
> > +++ b/configs/odroid-c2_defconfig
> > @@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
> >   CONFIG_USB=y
> >   CONFIG_USB_DWC2=y
> >   CONFIG_USB_KEYBOARD=y
> > +CONFIG_USB_ONBOARD_HUB=y
> >   CONFIG_VIDEO=y
> >   # CONFIG_VIDEO_BPP8 is not set
> >   # CONFIG_VIDEO_BPP16 is not set
>
> With that fixed:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks
-Anand

