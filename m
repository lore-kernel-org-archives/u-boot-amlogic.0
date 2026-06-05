Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B07CD6E79
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7836.1780664939006997784
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jun 2026 06:08:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BGU7cGGf;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3e03939so16024285e9.1
        for <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780664937; x=1781269737; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36nYAO9JGrWT+6/ChfZFx5kVmLgAWZsFX51Vlvaz46I=;
        b=BGU7cGGfy32F40MJtK266vx3zK0WloZK1blckh4z50jQuVWqC4DilupKNUX4C5j0bY
         MsSDmWzj6N1XfxizfuAt68UhF4SEw9nrOS+tTNzUCw26DZc2taKicXmo1G6fQTQD8HYy
         ESanooNYT+wVm6V/2l7vgGM5wjuTxFmPyNCwl7TOF7YFsql+CTg2yjdzySxZ383Q8E1d
         c060R6Z38gHpY9p0Avp0bVakzj4SmiCwEqMQUuARfJQ4NPogPjumIvXaqPijqaq82Qk2
         h2QxyTAQe5wKQLL3cvtcmT2nDH1Z1L667cy6WJS2fAx7G7Odz0tYC2ypQABRqk4S0nvC
         iRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780664937; x=1781269737;
        h=content-transfer-encoding:organization:autocrypt:in-reply-to
         :content-language:references:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36nYAO9JGrWT+6/ChfZFx5kVmLgAWZsFX51Vlvaz46I=;
        b=FyLvpXTLS2J32IlvMp9YCN814S3+BKtU02FYH2o1JmExeU2b+394YbByHefTpNNDqK
         LXD7UhSh3OaeIotwIbn0p7XvD9+m4qlB9oCbHr92CqN0hY0HdTDAFaps3NtGik+FfZsK
         +0B92LA9sJqsPUOsZHX2nx6ZtK6Ec2Fj6VQfj/lbljLVYN+D58jVavNnvyht5FZWbQ5k
         ISpBr+ykqTAptsvUigq6Ze9yN30f8CC0VKyxj8iYS4zrz5RTBCLbg1mF7LAhIIq1Jo2U
         LmwZYxmR27IglVvDEedeCEFyhDpR+nrNxraQ3961kWfP5sAm3jtqo18oiLHzhPafZT3q
         1nJg==
X-Forwarded-Encrypted: i=1; AFNElJ9hPvlVVZGSLF9GgRaz+D0G84twqTadcsA/rxqY8W8TS27OAGVimfsLWn43PE2A8VRwrZ+Qz3hdvFdnv1TJoA==@groups.io
X-Gm-Message-State: AOJu0Yx6/kC1xIbzPm0QQZRUIiz2f103LBB+d7Inn3RjXdGVB8fUzUV5
	SVB7KrfkjDD36Cxx2hljtLPaP1hPk1Nvhy4Y233qsIyZVVQJRf9KV9yTOzlxzeIkMks=
X-Gm-Gg: Acq92OHhkOrpeV8NJBQXRrznqzTZ50hBEyWztUEImtRVx2mzzBEKj4yHWMS1cpqpkw9
	0jcS8a0tknh9QiZmnwgupcVJCMimCBfjrsfGQzFMUZou5gbbCiZxBV/JOhrqAJ9vTCe6yGPkbTz
	V+ZWOE1ugYBsKlJ8sAQJBQVRpWhtOvAkZ5p7srGqsAo8ixxRv9JBFxLneoSb3ZIH0PtDN2/UjUi
	q7o+0ZJfgwIcTB6di72t5AxX+2noCsVIbnX8OBNpHFBjdLSuDnayw9++Y8d4d0Rk7xt8waa5KZ2
	LGJq5C8JowuvkRmSLgQHlUZyJdbCmrDqY+rFACJdywahyYzLlg+j4sU1+9xwqqbOAS5xRLLdG/h
	Mjl7XYNW0rOd6j94iVPfuyTJRuQ9pVshPctxOT0pypSeEoVakLKOP7mT4dRA2kIIC33AWbKyLOS
	Uk7O7SxdhOFycBJ3diRdsVlJKNcB/2RsBd+tp6exTVdAeXgPn224yo8ARAY2CJeoTHm70PHJsjk
	SZ+kDmdyZzceP4enw==
X-Received: by 2002:a05:600c:8010:b0:490:b4a8:e031 with SMTP id 5b1f17b1804b1-490c2cba8e7mr36702965e9.4.1780664937021;
        Fri, 05 Jun 2026 06:08:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668? ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm172766705e9.3.2026.06.05.06.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 06:08:56 -0700 (PDT)
Message-ID: <c0966d58-7364-4cd1-b914-a3421f537e8f@linaro.org>
Date: Fri, 5 Jun 2026 15:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/11] power: domain: meson-ee-pwrc: use
 dev_read_phandle_with_args for ao-sysctrl
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Casey Connolly
 <casey.connolly@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
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
 <20260604-devapi-v1-4-961aded05ff4@nxp.com>
Content-Language: en-US, fr
In-Reply-To: <20260604-devapi-v1-4-961aded05ff4@nxp.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 13:09:08 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3005

On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the manual ofnode_read_u32() + ofnode_get_by_phandle() sequence
> with a single dev_read_phandle_with_args() call to resolve the
> amlogic,ao-sysctrl phandle. This is cleaner and avoids the intermediate
> phandle value and ofnode_valid() check.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/power/domain/meson-ee-pwrc.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
> index 6361f3a6c59..882238f2937 100644
> --- a/drivers/power/domain/meson-ee-pwrc.c
> +++ b/drivers/power/domain/meson-ee-pwrc.c
> @@ -435,8 +435,7 @@ static const struct udevice_id meson_ee_pwrc_ids[] = {
>   static int meson_ee_pwrc_probe(struct udevice *dev)
>   {
>   	struct meson_ee_pwrc_priv *priv = dev_get_priv(dev);
> -	u32 ao_phandle;
> -	ofnode ao_node;
> +	struct ofnode_phandle_args args;
>   	int ret;
>   
>   	priv->data = (void *)dev_get_driver_data(dev);
> @@ -447,16 +446,12 @@ static int meson_ee_pwrc_probe(struct udevice *dev)
>   	if (IS_ERR(priv->regmap_hhi))
>   		return PTR_ERR(priv->regmap_hhi);
>   
> -	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,ao-sysctrl",
> -			      &ao_phandle);
> +	ret = dev_read_phandle_with_args(dev, "amlogic,ao-sysctrl", NULL, 0, 0,
> +					 &args);
>   	if (ret)
>   		return ret;
>   
> -	ao_node = ofnode_get_by_phandle(ao_phandle);
> -	if (!ofnode_valid(ao_node))
> -		return -EINVAL;
> -
> -	priv->regmap_ao = syscon_node_to_regmap(ao_node);
> +	priv->regmap_ao = syscon_node_to_regmap(args.node);
>   	if (IS_ERR(priv->regmap_ao))
>   		return PTR_ERR(priv->regmap_ao);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil


