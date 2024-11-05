Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2424D2C120
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 15:06:12 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web11.20376.1730819162277493182
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Nov 2024 07:06:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=IGJRcjMk;
 spf=pass (domain: baylibre.com, ip: 209.85.208.182, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so52676491fa.0
        for <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 07:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730819160; x=1731423960; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HZpd1bzSJHQl4obdcwxMK9nPRyH24ygPbUV/B51BdE=;
        b=IGJRcjMkJ/sogTSlSNRDh8aH9+Zk+so3QLXbTIqKwAIpP2iHC6rwxHmWX0rsDns7kL
         iNKKwZKsjl4FWj8fAuFp+VHcjOlgJ+9LxoU6xBhAKb78atdgv8iYxTdwtsZHAKdhbp1h
         xeulv+x9bkEKpa7EX1D3+UIwAS/T1Ed54PByXVYILpigWDrv0cEZ808Hx6H7mO3xVHUN
         /WO9hAtmgXW8RhK90FMwLMTh18TKJ38EQAFuDPKoj5/Ab/Xazww7kwtHLd8lLi+Dwjfs
         YP9SjWyMDQJ102llScD6iDBEx/qjAWBAqacifcTtuqlYsYcwh7X3sWDTb9mwTUwLvYDi
         i2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730819160; x=1731423960;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HZpd1bzSJHQl4obdcwxMK9nPRyH24ygPbUV/B51BdE=;
        b=APEmZnTcZMHO44rv7S4JKr9NY+ioqlRaM/SOdEiitp6PoTG9Vk/yXJlitr3tsTL7Fk
         2xsuF+XW2DuDWdS0AS/gyJp/A4WHheBHd2g2sfThmYs2E3L2ldbXDGn9kBVVZBZc4HSR
         uXw7Wl3d253UJtK1LBPVtcrCNly0smYa1eqUStKBT/m/3mEZOmdQmzItQwQ6WL+OkVWX
         DvWuDHB7KcUT5wgALaF7pGyjT5sMBjwT4ZxKTU894srcL8uxa886YiwOQJPfb3AkfDZB
         RmJ1noQIgsmRCa6anJg42SxYfxunMzoAjV12xZWDEKpNUHngmUaDxs2DnG5OhlqRdSSI
         pZgg==
X-Forwarded-Encrypted: i=1; AJvYcCWxU1VY0dzkOeL9EoQd0aA6U6u64CjdCyi7EgLkWoo7TuZ4V+AhgKgduDsej5V+gxXFWqF4MKqBfpXmcQ+i1Q==@groups.io
X-Gm-Message-State: AOJu0YzANFLb2Q5AvRNgGPg77YoKcfANq2pH/FgmzOSNfE9D+vLBDFsD
	UeyVfjbQkFbRWrvKDWn6f1tZ+2nkDIF0HyZ6xt2pCDsHQZDA5AxZVn3X29ndLs4=
X-Google-Smtp-Source: AGHT+IGbr1ZM4n3t3aQV+gGUJLoodSaD42NTzRYOr3OZ06TEkbtMaoffHf7d3J8pMo3zal5rZmHHKA==
X-Received: by 2002:a2e:e11:0:b0:2fb:62ad:89fe with SMTP id 38308e7fff4ca-2fcbdfbb311mr134294621fa.16.1730819158774;
        Tue, 05 Nov 2024 07:05:58 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9faesm221127695e9.35.2024.11.05.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:05:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 rockosov@gmail.com, kernel@salutedevices.com, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
Date: Tue, 05 Nov 2024 16:05:55 +0100
Message-ID: <87v7x1soto.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 15:06:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2534

Hi Sam,

Thank you for the review.

On lun., nov. 04, 2024 at 17:06, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Thu, Oct 17, 2024 at 9:12=E2=80=AFAM Dmitry Rokosov
> <ddrokosov@salutedevices.com> wrote:
>>
>> To align with the official Android BCB (Bootloader Control Block)
>> specifications, it's important to note that the slot_suffix should start
>> with an underscore symbol.
>>
>> For a comprehensive understanding of the expected slot_suffix format in
>> userspace, please refer to the provided reference [1].
>>
>> Links:
>> [1] - https://source.android.com/docs/core/architecture/bootloader/updat=
ing#slots
>>
>> Based-on: https://android-review.googlesource.com/c/platform/external/u-=
boot/+/1446439
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>
> Would be nice to add "Fixes:" tag here, pointing to the corresponding
> commit where the issue was introduced (see kernel docs for details).
> It could be quite useful for possible stable branches and other
> purposes, I'd recommend to add that tag for all fixes if you have more
> in this series.

I agree. Unfortunately, this series has already been merged here:

https://lore.kernel.org/r/all/20241025175409.GB4959@bill-the-cat/

>
>> ---
>>  boot/android_ab.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> index c93e51541019d0fe793303c4b3d5286df061906f..a287eac04fe88ad08bdcf1b1=
b1d6e564d503d800 100644
>> --- a/boot/android_ab.c
>> +++ b/boot/android_ab.c
>> @@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_contro=
l *abc)
>>         if (!abc)
>>                 return -EFAULT;
>>
>> -       memcpy(abc->slot_suffix, "a\0\0\0", 4);
>> +       memcpy(abc->slot_suffix, "_a\0\0", 4);
>>         abc->magic =3D BOOT_CTRL_MAGIC;
>>         abc->version =3D BOOT_CTRL_VERSION;
>>         abc->nb_slot =3D NUM_SLOTS;
>> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct=
 disk_partition *part_info,
