Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E1FC35FF5
	for <webhook@archiver.kernel.org>; Tue, 17 Sep 2024 08:47:07 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.16532.1726562826946657724
 for <u-boot-amlogic@groups.io>;
 Tue, 17 Sep 2024 01:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Hy/pvfTP;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so41531645e9.0
        for <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726562825; x=1727167625; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBUV6n6NEkC5vvZsjQldFMYu+CW4jRrd88sDOtNfCmo=;
        b=Hy/pvfTPh2Ck/8HaRbTyJoQrF4rcjYxww16tsdvatoq1twYTCHhXST1GfC1rgd2zOa
         BAs1IayYhXyQBGX4AIN58TJbieAbm9LcIPBV6lRDoWUffoptpIdnHZFXle3/mxgVynhy
         iv+JISmjbgSN6y5phYUcJ5A4SPXbegP9XPBdaZQ+1fUriLuV/XPRmEyAHBGBJcCvUfXS
         T615NUyRiHSgjQDeQMmWsWvpYYlZJGRS8LMJ1gX21/5cwjgXobMVDG/YkFR1jiauS7iV
         dwhoF7JpiIXHqR5CykT+pKO9hnuZII214iFm4B+YmlQZcukRQ0H/ZLApJgMRTODLXTty
         Z+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562825; x=1727167625;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBUV6n6NEkC5vvZsjQldFMYu+CW4jRrd88sDOtNfCmo=;
        b=naXaD8PvyVTBMkikdT/MK67MqOwfuL4+gJopxLN9BHZE8xqkY1PNJSlJK5Ed0A6omS
         FI9mHworxwvF7nhs3Q8u9I5d01lQqtLgdx029zphizl4MbwWL16vAd9zS+LMDzNSR8H8
         qDmk3hrv4uWquLZtf8JX4DpQEk/vGz7oPM53fkoYToUmsoo4EYnsHXXU6g2d7SJtNwrw
         DLCizDR2/mgktSWBdkRxRX5ScbUacfhPNZCzcjX5a3NPe/sMKfmSyuUXb09tsr3H/8Oq
         eDpg0PSof7QB/m6PEkRvuraplk8TA/iOw95DfY5HxuIQerE2qWC8pQUqyUMIdNrqNs3Y
         LEPg==
X-Gm-Message-State: AOJu0YzjWhihXxMjJ+SeCtVH/E2fsLS31TCAE3UW9NLRa3rrPpNvSKAq
	qnkc+tburLt1EltkfbEgO4SP2vI2e/Eh7FIM2e8Qo7LDn9VVEsyOeco0ZUy7YEu7BSE68zcaPy6
	E
X-Google-Smtp-Source: AGHT+IFA0FUnt+jReJfc6DnmCAVwl8Zdf7JRzBYuDCF/OrQ2xhca/Zf17WLXcz4ZNsQFkyTcDl0OrA==
X-Received: by 2002:a05:600c:1c27:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-42cdb572754mr121671575e9.33.1726562824551;
        Tue, 17 Sep 2024 01:47:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf? ([2a01:e0a:982:cbb0:e5df:ee06:f22e:a8cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22e8292sm97960535e9.26.2024.09.17.01.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:47:04 -0700 (PDT)
Message-ID: <730c32ea-bf25-4bb1-bdcd-5afa17d39f07@linaro.org>
Date: Tue, 17 Sep 2024 10:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI Capsules
 Update
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
 <20240916162912.GF4252@bill-the-cat>
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
In-Reply-To: <20240916162912.GF4252@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Sep 2024 08:47:07 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2390

On 16/09/2024 18:29, Tom Rini wrote:
> On Mon, Sep 16, 2024 at 11:41:47AM +0200, Neil Armstrong wrote:
> 
>> The necessary changes were made in U-Boot to easily support
>> EFI Capsules Update and be compliant with Arm SystemReady SR.
> 
> To be clear, "SR" or "IR" ? I assume you meant IR here.
> 
Indeed IR, I'll fix in v2, I need to send a v2 because I need to
add set_dfu_alt_info() to keep support for the ram backed dfu I
used when booting from USB.

Thanks,
Neil

