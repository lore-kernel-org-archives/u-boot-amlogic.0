Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451FC3DA40
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.3793.1719479399673019314
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 02:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fddV9LU6;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: clamor95@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fe617966fso521763066b.1;
        Thu, 27 Jun 2024 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719479398; x=1720084198; darn=groups.io;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BT/AxhHsjewpcb7QDDDof9jr1tiiKF8MnOwNAwI5wVE=;
        b=fddV9LU67vN/3IXElsWfSbeTue5rL4i+ElTeefWx+84Ug7wptK/Ffnmm73ExiNj5Db
         kms7aZIiEPq68w/WrZmx7S+a7yGKNiQgjCcHHiH/I7zKMvvkLwNPXF8+oFCyH7knUnSC
         u+800I6ICLEQ7pHlWmasdkbwyxjiDJxSgM0DvHp3eVl1i7jBG2zFmzC3bwzXFDHIMF20
         tSQkciVuCnbiMqBsONUHw8K43sHzx+6tLgwI4BlnJLoSRHpKQrFKJmzVCO1dwlscgN7b
         p/cKZGrNj5TVZa0/m17Gm2Y3XAdh6wLrSdbJZ6yvZLAw42VO/GQMy4xAwZKGMc8jSPe6
         Hcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719479398; x=1720084198;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BT/AxhHsjewpcb7QDDDof9jr1tiiKF8MnOwNAwI5wVE=;
        b=NIeE4TpkbofP2W5A0qdw7Ahid96yFEvlMhB8wSWgbg2s7KlOLMHsVIIRrw6UtHbEN5
         cydj50t/spV3DCyDzqKtIVa1hpu3I2YwII2YHMx+B+wu73cmC4/45UaWnNHEENCtfJ5y
         AAfQa1g/gKKQfZyYafgKMofBccWmb4tWFQBRA6G6xzetRuKH0x+pjGw/eFIwM39DJXZJ
         EntM9blyGqtuWcLbVeZ9VUs7yld1/7yhLubw4cY+E9mIs+WjyxuZ7MnDorrta5PkvCV2
         3uB//w9hxwSKdIG6D6scBlY5/PCTovZnGleLTbi40ODm1Zl4dQZ1GXNS1Q03J1fReFkp
         n5QA==
X-Forwarded-Encrypted: i=1; AJvYcCUveuOexX4oAcwwmdu7ku6SQ5B74SuvMZS8qTes3QScZG4NscMj7AS9ZwEdFP77BswL2jWxLMLxU4zmzzb4h5hs+E1TeGszSalZj4VxlxQy79KBAhGSBu+8MTpfkoblpg==
X-Gm-Message-State: AOJu0YxoBjKQWyvn19kRmsb/FSJvwUB+ik+pOlKsoo3feuq7kNE7X/Xx
	J1kDC0stKCZLbpLCHeWBKoqlam8W9DhqPn0TzoWsVne1vIuURFwt
X-Google-Smtp-Source: AGHT+IELyBNOR6adIzlaOfamfQf2QvDbvuBDUAvJa/9xJCICVQOGF/hkvPmvx6s6mKbCx9k7oiR+dw==
X-Received: by 2002:a17:906:81b:b0:a6f:cf64:a5d9 with SMTP id a640c23a62f3a-a7245c483a1mr737939266b.49.1719479397849;
        Thu, 27 Jun 2024 02:09:57 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.174.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d779515sm39317066b.107.2024.06.27.02.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 02:09:57 -0700 (PDT)
Date: Thu, 27 Jun 2024 12:08:54 +0300
From: Svyatoslav <clamor95@gmail.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
CC: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
User-Agent: K-9 Mail for Android
In-Reply-To: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
References: <20240626235717.272219-1-marex@denx.de> <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com> <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
Message-ID: <96AEFD59-B8D3-4298-8867-E94D474E16BE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2343



27 =D1=87=D0=B5=D1=80=D0=B2=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 11:48:46 GMT+0=
3:00, Caleb Connolly <caleb.connolly@linaro.org> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>
>
>On 27/06/2024 10:37, Simon Glass wrote:
>> Hi Marek,
>>=20
>> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
>>>=20
>>> In case a regulator DT node contains regulator-always-on or regulator-b=
oot-on
>>> property, make sure the regulator gets correctly configured by U-Boot o=
n start
>>> up. Unconditionally probe such regulator drivers. This is a preparatory=
 patch
