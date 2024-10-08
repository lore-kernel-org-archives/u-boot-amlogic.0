Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CACEFC23
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 15:15:32 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.11789.1728400530191566822
 for <u-boot-amlogic@groups.io>;
 Tue, 08 Oct 2024 08:15:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CmuemyNI;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430576ff251so2858955e9.0
        for <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728400528; x=1729005328; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esCOiD63IexPslStwAMxogPyByd0wbNEbF3bPl2FFwE=;
        b=CmuemyNIOlYJJHj5fp2n1mHa0V6pr0Da4DVNJVO/GeUo6LaGigqNwkWEr3XCPXgf+2
         +iWWovzRfhE/WcGAPsvnEYKlnHfY1pxOLpYJuBFjMw1eLtHE3QeFpG1ZZHCtHDXyZlrf
         wKcmal6dxMst55pICQWaxms+RgjcmiSgOkkZMP9zW1suvfeLWtEN1n4ObAOdWpCPYMdv
         x4CRuRfT1EPNpE0Oq0YrSkLcYRrg+yavVXcABvOdY0MMxOKtu1oawvxeNbyOrzus9dBq
         KMzTykxBYWtVGaO5cblyua5pbC1/6CYt7dqebS5K2gdCX5lTvgNUO0XBZqsWsirTvuSx
         EkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400528; x=1729005328;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=esCOiD63IexPslStwAMxogPyByd0wbNEbF3bPl2FFwE=;
        b=IIc/z/o149f24rMlFs2I17HYG4ySup9YcXEEUkYB+lsp9OopLTf3NHFhRr0RSCkc5M
         X44lP1fj4pfrBhaaqf4Q7RdP8qrYmDjiRM+49n922NPffFXszhNce9U6iBxIuDMKTflv
         ZFkE4/bl7ddW3KpmiDiUlHE+29GVjJ3qH5W65zIYSHIS57bFf2tg12xZcM0zTKSw77vz
         PQh3PT6IfVBrYrNYvqtD956faqGEV+O2D9nDS669QctxH2ndxO4KJf4LMB6coTZoX4uG
         AdVRRKc+jU1fPCMRhrSKI9doZkoRRtsoFwcXn8TzDT4RYLFYMgXqg3vpF3Yuf8IBhDs6
         X8BQ==
X-Gm-Message-State: AOJu0YwpYUo/3HfvYelGpZ9t2BeNaBGfNMKTGuLslq4pjajBh+Mm+BOy
	xpud3J/4MVVeZmA1gpl1sz4AELGjoUI5SOxX5AJ/WwBwOEMEftQRI4Bp4BOKeT/52puJxEDIYcw
	Eu3w=
X-Google-Smtp-Source: AGHT+IGr/mcTbpyN8X7wjJ2gxsdleRxQexn9fQJeKyjLWz/laeNIMxx/JDilDT3ktTqTNXknDr63fg==
X-Received: by 2002:a05:6000:b08:b0:37d:377d:c7b0 with SMTP id ffacd0b85a97d-37d377dcba2mr702050f8f.18.1728400528453;
        Tue, 08 Oct 2024 08:15:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d376009a0sm707676f8f.88.2024.10.08.08.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:15:26 -0700 (PDT)
Message-ID: <c89b43b3-7e48-431c-95bf-d88a6c3fc091@linaro.org>
Date: Tue, 8 Oct 2024 17:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
To: Jonas Karlman <jonas@kwiboo.se>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
 <b0174edf-5055-4c67-827c-2edefbf969fa@kwiboo.se>
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
In-Reply-To: <b0174edf-5055-4c67-827c-2edefbf969fa@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 08 Oct 2024 15:15:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2431

On 08/10/2024 16:36, Jonas Karlman wrote:
> Hi Neil,
> 
> On 2024-10-08 14:58, Neil Armstrong wrote:
>> If the regulator is already enabled, this happens if the regulator
>> is set in regulator-always-on, regulator_set_enable() return -EALREADY.
>>
>> Ignore the -EALREADY return since it's not an error.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/video/meson/meson_dw_hdmi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
>> index 587df7beb9b..ee219ce6ec4 100644
>> --- a/drivers/video/meson/meson_dw_hdmi.c
>> +++ b/drivers/video/meson/meson_dw_hdmi.c
>> @@ -419,7 +419,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
>>   
>>   	if (!ret) {
>>   		ret = regulator_set_enable(supply, true);
>> -		if (ret)
>> +		if (ret && ret != -EALREADY)
> 
> You could possible relax this further using something like:
> 
>    ret = regulator_set_enable_if_allowed(supply, true);
>    if (ret && ret != -ENOSYS)
> 
> That way you only reach the error state when there is an error with
> supply, for other states e.g. when supply is not found, DM_REGULATOR=n
> or the regulator is already enabled will be treated as success (ret=0).

Nice, thanks for the suggestion :-)

Neil

> 
> Regards,
> Jonas
> 
>>   			return ret;
>>   	}
>>   #endif
>>
>> ---
>> base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
>> change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb
>>
>> Best regards,
> 


