Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8CAD2A53A
	for <webhook@archiver.kernel.org>; Thu, 17 Oct 2024 11:43:44 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.46428.1729165415692743763
 for <u-boot-amlogic@groups.io>;
 Thu, 17 Oct 2024 04:43:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=2qnT5rj4;
 spf=pass (domain: baylibre.com, ip: 209.85.128.50, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so9384805e9.3
        for <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729165414; x=1729770214; darn=groups.io;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LWxILAH51/hr4Bd3wiqzoyqgNuq6HGgVx7DXpURG2dY=;
        b=2qnT5rj4mEL0QUraEM2gJyCLUCuBp5WAtOAJOQnNz/8EWCOBTCy7LwZU1vKZVkoEIU
         putWx61Q0PuCnCab57Feo44TVHzEbGWn2c6kn0A72xH7zl7fgCFLAMByFiSgzPV7c3du
         WgS8IHJ1cMiWbkBffiA32imFlPTGVkkPtMI+h7zojmGYEkmTAIp81dqwgFlB5CZNum+d
         Io46l0OWL/y6ihCe91EPpmZQ5BkU0jnucDMXS3sqz3sP6wt6rwtrjO0ZzAQ/KRZUVBq8
         rkgMrV2mqAfnf94ZTP9gPcJ5XaiA8za4W8fsUgq4YQFsfkDZfZea5WvxvMawwTOA9ueb
         UJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729165414; x=1729770214;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWxILAH51/hr4Bd3wiqzoyqgNuq6HGgVx7DXpURG2dY=;
        b=tHgPI/JzzDf2NGcdtMOTimp++aqbqpdSdMs0Bd61+qAyMd+FsD2NeixjJXubUm3b1g
         ViV4ldxSxgKNpnQPclvF9ogex2h5VRT31o9AgaNHy4daZI/cn8bCoBvZJN1lFstSsV/i
         XqQKKKjtTIaXPrwNUhKd/YWXmyslPXG6ByKHR2DYF344v+1q4l5k+drmESZCRs2XPIPz
         XSb0T9wZan7IjrOkteHFmHi9rYIf7/uLOLkIInGzeKKgV2ubTmDgpnosL6YDH8eogENr
         q9jYl6sD+65M4wUDzfrc/55vlL18OQf0XVCSVT1v9msh4XzGLOUwe4qQNf0yze6nWTtX
         W7sw==
X-Gm-Message-State: AOJu0YxceGnRA92NkcJNbTS2Dd+2oRuqRhJWliy/VWaYgMeeQJjUtr1V
	QRR70s2nVlpmgvITd1zlZV4xanSvsFtolnWzU4QTnkmGFtmY+scO5s+MHGoloWI=
X-Google-Smtp-Source: AGHT+IF8gpGKNU9yeLZBU4xTnZZuPDG5z8OleqTeTDOIN8jJTSJ6QysvOPirH4z7/ThBi/+9LZa/NA==
X-Received: by 2002:a05:600c:4e93:b0:431:5bae:c600 with SMTP id 5b1f17b1804b1-4315baec7eemr13049515e9.34.1729165413997;
        Thu, 17 Oct 2024 04:43:33 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4dd28sm23676705e9.37.2024.10.17.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:43:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>, Simon Glass
 <sjg@chromium.org>
Cc: u-boot-amlogic@groups.io, Igor Opaniuk <igor.opaniuk@gmail.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, rockosov@gmail.com, kernel@salutedevices.com
Subject: Re: [PATCH v3 2/6] treewide: bcb: move ab_select command to bcb
 subcommands
In-Reply-To: <20241016154832.nqlyspranlrsl6l7@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-2-f292c45a33e4@salutedevices.com>
 <17FD691FA1477948.8140@groups.io> <87ed4mhgaw.fsf@baylibre.com>
 <20241011180031.cgvuhks7zo772wl6@CAB-WSD-L081021>
 <87frp1r9iz.fsf@baylibre.com>
 <20241014203820.riljx72bkqw762v5@CAB-WSD-L081021>
 <CAFLszTgO5h1zdXJTk-PCcDWx6nAz3riV34K_sHcvnO4AYMNSqA@mail.gmail.com>
 <87ikttzhwd.fsf@baylibre.com>
 <20241015144245.e4zzhuuqguwnxafg@CAB-WSD-L081021>
 <CAFLszTjYYa_LO2eOj_5fFjGAMivq298g8n_U=-L20pKk6Tkw1Q@mail.gmail.com>
 <20241016154832.nqlyspranlrsl6l7@CAB-WSD-L081021>
Date: Thu, 17 Oct 2024 13:43:31 +0200
Message-ID: <874j5b2bvg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 17 Oct 2024 11:43:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2501

Hi Dmitry,

On mer., oct. 16, 2024 at 18:48, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

[...]

>> > ```
>> 
>> Long help should use U_BOOT_LONGHELP, we normally handle this with
>> #ifdef - see cmd/bootflow.c for example
>
> Thank you for pointing me to U_BOOT_LONGHELP. I have redesigned
> cmd/bcb.c to utilize the U_BOOT_LONGHELP(), U_BOOT_CMD_WITH_SUBCMDS(),
> and U_BOOT_SUBCMD_MKENT() functions. As a result, a significant amount
> of command management code has been removed from cmd/bcb.c, making it
> look much more compact.
>
> To be honest, I think I missed the minargs parameter in
> U_BOOT_CMD_WITH_SUBCMDS(). Including minargs would enable us to avoid
> checking argc for a minimum value in the each subcmd callback and
> returning CMD_RET_USAGE in case of any errors.
>
> Anyway, I will prepare v5 version with refactored cmd/bcb.c to
> U_BOOT_LONGHELP usage.

Thank you for your patience with all the back and forth on this. Looking
forward to v5 !

Cheers
Mattijs

>
> -- 
> Thank you,
> Dmitry