>>> for introduction of .regulator_post_probe() which would trigger the reg=
ulator
>>> configuration.
>>>=20
>>> Parsing of regulator-always-on and regulator-boot-on DT property has be=
en
>>> moved to regulator_post_bind() as the information is required early, th=
e
>>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>>> slowing down the boot process.
>>>=20
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
>>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>>> Cc: Chris Morgan <macromorgan@hotmail.com>
>>> Cc: Dragan Simic <dsimic@manjaro.org>
>>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>> Cc: Jonas Karlman <jonas@kwiboo.se>
>>> Cc: Kever Yang <kever.yang@rock-chips.com>
>>> Cc: Kostya Porotchkin <kostap@marvell.com>
>>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>> Cc: Sam Day <me@samcday.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Sumit Garg <sumit.garg@linaro.org>
>>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>>> Cc: Thierry Reding <treding@nvidia.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
>>> Cc: u-boot-amlogic@groups.io
>>> Cc: u-boot-qcom@groups.io
>>> Cc: u-boot@dh-electronics.com
>>> Cc: u-boot@lists.denx.de
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++------=
-
>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power=
/regulator/regulator-uclass.c
>>> index 66fd531da04..ccc4ef33d83 100644
>>> --- a/drivers/power/regulator/regulator-uclass.c
>>> +++ b/drivers/power/regulator/regulator-uclass.c
>>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
>>>          const char *property =3D "regulator-name";
>>>=20
>>>          uc_pdata =3D dev_get_uclass_plat(dev);
>>> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on=
");
>>> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>>>=20
>>>          /* Regulator's mandatory constraint */
>>>          uc_pdata->name =3D dev_read_string(dev, property);
>>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *de=
v)
>>>                          return -EINVAL;
>>>          }
>>>=20
>>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
>>> -               return 0;
>>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
>>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>>> +                     property, dev->name, uc_pdata->name);
>>> +               return -EINVAL;
>>> +       }
>>>=20
>>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>>> -             property, dev->name, uc_pdata->name);
>>> +       /*
>>> +        * In case the regulator has regulator-always-on or
>>> +        * regulator-boot-on DT property, trigger probe() to
>>> +        * configure its default state during startup.
>>> +        */
>>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
>>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>>=20
>>> -       return -EINVAL;
>>> +       return 0;
>>>   }
>>>=20
>>>   static int regulator_pre_probe(struct udevice *dev)
>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>>>                                                  -ENODATA);
>>>          uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-max-=
microamp",
>>>                                                  -ENODATA);
>>> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on=
");
>>> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>>>          uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regulator-=
ramp-delay",
>>>                                                      0);
>>>          uc_pdata->force_off =3D dev_read_bool(dev, "regulator-force-bo=
ot-off");
>>> --
>>> 2.43.0
>>>=20
>>=20
>> This is reading a lot of DT stuff very early, which may be slow. It is
>> also reading from the DT in the bind() step which we sometimes have to
>> do, but try to avoid.
>
>Could we set up the livetree pre-bind? What about MMU? On armv8 at least t=
his would have a huge impact on performance. I've done some measurements an=
d there is at least 1 order of magnitude difference between parsing FDT wit=
h no caches vs parsing livetree with, it's huge.
>>=20
>> Also this seems to happen in SPL and again pre-reloc and again in
>> U-Boot post-reloc?

Not so long ago I proposed a similar patchset with the same goal
and I have discovered massive issues with SPL and relocation
interfering with driver loading.=20

The issue which I have personally encountered was i2c driver failure
due to double probing. This behavior was triggered by
always-on/boot-on regulators provided by pmic which in most
cases is an i2c device.

At that time everyone just ignored me, so idk if tegra i2c is the only
driver which has this response or there are more, but be aware that
this patch set may cause cascade failure on many devices.

Best regards,
Svyatoslav R.

>>=20
>> Should we have a step in the init sequence where we set up the
>> regulators, by calling regulators_enable_boot_on() ?
>>=20
>> Regards,
>> Simon
>

