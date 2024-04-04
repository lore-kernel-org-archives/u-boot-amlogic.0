Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38985CD1284
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 16:53:05 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.43739.1712249576250190794
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Apr 2024 09:52:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LkBoV4R0;
 spf=pass (domain: linaro.org, ip: 209.85.221.43, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343cd12630aso417479f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Apr 2024 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712249575; x=1712854375; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6cDqREbLHI/zYd7s9AoenXPcmTJ2h4XSsQf8sOeiAA=;
        b=LkBoV4R0zG2IFkG8A/854Xnli2dgaWAVlpjEc4EQtrIGlKHZdDZkbF8naZ43hG3ps8
         nqe0WZ9giSW8j/cmFIeBThusgYKeGiSFxCiXFxFxBK+WRyJCgwwEq+jh5HZ2zGor8gui
         joosaBfv+7OjLRyOx/J05jUZwr3sIteJJzIiPjVmpf5+5QehbuM9poAmoeqOoGHjKlyY
         bZn7Iaf8CJ6czQ2RO1enB+COPHV0oWVA2bCBG5diswQnr6xn6ss0Ft6pdRfvPG/JA/O2
         /a0pztF+QLlnyTH5vPBuepcJlVVLKmYna3YGUfiitNSGMWL8or1BlFY8mZJNxUy/+hNO
         VTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249575; x=1712854375;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6cDqREbLHI/zYd7s9AoenXPcmTJ2h4XSsQf8sOeiAA=;
        b=svt3mxhuQSECsbh38cofuEsVvD/1Qp/XzCWp7j/RpBxgJM0c/aJmP4FcawqkjxeqDK
         yHApBgWAG94KfWSXnnCz3XuvfwCQwqT/J13Cp7LeUSONxeEpsHT3KVQ8ria296fZts1/
         s0+YFU35xNfE11kKKytiRn6nuGod06nfI9uLV91Y9NyS4BgjJIJzheutFg+AsURL0oyo
         1AL1uJcshSWtaFJsfNL8ym8QDpHbgwxodnxE1wQeIIddV3wOnx/3jbRXyaJUskpI3kfU
         fUcEpxdZ5SlrYAdbj+I0E2TO1umj2i0FcqleeuTpr7VhuxjBBEXM7KoQ/GRo1BTsTOjR
         r65Q==
X-Gm-Message-State: AOJu0YwMgFHPesm0ecXseT6Br+EV4tX1IUXzcJZ6jyJ0ASwyJhcFR7vo
	cvfv0FkaRpnXBwA+4QIgdYOnsDYjGchz8nY3BH26emOxtOnkut+tHCCgWionPGA=
X-Google-Smtp-Source: AGHT+IEIZ5ZW/IcevXx39YD22zbJK42F6XlOIra7Zmy+tZvbN670CcR0+N/5MAX1M8tOuKi0ARJvKQ==
X-Received: by 2002:a5d:4903:0:b0:343:688d:2cbf with SMTP id x3-20020a5d4903000000b00343688d2cbfmr90898wrq.60.1712249574354;
        Thu, 04 Apr 2024 09:52:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5910:95db:d5a3:46d6? ([2a01:e0a:982:cbb0:5910:95db:d5a3:46d6])
        by smtp.gmail.com with ESMTPSA id ay26-20020a5d6f1a000000b0034355b7e995sm9685183wrb.13.2024.04.04.09.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:52:53 -0700 (PDT)
Message-ID: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
Date: Thu, 4 Apr 2024 18:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20240404
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
 <u-boot-amlogic@groups.io>; Thu, 04 Apr 2024 16:53:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2265

Hi Tom,

Please pull this migration to OF_UPSTREAM for all Amlogic SoCs family
except the newer A1 family.
In Addition, there's a few fixes & updates for the jethubj100 board.

Thanks,
Neil

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20240404

for you to fetch changes up to 114df8b5339e503b50b6ac1a61bf1daac57c2e11:

   dts: meson: Drop redundant G12A, G12B & SM1 devicetree files (2024-04-04 18:48:46 +0200)

----------------------------------------------------------------
- jethubj100: fix config, MAINTAINERS & update docs
- Switch GXL, GXM, AXG, G12A, G12B & SM1 to using upstream DT

----------------------------------------------------------------
Neil Armstrong (5):
       configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
       dts: meson: Switch GXL, GXM & AXG to using upstream DT
       dts: meson: Drop redundant GXL, GXM & AXG devicetree files
       dts: meson-g12a: Switch to using upstream DT
       dts: meson: Drop redundant G12A, G12B & SM1 devicetree files

Viacheslav Bocharov (3):
       board: amlogic: jethubj100: fix common config header
       board: amlogic: jethubj100: update MAINTAINERS
       board: amlogic: jethubj100: update docs

  arch/arm/dts/Makefile                              |   36 +-
  arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
  arch/arm/dts/meson-axg-s400.dts                    |  602 -----
  arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
  arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
  arch/arm/dts/meson-g12.dtsi                        |  385 ---
  arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
  arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
  arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
  arch/arm/dts/meson-g12a.dtsi                       |  140 --
  arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
  arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
  arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
  arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
  arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
  arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
  arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
  arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
  arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
  arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
  arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
  arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
  arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
  arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
  arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
  arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
  arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
  arch/arm/dts/meson-g12b.dtsi                       |  146 --
  arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
  arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
  arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
  arch/arm/dts/meson-gx.dtsi                         |  675 ------
  arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
  arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
  arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
  arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
  .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
  arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
  arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
  arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
  arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
  arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
  arch/arm/dts/meson-gxl.dtsi                        |  940 --------
  arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
  arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
  arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
  arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
  arch/arm/dts/meson-gxm.dtsi                        |  216 --
  arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
  arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
  arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
  arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
  arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
  arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
  arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
  arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
  arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
  arch/arm/dts/meson-sm1.dtsi                        |  550 -----
  arch/arm/mach-meson/Kconfig                        |    4 +
  board/amlogic/jethub-j100/MAINTAINERS              |    2 +-
  configs/bananapi-cm4-cm4io_defconfig               |    2 +-
  configs/bananapi-m2-pro_defconfig                  |    2 +-
  configs/bananapi-m2s_defconfig                     |    2 +-
  configs/bananapi-m5_defconfig                      |    2 +-
  configs/beelink-gsking-x_defconfig                 |    2 +-
  configs/beelink-gt1-ultimate_defconfig             |    2 +-
  configs/beelink-gtking_defconfig                   |    2 +-
  configs/beelink-gtkingpro_defconfig                |    2 +-
  configs/jethub_j100_defconfig                      |    2 +-
  configs/jethub_j80_defconfig                       |    2 +-
  configs/khadas-vim2_defconfig                      |    2 +-
  configs/khadas-vim3_android_ab_defconfig           |    2 +-
  configs/khadas-vim3_android_defconfig              |    2 +-
  configs/khadas-vim3_defconfig                      |    2 +-
  configs/khadas-vim3l_android_ab_defconfig          |    2 +-
  configs/khadas-vim3l_android_defconfig             |    2 +-
  configs/khadas-vim3l_defconfig                     |    2 +-
  configs/khadas-vim_defconfig                       |    2 +-
  configs/libretech-ac_defconfig                     |    2 +-
  configs/libretech-cc_defconfig                     |    2 +-
  configs/libretech-cc_v2_defconfig                  |    2 +-
  configs/libretech-s905d-pc_defconfig               |    2 +-
  configs/libretech-s912-pc_defconfig                |    2 +-
  configs/odroid-c4_defconfig                        |    2 +-
  configs/odroid-go-ultra_defconfig                  |    2 +-
  configs/odroid-hc4_defconfig                       |    2 +-
  configs/odroid-n2_defconfig                        |    2 +-
  configs/odroid-n2l_defconfig                       |    2 +-
  configs/p212_defconfig                             |    2 +-
  configs/radxa-zero2_defconfig                      |    2 +-
  configs/radxa-zero_defconfig                       |    2 +-
  configs/s400_defconfig                             |    2 +-
  configs/sei510_defconfig                           |    2 +-
  configs/sei610_defconfig                           |    2 +-
  configs/u200_defconfig                             |    2 +-
  configs/wetek-core2_defconfig                      |    2 +-
  doc/board/amlogic/jethub-j100.rst                  |   11 +-
  include/configs/jethub.h                           |    2 +-
  include/configs/meson64.h                          |    8 +-
  include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
  include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
  include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
  include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
  include/dt-bindings/power/meson-axg-power.h        |   14 -
  include/dt-bindings/power/meson-g12a-power.h       |   13 -
  include/dt-bindings/power/meson-gxbb-power.h       |   13 -
  include/dt-bindings/power/meson-sm1-power.h        |   18 -
  .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
  .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
  .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
  .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
  .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
  include/dt-bindings/sound/meson-aiu.h              |   18 -
  include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
  include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
  120 files changed, 58 insertions(+), 21518 deletions(-)
  delete mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
  delete mode 100644 arch/arm/dts/meson-axg-s400.dts
  delete mode 100644 arch/arm/dts/meson-axg.dtsi
  delete mode 100644 arch/arm/dts/meson-g12-common.dtsi
  delete mode 100644 arch/arm/dts/meson-g12.dtsi
  delete mode 100644 arch/arm/dts/meson-g12a-radxa-zero.dts
  delete mode 100644 arch/arm/dts/meson-g12a-sei510.dts
  delete mode 100644 arch/arm/dts/meson-g12a-u200.dts
  delete mode 100644 arch/arm/dts/meson-g12a.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts
  delete mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
  delete mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-gsking-x.dts
  delete mode 100644 arch/arm/dts/meson-g12b-gtking-pro.dts
  delete mode 100644 arch/arm/dts/meson-g12b-gtking.dts
  delete mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-go-ultra.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2-plus.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2l.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-radxa-zero2.dts
  delete mode 100644 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts
  delete mode 100644 arch/arm/dts/meson-g12b-s922x.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-w400.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-mali450.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-p23x-q20x.dtsi
  delete mode 100644 arch/arm/dts/meson-gx.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-mali.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s805x.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-p212.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-p212.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905x.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl.dtsi
  delete mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
  delete mode 100644 arch/arm/dts/meson-gxm-khadas-vim2.dts
  delete mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
  delete mode 100644 arch/arm/dts/meson-gxm-wetek-core2.dts
  delete mode 100644 arch/arm/dts/meson-gxm.dtsi
  delete mode 100644 arch/arm/dts/meson-khadas-vim3.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi-m5.dts
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid-hc4.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-sei610.dts
  delete mode 100644 arch/arm/dts/meson-sm1.dtsi
  delete mode 100644 include/dt-bindings/gpio/meson-axg-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-gxbb-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-gxl-gpio.h
  delete mode 100644 include/dt-bindings/power/meson-axg-power.h
  delete mode 100644 include/dt-bindings/power/meson-g12a-power.h
  delete mode 100644 include/dt-bindings/power/meson-gxbb-power.h
  delete mode 100644 include/dt-bindings/power/meson-sm1-power.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
  delete mode 100644 include/dt-bindings/sound/meson-aiu.h
  delete mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
  delete mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h

