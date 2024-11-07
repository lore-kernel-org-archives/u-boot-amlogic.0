Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C891D42BA0
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 15:08:18 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web11.63875.1730949458670328207
 for <u-boot-amlogic@groups.io>;
 Wed, 06 Nov 2024 19:17:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KZlWX7Ax;
 spf=pass (domain: linaro.org, ip: 209.85.219.172, mailfrom: semen.protsenko@linaro.org)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2974743675so478572276.1
        for <u-boot-amlogic@groups.io>; Wed, 06 Nov 2024 19:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730949458; x=1731554258; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQtSDL3I+MXcDXRRveXBgA6B5E5VqBfEjy/H0NlIU7o=;
        b=KZlWX7AxfmOiVAkY0pN3AG16ijHb2utN9+Axh+I33EKxdXJ2t53YsQdeeJBFov1H93
         DZp7qjfn9Lc8SRMrfyMlDwCAbi1BUZJ43Y4D5Ri7QhhpwIg/RuA+oqNmjiyNzDzRq0o/
         b5aMlAWVap2tJH3c6NIlh+PGW4QIuly/l17Vd2fwl8Y4kPcCY8qFfXO8ZsTE2YHQXstv
         /JeCMdmTtdE+ilIzCHc+zFGkKB2GBhg1hFxo927+1WrywKjtEnjkic4Qn/Alf+BToO1h
         NLRw2hh0x5PSFC+ACtnUteEPzVQb8F3US4eYAigRHRAinOVb3Y9hr7D6qpKy6wHwfYNw
         92rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949458; x=1731554258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQtSDL3I+MXcDXRRveXBgA6B5E5VqBfEjy/H0NlIU7o=;
        b=asBMd5lWK6eHqSzy/zOo/LX25G/F5uqkIf8zx0BjvEac/lgZ56Oa/DGEUgavLGkCRc
         uLLA8GmH+I/wQnJFQwDE8MjP0eSfWyL8dy8c4KqAVUcqNgVyt66Fxqw7lqj/znb8Sf37
         Aetgb2R2hlbhRvSMT+RpyIF1ao4d73dfnlgNOJvjB5sjn2su2DTsbzHYAs9nhs0Q+oFd
         2QcPWZ1irYKENYHZACTG/yxlunvM7LwhkB2XPnFOzq4NI2dHeQHlKZNCDMsdvpAeWTH6
         HQS8XoXvenwpWXMdVVTayRn7N16RfYnDXojqFQ4AyfFq83f/H+WK6C7HTWRK+X8TxDqB
         prAA==
X-Forwarded-Encrypted: i=1; AJvYcCX55uh9vbtY6Dn5xlqLFw2MnQMBLMqRNmvipFEOIGjsNJSFAjmVrUjesV2Q1HSF0PQ2Jh4EvKqRAjEMcLnXTQ==@groups.io
X-Gm-Message-State: AOJu0YzwOpj+uVcHr4JuKixiYwcxR95xzLHNN8KzOcUxaQI1Wx4VgWyv
	+oFLd/xpSdappht8bufDfYodltwGjjd+RGdVakrNOp9VUQMSGYY8ic7PlpYW2LzNoGklUqb/hNy
	EsPEzI+we6Wt83mQIpiKHcKEaCeDDYt+eh7zdlg==
X-Google-Smtp-Source: AGHT+IHv9GNYd1GPo8eo4Yn9tgtLIHJcl5GZSikEpisUWhT44sOlol5ojTbwcycmsNizesos6h0nEjZf9ON5h/ibyuw=
X-Received: by 2002:a05:690c:4d09:b0:6ea:1f5b:1f64 with SMTP id
 00721157ae682-6ead11e3eacmr6254677b3.0.1730949457739; Wed, 06 Nov 2024
 19:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
 <87v7x1soto.fsf@baylibre.com> <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
 <875xp08ysu.fsf@baylibre.com>
In-Reply-To: <875xp08ysu.fsf@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Nov 2024 21:17:27 -0600
Message-ID: <CAPLW+4=qt++B+wD6zvfsoCxgd=Jmygf7w=Wz71p3Z8GUOZS9oQ@mail.gmail.com>
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2548

