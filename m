Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C960C3ABC3
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 14:08:05 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.891.1746802892032233392
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 08:01:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=tusn20jS;
 spf=pass (domain: chewies.net, ip: 209.85.208.43, mailfrom: raz@chewies.net)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso3490997a12.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746802890; x=1747407690; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBgL3ZL550pwHUyGu0636IzKUM8jYg6oWWIjwlwmye0=;
        b=tusn20jSxhqZMHK2lgNY3Jh14aURZfULo9m7/W5Wan+fhZ5qmuCHZ1dJ4xhJf/KqSl
         SwpP1ndVVS7c3xHc5iqMpmTGCOwcAaZoSsU/mTtwFn/4IY+AlwgVzWrhXZemf52kXGR1
         HjMMxvDN5LANC83uzFf2bNeTX4NcayRtWQVCiEMsL7idVaK4jh/fjXe5CqVWf7qVOIyd
         3C02IQJSKV6gH9Z6vO2PbR72E+1HCgUkH9fw4f3zEHZUTGxLL1QQKaJceTCsr9CCv7t7
         hNMTJTW3lsDMB+MaeAXsjvKZQWYK7dp7ztyva68sYuXJZojtvwNsZ6Viug5MbJy4OlsR
         oR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746802890; x=1747407690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBgL3ZL550pwHUyGu0636IzKUM8jYg6oWWIjwlwmye0=;
        b=CukxTvcyzI3RD/r1g+dzXZr3UrsfocXZ1IwzOhUONs9iTN+fPJUSHiUXMgGXBMiMed
         r517zy4UQwHhSh7ZxeR/kr/6I3caOfPHS2Y+d5PlbRZOiwnq2Ml/i06U17mXw7vpA1kB
         9ku69cXAnvnnH8Pw8uiHMrn6CwSNyQ4KA360mfDTp8OD5L8cfwtx/7MCMbffUX1Z1HJr
         sLqUiYy6MuIIqXPkWeWDpcU//NMJWGl4bq3jgUHUpkLEAFkHyun/IifpKLUaU6rp+cjN
         yvBOFrEZmsi6TNGwSOxuI9aVFKtWsa9/Qrk6+S7IVXUrqDH3tvTF1PfRi/6Jipz3vG6R
         SP2g==
X-Forwarded-Encrypted: i=1; AJvYcCWj3cHHSnOXuQlqE8S6dAz/whaS5suEGQI7w4HHG9AaLKNQiQ1/Wr0IY0b2URb6vWP/LFZeAQHSMSmOx0ZcVw==@groups.io
X-Gm-Message-State: AOJu0YwLayWq0Pyvyq8/DtU0JY3mcG/MUQ//wk6CClG9NW2kgGhJmtyW
	n5Q30c06CDvaGrnsudL58/h0E6wNulrAixVJkXdWxTGFcx4frCBeB/+1YY8nqKTsBXyo/9M+6Ak
	2XU+r+oZ5jQanqNm48H+BQAMmjL29qVXcNj+g
X-Gm-Gg: ASbGncvCwM0gZx4RlJegCyIofJph8VAoTHTZ0pRA8UiqGT0bfnmy+xHgBHqPcSTZSlC
	gVhATdUEOHeDpOmZKTejGhj2t5NZAUVDycHlKNKOJzj1H59XYj0O6qbMC1XYy3kcKARgoenY2CW
	IeGGVwBE/gb0iq4ffkYqcK
X-Google-Smtp-Source: AGHT+IFf+nVAgdwIKvhp6FKx94q2YT6+sEg9xhUFkBICZbH6CrypO4w3U2C9D+gFHigfCbHoi7dvxkUDtWZbD7xfAIc=
X-Received: by 2002:a17:907:a2cd:b0:ace:caff:675a with SMTP id
 a640c23a62f3a-ad218e47c9bmr306712966b.10.1746802889091; Fri, 09 May 2025
 08:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org> <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
In-Reply-To: <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com>
From: Wayne Schroeder <raz@chewies.net>
Date: Fri, 9 May 2025 10:01:17 -0500
X-Gm-Features: ATxdqUE_PmhZ54jFeg6jIYai2y3B-gBv2fkdfTsqYASmYzXd9Nfo6C7yAcR2Cw4
Message-ID: <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Anand Moon <linux.amoon@gmail.com>
Cc: Ferass El Hafidi <funderscore@postmarketos.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 May 2025 14:08:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2700

Yes.  Will report back how it works on the n2+.


On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> w=
rote:
>
> Hi Wayne,
>
> On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> >
> > I actually already have a working solution that I documented in my
> > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > check/delete a flag file on my boot partition and if it is found, then
> > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > script only on reboot to touch that file.
> >
> > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > reboot... && usb reset && sleep 10; run distro_bootcmd"
> >
> > It is a hack, but... the system reliably reboots remotely now, and
> > that's the important part for now.
> >
> > Wayne
> >
> > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > <funderscore@postmarketos.org> wrote:
> > >
> > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > It's hard for me to quantify if usb works in u-boot as I'm not load=
ing
> > > > off of any usb storage devices.  It certainly never lets me use the
> > > > keyboard to abort auto boot, and never has.  On reboot, to reliably
> > >
> > > You can send bytes via UART to abort boot, if you happen to have a UA=
RT
> > > adapter around.
> >
> Can you test this series to see if this resolves the issue?
>
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
>
> Thanks
> -Anand
>
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic

