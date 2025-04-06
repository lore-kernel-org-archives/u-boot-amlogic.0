Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E10C369A5
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web11.33840.1743977374299972446
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 15:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=FsxNaqKc;
 spf=pass (domain: chromium.org, ip: 209.85.218.43, mailfrom: sjg@chromium.org)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abf3d64849dso583838166b.3
        for <u-boot-amlogic@groups.io>; Sun, 06 Apr 2025 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743977373; x=1744582173; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0jBW5X0XiYSii1oOb5znw50BBByw8cuiN8gAQ9IO0E=;
        b=FsxNaqKc+wop3oWrtjqv4IQEvjSzHG+VfmRYAD+pooIt+iD/51sIoA//CprGoBm79H
         GETwzg8R0sEohEIYDxdLiM8X4a9P9kPTyfsWq9YWnV/K7eU6/I5S8MxLHU57pUvSlxU8
         MEQNJPoa1wAQVRUSLIKF/c/FDr+CvDvhdV6ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977373; x=1744582173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0jBW5X0XiYSii1oOb5znw50BBByw8cuiN8gAQ9IO0E=;
        b=oWA/B7I2U+l41p+/iX9urcemTPfXMOWun7MTuFs60fzwSxTk1O9DaruYvGcd0eqG+K
         s8rOOJJp+XmIf59+W4T7iHqdPj+HiO+JByzAT3dKr/3G1sBnIYyS2qrTz8OQXrCbDEma
         xEig6lVbY9reoNoG7uoknTZDOS3M/jEGosT8kAETFxMEk0/6xZisxqaHKjiL0x/+/pwG
         VMwPwYxWS8hVVU+75jvGzzhzk3YefiUzPLbVNHAPUF1Ax2cJXwu3sUIO5Rr/htyURkBg
         AWvL1iGn+X5JRVIU0lLIHd8Ppg56l+yH2XgQg5nLKC68KxA1bVejrYOzEDhLoyL8ryXp
         +iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4TFLEYhDgqz5oUZ3Aab36zk0CSq70Y7EEx/2yb4X9AoU+tcCUFHsDw3Cbyxsvsr1q1YFZ1aBWuo1UhctCoQ==@groups.io
X-Gm-Message-State: AOJu0YymGlZ9T+dGlRUztd6o2PW7LxClYENTunLohAzI+ve4BA44Dnz0
	S3WbWQdQUsJ9wD9TvLQIeAxxBtFRcQuG92vRpRpuSlkqrShxRDylr49HOGGSb/QIy0WSNIzOwA1
	U5wDg0bwdq7EVvsRqhw6iOcagPSRo0wT8lTFv
X-Gm-Gg: ASbGncsYTitXWWi76GJ28JaDSqr6C7UOV1BQ5+xOqva2qXzmGs11D1QaGYrp6ZGX9sR
	FHjjWpwH6vnkCB2eU7F8WD18mUp4a/Z20yzR2VvrmnuUS/UnCMZY9h0qcha3OpIv8BP3CtLg5xZ
	3csKB7xp/sb/S5SBhVK9bVdyBG5by6J8yA5Lpl
X-Google-Smtp-Source: AGHT+IHqzqaphfhaNCTAvlxk9NnjEJkEml4Wrym+NvvL8mOccqJhL8sIU2+GtsQq84RsrlHJtrd2lcCidsS7PXvK2ks=
X-Received: by 2002:a17:907:6e86:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-ac7d16bc07emr1106444666b.10.1743977372498; Sun, 06 Apr 2025
 15:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250405221308.498047-1-sjg@chromium.org> <20250405221308.498047-2-sjg@chromium.org>
 <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se> <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
 <a1026fc5-de0c-4a88-891e-1bdb5b98b705@kwiboo.se>
In-Reply-To: <a1026fc5-de0c-4a88-891e-1bdb5b98b705@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Apr 2025 10:09:20 +1200
X-Gm-Features: ATxdqUFBxKXrUpbOpsIqj3jTp1hZixUTNCjk_8dbKxt3Vvp-0diEGdA46_adzYA
Message-ID: <CAFLszTi_7vv-CBxat=naT6iWmPUPFvCNZhVxj+JvHr_GUqwn_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] designware: Use the remove() method with related drivers
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	neil.armstrong@linaro.org, 
	=?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
	Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
	Kongyang Liu <seashell11234455@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Parvathi Bhogaraju <pbhogaraju@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>, 
	u-boot-amlogic@groups.io
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2656

Hi Jonas,

On Mon, 7 Apr 2025 at 09:36, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-04-06 23:10, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Sun, 6 Apr 2025 at 21:02, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 2025-04-06 00:12, Simon Glass wrote:
> >>> Several drivers make use of the designware Ethernet driver but do not
> >>> implement the remove() method. Add this so that DMA is stopped when the
> >>> OS is booted to avoid memory corruption, etc.
> >>
> >> The designware Ethernet driver core should not need the remove() ops as
> >> the eth_ops.stop() ops already should stop DMA. And the eth-uclass
> >> pre_remove() ops already call the eth_ops.stop() ops.
> >>
> >> All these drivers seem to use designware_eth_ops and thus have correct
> >> stop() ops configured and should really not need the remove() ops.
> >>
> >
> > That's interesting. I wrote that code about 9 years ago so perhaps can
> > be forgiven for forgetting.
> >
> > Very few drivers set the DM_FLAG_ACTIVE_DMA flag, certainly not the
> > designware ones. So how would they be removed?
>
> Ahh, I see, remove() is only called for devices with ACTIVE_DMA or
> OS_PREPARE. So I guess that was probably the issue all along?

I suppose so, yes.

>
> There is some confusion that dm_remove_devices_active() does not remove
> device_active()=true devices and instead only remove ACTIVE_DMA and/or
> OS_PREPARE flagged devices.
>
> >
> >> Side note, this also misses the gmac rockchip driver that uses its own
> >> eth_ops instead of designware_eth_ops, however it also use same stop()
> >> ops as all these drivers.
> >
> > Hmm yes I saw that but then apparently forgot to include it.
> >
> > I can perhaps redo this patch to add the DMA flag.
>
> Maybe eth_post_probe() or similar should add the OS_PREPARE or
> ACTIVE_DMA flag for all eth-uclass, to ensure remove() and thus stop()
> gets called when dm_remove_devices_active() is called.

But not all network drivers use DMA. It should really be set by the driver.

>
> There is probably no need to add all these remove() ops, as they would
> still not have been called by dm_remove_devices_active().

Well, since we can rely on the eth uclass, that is correct, but I
still think it is better to add it, as an example to other drivers.

Regards,
Simon

