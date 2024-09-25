Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5994ECF64AC
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:31 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 by mx.groups.io with SMTP id smtpd.web10.9113.1727245767708020291
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Sep 2024 23:29:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=T5TWmEY1;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 207.246.76.47, mailfrom: srs0=0fb4=qx=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727245763;
 bh=QxK3tYlMK9m1W+B7sEeSpQwq15tsorgto9RIYUXmjl0=;
 b=T5TWmEY1mYNHxWyDmGFMWZRGd5IuywMbdIGiPr16X+1t4JriaOW1Y9FAF0oor5ZXJWnV3Hikq
 7PmKGHFoJw35cM6VJ1WZNFeuO5GWoJQjVQn0jJ36mzf9FFsQNWHS+dA+T8eWNsZOLXtQ41BFW6M
 Bp92c7cGjYrIO2/fMJjEk/xVTTewhg2YBSWSXPPgkdgLV3Hlpr2HIZjY3Mu9XGOI0r3RnCzRDX0
 nf/00r13moocqtFvEI78+JfGB/FLj83MkeKbbuFPrdJUhTJ/Cv19sXtxKqIMjzmEFCPWKBmaH1l
 J9hYXybnRHVWs67BA/0Vhbf9SZkDDplhUyCiCrBfpVTA==
Message-ID: <18454c94-9422-4fe3-8996-6fc83834e319@kwiboo.se>
Date: Wed, 25 Sep 2024 08:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] power: regulator: Exit from regulator_set_suspend_value on poorly described regulators
To: Marek Vasut <marex@denx.de>
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
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240925022314.714285-3-marex@denx.de>
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66f3adc1453145d9c3fa9afa
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2404

Hi Marek,

On 2024-09-25 04:21, Marek Vasut wrote:
> In case the DT regulator node does not contain 'regulator-max-microvolt'
> property and does not contain 'regulator-state-mem' subnode (like the
> test.dts regul1_scmi: reg@1 {} regulator node), then regulator_pre_probe()
> will parse this regulator node and set uc_pdata->suspend_on = true and
> uc_pdata->suspend_uV = uc_pdata->max_uV, where uc_pdata->max_uV is set
> to -ENODATA because "regulator-max-microvolt" is missing, and therefore
> uc_pdata->suspend_uV is also -ENODATA. In case regulator_autoset() is
> used afterward, it will attempt to call regulator_set_suspend_value()
> with uV = uc_pdata->suspend_uV = -ENODATA and fail with -EINVAL. Check
> for this case in regulator_set_suspend_value() and immediately return 0,
> because there is no way to set meaningful suspend voltage, so do nothing
> and retain the existing settings of the regulator.

I sent a different fix for this some time ago, please check it out:

https://patchwork.ozlabs.org/patch/1964571/

Regards,
Jonas

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
> V2: New patch
> ---
>  drivers/power/regulator/regulator-uclass.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 14cf3159203..3c05fdf1966 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -85,6 +85,10 @@ int regulator_set_suspend_value(struct udevice *dev, int uV)
>  	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  
> +	/* Regulator did not set limits, assume already configured. */
> +	if (uV == -ENODATA)
> +		return 0;
> +
>  	uc_pdata = dev_get_uclass_plat(dev);
>  	if (uc_pdata->min_uV != -ENODATA && uV < uc_pdata->min_uV)
>  		return -EINVAL;


