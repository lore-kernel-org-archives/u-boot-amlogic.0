Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98313CF64BF
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.13552.1727263794224005311
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Sep 2024 04:29:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=XTGOEP/C;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 44F0587E30;
	Wed, 25 Sep 2024 13:29:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727263792;
	bh=yN+By0kTW5UyUgEkfbbRSYexo8+igSnRUIACG241Aow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTGOEP/CtjPKjYCreJqa/JXTipNa4C3IdYfMBpKdYCDme1antInVV6/exDQESEeuC
	 3djBQcZhc53BZrlsTQvdwYo/eWWwVyBNmyAvdAPwAWmZOwsVd7l3NQ1eFNygFzDJ9E
	 5Zfb2kuLlupn8MAVDsW9dp/irq8qrgSUVgyvwa/Te2rj5cFmbbSpRsO2Jng1Fuzs8U
	 QtohBPr/Tx5I+0dgW0dGA2vzssK8ev8IxFBI8BId7M32+CZfmRWOdqNdK22MVJ6IR4
	 pkugpTvAoomVNHsISB0Nd3ltb28t+baazeXUJzqNu/enMHI/trW7WlakTLduqq+lvW
	 1rt7FF9FSdzZA==
Message-ID: <270aa01b-98f9-4164-9539-396b9b3f96bc@denx.de>
Date: Wed, 25 Sep 2024 13:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] power: regulator: Exit from regulator_set_suspend_value on poorly described regulators
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>,
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240925022314.714285-1-marex@denx.de>
 <20240925022314.714285-3-marex@denx.de>
 <18454c94-9422-4fe3-8996-6fc83834e319@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <18454c94-9422-4fe3-8996-6fc83834e319@kwiboo.se>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2415

On 9/25/24 8:29 AM, Jonas Karlman wrote:
> Hi Marek,

Hi,

> On 2024-09-25 04:21, Marek Vasut wrote:
>> In case the DT regulator node does not contain 'regulator-max-microvolt'
>> property and does not contain 'regulator-state-mem' subnode (like the
>> test.dts regul1_scmi: reg@1 {} regulator node), then regulator_pre_probe()
>> will parse this regulator node and set uc_pdata->suspend_on = true and
>> uc_pdata->suspend_uV = uc_pdata->max_uV, where uc_pdata->max_uV is set
>> to -ENODATA because "regulator-max-microvolt" is missing, and therefore
>> uc_pdata->suspend_uV is also -ENODATA. In case regulator_autoset() is
>> used afterward, it will attempt to call regulator_set_suspend_value()
>> with uV = uc_pdata->suspend_uV = -ENODATA and fail with -EINVAL. Check
>> for this case in regulator_set_suspend_value() and immediately return 0,
>> because there is no way to set meaningful suspend voltage, so do nothing
>> and retain the existing settings of the regulator.
> 
> I sent a different fix for this some time ago, please check it out:
> 
> https://patchwork.ozlabs.org/patch/1964571/
That one will work too, yes.

