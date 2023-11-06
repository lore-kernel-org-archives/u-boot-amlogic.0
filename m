Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9FEC4332F
	for <webhook@archiver.kernel.org>; Mon,  6 Nov 2023 14:34:41 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.55996.1699281274189527492
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Nov 2023 06:34:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=fbQ2qzgF;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-409299277bbso32002195e9.2
        for <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699281272; x=1699886072; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1CxC4/YldoRD/TOfl1wGaaYrst695jdTuse57HfZ6Y=;
        b=fbQ2qzgFeBMDdhNk/uA/+m52TxbxKAfm2lMswJx7Ul/+obP6Hf5ctcyaiRu+1zm92t
         +yETnNKRJZZTx6gzI0mh1gz5gN4qBQ6jUObICzzA3WFclt+orvENO87EITBRC/c6OYPI
         4exZ9NdAcZqLLFCDX/00WaM0TJq8yytxA03m4/ui9G0Y016sIk60LQPTbTFblBhJOOVo
         wEsfni1ndyguONBctaOqirJAg/qehkld/L+XmDTN5/+enXr1TN1HcXFDMhA7BXlV8xFO
         4x1rGvqOhfq6pZON9q1EWZcv4XJDR5on84lKQissqUaEwATmMsda2msmVbD9fM0JJccU
         DSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281272; x=1699886072;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1CxC4/YldoRD/TOfl1wGaaYrst695jdTuse57HfZ6Y=;
        b=GR9mIDQW6ml8nTkXh0yKNnk7Wz+gcXrSYpgmMoZ+8im/igY6TaqFEqlQd5ZsbPh/Q/
         ob5UzOzW62mMq0OdtxXTKhBixMEXWJHwRN09sT2UCCunLNWxwd+bMXloSPyKg+212+Hv
         vH57nedwpGIsafu4vHhSeaSdykY4c7ZI5YtbzgQoD8qblUPiy43Yo33iZJb6q5HUtv/h
         /3+5cx8Xf4wZQOm/kTLv0kx0EhMAQg4F5f22wMVOS5riT5XCQTaXfoAqGV2+wLnpW/wP
         IxdxnzWVW/LZC0wKSC6Slzle4rUfJnJPhV9gY9cO79oiYSVr0N0dH+PRO2yiWjRuvVIB
         ZjQw==
X-Gm-Message-State: AOJu0YwOp5R263F896xQmm1KOMmpKTKNCAGBK5mfFQj2Dtjg/nP99Ixb
	UKvZE7a2Ilq5YkTa/q4F2EqQiQ==
X-Google-Smtp-Source: AGHT+IEeVZfUX0LQMbHqId7/KE/WrVB8KGY0u7JfjCZ0a3m/+Ote6lhiZ9q9ymQvEfLJkMQ6SjBSNw==
X-Received: by 2002:a05:600c:1c90:b0:405:37bb:d942 with SMTP id k16-20020a05600c1c9000b0040537bbd942mr24639950wms.4.1699281272590;
        Mon, 06 Nov 2023 06:34:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a54:34e:8001:fb7d? ([2a01:e0a:982:cbb0:7a54:34e:8001:fb7d])
        by smtp.gmail.com with ESMTPSA id gy14-20020a05600c880e00b00403b63e87f2sm12106245wmb.32.2023.11.06.06.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 06:34:32 -0800 (PST)
Message-ID: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
Date: Mon, 6 Nov 2023 15:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231106
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
 <u-boot-amlogic@groups.io>; Mon, 06 Nov 2023 14:34:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1844

Hi Tom,

A little set of fix for:
- also enable DFU RAM boot for libretech-ac, since it uses a different config header
- SM probe fix
- A1 USB missing clocks

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18452

Thanks,
Neil

The following changes since commit a4c83bda17196bf5d1ce640844595aaeced6465e:

   Merge branch '2023-11-03-assorted-tegra-improvements' (2023-11-04 09:55:39 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231106

for you to fetch changes up to c550e81171940932664a85bda315a6a073aae23c:

   ARM: configs: libretech-ac: enable USB_DFU like in meson64.h (2023-11-06 09:46:05 +0100)

----------------------------------------------------------------
- fixup to also enabled DFU RAM boot for libretech-ac
- sm fix to bind child sm devices in the device tree
- add missing A1 clocks for USB stack

----------------------------------------------------------------
Alexey Romanov (1):
       clk: a1: add new clocks for USB stack

Dmitry Rokosov (1):
       drivers: sm: bind child sm devices in the device tree

Neil Armstrong (1):
       ARM: configs: libretech-ac: enable USB_DFU like in meson64.h

  drivers/clk/meson/a1.c         | 6 ++++++
  drivers/sm/meson-sm.c          | 1 +
  include/configs/libretech-ac.h | 1 +
  3 files changed, 8 insertions(+)

