Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFB2CFC500
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 08:44:13 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.50175.1728895444160848783
 for <u-boot-amlogic@groups.io>;
 Mon, 14 Oct 2024 01:44:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QPeEx4I1;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso794431f8f.3
        for <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895442; x=1729500242; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGnn/1kuvFEYRPlOdtnHvVcZzIkFWxwfHv7bxdm+vKo=;
        b=QPeEx4I1fOhDpJ5ZW5Jjxo3eCP0hFkX35pfaZAR0UKNAFsjfr84lK7CoqhVUONJrAA
         vAc/fTvSnz5RDbP1ZYcmuE+UZ2S3vPgfuvFTL/2SNBvQo/ghIPcV5c5OEv4c+A8Irct5
         vGE7uY0trq4N8sC9L5rjzmA4LJj4rhMXcWiMk6DAL4idtdnnznlAZs70pF2fxwXy4v0G
         9k1orb9au/urAj/CXLFJuqAOtpwVJi4rHuZYMFV6yZtPed1JHCx7bebRqVU2CO/uVIfN
         PJUxaJU7ZPjDA3fy99BrK6u9+FEpQT/xlYRgFKjANbGbid+pjRxefXn+uGRWtYzhn2ky
         /Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895442; x=1729500242;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGnn/1kuvFEYRPlOdtnHvVcZzIkFWxwfHv7bxdm+vKo=;
        b=DjwaJuhtMGB4MYoYmPEnM2ZIABQcgDQ/WfuZuNzcM6MrJu47uHkIYfQI6KU9Id7KhA
         ZJxlAskfl+TPURi1BWzLzSjUQIpmCKK/dYUK6vl1AJ+zyi1+mOZmOYyPWCp2uPI8a7+e
         RzJGg4QMDhmkLHIc6iMn+T1mA+empmdcv+hwtXLM2Ue1qmqCyQ0P5nbDriFUxClM+4Ht
         65sUYks58L/rqhQnThRSevLAaWkrKNLk8liMF2nN3Rti2kadIg1VMmxSvgP7tmjjH1Qd
         ifYHaI+FVAMiqYbcaWK2hVj67kptpHhgA20ok2uFgxINRcNZtxjPIxSCSmFBoZlcEd57
         eszA==
X-Gm-Message-State: AOJu0YyQlJ8x5HuxOyOoEBArUlX2UCWLOjYg0Dgxg6MfI6rJaL6wGwPa
	18ogh7t3+9g/7FHorJ9WMSfdEjUlSI0Hnonv9VkQKDoavmKoGGX58TROSr5dGhVOLwuYP0hEi+A
	8cB8=
X-Google-Smtp-Source: AGHT+IH7Kus1GHRW62r22CceeHs+6kfZAOeO2YHfWGGvQL2EnOtghf8lkgqJGDGoQWCsqlJ2CryHXQ==
X-Received: by 2002:a5d:5f56:0:b0:37d:5047:76d8 with SMTP id ffacd0b85a97d-37d5532847bmr9054503f8f.59.1728895442435;
        Mon, 14 Oct 2024 01:44:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f? ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfcdbsm10795813f8f.58.2024.10.14.01.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:44:01 -0700 (PDT)
Message-ID: <d2b5a5e5-c50b-459e-a81e-90c952efdd16@linaro.org>
Date: Mon, 14 Oct 2024 10:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20241014
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
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 08:44:13 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2482

Hi Tom,

New Libre Computer boards are added with UEFI Capsule Update support,
plus various fixes for HDMI support, boot targets and android-mainline
kernel support for khadas-vim3 android config.

Thanks,
Neil

The following changes since commit 580fb5773634c4a01f907a164b2a05961840b4c0:

   Merge tag 'u-boot-imx-master-20241013' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-13 16:25:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20241014

for you to fetch changes up to 315cad97a5ae09b1b975fff2413ce785b3b8592a:

   configs: meson64: Ensure commands for boot targets are available (2024-10-14 09:06:16 +0200)

----------------------------------------------------------------
- Add Libre Computer boards into proper libre-computer board directory
- Add new Boards:
  - Libre Computer aml-s905d3-cc
  - Libre Computer aml-a311d-cc
