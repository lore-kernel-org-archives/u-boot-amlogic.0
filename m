Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87447CD6E78
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 15:43:25 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13745.1780585340421009690
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 08:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=XEBbakKt;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: casey.connolly@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so636652f8f.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780585339; x=1781190139; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Err73DfSZ+PX9FWDl+8+Mp8IRLdKqf6Q0Lqb2301kXk=;
        b=XEBbakKtKU5fgcOsdy6MHUh0zONc5C1aWvDBwMEqFLB2YGANPucPnpPgq0niAQ5+59
         rNC4rqJ/yaN/BsJrJPaN90FqlFuhle5XOyTgHZY/UsXmnquZo8kzD1KviE3yS5+r/Hve
         XhtDy5uBjzdXhdCz9HiNDEuD5xSU7WiCXaOMXfPvvT63qppaVAbjS7674LK10c1WIDus
         2xC63bspwrJF2H9xSNEvM6PIekYvfN79JWhx7a8QdlZXrYqrt/v0bBXa7mDsf0Y5P78s
         o9/1WBY6CoHUJFNcOQ5Dler9wK5xOz/Fy7qYDBNrUtcSJ+cVtfFfzODncHvxg+L4jI+v
         tXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585339; x=1781190139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Err73DfSZ+PX9FWDl+8+Mp8IRLdKqf6Q0Lqb2301kXk=;
        b=ioY5TLyqCH0oAJGEsYemPbNrlDMNeUjSnztYBsptUy5O/b3Jw+ggCrZMZ99yeJdqUZ
         u8wX2Gt5BqPClwmtaREDyj6mulTtxO+q7ntSIqfasWFexCjAAas4SQQt0VJRjNxw64op
         bfWUpwgNc9Dhxg0hBa1V9bbTAttQ+jdys7fKSI4THiCPg8N3CAyXzeXj8cYiUD3fvbRi
         zDK9Kn94i1AMSdK3iMrIzGetA2Wx4poNkDFqoHtKjYBQyUM3RanB9O6BM6TSGm6F4eF/
         NJUX5tu7krT8QEtZMelfybPKZlYNd7sGx4SiQ1T4+l9r10MPzVBseHubg1jolVpZhJhN
         BXhA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xne0xXPqTRXAd64hr6BXmfQPWZZr49x09CXq2lnNv3W0LMlv3SoYJzAZMJwWNPe/ZkC3RRmPwQDGUfbZSRw==@groups.io
X-Gm-Message-State: AOJu0YySmnMg2fELOuvOpG3ofiNQkTwuWEx7a7vF6J0a3jUnvxuLiRCY
	7jVsg3HyCQJtXiQoOW4iUu1dW8butGqNY4NY2D/2d8cAGgm+EgeQhKjEvbMyLwkZeEk=
X-Gm-Gg: Acq92OEkR/QA/evE6xCwRMkfjAXme27QJmN3B93eQNpVwbweTxPwu55c1TtUsXwouZu
	gfnuVCzJUfAIU3KvBLoK8kLrsmgvm1pywEc5xpEvpUH+t0Yisim/enyQUeYdU0Dvb12WuZLxH/Q
	iULauQpiQ1/glOrM+3+exP2Ha1Cw+oH6a20Cz7nFmO0IZZupSVi8hxsczB52iIFnl3ZESG5xWOq
	PUvrpCegE07RdaUS2H/P998VgF3jiAZVGxydXJ+noUWfzn18IQt8HUFzByWTBa9oFNepT0uwiNR
	AREzItp6UbXXPnCD/HwlRE3z1hNe4EFYuw6C48f9GeXcHuEjIeMrDQsGj5F7RKAJBieQQxN1pPM
	kWWOdcWerwQa4i6w09OIo70Fp1u6JmLu84M4rCJyQxPu61iB7yku1S/8Ep02oPuG0MtAz8BAieo
	IbYMZmzpHOxZH5pQkkwOAa9y95HzSusgQJ/6Io5Oi4DjsOM+U0M/fF1MTO3vpH3VJbSSJUOC8Z1
	ldRN46lsg==
X-Received: by 2002:adf:fd48:0:b0:45f:f142:d55f with SMTP id ffacd0b85a97d-460216db965mr10949386f8f.15.1780585338649;
        Thu, 04 Jun 2026 08:02:18 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1? ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm12854726f8f.10.2026.06.04.08.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 08:02:18 -0700 (PDT)
Message-ID: <16ac86c9-e5e3-463c-ba3f-2ba6cbdff9f3@linaro.org>
Date: Thu, 4 Jun 2026 17:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] mmc: msm_sdhci: convert ofnode API to dev_read API
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
 <20260604-devapi-v1-2-961aded05ff4@nxp.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-2-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 15:43:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3001



On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace ofnode_read_u32(), ofnode_get_property() and
> ofnode_read_string_index() with their dev_read_*() equivalents in
> msm_sdc_clk_init(). Remove the intermediate 'ofnode node' local
> variable.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/mmc/msm_sdhci.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index aaa87923604..7bdb02142a2 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -64,14 +64,13 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   {
>   	struct msm_sdhc *prv = dev_get_priv(dev);
>   	const struct msm_sdhc_variant_info *var_info;
> -	ofnode node = dev_ofnode(dev);
>   	ulong clk_rate;
>   	int ret, i = 0, n_clks;
>   	const char *clk_name;
>   
>   	var_info = (void *)dev_get_driver_data(dev);
>   
> -	if (ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
> +	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
>   		clk_rate = 201500000;
>   
>   	ret = clk_get_bulk(dev, &prv->clks);
> @@ -87,7 +86,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   	}
>   
>   	/* If clock-names is unspecified, then the first clock is the core clock */
> -	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +	if (!dev_read_prop(dev, "clock-names", &n_clks)) {
>   		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
>   			log_warning("Couldn't set core clock rate: %d\n", ret);
>   			return -EINVAL;
> @@ -96,7 +95,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   
>   	/* Find the index of the "core" clock */
>   	while (i < n_clks) {
> -		ofnode_read_string_index(node, "clock-names", i, &clk_name);
> +		dev_read_string_index(dev, "clock-names", i, &clk_name);
>   		if (!strcmp(clk_name, "core"))
>   			break;
>   		i++;
> 


