Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883B1C5DF9C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:45 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16119.1787576382935101232
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 05:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=uRobFnj9;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482938466a7so2512156f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787576381; x=1788181181; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OqhocBqwzfKdgepumpLVo9xZbFiI+hYcuMic5h4V7zU=;
        b=uRobFnj9Mf6CC+S7duY/MJ8WxqcOgg/OmBewSKNP7/CgGN4QnzgpR37CR6HG741l2i
         MUOIdEpbiMYmGUAVEJ8n1JWcb3jDQg49BTKZR6uJigqJxnhuutsR8Ph00Ul6KcH3sexT
         mPaCZZk5yPcCCspI9znJIfQiDI4zQzoXhGEMZxAwq0k6hM8JS/D5yFwmTz6O0zHHuirS
         2JWZ/Z7FceD5UyCojAlXSKdFGyQTr67sb0JPLocwhIX5cOSRk+Og8TOZvrlTKqnbjT/u
         eXK2nhjintHktQNsQPwUiz+Ise598FNuj6OctJgnsL/iB4UNadxWTVvK//ZFWJvGoSRR
         k3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576381; x=1788181181;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OqhocBqwzfKdgepumpLVo9xZbFiI+hYcuMic5h4V7zU=;
        b=bdy2zy8BDTXUZGlF7OP4mZV5Ul/Pj+VkuMsuEGD/O4zcaLJBOx8Bk60sWSEyD22QQP
         K9s1mARiR74Iya3oqparUqMnxPnxXTlYkpY/zL1X6T5L8AZSGYkHnaEj33LC8O3BBdov
         dukNpFsAjfGXxBIYmtvoRYpQs1Y5sRAhgCVO9gtx1EmooI4cnQ/mFllUchfBzwFn1xK4
         Mg8z9XP2okBH6n+E/p4FnQUiFB/6L0Gd+w3s6xHWbOydxavilxbkVLwBah5BGFfi8lhz
         8nPvQTXlq6LsmH0LkOi42JU+qYERhcfBJlQUiWwj+Vu1rXI7RN5iDAQEZVMTz36L7fja
         MdiQ==
X-Gm-Message-State: AFuF++khREPuUv/YQnBmcWHNpJWpYXQ2WB/s0trymAByLSZdV70JrOHk
	pJldW7m5hpu63GYn8NRr247KL+kbLrZNMWdBL41rgQNd8UDuPep5kyitO0KEnWbzYry3JwUw23/
	GAQb3
X-Gm-Gg: AR+sD13ckVSUtnG7PBNEwdX8MWtCI2cRsmZWOIjX+232Uh774bKHIqSi8ooAwnGx1Nb
	jL6nCo5HM532xKMvAg0dAeYgPNj7tFzsRtXTdxoc05cWGSpSVU1i1XgcOAE7POoVYdqToAjy5e2
	3ZKDvo68qOGtyTqJFEHolI+yFW5/U1UYs6SIoI/0GtAq+WI3Bz1GZY6llS9++cWDE8m6gNpN7IZ
	YlNtm+hBvxAW7ZqzQ46yueCMYhImYQTd3YGatv3zKLHQLZGj88bE73zCKREpUJzRYeXc0w51i0v
	449BmTXOTSoDpN6emf2ntt5sgrltgo4bseXI2qdN5DWE8/ztBQR2b3fo/8Ws7QuE5ZqfSG+Rd3D
	nucdKUXnwVtQnzWYg7M2Ha0nxUuuU2cmAYnqmzlp4WLdoFCNBlkfb+cPL0kxjhDcTSft1OrszQD
	MyEF/PkWDMiXXupaW1R6opFJQpf5Nps6oi501pE5xa5xykMc2pzFZbyL0FFxdBbbFLBWNmJhbid
	bCNASDZjk4qINDEoDWSKKkOabRuNdw/qClEuPrdkg==
X-Received: by 2002:a05:6000:2212:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-482c0ba3389mr33399727f8f.15.1787576380945;
        Mon, 24 Aug 2026 05:59:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273? ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b69a49sm8106788f8f.7.2026.08.24.05.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:59:40 -0700 (PDT)
Message-ID: <a5c38878-4233-4df3-871d-09ad511c7260@linaro.org>
Date: Mon, 24 Aug 2026 14:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] reset: meson: Add s4 support
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260817163604.1893382-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163604.1893382-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:59:45 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3057

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> Add s4 support. There are no new features, so just define the layout
> info.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/reset/reset-meson.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 8c27563ce23..16d2dc19898 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -82,6 +82,11 @@ static const struct meson_reset_drvdata meson_a1_data = {
>   	.level_offset = 0x40,
>   };
>   
> +static const struct meson_reset_drvdata meson_s4_data = {
> +	.reg_count = 6,
> +	.level_offset = 0x40,
> +};
> +
>   static const struct udevice_id meson_reset_ids[] = {
>   	{
>   		.compatible = "amlogic,meson-gxbb-reset",
> @@ -95,6 +100,10 @@ static const struct udevice_id meson_reset_ids[] = {
>   		.compatible = "amlogic,meson-a1-reset",
>   		.data = (ulong)&meson_a1_data,
>   	},
> +	{
> +		.compatible = "amlogic,meson-s4-reset",
> +		.data = (ulong)&meson_s4_data,
> +	},
>   	{ }
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_reset
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

