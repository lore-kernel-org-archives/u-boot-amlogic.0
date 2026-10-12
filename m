Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8207CA9EC5
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 15:44:27 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16475.1791819864842482790
 for <u-boot-amlogic@groups.io>;
 Mon, 12 Oct 2026 08:44:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=e4pFsEh5;
 spf=pass (domain: linaro.org, ip: 209.85.221.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b060ec084so1253030f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 12 Oct 2026 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791819863; x=1792424663; darn=groups.io;
        h=content-transfer-encoding:content-type:organization:autocrypt
         :content-language:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
        b=e4pFsEh5wUJQ0/KneMYQZEusgkT6sk+Hx+XqEzzobadAkqGPPybdNL7wj0Iqkk8Jae
         8qRCQb1Dx62R6uJyzYpu6ot4/MPU+BngQr1DgMY0aOIChfkAHJBe4RlACbPZ0EwSO6iX
         AXyffk0hVNSzc8bvxFH8Ll+CUoab/C8+/FPBklyMcRd82Ka5OSjbzsUKvHPBiZrCq+Jx
         0d0zy+Ey8vlzauF1wTQeky1mKy5M4nDu1Sl4YZhfOjO8hVD60N38R+no/vlNBNHCA9fI
         /ep2fwZnuuvoIpcTD501RKUJttkhZ4U3M5f4AUj3p2moP0ohWQlMAgiUHUhy+Z4alGGG
         2VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819863; x=1792424663;
        h=content-transfer-encoding:content-type:organization:autocrypt
         :content-language:cc:to:reply-to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b/CwHOVBkeCOQ01mmPsOnT+9oefBtixE7b9i4h9AB18=;
        b=oDzEfE4CPSpFnEQ5uGDwrmiMHAtff5ckgloZjx7UKXA7acyAJ7hstuVHcXhu0fSFOV
         CTBZC5xD431WmrEtO7ROn4LS77m14mNtRFcS2d4FDsjFEsAoIw8PGfF+kSBddQ5GZVbB
         ctKSmMlWdSoMIZf0n0KB1c7ZdLa0s+MBIlZoKN0JgQ9cYwCXqCXYDCmo8m7vX7Mucbig
         +pU9CJGJ/GoBfJicOPtPRBmMcoDgKo229+7ljGbgrJ2lgtei9qc9LPQXwfUvVi9aRTp4
         d+Hm2cfbR0rm87kz475qBUxPnTnAtXtubCdO8UYQUMBGGCE87Ytm6/Z6Cv2zafdz6Dv/
         +mYA==
X-Gm-Message-State: AFq9FYIOuz18DqEfOV0zRCodjvWRlCQcOiWJJLR3/L4chIP38sjEdGE4
	hFkvmNv2AhcL3ZUt7NhXTiY/RQthWnf4xVuXcXdiCjh+eSwhghGdWkplYATV1VP0jbk=
X-Gm-Gg: AYBFou1FgExgfjknlydl8XYANXaZXRtCF9Y5QcdOwobOJSbnkV1voUd71rCY4cW5qNk
	dbare3ARqEsLX4EaRhdTWHHQ9eNppv3FypNImmL1cjmbMuEWLicJe3YyWN9OiLy0F+VYKbQTSTZ
	QX7ruuN1ZOzKl4c2CGaArz34S8R97lCzGskaGP1Dy5+oS9mDjsmxJNkGn3KyvM+BTYaEjQ9xNtT
	hgJpgGHpOzUaGx18T/LiaZX5QxUVqNbA9jOp8K3Nz7yeI8LH7gpH+NM4eotE3GmAapYlA8ONIdV
	5X/F1r2m9polkMN+WYowv7Y5Y5ha2dk5qHv21plUjXFJORE730YtfuRK9Lr6gAwwW2Q11k0E127
	BjbjEBVubZfTZvwkixx+i7o7R7WinSA005QP++7xhUFosY2MbS5XPDGzwe22skzRwf+ziYuqLqU
	S8tu9pskr0N3yJtfw1rceP1hLK8MERHytYv2/vLCpLiVPzy/PyTTmBoQhv6JlFIAtzjrDHE0j2F
	4cUANcAd5YfIYuO3kjNgsL8krdm/+yDvyfH
X-Received: by 2002:a05:6000:989:b0:48d:b650:69aa with SMTP id ffacd0b85a97d-48dbacf596fmr17396840f8f.50.1791819862371;
        Mon, 12 Oct 2026 08:44:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:417e:f4c4:5b8:8c48? ([2a01:e0a:106d:1080:417e:f4c4:5b8:8c48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm81885f8f.57.2026.10.12.08.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:44:22 -0700 (PDT)
Message-ID: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
Date: Mon, 12 Oct 2026 17:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20261012
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
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
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 12 Oct 2026 15:44:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3129

Hi Tom,

Here's a set of Amlogic changes which enabled basic Amlogic S4 support for Khadas VIM1S,
plus cleanup & update for Android support.

Thanks,
Neil

The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:

   Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-amlogic.git tags/u-boot-amlogic-next-20261012

for you to fetch changes up to 9c048da44bed99311355450d70840bb0795e21f8:

   meson: Add Khadas VIM1S support (2026-10-08 10:45:27 +0200)

----------------------------------------------------------------
- Support watchdog for S4/T7
- Add S4 support:
  - reset
  - serial
  - clock
  - mmc
  - SoC support
  - Khadas VIM1S
- Remove Android support for SEI510/SEI610
- Fix Android support for Khadas VIM3

----------------------------------------------------------------
Guillaume La Roque (7):
       configs: sei510: drop Android support
       configs: sei610: drop Android support
       configs: remove unused meson64_android.h
       configs: khadas-vim3: drop non-A/B Android defconfigs
       configs: khadas-vim3: enlarge the fastboot buffer
       configs: khadas-vim3: update the Android partition layout
       configs: khadas-vim3: fix the Android DTB index

Sean Anderson (13):
       watchdog: meson_gxbb: Add support for s4/t7 SoCs
       reset: meson: Add s4 support
       serial: meson: Add s4 support
       mmc: meson: Parse devicetree properties
       arm64: meson: Add s4 SoC support
       clk: meson: a1: Eliminate separate id parameter
       clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
       clk: meson: Use soc-specific naming for common functions
       clk: meson: Export a1 functions to common file
       clk: meson: Support fractional fixed-factor clocks
       clk: meson: Support power-of-two dividers
       clk: meson: Add s4 clock driver
       meson: Add Khadas VIM1S support

  MAINTAINERS                                        |   1 -
  .../dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi   |   5 +
  arch/arm/include/asm/arch-meson/boot0.h            |  12 +
  arch/arm/mach-meson/Kconfig                        |   7 +
  arch/arm/mach-meson/Makefile                       |   1 +
  arch/arm/mach-meson/board-info.c                   |   2 +
  arch/arm/mach-meson/board-s4.c                     |  50 ++
  board/amlogic/sei510/MAINTAINERS                   |   1 -
  board/amlogic/sei610/MAINTAINERS                   |   1 -
  board/amlogic/vim1s/MAINTAINERS                    |   7 +
  board/amlogic/vim1s/Makefile                       |   1 +
  board/amlogic/vim1s/vim1s.c                        |  26 +
  board/amlogic/vim3/MAINTAINERS                     |   2 -
  configs/khadas-vim1s_defconfig                     |  66 +++
  configs/khadas-vim3_android_ab_defconfig           |   1 +
  configs/khadas-vim3_android_defconfig              | 122 -----
  configs/khadas-vim3l_android_ab_defconfig          |   1 +
  configs/khadas-vim3l_android_defconfig             | 122 -----
  configs/sei510_defconfig                           |  10 -
  configs/sei610_defconfig                           |  10 -
  drivers/clk/meson/Kconfig                          |   8 +
  drivers/clk/meson/Makefile                         |   2 +
  drivers/clk/meson/a1.c                             | 495 +----------------
  drivers/clk/meson/axg-ao.c                         |  12 +-
  drivers/clk/meson/axg.c                            |  16 +-
  drivers/clk/meson/clk_meson.c                      | 376 +++++++++++++
  drivers/clk/meson/clk_meson.h                      | 149 +++++
  drivers/clk/meson/g12a-ao.c                        |  12 +-
  drivers/clk/meson/g12a.c                           |  24 +-
  drivers/clk/meson/gxbb.c                           |  24 +-
  drivers/clk/meson/s4.c                             | 601 +++++++++++++++++++++
  drivers/mmc/meson_gx_mmc.c                         |   3 +
  drivers/reset/reset-meson.c                        |   9 +
  drivers/serial/Kconfig                             |   2 +
  drivers/serial/serial_meson.c                      |   1 +
  drivers/watchdog/meson_gxbb_wdt.c                  |  22 +-
  include/configs/khadas-vim3_android.h              |  36 +-
  include/configs/khadas-vim3l_android.h             |  36 +-
  include/configs/meson64_android.h                  | 279 ----------
  include/configs/sei510.h                           |  30 -
  include/configs/sei610.h                           |  30 -
  41 files changed, 1422 insertions(+), 1193 deletions(-)
  create mode 100644 arch/arm/dts/meson-s4-s905y4-khadas-vim1s-u-boot.dtsi
  create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
  create mode 100644 arch/arm/mach-meson/board-s4.c
  create mode 100644 board/amlogic/vim1s/MAINTAINERS
  create mode 100644 board/amlogic/vim1s/Makefile
  create mode 100644 board/amlogic/vim1s/vim1s.c
  create mode 100644 configs/khadas-vim1s_defconfig
  delete mode 100644 configs/khadas-vim3_android_defconfig
  delete mode 100644 configs/khadas-vim3l_android_defconfig
  create mode 100644 drivers/clk/meson/clk_meson.c
  create mode 100644 drivers/clk/meson/s4.c
  delete mode 100644 include/configs/meson64_android.h
  delete mode 100644 include/configs/sei510.h
  delete mode 100644 include/configs/sei610.h

