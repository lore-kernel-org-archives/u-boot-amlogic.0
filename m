Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB44C3ABD4
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 14:08:05 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.17971.1746908518733184242
 for <u-boot-amlogic@groups.io>;
 Sat, 10 May 2025 13:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=u47z14ce;
 spf=pass (domain: chewies.net, ip: 209.85.208.49, mailfrom: raz@chewies.net)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so8132268a12.0
        for <u-boot-amlogic@groups.io>; Sat, 10 May 2025 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746908517; x=1747513317; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghFoxlYELDJTH8sQXcJctO6qyyJl1AJpsH25aK+VUgs=;
        b=u47z14ce5rv/VGulMJaWEG3yy/nDbQ1iqdbBX6beyiOFN5zKc+urfCLgrIhsi7qZjM
         M7cb5AoOK4KM39quyNhqLD8zDiVh7tVcG/Oj0B8+hGjJiil8zV1L6Up1uW70qaApseSi
         elOFCBOdprz/9CZu7TWkyVrxUhZw7QAoze61zTQ8kuSGGSYQVLnl+Kg0G/qngtWOHSZN
         UgPAR1uNOWBLY1XVPZkzvWTDOLyIv/Hwr8La7PgXL0nAbwgO2B3i+rbnl+JI02GdJl7Z
         jYPoC0TGFZVSP8Nqgn/atQ3Hvp/2z15Dsr0m1PrRwWUw8ITCVm0UjRaZgCnLctbH/aFJ
         5zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746908517; x=1747513317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghFoxlYELDJTH8sQXcJctO6qyyJl1AJpsH25aK+VUgs=;
        b=bM6tNB+dDcx6V2J4MNh/Vbs2oFClWtHvSeC3ZTPs2PXpbgK/W9HxjC7rWOkC/WL2l2
         C6YLaCKfipjZeCMAiFYtkxV/Qg0JFRV4eF6EpBVLeTo+5J9oXdOP7FIC9ddk2otENM/b
         RbuGzZiOJvoOveu9fUnaCkWmsPBQrSgCSTb8U4d4UU50MxFLerm4YXbtsMX64OVWVVbj
         GYNBZEvTD/lBxWyJdSn2WoptNENUouqKnHeL3ybR3HOqkbMiuFOA/MgA2peXxLWKUXH4
         0sqB+h9yKmSWC1VPIG2uvIianbNC6YASki6tA/pT62MwLCGQY9sO5FzAtGQFRPEcX9no
         T7BA==
X-Forwarded-Encrypted: i=1; AJvYcCUBR+7zqycDFil3SUoyFP/MQsY9hLFtYVGwmY2Zqc9frPLstYZ5is1NgKkY5Yli0zryUQkRtrmo8h2IC7GgjQ==@groups.io
X-Gm-Message-State: AOJu0YwKIcM26GxRcf70V650dtybEgozWb5ijOz3jP8tqM5ZFGYrnm9Y
	VzOS2S9ymEGQuX2BYMKO0386RfqbJt+XZh2Cn17vMSl1gvcM7XMcTSpM1bhLbXoX8k3gukbANNZ
	WBgIj/kYwQRoo7A0NYwOAkqKxcNzu7XfPApIeSoLh8d7Ope7F4w==
X-Gm-Gg: ASbGnctX8FgFp7gbWc3lfV8zbdfBgXJ+J2jKD7/hkVqib31r4ef10AlfZCCWY31K5tS
	77ELMHIEfrL1ZThhYrR92rEzftxQbHrbH7FDj7FsrPdA2jHAvPV/AvZVgDqAtovX7Qw6hiS6j6N
	evGtEcuYltlQUTD7IiuxcviliwGXUSDw==
X-Google-Smtp-Source: AGHT+IHrmIxpu89JcXp8pTsYpjYQ52JP4jQJB6ftV4JyF40SXcxgujBoCYyks/9VE96AKLi7tzU34e4CP9TYSNEW1s0=
X-Received: by 2002:a17:907:c317:b0:ace:8176:9870 with SMTP id
 a640c23a62f3a-ad21b16d832mr722442266b.9.1746908516933; Sat, 10 May 2025
 13:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org> <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
 <CANAwSgRkqAj5Q4LMO-CKBSoMgO-+zd6JpbVs+eWY3kPgmj9bug@mail.gmail.com> <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
In-Reply-To: <CAEUiLubakMjzhi2sUTQx1S4ciTjkL6ysx465i1t-T5zKUQdUvw@mail.gmail.com>
From: Wayne Schroeder <raz@chewies.net>
Date: Sat, 10 May 2025 15:21:44 -0500
X-Gm-Features: AX0GCFutdAtYDL586PDSub990CVv4WeGORcasNYzmQIEdeFBm-BEawgbOOwFLNY
Message-ID: <CAEUiLuY2D_CzkEH0+gCvkbC_MtJ4B-MLYYkx_r2E9BHxPvuVjg@mail.gmail.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2701

Applied patches to 2025.04 release (applied clean).  Made stock
defconfig for odroid n2, built, signed, installed.  The reboot issue
remains and usb ports are unavailable to linux kernel after reboot.

It is worth noting that linux does see some enumeration of devices
after a while, but even if it logs to the console about device
attachment, the devices don't actually function.  This was the same
behavior with the release version.

Wayne

On Fri, May 9, 2025 at 10:01=E2=80=AFAM Wayne Schroeder <raz@chewies.net> w=
rote:
>
> Yes.  Will report back how it works on the n2+.
>
>
> On Fri, May 9, 2025 at 2:08=E2=80=AFAM Anand Moon <linux.amoon@gmail.com>=
 wrote:
> >
> > Hi Wayne,
> >
> > On Fri, 9 May 2025 at 01:25, Wayne Schroeder <raz@chewies.net> wrote:
> > >
> > > I actually already have a working solution that I documented in my
> > > github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
> > > check/delete a flag file on my boot partition and if it is found, the=
n
> > > reset usb and sleep for 10 seconds.  I then have a systemd shutdown
> > > script only on reboot to touch that file.
> > >
> > > CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
> > > reboot... && usb reset && sleep 10; run distro_bootcmd"
> > >
> > > It is a hack, but... the system reliably reboots remotely now, and
> > > that's the important part for now.
> > >
> > > Wayne
> > >
> > > On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
> > > <funderscore@postmarketos.org> wrote:
> > > >
> > > > On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > > > > It's hard for me to quantify if usb works in u-boot as I'm not lo=
ading
> > > > > off of any usb storage devices.  It certainly never lets me use t=
he
> > > > > keyboard to abort auto boot, and never has.  On reboot, to reliab=
ly
> > > >
> > > > You can send bytes via UART to abort boot, if you happen to have a =
UART
> > > > adapter around.
> > >
> > Can you test this series to see if this resolves the issue?
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D456088
> >
> > Thanks
> > -Anand
> >
> > > _______________________________________________
> > > linux-amlogic mailing list
> > > linux-amlogic@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-amlogic

