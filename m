Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A05C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 07:58:32 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.9208.1746777510744700101
 for <u-boot-amlogic@groups.io>;
 Fri, 09 May 2025 00:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Q55l+FOU;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0b6aa08e5so1701981f8f.1
        for <u-boot-amlogic@groups.io>; Fri, 09 May 2025 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746777509; x=1747382309; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkiRHoKDT6dfwcEIriCYxav2MxpbA3FzZHfgt19y4No=;
        b=Q55l+FOUBKs0npInOMcLaaLk1rZcGQYaIysBAKHgLho4Mg8Fs+r/7T1KFFcyNQv3/v
         eInpVj0z7yCAJuBMZCDpLokzpDABs1uVZs9P5cPwh/iodsvV/MyZyLgFZvN8iI2y3veN
         q+JSEjGu2bb+gHJCJjFDcyNsz03rsS6OayED71Z0xqCtWWP4gaRPvCtgp3G2EY1tK0h1
         zt8mH4RPHujI20uHUmOHRPRGk4071WrKaxKVIWQ8uyRgF6fsb/hcfgf4btyfbfXIp0fO
         hxWftVxI6uypPauPLAgSuceyuiNHzEz+CvoF8FTfZ1UubgN3oyO+Z/jHOkxO//vCvQH0
         Wndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746777509; x=1747382309;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkiRHoKDT6dfwcEIriCYxav2MxpbA3FzZHfgt19y4No=;
        b=o4LLN02ZEJmzwJl9ZaZxe/xSyL0IRSTxacQDkMC/9Sp/fEu2EmyYGUgT3eQwqI5LMX
         elLtczP6fQp/KPpN2q5dacwimfyEui2+sKpNlenNPgO7aBE2RPE9jMvdlsguOaag536/
         eInVCbNS0GNHx84sqUbM8Zd/G7pH2NCW7duUWAlAvj16aWCnZUt91Z5ERlE214VtsiTJ
         CPHA1Z15fD/bU36CUJV+bTwZvtNrgJN3DDeADzX5sY9u71egEnrAp3V/gZODGFY5DZ4t
         qrqw7tx3RXYkujXuSB0tavX8s4nNiike5BW0aD7JG6h4DBmuDVYxmY15qQtReUIY8Bii
         pcWw==
X-Forwarded-Encrypted: i=1; AJvYcCUlbozxwkbOVpK4QI2+M4KBERt3koLA6KsoD/gC5CMuC8McJl0bbPltwH+uPhfXAD1Wiv9PjZisBaOrNBwwfw==@groups.io
X-Gm-Message-State: AOJu0YxVWQQj7T2KINzZsuUEDLoqnLW8zQQ4LZgV2zmSBgrEJZHP+qFH
	1x0eKzI6TekK4hJ/0VOP5OPNiLdDRFP+0iBGuDO3bgP8ojO6KblRQWPYUiTNlbc=
X-Gm-Gg: ASbGncsmrKO+IhGnlJHwunGm0d4QV2WvUT6pl1ROw4YaYOM5yd8Zt8hn5KtdcktbIVp
	8MWgVRA7AFLMqyKOvsqNmoLt5y7hskvKLmJP+i/j9NxPHWpqeVoLsidDNus4Sp/EFwfL/+KakS4
	I3fXgQaDHZp7K/zE0b08m9CH8bFsqMueUE82H7kR64MyKhlB8pb6S70LvBsnRgjReBIw+fRuKWI
	sg3V95pby0BvOO2G/XC9cMfQ2VSfz6UdvAOfeK6esJVOwgoI6hNIXrbxA5t4nje7Tpgd6yinJ4d
	c+gWAruQIuJBqgBojKZAYtj1uGT1yc/qYBMas82+5SSfzcoeE+CRxdB3jPSJedcTx9PQOcpXy2j
	M+ZKxprMpGybGUio=
X-Google-Smtp-Source: AGHT+IEuJmBM+CdYS5KBJ4IWwiMue73kIeV+s4wAv1ePa9EslYF2wv4iYUn+0nm2jS48gWRHZkAIvw==
X-Received: by 2002:a05:6000:1a8c:b0:3a1:f538:d9d5 with SMTP id ffacd0b85a97d-3a1f538da17mr2859321f8f.28.1746777509187;
        Fri, 09 May 2025 00:58:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2? ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f28f7sm2408158f8f.41.2025.05.09.00.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 00:58:28 -0700 (PDT)
Message-ID: <e152f223-6002-41a0-ba64-960fc4d3d9f7@linaro.org>
Date: Fri, 9 May 2025 09:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 3/7] usb: onboard-hub: Add support for Genesys GL853G
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-4-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 09 May 2025 07:58:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2690

On 09/05/2025 09:02, Anand Moon wrote:
> Enable support for the Genesys GL853G USB2.0 and USB3.1 Hub on
> the Odroid N2 and N2-plus. The GL853G driver activates the hub
> reset signal, which toggles the GPIO.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> => dm tree
> 
>   simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
>   usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
>   usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
>   usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
>   usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
>   blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
>   partition     0  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:1
>   bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
>   usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
>   clk           2  [ + ]   fixed_clock           |-- xtal-clk
> ---
>   common/usb_onboard_hub.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 39bbc1aefa2..3914e2f773d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -231,6 +231,10 @@ static const struct onboard_hub_data genesys_gl852g_data = {
>   	.reset_us = 50,
>   };
>   
> +static const struct onboard_hub_data genesys_gl853g_data = {
> +	.reset_us = 50,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -244,6 +248,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
>   		.data = (ulong)&genesys_gl852g_data,
> +	}, {
> +		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
> +		.data = (ulong)&genesys_gl853g_data,
>   	}
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

