Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979FDD111BB
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 08:26:21 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.33312.1730627035973197891
 for <u-boot-amlogic@groups.io>;
 Sun, 03 Nov 2024 01:43:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SDkWUjCw;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: igor.opaniuk@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so2224275f8f.0
        for <u-boot-amlogic@groups.io>; Sun, 03 Nov 2024 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730627034; x=1731231834; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlpXUa/y6hbCSQWXh7uOUac/kfV4pe42UeWXdwzZYkU=;
        b=SDkWUjCwMAFN+s8neSI4RArLMJJL3EPLnCB+i+FnTlZONTKkyisUAyrU3PS04BxDWt
         1VFQiiKTvZLQ06x/u0rAoFbE0u7yKZN/oYMqvmws4F/wRG2bYRZcqhamFw6qnBCctPY5
         ZBPBiwzGW2CXq7osxtrhF/h4bphl/zcXNyzt8WdYgca4l3JHnukv63QGtgkjWWH8nlam
         8goB2NYT0V+9heARSg8SkY0nwnByPZFNCOq0AirYNb9Cmg9c6vav+g8FAyq3e3udwRdr
         rMtzYSn+ScJLBE9A7WLLF/xzyRsi3fOCuFnnMgyCXnUysGYPGT1tOWLHgUN/QX7nTdqR
         XwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730627034; x=1731231834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlpXUa/y6hbCSQWXh7uOUac/kfV4pe42UeWXdwzZYkU=;
        b=et3BZ5t52U6uKWXCKDmU4LXujwMSx7cEtiCDv0hovo+X/WNtvwDxZfVcVYYtjDHbJe
         8WekkbwPkYQVt5oo2TJHNMA2efHlHejwdv77nuoV8BpwKFv8gqZCdaVotrItnlGHjblN
         jMAIhlCoC0fx2d8eAR8ficIM6t90liqDbTSyGTZhO7QZedA0W55uBVXXZ2jysoGt7Lo2
         gdNIHkBoZXpMTkL8oSM9+Yv+W22N+kl7+ZADH0oOUBu1MS6hJdP373cgv3fN25mBdswC
         os0KNvVevJ8DsYuejrTCPgMFOLRbc2piC8pdBqW9sygSS44BQriBspzDBOXGiuWWjiTa
         NwOw==
X-Forwarded-Encrypted: i=1; AJvYcCUSeDR2b2DGseWpy5ZCYvhynx9uMBxXtxlQ3mL2xOYWEPobl2B9TuJeBZb5MvTefibyMH9AwfCWhwEMRo9JBQ==@groups.io
X-Gm-Message-State: AOJu0YwYh6SipJtP9fyQZS/mXWsN+TvFGN1k4DN2+DKXalesLVczFMSJ
	XWeIM5MPNnUtvIVgXwHP5bL+u3rbcd9PJf4ilykqmjPMSj9ZV1jhYQEPezx+178UKPPYdmPPrK4
	fVfDxVrWBv2zukZHJoSCdF1QqWwM=
X-Google-Smtp-Source: AGHT+IGoNBwdL5SjQdohSFc/ao3VRguiq5OOVyAwqpvDIOjXcCqRUqo+MFdXWyFbmBE9nmzL6gP7de7+rJ1iHfy5LKI=
X-Received: by 2002:a05:6000:ac1:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381b7057644mr11736299f8f.10.1730627034137; Sun, 03 Nov 2024
 01:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com> <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 3 Nov 2024 10:43:42 +0100
Message-ID: <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Tom Rini <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
	Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	rockosov@gmail.com, kernel@salutedevices.com, 
	Guillaume La Roque <glaroque@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 04 Nov 2024 08:26:21 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2531

Hi Dmitry,

On Thu, Oct 17, 2024 at 4:12=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> To align with the official Android BCB (Bootloader Control Block)
> specifications, it's important to note that the slot_suffix should start
> with an underscore symbol.
>
> For a comprehensive understanding of the expected slot_suffix format in
> userspace, please refer to the provided reference [1].
>
> Links:
> [1] - https://source.android.com/docs/core/architecture/bootloader/updati=
ng#slots
>
> Based-on: https://android-review.googlesource.com/c/platform/external/u-b=
oot/+/1446439
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1b=
1d6e564d503d800 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_control=
 *abc)
>         if (!abc)
>                 return -EFAULT;
>
> -       memcpy(abc->slot_suffix, "a\0\0\0", 4);
> +       memcpy(abc->slot_suffix, "_a\0\0", 4);
>         abc->magic =3D BOOT_CTRL_MAGIC;
>         abc->version =3D BOOT_CTRL_VERSION;
>         abc->nb_slot =3D NUM_SLOTS;
> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct =
disk_partition *part_info,
>                  * or the device tree.
>                  */
>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> +               slot_suffix[0] =3D '_';
> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>                 if (memcmp(abc->slot_suffix, slot_suffix,
>                            sizeof(slot_suffix))) {
>                         memcpy(abc->slot_suffix, slot_suffix,
>
> --
> 2.43.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk

