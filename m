Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF54C54798
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 13:38:41 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.12143.1709041113509637263
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Feb 2024 05:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=UScCsV5O;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412a4848f0dso15203055e9.1
        for <u-boot-amlogic@groups.io>; Tue, 27 Feb 2024 05:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709041112; x=1709645912; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CdQ4/Hgyvzk3UCjyq88zPjz9SAcY+jYYLOA4hojJ+4=;
        b=UScCsV5ObDxEPvi+RxVN0nUaPbEOQld2TOQAwfxr6aYW6faOx99iSWSjzDLYnyUGNW
         u5Rxyd9UaytDk9XuDX8Rei6/IDApK7oGlCP6Kvml0NkhEZ1EA9lM67ibu7jCawvWW3HQ
         hVWuD++FIiLpnByeqd9UyaRY7/km/HNtrus+g85caZpMr4yxTvyV4m9eYePI5mRrLBOs
         nTGevPXJSGyRTzNEUNElrE6zTC7eH8NCxjLzIZhV0ElXctSZr9aLaGxiTBGgrsFDl2nz
         BJiVosVEzN8ocNDlBKCTXMHLSWjVg2C8iVXXZ6J21JekR1RTF8VzXHmgK6I9xZzea7II
         1nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709041112; x=1709645912;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0CdQ4/Hgyvzk3UCjyq88zPjz9SAcY+jYYLOA4hojJ+4=;
        b=Rw5NFbAeTDO3Lu37nfy30iaREwSl/IXcMwxBgyaQRvTClljGnZoc0PbYcl6dGm+0Yc
         cunPKACCxtUx8vtCY0yyxfTZN+pC6lPUv5XVh/6iO7NJA5Gk6yXBF73iKSB99hQu3X+v
         kABGj+QrrXzMwW0+SGcc02V5r3UkqBM0GYx9/y57ap1L4kmwwdkCwh7G6jk+FSaVi0eK
         zqbMz1KhLXlUT+N434X5Ej313VXHpnpMo2Rx8DoowoMSlbHcs5Yhmn1kMw95iL+CK+i7
         4QIBSFtV5mvAviPwg/GfjXS9TMaqRj5fhF8XzpqyLy+x5tBh4VOydZ8Fja0qR7qDbQDj
         Dncw==
X-Forwarded-Encrypted: i=1; AJvYcCWbcakpxfZurjj+EEWHdWhuuUXghwplTT/+9Hw78pzIFIB8lI/JPT3SRQfL/br/Msu4djzF3C/Z+NIRYaTvIwWzPJvWF/PwANI=
X-Gm-Message-State: AOJu0YxIatqsbz8fXoZhaEtk40EI/q/Dqus9BvIWfqTVaqE4hz4koNHw
	9M6IwRETYwHNBzmbFr47bBmjrShOxngUepDOr+zUb5FcK/Cpj9B6WUodUFMs4q5nHtwiNNa+d1m
	9w+4=
X-Google-Smtp-Source: AGHT+IFVfs2AU9hSrINcdJEhaNoVykQcYIj3k4IFCtS/jvv0eDaNtS68+iAFO586Js5LEsSS/+SXWQ==
X-Received: by 2002:a05:600c:6b07:b0:412:117d:949c with SMTP id jn7-20020a05600c6b0700b00412117d949cmr9553196wmb.41.1709041111945;
        Tue, 27 Feb 2024 05:38:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:68ee:e3d3:74d9:c0d1? ([2a01:e0a:982:cbb0:68ee:e3d3:74d9:c0d1])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b004127ead18aasm11485160wmq.22.2024.02.27.05.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 05:38:31 -0800 (PST)
Message-ID: <6d57d749-7967-4475-b84f-326bfbffc5f2@linaro.org>
Date: Tue, 27 Feb 2024 14:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
To: Viacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240227065551.580199-1-adeep@lexina.in>
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
Organization: Linaro Developer Services
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 27 Feb 2024 13:38:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2148

On 27/02/2024 07:54, Viacheslav Bocharov wrote:
> Update JetHub D1/D1+ board support files.
> 
> Viacheslav Bocharov (3):
>    board: amlogic: jethubj100: fix common config header
>    board: amlogic: jethubj100: update MAINTAINERS
>    board: amlogic: jethubj100: update docs
> 
>   board/amlogic/jethub-j100/MAINTAINERS | 2 +-
>   doc/board/amlogic/jethub-j100.rst     | 9 ++++++---
>   include/configs/jethub.h              | 2 +-
>   3 files changed, 8 insertions(+), 5 deletions(-)
> 
> 
> base-commit: d49fa3defa50c6d3f04acbb52fd486c13c14ab6a

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

