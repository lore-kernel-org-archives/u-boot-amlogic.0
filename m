Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F786D12674
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 09:43:18 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web10.4716.1730761599612410121
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Nov 2024 15:06:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pctCfhVf;
 spf=pass (domain: linaro.org, ip: 209.85.128.175, mailfrom: semen.protsenko@linaro.org)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea0b25695dso39632507b3.2
        for <u-boot-amlogic@groups.io>; Mon, 04 Nov 2024 15:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730761599; x=1731366399; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uui/o0ZsYS5WVwOp/dS3baegzYPblc+/UJ7XOLxLFrE=;
        b=pctCfhVfhJjGTQB2ZpOxZtVhig67DsUcnM9XIHJNyusxFOGKd7af1XnH/EEgqZQs6Y
         Uk5r/eR33sVJW7IMxangKCq+xrs5uPzHsDxQ9Ghi/kR3UTnN1wde8dK4YcKBVcLCGzTX
         J8RXyZ3pprWRq2WHSpgnR920/zx7qYTDCWoAFutXduCu5iM+Ea1eHlSKPslMlr8h+4PE
         DaJ6N2XiJbyKQlFf0UK+QmHgm85YiDBQbprCfoSR6JHxJ/m4bzuiVttUNe3d+XMT+lqL
         22Oagzdc6FosnBzKHbE4on0dVe2Dkm1onJJdbstXQtSra52xRqrsw41O+ve5TDSkBcvK
         SJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730761599; x=1731366399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uui/o0ZsYS5WVwOp/dS3baegzYPblc+/UJ7XOLxLFrE=;
        b=h5zQyliIHSDktcKwwSNWteGRBg5h1OC6WBFoeUbFxqFzyDavYrAqHNRHIPA3OjVyZE
         jP6hOvsf6yQzTjnyJ+NyssqTMm9xG/3ZBBJhW8EZ2RcHrEEVQ6Ok0XpUi1t6gZd+VGbF
         IkWMUSSr/yWC2jicYpEgWzaNHulxyJH0ME1BkGJM220jVMiKFl5jKbraR8ZtI7cM+WdR
         +kgY+uPGMnkugYyY7JzqAYantuCkuIRUU/2LUXVk2pqyUutnczeigJI+byQFy5rJ17fk
         Z4kPODL8D0rRVofmg1gq0SK4Z/I60MUWXSkl3CYZP3ZvsqHA0FqXIh41TUU4xKc4cikW
         rROw==
X-Forwarded-Encrypted: i=1; AJvYcCXSRlMI7AzJhfy1lgkkO+WkWBsl+TGjITxzeV83wz712hzccYNaMnfCJiG6trjf/qWWlSZWV2NDfZB0OCT0LQ==@groups.io
X-Gm-Message-State: AOJu0Yxm8FmOIziO6lUTbdqUi37iazpvvVg+DNGA3ZRd5ualMmJtOZqv
	Kb8j1F8Pcv20J0Q+39GBPBWB7EF8DoJer7LlQHbeJyn4qbk87sG/qlF3fCie1bDD23ZN4Fe6Ogc
	GS8Zxf5ZU4Q7XbDJJ6QhZJC2gSAtFifO4ruQVqA==
X-Google-Smtp-Source: AGHT+IH1qy24gizr5lfA9Ah/no+7F4niJ4Ykm91JKYFlIgZ+6ZZzjhA/Jf0QNoJJiunbcgZXN/ZRxHKAs+ls0vKQEMA=
X-Received: by 2002:a05:690c:9a8c:b0:6ea:7198:fb64 with SMTP id
 00721157ae682-6ea7198fd57mr86239957b3.41.1730761598706; Mon, 04 Nov 2024
 15:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com> <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
In-Reply-To: <20241017-android_ab_master-v5-6-43bfcc096d95@salutedevices.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 4 Nov 2024 17:06:28 -0600
Message-ID: <CAPLW+4msra4=oUDCSWx8sfM7uCGgfmJbRi++Q=wf8cQ-ERoHGw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] common: android_ab: fix slot suffix for abc block
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
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
 <u-boot-amlogic@groups.io>; Tue, 05 Nov 2024 09:43:18 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2532

On Thu, Oct 17, 2024 at 9:12=E2=80=AFAM Dmitry Rokosov
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

Would be nice to add "Fixes:" tag here, pointing to the corresponding
commit where the issue was introduced (see kernel docs for details).
It could be quite useful for possible stable branches and other
purposes, I'd recommend to add that tag for all fixes if you have more
in this series.

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

AFAIU, this changes the behavior of two above functions, and
consequently of "bcb ab_select" command? If so, just to double check:
were all users of those reworked correspondingly? I can see next
occurrences (there may be more):

$ grep -sIrHn '"_' boot/bootmeth_android.c

boot/bootmeth_android.c:74:    sprintf(partname, BOOT_PART_NAME "_%s",
priv->slot);
boot/bootmeth_android.c:111:    sprintf(partname,
VENDOR_BOOT_PART_NAME "_%s", priv->slot);
boot/bootmeth_android.c:156:    sprintf(slot_suffix, "_%s", priv->slot);
boot/bootmeth_android.c:397:    sprintf(slot_suffix, "_%s", priv->slot);

$ grep -sIrHn 'slot_suffix _' include/configs/
include/configs/ti_omap5_common.h:107:    "setenv slot_suffix _${slot_name}=
;"
include/configs/meson64_android.h:65:        "setenv slot_suffix
_${current_slot}; " \

>                 if (memcmp(abc->slot_suffix, slot_suffix,
>                            sizeof(slot_suffix))) {
>                         memcpy(abc->slot_suffix, slot_suffix,
>
> --
> 2.43.0
>

