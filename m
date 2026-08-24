Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DBEC5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 13:01:26 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15977.1787576482401421943
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 06:01:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=GNH69u7U;
 spf=pass (domain: linaro.org, ip: 209.85.221.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1102470f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787576481; x=1788181281; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aufkQEztgqHKqqqiuyiZhAHIJSkdXnuAw9Xl6TbdqI=;
        b=GNH69u7USMVFYQ+ow8kWuRsDdc1lGJtOV5S42VFB/3FD43JM06LV1V+b0u+ZHZ1IxC
         lw8J+yxkMgBJin5BlpYTNjw6W0jOLAILyywc/b+fNpJcfsI9tzNWFq3DJF1diZCPAQXF
         IQNH/Sisd9Ugi80MrL9W17ZLxxN/WD1qCraSEGv61eW7nN3JWkD+ie8rYvdP5EWSlfjP
         Xe890+nGlWm4fBm27q+SQMj0Mv25ZKqdzSjOPlabExiJqVuhIRtppQYTISqNm5Y2WEMh
         4joyfbqTJGusNax889k/Z5ek45C+J5LByxdF3D0qqqMq4t+Nb7tajYjmTDlCilCf9ZVD
         l/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576481; x=1788181281;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aufkQEztgqHKqqqiuyiZhAHIJSkdXnuAw9Xl6TbdqI=;
        b=QU13chEx1hdJy/v27bBRqtfw26/2XXz2RUhwKjoihkL98EXgcz+EDvNzvJJxg38NQ+
         g8h7AWMwm4BWDvToUOVxHDtOjOuj7A7bLCUGOj2RRj0GlJd3mGjSuzXIOzLS/vPSyb9L
         t4yHKnbU4He5nUZaoCozM2K2AM5h6xN2is+3UZmQnph/2YJSnnNfaXU3/HgEqkdSZpVN
         5FlyHNLiHFYtXzk73edzlSwIp8JBY2GRBaL2oc4cn2YCHEw/he72m0XPqUx9m2VoAeXy
         voDiko8kp0gis/IPWPY1PiqlChsa6dWvkwn2/CCqXR9ms8oO0ph1KEt4FPrEyIBEp/Qc
         n/SA==
X-Forwarded-Encrypted: i=1; AHgh+RrD/4AsMzPbsuqRcre6F/1CAsFd2NuuWdm/SnnS9zWOtNaLQEmm72DsBwCmWfLH3P+nOhlgVuQOGsEFuyYrxw==@groups.io
X-Gm-Message-State: AFuF++ktKcmxEdeN0wYuhHWA0WvHEgva4MNH4BCdU8ix5i0AUf9KcEd9
	UMxEl1xLvFY67JAjZARXyyKFYo9BCpxbmBUpVIKq4mnJUHln21sKptXsTGlvf40/fEk=
X-Gm-Gg: AR+sD134FsITP5nuXbDZwIFzRft0RyTDCzQKRcdGr70v+Qpx7PBSpmjMOmaLiHwTg/e
	EYy1f+nJK8xm/riLCs7xYTLCnHZd+XT29KK2c0nfYPakadPgFF204vVwRRBt4XrOetBWE78ZNXo
	/WloXDaRqZxDm2EctcunIPceSj8InZScmh96dzrEfXSX92Muyiebkl81kLm8g2kYaFLGbolvkWe
	078rPQjm+zd1LVd3athvHbmFXEvGJN9Co7xAvZTue4ULFRwUwmFtzQAQz4pycYPOPw715X86Kjv
	8d9Pm0Qc/pHO1scZ5rMqCTXvPTyJb+VbblNzE8zaz4RS8cAtulfxXMMcaFYKSAggZ7kuGC0jCos
	cWYx7B/p19ECuBNmArDs5rsGdAf3qj4WaZlC84sOQubPIFTwIEHVKLcnTdZtiuPrpmc0LmPWZJf
	o3q3dsnqRIE8vui0M2lViigxNjTGIL3th6Yi+fK+O8ZLYCLfn7Ad2Mv+IwXVuBVEDFIG5fkSCPQ
	k/JOVCJaQtpZpyVigYD6iREU46LRerZWxXnUV+fMQ==
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id ffacd0b85a97d-482c0b54855mr31826012f8f.2.1787576477812;
        Mon, 24 Aug 2026 06:01:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273? ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0bef5sm8344261f8f.31.2026.08.24.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:01:17 -0700 (PDT)
Message-ID: <56b25fc4-cee6-4ca6-862f-481ba3c0454d@linaro.org>
Date: Mon, 24 Aug 2026 15:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] pinctrl: meson: a1: Use gpio regs for ds
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260817170313.1940219-1-sanderson@brivo.com>
Content-Language: en-US, fr
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
In-Reply-To: <20260817170313.1940219-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 13:01:26 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3059

On 8/17/26 19:02, Sean Anderson wrote:
> On newer SoCs, the drivestrength registers are included with the rest of
> the GPIO registers. Linux has a rather complex system that uses a helper
> function to fix up the registers for each SoC before registering the
> pinctrl. Instead of that, just fix things up in probe.
> 
> This silences warnings like
> 
> meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported
> 
> which I encountered on s4 and which I assume affects a1 as well.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/pinctrl/meson/pinctrl-meson-a1.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
> index 7e9ac6390b1..e9a7522ce50 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
> @@ -856,11 +856,21 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
>   	{ },
>   };
>   
> +static int meson_a1_pinctrl_probe(struct udevice *dev)
> +{
> +	struct meson_pinctrl *priv = dev_get_priv(dev);
> +	int ret = meson_pinctrl_probe(dev);
> +
> +	if (!ret)
> +		priv->reg_ds = priv->reg_gpio;

Please add a comment on why you're doing that.

Neil

> +	return ret;
> +}
> +
>   U_BOOT_DRIVER(meson_a1_pinctrl) = {
>   	.name	= "meson-a1-pinctrl",
>   	.id	= UCLASS_PINCTRL,
>   	.of_match = of_match_ptr(meson_a1_pinctrl_match),
> -	.probe = meson_pinctrl_probe,
> +	.probe = meson_a1_pinctrl_probe,
>   	.priv_auto = sizeof(struct meson_pinctrl),
>   	.ops = &meson_axg_pinctrl_ops,
>   };
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_pinctrl
> 


