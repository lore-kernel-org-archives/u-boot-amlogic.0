Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F4C54E67
	for <webhook@archiver.kernel.org>; Thu, 28 Mar 2024 08:21:57 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.10647.1711614107842051004
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Mar 2024 01:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=f9qY98zd;
 spf=pass (domain: linaro.org, ip: 209.85.128.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4148d1b4a26so4826525e9.1
        for <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711614106; x=1712218906; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6PGotZ9BAl28iGXvlFuCeiM+gNFjdxenvme2loFeLQ=;
        b=f9qY98zdRQGQBN6EUx8Pl0w//z6iviBRM8wsYHvBSu7pGA6ixh5xGyA37HumfUKcg8
         nI9TbOvNIDWzK+GZWcVJ4DuuejWIYZ5dWfzZ1CIk31IgoVQPOXOOFRrurMo0gPVkjddL
         4DBt3bx7ti2GRssC1wmEMir5EXBONG9d1FtUjQ/S1T36B3Ce7h4M52TTzWh3PGp+MwDM
         G0V0zj2LmsivIe4VJx6hf2D/Wbx7PLqkgC77sMnvq/xdDqasyiRkPY6OwymKBkYThcx1
         +llEixtT12JsrzgWJ7nPtABOeP3SEiouq53FizUg8nojgaBrXspXF/tRQ6cLPJbx920O
         BjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711614106; x=1712218906;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O6PGotZ9BAl28iGXvlFuCeiM+gNFjdxenvme2loFeLQ=;
        b=ucUXY2NfAOjcCaHV2+SWAJh+0AjK41FmgWXdY9jDWqvxP1IsfP8G1grvOtOSHnlq1Q
         Tycjj5E4NKWxUrlGnB7B9VT56jBYdRfR4L85L/iBax0jF36axsbonr1NOIgHm2OZgbN/
         1hTP0MZuxCYNVhBHRvTfu9qIWWyprR3TCqzsiH+0FYnjMpHBXN6vhORYOyyqB+KxqeWh
         xbpDiRMsL/JZrCQuFr1n2LjPaV1/VI1Iq8NwvH7aD5T2x3YmS0wfUdlGyD6BQ6+Da8GR
         KUw9YY7K0DRLNnNwlIdYkzHSiQw3AL1r8PHzE0XApqaBM2cQn8Lf19vLlDyJ5e2zA9XF
         afEA==
X-Forwarded-Encrypted: i=1; AJvYcCUdfizIHWhjsjUF7bwAxu+EmtewGTw35yQismBzdkrlqM2Y+JyrZ5D5gwlEG4KuJMUsSVwoA76ArtOVgZyF9YXo0IUhzN3xqVc=
X-Gm-Message-State: AOJu0YxqLCJBYsfwyjp01Ekl2Y4MJtx4p9Wz/lS8yKj6u+pxW+IBMGVR
	1oq6WIx7r2twCdI7LVnSdT92EwnrsvmRlMjwM8dVEtGVcLdbFHgvdalFz9zFbgw=
X-Google-Smtp-Source: AGHT+IHeDAgoh+6CZFRF268LU3fv2HQbbutZxK0Yo708XIK8soTbEalfvBRArP2ep6bDy+T1sHlUIA==
X-Received: by 2002:a7b:ce89:0:b0:413:ee4b:cd8e with SMTP id q9-20020a7bce89000000b00413ee4bcd8emr1034201wmj.24.1711614105868;
        Thu, 28 Mar 2024 01:21:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6306:1c7a:72c2:892a? ([2a01:e0a:982:cbb0:6306:1c7a:72c2:892a])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b0041543ea1007sm625678wmo.1.2024.03.28.01.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:21:45 -0700 (PDT)
Message-ID: <625e06c4-0410-4067-8ead-5142373bc1ee@linaro.org>
Date: Thu, 28 Mar 2024 09:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM,
 AXG, G12A, G12B & SM1 SoCs
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
 Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
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
In-Reply-To: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 28 Mar 2024 08:21:57 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2252

Hi Mattijs,

On 19/03/2024 15:42, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> CI built & tested at:
> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552

Can you check it doesn't break android boot ?

Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (4):
>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>        dts: meson-g12a: Switch to using upstream DT
>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
> 
>   arch/arm/dts/Makefile                              |   36 +-
>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>   arch/arm/mach-meson/Kconfig                        |    4 +
>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>   configs/bananapi-m2s_defconfig                     |    2 +-
>   configs/bananapi-m5_defconfig                      |    2 +-
>   configs/beelink-gsking-x_defconfig                 |    2 +-
>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>   configs/beelink-gtking_defconfig                   |    2 +-
>   configs/beelink-gtkingpro_defconfig                |    2 +-
>   configs/jethub_j100_defconfig                      |    2 +-
>   configs/jethub_j80_defconfig                       |    2 +-
>   configs/khadas-vim2_defconfig                      |    2 +-
>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>   configs/khadas-vim3_android_defconfig              |    2 +-
>   configs/khadas-vim3_defconfig                      |    2 +-
>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>   configs/khadas-vim3l_android_defconfig             |    2 +-
>   configs/khadas-vim3l_defconfig                     |    2 +-
>   configs/khadas-vim_defconfig                       |    2 +-
>   configs/libretech-ac_defconfig                     |    2 +-
>   configs/libretech-cc_defconfig                     |    2 +-
>   configs/libretech-cc_v2_defconfig                  |    2 +-
>   configs/libretech-s905d-pc_defconfig               |    2 +-
>   configs/libretech-s912-pc_defconfig                |    2 +-
>   configs/odroid-c4_defconfig                        |    2 +-
>   configs/odroid-go-ultra_defconfig                  |    2 +-
>   configs/odroid-hc4_defconfig                       |    2 +-
>   configs/odroid-n2_defconfig                        |    2 +-
>   configs/odroid-n2l_defconfig                       |    2 +-
>   configs/p212_defconfig                             |    2 +-
>   configs/radxa-zero2_defconfig                      |    2 +-
>   configs/radxa-zero_defconfig                       |    2 +-
>   configs/s400_defconfig                             |    2 +-
>   configs/sei510_defconfig                           |    2 +-
>   configs/sei610_defconfig                           |    2 +-
>   configs/u200_defconfig                             |    2 +-
>   configs/wetek-core2_defconfig                      |    2 +-
>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>   116 files changed, 42 insertions(+), 21511 deletions(-)
> ---
> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
> change-id: 20240319-u-boot-of-upstream-46454fded5ea
> 
> Best regards,