On Wed, Nov 6, 2024 at 4:02=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Sam,
>
> On mar., nov. 05, 2024 at 18:58, Sam Protsenko <semen.protsenko@linaro.or=
g> wrote:
>
> > On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Hi Sam,
> >>
> >
> > Hey Mattijs,
> >
> > [snip]
> >
> >> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, s=
truct disk_partition *part_info,
> >> >>                  * or the device tree.
> >> >>                  */
> >> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
> >> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
> >> >> +               slot_suffix[0] =3D '_';
> >> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
> >> >
> >> > AFAIU, this changes the behavior of two above functions, and
> >> > consequently of "bcb ab_select" command? If so, just to double check=
:
> >> > were all users of those reworked correspondingly? I can see next
> >> > occurrences (there may be more):
> >> >
> >> > $ grep -sIrHn '"_' boot/bootmeth_android.c
> >>
> >> I thought the same when first reviewing the patch.
> >> Looking a bit closer...
> >>
> >> >
> >> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s=
",
> >> > priv->slot);
> >> > boot/bootmeth_android.c:111:    sprintf(partname,
> >> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> >> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->sl=
ot);
> >> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->sl=
ot);
> >>
> >> ... We can see that ab_select_slot() returns an integer
> >> That integer is used later on to initialize priv->slot:
> >>
> >> """
> >>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
> >>         priv->slot[1] =3D '\0';
> >> """
> >>
> >> The change from Dmitry only changes what we **write** to the BCB (into
> >> the misc partition), not what is returned by ab_select_slot().
> >>
> >
> > Sure. Just wanted to double check that the behavior is not changed in
> > any related parts, as the commit message doesn't mention that. Btw,
> > BCB is an interface between the bootloader and AOSP, so if this patch
> > changes what's being written into BCB, does it affect AOSP part of it
> > somehow? Especially for already existing devices with particular BCB
> > data, in case U-Boot gets updated there.
>
> Those are valid concerns.
>
> Per my understanding, on recent Android versions the slot suffix is not
> read from BCB, but from the ro.boot.slot_suffix property:
>

That probably still leaves the possible combination of some devices
running new U-Boot versions (with this patch applied) together with
older Android versions. E.g. in case when U-Boot is updated but
Android isn't, may be especially relevant for some dev boards out
there.

> """
>   // Initialize the current_slot from the read-only property. If the prop=
erty
>   // was not set (from either the command line or the device tree), we ca=
n later
>   // initialize it from the bootloader_control struct.

So even in recent Android versions it's being initialized from BCB in
case the property is not set.

>   std::string suffix_prop =3D android::base::GetProperty("ro.boot.slot_su=
ffix", "");
>   if (suffix_prop.empty()) {
>     LOG(ERROR) << "Slot suffix property is not set";
>     return false;
>   }
>   current_slot_ =3D SlotSuffixToIndex(suffix_prop.c_str());
> """
>
> See:
> https://cs.android.com/android/platform/superproject/main/+/main:hardware=
/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D185;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d;bpv=3D1;bpt=3D1
>
> This has been the case since 2019.
>
> If we look at earlier implementations of libboot_control (which was in
> bootable/recovery)
> https://android-review.googlesource.com/c/platform/bootable/recovery/+/11=
91517
>
> So implementations before 2019 that do not have this patch:
> https://android-review.googlesource.com/c/platform/bootable/recovery/+/11=
11899
>
> Will get the slot suffix from the BCB (not from the commandline)
>
> For these older implementations, we will go through the following:
> BootControl::Init()
>   LoadBootloaderControl(device.c_str(), &boot_ctrl)
>   android::base::ReadFully(fd.get(), buffer, sizeof(bootloader_control)
>
> And struct bootloader_control has:
>
> struct bootloader_control {
>     // NUL terminated active slot suffix.
>     char slot_suffix[4];
>
> And if we look at how the BCB is initialized from userspace in:
> https://cs.android.com/android/platform/superproject/main/+/main:hardware=
/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D120;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d
>
> We can see that we copy _a, not a (for example, if slot =3D=3D 0).
>
> So I think this is fine.
>
> If needed, I can dig more for behaviour on older devices (<2019), let me =
know!
>

My point is, if it's possible to introduce this change but keep the
same old behavior (across both U-Boot and AOSP), it's usually better
to do that that way. If I'm not missing anything and that's a valid
concern, maybe a separate patch can be developed on top of the merged
patch series handling that. Anyways, I don't have enough time to work
on this right now, so just pointing out what I noticed, if it's useful
for anybody. I'll let the maintainers decide :)

Thanks!

> >
> >> ab_select_slot() still returns an integer which needs to be converted
> >> via the BOOT_SLOT_NAME() macro.
> >>
> >> >
> >> > $ grep -sIrHn 'slot_suffix _' include/configs/
> >> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slo=
t_name};"
> >> > include/configs/meson64_android.h:65:        "setenv slot_suffix
> >> > _${current_slot}; " \
> >>
> >> Same goes for these 2 examples, we use:
> >> The "bcb ab_select current_slot" command to store the slot into the
> >> "current_slot" environment variable.
> >> Looking at cmd/bcb.c we can see:
> >>
> >> """
> >>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
> >>         if (ret < 0) {
> >>                 printf("Android boot failed, error %d.\n", ret);
> >>                 return CMD_RET_FAILURE;
> >>         }
> >>
> >>         /* Android standard slot names are 'a', 'b', ... */
> >>         slot[0] =3D BOOT_SLOT_NAME(ret);
> >>         slot[1] =3D '\0';
> >>         env_set(argv[1], slot);
> >>         printf("ANDROID: Booting slot: %s\n", slot);
> >> """
> >>
> >> So I think this is fine.
> >>
> >
> > [snip]

