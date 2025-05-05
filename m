Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE10C3ABBF
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 11:54:32 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.49988.1746450775334467028
 for <u-boot-amlogic@groups.io>;
 Mon, 05 May 2025 06:12:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chewies-net.20230601.gappssmtp.com header.s=20230601 header.b=pBOZRvGV;
 spf=pass (domain: chewies.net, ip: 209.85.208.48, mailfrom: raz@chewies.net)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso9975105a12.1
        for <u-boot-amlogic@groups.io>; Mon, 05 May 2025 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746450774; x=1747055574; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PLmUJUdgMb4I0FCDdfNItxNNG3T0tV4J7kVIBv0o0U=;
        b=pBOZRvGViTeG8BxPhlk53ZMP/MyLbEUKAhU+py0/YoQdVAgyvwTCjqVMedONq83MfI
         M7HpxyHuesJ62xcCDfO2XChB9OM0/Avy6gPzGEbCNMzXvE6VTZ21Yh0ysWZWazwwFQ3O
         8/V64ZBocb47lcmMOxoUtyokl8c4zhPnlnRFbx/dNigMA5AVMp80Euu+R5VyZk70YsEA
         RGngXrF+X5sbuvvslTCBwPMAz+yhzK/BDOLpn8A8TG9nCS9x8D0QGPjSkpUsL8KZm5um
         0vrETIaNUvu2u7CFKxC5IcNHsNN/V3Xeq69IdgXxvAgGAEd+Mkwb8EAIN32nGg0Evtts
         eUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450774; x=1747055574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PLmUJUdgMb4I0FCDdfNItxNNG3T0tV4J7kVIBv0o0U=;
        b=Q4zzddd7wqTeOiTK2E7p5tYsHDosXKo6ZCYEqxzREsG9i8rTMHaRXbo4g8eMWuhVen
         EmYfER7wuYMDR+k7/AgYOdzn1BYc7b2w2hvNOOH5+177FQurdL7FyXtHH2g1ArzHW5Dx
         y5by0k2Mp8xB1Uw5M3jWSRht6QKoTqog1P5TJBz1eovOdxx4rDh+v3MKB3RZ1zqNYBCT
         IZQxVrjshkbUMZAe64Lpw4eMMoJJMo0106FRpkg7vhxzaWs5s5pEyPtOLvRyfxG2dpsS
         74GfiPLjvDw+TU85STAll/4Ierud+Q/VV4IoP/b3bt3itqlCydma0niKO1RjGNFS39h5
         efbA==
X-Forwarded-Encrypted: i=1; AJvYcCXrXRQlMFAvjQ00wZw2Pzbi3vlNfrTsI1m/t1CRNspEyi8OQsa/C0Cfta+vTTcFV2+SEbRnJ9xKMFZUINTI/g==@groups.io
X-Gm-Message-State: AOJu0Yz1w8m7336YHVe/p0DqYGfKT//t2rQh+4aUBb+xunEigR3gYo26
	8Xb9wg0uWsxHsezsz5eDzNlo7m3n8ifTGgE0+ieNoe+umM3lfZW6C/0ubFZAn7QvmXXinyorqLH
	UegHNqkjt9BI3VKMI/Bc/+dkvXvdHerJcDLL3
X-Gm-Gg: ASbGnctfmqeS01P/anOLDMk0ojAPjcn4jGDHXxW48WDiY1iD1JdeMoW2AQKXWlW+b3L
	VK23uBJVilrApDRMI18MM7E6KNTmDdF6Alu8Ip6DGBR0Q1yamroNn9vmaXsDe23Lpk+emZb7ji9
	bRN51mB0j/KiXAnzzDaCE=
X-Google-Smtp-Source: AGHT+IFYElk0llN1ge4pi4ZSXHpMCLLnNKx89JuhozP4HSomsgFEAmnq/9ASvVYW1zWldmmYnM0dnyeW/hjmdTFJlwE=
X-Received: by 2002:a17:907:c1f:b0:ac1:791c:153a with SMTP id
 a640c23a62f3a-ad17af8392cmr1114328266b.27.1746450773558; Mon, 05 May 2025
 06:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
In-Reply-To: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Mon, 5 May 2025 08:12:39 -0500
X-Gm-Features: ATxdqUF4lges0CS6ogY4qszXoi_2lLRibq4vcliRXnEvivpaFf0MHzWf0mKZKmM
Message-ID: <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, 
	"u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 07 May 2025 11:54:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2669

If I add the usb reset command, it works reliably at reboot, but it
does not work on a fresh power-up with that change.


On Mon, May 5, 2025 at 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrote:

> I think it's a very long term issue, USB lacks a proper reset at probe on
> warm reset, does USB still work from U-Boot after the reboot ?
>

