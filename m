Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E7DC30653
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 08:48:54 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.15396.1719823731326606131
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Jul 2024 01:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=WcOuAJCG;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso4027083e87.1
        for <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719823729; x=1720428529; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUvdH3IXhEmKAjhpbxVrzYZY642aKB40M8uAj9K8WhA=;
        b=WcOuAJCGmGKklmECgXjjQPG4pQe9sY/NEwfzOu0TQ0OGTeocquKhJjUKfonmlqRtpZ
         IwvmSnRSC5xBOF2bBM0dQ1M5LiZbqsmyEHyorjjN/6nAGUspo4SwL9xrbDRpoU0LL9x9
         vPZ8oz4cNS5phtdB1IOLB1vtclskDQwdWHZ6xIe7KZdkULB1sTqxLYl7p1wd3bskzWYE
         92+DG8WOAQrbOn7NDr3Ov+IBp2C1soIbfm6VKHUHZ7Nu8mJUHABFUci1IUau5hUyLzNp
         ZswJT18Ps9V1gFFMD5lHEY82g2APYOy/mKv1JoUvwasZcLBcY3oEws0xPxQJGHDFAgyl
         ihqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823729; x=1720428529;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUvdH3IXhEmKAjhpbxVrzYZY642aKB40M8uAj9K8WhA=;
        b=bY2DGuV/uKUdZrHuJrlf6QbeSdLDSa7SaIboS2yH3Uy9tPosu0gzhQqnU8v8AXWEjG
         OKcyr2fu9ZQp9na8IABzMuu2MwxEsYrcFHpkVgTYnqRi7f5S+tw3DmvAT+Mtqd1ach6j
         gLHd9ddGQ9AOWrr+xRrrliBI1JjpyIbmol0SKW9lAbfAa65zjs74EOBavBt/kBXbgqXF
         h8fOxBLgvM7EM3kXelfwWPf+X80Xntfp2qYH4spzSnuSZWZfqJQ2Pompm55UD47nM1Im
         YpzDyxQ7Yqn0CFLUS5VWPKUBnDt+vqhx8SR+ZvA2wf2bsvlmFtz5U4N+9zNfGx5SOflH
         W5JA==
X-Gm-Message-State: AOJu0YwGb+Cex5bb058pjD/TvkiDx+aTOSqxrNp4bx44fOqewlO+AXiJ
	SU1unHvbnQ7tY2/s7VhYV62PMXaBzwSfGY/rJGSSEa585GYNtb+NpwV5PEnZ+Jk=
X-Google-Smtp-Source: AGHT+IH4nK5l053KkmUPRiCdT8mRwhKf7gXLnj3rNWqk0vLPhXOAoXQ5TJMOsKhVFoWSYFBgrxupWQ==
X-Received: by 2002:a05:6512:31cc:b0:52e:76d5:9504 with SMTP id 2adb3069b0e04-52e82651c26mr3838107e87.3.1719823728742;
        Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4719:99ea:652b:10d0? ([2a01:e0a:982:cbb0:4719:99ea:652b:10d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c25esm143339375e9.9.2024.07.01.01.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
Message-ID: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
Date: Mon, 1 Jul 2024 10:48:47 +0200
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
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 08:48:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2335

Hi Tom,

A set of changes to switch meson dwc3/usb PHY to set_mode callback for switching USB mode,
and a driver declaration fixup for meson_axg_gpio.

Thanks,
Neil

The following changes since commit a7eada24327a40f7ef6c55c220e119839c9d4227:

   Merge tag 'v2024.07-rc5' into next (2024-06-24 13:34:52 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20240701

for you to fetch changes up to 96e1a156e90a0674b21c56e7121b17a9211176ec:

   meson: Correct driver declaration for meson_axg_gpio (2024-06-26 11:19:57 +0200)

----------------------------------------------------------------
- Switch meson dwc3/usb PHY to set_mode callback for switching USB mode

----------------------------------------------------------------
Neil Armstrong (5):
       phy: meson-gxl-usb2: add set_mode callback
       usb: dwc3: meson-gxl: switch to generic_phy_set_mode
       phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
       usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
       usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static

Simon Glass (1):
       meson: Correct driver declaration for meson_axg_gpio

  arch/arm/include/asm/arch-meson/usb-gx.h      | 17 ---------------
  arch/arm/include/asm/arch-meson/usb.h         | 12 -----------
  drivers/phy/meson-gxl-usb2.c                  | 30 ++++++++++++++++-----------
  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  2 +-
  drivers/pinctrl/meson/pinctrl-meson-axg.c     |  4 ++--
  drivers/pinctrl/meson/pinctrl-meson-axg.h     |  2 +-
  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  4 ++--
  drivers/usb/dwc3/dwc3-meson-g12a.c            |  2 +-
  drivers/usb/dwc3/dwc3-meson-gxl.c             | 18 +++++++++-------
  9 files changed, 35 insertions(+), 56 deletions(-)
  delete mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h
  delete mode 100644 arch/arm/include/asm/arch-meson/usb.h

