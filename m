Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D17CAC5B8
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 18:37:19 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.1316.1759257430258944661
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Sep 2025 11:37:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=mBU7WdmE;
 spf=pass (domain: linaro.org, ip: 209.85.128.42, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so38850125e9.0
        for <u-boot-amlogic@groups.io>; Tue, 30 Sep 2025 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759257429; x=1759862229; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONjENpCRmhqAi8gk6hWzUM8u623rvhaxpiHxoiPqHwY=;
        b=mBU7WdmEEeKLF7y2i3I5u9BUiFRf5MW7CS5huyVWLyi7SAoSKwij7l9mwvMxdRgwfo
         KBEv6C6GQJZacHlnjd86MliL/9cMJruwI25RBqT1TsiXBJ6wGcDIMc1yye0n2RbnD4gr
         08UVKFnnEHIaKAwf154XpOVI5WjMb36SKQ2oT4LYcoM/MOqcZEIvTV+/gEGxLLppq5sB
         nYAAMf2n9Vvlx2WYLFJK5HrhXC0ljSzWW9hTxzHkQxNIlNS+iAXer5hf8t+O8nv2Zn9+
         Vhj7VKXBFdUwdukF6QwFlfDmOXsOa3/nBfCwod1xH286NdahVMg/EoOVgKyn9zLWuF22
         6sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257429; x=1759862229;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONjENpCRmhqAi8gk6hWzUM8u623rvhaxpiHxoiPqHwY=;
        b=o1IxKCOksuR1ypRy8TZ3if3eTghYeFDZRjeD9fXNU511HvfxgvqCHFkAXLmGo09zFO
         hZCPaleGnJYP6+i6jde+WhbXU0J9KtmQVt0qr6O4lmq+Ro/5oxDOXagqU8uKP74kOPzM
         q2M0dLjz3mTCt9eDvdB9U692+ZbSR2sMuW0a/E2wSgs0n7Yed1SV8dZa+5hr9Ip+Y/bD
         bCb7DKfKAvtXQx/FqDW4lFYM+71U/jUgXyuUnI834B5aPLldT4sINKOS9kClufGJbhdd
         3xu0cITuTrJNW3EB0+vk3bBYRYxiZXOlV0L7hOiD0HXA7Y+42Ebzm9LKfzgfflYiH4po
         wE5g==
X-Gm-Message-State: AOJu0YwAt45++nq7Y0vlgy9PjdvJxBormSKdKReqSISHwbjX7HZmwB3t
	Ddp7SBk4VKkN+foWeaPANTVBvor6GWKbbQS965QAY2IRr/4cTSAQfpv9OxY2u123iYaP64+NF0b
	RL+Zx
X-Gm-Gg: ASbGnct9rjiH8lQ7JtctB85POPPDuTKhZNhYsqUDYHldNjqGP+JIz6mK6/Mwgbjo6/M
	gIp2NjS5UAed4HMluoHCNhHiP8KxUXHH4/okybeneGCW930bT8IuBxxW1xEMxsUr2aGpo3CAETO
	xBNuDiQyW7IiRWkU/lVApUG8/ISRnK78K50bAI8NSzX08IvEzjs7qME/3KINwjgEAnqN/0mst5q
	qqeuI3ZBb93doIIP85Eax54mGXWk7Btf4SIbwUBhztu/IpxHz0fIN/hYHfTHlYfagiQocYRdtXI
	atJs5RotIZ/XY8gCIPJVdwlu1X5qHFbAsxcv6VcAL4mSKGXLfvEZvh9eLTwxeKA6cVSW2IHGqA6
	KWFw/qD85sf74FMBLmBAeWFbNpH1LfdO50unTCdwlgO1Mz0hzZzAiqIivlUFCYWTqF+XT1x+aCv
	vtn5qBAux8dyssOhhozWwslBPJ8vTQd7Hp+A==
X-Google-Smtp-Source: AGHT+IGWQlHfGrMuIA7R4JZCPoXvtDiDSv4tTOgiLMZjF0GHz3YeALSoEY6c5vPFJbiSNNPqVjtugQ==
X-Received: by 2002:a05:600c:37cc:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46e6126ae01mr7415875e9.6.1759257428379;
        Tue, 30 Sep 2025 11:37:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859? ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3b75sm4430225e9.7.2025.09.30.11.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:37:08 -0700 (PDT)
Message-ID: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
Date: Tue, 30 Sep 2025 20:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20250930
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
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
 <u-boot-amlogic@groups.io>; Tue, 30 Sep 2025 18:37:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2786

Hi Tom,

Here's a small set of Amlogic changes for the next release.

Thanks,
Neil

The following changes since commit 9710d98e8942151fc0c62d54100d9d27e8263d04:

   Merge tag 'doc-next-2025-09-27' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-09-27 09:49:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20250930

for you to fetch changes up to d521fa32cc692a44c7c11d4b2a86f371d614e727:

   ARM: amlogic: fix JetHub D1 eth mac fallback generation (2025-09-30 20:32:15 +0200)

----------------------------------------------------------------
- set reversed bit when using internal phy on GXL SoCs
- support gpio toggle command for amlogic gpio
- fix saradc
- remove unreachable in meson clk driver
- Stop premature exit from for loop in meson pwm driver
- fix JetHub D1 eth mac fallback generation

----------------------------------------------------------------
Andrew Goodbody (3):
       adc: meson-saradc: uint cannot be less than zero
       clk: meson: Remove unreachable code
       pwm: meson: Stop premature exit from for loop

Neil Armstrong (1):
       net: mdio: mux-meson-gxl: set reversed bit when using internal phy

Viacheslav Bocharov (1):
       ARM: amlogic: fix JetHub D1 eth mac fallback generation

Yang Xiwen (1):
       pinctrl: meson: support gpio toggle command

  board/amlogic/jethub-j100/jethub-j100.c | 22 +++++++++-------------
  drivers/adc/meson-saradc.c              |  8 ++++----
  drivers/clk/meson/g12a.c                |  2 --
  drivers/net/mdio_mux_meson_gxl.c        |  3 ++-
  drivers/pinctrl/meson/pinctrl-meson.c   | 20 +++++++++++++++++++-
  drivers/pwm/pwm-meson.c                 |  3 ++-
  6 files changed, 36 insertions(+), 22 deletions(-)


