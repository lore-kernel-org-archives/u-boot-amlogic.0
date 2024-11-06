Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8752FD42B9E
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web10.35930.1730854699023460733
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Nov 2024 16:58:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=OYC/kjar;
 spf=pass (domain: linaro.org, ip: 209.85.219.173, mailfrom: semen.protsenko@linaro.org)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2e444e355fso316952276.1
        for <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730854698; x=1731459498; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0T625n7xhdhvD5r9zXSr9RDqmz7giA2s8bSypQmLkQ=;
        b=OYC/kjar8nxxQfMeRYU5aztAJLgIymMQn7qVcK4VZ7F2W3qQNuyLs50eQZLYNiO1LL
         FkrydLIcwv5q1FN7sjMXlUnkdpJxcNFFsK5bjh+dj6bUmoNMRe9kDnH9dRVNdpg+32gc
         tdLbhFf0AsGVTF5yaX5U0dgKn3ONRB2G0DMHLD7DhGwkrqsVDmizsdBeCsScz3r1l2As
         4PGTQXy99S/1n8668QNYbDX7vC9oyGDMuvKUpHsCdzDut5IlZFefcEd2kutOq1pIAei2
         LNLFyFErxJkm5a3exa7g/fAT7mR4Sd2HsXOI7Ry6U8Se98KBsey77xrSoFmZ1iBBggaz
         OvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854698; x=1731459498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0T625n7xhdhvD5r9zXSr9RDqmz7giA2s8bSypQmLkQ=;
        b=SQznQ2BetHUucBx8k6eiRhx0JtbiwSPZEsQMl1A7VI+VtN3h+otilA3xfT7zR4KMYx
         1StirqAXzu1OfEQ6Trm9I+R+nukVSRxW2rRMlIb2jNPq/yAuHbwbVnUMtARb2paKcjNN
         JmghgZQWGEnR/fsrBkakSffcfU5T1SQj1nXm/ZAAY4OIvAsJArEMpM8RDd9FKbliHjQz
         vocjgqmCGf0ocPZ1UWD2wmGD6GLTdHc9ZtyBsMnSXIlC+fskdTfrztkC8boUNagH4fqK
         HMSMzWE9TvIPBOCNv7kTi/IA7+dbsMB5Hj/wm2RElBGv1Lg6hehW8LgZBktZjKfI3jsp
         WuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2OLH3y9veWGkXvHcKBkUKlSSOAwc3WrHvlVZrYJKw0wcBs9WkV/EPyQgNnBj33MjI/TxIRUS5srLULRSm8g==@groups.io
X-Gm-Message-State: AOJu0YxVt2kdeqEqMZd7Qm9PIYXC2oSN3npVGE2pB9N9Se7ZWTsBapnC
	VmGpG5IDNLVikbMrEjnIumvNGryMG1P0v1tS4kTBcZNuXufMGteC5Kq2K5MlWQN2m6Mp1GFEgGj
	VdpSvYcpKLHdG8TZk+uEBD8Er0MbqXuMDLncvTA==
X-Google-Smtp-Source: AGHT+IGMRCuceF+eAofYz263lImLlyi0T3K6Bygh/KHtwRTW1Ys7zsjs/I6pK1YRFz3W+z0u5r7v6zWuQVXd5wgs3OE=
X-Received: by 2002:a05:690c:3382:b0:6ea:88d4:fd4f with SMTP id
 00721157ae682-6eabf04814cmr5414917b3.18.1730854698192; Tue, 05 Nov 2024
 16:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com> <87v7x1soto.fsf@baylibre.com>
In-Reply-To: <87v7x1soto.fsf@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 5 Nov 2024 18:58:07 -0600
Message-ID: <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
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
 <u-boot-amlogic@groups.io>; Tue, 12 Nov 2024 15:08:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2547

On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Sam,
>

Hey Mattijs,

[snip]

> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, stru=
ct disk_partition *part_info,
> >>                  * or the device tree.
> >>                  */
> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> >> +               slot_suffix[0] =3D '_';
> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
> >
> > AFAIU, this changes the behavior of two above functions, and
> > consequently of "bcb ab_select" command? If so, just to double check:
> > were all users of those reworked correspondingly? I can see next
> > occurrences (there may be more):
> >
> > $ grep -sIrHn '"_' boot/bootmeth_android.c
>
> I thought the same when first reviewing the patch.
> Looking a bit closer...
>
> >
> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
> > priv->slot);
> > boot/bootmeth_android.c:111:    sprintf(partname,
> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot)=
;
> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot)=
;
>
> ... We can see that ab_select_slot() returns an integer
> That integer is used later on to initialize priv->slot:
>
> """
>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
>         priv->slot[1] =3D '\0';
> """
>
> The change from Dmitry only changes what we **write** to the BCB (into
> the misc partition), not what is returned by ab_select_slot().
>

Sure. Just wanted to double check that the behavior is not changed in
any related parts, as the commit message doesn't mention that. Btw,
BCB is an interface between the bootloader and AOSP, so if this patch
changes what's being written into BCB, does it affect AOSP part of it
somehow? Especially for already existing devices with particular BCB
data, in case U-Boot gets updated there.

> ab_select_slot() still returns an integer which needs to be converted
> via the BOOT_SLOT_NAME() macro.
>
> >
> > $ grep -sIrHn 'slot_suffix _' include/configs/
> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_n=
ame};"
> > include/configs/meson64_android.h:65:        "setenv slot_suffix
> > _${current_slot}; " \
>
> Same goes for these 2 examples, we use:
> The "bcb ab_select current_slot" command to store the slot into the
> "current_slot" environment variable.
> Looking at cmd/bcb.c we can see:
>
> """
>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
>         if (ret < 0) {
>                 printf("Android boot failed, error %d.\n", ret);
>                 return CMD_RET_FAILURE;
>         }
>
>         /* Android standard slot names are 'a', 'b', ... */
>         slot[0] =3D BOOT_SLOT_NAME(ret);
>         slot[1] =3D '\0';
>         env_set(argv[1], slot);
>         printf("ANDROID: Booting slot: %s\n", slot);
> """
>
> So I think this is fine.
>

[snip]

