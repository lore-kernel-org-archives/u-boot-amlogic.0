Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8979EC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:56:02 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.9176.1746777361573717359
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gVQzQwt1;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso16831465e9.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777360; x=1747382160; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxnEOfMSdtSDZ2MSZ22NEolidRzi0vam2g8uLH0Om80=;
        b=gVQzQwt1Fb8OcEnuG76AeAmdWvdvaZ+PV9GCruLgV+bAN0kaZngfjR4g9SfFYdmKTi
         hLVgUpZG93FDnzam5cPEOOlc1DGRtIO9oJM/Q9aOo1/CoFBPS5rb+AezueCuT0y67oHy
         vOAwKhoocXv1uw5jVa77z0xjbwxAiYTLBqK5r/VMXy1kRmpDqNwjanc7DHghgRjNUDgH
         4eS755lR6ynYquhD3FGquUhLuMHg8zoHItLpsXpSRstTHtfc48o/0H0o1HqTCfQ3BBVW
         vi+V8HXQGNdq0MNCQ1xkO95NnNwy9WFCj9t/Qhh0WWAIxzQuR7DVRZK4SJzbhKQG14Fd
         yGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777360; x=1747382160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LxnEOfMSdtSDZ2MSZ22NEolidRzi0vam2g8uLH0Om80=;
        b=ijNVZV1KNGfGIBFvt8WYy1kA+IztZ+PjM4Tqpv698VBQaqnwOh2+acQxOsvQR0fC+c
         DPJexaYGBnL0xesIvnLqjobGBdbRogmrG9X3/UB1aCmFx1hzIp3qPOZvVbUwq6kcJn37
         l79KCOroBXn0S5MdUGezYepZntd/NiFHajvfz8GRdO6X4/YwbKCnyvHh4asGYR9Vldz/
         a8mAMn/1Ivg5ZGE22Mbj73H17wE1XY9qyow4hN9Jq6ponnP9W3dLKonWEqUZSZtxv8A8
         Asq5VRr+S7GbNlJNEp2WcAiKTPNgaIZ8T30Zi8yx9OinsEpOcWLr9GfwCULbECZ5OBPc
         fH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIGZrfagUAioE8tNYOn9AT6PVSsmAWSJPliszJ0HzXOb6ff8Eu6/kNuBaWyfZl6vjbJ1NHMHhgpRZm2gmopA==@groups.io
X-Gm-Message-State: AOJu0YwXpx7u5iBKwlOvZXdYAFGUMy4cDsI0Vp1qTfG4yb4BxnahpD0p
	SpwZD72cBlRQE3fF/+CJjt7nnUKrJiVFQdtP6t6pgJpoY2/DAfirlQ4ab8dmTc8olqAvGDhML7P
	u
X-Gm-Gg: ASbGncsGOWEUODFgeVwpoX/qyIrXAlVwwcVc8OYwmBntR7OY65OB0uIqh9Yu7SXuJnY
	878ErWm9Dbs32F+1rxybSwVvs0g3SBEseBlTEGv8NbAGfFCnVtotGguo97HBp2XQl9OXQXd5ztZ
	ulZ+YKDKdkI030T1kddbQiM5HpQjaWpzODEKqACl5ky+xufi7KKMtcQvL3Dtkw0QpvgQdfBGEVN
	J808M07toL9lr1Ft62/jpRQ6u/q0XcVfmlViYMrRB3w8PIcBuhs84Uaa+v1ndnTOZqTOOlEnL1Y
	3cR5PBhzlHJMtTQ2SbVY55W8gA6e2Jk1mwTzghIYXcCj2uXrFpQ9Rhqi/BIy3eEeVAj3BkomeNb
	cluBVsowkBdYVSDE=
X-Google-Smtp-Source: AGHT+IF9pb8nPrtyTDDdVnYfv8x3EqBsFV1lbQQUOmc5MqsrD8OKuk32cSdTKu+oM1gx+nMrz/sydg==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-442d6d64aefmr17811985e9.15.1746777359759;
        Fri, 09 May 2025 00:55:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d77e6943sm8587355e9.2.2025.05.09.00.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:55:59 -0700 (PDT)
Message-ID: <bc9aa7de-66b8-454b-b709-bf5e7f294fd5@linaro.org>
Date: Fri, 9 May 2025 09:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 1/7] usb: onboard-hub: Add support for Genesys GL852G hub
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-2-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:56:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2684

On 09/05/2025 09:02, Anand Moon wrote:
> Add support for the Genesys GL852G USB2.0 Hub on Odroid C1+
> and Odroid C2. The GL852G driver trigger hub reset signal
> which toggles the gpio.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Still some issue with USB hub on Odroid C2

What does that mean ?

> => dm tree
> 
>   vidconsole    0  [ + ]   vidconsole0           |   |   `-- vpu@d0100000.vidconsole0
>   display       0  [   ]   meson_dw_hdmi         |   |-- hdmi-tx@c883a000
>   phy           0  [ + ]   meson_gxbb_usb2_phy   |   |-- phy@c0000020
>   usb           0  [ + ]   dwc2_usb              |   `-- usb@c9100000
>   usb_hub       0  [ + ]   usb_hub               |       `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |           `-- usb_hub
>   regulator     0  [ + ]   regulator_fixed       |-- regulator-usb-pwrs
> ---
>   common/usb_onboard_hub.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 7fe62b043e6..39bbc1aefa2 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -227,6 +227,10 @@ static const struct onboard_hub_data usb5744_data = {
>   	.reset_us = 5,
>   };
>   
> +static const struct onboard_hub_data genesys_gl852g_data = {
> +	.reset_us = 50,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -237,6 +241,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
>   		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
> +		.data = (ulong)&genesys_gl852g_data,
>   	}
>   };
>   


