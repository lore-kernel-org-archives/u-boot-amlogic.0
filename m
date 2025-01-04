Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77404C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 08:55:50 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.25048.1736019085280794338
 for <u-boot-amlogic@groups.io>;
 Sat, 04 Jan 2025 11:31:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=CPVGgoq8;
 spf=pass (domain: chromium.org, ip: 209.85.208.52, mailfrom: sjg@chromium.org)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so22815426a12.1
        for <u-boot-amlogic@groups.io>; Sat, 04 Jan 2025 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736019084; x=1736623884; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyEqcxvEbGQr70b1wCPO/zABvUUtUC4T1WHSoiVGpWw=;
        b=CPVGgoq8aPnbRGZRUMGUl7/iSEmzsMxrCc1OLEqlvLFX4lmE0wzHBLnkhLkK5qfkQ6
         G9neTmWl40lkdwy2Fxu6UXCT0kQ9Qo+ppgAaXGQOEZBnc5jQkov4nzLSTzviaxA8egvr
         6AhugZPxrA+ky7WEyGNB4TE3A1FP9LVVBn9Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736019084; x=1736623884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyEqcxvEbGQr70b1wCPO/zABvUUtUC4T1WHSoiVGpWw=;
        b=msPQ4UAm7Cj9qPuSnfWUh4IXTLSgwNUiF3jK4JvUUcAYOeDDcr5ntrMB7T7Wxjsgpk
         YHi3WwIrPRwcOSDo+w3WT/7Zqlhb/Olm1s1Xc4WIpf21D+gAyyCY/3pfggMn3cUWdhuM
         rREGrVj37qeBTLekwOYvbFaUtX57hybSi3nUik3Y0aef/FFpjgiJG2ZE5TOk9Nqmh/qV
         baQNgq4hK2giaqTytKgeJgpmKjCpDw+eViI6uEc/ZwFnJvb7xkR0E5bPi4ARPx+I+PIF
         OXxYcUfsV6kbSJTGEkSQwtAWnMrotmoQT32mPSILqtfjChM7hm24QcYftI/s4TOgBtWg
         lU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ4Pem3qlpoPjdS8c5aP+NXpV4j4GfqkXj3dk9rT8IyZ7yQW/BKPnVXYtIE0nCCC/msPaXALr8sOr3WJZKA==@groups.io
X-Gm-Message-State: AOJu0YxBPH+Frp4pPHejFVyq06CQ6GHBeg+ReuWbV6wpUyKziKzFlz3p
	lkygB7dyeBe+N200AM0LXbzO7x3ly2I9AOiu6n4dPT1QGO0wiIXnOOPcHBXFh0XpiuoTFL7/tBM
	cJAPH7iXZkBjaHg7LKb4txjgDhNBRuiWNgSsPtNvtiPfEaXg=
X-Gm-Gg: ASbGncveoVBBpbuEePzsFPLUBNCU8r7jBDWJ/wlc+0tJYlg6CjOC7HC2Qir6X0m8fDR
	KsrfwKP0qAUOa/+6igWTeAV1oZ9AjXHnHpB/ldTzE
X-Google-Smtp-Source: AGHT+IFy0wBxb2lL9mRQByHiahl5wN1CWt1TGjqVjYzpRISSJ0VtagfohI/4wfeUj1wHFGbPvfz7p0Lt6ys1GknqJLw=
X-Received: by 2002:a17:907:60d0:b0:aab:933c:4125 with SMTP id
 a640c23a62f3a-aac2702afb5mr5185301666b.10.1736019083586; Sat, 04 Jan 2025
 11:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20250103215904.2590769-1-jonas@kwiboo.se> <20250103215904.2590769-3-jonas@kwiboo.se>
In-Reply-To: <20250103215904.2590769-3-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:31:16 +1300
Message-ID: <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
	Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot-amlogic@groups.io, 
	u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 08:55:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2603

Hi Jonas,

On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
> and SD-card.
>
> Vendor BL2 have solved the issue with different offsets by considering
> where BL2 was loaded from to adjust the offset where BL3 is read from.
>
> This provide a different solution to create a boot image that can be
> booted from both eMMC and SD-card and where the offset for reading next
> stage loader can be shared for both boot options.
>
> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
> to the expected offset of 0x1000, into the padding area at offset 0x200
> when a normal GXBB boot image is created. A special GXBB eMMC header can
> then be created that have the payload offset point to this relocate
> code, BL1 will jump to this relocate code when booted from eMMC instead
> of the normal payload start. One effect of this is that the payload size
> limit must be reduced by 512 bytes on GXBB.
>
> Example of how to use it:
>   # Create a normal boot image
>   tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
>
>   # Create a boot image with a special eMMC header
>   tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
>
>   # Write normal boot image to sector 1 of eMMC/SD-card
>   dd if=bl2.bin of=/path/to/dev bs=512 seek=1
>
>   # Write eMMC header, 112 bytes, to start of eMMC
>   dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
>
> Or with binman using something like:
>   binman {
>         multiple-images;
>
>         u-boot-gxbb-sd {
>                 filename = "u-boot-gxbb-sd.bin";
>                 pad-byte = <0xff>;
>
>                 mkimage {
>                         filename = "bl2.bin";
>                         args = "-n", "gxbb", "-T", "amlimage";
>
>                         u-boot-spl {
>                         };
>                 };
>         };
>
>         u-boot-gxbb-emmc {
>                 filename = "u-boot-gxbb-emmc.bin";
>                 pad-byte = <0xff>;
>
>                 mkimage {
>                         filename = "bl2-emmc.bin";
>                         args = "-n", "emmc", "-T", "amlimage";
>
>                         blob-ext {
>                                 filename = "bl2.bin";
>                         }
>                 };
>         };
>   };
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>  tools/amlimage.c               | 37 ++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 tools/amlimage-gxbb-relocate.c
>

I sent [1] some years ago and would quite like to enable the odroid-c2
in my lab. Is that an older version of what you are supporting here?

I heard that there are people working on open source tools, but it has
been a few years and I'd be quite OK to just use vendor tools.

For your docs, could you put them in doc/ instead?

[..]

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699821-8-sjg@chromium.org/