>>                  * or the device tree.
>>                  */
>>                 memset(slot_suffix, 0, sizeof(slot_suffix));
>> -               slot_suffix[0] =3D BOOT_SLOT_NAME(slot);
>> +               slot_suffix[0] =3D '_';
>> +               slot_suffix[1] =3D BOOT_SLOT_NAME(slot);
>
> AFAIU, this changes the behavior of two above functions, and
> consequently of "bcb ab_select" command? If so, just to double check:
> were all users of those reworked correspondingly? I can see next
> occurrences (there may be more):
>
> $ grep -sIrHn '"_' boot/bootmeth_android.c

I thought the same when first reviewing the patch.
Looking a bit closer...

>
> boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
> priv->slot);
> boot/bootmeth_android.c:111:    sprintf(partname,
> VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot);
> boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot);

... We can see that ab_select_slot() returns an integer
That integer is used later on to initialize priv->slot:

"""
	priv->slot[0] =3D BOOT_SLOT_NAME(ret);
	priv->slot[1] =3D '\0';
"""

The change from Dmitry only changes what we **write** to the BCB (into
the misc partition), not what is returned by ab_select_slot().

ab_select_slot() still returns an integer which needs to be converted
via the BOOT_SLOT_NAME() macro.

>
> $ grep -sIrHn 'slot_suffix _' include/configs/
> include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_nam=
e};"
> include/configs/meson64_android.h:65:        "setenv slot_suffix
> _${current_slot}; " \

Same goes for these 2 examples, we use:
The "bcb ab_select current_slot" command to store the slot into the
"current_slot" environment variable.
Looking at cmd/bcb.c we can see:

"""
	ret =3D ab_select_slot(dev_desc, &part_info, dec_tries);
	if (ret < 0) {
		printf("Android boot failed, error %d.\n", ret);
		return CMD_RET_FAILURE;
	}

	/* Android standard slot names are 'a', 'b', ... */
	slot[0] =3D BOOT_SLOT_NAME(ret);
	slot[1] =3D '\0';
	env_set(argv[1], slot);
	printf("ANDROID: Booting slot: %s\n", slot);
"""

So I think this is fine.

>
>>                 if (memcmp(abc->slot_suffix, slot_suffix,
>>                            sizeof(slot_suffix))) {
>>                         memcpy(abc->slot_suffix, slot_suffix,
>>
>> --
>> 2.43.0
>>

