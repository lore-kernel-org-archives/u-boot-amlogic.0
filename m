Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27471CC6B1D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 09:46:19 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9527.1791971176936536498
 for <u-boot-amlogic@groups.io>;
 Wed, 14 Oct 2026 02:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Tqj4/uvf;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso50648755e9.0
        for <u-boot-amlogic@groups.io>; Wed, 14 Oct 2026 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791971175; x=1792575975; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
        b=Tqj4/uvfAuouYY/d/iNwUe3O0CuaY8CbXfJEvYg9W8sOgNxUTT6czBxUEi6fup7Pht
         kqR+RI6m8NZmc9ccslM2bIP88X8XmE32lYa2DEDzpbIqZGsxl9gjKa0Aen2RsN03STW3
         leBc22WfeP8C/QZhCxI1cKzqeg8sf3IC9rB49hw1DZwEjnu9lvQARVVHRsieK9qqpMLv
         4bgGhZWzi5TPcbIW7U1VGaOpQlY5yWoTx3xPjuRsBWsP2WbX5eQjwmFBWA6PxXjcCCZD
         mzvMS0xxYFmkx4k69Jl1Lxn4viLJwaT1wfsno7uRz27I6QzPXHQkM7jPiPESdxkzhHz9
         wSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971175; x=1792575975;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OWGCIPcbNGiJSbGxIFwCTCg+W++D0AwkbWNgCH5LJE=;
        b=UnYbMWP1K6ZNuUPHoDemv+dBNT2ME1J2vp+2TObCQYIgCxr+s4ZGLqx+0w8ARbRWX9
         G9ITBXbmBm/Im3Qv0fj1f3HU1H0EEcu3adf1qR+JMVrJ77L4R3feR7m0LdIzC4IxRsf5
         nS49ZOyvBsX36R43W7guzo7NLYJCECJnOyFyJ7Zfcy4HiLC+H3Ogtk+wKQFdI1qhvckW
         tkkh2nXlqLkEfSFT14Vmv+rvSGUubsJ+TGfuSpTjstebgEPdX0Bj+4E5IXEdqL78xOKK
         1E1d+lPiS5gT7nD1gkg8JvhG9ZnckYRieZr7o4ilphfTmhg7fsAqUBy7v2B7CZl0nueD
         lYDg==
X-Forwarded-Encrypted: i=1; AKwUvBxnYk2Vrf0eojs8gPf9W1pqUiEP6GNRJlXgrHGUVdsFikf4CJaehOk5irW3i+JPuzSJDCS8zZjPvwBJppTQZg==@groups.io
X-Gm-Message-State: AFq9FYKPNGVicoybDa4wmMbozPXnGiwTckdJ+BnbA9p+kDNQ4xNwwC3Y
	vY96d9c6Yz0sMxSvlaxhdNI8lFtrHLhkwzbZUHwVjRMj1lirWU+F2xs6bTKHOZiKatY=
X-Gm-Gg: AYBFou2YEv4FwtVeEHzXKjpM7lFr/RC06RdlwCEWsC1l5RNaRrXCJX6XL67QJ6ssUmg
	hU5JL7UyGlNHzS/tcueau02uTQE0UOVhnJ4nA4v42SOJGg+PrUaGbZqnZXzRADr+p9zOltumwoR
	5VVvQ6hcBrGZiCLXXaY7wKCG2lX+3LKCp9hQpBiODKDSr1O0ONVXVJoOhhbS/pnmvKOvC6YoA25
	3R2+J9bCQi+e7oNu8qCrxxy+RWStCxTIpHVTdqgPvlJesH+PTqwdaenkQHSzaqZ0tPb4m3t/vo4
	F7aRnsKcr2mc+MOsMXWxC9GwxyI/ky7/0EwaZmUc9ZyiJdLvB03Js9ILBO7DFzFAaTFhLYnM4zT
	x2WPILOnMcbtSS8v3s+nEA+C8zhWFehsSAkqMcNfq75VwzieGF8UxZIbrTtcUhxqOqeFgCm2cCd
	J5W4aSI42TtAN0c/z1VJFbuvzUVspPpO7XZXd3uWimXcbZj+l9lyiX5RWUduIi/p1/Qao34FEMQ
	BGPRFmdwP3pIZQz8yxRiBdoMJklSc4BU/EGZfvmIc+pcStoI++0Dw==
X-Received: by 2002:a05:600c:8b78:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a18e4837f2mr289648215e9.5.1791971174837;
        Wed, 14 Oct 2026 02:46:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb? ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm547666275e9.4.2026.10.14.02.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:46:14 -0700 (PDT)
Message-ID: <afdf3fbe-3a4b-403e-bcfd-fd166cc72a82@linaro.org>
Date: Wed, 14 Oct 2026 11:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org, Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
 <179146357781.183177.17223915816731601716.b4-ty@b4>
 <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
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
In-Reply-To: <xhkdb1p9u7x4f.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 14 Oct 2026 09:46:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3133

On 10/13/26 11:44, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> On Thu, Oct 08, 2026 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> Hi,
>>
>> On Fri, 25 Sep 2026 15:42:23 +0200, Guillaume La Roque wrote:
>>> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
>>> A/B images used by these Khadas development boards. Remove the unused
>>> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
>>> partition layout and correct the DTB indices in vendor_boot.
>>>
>>> The layout follows the AOSP generic boot and vendor_boot model:
>>> https://source.android.com/docs/core/architecture/partitions/generic-boot
>>>
>>> [...]
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)
>>
>> [1/4] configs: khadas-vim3: drop non-A/B Android defconfigs
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a2d0134bfc140b9b2092ab09cfef37a7da7c51ac
>> [2/4] configs: khadas-vim3: enlarge the fastboot buffer
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/349d13ce42f60dba1604accc3abb24d5f6afeb18
>> [3/4] configs: khadas-vim3: update the Android partition layout
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/09aee880eea6cf05e117988da1be8231b07c5bc0
>> [4/4] configs: khadas-vim3: fix the Android DTB index
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7a403d3db56db9f1efba44ed145e875c23fb785d
> 
> I see that the patches have been applied to git.u-boot-project.org [1]
> but the b4 ty note still lists source.denx.de.
> 
> Can you consider updating your b4.thanks-treename and
> b4.thanks-commit-url-mask so that it points the new instance?
> 
> FWIW, this is what I added to my ~/.gitconfig for DFU:
> 
>   [b4]
> -    thanks-commit-url-mask = https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/%.40s
> +    thanks-commit-url-mask = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/%.40s
>       thanks-am-template = /home/mkorpershoek/.dotfiles-private/u-boot-dfu/thanks-am-template
> -    thanks-treename = https://source.denx.de/u-boot/custodians/u-boot-dfu
> +    thanks-treename = https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu


Forgot to update it, fixed thx.

Neil

> 
> Thanks!
> Mattijs
> 
> [1] https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic/-/tree/u-boot-amlogic-next?ref_type=heads
> 
>>
>> -- 
>> Neil


