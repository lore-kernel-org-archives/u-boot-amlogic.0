Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B6CCA9ED1
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:17 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29286.1791735402782420264
 for <u-boot-amlogic@groups.io>;
 Sun, 11 Oct 2026 09:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=FZdifUOz;
 spf=pass (domain: chromium.org, ip: 209.85.221.45, mailfrom: sjg@chromium.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso887439f8f.3
        for <u-boot-amlogic@groups.io>; Sun, 11 Oct 2026 09:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791735401; cv=none;
        d=google.com; s=arc-20260327;
        b=Wro4nn68hYyGQSGs1ljSUttJDJlhPTGCkNyuDI+W5P58r+OzV1VUDrJMitK8RW4dKj
         t/qpaAN6sH7f/syb6o7w0pVJc5lVEf9tmYkicBOttQ/kEv+CELI8DWBVjmMiARsvUOHc
         XzDDaFXW0Eiesv3GOpBoyDy+VpdgsRj/1V6ZCsdFsAUEw3NGIeJWfXl1SCb38NP+Ou8U
         PjExuHh6ESFjtVouD4RnWCYSuxuk7iv6j8xo4xVcK6cCOqnh1sy1zmp8yAIxXIUSLgqE
         d7/g1Kv4Or+e9hJiD43ibSH6vohlljP/cqJZtL0ObW5Q1Yxl528pOhP+HYa7OOrZz5/x
         rctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
        fh=E/DvG59yAcvdfe5KvMAnDh3EZaKm0SwcJan8jitcXXU=;
        b=GRrAbCP8BckZ3qAzPVzQSxhJeQpLK85T71oYjt3+JFwNzb8AJwR7/EYO1kNl8bY1A2
         jHHv30FnNjEpGm1cDvkgFSlBchjo546ZyOHRyJDRI7TYMagpDylzr0OCo9zEZzqWO6AR
         UFwNUIPcpp5qXVM6dI7eNnbW5yyFa/Z9xn+8418x2JvxTLhn2q2Nj/L5KhN+KzgM1M2L
         8kWL+bJzQMNSR8HzDsZRYrZ8LKyVAMBfTMZ5LcC1Cw6612ZSrHyVRZcSSyOXPPEI8IUP
         JizVDTQiDjLuZkN82U5Q+bV72Rw3JpJbJ1k7lWecUNPUeXlSACQxhPasLEYiNwHM3Qa1
         snrg==;
        darn=groups.io
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791735401; x=1792340201; darn=groups.io;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
        b=FZdifUOzmI5iYra1Ke9wiB6/gZt1vRVoaBlDz+ip8ZP7Qreu835KsfdycrriXLUlT9
         BGSPjBTQVhG4wLxsvapGm+5ON/cB52ebfJpNdvdEjr/8u6l0uNK5QfENhrn7ji/ZoyUk
         IMQ2fUmJVwWfsT+BQhPnvchRG0pZSKzaZ36+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791735401; x=1792340201;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hVreMmSkMjFsmv7LmF7GpMfl0t+NxjTD7WIVOB+61nA=;
        b=N3rrGmP06uffiJcsHe/vKWzPWf+EbMa/3dXaS3F5MoaYKJyw9Hi7D+JfOo5OtLgQ43
         OMYEKriHF9D7s7jeIU4Km5SNTwI6AJ/zbuk7p+/30IA4f65h6XgWO7mR3hDTcBfMZof6
         MPS9zaDtX/Yht9p/UmLl1TNL3RGg+fO4cEElOByEaz2JypjS1Xt6By78GmBB5RW6pnK/
         AUI31qwDPR3oblEkc5n77jJBh50zisH0KBrx+A6/4XCu6ofEDiRoZm/TYxJT4jSHdT2y
         5rTV19tHBciqSfFXAxStUA4g13QP/kATxbk5OSE/UGWnP7VaDUclgJyrw9g57z6O7TZF
         ufyQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7XrptZJ/dp2HBgQAejpnvT7JeHgaWuh1CWLdMoLs3G/bjspKwAasi6AaxcSwDkyqxV1DnHQE8vK1D5LegPA==@groups.io
X-Gm-Message-State: AFq9FYI6BVkEov9+kZckjPZBzQS/D3UoQWq89ovQBAr3kuGkhG7ECVv9
	OSXzc6SOpssoCNxJVoSdPy1wyYDGmBxtwqNhhtfBKsp9Vawl5oABCh+9H6d3KcwOijprzm//sZh
	uGiCk9nBcMloR8zY87+FRxVzASBxQ4VzWYVNMjraf5ERw/ocWzK1RGTj8
X-Gm-Gg: AYBFou2WOmQrJ21Ri6hbY6GrdUSDYtKkrtq5WAXYi6N8aRcLCcENpcCOkBEm4zg52vD
	kW4rR5oanLryi0g91CV2v+PVmD5viFixvqNPmv2I2j8hJT4kkjnB3ZvQ9+5oCOgCiAnXh10EAAQ
	GLQDfFzAjeNtLmNuQ84oV2ZOe98GCSH8i8IGhak/8JfJ5AiVqwIc4nOC4eu//sMlR3memO1jgU6
	TiOucHNkh51VHCHGQTulgaLxAxDgiOm4LObkJ7hAW9RGnjWubh2Fed4WbSVYXd9+qqAqD43tX8/
	JqlVgSJ4kla+4jPUfkyYo/nLtfv0Mg1c1KoREjXHe4KjlU/BfhyMkawf
X-Received: by 2002:a05:6402:42c8:b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6b17c2cbe9emr6687225a12.28.1791734961892; Sun, 11 Oct 2026
 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
In-Reply-To: <20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 17:09:08 +0100
X-Gm-Features: AclHuK8PV0Cg6OQBF4O0f_6qGkA91uev9ghiZxxyt0EoGUSBSUG0zqbX-vl4pDU
Message-ID: <CAFLszTj7kB=JkLx1ws9QbKX682ZiYyy8LHJywzVq_pZnObbUQw@mail.gmail.com>
Subject: Re: [PATCH] video: use bpp conversion helpers consistently
To: imkyufie@gmail.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org, 
	u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
	Anatolij Gustschin <ag.dev.uboot@gmail.com>, Eugen Hristev <ehristev@kernel.org>, 
	Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Andre Przywara <andre.przywara@arm.com>, 
	Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Oct 2026 09:35:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3127

Hi Reza,

On 2026-10-08T13:51:38, Reza Kurniawan <imkyufie@gmail.com> wrote:
> video: use bpp conversion helpers consistently
>
> Use bpp conversion helpers for consistency and to reduce the
> reliance on the specially crafted VIDEO_BPP* enum values. No
> functional change is made.

Thanks for doing this!

Please can you name the helpers here (VNBYTES() and VNBITS() from
video.h)? It would also help to say that VNBYTES() is only correct for
8bpp and above, and that every site converted here is 16bpp or 32bpp,
which is why there is no functional change.

>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
>
> cmd/bdinfo.c                           | 2 +-
>  drivers/video/atmel_hlcdfb.c           | 2 +-
>  drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
>  drivers/video/meson/meson_vpu.c        | 4 ++--
>  drivers/video/mvebu_lcd.c              | 2 +-
>  drivers/video/sunxi/sunxi_de2.c        | 2 +-
>  drivers/video/tegra/dc.c               | 4 ++--
>  drivers/video/tegra/tegra124/display.c | 2 +-
>  drivers/video/ti/tilcdc.c              | 4 ++--
>  drivers/video/tidss/tidss_drv.c        | 4 ++--
>  test/cmd/bdinfo.c                      | 2 +-
>  11 files changed, 15 insertions(+), 15 deletions(-)

> diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
> @@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
>       uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
> -                             (1 << LCD_MAX_LOG2_BPP) / 8;
> +                             VNBYTES(LCD_MAX_LOG2_BPP);

The subject says 'consistently', but a few sites are not converted.
atmel_fb_lcd_bind() in drivers/video/atmel_lcdfb.c has exactly the
same pattern:

    uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
            (1 << VIDEO_BPP16) / 8;

The others I spotted:

    drivers/video/sunxi/sunxi_de2.c:221  (1 << l2bpp) / 8
(efi_add_memory_map() size)
    boot/fdt_simplefb.c:62               xsize * (1 << bpix) / 8
    drivers/video/video_bmp.c:322        1 << bpix             (VNBITS())

Please can you convert these too, or say in the commit message why
they are left out?

Regards,
Simon

