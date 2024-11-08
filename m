Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087DCD5E14F
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 10:10:34 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.9540.1731060620491080321
 for <u-boot-amlogic@groups.io>;
 Fri, 08 Nov 2024 02:10:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LBl8Xu5v;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1127932f8f.3
        for <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 02:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731060619; x=1731665419; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9s9wQSK+zE3ZeyEW821Io6phZev57dH2YRnq+c1lI4=;
        b=LBl8Xu5vj3RKY9Wdh3tff0YHRVg9G+H5NCrTemt3l8nFAGWUVTKFD8PH43JXDhpJ5v
         au0YVk1OqqUhXe0leJic1u04bPXOqFkRHI/lK095LUYOCtl0OGpvV2iFq/BLYjKpD/xP
         ZltHNilfIYJUoZlb6gt+pPDEgveyjRKWf67juncNcpolmlxw72gcHf5tmqPljaLAvN8B
         F/aUq1rIkus7lAcq5JgPMxFw/lpFQd5R7XjWXqTGUx+svUPrqA00SB3dBsCWcpZ+K8z7
         VXlZxHNpUpixjFX+d6bhRKeCHGbj/FpibuKHr4rdJc/n40R3+CQSr3/WFMdruqAqqNfz
         ZY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060619; x=1731665419;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S9s9wQSK+zE3ZeyEW821Io6phZev57dH2YRnq+c1lI4=;
        b=qwPNECYRrPLLg7LDeWHHrzifYgvwYFFop/yE9FVZ62YpSjQgK9e9eNls87K+k6HM96
         z1sM52B85EM6HRkcmJS2hOjHKCC50TW+aYfYNLlLGWP6FGq8zY+y3goeRD3BZzD+NQHk
         piT9v+zeNBLm/JgZBCIybB48unS8HEKUdjq9Jp5xTvNazpOa/2DlZ+oT/M2gh4uEYrrL
         3DNMIkd3cknhnI4Fup5sJ3j6soJP+4Ncm+7A4nR0aUSfZHeNmVk7irAEanqK1/gpLbN6
         PhHWLIgBYlz4ROpFMLV78xGkiUAWlLpMpd87Px6rldS/lGpL+/wzsCEs91Jzbl+SKmf+
         Qq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvJWAUQGyHdZjpzaz7EaA/1SUdcX0GXNrAeh2OngsrJ3ZBQbx6xN5JZfRKxafxlgy/1hbHP0tXx4BOnWBxPQ==@groups.io
X-Gm-Message-State: AOJu0Yyc5nSUHLnMHDeUiZsSWMmiMNRhnNzTfx5M2aacOZ5LdxUh3dw4
	VKReQOExVdb/woPVY4j45VdcsXwcLi1YYuFUlw5C3I4Ua0grQ+xHnHeBExvPNO4=
X-Google-Smtp-Source: AGHT+IFkNvm79j/hELKkG2tYJq01oKQ6G6LjjaUl0SrF5t1KipAjhWmutVwwWeTia/jr1ki9X0dV8w==
X-Received: by 2002:a05:6000:184b:b0:37c:d558:a931 with SMTP id ffacd0b85a97d-381f1873086mr1645649f8f.31.1731060618869;
        Fri, 08 Nov 2024 02:10:18 -0800 (PST)
Received: from [172.16.23.252] ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm4080686f8f.61.2024.11.08.02.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 02:10:18 -0800 (PST)
Message-ID: <fd46ba38-29e3-44df-a4d5-e520119f23a2@linaro.org>
Date: Fri, 8 Nov 2024 11:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
 <87msia3urk.fsf@baylibre.com>
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
In-Reply-To: <87msia3urk.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 08 Nov 2024 10:10:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2538

On 08/11/2024 11:05, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:
> 
>> After increase boot and recovery partition userdata was not resize.
>> so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
>> $partitions` fail because end of last partition is outside of eMMC
>> size.
>>
>> Remove 64MB on userdata partitions to fix it.
>>
>> Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
>> partition size")
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
> 
> Do you think you can pick up just this patch ([3/6])?
> 
> Since it's a fixing a regression that I introduced I'd like this to
> picked up without depending on the rest of the series.

Sure I was waiting for your go!

Neil

> 
> Thanks!
> Mattijs
> 
>>   include/configs/khadas-vim3_android.h  | 4 ++--
>>   include/configs/khadas-vim3l_android.h | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
> 
> [...]


