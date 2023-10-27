Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481EC25B67
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 08:38:55 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.2650.1698395924604256625
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Oct 2023 01:38:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=vyuBKI/F;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-408382da7f0so13634595e9.0
        for <u-boot-amlogic@groups.io>; Fri, 27 Oct 2023 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698395923; x=1699000723; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfGOZLfZwEtsIgcao11L0wN/Yh9wDY5bsZIxCjKawl4=;
        b=vyuBKI/F9rnPoT+xD+rfR/PiXQBHY2x8piGD0abQLfrVW3gbqZsyNVXyphigbiwXZr
         4+A9V114KSvY7vHMQ72rbKUAPh2BUlv4D+YCYvb5fGF7xjTnegvIkpH3Y04L0UMOcT1t
         CsEqkUviEs5g4DPjuARfBO8VHg5T5+1FPNTd5v+nUAqBzflaSNiF3ehNgfR2eO/HhtDv
         oyKLB1Zn4Kib/fpLVuJo1v4ojmS3T4f5uKXZk/TMwfMpXU9EHEilLkOFFSnIqClUCF3h
         dDw0ujTaPupoLXlR2ObRDZZz+lIGPT3qzs9FObT2VAVfPHBkpS+0ANgUVND5LJT2GgU0
         1g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698395923; x=1699000723;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfGOZLfZwEtsIgcao11L0wN/Yh9wDY5bsZIxCjKawl4=;
        b=D/2MG3/OURQ9sraSWczDApwR1qqUnBETfiglZ04lZ9SscAAafiej9LtPwve3shWjZr
         rs8eUUad6c9zrBO8PyEluqMpbULWZwkx8zFysEL2+ou9/+S4/UA1dlnb7OnnUgNTEN0m
         WlDAxyppJbE6DEMOpLtVpECMRN/Y5MhvfqOp6+B0qNAY5TAbi7u7x8+MYZNtLoswuUd2
         1e6jmuwvncjSjz497FHNhkbbQnV9udp3AiVX+brTLbdRC0mPaha7oJHKeualQWeoIMTL
         6UJMQkvDN6WXMbWZuNwO34FzcxUWF0KX4UvU3C9yEcCgCzh9VBGXDfhXfszb5LdndQ2k
         02Ow==
X-Gm-Message-State: AOJu0YzIIzW5Inmd94JWPKM6ZWvi6vQh8u3/xUNDFqOqIm2ew0Ahr4vn
	/T6gVkGDQ9plHwxZ6pe0SfEZitPQ850E5JQCHE1Q2hax
X-Google-Smtp-Source: AGHT+IHp/83pUXHvxbt3bYziiHzIW4QQfhtSg1KIYBscK1TrTlpjH7Ea2+Fnd/vBGw9W8e5OdxwlYQ==
X-Received: by 2002:a05:600c:444f:b0:406:535a:cfb4 with SMTP id v15-20020a05600c444f00b00406535acfb4mr1813221wmn.1.1698395922930;
        Fri, 27 Oct 2023 01:38:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ba29:8286:ad2b:d178? ([2a01:e0a:982:cbb0:ba29:8286:ad2b:d178])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0040472ad9a3dsm1071567wmq.14.2023.10.27.01.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:38:42 -0700 (PDT)
Message-ID: <4839b54f-1e61-4c46-b1ed-40a2ea0f9c08@linaro.org>
Date: Fri, 27 Oct 2023 10:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231027
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
 <u-boot-amlogic@groups.io>; Fri, 27 Oct 2023 08:38:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1805

Hi Tom,

A late PR to:
- fix environment saving for new Android boot features on vim3*_android
- Add SPIFC support for Amlogic A1
- Add DFU RAM boot step when booting over USB, fixing full USB boot for G12/SM1 boards

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18322

Thanks,
Neil

The following changes since commit fb428b61819444b9337075f49c72f326f5d12085:

   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-24 19:12:21 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231027

for you to fetch changes up to 892e04bc965400772e1b84e6450a7919deca0e0b:

   ARM: amlogic: ad401: enable SPIFC (2023-10-26 17:56:58 +0200)

----------------------------------------------------------------
- Fix environment saving for new Android boot features on vim3*_android
- Add SPIFC support for Amlogic A1
- Add DFU RAM boot step when booting over USB

----------------------------------------------------------------
Igor Prusov (2):
       spi: add support for Amlogic A1 SPI Flash Controller
       ARM: amlogic: ad401: enable SPIFC

Mattijs Korpershoek (1):
       configs: khadas-vim3*_android: fix environment saving

Neil Armstrong (4):
       ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
       configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
       configs: meson64: add alternate USB DFU boot target
       ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget

  configs/ad401_defconfig                   |   1 +
  configs/bananapi-cm4-cm4io_defconfig      |   6 +
  configs/bananapi-m2-pro_defconfig         |   6 +
  configs/bananapi-m2s_defconfig            |   6 +
  configs/bananapi-m5_defconfig             |   6 +
  configs/beelink-gsking-x_defconfig        |   6 +
  configs/beelink-gt1-ultimate_defconfig    |   6 +
  configs/beelink-gtking_defconfig          |   6 +
  configs/beelink-gtkingpro_defconfig       |   6 +
  configs/jethub_j100_defconfig             |   6 +
  configs/jethub_j80_defconfig              |   6 +
  configs/khadas-vim2_defconfig             |   6 +
  configs/khadas-vim3_android_ab_defconfig  |   8 +
  configs/khadas-vim3_android_defconfig     |   8 +
  configs/khadas-vim3_defconfig             |   6 +
  configs/khadas-vim3l_android_ab_defconfig |   8 +
  configs/khadas-vim3l_android_defconfig    |   8 +
  configs/khadas-vim3l_defconfig            |   6 +
  configs/khadas-vim_defconfig              |   6 +
  configs/libretech-ac_defconfig            |   6 +
  configs/libretech-cc_defconfig            |   6 +
  configs/libretech-cc_v2_defconfig         |   6 +
  configs/libretech-s905d-pc_defconfig      |   6 +
  configs/libretech-s912-pc_defconfig       |   6 +
  configs/nanopi-k2_defconfig               |   4 +
  configs/odroid-c2_defconfig               |   4 +
  configs/odroid-c4_defconfig               |   6 +
  configs/odroid-go-ultra_defconfig         |   6 +
  configs/odroid-hc4_defconfig              |   6 +
  configs/odroid-n2_defconfig               |   6 +
  configs/odroid-n2l_defconfig              |   6 +
  configs/p200_defconfig                    |   4 +
  configs/p201_defconfig                    |   4 +
  configs/p212_defconfig                    |   4 +
  configs/radxa-zero2_defconfig             |   6 +
  configs/radxa-zero_defconfig              |   6 +
  configs/s400_defconfig                    |   6 +
  configs/sei510_defconfig                  |   6 +
  configs/sei610_defconfig                  |   6 +
  configs/u200_defconfig                    |   6 +
  configs/videostrong-kii-pro_defconfig     |   4 +
  configs/wetek-core2_defconfig             |   6 +
  configs/wetek-hub_defconfig               |   4 +
  configs/wetek-play2_defconfig             |   4 +
  drivers/spi/Kconfig                       |   9 +
  drivers/spi/Makefile                      |   1 +
  drivers/spi/meson_spifc_a1.c              | 384 ++++++++++++++++++++++++++++++
  include/configs/meson64.h                 |  49 +++-
  48 files changed, 687 insertions(+), 7 deletions(-)
  create mode 100644 drivers/spi/meson_spifc_a1.c

