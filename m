Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CBD5AE74
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 08:54:13 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.67708.1730969642785788311
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Nov 2024 00:54:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=yZL/jvFH;
 spf=pass (domain: baylibre.com, ip: 209.85.128.41, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431ac30d379so5833445e9.1
        for <u-boot-amlogic@groups.io>; Thu, 07 Nov 2024 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730969641; x=1731574441; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62NebAwLZ0tLPjRJh/RK1QUkF+esVUerAJcHq3e49Ss=;
        b=yZL/jvFHoWQUn/cen2T65SlHv160uYt88BiyqdLXhwgZ73yKxulV2myXlrvo8t3zFA
         o6bdU6gC78xbErmg2vn9g2Mfep6BdaPBUVMQU4xuw8Bn0AoTVpX06Xoe1BYiwkQhq4kc
         7Emigu+FjO9664QwY644QElT4ZVeTga6ebxPipXz6BnG5Gdny9IYyIUweym29hUfUpXq
         OiThMdlO9z10aRKzcORl7hhxJySWw+KYiWoUgR2HdCONj7dDqBqF0H0Xj67Lv550mNDs
         Pab0McqcYF6IEw/5HlMR5++A8c2D61th7tEdEFGLlyDm9t+sPpBbhGFzLhTs6ZA+QBpF
         xxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730969641; x=1731574441;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62NebAwLZ0tLPjRJh/RK1QUkF+esVUerAJcHq3e49Ss=;
        b=dS3fmkWvT/T2Rp2z82gNMLcaZwu7DvoAmEX/dpFs9p/w5Wzelf88b6De5cUBx0Pmcv
         niILgC5htMYseswSlOifmJnwt64N9FfZ7RfwmuAXD08zio8LuhteC/xp7UeWdCqtzPIW
         SpIcBzgniv7MiJbMA3Sw0raZbueMcJZFbWC1VQgP6xc2y/q21GizPBjj2fjaQKtE0Nmk
         oZnAlRMhQIXR1CyD2bPyTY6NeWUIOqX3RRsdOgj1fA2HDabz0iXQfOBFc2qD6wtRRPcE
         K8IZjrNcJ0aZPBeLaKuBKH+QQwZRU9dyL7I3xibsLjsMsyP1q5+7uVbKkVqWxNXvfS+f
         HvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf+QyR10ewF3JD1Mp0rPyrdR5GlZNjVkv94dqys6GUPy1yKnOpRfTVJ8Vdwr4gUksZj6bWoSowfVMA0x4y0w==@groups.io
X-Gm-Message-State: AOJu0YyYE82YVi8Dm+wLtmatQ2taA2a/FcUPOBw0DOTbWaLFF7qQf5pL
	HDPKMfpWZ7Cipq86hcUgtJp2+RbJQr6nAqWckik/ntrghPKHLDhAaZOP5jB16CE=
X-Google-Smtp-Source: AGHT+IHBIqidVIVFQZbqwiQ+BAqoIlQ3ALIC3sLzxe+IfgIbyStfR4MUCcKvl1z7RFnIFQT7x5mk5A==
X-Received: by 2002:a05:600c:4f15:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-4319acb104dmr396632535e9.14.1730969640485;
        Thu, 07 Nov 2024 00:54:00 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97cfefsm1107179f8f.26.2024.11.07.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 00:53:59 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dmitry Rokosov <ddrokosov@salutedevices.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>, "Andrew F. Davis"
 <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass
 <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, rockosov@gmail.com, kernel@salutedevices.com,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAPLW+4=qt++B+wD6zvfsoCxgd=Jmygf7w=Wz71p3Z8GUOZS9oQ@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
 <87v7x1soto.fsf@baylibre.com>
 <CAPLW+4=-yPgMeDM5XRkBXR-nD4Ni2VtWqTKxJVVrfdU8g2sG4g@mail.gmail.com>
 <875xp08ysu.fsf@baylibre.com>
 <CAPLW+4=qt++B+wD6zvfsoCxgd=Jmygf7w=Wz71p3Z8GUOZS9oQ@mail.gmail.com>
Date: Thu, 07 Nov 2024 09:53:56 +0100
Message-ID: <87v7wz4e6z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 07 Nov 2024 08:54:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2536

Hi Sam,

On mer., nov. 06, 2024 at 21:17, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Wed, Nov 6, 2024 at 4:02=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Sam,
>>
>> On mar., nov. 05, 2024 at 18:58, Sam Protsenko <semen.protsenko@linaro.o=
rg> wrote:
>>
>> > On Tue, Nov 5, 2024 at 9:06=E2=80=AFAM Mattijs Korpershoek
>> > <mkorpershoek@baylibre.com> wrote:
>> >>
>> >> Hi Sam,
>> >>
>> >
>> > Hey Mattijs,
>> >
>> > [snip]
>> >
>> >> >> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, =
struct disk_partition *part_info,
>> >> >>                  * or the device tree.
>> >> >>                  */
>> >> >>                 memset(slot_suffix, 0, sizeof(slot_suffix));
>> >> >> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
>> >> >> +               slot_suffix[0] =3D '_';
>> >> >> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>> >> >
>> >> > AFAIU, this changes the behavior of two above functions, and
>> >> > consequently of "bcb ab_select" command? If so, just to double chec=
k:
>> >> > were all users of those reworked correspondingly? I can see next
>> >> > occurrences (there may be more):
>> >> >
>> >> > $ grep -sIrHn '"_' boot/bootmeth_android.c
>> >>
>> >> I thought the same when first reviewing the patch.
>> >> Looking a bit closer...
>> >>
>> >> >
>> >> > boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%=
s",
>> >> > priv->slot);
>> >> > boot/bootmeth_android.c:111:    sprintf(partname,
>> >> > VENDOR_BOOT_PART_NAME "_%s", priv->slot);
>> >> > boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->s=
lot);
>> >> > boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->s=
lot);
>> >>
>> >> ... We can see that ab_select_slot() returns an integer
>> >> That integer is used later on to initialize priv->slot:
>> >>
>> >> """
>> >>         priv->slot[0] =3D BOOT_SLOT_NAME(ret);
>> >>         priv->slot[1] =3D '\0';
>> >> """
>> >>
>> >> The change from Dmitry only changes what we **write** to the BCB (into
>> >> the misc partition), not what is returned by ab_select_slot().
>> >>
>> >
>> > Sure. Just wanted to double check that the behavior is not changed in
>> > any related parts, as the commit message doesn't mention that. Btw,
>> > BCB is an interface between the bootloader and AOSP, so if this patch
>> > changes what's being written into BCB, does it affect AOSP part of it
>> > somehow? Especially for already existing devices with particular BCB
>> > data, in case U-Boot gets updated there.
>>
>> Those are valid concerns.
>>
>> Per my understanding, on recent Android versions the slot suffix is not
>> read from BCB, but from the ro.boot.slot_suffix property:
>>
>
> That probably still leaves the possible combination of some devices
> running new U-Boot versions (with this patch applied) together with
> older Android versions. E.g. in case when U-Boot is updated but
> Android isn't, may be especially relevant for some dev boards out
> there.

