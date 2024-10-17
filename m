Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E84D2A53A
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 11:41:44 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.46401.1729165300428365928
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 04:41:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=Ntc8POVe;
 spf=pass (domain: baylibre.com, ip: 209.85.221.42, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so796950f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729165299; x=1729770099; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aROGsa4qf+z9vHN3EbDPXJFucg6RZQKdlYgqfKaO0ts=;
        b=Ntc8POVeJF69tCYxTWaNYBg9ADs3/bYmZ8mhfXmCzDoYaP+Zjk2DOK8/d0hT0WBxN5
         RFbrJq/QKtAzuDDOym5wC7+PU7k0dd6HWUA+ljIYBET2tLFE0oons6s453mzCBZRBhpJ
         mmrJPR2R3OBpGP1htUvLxTFCXYL5jVG/I3bZh+sdRNgCbN+he7wtdKTBxGAq4kW4/jdU
         lS6ryjuaxVYbLZMmncj7TwJGa1dlr1xVVk6YBTf63lS9tNIe3jVZDskhWkVXLEQl4z6l
         HEt/P/nbEQq0XY/ZFzdHNGqTNiGJoTlEfos3fRhtOiumGOlJBDlZ5Hm73s7TvYn30PLs
         WdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165299; x=1729770099;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aROGsa4qf+z9vHN3EbDPXJFucg6RZQKdlYgqfKaO0ts=;
        b=HFrlPDwYS1uHGD1rOfePdP/99vjzFnVceDvUlwPTcnaB8iu3+jI+EmfSO2mhc8bo4b
         lhrQj1+ZV/MD3nCU/DS3pa9+uZjrXQUrrwBuknRPVWIm+yg0kSVDJszDYhbuiBXruPyy
         BR0emWqN7sSH8M5NCP474xB7kq0iynmMn4SzJeMG+r3I07w2HBz2uZ2MOKngRuheLQSd
         zb9p/o/LHephmBQeYhRMcfHvmxkFAzBbTyFaQrnUpqkuFJLqr0JQfKDgQWRLsu/ZGdN9
         B7FV6lEGRW+rTzZFdKfTEFZ1qaG/PcTBGAVwFgFbZb+mEYkd4ir8hGVO7EKljpfonl82
         IyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXET37o7PmEKN0s5L6bRsvY7Cz0WnACGPLKtSV4pL/U5yGCKxPbkljBt/qKmL14YWASI2CS2Q6SThAowpOQNg==@groups.io
X-Gm-Message-State: AOJu0Yw+ag8Ju/0DCssPIyGHU/UXgy1urTzq6Xf92bLBT/VJMnzDl4BS
	CW8sETbH6ofXoiDYW+I66/TB8YNruiFeRX5BsVr3h8EHsf0hwC5IEOu5FBlbJXk=
X-Google-Smtp-Source: AGHT+IHGpRZE68/LINUIX56UATrxqK4rqGNHoSmJB0LcMGKT4WBkNVXkqnit23ePNlIHnSGyrVxVCg==
X-Received: by 2002:a05:6000:e85:b0:37d:3f5f:9191 with SMTP id ffacd0b85a97d-37d5ffb3301mr16395883f8f.33.1729165298723;
        Thu, 17 Oct 2024 04:41:38 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a584sm7006756f8f.20.2024.10.17.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:41:38 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, Tom
 Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <20241016140654.mxms6m4g2rr3vncz@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015132631.qnnbrmnuwp6zr7r5@CAB-WSD-L081021>
 <87cyk1z8sy.fsf@baylibre.com>
 <20241016140654.mxms6m4g2rr3vncz@CAB-WSD-L081021>
Date: Thu, 17 Oct 2024 13:41:35 +0200
Message-ID: <878qun2byo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 11:41:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2500

Hi Dmitry,

On mer., oct. 16, 2024 at 17:06, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

[...]

>> >
>> > I just run build on the my x86 Ubuntu machine.
>> >
>> > $ cd uboot
>> > $ make mproper
>> > $ make sandbox_defconfig
>> > $ make -j$(nproc)
>> 
>> I tried these commands:
>> Here is the successfull build output:
>> 
>> https://paste.debian.net/1332378/
>> 
>> I use:
>> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* gcc --version
>> gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
>> Copyright (C) 2024 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> 
>> $ ~/work/upstream/u-boot-dfu/ dmitry/ab-dump-v3* ld --version
>> GNU ld version 2.41-37.fc40
>> Copyright (C) 2023 Free Software Foundation, Inc.
>> This program is free software; you may redistribute it under the terms of
>> the GNU General Public License version 3 or (at your option) a later version.
>> This program has absolutely no warranty.
>> 
>> What toolchains do you use?
>> 
>
> By default, my machine, which I typically use for cross-compilation, has
> an outdated toolchain version:
>
> $ gcc --version
> gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
> Copyright (C) 2017 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> $ ld --version
> GNU ld (GNU Binutils for Ubuntu) 2.30
> Copyright (C) 2018 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or (at your option) a later version.
> This program has absolutely no warranty.
>

Thank you for sharing. that looks indeed very old and would explain why
we see different results when building sandbox.

According to this commit [1], you should use gcc 13.0.2 at least
Would it be possible to update?

[1] https://source.denx.de/u-boot/u-boot/-/commit/11934281526bda3be51783380b55c332804d043d

>> >
>> > That's all.
>> >
>> > I've already sent the v4 patch with #ifdef. I can prepare the v5 patch
>> > using the IS_ENABLED() macro and will aim to send it today.
>> >
>> > But I have one question:
>> >
>> > Do we really want to display the ab_select and ab_dump subcommands to
>> > users if these commands are just stubs? Perhaps we should consider
>> > adding #ifdef directives to the subcommand arrays.
>> 
>> That's a valid concern. I don't think we should display
>> the ab_select and ab_dump commands to the users but I still want to have
>> IS_ENABLED wherever possible to keep the code simple.
>
> -- 
> Thank you,
> Dmitry

