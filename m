Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA5C5321D
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 08:53:41 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.11863.1724403213301273031
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Aug 2024 01:53:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=JIKXQpgj;
 spf=pass (domain: linaro.org, ip: 209.85.128.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-429e29933aaso12551215e9.0
        for <u-boot-amlogic@groups.io>; Fri, 23 Aug 2024 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724403212; x=1725008012; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFizrNLBGJfQBmXaxS7CRPlSxBfoe9oXjYU+fV7ZdLg=;
        b=JIKXQpgj3HqLbzr6r8S/kxa1xc2fetFamIPLEpor6/Pdwme8xImO+IzG8d7RsSz4RM
         Nwam58VylVRjT+lQeOlTGWrMlJbI475LFk0/U+QYmrdUKgwLNcChCJktQ8QLKQkapKZy
         DcCCIWAa3YWNfz+Etrf4VuxoVwhtPLrIY+H4hoQGvS01BFN/rJCTcD29zfvGH382h80L
         cDlKO9JzOlCIAX7w3UsEhLkR77EzA/NHI3mw9qa4l4KUIBVZ3pqGdeVhlU7nnTZ9Y4PY
         pb4YgpGuediVKwibpHrHy/xg6TmDp3VTPkIBcVOyg/0I+eRhGuLXE/LLeNNkJru1nC/P
         IY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403212; x=1725008012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFizrNLBGJfQBmXaxS7CRPlSxBfoe9oXjYU+fV7ZdLg=;
        b=dzxnd7XNc5Pj2m2ljtL90VRs+nGgTtPXqv+A2kTkdOIMwf8u2hklCNj9qqZIQl7Hs4
         H/Wzgt64Wg5rNyeGn/3t3LUuNCpUmnvXdChbr5hYDqM4POTUkrlL4EThaYQWwhGLDuD6
         Lbu6s4jtY5rTp1sA9kWeuLTDva8IXT5jHVCs4q9aEBhn7/Q/IUuvOf2ESxHnkMZhJ0Np
         McWi+zPo6vWDxkO9EaSp3XLB4/ufl+WClQWBoSMH0KZvElsfayJbB6oKadwLvfTVyx5V
         5U/Y/CbTRaT3CNu/LeJiqFa93ridGAArZ+dAQDTYTPGiCc1pgu3Izr55aIDxlTE+hVD2
         M/FA==
X-Forwarded-Encrypted: i=1; AJvYcCWm6eDilh/JVGB9lUgrisIb/DnLFbWVsmPgHTyNWJRBxd/7flVBrDa+Mqi7itRnZw16S2YQPDlWGqB66u1Lcw==@groups.io
X-Gm-Message-State: AOJu0YxF14Ck1QHQWC4O5/AfZQNSPbmbqCjUSUxe7+dDLDUbT9OLBC2i
	HSdV35RtwYeTDQoX2tQq4pUE2nNCwu2vabmPnU+g/UMy736WNAQoU3ZOHYXBvcE=
X-Google-Smtp-Source: AGHT+IEVkf0byAbk4UAUVYW0mgG3ePRv4dA5QKa2hVBp7m5fD259rKBkADwlUhgVm7xYb/3NUfVhug==
X-Received: by 2002:a7b:c399:0:b0:427:d8f7:b718 with SMTP id 5b1f17b1804b1-42acd5d7dacmr9434335e9.24.1724403210871;
        Fri, 23 Aug 2024 01:53:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:995c:3fea:6b19:4a51? ([2a01:e0a:982:cbb0:995c:3fea:6b19:4a51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5159450sm52139335e9.17.2024.08.23.01.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:53:30 -0700 (PDT)
Message-ID: <887fcb7b-5bd7-40ef-9bb5-ab9ed5079b06@linaro.org>
Date: Fri, 23 Aug 2024 10:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>,
 u-boot-amlogic@groups.io, kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
 <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
 <bb05c33e-9769-7e1d-699e-f42829255796@salutedevices.com>
 <CAOf5uw=UKXVB5H3DBzFFPx8nrXw3S44yPq=5CD+VAVHGuAmQTg@mail.gmail.com>
 <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
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
In-Reply-To: <0343aa52-8f23-4447-1827-3de7710735f3@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 23 Aug 2024 08:53:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2360

On 23/08/2024 10:29, Arseniy Krasnov wrote:
> Hi! Got it, thanks!
> 
> On 23.08.2024 11:10, Michael Nazzareno Trimarchi wrote:
>> Hi Arseniy
>>
>> On Thu, Aug 22, 2024 at 9:04 AM Arseniy Krasnov
>> <avkrasnov@salutedevices.com> wrote:
>>>
>>> Hi, thanks!
>>>
>>> Thanks, Arseniy
>>>
>>> On 22.08.2024 00:17, Michael Nazzareno Trimarchi wrote:
>>>> Hi
>>>>
>>>> I will read them tomorrow ;)
>>>>
>>>> Thank you for understanding
>>>>
>>
>> All the series are delegated to Neil. I will review anyway but I think
>> that will then pick from him

Sure I can pick them if reviewed!

Neil

>>
>> Michael
>>
>>>> Michael
>>>>
>>>> Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
>>>> scritto:
>>>>
>>>>> Hi, sorry, pls ping  😄
>>>>>
>>>>> Thanks
>>>>>
>>>>> On 08.07.2024 10:13, Arseniy Krasnov wrote:
>>>>>> Patchset is based on patchset for Linux (today merged to nand-next):
>>>>>>
>>>>> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salutedevices.com/
>>>>>>
>>>>>> Here is description from it:
>>>>>>
>>>>>>   >  Amlogic's boot ROM code needs that some pages on NAND must be written
>>>>>>   >  in special "short" ECC mode with scrambling enabled. Such pages:
>>>>>>   >  1) Contain some metadata about hardware.
>>>>>>   >  2) Located with some interval starting from 0 offset, until some
>>>>>>   >     specified offset. Interval and second offset are set in the
>>>>>>   >     device tree.
>>>>>>   >
>>>>>>   >  This patchset adds R/W support for such pages. To enable it we can
>>>>> setup
>>>>>>   >  it in dts:
>>>>>>   >
>>>>>>   >      nand-is-boot-medium;
>>>>>>   >      amlogic,boot-pages = <1024>;
>>>>>>   >      amlogic,boot-page-step = <128>;
>>>>>>   >
>>>>>>   >  It means that each 128th page in range 0 to 1024 pages will be
>>>>> accessed
>>>>>>   >  in special mode ("short" ECC + scrambling). In practice this feature
>>>>> is
>>>>>>   >  needed when we want to update first block of NAND - driver will
>>>>> enable
>>>>>>   >  required mode by itself using value from device tree.
>>>>>>
>>>>>> The only difference is that patchset for Linux updates DT bindings, while
>>>>>> this adds NAND_IS_BOOT_MEDIUM flag support.
>>>>>>
>>>>>> Changelog:
>>>>>>   v1 -> v2:
>>>>>>   * Pls see per-patch changelog.
>>>>>>
>>>>>> Arseniy Krasnov (3):
>>>>>>    mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
>>>>>>    mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
>>>>>>    mtd: rawnand: meson: read/write access for boot ROM pages
>>>>>>
>>>>>>   drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
>>>>>>   drivers/mtd/nand/raw/nand_base.c  |  3 ++
>>>>>>   include/linux/mtd/rawnand.h       |  5 ++
>>>>>>   3 files changed, 65 insertions(+), 27 deletions(-)
>>>>>>
>>>>>
>>>>
>>
>>
>>


