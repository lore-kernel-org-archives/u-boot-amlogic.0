Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A942EFF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 07:53:55 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38027.1777276434301906480
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Apr 2026 00:53:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iFWXMDYq;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891b0786beso70246155e9.1
        for <u-boot-amlogic@groups.io>; Mon, 27 Apr 2026 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777276433; x=1777881233; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBdzZxS33oTsi3JXiSoA1A8tpFKlShXs59Ic8lkNYfo=;
        b=iFWXMDYqIuoIIYtochPvT3RLNWC2NqVec3lwALk4PzFOaWwq5QCzSHQcfSgfdPQQx8
         3jVJdBKkptqrOYiT0rAMDuNIQiCLT3Y6hPW8RuOVlEs/9dvlTy8fnKmkaOJq5RWGTxVY
         GuZBZNqwRpHhE7K6gCt2ssJGoqmD1nuaodKReQzr2nnWlyXcZq7L07eERxJRKk1d2QZP
         CPdSWf97lhm/pLxLm3AIIOLCnh8/DCs9U0PfzlsqUzW0pnk3sO1ld3Nj7n29zVOXXwq/
         UlSTwvKa6xoW4cLxJg5XBvcFHKZbggnzOdzQVlnUolzJWjspJZq653z2WPjVBFEdVdh7
         mtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777276433; x=1777881233;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBdzZxS33oTsi3JXiSoA1A8tpFKlShXs59Ic8lkNYfo=;
        b=hCHFsvG8bxt9W9EsWRxu+RsYE4cUggxkAxd7oRe5e+LeYAi8s6234Kk+gLowmJcgOl
         4t1ADZMtuqlBPBLVV9t+ErWWUqaqBPoJcSPBaVNXqZN0r/5+YtGp3AuNy3VVpqMTThdH
         RGebpWYJx66QzJ1QHjncFvOjdwH/hfKjPWFqoAF7Y5hEFnj0wotqlZWkPBvNvJ0TKn3C
         YcgEXE7U45ngj5RZOhz95GIqAZlBlVC6M8SOyJJXZU2Vx3yXH7Hyd+bikBJ+QYAPZKv7
         Ryz3DxMwyDs0KgSdjIJemxWOquKjEF2PoWC5EoVWU0rl8BDxR6BDBSxvrWAHJv6VZKid
         cSaw==
X-Gm-Message-State: AOJu0YzYBIkVqEmJWttCYkb0BdpJlUT8RzRroh2cIvq8vQNL16xjuFgu
	s7dUHeSPNL+C7T/XX6E+Px0o9HqDBkXC1n3fovG+pJTr5lBqIuqEkKUVPyUNBALjWA4=
X-Gm-Gg: AeBDieuYtAH3EJY5HjVhB61TSmZqUf/EQ3HtL1Ncexbh9Ihme1elrHIKkloqWhur5XV
	sDFNkjywHcM6yUTmCV4RTuHCTqcsxYUPtKlK5KFkCgAORpy/RiNMEq4+cnBjmU08XOewlPp45sZ
	/MkW/y9v8lGvA6RtB1l5WzwsxPfDZm7yCH+hMciS1xZxV05+7YoV0dwl8pV0V/26wywchoLYgDb
	l04hlHtbb31Vi0vb4iHZ/jHafxrFvZObxMXr/GxGGL9S57E88d1+2vPlSyAZhHWsG1HmfMOroPz
	BkABcevoiVL60vYMdSayc6WTYFCFVucfjlZd40Y+cIFbAAFqpJ2kwbGzu8ASFaDMj+aXxpmRiwr
	6cTaZpk0PZt+OXs7Ly5bsFfQmy23/OGOfaw6URRzitapMM2mA1UMK68uxLW4X1yOOECANdq21Bn
	h2+EWbC7Nao6ySnyF8JCqgymdPOnz0CU5oXlfPbXIvv4kY3vfUR5U6Fn/k4MsHDBQQHKGJWAKAt
	Py1+S0p68uc5HQpHX/cdKQDK6VP
X-Received: by 2002:a05:600c:3053:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48a53ea1526mr236261285e9.28.1777276432550;
        Mon, 27 Apr 2026 00:53:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440? ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a682588f8sm162693215e9.10.2026.04.27.00.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 00:53:52 -0700 (PDT)
Message-ID: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
Date: Mon, 27 Apr 2026 09:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20260427
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
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 27 Apr 2026 07:53:55 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2982

Hi Tom,

Here's a short set of Amlogic changes, first fixing MMC init when switched
to Linux 7.0 DT, and adding support for EFI capsule on disk on Libre Computer
boards.

Thanks,
Neil

The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:

   Merge patch series "Linux compat improvements and CCF prep" (2026-04-21 11:21:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20260427

for you to fetch changes up to e07cc9e7fdcc35780f539ee1d452ffd3da0fbd1f:

   configs: libretech-cc_defconfig: enable EFI Capsule on Disk (2026-04-22 18:27:26 +0200)

----------------------------------------------------------------
- enable EFI Capsule on Disk (+ sysreset fixup/cleanup)
- do not fail when setting SD_EMMC_x_CLK0 on GX/G12

----------------------------------------------------------------
Ferass El Hafidi (4):
       arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
       arm: meson: enable SYSRESET_PSCI
       configs: libretech-ac_defconfig: enable EFI Capsule on Disk
       configs: libretech-cc_defconfig: enable EFI Capsule on Disk

Neil Armstrong (1):
       clk: meson: do not fail when setting SD_EMMC_x_CLK0

  arch/arm/mach-meson/Kconfig        | 2 ++
  arch/arm/mach-meson/board-common.c | 6 ++----
  configs/libretech-ac_defconfig     | 1 +
  configs/libretech-cc_defconfig     | 4 ++++
  drivers/clk/meson/g12a.c           | 5 +++++
  drivers/clk/meson/gxbb.c           | 5 +++++
  6 files changed, 19 insertions(+), 4 deletions(-)

