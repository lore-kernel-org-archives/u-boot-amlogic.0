Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A6CD11DB
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 09:41:31 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.47811.1711359681654530116
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 02:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=cG0ZU+RW;
 spf=pass (domain: linaro.org, ip: 209.85.221.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3417a3151c4so3769340f8f.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711359680; x=1711964480; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0L2naDWR5wSXzNC2dSz36D7V8qn+x0FqAk42bj0OH9c=;
        b=cG0ZU+RWz7m1sY4ZB4cwgDcA+vFGxW6XBPTAtIvEN7Uh7YAKNh5MMScCV1fCp2EuwY
         FNEKIEtOcnUYf2/GHKp27KKXFv2Jkw1NlrgsqezL88UOVU3pAoaV8F+aHjsfPh2xz0tN
         x0lpL8SwtjC2ScDZqLe9nYIYX/jqTf+4Oecl+mdU9ZImSKte31Vo1MH+FYrFNLPOL1+D
         kaGyxsjzdf6MHkfbhg0iJrL8u0qSdePt2va/xpQu4+g6+LXW6e9RXvAwDs2QxZOFoOoG
         Z+KpqlWJZpkFUHyVz0a34ydw5M4PE9OKOPKvr32obK+8bCT3deM+f9nOJ9bejhJaN5ar
         JRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359680; x=1711964480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0L2naDWR5wSXzNC2dSz36D7V8qn+x0FqAk42bj0OH9c=;
        b=D/j9Ma3gQXJRAyTHb4zNPc2MgAXBHy3GjgSCdcMCIeqklmpkkY2+3S+1hQ2C3g+qe0
         0CdVwzsm/TzCgR5QrjhXG7Fn1NVgg37crZ61x6MDbVN3h0ktUIvHzpkpMukAL0rkyT70
         2FvDMsPHkU3bKlB0mcsn9/A285/elEFQiMYAlYvWkC2ZhYNNQoTse1YdYxwTUKjmAG+X
         +kz3V5GRjVcymGmnJzHZgFY2qVHPxy+O3aaeBjd9e3fyVVvuz6eUNh2PAMZhE23KE4SM
         DyWSQ2qzPi0jCOMueIlrbN0tVd+b2CIDkQHVCJw0kjYG+ShkACiNMddA/udCcr67VS7U
         eN2g==
X-Forwarded-Encrypted: i=1; AJvYcCXNqvL6cTNT/MQUBPLeVsvkqMNlwnBjGeMgYl7NNoHMNoQ/BunfP3hfi10XjMYhZ4qCSYQjUfkLR2Gh8WRFcm+LPA7VHLO8mSk=
X-Gm-Message-State: AOJu0Yy/iJ2HW1MWMTiIJ5pmTDqAdZM7qB+PBEsX3GNAW8Eq2twV5hZN
	ahMpDQGWq/waPc2AZOdUPEvrW6moP0UTl0xGMJWxz+06pAY+4TuDcfJOylk21YM=
X-Google-Smtp-Source: AGHT+IH0QmT9/nORhVQMFmwvns4C4b1sjBYYfJzE4CJafUDlI4gKu3gmqhkqJ5Ipf853rwlMlr2CDA==
X-Received: by 2002:adf:f8c5:0:b0:341:76bc:2bfe with SMTP id f5-20020adff8c5000000b0034176bc2bfemr5893140wrq.4.1711359679582;
        Mon, 25 Mar 2024 02:41:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:32cb:35f3:5930:592a? ([2a01:e0a:982:cbb0:32cb:35f3:5930:592a])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00341bb338407sm7655387wrb.99.2024.03.25.02.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:41:19 -0700 (PDT)
Message-ID: <82a76f25-b532-4dac-825e-50d4d5e9e5b9@linaro.org>
Date: Mon, 25 Mar 2024 10:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/3] board: amlogic: jethubj100: update docs
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240227065551.580199-1-adeep@lexina.in>
 <20240227065551.580199-4-adeep@lexina.in>
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
In-Reply-To: <20240227065551.580199-4-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 09:41:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2245

On 27/02/2024 07:54, Viacheslav Bocharov wrote:
> Improove documentation, add new revision.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   doc/board/amlogic/jethub-j100.rst | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
> index 86acdafa06f..80bed6e919e 100644
> --- a/doc/board/amlogic/jethub-j100.rst
> +++ b/doc/board/amlogic/jethub-j100.rst
> @@ -1,9 +1,9 @@
>   .. SPDX-License-Identifier: GPL-2.0+
>   
> -U-Boot for JetHub J100 (A113X)
> +U-Boot for JetHub J100/J110 (A113X)
>   ==============================
>   

I have a CI failure: https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/jobs/804174
/builds/u-boot/custodians/u-boot-amlogic/doc/board/amlogic/jethub-j100.rst:4:Title underline too short.
U-Boot for JetHub J100/J110 (A113X)

Could you check and send a follow-up patch I can squash on top?

Thanks,
Neil

