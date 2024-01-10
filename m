Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BFC47073
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 18:50:37 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.1802.1704912635901512777
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 10:50:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FZealOoa;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e43fb2659so40358435e9.1
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912634; x=1705517434; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWJBa8cFc1FCojmIRs7ra/sWSczM6Wncqn1pKohtU3E=;
        b=FZealOoaKwnzpo9b9BYLtxYJNWJvYPsqfmBKI3BFl7HpHEwRO7hVjQFFa8m1azCe8I
         jPPp8S39uwCCX2S/j1+lNOF/3MbtIYrwDHbNo8YDnNNNJCw4ZZDRfOJrEp7PfkY/7c2N
         +OAryIMO00jp3MjEcwzYazoIS5vH/RCO0K18JRBOoFCXZOpOIDLlGNuqas+zmS9kROIA
         SZxDFwU/x41TfVS1imkn920k/w8Wm5ebSQhHCi4JM7P+I4dx8oXGtBhml05s7aDe2NBD
         BStuF+8tT9pNMJulRWpA7vZRevrBn/PnYFevzh6yNAfBa11YvoFO3Cz6GbEPJGwuBm5S
         HSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912634; x=1705517434;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FWJBa8cFc1FCojmIRs7ra/sWSczM6Wncqn1pKohtU3E=;
        b=Z7XqUFMIyK4az1RocTTNEEaW+4HM+MPBdNDZ7niQJDt56o5VakW60+dLlewF6zynkt
         WDAQC7j7C/yk/hk9i88HbP7ddpg/a2UuCOfe6sWaQdYmxwHCJDdwf8XNNixgeG9ZPmFj
         vWElrwTYVFcRUl4P/kWyAnqpmcu+XXW+nADogkPTo4RYXxxNEAu0Ifl5RdP5GWCTtIbI
         JyMg3wkMsUSMhnrN/wDrDyU+oHzqQKnBpzrCIFDw1tpVMWiI/Nb9fagkU+VdO2KOTyDb
         uRRc9koywqXbHztvANn2ic3RguTGs2nMsmy2fR8TBFxCoNp7z0qXbsb56Kt4muL0wdLw
         vKBw==
X-Gm-Message-State: AOJu0Yz+aHPSReWy5TiqL/Zh2zAtaI850oaJcXLU2/ig3sd2sKpguBTp
	s14dv9O+ZMQYba9O0x+DTHe0TAlf5M5FdSd/AqZzgSiRgAsNMOBF
X-Google-Smtp-Source: AGHT+IHU9IUeGihF4wQAz8Pqj9KY7ONkTaTB1ffMGb7ZaMm7ZrAP5fL91Od6DQRx3YOwQC15snN5Vw==
X-Received: by 2002:a05:600c:4293:b0:40e:4d21:6729 with SMTP id v19-20020a05600c429300b0040e4d216729mr789847wmc.71.1704912634212;
        Wed, 10 Jan 2024 10:50:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5dee:51de:9349:2adf? ([2a01:e0a:982:cbb0:5dee:51de:9349:2adf])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0033719111458sm5458864wrq.36.2024.01.10.10.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:50:33 -0800 (PST)
Message-ID: <056e0dc2-d3e2-4b78-bd1a-c19dce447be0@linaro.org>
Date: Wed, 10 Jan 2024 19:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Content-Language: en-US, fr
To: Sean Anderson <seanga2@gmail.com>, u-boot-amlogic@groups.io,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
 <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
 <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
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
Organization: Linaro Developer Services
In-Reply-To: <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 18:50:37 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2056

On 10/01/2024 16:41, Sean Anderson wrote:
> On 1/10/24 04:23, Neil Armstrong wrote:
>> Hi Sean,
>>
>> On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
>>> Amlogic SoCs embeds an hardware clock measure block, port it
>>> from Linux and implement it as a UCLK_CLK with only the dump
>>> op and fail-only xlate.
>>>
>>> Based on the Linux driver introduced in [1].
>>>
>>> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
>>>
>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Should I take this via the amlogic tree ?
> 
> If you like.
> 
> I will be doing a PR sometime before the merge window ends.

If you're making a PR, I won't except for this, so please take it then!

Neil

> 
> --Sean