Yes, you are right. Boards with Android older than 2019 and U-Boot v2025.01+

My experience is that most of the time, it's the bootloader that stays
out of date and the Android that gets updated. But that might not be the
general case.

>
>> """
>>   // Initialize the current_slot from the read-only property. If the pro=
perty
>>   // was not set (from either the command line or the device tree), we c=
an later
>>   // initialize it from the bootloader_control struct.
>
> So even in recent Android versions it's being initialized from BCB in
> case the property is not set.

Nope, the comment is wrong. If look at the lines below you can see that
the function exits early when the property is not set.

So in recent Android versions if the propery is not set, we just fail to in=
itialize.

>
>>   std::string suffix_prop =3D android::base::GetProperty("ro.boot.slot_s=
uffix", "");
>>   if (suffix_prop.empty()) {
>>     LOG(ERROR) << "Slot suffix property is not set";
>>     return false;
>>   }
>>   current_slot_ =3D SlotSuffixToIndex(suffix_prop.c_str());
>> """
>>
>> See:
>> https://cs.android.com/android/platform/superproject/main/+/main:hardwar=
e/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D185;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d;bpv=3D1;bpt=3D1
>>
>> This has been the case since 2019.
>>
>> If we look at earlier implementations of libboot_control (which was in
>> bootable/recovery)
>> https://android-review.googlesource.com/c/platform/bootable/recovery/+/1=
191517
>>
>> So implementations before 2019 that do not have this patch:
>> https://android-review.googlesource.com/c/platform/bootable/recovery/+/1=
111899
>>
>> Will get the slot suffix from the BCB (not from the commandline)
>>
>> For these older implementations, we will go through the following:
>> BootControl::Init()
>>   LoadBootloaderControl(device.c_str(), &boot_ctrl)
>>   android::base::ReadFully(fd.get(), buffer, sizeof(bootloader_control)
>>
>> And struct bootloader_control has:
>>
>> struct bootloader_control {
>>     // NUL terminated active slot suffix.
>>     char slot_suffix[4];
>>
>> And if we look at how the BCB is initialized from userspace in:
>> https://cs.android.com/android/platform/superproject/main/+/main:hardwar=
e/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;l=3D120;drc=
=3D86b8f575059a1799c760ca7012f540a528d68a9d
>>
>> We can see that we copy _a, not a (for example, if slot =3D=3D 0).
>>
>> So I think this is fine.
>>
>> If needed, I can dig more for behaviour on older devices (<2019), let me=
 know!
>>
>
> My point is, if it's possible to introduce this change but keep the
> same old behavior (across both U-Boot and AOSP), it's usually better
> to do that that way. If I'm not missing anything and that's a valid
> concern, maybe a separate patch can be developed on top of the merged
> patch series handling that. Anyways, I don't have enough time to work
> on this right now, so just pointing out what I noticed, if it's useful
> for anybody. I'll let the maintainers decide :)

Yes, thanks a lot for noticing and taking the time to report your valid
concerns :)

>
> Thanks!
>
>> >
>> >> ab_select_slot() still returns an integer which needs to be converted
>> >> via the BOOT_SLOT_NAME() macro.
>> >>
>> >> >
>> >> > $ grep -sIrHn 'slot_suffix _' include/configs/
>> >> > include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${sl=
ot_name};"
>> >> > include/configs/meson64_android.h:65:        "setenv slot_suffix
>> >> > _${current_slot}; " \
>> >>
>> >> Same goes for these 2 examples, we use:
>> >> The "bcb ab_select current_slot" command to store the slot into the
>> >> "current_slot" environment variable.
>> >> Looking at cmd/bcb.c we can see:
>> >>
>> >> """
>> >>         ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
>> >>         if (ret < 0) {
>> >>                 printf("Android boot failed, error %d.\n", ret);
>> >>                 return CMD_RET_FAILURE;
>> >>         }
>> >>
>> >>         /* Android standard slot names are 'a', 'b', ... */
>> >>         slot[0] =3D BOOT_SLOT_NAME(ret);
>> >>         slot[1] =3D '\0';
>> >>         env_set(argv[1], slot);
>> >>         printf("ANDROID: Booting slot: %s\n", slot);
>> >> """
>> >>
>> >> So I think this is fine.
>> >>
>> >
>> > [snip]

