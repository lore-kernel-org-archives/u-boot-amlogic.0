Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00757D2C11B
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 14:54:32 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.20016.1730818468096505402
 for <u-boot-amlogic@groups.io>;
 Tue, 05 Nov 2024 06:54:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=CyvORAPq;
 spf=pass (domain: baylibre.com, ip: 209.85.221.41, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d447de11dso4312246f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730818466; x=1731423266; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjK3CpCzjOKZWgXNLqIPZYNp3SDYBLyEBuadA8pHxTw=;
        b=CyvORAPqrvMxaIaGKGnjiwqVbUV9YYybdmWRM06ySP/iTxxQYVru5Z1KOMjm7k9Gmj
         fUYWJc1GJXvd72X8ch4N5kkENqhsQSF7Y3RoBAQMS7cG9eGu+nJtihlbveZu4mV7UVFs
         P1bKRP2a3C1NH9L+o5cnScWc7MQNZkW9xQIEBGFQJSbNSZ6rvmjWaY9PaXhO14hUjiIy
         HlDZ/TUN7EAscOsRgp5mF0gl6pBgn2/F9WmBpuW0v5A07k4GacGP0vIdHAb6dPaK5aGj
         YU1b/OLPr29BT8Cl8u4aVtYqpRirw8viqCmHr7lNXaFsW8BkjcODXZQcMc5DzqtZusif
         xaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730818466; x=1731423266;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjK3CpCzjOKZWgXNLqIPZYNp3SDYBLyEBuadA8pHxTw=;
        b=S7HfFN+//q24vd1kJIW7Wekl3hDPvstTSoa8JcSCk3jbPWSQsHQKV+BD1dARQeu5Ug
         +OwxBLQPoAVXwxNYvRSwXMv8Lt47m9itgXG0/S6m+adgs8xUjvJkKYmdQVIcKxWRKMIt
         GBF9Ipen9Bs110hhIHVCoshXH2dtHjkrlwxyPGCUctwjmN/KuhrPlEQMas8D0sFM2o8D
         yiyl2M6ZIzGXNQNPejLw1wkF14bJwRi0ld0wKWzl5uNieuS0wH6ho55cAL8kp2BPpa9x
         1dSvFID9KWZAZej0ZOx0ZljI6JWTo68bfjkxfzfhiGKC/K4cfWQBvQm5I7DIcWpuzMFb
         I6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUD5j3Efoz9rOiL284w58mUdSbD6Fy1QZ1TSJic8YmS9Ip0b8I8laMq20h2IGciODU8OhehD9ucjSqUqk04Sw==@groups.io
X-Gm-Message-State: AOJu0YxvQ0bqSe6iM1upRr4IMnPHaWT9WJxzqsnAjDzmqft2dkbFDi1Y
	ZajsHRMbdasg0c3ETIeYyt2Ccm2MytWJgyTg9ZEcDtdhy2zfeaZDnh/6cg4B+bk=
X-Google-Smtp-Source: AGHT+IFFqfpRQKWdmeOWfkxfBjFjCMoTc6tZFPby43e/OhNMIQJhTECfZSRD3hiSG9io7SKbRe1WCg==
X-Received: by 2002:a05:6000:1fac:b0:37d:498a:a237 with SMTP id ffacd0b85a97d-381be7adfc7mr15214092f8f.8.1730818465996;
        Tue, 05 Nov 2024 06:54:25 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c08sm16452466f8f.17.2024.11.05.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:54:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
 <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 rockosov@gmail.com, kernel@salutedevices.com, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
In-Reply-To: <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com>
 <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
 <CAByghJb+ObC4jQ4B71Bf-eUKhyYcAY1inj=7LSa+qG1t-RBO+Q@mail.gmail.com>
Date: Tue, 05 Nov 2024 15:54:22 +0100
Message-ID: <87y11xspcx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 14:54:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2533

Hi Igor,

Thank you for the review.

On dim., nov. 03, 2024 at 10:43, Igor Opaniuk <igor.opaniuk@gmail.com> wrot=
e:

> Hi Dmitry,
>
> On Thu, Oct 17, 2024 at 4:12=E2=80=AFPM Dmitry Rokosov
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
>>                 if (memcmp(abc->slot_suffix, slot_suffix,
>>                            sizeof(slot_suffix))) {
>>                         memcpy(abc->slot_suffix, slot_suffix,
>>
>> --
>> 2.43.0
>>
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Sorry, I can't apply that R-b tag because this series has been merged
into master already:

https://lore.kernel.org/r/all/20241025175409.GB4959@bill-the-cat/

> --=20
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk

