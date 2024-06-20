Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB32C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 07:39:59 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.42237.1718869192156224498
 for <u-boot-amlogic@groups.io>;
 Thu, 20 Jun 2024 00:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WEsE9GqD;
 spf=pass (domain: linaro.org, ip: 209.85.218.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a62ef52e837so57440366b.3
        for <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869190; x=1719473990; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6EU4d8LrV/Ueke3iuRp4pl3Ga+6FOrMKGxXcnG9ruk=;
        b=WEsE9GqDp3bgXR8j1/Tc2i/qHTMuHn9LYPrp+wJ53yaOpRqDjaS8PBoBohWK2v7eFc
         R6Y2wtkM/yxsdayFIIdMfu0bnTKGx4s5WVswCy2qRVjGwq7dHGnRBRZQGMjkV7bboCdJ
         drMNi3yutsSfCvTh4f0rYFk23gWfO+Kartr/isvy/5EjA1609v0RE/rDiSN38SHjxbyB
         9CB9wQIItsOQFcXHLW8LWL8uw+sx2Nn/0B8L5n2PsZg4YOKrbE8QGDfS6gTGhEcFcyCJ
         WBRwTKX8TIvjqkHzTZqi7vzirG9SoIZRg5t6wJT1bgMlWJU2cyVbD5xiGLSF4eYg5LiO
         65jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869190; x=1719473990;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M6EU4d8LrV/Ueke3iuRp4pl3Ga+6FOrMKGxXcnG9ruk=;
        b=K573NzJ8I5hNNj7rUvBTNf8FQKhbg4x4vRpnbHebKaKC8Xo8V9ylsiFr/xz804PfyX
         eenC0+aBeZmxXh0kMiogG2J4Whz8ycrX9V8VQKVrOc6OQgZGmN5tNq+H5riKBKxeiCy9
         bP5GO0Z3fqSWkSxZOjBhdLSDZijRkPNz37d92c5hcPQCy+cct/snoVIiUNfNVTPYy8jR
         1xgR1SvizSPZjj192EDqz7SG2aaBMd0sUmfxG1YqmEaQ/nD6kr80OExqnUZh4BPz+4qi
         yVMDm+5KzdCZtYL50BZwETd/mubL2iqqNCzXq0zp4BIobOu6XG44f8ayq11oei/vS1E8
         2kfg==
X-Forwarded-Encrypted: i=1; AJvYcCXDxcaTEz1Pj8aUD1lUYTAAD3dIxVLVnQh7GnHrevLeSLh+rurRQQ7gWss3GfjfE9I+gzr3kxNjq3SzNu8lCfVs4TONYvSRMn8=
X-Gm-Message-State: AOJu0YypDBEAjhKP8k5t6S7kUV/DqIwvMfKgipor/Kt0mDUsTf47J0S+
	9Ailho44fi9jbaPaYYTp8LDob14eNQiBPKv49Cvu0qt5z9APPqDuNg/A2kgYJrk=
X-Google-Smtp-Source: AGHT+IHVIfG9uxE9peIApdgp8lAzabbTupri8C9xaJNkvUnb5Xxk/2En1LFiSwPAtMvYajH1HaCOiA==
X-Received: by 2002:a17:907:c31c:b0:a6f:1378:1329 with SMTP id a640c23a62f3a-a6fab607142mr368624566b.4.1718869190507;
        Thu, 20 Jun 2024 00:39:50 -0700 (PDT)
Received: from [192.168.7.32] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fc3f3efb3sm25753266b.15.2024.06.20.00.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 00:39:50 -0700 (PDT)
Message-ID: <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
Date: Thu, 20 Jun 2024 09:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
 <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
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
In-Reply-To: <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 20 Jun 2024 07:39:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2306

On 18/06/2024 16:56, Marek Vasut wrote:
> On 6/18/24 9:55 AM, Neil Armstrong wrote:
> 
> [...]
> 
>> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>>   struct phy_ops meson_gxl_usb2_phy_ops = {
>>       .power_on = phy_meson_gxl_usb2_power_on,
>>       .power_off = phy_meson_gxl_usb2_power_off,
>> -    .set_mode = _phy_meson_gxl_usb2_set_mode,
>> +    .set_mode = phy_meson_gxl_usb2_set_mode,
> 
> Oh, I see you did rename it here, so please ignore my comment on 1/5 . Maybe just mention in the 1/5 commit message that the rename is happening in follow up patch , if you are doing V2 at all .

Sure, let me update the commit message,

Thanks,
Neil



