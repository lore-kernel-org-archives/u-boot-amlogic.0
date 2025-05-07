Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16DC3ABC5
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 15:54:04 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.8565.1746622893655886757
 for <u-boot-amlogic@groups.io>;
 Wed, 07 May 2025 06:01:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YM0iG/d7;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: linux.amoon@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ace333d5f7bso1274601666b.3
        for <u-boot-amlogic@groups.io>; Wed, 07 May 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746622891; x=1747227691; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiNXlxur2Dh7oN7P4Es0NHzTBV+X3Ml6Cdu3bCSQCe8=;
        b=YM0iG/d77WfPd3aQhCsA//PhLbN3pRunYa0689BWuQB8vJpQzXH59P+iL906AOh75s
         c6NKTuRPrU3jV64nXEUENHxX8c4gMrDyuoNQi5j6TpzlWnTkWpGnhWfODRPBy5G42PJ6
         QZEzBUAJtnGt2fuwmRBYW507nJUJd5Jm2E9PoNQ+R5ipmxZEjeK5WGxYYxY9hQmEP0iv
         y4PNY3N8MRr79BFxF7Mo8gN5x/QBEfI6vFuMafVU0cn8XavPD3ODqG0LJ7IVP8im4Y0D
         wPb8nfOFC+Lhn+WrWh2ITHKLRnJbLvfOM6f6TVpE/y8QN/eaBnFLuNnaGPqravQVEnOn
         NRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746622891; x=1747227691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiNXlxur2Dh7oN7P4Es0NHzTBV+X3Ml6Cdu3bCSQCe8=;
        b=iZ0SKJxlC6xQ2VZPnI7ztoGUrh7+DxD4HZ+aco54Ul8oYxF5tcUJassRS3yc58CXjV
         DVwXRXRCJm9pgyd5nb31ehBvt6FvIsLYXlbYS2lOiPgfMD07RVcwd5vLgcYtwzlam17Y
         zZcEiY/aOeOPWWTDB2mX/P9+vefREeMM0lQ8hrxfKmIYM4ggP71O5uVQK1T5gGr8zKu0
         CyTZ1NcVB31hHsAi52K/dvilyQIHpEAURU0xemTB5pbAXzfTve0gh1Bmqb2piUuwi9Yn
         ob7UbmjGni8TTI8GqgrgMJjuzHMtR4awmuU4nkAreFI9zyCJYalyYKMXcqIU3OTgNcKn
         LkSQ==
X-Gm-Message-State: AOJu0YyMKiiyR/29pnt51JU86cmO2bSAX7h3NCHM19ywO9YxSz0ESIRn
	UT/iYCPTIqY9XVTSZvcyJLf9ue4z6uq77oJ5XoB7v6hZdBIoTIYAazGFyyQte5qsGTAXVCCYTEC
	b+3m+ZZi7KJL9kVJUHhF2gQL9dqLZAdt/
X-Gm-Gg: ASbGncvApnO7d1vVvPGY/F5pP4lPlesTchLOndqNZrIxjYtGS3idsEEKktzpFRXx+xt
	A8UZECXxVvzFbGwQNRvjYrM4AD0NFqJUp5U8FALKGXmrSC9qOBfTUlhTuHmx6CtkoRmwTESwADP
	3662AkJfNzhyqTQSbJm8fM
X-Google-Smtp-Source: AGHT+IG02Z02N2xSddTvR9GvEJOIffjEx/5l5nVWEcqi4ELPqR9OiqScJnw1rud2NTaLP6BPWACNY23H103jmS9hmi4=
X-Received: by 2002:a17:907:2cc6:b0:ace:3ede:9d16 with SMTP id
 a640c23a62f3a-ad1e8b9587bmr328847266b.9.1746622890329; Wed, 07 May 2025
 06:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
In-Reply-To: <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org>
From: linux.amoon@gmail.com
Date: Wed, 7 May 2025 18:31:12 +0530
X-Gm-Features: ATxdqUE0l5vsyzNKgL8uwyW-d7Ikg0-6lIS_zZgvV9ODcVZjJW6RmPTXmkIZfpU
Message-ID: <CANAwSgRMGOxrjuottn+rhU1Z3901LOgX=ktrMh7-HOJZhGaTmg@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org
Cc: Wayne Schroeder <raz@chewies.net>, u-boot@lists.denx.de, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 May 2025 15:54:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2672

Hi Wayne,

On Wed, 7 May 2025 at 17:31, Neil Armstrong via groups.io
<neil.armstrong=3Dlinaro.org@groups.io> wrote:
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
I wanted to enable CONFIG_USB_ONBOARD_HUB on Odroid platform on u-boot
I think this should help USB hub reset, I'll check this and let you know.

Thanks
-Anand

>
>
>=20
>
>

