Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD4CC30653
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.web11.3435.1719477443882366716
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 01:37:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=dG2QG3s7;
 spf=pass (domain: chromium.org, ip: 209.85.219.42, mailfrom: sjg@chromium.org)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b4fced5999so32108176d6.2
        for <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719477443; x=1720082243; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMc4ljFg7l2S+adb42/qqkZ0lAiGcoiXen99I9SZOAg=;
        b=dG2QG3s7GORoIeDBnf7sX2jyqvpbOPb/Lqz+/ACa9kANLGFvDE8aSA/bbWlQitawWh
         uYLXECrHMK5P2sytoYHGdRif+PomYFobljkqrdoascwiTK/Feln+VZSjNQwyCQHoNLDY
         OcjEBv8QwgAkeHB9/VUnltFeqEv/SXUiju/zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719477443; x=1720082243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMc4ljFg7l2S+adb42/qqkZ0lAiGcoiXen99I9SZOAg=;
        b=nKj3wwhP51YOPSQTOw/lDncdBA4ahDgMyLipnEnXHoU420WjwAtPGsEfX2fpx005Tx
         6M62fyuGY82QTWPOAm7s45CuAm/ZkYZtzBUXwAzUZ26iQ6XGNQWfnRCO62waDTYrfWxc
         X8Nq3Nj5al2SifaX5uZbFTdRcSCoS64RCnBUoAKDtYf5u9F41TI8V+Geu9YDh9FNM0bi
         4Hsx4bPkvp+MxkU053zETMaCpQQExygRiGtS5SZNCZgrYWdS+rjScp3kgKNXylUSMlJH
         F7yy/D+i0lMX3AlH4bgDG0KxmeHt+TtG6HEXneAWbOKHOkRWwJNXR6siJfz4SxNHavUB
         d+vA==
X-Forwarded-Encrypted: i=1; AJvYcCU1DAzB+RE2dMIGSXQL75tJXqHRerb61ghaz7lxjovUICCg7qi0etp2D9EjyAPXKJxowXXfqEJaJ6np7vQv+RsFKlnHzYxKaGQ=
X-Gm-Message-State: AOJu0Yx5pCJk+8RnnrdRswnr4f1RE55nQfZMjGUjPdHlRoJNWlbLh+eR
	slKl/Z0YKC+zN1wo3vFaQ0JDBPQWRd/fCPknh+0fvRF9e44l6nt8H2ROYoWcFkK0p8Qj83Lcwn+
	siDZTE9FDVfU5fBVtBK/K2zdlpWuw3sGtQuFK
X-Google-Smtp-Source: AGHT+IFhGtaZsYu+JsYbMdjHkL2dtU5fQIErE4zdPS5c616U3P2RmZjS4NhZe2IDSecjFCkeWrNkXlWWgx+G8U2nAF0=
X-Received: by 2002:a0c:cb87:0:b0:6b4:fc60:a835 with SMTP id
 6a1803df08f44-6b540cedfb6mr137771266d6.56.1719477442975; Thu, 27 Jun 2024
 01:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de> <20240626235717.272219-2-marex@denx.de>
In-Reply-To: <20240626235717.272219-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:12 +0100
Message-ID: <CAFLszTjb7=x78V7-75Ch11wdJy2CBnuYE1_+11b+mivokCFm=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Dragan Simic <dsimic@manjaro.org>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
	Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Max Krummenacher <max.krummenacher@toradex.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
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
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2347

Hi Marek,


On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
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
> Cc: Kostya Porotchkin <kostap@marvell.com>
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
>  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
>  1 file changed, 19 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index ccc4ef33d83..d52f273042f 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -308,6 +308,11 @@ int regulator_autoset(struct udevice *dev)
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
> @@ -512,56 +517,28 @@ static int regulator_pre_probe(struct udevice *dev)
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
> +       if (ret && ret != -EMEDIUMTYPE && ret != ENOSYS)
>                 return ret;
> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> -            dev;
> -            uclass_next_device(&dev)) {
> -               ret = regulator_autoset(dev);
> -               if (ret == -EMEDIUMTYPE) {
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
> @@ -569,5 +546,6 @@ UCLASS_DRIVER(regulator) = {
>         .name           = "regulator",
>         .post_bind      = regulator_post_bind,
>         .pre_probe      = regulator_pre_probe,
> +       .post_probe     = regulator_post_probe,
>         .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
>  };
> --
> 2.43.0
>

