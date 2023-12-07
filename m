Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C527DC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 15:02:38 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.86445.1701961350494726172
 for <u-boot-amlogic@groups.io>;
 Thu, 07 Dec 2023 07:02:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nUePr89S;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-333630e9e43so1048505f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 07 Dec 2023 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701961349; x=1702566149; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UFcceIOfJiFud0Bq+7/kJ+Zi9Ce9xN1K0UxRI0JMhRQ=;
        b=nUePr89SjHZJHI6tgWx5NKN3K2Fmv8ZOO64Y5/Ei8DiNA7Sf09Hap2QK66ZeFx4uOh
         ihVys7hH5FpZDs88eoAmsFdL/NiqLPnUA9DwIQihjCyj/S8s/D4uacKNId6pWvrJ7Ahi
         pZvWPV1AX0JwfqOXYvvvz4AMGOUmVOYeFPXR83gvDoAPVXZq4ng2l2Z4l3F2AKmKKYxg
         fXi8OLQoYjh2Q2owSOPEMAyXktL1vGakX35YVq7yqAul23iwsqYiDk1jrDHnZW6H48Uy
         ZkY4tbNceJ3mb1e2uVj+9nAWG8WjchUPfekdNu3b4JWnVycWsAbVoYCZc3AQ9i5omcu2
         bAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961349; x=1702566149;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFcceIOfJiFud0Bq+7/kJ+Zi9Ce9xN1K0UxRI0JMhRQ=;
        b=o0BU5fntFWbvjtdhcCXWZsnZb7mfnX6W8kLKp7N5wWQegkRHNHA+nUHDv4k9OL8aY+
         nTYY7lhHcab5wBurFvcZ8tNKiUxw7qwCy+ZnawLY0YDw8bcRI4z8gbxwehFm5jRaY0Hf
         86ScRgJiTdB0EsZDGORKdLES7oT1yCGHd9a+fBKvEAuyR7iw7bykYoiEI9nbXVf636Ar
         rw3kjREkVvEP5wp4EY4HGiuCsCyz+fhOD0FU3fl/6bFe7ka2SJJEkiONfxrfoyi+J1bv
         yakAAqnZxIuv/p3eSuQY9oGRL9V5Q0rCtVMuy4gpdNHS0jtLrUSXYNtyH1+NPMNQDIrE
         TzUw==
X-Gm-Message-State: AOJu0YxuAn7QR+IAx3q6C6eCrRnPrwaJUIScWMfoW/myGaMvwVUM2ulo
	tg2b0GhN3ygmhsAzIRmMBs32/7wgobVwwlImywYpB9wA
X-Google-Smtp-Source: AGHT+IEQq/xZYTutj9f8RAPtRKqvfFfODqgw5VhF9A3JqCIvSm8Cquf0gXnW64vTr1IDTN/H+/nXPw==
X-Received: by 2002:a5d:6348:0:b0:333:1a41:c1d with SMTP id b8-20020a5d6348000000b003331a410c1dmr1054631wrw.33.1701961348825;
        Thu, 07 Dec 2023 07:02:28 -0800 (PST)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b0033349de2622sm1640168wrp.94.2023.12.07.07.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 07:02:28 -0800 (PST)
Message-ID: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
Date: Thu, 7 Dec 2023 16:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231207
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
 <u-boot-amlogic@groups.io>; Thu, 07 Dec 2023 15:02:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1900

Hi Tom,

A little fix to add the missing DM_USB_GADGET config for the amlogic boards

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18828

Thanks,
Neil

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231207

for you to fetch changes up to 4005729c0de234ffcf36465f6471755617b42375:

   configs: meson: enable missing DM_USB_GADGET (2023-12-07 09:36:19 +0100)

----------------------------------------------------------------
- Add missing DM_USB_GADGET to amlogic boards

----------------------------------------------------------------
Neil Armstrong (1):
       configs: meson: enable missing DM_USB_GADGET

  configs/bananapi-m2-pro_defconfig | 1 +
  configs/bananapi-m2s_defconfig    | 1 +
  configs/libretech-cc_v2_defconfig | 1 +
  configs/odroid-go-ultra_defconfig | 1 +
  configs/radxa-zero2_defconfig     | 1 +
  5 files changed, 5 insertions(+)

