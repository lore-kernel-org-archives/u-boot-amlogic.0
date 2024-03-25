Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B9C54E58
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 09:45:51 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.47869.1711359946660872875
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 02:45:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=vct8CJeT;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-414866f92beso6226585e9.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711359945; x=1711964745; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcrEtD3QKqez7BRwuFAL5gLLM1Hprt+fJgIRbNpXL88=;
        b=vct8CJeTRcZBViIS9fInj6JjHU6BX9TfJPU1vx7zsLgX/WdQshXN0Lc6iZrZomVvXN
         5MOSYT1Gf08JZqqWcAaPP/PhiudhyxLMvGmzeZbua9QAUr+hTMo/gBNEueMTUrgAnN1W
         hbmQ7biDCwz03LST3JgoZhqjmhrPHPzzn5oow5LfzA4mkQCyLhAVm8xD1m7kuA3WnQWb
         CkuMYKx6gn6IKMG9zdcYPCVj6I7nOnGwHLiHasb1WNpLYqrnLcgAZfPZL70Nk9oQN+m5
         ic9F1Htq8Wr5S5RiqzecctZu8u8jWrC5v1ooHtJkPWS70dDD4Wq/pQ/SZOkUbhO8gXd/
         I7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359945; x=1711964745;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcrEtD3QKqez7BRwuFAL5gLLM1Hprt+fJgIRbNpXL88=;
        b=OWJ8xNrtq3NvLtnpT9uM9bwukyxwNg/VEHyhanq4R1gler5A8XufXkQXtflsE9eN8b
         GWlAw/TIvFXdBPnAKC2OoYXDmKzax3MCURH+jtelJsLMfGPGSzGiLyl+QrpZ+XlOI/LP
         xMgE9o+q8r5nuscUguUzVlXLESB6y6ykO4HPse06MVyvTGRgjNDQ5kU5L2oPULOD0Kzl
         gKE9qh37llP3uNf6S5rhBaTWZ8xLK/GKt7GHxtlrvzuVlzwKH/Yd7KJmWdJTcW7OXfgY
         VHsD9TxdGs/Hk+BdFbc6zLyV4BRwZOQajr+MUi9nYbml59hy6UpmDb6jK/HGNO6LsujD
         bl5g==
X-Gm-Message-State: AOJu0Yx/AKt5yO5keoDt0LeM3+Nw9SzF2QD7cvCvLPbRNYegf31+m5H8
	mM9HSdT9fSL2mGVfUAnVbqvXKl4vlw9brksPfww4Sf8FKQyTuLMpDlQy6ZwfFm5jV4rY4Btx//7
	WIh03xw==
X-Google-Smtp-Source: AGHT+IH/clFILcuiKEU0XbYV4mUD/qtU0/Lj8AUkPNq59Cp5nj9iYsxhP6EXxR5fDirP44O8L79fQg==
X-Received: by 2002:a05:600c:a02:b0:413:1ae3:8dd2 with SMTP id z2-20020a05600c0a0200b004131ae38dd2mr4515304wmp.37.1711359944691;
        Mon, 25 Mar 2024 02:45:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:32cb:35f3:5930:592a? ([2a01:e0a:982:cbb0:32cb:35f3:5930:592a])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0041480a98bb3sm7239828wmq.15.2024.03.25.02.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:45:44 -0700 (PDT)
Message-ID: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
Date: Mon, 25 Mar 2024 10:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-fixes-20240325
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
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 09:45:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2246

Hi Tom,

Please pull this set of last minute fixes

Thanks,
Neil

The following changes since commit bd0aedde3ea3691616c17c720e2d25351308c0a1:

   board: toradex: verdin-am62_r5: Increase SPL_STACK_R_MALLOC_SIMPLE_LEN (2024-03-22 11:10:51 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-fixes-20240325

for you to fetch changes up to d54f87f09a36ac20154955297b7c999b368b0443:

   board: amlogic: fix buffler overflow in seria, mac & usid read (2024-03-25 09:16:19 +0100)

----------------------------------------------------------------
- fix Ethernet and random MAC's on WeTek Hub/Play2
- fix buffer overflow in serial, mac & usid read

----------------------------------------------------------------
Christian Hewitt (2):
       ARM: dts: fix Ethernet on WeTek Hub/Play2
       board: amlogic: add meson_generate_serial_ethaddr fallback to p200

Neil Armstrong (1):
       board: amlogic: fix buffler overflow in seria, mac & usid read

  ...b-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
  arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi             | 13 +++++++++++++
  board/amlogic/beelink-s922x/beelink-s922x.c                 |  3 ++-
  board/amlogic/jethub-j100/jethub-j100.c                     |  3 ++-
  board/amlogic/jethub-j80/jethub-j80.c                       |  9 ++++++---
  board/amlogic/odroid-n2/odroid-n2.c                         |  3 ++-
  board/amlogic/p200/p200.c                                   |  8 ++++++--
  board/amlogic/p201/p201.c                                   |  6 ++++--
  board/amlogic/p212/p212.c                                   |  6 ++++--
  board/amlogic/q200/q200.c                                   |  6 ++++--
  board/amlogic/vim3/vim3.c                                   |  3 ++-
  11 files changed, 45 insertions(+), 15 deletions(-)
  rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
  create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

