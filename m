Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF07C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 13:48:24 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.23065.1709300894663715781
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Mar 2024 05:48:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=i37jkqbA;
 spf=pass (domain: linaro.org, ip: 209.85.218.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so411981466b.1
        for <u-boot-amlogic@groups.io>; Fri, 01 Mar 2024 05:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709300893; x=1709905693; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GI0yUdoTdJaxhh/LVRaEugw/4qRC1T8OrLHfUKQHlQ=;
        b=i37jkqbAdKRuGcQjpAQE/TUdofZlcE4Gys++i6TWE0bU4S/yWbnLZkbcOBLvRwKhM3
         3wVdxaIdcJOKNNj3uffeJ3bb1zTtmLogHL7WR3WmmRcbQPzQ7xBoKQOXdqhrd5cLjm/v
         3yQb5gfIEeyCYLxB3d56pxnDTVkQT3ChPrGrbWFjZcs8ehlZwhZeQaotMhWEd9CbSOg1
         BS/G7IgOg/GY3fWTemZ7QIsHS8ed6Htel9dF8a0RpDyIEs8BITp7Y8n9HNuTi4Ywz/86
         atJV4Yddn+yL2f/7UHFA5qaCIEZ9BH4VXLy1SJ0qTrvW03BArsavyFR+K00tWynE0HeI
         WLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300893; x=1709905693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0GI0yUdoTdJaxhh/LVRaEugw/4qRC1T8OrLHfUKQHlQ=;
        b=jPLDNk8WrjyywvrCZBQz0g4o0EmUBO3GAkj77ci93NQLf7PEWBI18/pqEM+gcS99EG
         dVU+Vic4MsVBAHlbYSl3sSeYqkPJwMkUcXYEFM08TAfeGAnuEDkq5Ng1fycVLktPADGC
         6wJNrOZjZdj4opkqjsMqVzEgk8mwri+CVsclBkGKBEY/39IzkB89Hb4qLlg4IE4YCfpA
         v2rjfeuLQKarDlRiNXoLTDpK7jzNf4jMiONPK/01Ze4xmYIlET32kw7/BQeffOFwQzMV
         6K6Kx8IpfXLoEGaAO6O4MvZH5ShgyzQN5j73Wg6dTOCdwgA4shjyimj4TQHEabrLIq2s
         r2HA==
X-Forwarded-Encrypted: i=1; AJvYcCWrziXXofOXVcgJ8LnnreJBKKZXdK8mKgc/SEji35AA43fIsvYc82zeIYOUckXNrRkzPkySykCB7F5Jr8Lw/4LtT60YwE/Bq9M=
X-Gm-Message-State: AOJu0YwIF3ltC4mw3+IzmRVdYts2csWUGhBe1YP0lHN1TVGyD0YpG0jD
	MMHvXsy1Cy3B0vcPj+2GPP8uQzPFeOBsmMu94YUQfJx1MvZLnMnhXXeOkVHJF7M=
X-Google-Smtp-Source: AGHT+IGfzdCnreNKbLwPfQpzcRj8KgrXW3xSyC3x62eRqTfO4rvhdwuhQ7wvkQBb+G9vWqZ4coaaLg==
X-Received: by 2002:a17:906:29c7:b0:a44:bb64:9d0f with SMTP id y7-20020a17090629c700b00a44bb649d0fmr144224eje.72.1709300893003;
        Fri, 01 Mar 2024 05:48:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8? ([2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8])
        by smtp.gmail.com with ESMTPSA id w13-20020a05600c474d00b00412c1d51a0dsm4179837wmo.45.2024.03.01.05.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:48:12 -0800 (PST)
Message-ID: <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
Date: Fri, 1 Mar 2024 14:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
Content-Language: en-US, fr
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 festevam@gmail.com, nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk,
 paul.barker.ct@bp.renesas.com
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
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
In-Reply-To: <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 01 Mar 2024 13:48:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2150

On 01/03/2024 14:30, Sumit Garg wrote:
> On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
>>
>>> Changes in v6:
>>> --------------
>>> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
>>> - Patch #3: Incorporate fix for sandbox CI failure.
>>> - Patch #6: Incorporate shell script comments from Marek.
>>> - Patch #8: Incorporate documentation review comments from Paul.
>>>
>>> [...]
>>
>> Applied to u-boot/next, thanks!
>>
> 
> Thanks Tom and everyone involved with the reviews. I hope we can carry
> forward from this effort towards a healthy devicetree story for
> U-Boot.

Thanks Sumit!

I'll try to submit patches for Amlogic GXL & G12A to switch to this!

Neil

> 
> -Sumit
> 
>> --
>> Tom
>>
>>


