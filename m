Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8EFC3DA41
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:15 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.3550.1719478131525963090
 for <u-boot-amlogic@groups.io>;
 Thu, 27 Jun 2024 01:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=TmkBcJiN;
 spf=pass (domain: linaro.org, ip: 209.85.218.46, mailfrom: caleb.connolly@linaro.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a724598cfe3so664112166b.1
        for <u-boot-amlogic@groups.io>; Thu, 27 Jun 2024 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719478130; x=1720082930; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQWX+luspyCXe7Er1ZSMyswIEZzqq2frk40BZPN/01Y=;
        b=TmkBcJiNjUA00OouWjPdbNQMB0PjI1mCqXXr4CBcv9mS4eIqs88q5s3LfCyRgnb5SF
         AVNSyLoqYTcgM5Tb43PmSJPMnrP4v8fANbnbK3Y4zN7TlK6DNRtIDRSeNvbMc336BvQi
         QrlkS8CoWY5pn5EDEbtDWOLrZFI6dqc25jKjinRlkRJwFgetFwbRyURg8K71BoJ1bD1p
         brzER6Jdp/NZu0FcVkpM96DTg4blIAqrHe5JN3Op46aGlWAt6/dDQZ0n4J+bt9Gmfz6i
         EQtNrrDBPg9iqVVU5bz1z+R+5wrHYVSOaq4pTwxu+EVPAWIx/FG4ICpftnMO7kW6JjyT
         4Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478130; x=1720082930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQWX+luspyCXe7Er1ZSMyswIEZzqq2frk40BZPN/01Y=;
        b=Sb1Y6PiP2AaRrLU1UxI1ywLsAbfOmB7FuMneNKr46HM/aJFkgX/B4uMIOUjYJbHsEX
         YROaVbpRTT/Yv6ZgmamtaA0Ni8cXfgdaszckER/t2qKIhATDwXYiNHJ5Km2mlw+uiOIB
         9K0rCO9gbyvhBIve6lIdAgYYDyhXag7ETumS2wGTVr/vmC1rhmOUCxfs3zkBQkrZmExv
         PXu/mVZQwLySjzTcF+Z3iZN7/SSMIkhlSGAau+vY/s+TzVrIYhUgwPxn9qGfos+efGHT
         QXK3K59zHbrZuyQwATbGBFnsx7yiL3Rmk+PHyvLF5IoAUz9YOBw/hoGZHIcl0WAlg6Nq
         4eCg==
X-Forwarded-Encrypted: i=1; AJvYcCX23ouB9/5ME5NXoXsv0ipB5sMaqkTutocfcoFEY3wJT9fQf1nbIJl7MLJeVoLv9CJthkDPnbcRzObjcKyYzjYc2FOkfU9GynI=
X-Gm-Message-State: AOJu0Yw0Mxd58f1h5JS7FY0RNi2uUfUfUiF33fjnEdL8QfYq52oujXfJ
	OlBQWTKA+4ukFJkKmqrZnIck2bmNaN52B3fNe28YWajWGbSElssZcuq/BEnq3wQ=
X-Google-Smtp-Source: AGHT+IHx00dY630Um06yB7PSZgoB5BMl1TlmFaISRXKiaH+xdDQo+IeYUMNUQ7mjfln6sy8TSDV3GA==
X-Received: by 2002:a17:907:9726:b0:a72:a05a:6601 with SMTP id a640c23a62f3a-a72a05a674dmr73486066b.14.1719478129673;
        Thu, 27 Jun 2024 01:48:49 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d71f5b7sm38416266b.75.2024.06.27.01.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 01:48:49 -0700 (PDT)
Message-ID: <b84e8b10-8698-41f2-9648-0b3f5c399b02@linaro.org>
Date: Thu, 27 Jun 2024 10:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2339



On 27/06/2024 10:37, Simon Glass wrote:
> Hi Marek,
> 
> On Thu, 27 Jun 2024 at 00:57, Marek Vasut <marex@denx.de> wrote:
>>
>> In case a regulator DT node contains regulator-always-on or regulator-boot-on
>> property, make sure the regulator gets correctly configured by U-Boot on start
>> up. Unconditionally probe such regulator drivers. This is a preparatory patch
>> for introduction of .regulator_post_probe() which would trigger the regulator
>> configuration.
>>
>> Parsing of regulator-always-on and regulator-boot-on DT property has been
>> moved to regulator_post_bind() as the information is required early, the
>> rest of the DT parsing has been kept in regulator_pre_probe() to avoid
>> slowing down the boot process.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>> Cc: Chris Morgan <macromorgan@hotmail.com>
>> Cc: Dragan Simic <dsimic@manjaro.org>
>> Cc: Eugen Hristev <eugen.hristev@collabora.com>
>> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Kostya Porotchkin <kostap@marvell.com>
>> Cc: Matteo Lisi <matteo.lisi@engicam.com>
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Sam Day <me@samcday.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
>> Cc: u-boot-amlogic@groups.io
>> Cc: u-boot-qcom@groups.io
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   drivers/power/regulator/regulator-uclass.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>> index 66fd531da04..ccc4ef33d83 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -433,6 +433,8 @@ static int regulator_post_bind(struct udevice *dev)
>>          const char *property = "regulator-name";
>>
>>          uc_pdata = dev_get_uclass_plat(dev);
>> +       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
>> +       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>>
>>          /* Regulator's mandatory constraint */
>>          uc_pdata->name = dev_read_string(dev, property);
>> @@ -444,13 +446,21 @@ static int regulator_post_bind(struct udevice *dev)
>>                          return -EINVAL;
>>          }
>>
>> -       if (regulator_name_is_unique(dev, uc_pdata->name))
>> -               return 0;
>> +       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
>> +               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> +                     property, dev->name, uc_pdata->name);
>> +               return -EINVAL;
>> +       }
>>
>> -       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> -             property, dev->name, uc_pdata->name);
>> +       /*
>> +        * In case the regulator has regulator-always-on or
>> +        * regulator-boot-on DT property, trigger probe() to
>> +        * configure its default state during startup.
>> +        */
>> +       if (uc_pdata->always_on && uc_pdata->boot_on)
>> +               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>>
>> -       return -EINVAL;
>> +       return 0;
>>   }
>>
>>   static int regulator_pre_probe(struct udevice *dev)
>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>>                                                  -ENODATA);
>>          uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
>>                                                  -ENODATA);
>> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
>> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>>          uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
>>                                                      0);
>>          uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
>> --
>> 2.43.0
>>
> 
> This is reading a lot of DT stuff very early, which may be slow. It is
> also reading from the DT in the bind() step which we sometimes have to
> do, but try to avoid.

Could we set up the livetree pre-bind? What about MMU? On armv8 at least 
this would have a huge impact on performance. I've done some 
measurements and there is at least 1 order of magnitude difference 
between parsing FDT with no caches vs parsing livetree with, it's huge.
> 
> Also this seems to happen in SPL and again pre-reloc and again in
> U-Boot post-reloc?
> 
> Should we have a step in the init sequence where we set up the
> regulators, by calling regulators_enable_boot_on() ?
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

