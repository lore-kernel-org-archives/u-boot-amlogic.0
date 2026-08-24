Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895ACC5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:55 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15926.1787576393831500272
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Aug 2026 05:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QieHpdwX;
 spf=pass (domain: linaro.org, ip: 209.85.221.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so2364185f8f.2
        for <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787576392; x=1788181192; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lhzdL+a1BKnrrBERY/UHGCc8CRG9V/A8/xlr7D0+ds=;
        b=QieHpdwXXWGfDxvhBp06E2jZYAsCkCqOyIigiSyjBUMo+g41xHvJ6wVdHEotcOdpY6
         qb6GVO0pBnaU1bS+paWqYjvGXDo+sdbvtPShYtiEhsns/7e/uGl6sdRHy97YS98sBNw2
         VF+TgtKgzJi+i0UKjLy8Dk9KXOZU/2w/FmDdJgegDljwC3MQddhOewFsFz0tau2zoHlh
         q/ZdyhoylR07jkfGV1LXyEheA4t6b1v1+BGoi559hFcd7o/6gqszc9Z1be+p8cVtG7dM
         0RwwjdV/wiNG7gzQYMa1lMco4abAL9Xs0BcUVYqrIjhCxa0HOggj9lGKXScbwMjyPFaK
         TDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576392; x=1788181192;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lhzdL+a1BKnrrBERY/UHGCc8CRG9V/A8/xlr7D0+ds=;
        b=QEgLB2gjYpVrrVdadSIwIKIKvfPnmrmtOnPslXknTk14eZBbvaf63ff9xJx+bvIxIp
         ukdFft5gk8mMffRC42Yq+MvdpZiJP92jhbJGK5wHjkwEsiwkLSor6dDQyJ+gdyM7WJq4
         PCDF5VdIbgX7ZyuM7F5FkAUbvhIKhT3rsRsfsFk2VyiCnBRDFGwPuZAHTxQ099H8GU0G
         UGUY2kDwCZCZWlxWWxybMivxGPNH9+uW007/UiUuVwoJLnzHx8AQGvCoQoHjp9pdtFxQ
         iJvErksBduy+PKix3de7QEjxQLXUf4l+T4yW17ZCEzUoYQ8tU/B/mk+s3aCZvgPoGZbZ
         5SrA==
X-Gm-Message-State: AFuF++n7mlVBbmTeQjtyqmNYqq8ECbr9iuld2QLRNP1F0hmFdC2vz+0Q
	KmDHXGlEUdwugWX8tSaO1Lqa2nhQ4WLW3idnvhG9HkeMbuVyFQ3JEtd0jhVjOWF1CD6AGKb18IW
	JwLaT
X-Gm-Gg: AR+sD12cMrozkKDUZI9O9WW0Dt4brJLJoGHRXWHsw5l/8rVcD2mi5co9VYrpat2vvxP
	2Oudp2qhUuAcuVHeXpOA0DAeumgwfMVx4OgYGjmMsyYXxYSEVZFOqc114MOWK4jPrtQPCGCjw4N
	eWHWaxWqa3lC/pmtCYEijzmnpIVV4zVCl/DJ0RMFWkz5xy35CuZ/HS57I3oqW2I7bib2OrtJa5w
	SH9racHXlq6c6XHuiT1gKvMW6TQVpmJJ1lmxiNkgGvUMeQt+1fvq7wReSqEHFwSvujxkBG4JIH5
	Vr7iWqiwLGpEXSfJsjpF1SaRbiao4QXaTwRucHuTzPpqyakjdF64chKJ2EHHGXfMUG3vOjWHzax
	GjNuaO36rpsRhTLLrYcFNOigHLkWy8yiaBXZBMyqgKV1gT3NSqmMqc2a+6XUasSdmiIX2i+Vub4
	jUpxz7mQj4tSTfAG1GM9Jcb5XM77dLoDKKMuEPMLFGa6hcb8Vuuh6gm8aayPso63AhtwYgceaHC
	YeDyw4SH+mogV59msgLXsmlMr5ybaLA0tg4+VtJkSM=
X-Received: by 2002:a5d:5f93:0:b0:47f:5ec2:d54 with SMTP id ffacd0b85a97d-482c816c126mr19222602f8f.5.1787576391949;
        Mon, 24 Aug 2026 05:59:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273? ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9c0bef5sm8339351f8f.31.2026.08.24.05.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:59:51 -0700 (PDT)
Message-ID: <2aa0d5e3-e0e2-4f82-b620-39f4c3a220e6@linaro.org>
Date: Mon, 24 Aug 2026 14:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] serial: meson: Add s4 support
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260817163438.1893025-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163438.1893025-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:59:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3058

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> No new features, just a different compatible.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/serial/serial_meson.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index cc71381f87e..336ca552ead 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -244,6 +244,7 @@ static const struct udevice_id meson_serial_ids[] = {
>   	{ .compatible = "amlogic,meson-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
>   	{ .compatible = "amlogic,meson-a1-uart" },
> +	{ .compatible = "amlogic,meson-s4-uart" },
>   	{ }
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_serial
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

