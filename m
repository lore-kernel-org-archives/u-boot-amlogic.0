Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77857C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:58:22 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.9206.1746777502012556558
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:58:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wlaPUn44;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so19047985e9.3
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777500; x=1747382300; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLe/IZ4rXnBdZgnZ4/eWyXuOlnh9tUiYke1zR9KxH1c=;
        b=wlaPUn443zclsIQgWuMxcuH+7wDGGul3OK+iWoIFEn4ljkmohPLUEXGzwvhA/3Qams
         bg8BIdLJfB6zchsncQE00NB3iaDqDVuAK7fTRhyiAZyVk6Px2tt4UzC4TlgPy1YVEwYH
         gWHX8zpSsCShizFMjfTak6/GLuwllYvySuObNeybQWSz2eFTa4YnaNHaEJskrSo+E1IQ
         hBKr7JwprPazw99gXYmnqJqaOWNX+vDlVyG7X/Oui44wL1DXiG/ljO2Ugxl6D4ueqQVF
         z+ziN/0JmuAyKTYZ9daV7/rk2EY9XypIIYzDuO6dehnn9+QZ2Aqi9tKTXaYu7veCyodD
         EspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777500; x=1747382300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sLe/IZ4rXnBdZgnZ4/eWyXuOlnh9tUiYke1zR9KxH1c=;
        b=wn0aeaStRtcxEvDNHOhI+giHIREGzZReg1CHSzAGeDsmFmQfFs1eHhfSuSVHEhGLZs
         FuwNl1Lg3wQlfjtv87vHe/ASOxgkpbUc+nf0emML0NSRwKGVQdv49gtHF7J+n7GQa5Mi
         dKAdTWMi8qxfaS6h7Jb0H8KKs2+Fs5iGT1OP2WK5NvcunMENBS+zn7tUrIywg5BOgL1r
         N6ITVoqPgzRMRpVXErAScoVq+Yi6h2MIlboWwi5mTqWtnvL+dMZdKcqi2NJTvWBE2m2G
         4bdTDMcWebzl8aoPDidEMG2bebjugjRg8ryFeVa5ZAvrT+4uVTA5aS/rcePPwxnMI0HG
         YkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR2GX0mOAWGHQtkeDqO3y+lQ1GlIZP6/WWlw7UO2x6fWEgxeGYnhQ7sJsuN323tFaRBmawTxaPdL2IpeP3hg==@groups.io
X-Gm-Message-State: AOJu0YyHsXz1t7Y/DejXYq1CkqF+Q2pYdbcWtRUVWbaItelYB/aVou4J
	D2w92mu/QZHp+KSY6JcH/55+T1TBJTgs3Y7dCYAmEGDzxNHQJ6th0SmmMskkm74=
X-Gm-Gg: ASbGncuzQZm/kRvohHWyG8KCqoB3B37vO4WkStQYjODlQ3I+x221nejFtsAvVnmxUu+
	3J+qpE64RKjbw2nuvM/hHFG4FcXM0S+HjBT0ikBjQlvPEKcvtHWRoYgRtQycbHsbokHuNlPsf2w
	Z4QKcixGx92JKCulVtnbhByA78ALfTVDAFfBlY20T7bOONP29IaU85zYGVOuYxtgkx+9qfdZR1j
	jZkNBqlI9MVjcwgn8PNosigRO+0TLcccBudJpvABY/k24GHRUOhu5vNdDmzG9t+NaaDLOfvidDE
	9AXkbvq4y6Z5H5XX/I6axklJKhTV/PGpQux/EY6uhJ9do9wJq3m6OKrSbkKNnlM7scxcdbfrOQq
	Nk/k6jfOREEtn4LVuAGANyGmHTw==
X-Google-Smtp-Source: AGHT+IGurNYMve6HR6jhsSK8a2GA1GX0uhAtMDYOzVLPjYGeG5eoYCcQ6PxJYZKonFoVPI9c/Z0X0A==
X-Received: by 2002:a05:600c:4e8f:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-442d6d44d0fmr19199525e9.13.1746777500386;
        Fri, 09 May 2025 00:58:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d6bf96bfsm20245885e9.6.2025.05.09.00.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:58:20 -0700 (PDT)
Message-ID: <a51537fe-0960-40da-a039-e112a7d8413d@linaro.org>
Date: Fri, 9 May 2025 09:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 5/7] usb: onboard-hub: Add support for VL817 USB hub
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-6-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:58:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2689

On 09/05/2025 09:02, Anand Moon wrote:
> Enable support for the Via labs VL817 USB2.0 and USB3.1 Hub
> on the Odroid C4. The Via labs VL817 USB driver activates the
> hub reset signal, which toggles the GPIO.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> => dm tree
>   simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
>   usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
>   usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
>   usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
>   usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
>   blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
>   partition     0  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:1
>   partition     1  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:2
>   partition     2  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:3
>   partition     3  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:4
>   bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
>   usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
> ---
>   common/usb_onboard_hub.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 3914e2f773d..1242513c631 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -235,6 +235,10 @@ static const struct onboard_hub_data genesys_gl853g_data = {
>   	.reset_us = 50,
>   };
>   
> +static const struct onboard_hub_data vialab_vl817_data = {
> +	.reset_us = 10,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -251,6 +255,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
>   		.data = (ulong)&genesys_gl853g_data,
> +	}, {
> +		.compatible = "usb2109,817",	/* Via labs VL817 2.0 */
> +		.data = (ulong)&vialab_vl817_data,
> +	}, {
> +		.compatible = "usb2109,2817",	/* Via labs VL817 3.1 */
> +		.data = (ulong)&vialab_vl817_data,
>   	}
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

