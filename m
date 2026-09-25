Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F9C98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 15:04:54 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.410.1790348689138087843
 for <u-boot-amlogic@groups.io>;
 Fri, 25 Sep 2026 08:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CLPi/NEB;
 spf=pass (domain: linaro.org, ip: 74.125.225.141, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso7525175e9.2
        for <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790348687; x=1790953487; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
        b=CLPi/NEBRdnn2+C6eIVzJBaIGFUfIL/8765lml+7CXnwt+YGqPKHoxoJY1PjRTwwXG
         E1oOyhBIk+4bXwkCERwooxqiOf6wnEj/atFTr9ZC3sX7kLO9KOxjpm+pKW4JQlzgIv8L
         XbDaKTyWSWpuDoIovH8h/3wzoP4A2m018KueShPhZqsCRoWpJOFflBwH4h26cLf5uyAd
         /fUinRU2duJcn5vbahMFmQSm0yhilz58dUdt4Ww2LArVXyiV6yNucOc73LbU1n4HT8ru
         Rwc04NllPkuoRru04wP86gxn1mjxAVa3dZ16jeVYT6LkFJdp05HINON/kbP/VM+j0+76
         pIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348687; x=1790953487;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=avWe43OBeNkGOY5VdBUb2fZ60u0fdDmIYpnmWq+Fyz0=;
        b=UtbsHv6JSWWd5GMR3Z4FT4eljKKafMX56zG33VLFczaMx2TW0jCwOL7kX0FMB5PTpc
         KjYB0bxR8C8ivHOko0T6NRqQfOS2IVyd5vHyqItoY7kcgsNEuu8TFYM+UH90/L61nzH4
         c0jqsoWFz/xPol2j+CWeXTSrdb2sVgAtARWTP0Hvql1JHXtFZ0uPIMxHhzAosNx2xNV5
         aljOuWtp5/Wxs1JTZzCXbw8zDiUTlqzgyOFohlIriP6YD+cIIbv60xxoGqhX2uZqLLzM
         TmnZroU/h0w8GKfXhGrDPTDXUkjNYJUFaCPIw0Pe9WQCtz2XfeOxSEFmZYswSqfrKs26
         vATQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIneLlwybFuldcOnL0KCo6QN1f4b9gvWR/Kn5Xg8vAx50oT5WslHJO82VSFfWVGub2heIR5lDPKwaaGcN7lw==@groups.io
X-Gm-Message-State: AFuF++ncg00wkVb4Q1J3OAP31j6siAixXB++/MXwFU7J1FmWmUus0GZ0
	14C68sRiZWK+Jrfv33SEyhevltIMJmUke8zJ6yle86l5O2E2+LoHI5QMVe58GD1K0ag=
X-Gm-Gg: AYBFou1mX9bmirjksEpabTotthJxIEBE9/cBj5VWhGKIo8YEzQ0LYVl53Cmbxo+Lmd1
	OtlTiRwQC9WVtYzBKfQ3ws47D6OE0YxumQvV5n8pJwy7G3K5LfrbBNbN48gCly/EqCSkQve8x/a
	vGb2fmYJcRlqaRlKAj556yptYG3lOEiIYpp3RPPnd4/bw33UAppXiaTpz0MgNs4sr/4bsCOSkpM
	OFmZoiRfwIBJwHB0mJ56gaHCe4cRyAJKOK17B3XSm3OMYxUWVTXf/Tt2HANcC5TXDAeApj6aais
	0yz8WUes87YzZ/iz8mR+Trx15uEhohthSq017/y4TnUdvqHfTgZ78GaOpB8iMByasF1/KgOqVHN
	EaYMkBOnUq7Pq9e4FFS8FizCYut4tbwG3JJf1WpemqMxF+CHZNACK/QWQzBn8jQfPGGcjPkYqGo
	06g1HoHid/Jrji+BW5OXnT57Bv9nRbZtALdzHSzpMrBK0Ae1Ousuk4Syt0oew8bXNV+20S+ZbT6
	5ztgl3opmmm2JUVRayeP0gIf5FwzGb0gG7PcKQZFwGaYYS+BEnws8sQ2Uskuyf1
X-Received: by 2002:a05:600c:630c:b0:49c:ffde:45ff with SMTP id 5b1f17b1804b1-49fe66eb254mr102383955e9.17.1790348686113;
        Fri, 25 Sep 2026 08:04:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3151:fc9b:d41c:770b? ([2a01:e0a:106d:1080:3151:fc9b:d41c:770b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef5fe71csm50799435e9.2.2026.09.25.08.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 08:04:45 -0700 (PDT)
Message-ID: <b40d236c-6180-47a8-aafd-971fc7497244@linaro.org>
Date: Fri, 25 Sep 2026 17:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] configs: khadas-vim3: refresh Android support
To: Guillaume La Roque <glaroque@baylibre.com>, u-boot-amlogic@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
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
In-Reply-To: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 25 Sep 2026 15:04:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3100

On 9/25/26 15:42, Guillaume La Roque wrote:
> Update VIM3 and VIM3L Android support to match the Android 16 AOSP
> A/B images used by these Khadas development boards. Remove the unused
> non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
> partition layout and correct the DTB indices in vendor_boot.
> 
> The layout follows the AOSP generic boot and vendor_boot model:
> https://source.android.com/docs/core/architecture/partitions/generic-boot
> 
> Both Android A/B defconfigs were build-tested. Android boot will be
> tested on both VIM3 and VIM3L.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Guillaume La Roque (4):
>        configs: khadas-vim3: drop non-A/B Android defconfigs
>        configs: khadas-vim3: enlarge the fastboot buffer
>        configs: khadas-vim3: update the Android partition layout
>        configs: khadas-vim3: fix the Android DTB index
> 
>   board/amlogic/vim3/MAINTAINERS            |   2 -
>   configs/khadas-vim3_android_ab_defconfig  |   1 +
>   configs/khadas-vim3_android_defconfig     | 122 ------------------------------
>   configs/khadas-vim3l_android_ab_defconfig |   1 +
>   configs/khadas-vim3l_android_defconfig    | 122 ------------------------------
>   include/configs/khadas-vim3_android.h     |  36 ++++-----
>   include/configs/khadas-vim3l_android.h    |  36 ++++-----
>   7 files changed, 34 insertions(+), 286 deletions(-)
> ---
> base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
> change-id: 20260908-update_vim-997dcb218017
> 
> Best regards,
> --
> Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

