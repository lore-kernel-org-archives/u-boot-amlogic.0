Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00941C5B542
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 14:03:24 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.46748.1724653632255133653
 for <u-boot-amlogic@groups.io>;
 Sun, 25 Aug 2024 23:27:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amarulasolutions.com header.s=google header.b=mWXg4CGD;
 spf=pass (domain: amarulasolutions.com, ip: 209.85.167.41, mailfrom: michael@amarulasolutions.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533496017f8so5274918e87.0
        for <u-boot-amlogic@groups.io>; Sun, 25 Aug 2024 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1724653630; x=1725258430; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O49GULQ1RBuCV3mQEjbflI9CcaxwJjbcRrrTowCZDqA=;
        b=mWXg4CGDKGaC50nf+i3+ekYRKedoxiS6+gFFD6at2KrIShdp4hsBngaKbryT0zbRgD
         EcJmOcy3M+QuB2xUDk6iYgO5LwaKcZjGL8ej4XB5cb/dB7QpAzzmbOxAdRhL9yJsInl5
         QVfwT5q/fafb7xx7L685KzU4dl3LIqjhWaJG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653630; x=1725258430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O49GULQ1RBuCV3mQEjbflI9CcaxwJjbcRrrTowCZDqA=;
        b=Ud8DKcWzSimEBcDS6XYhGlCqPNxGv2jgTV4iUoxeWKKdzj9eWoW+ZqPJX9VB2Ln8I8
         pJpzPUi1r1z7hy694V0i/HrIoeOS2wMpa+Rw1g6DF8VVVB4Ubh4oChv+p2XOpbid0oY8
         Rtbk/Go2UonwXfNtIp+kCl9JTZ7dCkUEh++Y3s7yIkeCTjIQPu8ig98apUhBcscNU48P
         +kc2FqOTsTYiGqHmAZk/tkOaV8LxHIbn2HtwpBD3TujEM9e8varb98p3bNGptSoXQ0HU
         FHbC1WgTPAccHjG9lKIDtkIXIXiaW8xr+TrG+ljMAFVVtlEdIsqoBq9FH0JMLvq3dVp9
         czDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2AgoX+csnohYZoN2fRP+wX8/rYWfR6/jR8qPa57OcC1qONFol2aEuIg0JdJYEu2dJb/zocDhaPo0rI8DT/g==@groups.io
X-Gm-Message-State: AOJu0YxWkG91LAooHjb78ZmJZDzIPL2BHql8hI8W56LuASOHp1gl1Mem
	n8dev6OKlvWAdIssvzDx0y5inoKwkBsr+zbDzXGW3eBMB3Ccx9FyWWmLjNWlYtLADLed+dkVF7W
	7vPzj0U+mu04WIPMpZ3WZpf8YMtz9Vg3aoc3ggw==
X-Google-Smtp-Source: AGHT+IGLZm8cpIXurtfd85+7V/VWH/yGKgxHrxhSBjQ+B0cw3qRJc/GEE2joGgaf9tN7H7F8APZaUm5kWlVaAJMXZtM=
X-Received: by 2002:a05:6512:3351:b0:534:3cdc:dbfe with SMTP id
 2adb3069b0e04-5343cdcddabmr3468345e87.28.1724653629740; Sun, 25 Aug 2024
 23:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com> <20240826060411.3532105-2-avkrasnov@salutedevices.com>
In-Reply-To: <20240826060411.3532105-2-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:26:58 +0200
Message-ID: <CAOf5uw=hQv4WUQuFgw7RsZSQYW1Az0_sUvO=_8kqOFdK945pUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, 
	u-boot-amlogic@groups.io, kernel@sberdevices.ru, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 28 Aug 2024 14:03:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2363

Hi

On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Based on Linux kernel:
> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as=
 a boot device")
>
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v1 -> v2:
>   * Place 'NAND_IS_BOOT_MEDIUM' according its numerical value.
>
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  include/linux/mtd/rawnand.h      | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index c40a0f23d7..ed605b4af5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struc=
t nand_chip *chip, ofnode nod
>         if (ret =3D=3D 16)
>                 chip->options |=3D NAND_BUSWIDTH_16;
>
> +       if (ofnode_read_bool(node, "nand-is-boot-medium"))
> +               chip->options |=3D NAND_IS_BOOT_MEDIUM;
> +
>         if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>                 chip->bbt_options |=3D NAND_BBT_USE_FLASH;
>
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae641..61690e816f 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -248,6 +248,11 @@ enum nand_ecc_algo {
>   * kmap'ed, vmalloc'ed highmem buffers being passed from upper layers
>   */
>  #define NAND_USE_BOUNCE_BUFFER 0x00100000
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this inform=
ation
> + * to select ECC algorithms supported by the boot ROM or similar restric=
tions.
> + */
> +#define NAND_IS_BOOT_MEDIUM    0x00400000
>
>  /* Options set by nand scan */
>  /* bbt has already been read */
> --

I will then backport this from linux kernel
dd6ed5c9890b759ba1b56697b9f3f50e71909e43

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> 2.30.1
>



--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

