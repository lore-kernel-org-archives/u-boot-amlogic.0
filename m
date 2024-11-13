Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5555BD637A5
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 17:45:33 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.17993.1731519926196256225
 for <u-boot-amlogic@groups.io>;
 Wed, 13 Nov 2024 09:45:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=CElJxYRO;
 spf=pass (domain: linaro.org, ip: 209.85.221.46, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d51055097so4374842f8f.3
        for <u-boot-amlogic@groups.io>; Wed, 13 Nov 2024 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731519924; x=1732124724; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uvyp5aHJ1Z7JGiBkv2RmSv2DsxVkKk5hPpUi2GOqfns=;
        b=CElJxYROy/loSZ0YW8ixIj8nclUnWYfZPj6CMcen/9C0zgV2Htv0yiSCDSztY8x9J0
         zW0Vf+DL63LTvfLMn494pFE+W+l4ZXSUtfBt1JBdVHEAHAKMkn5noYVZJdxXWVUCvDny
         OTbjZhy1zaBHFdHJg2PqccYZpPrDa5w1RtsL2FSOCAVXo9QIWa9l5qdMlRYTsq9GDFWR
         cGn+RDotZrQo5bLavNwKzuf2SpS5oHnsKYwXjLM0YZ6B0AhWcT7KK3p/MB4/SavesoGo
         83L9BxQVknjByCX+qbGAjnqSwEJhjuv/brneRayDwDd7cQX1qpqqlmQwc6U+z2PN6b37
         osUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519924; x=1732124724;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvyp5aHJ1Z7JGiBkv2RmSv2DsxVkKk5hPpUi2GOqfns=;
        b=C9zDGfGvAKsuyKLVyzzqz1Z7ECfg9vFGajb+cp8XpPiSn3C5yGbIyx1w64I7Sjzg6z
         8hCpix5yvdhNWQfV33YIxwVgCn26shTZBC0IauDcYeQiCrFPH3uXprS1iIIDd0deE9Nk
         jjYMhc+ZH+u9IT+NPrNThpLA3m++SiXWRuU5OQFDpt9O4f+k4rd06H/w/wwm2nJCoJUF
         /G/7IDZqcQZ4Drx5qai6TwzGfn0tNJk5seO/ykfDh2Lqsa1+6/EwFnRLft2KyPW1k/YL
         FB7GO1FvADDdqdcyVmrNS0A2/5Ex2YEqFBt6oDOyVyZgDgfc+1lRKGUgGWDkHc3paXdG
         K6pg==
X-Gm-Message-State: AOJu0YwrhaGn3gToFqktMxcAEeoSa/20H7tnXK/he2AWhBRintUN/T+Q
	4s0NWrsGSaxCcMBjXJDD5HYDpmZgEFxfpf5j2ZGna2QwWItvp2y7UfnyFK9bRcc=
X-Google-Smtp-Source: AGHT+IH1vh0n17Nih4qZdtZq6M8bInGGG8ibt19OQwFpr6y4fky9AiYt0mXkBi3ZZvbC5/Yov/0FMg==
X-Received: by 2002:a5d:47ae:0:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-381f186bfdemr17651728f8f.25.1731519924572;
        Wed, 13 Nov 2024 09:45:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e35e:22ff:8c36:1a4a? ([2a01:e0a:982:cbb0:e35e:22ff:8c36:1a4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed987d95sm19159878f8f.44.2024.11.13.09.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:45:24 -0800 (PST)
Message-ID: <6d6d1630-838b-460b-ac4f-1c4923bfb40b@linaro.org>
Date: Wed, 13 Nov 2024 18:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20241113
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
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 13 Nov 2024 17:45:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2550

Hi Tom,

Here's a small fix for khadas-vim3{l} android config, and a drop of
obsolete dtsi and include bindings in favor or the upstream ones.

Thanks,
Neil

The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd271:

   bios_emulator: fix first argument of pci_{read,write}_config_* function calls (2024-11-04 18:01:58 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20241113

for you to fetch changes up to 1cdb4e03e684d94456dee0cc30c935d7e25b263d:

   dt-bindings: interrupt-controller: remove arm-gic.h from include/ (2024-11-13 17:25:07 +0100)

----------------------------------------------------------------
- khadas-vim3{l}: fix userdata size for android config
- drop A1 dtsi and other bindings includes in favor of Upstream ones

----------------------------------------------------------------
Alexey Romanov (4):
       arm: dts: meson: remove meson-a1.dtsi
       dt-bindings: remove a1 bindings from include/
       dt-bindings: remove axg bindings from include/
       dt-bindings: interrupt-controller: remove arm-gic.h from include/

Guillaume La Roque (1):
       configs: khadas-vim3{l}: fix userdata size

  arch/arm/dts/meson-a1.dtsi                         | 518 ---------------------
  include/configs/khadas-vim3_android.h              |   4 +-
  include/configs/khadas-vim3l_android.h             |   4 +-
  .../clock/amlogic,a1-peripherals-clkc.h            | 168 -------
  include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |  25 -
  include/dt-bindings/clock/axg-audio-clkc.h         |  94 ----
  include/dt-bindings/clock/axg-clkc.h               | 100 ----
  include/dt-bindings/gpio/meson-a1-gpio.h           |  73 ---
  include/dt-bindings/interrupt-controller/arm-gic.h |  23 -
  include/dt-bindings/power/meson-a1-power.h         |  32 --
  include/dt-bindings/reset/amlogic,meson-a1-reset.h |  76 ---
  11 files changed, 4 insertions(+), 1113 deletions(-)
  delete mode 100644 arch/arm/dts/meson-a1.dtsi
  delete mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
  delete mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
  delete mode 100644 include/dt-bindings/clock/axg-audio-clkc.h
  delete mode 100644 include/dt-bindings/clock/axg-clkc.h
  delete mode 100644 include/dt-bindings/gpio/meson-a1-gpio.h
  delete mode 100644 include/dt-bindings/interrupt-controller/arm-gic.h
  delete mode 100644 include/dt-bindings/power/meson-a1-power.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

