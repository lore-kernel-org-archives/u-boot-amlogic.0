Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154D1CDB474
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 09:02:40 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.116659.1698051753184007365
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 02:02:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=buhZMpdq;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4081ccf69dcso22780575e9.0
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698051751; x=1698656551; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1gLox9RqyXPSzPj6p25lDQAF72qjp15QUnwuXfYshI=;
        b=buhZMpdqDT/wlxPRw0kyBiCe/6h5IXMWFgC1FqUQ43/e+gvwb+hYcNzuwIhglSrygH
         By0Zfz+BDvMxWeeEwnz3IAdOqdzXWSLzYiWELiGYOlFDLLA9jzisvt4+e7Zp6KW/9vmr
         TOc77/SSJUYshT80x+1NV/GOmffXiVzPuQRVp9RtyiAGX433NiS6pz7qGcdGsdQwOgps
         4sR5NAUsmN6A8GEo8ehcPZxXgf5bQxFEdGqlP1NU8Yl/NcYyKD7RKzxX8/Cq5e+eCQCt
         iVzGzpdlCRycbdUsQ0J0IRxs66zUkamPQk4AVF2d+EWJc37FMKs8Tbcypk6x0XF3uDG+
         61ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051751; x=1698656551;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1gLox9RqyXPSzPj6p25lDQAF72qjp15QUnwuXfYshI=;
        b=xMbr1QOFcB3otS9SUe4XXlJm9iza3RCHr9Nnwxa6hTe3xW2Hstog5r2CnKoo6yMLzA
         m+RwM5xqiVgBowyyafUFposMCFFarOpQhusQi2hL3pMsnRirfwldOBp7OViruUBPXN7a
         MzpknnE/36/tMhoQ41R32VU06Uy986xPMmnl/Wv0FMqEB8+5dgk6OlRVOGRxcvDOjtL5
         ElLMvp20gpkt8kNw0TOxpN6dMvUY7GzwicC2r2oN6WxL664HptFBKF8atAaDDrbiZATR
         x36+dncmboNvybC0AS3kSoAlAiJBxs7JxIBu27h9HkZuK/ebgwol4WnpT5cyuan71qdG
         xuaQ==
X-Gm-Message-State: AOJu0YzDDLUxe3WKsJAQFE+cAKzAVQp9S2FAQHJKpQxkrIrVyhTU9ImS
	oz3QQBOEA77h25ELXKEX3Q59Sa3jwY65qqE+3xRrN2vj
X-Google-Smtp-Source: AGHT+IGUwhggw3BSwF4EnKe4ojEgyJDpLymdWBwF7GZfh89uXxKyV1qs+6FBH8e89wYFUXLrgX8mFA==
X-Received: by 2002:a05:600c:3c93:b0:407:4701:f9e with SMTP id bg19-20020a05600c3c9300b0040747010f9emr8275336wmb.17.1698051751597;
        Mon, 23 Oct 2023 02:02:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1? ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c314e00b003fbe4cecc3bsm13740220wmo.16.2023.10.23.02.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 02:02:31 -0700 (PDT)
Message-ID: <42fa4e61-93ea-4b99-a5a3-1ffc3ab36cd9@linaro.org>
Date: Mon, 23 Oct 2023 11:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231023
Reply-To: neil.armstrong@linaro.org
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 09:02:40 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1788

Hi Tom,

An important fix for USB Gadget on G12/SM1 boards and a welcome DT sync for the Amlogic A1 DT.

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18256

Thanks,
Neil

The following changes since commit e65b5d35c9116485366bb08138043d51220551da:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2023-10-17 09:15:56 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231023

for you to fetch changes up to 14a21f1a80afc58d52dc72e35f27d3a47d36c082:

   arm: meson-a1: dts: Sync DT with Linux (2023-10-18 09:46:01 +0200)

----------------------------------------------------------------
- sync A1 with Linux and add missing UART compatible
- fix USB2 gadget init on G12/SM1 based Boards

----------------------------------------------------------------
Guillaume La Roque (1):
       phy: meson-g12a-usb2: fix ret check on power_domain_get

Igor Prusov (2):
       serial: amlogic: Add UART compatible for A1 board
       arm: meson-a1: dts: Sync DT with Linux

  arch/arm/dts/meson-a1.dtsi    | 356 +++++++++++++++++++++++++++++++++++++++++-
  drivers/phy/meson-g12a-usb2.c |   6 +-
  drivers/serial/serial_meson.c |   1 +
  3 files changed, 355 insertions(+), 8 deletions(-)

