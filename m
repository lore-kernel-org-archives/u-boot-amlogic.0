Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B5CCD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 15:43:25 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13576.1780584956879477761
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 07:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=AK0IoVs1;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eee266c6cso669017f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780584955; x=1781189755; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpSoUgCTGlEAVR4p19MOr0Uyd/9zz07UqLGzvS/SaDs=;
        b=AK0IoVs1h/ZDQrGQYK4WFchxQiD1nS7S7I6vDkhjLpSGDCxzPiUZ9rSb2WAMrvB/R3
         8Yroaw4G0VB5XCleTioebF3Bz40Mkh/SK8f7rygy+F9zcSUCsaGgOT4iaFzD4Ow629Sk
         IY2H+lLIEcxjGhMxUfabIirof1LhYJ2iraTgWOzODRaLi1JSG4w34JUu/VUgnIzikWCf
         LKHKTC1enCxx6IMSTcvnXNPXKaInF3YT9yf0uciQh7QcKEDfJh6DTFzVCVhX7YK7OAlD
         vGwoKjrZ4snwsxdsH6PT/csQ10isxXiFhyXtIK+JBg934puVGSfSq2ETjGCCpUK7Q80Z
         2Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584955; x=1781189755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpSoUgCTGlEAVR4p19MOr0Uyd/9zz07UqLGzvS/SaDs=;
        b=bwRH07RdHZREeSkyDMlNBBpEZeMUozU52F4OyIbzye5qCl++24veFIDXJHzbMuUr4f
         gqefL5rQxQilW75SPA13NMTxC+pSTaUrgIktffnfW0DXlI3HXn+SVVMRALb3oUSjZpwR
         a/dHfX6HgOBNh3uCMYmfKWjLm75ovBjV6z0OGSJmZqkeghYer6/FU6n3XGvQSJrVXT7L
         zBNEPeakCJoOsJS0blPOs+xMzt/3haYPCVg4XuZLBrTMJBfUkbLs8XabTSeSHHopP0Y5
         TrRLCh2KtDMC78F2A7qnLci5wFoXm23xOGqi89jXEgcd/GH/2zM1Tliba2aKm+OFrs6k
         jRlw==
X-Forwarded-Encrypted: i=1; AFNElJ9+E5lsGzotR14T5cdW+cSafnKOX5fZFxIFi0AsstfeOUAy0AHsdRqYxThmKZnrDnbs7fDjoxKK9mQCIWGi9Q==@groups.io
X-Gm-Message-State: AOJu0YykAHPmgay/sTT7YOGpHxfHCL/AkGpPxTQ1fB04ObCMdepvyLxc
	614+HMe0WXI2aSqOkr7fb0zyC9iaDGsDJN5vZ/cUAtCzhlg3NtFzS1j94WjC2wuRy0o=
X-Gm-Gg: Acq92OFUlMMWG5BFI6qib4QGZyzphXZOeWGw2U0ba5llb1QXPqJJRksarld+YR6WufJ
	/7BoIGYVbT4CJLpI945K8xgcic8sPuE52jcgRlQg6KLVzQryEGvgwNiSgVU9DSZTt/ZwldAsMb5
	V79jnzGZnpbmcYhUNW873bgyhIITWie+Hk0yy6JEfGvXy0wfpChIZh+eQxkJy5dRUoGnkI4qhXg
	0uZiyf90pnddAKZBJVGDA+U7aOs7Ls6fnD9syUspNwu+EGSwh6GD2QB8uEgQzrdq0ybwlD1SO2w
	TPKT26VmYl0xHsSZEX5wIA+6ATSRPneTx0/Dogr8CpW+qhoIRCUrfNekWg+FP/ahD75iW+eC4Ly
	kkOHsujRQUgv8S+fs4fnQ1A3nGc8tAyJH22tBuCrwjTNwc+akvovNHjKSlOpGx+H8W7rTXhcE0p
	cq0c0lCgQk9ixbT7rlPpeCoCY9+AdQXBKZhvt+q5mtOMQ88XPR9ygMiLN5/UrgH0AXQhAIsIwUJ
	fT/lQYEpQ==
X-Received: by 2002:a05:6000:1f09:b0:45e:f266:f4cb with SMTP id ffacd0b85a97d-4602193871amr9144318f8f.22.1780584955258;
        Thu, 04 Jun 2026 07:55:55 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1? ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm16612714f8f.17.2026.06.04.07.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:55:54 -0700 (PDT)
Message-ID: <a9531a9b-7a10-4804-9f00-199f8c50d051@linaro.org>
Date: Thu, 4 Jun 2026 16:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] power: regulator: qcom-rpmh: convert ofnode API to dev_read API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
 <20260604-devapi-v1-10-961aded05ff4@nxp.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-10-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 15:43:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2999



On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace ofnode_read_u32(dev_ofnode(dev), ...) with
> dev_read_u32(dev, ...), ofnode_read_string(dev_ofnode(dev), ...) with
> dev_read_string(dev, ...), and ofnode_for_each_subnode(node,
> dev_ofnode(dev)) with dev_for_each_subnode(node, dev).
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 4d65aae1690..f1de660c3a0 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -5,6 +5,7 @@
>   #define pr_fmt(fmt) "%s: " fmt, __func__
>   
>   #include <linux/err.h>
> +#include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/device.h>
>   #include <dm/devres.h>
> @@ -882,7 +883,7 @@ static int rpmh_regulator_probe(struct udevice *dev)
>   	priv->hw_data = init_data->hw_data;
>   	priv->enabled = -EINVAL;
>   	priv->uv = -ENOTRECOVERABLE;
> -	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
> +	if (dev_read_u32(dev, "regulator-initial-mode", &priv->mode))
>   		priv->mode = -EINVAL;
>   
>   	plat_data->mode = priv->hw_data->pmic_mode_map;
> @@ -933,7 +934,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> -	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
> +	pmic_id = dev_read_string(dev, "qcom,pmic-id");
>   	if (!pmic_id) {
>   		dev_err(dev, "No PMIC ID\n");
>   		return -ENODEV;
> @@ -941,7 +942,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
>   
>   	drv = lists_driver_lookup_name("rpmh_regulator_drm");
>   
> -	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
> +	dev_for_each_subnode(node, dev) {
>   		data = vreg_get_init_data(init_data, node);
>   		if (!data)
>   			continue;
> 


