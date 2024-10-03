Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAFAD1A429
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:00:52 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.7419.1727988589069814233
 for <u-boot-amlogic@groups.io>;
 Thu, 03 Oct 2024 13:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=kviY5BeJ;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7F3E788E3A;
	Thu,  3 Oct 2024 22:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727988586;
	bh=veJO1foQO923sQKYKfDMZ9ISzEPAzGab0vNiFkkw33U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kviY5BeJZ4018iVPDuqEprpyol0GyJw4XOJc/sgQtlBdwzdSlWzKeuc0zOYeTa4Ea
	 G+BhNdywcrP8yP5Xj/iWMF/CT7mXv8ZRtELcG+23unBEeRdgPKje1caK7urUogp2+t
	 /9IquZlFkP0we7GKQYC92PceBuz+7/FMZCuDQLBQzoog/07gdmNQSOa0jnVJUuXr8B
	 3GP6O6QztnJrumkZZ52DEXT900+oekp7WLA+3aEN5T9Pskn5uoLi6Nz8mjAVcNezfN
	 UldOGlah+uBNXcFbfWIt/CoR0+SKojmNbLpS/Ihn8mlgprkfUMqWjUU33e43Tq4ck0
	 8VCzfUB0dkZuQ==
Message-ID: <07c9067b-ac09-45de-8e65-ba06b0b761c8@denx.de>
Date: Thu, 3 Oct 2024 22:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] power: regulator: Convert regulators_enable_boot_on/off() to regulator_post_probe
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Matteo Lisi
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
References: <20240926231457.2933914-1-marex@denx.de>
 <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:00:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2456

On 10/3/24 12:55 AM, Simon Glass wrote:
> Hi,
> 
> On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
>>
>> Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
>> empty functions. Implement matching functionality in regulator_post_probe()
>> instead. The regulator_post_probe() is called for all regulators after they
>> probe, and regulators that have regulator-always-on or regulator-boot-on DT
>> properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
>> such regulators in regulator_post_bind().
>>
>> Finally, fold regulator_unset() functionality into regulator_autoset().
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
>> V2: Rebase on current u-boot/next
>> V3: No change
>> ---
>>   drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
>>   1 file changed, 19 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>> index 1a970004540..9fcc4bd85b9 100644
>> --- a/drivers/power/regulator/regulator-uclass.c
>> +++ b/drivers/power/regulator/regulator-uclass.c
>> @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
>>                          return ret;
>>          }
>>
>> +       if (uc_pdata->force_off) {
>> +               ret = regulator_set_enable(dev, false);
>> +               goto out;
>> +       }
>> +
>>          if (!uc_pdata->always_on && !uc_pdata->boot_on) {
>>                  ret = -EMEDIUMTYPE;
>>                  goto out;
>> @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *dev)
>>          return 0;
>>   }
>>
>> -int regulators_enable_boot_on(bool verbose)
>> +static int regulator_post_probe(struct udevice *dev)
>>   {
>> -       struct udevice *dev;
>> -       struct uclass *uc;
>>          int ret;
>>
>> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
>> -       if (ret)
>> +       ret = regulator_autoset(dev);
>> +       if (ret && ret != -EMEDIUMTYPE && ret != -EALREADY && ret != ENOSYS)
>>                  return ret;
>> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
>> -            dev;
>> -            uclass_next_device(&dev)) {
>> -               ret = regulator_autoset(dev);
>> -               if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
>> -                       ret = 0;
>> -                       continue;
>> -               }
>> -               if (verbose)
>> -                       regulator_show(dev, ret);
>> -               if (ret == -ENOSYS)
>> -                       ret = 0;
>> -       }
>>
>> -       return ret;
>> +       if (_DEBUG)
>> +               regulator_show(dev, ret);
>> +
>> +       return 0;
>>   }
>>
>> -int regulators_enable_boot_off(bool verbose)
>> +int regulators_enable_boot_on(bool verbose)
>>   {
>> -       struct udevice *dev;
>> -       struct uclass *uc;
>> -       int ret;
>> -
>> -       ret = uclass_get(UCLASS_REGULATOR, &uc);
>> -       if (ret)
>> -               return ret;
>> -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
>> -            dev;
>> -            uclass_next_device(&dev)) {
>> -               ret = regulator_unset(dev);
>> -               if (ret == -EMEDIUMTYPE) {
>> -                       ret = 0;
>> -                       continue;
>> -               }
>> -               if (verbose)
>> -                       regulator_show(dev, ret);
>> -               if (ret == -ENOSYS)
>> -                       ret = 0;
>> -       }
>> +       return 0;
>> +}
>>
>> -       return ret;
>> +int regulators_enable_boot_off(bool verbose)
>> +{
>> +       return 0;
>>   }
>>
>>   UCLASS_DRIVER(regulator) = {
>> @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) = {
>>          .name           = "regulator",
>>          .post_bind      = regulator_post_bind,
>>          .pre_probe      = regulator_pre_probe,
>> +       .post_probe     = regulator_post_probe,
>>          .per_device_plat_auto   = sizeof(struct dm_regulator_uclass_plat),
>>   };
>> --
>> 2.45.2
>>
> 
> I thought I objected to this patch, but it seems to be in -next? Does
> anyone know what has happened here?
> 
> I am seeing these errors now when running sandbox 'u-boot -D':
> 
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
>         out_set_value() PMIC write failed: -5
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c49db0 register: 0x0!
>         out_set_value() PMIC write failed: -5
See Re: [PATCH] sandbox: i2c: Make sure phandle dependency is probed , 
let's continue it there.

