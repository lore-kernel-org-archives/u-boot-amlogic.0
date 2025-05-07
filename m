Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AECBC3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 15:54:04 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.8625.1746623048049018559
 for <u-boot-amlogic@groups.io>;
 Wed, 07 May 2025 06:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=vlYX8bdl;
 spf=pass (domain: chewies.net, ip: 209.85.208.53, mailfrom: raz@chewies.net)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbcc5aa54aso2574159a12.0
        for <u-boot-amlogic@groups.io>; Wed, 07 May 2025 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746623045; x=1747227845; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4+LmSgXiLryF/j8oR/d0abK66q0D8JYbtiWsJTdvXQ=;
        b=vlYX8bdlT75/egKFQq+xL3DMVWW6cxaWSDiMOol8M21T+TyP7vx0n/4/ugRL678Hok
         8KLIiaqqCnpy791lq5CA6W57i+eFuuNHZQkCbYGszUA9z1s9Ud7UJTsJexRaKK3M4nCc
         +e9sPgRFv0c5bFU6uk9TTXf2qorGdN6oZJsQZsnuFKuMeFowsghDCgNh/PFfqrumXaLs
         0gff2M8Wh5mdMc1bRnI7zkOs+vvLlypQ9yNNT+k5+GwNvu9MStbstENFcZKygXlsAn8c
         IL2pBEU/AwhG1CcLqimByTgszWYB+hJYP036mTHdg6awYYagI7QGGUYZRXwOYEGkUtOH
         u7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623045; x=1747227845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4+LmSgXiLryF/j8oR/d0abK66q0D8JYbtiWsJTdvXQ=;
        b=kjB7jPTQsM9VBamxe7bWUXxejayLDk8x9bDkhFWkxyv0jvti0DbmWFq3J5wNUWoXfq
         4uQyojHQGrNVHNVLaeniofiG0GJe1iqGdiHfUQqKvdk6ONu0+ACU3R9nodsFl6u3oAIz
         Hk9WB5XOVIEB/rATUxtRHuhwHF7jNLNWcM1w1K+q8pNvbZUBwIOfBWdsokbRhHAB7jEW
         iqAckYbe1IW36dTWZ7b5Y62blqb/DE83l1XFQBe2rbQ0SSVmebbDDJVE31mzRPRV2+Yl
         pNELXcfqlDSQ/X3O3GRzE5PcsZrXVRqdYUPSSG02SJFksjj6+Hla+ysBSgXA8orSHrWu
         N7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWOznFfKNpzp97SaIDc1bg9xVjE6UxkBUoJBMxh59okDuqwNd6XzuNYG2ieXFnnltOISOH4AuOL9OKpjFyy4Q==@groups.io
X-Gm-Message-State: AOJu0Yy4U5ArC6YkpWaQ7wF4d3MWyY/V0PRCrAmDn8aLkwj7VrQd3y7x
	lMRmhcDHOsV/P6H5BvHhsUEL8yzqmEI2400fvX4v8s3gdNxLxKpRezpJ99I9Ud1BVYFpxIxPtWn
	FuFmVgXp8ELqJyCq1Ac6frM0piCSFnnNdgwBu
X-Gm-Gg: ASbGncuQ9MIoGIOmBc901pAXHkzjkjxuT5F+2mpFFnXHq9WTGzSVhf1+RVjdMuUQBVx
	fdXMuVkwSvIkhwDE0SMoxtc9Eavp5uiAEYpamFTRx3rxxe4wXVrEJfcW/5PgRjm7XEzc6ncIb+c
	AHo275AxBjZlWxVazqZhc=
X-Google-Smtp-Source: AGHT+IFzajSvRmyDEs5hHY4lL+t8+2vMhkjYGb7OU5fT3ekq5YUVOD2BAWbTh9IUJt7dgx74MkVuHg/PnkykKXwE4ik=
X-Received: by 2002:a17:907:9709:b0:aca:c4a6:cd90 with SMTP id
 a640c23a62f3a-ad1e8bc315cmr333347866b.5.1746623045257; Wed, 07 May 2025
 06:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
In-Reply-To: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Wed, 7 May 2025 08:03:52 -0500
X-Gm-Features: ATxdqUGrMJl_qwtuZFp4N1ILboK2S9KpJF6PNjsTlAh7u7oPIil0F6b7Kp5_KIE
Message-ID: <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 May 2025 15:54:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2671

It's hard for me to quantify if usb works in u-boot as I'm not loading
off of any usb storage devices.  It certainly never lets me use the
keyboard to abort auto boot, and never has.  On reboot, to reliably
get it to work, I have to do a usb reset and sleep some amount of time
before doing distro boot.  I picked 10 seconds.  If you would like for
me to do some scripted boot command additions before my extlinux to
gather data, I can.

Right now, what I have done is make a reboot hook in linux to touch a
file on the boot partition that my bootcommand fatrms and if it was
present, it resets usb and sleeps 10 seconds, so it's reliable to
reboot remotely like that.  Let me know how else I can gather any
data.

On Wed, May 7, 2025 at 7:01=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 05/05/2025 15:12, Wayne Schroeder wrote:
> > If I add the usb reset command, it works reliably at reboot, but it
> > does not work on a fresh power-up with that change.
>
> OK this means there's a dangling resource, Does USB always work within
> U-Boot or it breaks U-Boot and Linux in those cases ?
>
> >
> >
> > On Mon, May 5, 2025 at 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrot=
e:
> >
> >> I think it's a very long term issue, USB lacks a proper reset at probe=
 on
> >> warm reset, does USB still work from U-Boot after the reboot ?
> >>
>

