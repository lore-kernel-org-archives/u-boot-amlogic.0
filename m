Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4B1C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.3434.1719477442014013254
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 01:37:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@chromium.org header.s=google header.b=dM3FTEqN;
 spf=pass (domain: chromium.org, ip: 209.85.222.173, mailfrom: sjg@chromium.org)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c054b65d4so151177885a.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719477441; x=1720082241; darn=groups.io;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Drsax0+dXEStDCtvGER0XXppogmnc1mTb7HjV3GTpI=;
        b=dM3FTEqNRrp+IDl6PQkm4INDhviT8Duo0v/PSO4dHw2ZhGrytj+10WgvMbd7xDJD2k
         DKnyyNb2DD/uqHizQyuBlJToCOLTfvrXwR+KwN4g86n5BKA+odRs+TwCkwBjbrXiM/4a
         XcQ85fPM+b/Knaj+BddDiCSwD6REHdHN7VGFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719477441; x=1720082241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Drsax0+dXEStDCtvGER0XXppogmnc1mTb7HjV3GTpI=;
        b=OnSHLBbuUHuWSh/igNKjmLce/0Xvm0QcGe3BoG8KPpZLiw6CrvSc4I4Qu6oVs4t5ir
         p/QggF69DmkJRDzwObTsBJyoL/oU2V/R7RqEH6QLePqWK3xG9Iuy/MnJZsEIWxjS1uAk
         Bs5sSglv9BJW3lcb8q5kNuN2pql44EAetEgCezrwGj6XzLXWJA6A7TEb0VppMUtJm9j3
         lduLGkKLHb/hwLuEQQ5/U8NI4MpcAtYUDOvA7AQbmYN6Uwrv7pXW8t+eCv7VwVteFLa9
         UBq1tUnQ+3VBNl5czVdw3A0Bg4tH5rH+N3flpSPVW/ZrDcc/7OS4fdB2ncE5shiz0gqo
         Hjnw==
X-Forwarded-Encrypted: i=1; AJvYcCUMreyTlrrR8WuyoKsuXny/3i4TmCNq/Y06sgpFxMti9tLCcOMj1vj4rMSIoMXHNcSNBdOYhg1I1/1/9H1GkwriQr5tJV9Y7nE=
X-Gm-Message-State: AOJu0YzzZ7Pjkyn8ILS6dcgBvDGxncy6+aMQ1ZZEjnfH1ibVHEPwVEgz
	I8BckK5ppml1gsZlNO4qbvf7NUIP/9gGysOVH6IDp/1NihljBc5jDR4+pbUJS2qqLfdghgbCu0A
	Yc8J7GVEbpUn+lxAZxGFIG2iAqLWo4S16fmLX
X-Google-Smtp-Source: AGHT+IGxdtL7Rroo0sFI11mpUZ72HuIEcxMYc5mTwDbHV/ylp+hOvCtvlxZ9tIns2pZk0WDsq2X5RlsVPhlwN1EehHk=
X-Received: by 2002:a0c:f94d:0:b0:6b2:b2a3:67ce with SMTP id
 6a1803df08f44-6b582745041mr35980076d6.51.1719477441110; Thu, 27 Jun 2024
 01:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
In-Reply-To: <20240626235717.272219-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:10 +0100
Message-ID: <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
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
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2346

Hi Marek,

On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
>
> In case a regulator DT node contains regulator-always-on or regulator-boot-on
> property, make sure the regulator gets correctly configured by U-Boot on start
> up. Unconditionally probe such regulator drivers. This is a preparatory patch
> for introduction of .regulator_post_probe() which would trigger the regulator
> configuration.
>
> Parsing of regulator-always-on and regulator-boot-on DT property has been
> moved to regulator_post_bind() as the information is required early, the
> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
> slowing down the boot process.
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
>  drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 66fd531da04..ccc4ef33d83 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
>         const char *property = "regulator-name";
>
>         uc_pdata = dev_get_uclass_plat(dev);
> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>
>         /* Regulator's mandatory constraint */
>         uc_pdata->name = dev_read_string(dev, property);
> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
>                         return -EINVAL;
>         }
>
> -       if (regulator_name_is_unique(dev, uc_pdata->name))
> -               return 0;
> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> +                     property, dev->name, uc_pdata->name);
> +               return -EINVAL;
> +       }
>
> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> -             property, dev->name, uc_pdata->name);
> +       /*
> +        * In case the regulator has regulator-always-on or
> +        * regulator-boot-on DT property, trigger probe() to
> +        * configure its default state during startup.
> +        */
> +       if (uc_pdata->always_on && uc_pdata->boot_on)
> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>
> -       return -EINVAL;
> +       return 0;
>  }
>
>  static int regulator_pre_probe(struct udevice *dev)
> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>                                                 -ENODATA);
>         uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
>                                                 -ENODATA);
> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>         uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
>                                                     0);
>         uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
> --
> 2.43.0
>

This is reading a lot of DT stuff very early, which may be slow. It is
also reading from the DT in the bind() step which we sometimes have to
do, but try to avoid.

Also this seems to happen in SPL and again pre-reloc and again in
U-Boot post-reloc?

Should we have a step in the init sequence where we set up the
regulators, by calling regulators_enable_boot_on() ?

Regards,
Simon

