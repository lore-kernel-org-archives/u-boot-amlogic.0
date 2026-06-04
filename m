Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85632CD6E77
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 15:43:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13636.1780585107874068522
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jun 2026 07:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=i8P/k4Xm;
 spf=pass (domain: linaro.org, ip: 209.85.218.47, mailfrom: casey.connolly@linaro.org)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-befee9e5ef7so68164666b.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780585106; x=1781189906; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HidTd4zfsVEmGU+IWMMZTIKZtcqJUScKG3FdfDG+R2E=;
        b=i8P/k4XmXuI+vmJq6DB4GHAG8dU8mqsAqpbT0nOiWdES4DrAJK2QECFHrqBkWL8SoS
         G837ZrO400z20wzV0dw5Ufg9tJNdukWpuiwFfKNMls+CYWcZ1zTLSbNPpzIVyqXOsbGC
         DolTTah6bD7jf/RrBsdgWSzm+FaHmmSxYjua+POKQ1ZA/gkGiHqcBDTXoKOFAyT9r48z
         UObfCAM2O+NNSTpoimK4wDkrfGZotHhLE2bDrj8nQCCHVaJYLJuC+HyG9rYYedvIwRF7
         ENpnr4wIJ5yYimHBqidF+PrpULpwF/Xvob7/eOC43sr/lMAiN6dmrvExhAV6GoIMux1B
         oUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585106; x=1781189906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HidTd4zfsVEmGU+IWMMZTIKZtcqJUScKG3FdfDG+R2E=;
        b=DmiTQ7bADjPOIHFD4isrEl96MtUA+iF+Z4I5OSWcrk56GGDi1pY3UWWayPfQxfu9CO
         mrH1lMQfq+ng8uzwNG1gkQUGXzos13KoXbBzHoh7r32g2KCRd6N8AJvFqm2/noV+Gx3O
         BIjW14fiXKGI6VbZ3YaoQsCsmv5ZtH80bIwa0WX7zi9+gu6pzJOiDOtKncvBAEVln1Lz
         O8rVm+VNbyYm9Bs69BzghYWT2IAs3PeqrwD7TSVRo9PHLPq516kaSfLzjcXK/y8eEd1Q
         rkZ0g6leWUlFluYjOIxRK/rIrPjj3bfpfpb/mdtaVdB4EXP+PJZ7MLHBuIY79yV6U5qD
         qw5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/cBt4At/0jSqNtGEcz+xzz/tkekQFrpIrBN2jBr+FqtzM5vGJ4yXjRjujbJQZTIUohZcSuHb+hKHAGuTbNCQ==@groups.io
X-Gm-Message-State: AOJu0Yy1tTULOB/zX17l/0Nbyw3reylI0gSygizz/xmKh5e1/Cw0tDqT
	imWoM8iknDvkQdZcOoCA+cJhUMtFOzhRHA8cdLa00h8XwBXuahHq44dSI2l9tckDtRlN9kjSEeB
	QLEmdj+g=
X-Gm-Gg: Acq92OGbHDynBWB/1BvqEetCyWKTe5ZCdoSrsCXoO5iR1YGoEJN7jEh00Vlg6BnbHHf
	CvQZDkb3jUuTKm5WHnoY2jCNDhWn6Jhgtha8ZKSy/2ZUkl6v9vEMVVJa5/O1FZG/Uk3kVfHGvaJ
	dt3PaF6FVgpp+vZ/ux1s7QtR+AzBndtk7Sya8eoMSdD/Qb3OBk5nHdowg0sXV8IV0RcIZltST1c
	YWdXPKKOElG2CETY23ZnGrzLFbPwuZfohmbJfQA1tAJcXskMTgFJnRMpCgXD5/ydgZcOJMTi55y
	T3vCos1FSjCY2UezvdIOT+g5c4eJGfMnBn3Fu8LyJaoWKd/e7nJ2ExXlIzc/nQj8yWOMiczHKw6
	rQYNdGmPw05Qs/bVJCtNQ+bXyfL+GHrO0iaM4EHs9TjH2cjm7NusFLrQkk/Zdc5x0czpy+BvWbZ
	6XdhReObOhzSXoABu9GOBPYdIf4tNyXucuB5sEjnyUsKuJCyG1FjRAloa9si0gSXbsXGx1hUi1s
	LdKBQEEZ34zvrZL4cDk
X-Received: by 2002:a05:600c:a49:b0:490:b3e7:4614 with SMTP id 5b1f17b1804b1-490b5e64ac8mr141790525e9.25.1780584793138;
        Thu, 04 Jun 2026 07:53:13 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1? ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm17082506f8f.25.2026.06.04.07.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:53:12 -0700 (PDT)
Message-ID: <9508151e-3603-46ca-a3a2-212e8ba4bca5@linaro.org>
Date: Thu, 4 Jun 2026 16:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] power: pmic: qcom: convert ofnode API to dev_read API
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
 <20260604-devapi-v1-8-961aded05ff4@nxp.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-8-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Jun 2026 15:43:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3000



On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace ofnode_read_u32_index(dev_ofnode(dev), ...) with
> dev_read_u32_index(dev, ...).
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/power/pmic/pmic_qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
> index 92d0a95859b..4b8dcc6104c 100644
> --- a/drivers/power/pmic/pmic_qcom.c
> +++ b/drivers/power/pmic/pmic_qcom.c
> @@ -72,7 +72,7 @@ static int pmic_qcom_probe(struct udevice *dev)
>   	 * contains two discrete values, not a single 64-bit address.
>   	 * The address is the first value.
>   	 */
> -	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
> +	ret = dev_read_u32_index(dev, "reg", 0, &priv->usid);
>   	if (ret < 0)
>   		return -EINVAL;
>   
> 


