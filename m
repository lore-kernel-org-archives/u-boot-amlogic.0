Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F529C4332F
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 07:54:47 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.58207.1702626885789868512
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 23:54:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iGXumuID;
 spf=pass (domain: linaro.org, ip: 209.85.128.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c2308faedso4588505e9.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 23:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702626884; x=1703231684; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aZoud8po6wsnTFFTJ6fgKtd417sEG0xWSU5s6TbLfE=;
        b=iGXumuIDTfPUny3enObazsng5/jj+TE04zRtKjle/QdPqcQAqiadf6RKvtxn6siMU3
         H9uE7ANwsGANL6mnOO6TCVGY7aPpjVhcYLGjuW5wO9RXGR6sjELhpzwONwAhWxv3SNL2
         BzmhRq0iJR7Kevk/HuBuNOi3fqJjWkrBpvhj6YGUGrZj4JmDKgy38f2CCMFbBQupKucH
         ZQK+0K1QGiORLTHO7AjtbEtwJaQI7DBRuewvq197KoKS2Whmimz2i/BPC50U2W40dGzI
         CSiqPWeu7XmV9SSFKd+AY5ebLEFiUK0hkblTJ/lhQd4c3PfT5GYwp+GjU42Mi7QqOICi
         VWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702626884; x=1703231684;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1aZoud8po6wsnTFFTJ6fgKtd417sEG0xWSU5s6TbLfE=;
        b=CyN5vdY5+X+no0PVAjGJ0jOghCbhrIgVAVle5YQDPbFr4CYKkQypsLq9sFnts5kI37
         B7pE2cB+S4KmKmyEeloA1Br0s+H+8LsAdIw4ofQ4k9hJJ6Ep1Ge7EJe5SvVPXphyamzM
         SiffJOEzEx1J6Hby6OH1cUVcH8N/aG6S/EXNDvqkX0z9zVx645Dx/C4tX85QEEggByo/
         le1yMf+IpNJXh4neC/rV27f/M+nqvZc5d3aknyZ2jlMa3liS4YAc8Fv5DcEww+OGlwMb
         SCQT18TtYjyXPC7oLCvph+ccrfj/VzS/B4jesiFXzUECxdjlsGCv3kjWb5SXLR4UTMv8
         Ptlw==
X-Gm-Message-State: AOJu0Yx3+NR52C53qMH7I/jMJBuSik3nVgMEg6Thir8j9Plznh9Ndxdl
	W6WxdEUgn2rvlOfG6t7tb8E+lw==
X-Google-Smtp-Source: AGHT+IG3vAKpFAHsymcwWdJLdgUj+glrOzRYngCe2TjV1BolAPHyLmbdOvI5pKbavxLaj1lx1IgyDQ==
X-Received: by 2002:a7b:c407:0:b0:40c:32b5:d38d with SMTP id k7-20020a7bc407000000b0040c32b5d38dmr5394448wmi.147.1702626884197;
        Thu, 14 Dec 2023 23:54:44 -0800 (PST)
Received: from ?IPV6:2a0d:e487:115f:e549:fc61:d8:ed51:fc0d? ([2a0d:e487:115f:e549:fc61:d8:ed51:fc0d])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm11348948wmq.17.2023.12.14.23.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 23:54:43 -0800 (PST)
Message-ID: <df272f79-fc39-4a99-8a51-302d829c920e@linaro.org>
Date: Fri, 15 Dec 2023 08:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <20231214201511.GR2513409@bill-the-cat>
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
In-Reply-To: <20231214201511.GR2513409@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 07:54:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1928

On 14/12/2023 21:15, Tom Rini wrote:
> On Thu, Dec 14, 2023 at 01:48:42PM -0600, Rob Herring wrote:
>> On Thu, Dec 14, 2023 at 12:23 PM Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wrote:
>>>> Hi,
>>>>
>>>> On 14/12/2023 14:50, Sumit Garg wrote:
>>>>> Prerquisite
>>>>
>>>> s/Prerquisite/Prerequisite/
>>>>
>>>>> -----------
>>>>>
>>>>> This patch series requires devicetree-rebasing git repo to be added as a
>>>>> subtree to the main U-boot repo via:
>>>>>
>>>>> $ git subtree add --prefix devicetree-rebasing \
>>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git \
>>>>>         v6.6-dts --squash
>>>>
>>>> So I think the big question is: when should the subtree be updated ?
>>>>
>>>> Because as we discussed in the previous GH pull request, if a bindings changes
>>>> was made in the upstream Linux DT, then the subtree update should wait until
>>>> the u-boot support is merged before updating. This could cause a lot of frustration.
>>>>
>>>> And this could cause a lot of regressions, even more if both Linux and U-boot are
>>>> not maintained by the same people.
>>>
>>> I think some of the important questions to ask are, how often / likely
>>> are the breakages to occur? It seems like these days it's either:
>>> - U-Boot had an early version of the binding and we already state we
>>>    don't support backwards compatibility here. It should be on the
>>>    maintainer to be proactive in this case.
>>> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
>>>    incompatible DTS change now". This too is hopefully the kind of thing
>>>    that at least board maintainers will be more actively aware of needing
>>>    to deal with in U-Boot, if it's really a problem.
>>
>> A common issue in the kernel is with forward compatibility when
>> platforms add new resources from a new provider. Then the kernel
>> expects a driver for the provider and waits for the dependency. Of
>> course, older kernels don't have that provider driver and so the
>> dependency is never met. Not sure if u-boot will have similar issues?
>> At least you should/could know if the provider driver exists or not.
>> (The kernel doesn't because modules.)
> 
> I think we'll be fine, but time will tell. And perhaps the more frequent
> re-syncing will make any sort of corner cases show up more quickly and
> be something we can figure out how to resolve going forward really.
> 

Sure, I suppose I'll only switch the stable boards, and keep the in-progress ones
with manual sync.
And I'll need to make a prerequisite to any breaking DT change to have the corresponding
U-Boot change submitted before (and probably other OSes like *BSD*s)

Neil

