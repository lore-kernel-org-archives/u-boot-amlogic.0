Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78458CF64B3
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.56330.1727389017920449035
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Sep 2024 15:16:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=DiXsIH+G;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 28D2788F08;
	Fri, 27 Sep 2024 00:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727389015;
	bh=ChzMy5WYqc3uW8w8j0l/YJ76ufI3mEG1AJyTnWAHWvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DiXsIH+G6ZySjfUCfP5aKPpfnXl8I+vYWVWriBGcB3t9w31yebE3rXbXxbca9CkgY
	 fbucKsnL1LcldN3CfoMX0eWUNl6VePMlr/EGjolRDcqbLZG/sC+lkOUzdFa6GHmgDg
	 qz7roYNQmT4NjhE68/kRHiCZsysXPbVT5OuPaxW5VY6FZ79KVX12uxtE/H2mkO7Hbh
	 lSFNUjcZBwNJJC6spPPk5tdLYrUNXWLYmava2gf9lNqH9SudwnRAvsez4Q5WDAFtqw
	 l9eEjCyR04aBA+D669ArIuyD6Vvx27IxFlb7rLK0HBcnOQGKsc6Wl9fSeoRrwAWvAR
	 DDKhYGTEFPNSQ==
Message-ID: <b769e5c6-7e19-4ce6-9c3d-9a262a1bad8e@denx.de>
Date: Fri, 27 Sep 2024 00:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240925022314.714285-1-marex@denx.de>
 <b8eb1c20-afdb-497e-9788-498550520d61@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b8eb1c20-afdb-497e-9788-498550520d61@kwiboo.se>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2421

On 9/26/24 5:05 PM, Jonas Karlman wrote:
> Hi Marek,

Hi,

> On 2024-09-25 04:21, Marek Vasut wrote:
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
> 
> [snip]
> 
>>   
>> -	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
>> -	      property, dev->name, uc_pdata->name);
>> +	/*
>> +	 * In case the regulator has regulator-always-on or
>> +	 * regulator-boot-on DT property, trigger probe() to
>> +	 * configure its default state during startup.
>> +	 */
>> +	if (uc_pdata->always_on && uc_pdata->boot_on)
> 
> This check for always_on _and_ boot_on does not fully match the commit
> message, comment or the old behavior of regulators_enable_boot_on()
> where any always_on _or_ boot_on would trigger autoset().
This should be ORR, thanks for spotting this, fixed in V3.