- Add capsule update to libretech-ac and the new boards since they have an onboard SPI nor flash
- Fix HDMI support after sync to v6.11 and regulator enable from Marek
- Fix khadas-vim3 android config for android-mainline kernel
- Disable meson64 boot targets when configs are not eavailable

----------------------------------------------------------------
Callum Parsey (1):
       configs: meson64: Ensure commands for boot targets are available

Mattijs Korpershoek (2):
       configs: khadas-vim3{l}: Increase boot/recovery partition size
       configs: meson64_android: Remove dtbo support

Neil Armstrong (8):
       board: libretech-ac: move board support into dedicated directory
       board: libre-computer: aml-s805x-cc: Enable capsule updates
       ARM: meson: add support for Libre Computer aml-a311d-cc
       ARM: meson: add support for Libre Computer aml-s905d3-cc
       dts: meson-g12-common-u-boot: do not disable canvas
       video: meson: dw-hdmi: do not fail probe if HDMI regulator is already enabled
       clk: meson: gxbb: add HDMI clocks
       power/domain: meson-ee-pwrc: make sure to not enable a domain twice

  arch/arm/dts/meson-g12-common-u-boot.dtsi          |   4 -
  .../dts/meson-g12b-a311d-libretech-cc-u-boot.dtsi  |  15 +++
  .../dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi  |  15 +++
  board/amlogic/p212/MAINTAINERS                     |   2 -
  board/libre-computer/aml-a311d-cc/MAINTAINERS      |   7 ++
  board/libre-computer/aml-a311d-cc/Makefile         |   6 ++
  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  44 +++++++++
  board/libre-computer/aml-s805x-ac/MAINTAINERS      |   8 ++
  board/libre-computer/aml-s805x-ac/Makefile         |   6 ++
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   |  71 ++++++++++++++
  board/libre-computer/aml-s905d3-cc/MAINTAINERS     |   7 ++
  board/libre-computer/aml-s905d3-cc/Makefile        |   6 ++
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  44 +++++++++
  configs/aml-a311d-cc_defconfig                     | 108 +++++++++++++++++++++
  configs/aml-s905d3-cc_defconfig                    | 108 +++++++++++++++++++++
  configs/libretech-ac_defconfig                     |   8 ++
  doc/board/amlogic/aml-a311d-cc.rst                 |  46 +++++++++
  doc/board/amlogic/aml-s905d3-cc.rst                |  46 +++++++++
  doc/board/amlogic/index.rst                        |   2 +
  drivers/clk/meson/gxbb.c                           |  50 +++++++++-
  drivers/power/domain/meson-ee-pwrc.c               |  15 ++-
  drivers/video/meson/meson_dw_hdmi.c                |   4 +-
  include/configs/khadas-vim3_android.h              |   8 +-
  include/configs/khadas-vim3l_android.h             |   8 +-
  include/configs/meson64.h                          |  28 +++++-
  include/configs/meson64_android.h                  |  26 +----
  26 files changed, 643 insertions(+), 49 deletions(-)
  create mode 100644 arch/arm/dts/meson-g12b-a311d-libretech-cc-u-boot.dtsi
  create mode 100644 arch/arm/dts/meson-sm1-s905d3-libretech-cc-u-boot.dtsi
  create mode 100644 board/libre-computer/aml-a311d-cc/MAINTAINERS
  create mode 100644 board/libre-computer/aml-a311d-cc/Makefile
  create mode 100644 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
  create mode 100644 board/libre-computer/aml-s805x-ac/MAINTAINERS
  create mode 100644 board/libre-computer/aml-s805x-ac/Makefile
  create mode 100644 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
  create mode 100644 board/libre-computer/aml-s905d3-cc/MAINTAINERS
  create mode 100644 board/libre-computer/aml-s905d3-cc/Makefile
  create mode 100644 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
  create mode 100644 configs/aml-a311d-cc_defconfig
  create mode 100644 configs/aml-s905d3-cc_defconfig
  create mode 100644 doc/board/amlogic/aml-a311d-cc.rst
  create mode 100644 doc/board/amlogic/aml-s905d3-cc.rst

