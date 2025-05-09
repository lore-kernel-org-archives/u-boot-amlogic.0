Return-Path: <linux.amoon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8AC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:09:02 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.8714.1746774537177789703
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:08:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HNoqxreV;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: linux.amoon@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3289601a12.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774535; x=1747379335; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDOVTvBY2hQzl4x0xlAS9VP7sT+X5C+A8PuttaCFmyA=;
        b=HNoqxreVamxUyvj9sXKEnwwxfqDAOUFKdVkGfFlA4iMnesnf8JQVolfH/4tHWaaNT8
         zHQ5a5i5L/reBP9buzBH5vsBlbE377XC1KI64drseo+R1Ujrto5lPSkgLa1oSGHwhm8K
         cigEk7Ltkukf3M+BadvmK8dgJTh9hPgi79SZnxtn3NY+oZLjxFOdxRb6tMJu4rK7RpFU
         3DrhIdOqH44NBTpla/uKRmCyJmfhwgwvJSA+0wTTbetl06wAuHDlfqG45oYcxq+Z15TP
         n/znz1WM+WHAHTkgvDDIwolyhaQouUiFX7Vezd2FrdA7y9FPiU5NGraqnhbQJCRUW2hh
         CS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774535; x=1747379335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDOVTvBY2hQzl4x0xlAS9VP7sT+X5C+A8PuttaCFmyA=;
        b=ISHWT1h8zSwk1y9JDhAUAnN27B3yh22q7KLMCtSmpFQxsv9WyO+OFJBgZuo/Kfq8yB
         Gvu1+xZRgL5Gs6ExjliF298kNIxOvz+zR4Zl8zVzCLGYV5t6fZJIhCaYZi06xJDeQugh
         P0apPba6Gd9Vim2VcUzmF+BJkGZCkdaYkcSpJ7LDvhv0bg6R/t206ECtCEjDNW810JAw
         k/Opu09cV9P4MZrvjOLSNQZx7pA1DzqiDvl4D8oI7mrF5jEUEi0KuazTCbSdMwI4RTKd
         Fv1WF+b9EV9yZY9AlYsy1L3qBMtPhOzIRv5jKjbaeUaKP5KTvCal/pfO0NgK47XMn8gF
         G84w==
X-Forwarded-Encrypted: i=1; AJvYcCUuN8DWzKBxz9DO0BaTaGlPIyaEsKiLMUoTCMfCxDyP2b6tGeHCNorkPpcG/b22EjVdD0Y0ebw3fNAcDDU6uw==@groups.io
X-Gm-Message-State: AOJu0Yy3ZPzjtbZw2EpJzZ38pbjl3pzvmSOEff7k9u9x4Vks+Ih7NvuJ
	7/s6JBifSJ5YyXgd1qsyn+T7d8fzJQquuP/ayhA9Is4hGW0YSJIhPJe32XQEVFzOLQtkTRRkPED
	oh34ZkH3gS9voaCKwlrddyw92Ano=
X-Gm-Gg: ASbGncurHm4Wd1wgbqdFHtiFsAMGItBlvOKytiYsHvpDT63aVHOlF/JmXR4aijDR8ux
	RQF0gKUCnIV9J5r6U3QTXinmZusA4drYkprSrMoETs/dS+U1b7ZNB95/XtdQXk/9gqQQfWOvFzQ
	Eqf9Jp3xw7hPh7d/odzbA=
X-Google-Smtp-Source: AGHT+IFy6xSeENnr6GpZhNdMlhkEbAuN+UZ4rG9yxOM+Fw1GvytEt7cTK20FJVRt02pTE3RFKoZFSKkTIULzJWvTRRc=
X-Received: by 2002:a17:907:688a:b0:ad2:2417:12d9 with SMTP id
 a640c23a62f3a-ad2241716a5mr51158766b.39.1746774535293; Fri, 09 May 2025
 00:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org> <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
In-Reply-To: <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 12:38:38 +0530
X-Gm-Features: AX0GCFvlAIyHMSqomrT8B9EkBmrGtOImqqnXVMTyKPDTZq4Vn-h2XNtU_Hhsenk
Message-ID: <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Wayne Schroeder <raz@chewies.net>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:09:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2683

Hi Wayne,

On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
>
> I actually already have a working solution that I documented in my
> github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> check/delete a flag file on my boot partition and if it is found, then
> reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> script only on reboot to touch that file.
>
> CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> reboot... && usb reset && sleep 10; run distro_bootcmd"
>
> It is a hack, but... the system reliably reboots remotely now, and
> that's the important part for now.
>
> Wayne
>
> On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> <funderscore@postmarketos.org> wrote:
> >
> > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > It's hard for me to quantify if usb works in u-boot as I'm not loadin=
g
> > > off of any usb storage devices.  It certainly never lets me use the
> > > keyboard to abort auto boot, and never has.  On reboot, to reliably
> >
> > You can send bytes via UART to abort boot, if you happen to have a UART
> > adapter around.
>
Can you test this series to see if this resolves the issue?

https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088

Thanks
-Anand

> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

