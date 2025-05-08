Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C5C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 12:47:26 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.5280.1746734079663798220
 for <u-boot-amlogic@groups.io>;
 Thu, 08 May 2025 12:54:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=W6c89YbM;
 spf=pass (domain: chewies.net, ip: 209.85.218.46, mailfrom: raz@chewies.net)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb5ec407b1so231776066b.1
        for <u-boot-amlogic@groups.io>; Thu, 08 May 2025 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746734077; x=1747338877; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3stnx/8tSv02z2R+WZ/pNypTKXfQ6hJ4O4a92YG83Ic=;
        b=W6c89YbMvyIdGPfav5UTgTWrkHvIBTnAlk4naRkpS2u1oirX//s4fZ2zFmErFIUjzR
         BC81wuhbN5hvc2RQiHGwFizNbRqykWcqwPPjlLKjkEAz2spDoZPuzDTN6bssR6waGZs+
         X6v/tpzX8Sz/RQuYX+C2bEV/VH5FBNRaB9ZbW+y43B5mHuoKcysg8ChpmzbhM72aef1w
         3n2Lmiicc1G4CEabZ4K9Ez/dY5Q1PhYMuxRXuoxGpLDjyY3BkZMbS7Z8irKMf0fwjMPf
         X0Ui3ZrKAgixzbcwfH45keDr63zSzM1Qb5AzZagDUo88O5yUI5gnS4hmQlnOSh1bMlT/
         OtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746734077; x=1747338877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3stnx/8tSv02z2R+WZ/pNypTKXfQ6hJ4O4a92YG83Ic=;
        b=vfjVWbnOQ73DqCIxDMW8BSR6303E4eAO+iT/eYowUmSmFVDjH+VLZQW9/5lzbKWLPg
         /26gnYVYacAORzeIyFHAqMOEMzjh4FViXlaF7S7w9+fvo86FEc8f1wI8QiccJHRK763k
         ZTsFsw8XfnWHwDT706/fu6TpaNo56l8nWMdpuH14PFLPC2GkZi9Dy5IwszmZG2j8AYxl
         RA74gh2+wWbST8B6qOjgjopo8ErgAf+/4mJhj0lXCzGUUxzSPRYDZrwbzaMC2OhZpF9H
         TTDQanFsEd9KMYG9ul57z5EnMVu0hMlmda2jgJ6bsOWnX9mgOgSW64dxd/TNLEhEMCEc
         x8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUpKtyPMS3aHqCCEDqSEiLu1YKvfO24Hgl8+9kBbPP/eXNBIWGK6pSV8hpl1/Z/T6bwQBo27G8GPRj7sGpa7w==@groups.io
X-Gm-Message-State: AOJu0YwEV/WfdegEcHn1wuYlfwhswPY+bS+kq+VyCkT2HNf2ByTmaeXT
	6poGj1iq9yLIdCcfIjpk/SRH/alY2wc/fKzDLl/bBL2Gi9O3XdcJNkzvg7HjwO/oDAouZcWZbwV
	9+NLlc+FuyxlyshQOQIZpPGivYuYhEGQJdzAi
X-Gm-Gg: ASbGncs9IHELBvTC6ospFQUhG8xEcVsUi18wZFrEM5XbRmqVSsxL61IK1Eckic8jKOO
	PWkGal4fYiL42pj1yALBqILMGD1VIazQzVtxHXd/wRH+IA1H42ReUmMGBaO2k6Y1JqwzQPDW9aq
	TXVZxkFRsvla5IarvKYV/3rqSob+1NIA==
X-Google-Smtp-Source: AGHT+IH2+/gg13T5NN5Eyoum1lKK2XajbhrJ0rZkP+NMR+BmxtRzYNi93HyAeD7SxIGunz1ad62B7jFOeKm5i/whAuo=
X-Received: by 2002:a17:907:c081:b0:ad1:e587:9387 with SMTP id
 a640c23a62f3a-ad218f19a66mr78477966b.21.1746734076821; Thu, 08 May 2025
 12:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org> <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
 <3783aef0-a7a0-489f-add0-21e1fc2bfad1@linaro.org> <CAEUiLubVazb4rgfBd-r-5AtyfBVaMFmy89OO_UZB97FM43if7w@mail.gmail.com>
 <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
In-Reply-To: <D9QX0MRWSYW6.3ELRB73BS6PRT@postmarketos.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Thu, 8 May 2025 14:54:25 -0500
X-Gm-Features: ATxdqUGw2CG134B1aSNbqeEu0cZ_c6g2trXskQS6xYNTP-PlR6OnNDQu0nF5Xnk
Message-ID: <CAEUiLuYW61Vz4zAie2K9cnXXQxxRj150Nc-fJMQCh9NwXZQmzQ@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 12:47:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2694

I actually already have a working solution that I documented in my
github repo (dubschro/odroid-n2).  All I do is set BOOTCOMMAND to
check/delete a flag file on my boot partition and if it is found, then
reset usb and sleep for 10 seconds.  I then have a systemd shutdown
script only on reboot to touch that file.

CONFIG_BOOTCOMMAND=3D"fatrm mmc 0:1 reboot && echo Resetting USB on
reboot... && usb reset && sleep 10; run distro_bootcmd"

It is a hack, but... the system reliably reboots remotely now, and
that's the important part for now.

Wayne

On Thu, May 8, 2025 at 11:22=E2=80=AFAM Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> On Wed May 7, 2025 at 1:03 PM UTC, Wayne Schroeder wrote:
> > It's hard for me to quantify if usb works in u-boot as I'm not loading
> > off of any usb storage devices.  It certainly never lets me use the
> > keyboard to abort auto boot, and never has.  On reboot, to reliably
>
> You can send bytes via UART to abort boot, if you happen to have a UART
> adapter around.

