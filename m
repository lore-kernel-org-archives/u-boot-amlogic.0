Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84998D1A45A
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:52 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.7404.1727909751484330353
 for <u-boot-amlogic@groups.io>;
 Wed, 02 Oct 2024 15:55:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=mu17uDB5;
 spf=pass (domain: chromium.org, ip: 209.85.219.54, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb3d2ce75eso13269056d6.0
        for <u-boot-amlogic@groups.io>; Wed, 02 Oct 2024 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727909750; x=1728514550; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHT05oy9Zb03oLutDMF4gtb1zHH+EywA/Pf5IkPVlZw=;
        b=mu17uDB5YyNKajexG3BOkSOga+oFMQAw3adzacuke2/itec6nT8F2+yY/zxF7UlIHm
         BPg1Z2dYeP7/B2yR0bU9u4JJC0wDgz5QvZDZTWopLcEOGnr8XOqAks+X+MnZwQl5dz4H
         TIHlPT5SCJUPGAgBhcyLsHHKFTGdC7I4uFlJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909750; x=1728514550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHT05oy9Zb03oLutDMF4gtb1zHH+EywA/Pf5IkPVlZw=;
        b=n0u8fZbGXwKzb2aVR6OWv/GU1Q0OAL4ID4Ppog2L4cDf3Vb2EGvjhjoMfJjlPJLrEt
         E1C+7X4UcjwCNpiWNBIhSOSpoetm66ERKcSGcmv+MTDrbPL7qVgP53Z/ZnsZ7uFsLMlN
         CNnrjt7540qXzpvlWWb97cSaFC1CIZp6ejGQOzelBPZCFmJOPCaG79sO3yQa9Fu47E7d
         HkE9xUQln8lCNwVlfr21vhq4qM7leDtePQFf9bKl2od2ubT41W1KsFDH4Ewna3sNs6Dp
         bBC1+3CN6mfcABEV88H3ep5CNhJD/9eVuSUCiVPA4L+T8uOO8Hlu0ZMzFCZZ91Gj4cS2
         v1bA==
X-Forwarded-Encrypted: i=1; AJvYcCWepaaEpzZW5tAmNoDS57NuFtYSt2b5oDvIF/uI90djJS05+V8TPBmv4Q2p1LLbchur071Qh/Z478kqDeunqQ==@groups.io
X-Gm-Message-State: AOJu0Yx0X0TOmnGrPLZxgrojFZLWwuWSMsk8dS9U+uJY1iJ14LDN9wrU
	Tpd3Gk44tdFSem02d786JUHdcCkmeHTbKk0SkljASN23GgtSOV7s0pewkk1QIAwLfQKNITm5T1y
	t8VzlmXEc6bYVZwMtRntWrJoU4AvIjc6lCe6C
X-Google-Smtp-Source: AGHT+IFjuoS7/Zw3tzNvR+meA5geMK78vcwT93kXjxfgxpwBD0lzcVblJiT7llCr4T1Wb+Nyae6rvj4vbgAj1dmj790=
X-Received: by 2002:a05:6214:5a07:b0:6c7:c646:4b7f with SMTP id
 6a1803df08f44-6cb900ad4c5mr19312976d6.3.1727909750523; Wed, 02 Oct 2024
 15:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240926231457.2933914-1-marex@denx.de> <20240926231457.2933914-2-marex@denx.de>
In-Reply-To: <20240926231457.2933914-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:39 -0600
Message-ID: <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Matteo Lisi <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
	Max Krummenacher <max.krummenacher@toradex.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Patrick Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
	u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
	uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:00:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2459

Hi,

On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
>
> Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
> empty functions. Implement matching functionality in regulator_post_probe()
> instead. The regulator_post_probe() is called for all regulators after they
> probe, and regulators that have regulator-always-on or regulator-boot-on DT
> properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
> such regulators in regulator_post_bind().
>
> Finally, fold regulator_unset() functionality into regulator_autoset().
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Max Krummenacher <max.krummenacher@toradex.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Sam Day <me@samcday.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> Cc: u-boot-amlogic@groups.io
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Rebase on current u-boot/next
> V3: No change
> ---
>  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
>  1 file changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 1a970004540..9fcc4bd85b9 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
>                         return ret;
>         }
>
> +       if (uc_pdata->force_off) {
> +               ret = regulator_set_enable(dev, false);
> +               goto out;
> +       }
> +
>         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
>                 ret = -EMEDIUMTYPE;
>                 goto out;
> @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *dev)
>         return 0;
>  }
>
> -int regulators_enable_boot_on(bool verbose)
> +static int regulator_post_probe(struct udevice *dev)
>  {
> -       struct udevice *dev;
> -       struct uclass *uc;
>         int ret;
>
> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> -       if (ret)
> +       ret = regulator_autoset(dev);
> +       if (ret && ret != -EMEDIUMTYPE && ret != -EALREADY && ret != ENOSYS)
>                 return ret;
> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> -            dev;
> -            uclass_next_device(&dev)) {
> -               ret = regulator_autoset(dev);
> -               if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
> -                       ret = 0;
> -                       continue;
> -               }
> -               if (verbose)
> -                       regulator_show(dev, ret);
> -               if (ret == -ENOSYS)
> -                       ret = 0;
> -       }
>
> -       return ret;
> +       if (_DEBUG)
> +               regulator_show(dev, ret);
> +
> +       return 0;
>  }
>
> -int regulators_enable_boot_off(bool verbose)
> +int regulators_enable_boot_on(bool verbose)
>  {
> -       struct udevice *dev;
> -       struct uclass *uc;
> -       int ret;
> -
> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
> -       if (ret)
> -               return ret;
> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> -            dev;
> -            uclass_next_device(&dev)) {
> -               ret = regulator_unset(dev);
> -               if (ret == -EMEDIUMTYPE) {
> -                       ret = 0;
> -                       continue;
> -               }
> -               if (verbose)
> -                       regulator_show(dev, ret);
> -               if (ret == -ENOSYS)
> -                       ret = 0;
> -       }
> +       return 0;
> +}
>
> -       return ret;
> +int regulators_enable_boot_off(bool verbose)
> +{
> +       return 0;
>  }
>
>  UCLASS_DRIVER(regulator) = {
> @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) = {
>         .name           = "regulator",
>         .post_bind      = regulator_post_bind,
>         .pre_probe      = regulator_pre_probe,
> +       .post_probe     = regulator_post_probe,
>         .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
>  };
> --
> 2.45.2
>

I thought I objected to this patch, but it seems to be in -next? Does
anyone know what has happened here?

I am seeing these errors now when running sandbox 'u-boot -D':

       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
       out_set_value() PMIC write failed: -5
       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
       out_set_value() PMIC write failed: -5

Regards,
Simon

