Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6FFCF64B7
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.46162.1727363130697314307
 for <u-boot-amlogic@groups.io>;
 Thu, 26 Sep 2024 08:05:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=KKBJXaB3;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=3c7c=qz=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727363127;
 bh=Y+YnRVBW43H1F0UL6bLCP1aMcWtJ29E/WmvU1jfMCaM=;
 b=KKBJXaB30RQHqA6J7TmHnNCaNsqz9t73wzVY6LW8fxwe9GRxO72hmWqP8EMoM4eZsdP+u9aJE
 sa2CtZstdNVYs+FXL/DTkgBnig648Btar1BYHWICCGlkzK7lBeH9jYCjcBeV1CDXRBwYrUYge3H
 bv59tM+xfaviOowY9Hh9flgarH8Q/3BnYzAbr03osTmSxeLoKfrUxP734fv3N5DoUl/gsUnx4XK
 a7K8x+UYwWtIud53lW4cWDJhfjVHLlgBfWe/cSfgeJd3FROfJVte4nK5LQBA1SMDfYqiAvgcNxn
 0S7zDscPqrPz6EU5FAAdotYqqsttyIOhmi53y1ibvkpg==
Message-ID: <b8eb1c20-afdb-497e-9788-498550520d61@kwiboo.se>
Date: Thu, 26 Sep 2024 17:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
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
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240925022314.714285-1-marex@denx.de>
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f578317ea0e42a3af9b8e1
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2418

Hi Marek,

On 2024-09-25 04:21, Marek Vasut wrote:
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

[snip]

>  
> -	debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> -	      property, dev->name, uc_pdata->name);
> +	/*
> +	 * In case the regulator has regulator-always-on or
> +	 * regulator-boot-on DT property, trigger probe() to
> +	 * configure its default state during startup.
> +	 */
> +	if (uc_pdata->always_on && uc_pdata->boot_on)

This check for always_on _and_ boot_on does not fully match the commit
message, comment or the old behavior of regulators_enable_boot_on()
where any always_on _or_ boot_on would trigger autoset().

Regards,
Jonas

> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>  
> -	return -EINVAL;
> +	return 0;
>  }
>  

[snip]

