Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6994C46CD3
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 10:43:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.19112.1703069034690417858
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Dec 2023 02:43:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=zUIP3m5L;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d3a2703c9so20645e9.0
        for <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 02:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703069033; x=1703673833; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GRgUN4Cgb6/CN21v+aOuyOjxrnWKjuw+yAeeRTJm/ug=;
        b=zUIP3m5LO4WSELshOpWtj4e+/jhWrTx7gEvtqGoNJEIM/kSg8DPzZ2mEZHWS46KtHZ
         S0E8llrfrrvPEsStTC1WQmUWfm67nBYYpHFuCsLJJ6SI0yFvcFYA5zBlOnfeaTh3R/t9
         +Eweqay8HhezMdjQ/9acU8ba/H6HmxyvRelTCDuLSsvgs1ZnIvw1/vjS/4KMzKs9TTeh
         fiRnT/TCpLc6wip/F3AyH1MXpuQ6LPmsY3Wl9piVIMnmAzXsFRgg+zJt9sbP0DJ1L5Ie
         96BGNtMvySmshejN9tsoMgaDoIWYYS4mpm/JQjFY6AVwh+PFmC/WhunUyOXZS+Mh89/g
         V3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703069033; x=1703673833;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRgUN4Cgb6/CN21v+aOuyOjxrnWKjuw+yAeeRTJm/ug=;
        b=CPDhgWSukZClv45UUNRV6GepwtgxJ8jslfTzYragDEwS/QRwUPp6vHDGH445gZd4yC
         hFe1CqieUkyjQULaq9QiT7+HttbP/HymCRwq7Dq1X4E46w1jL7u6SA7ati622DG+PFz9
         cAr0uRADkiHZLrMeCfCj3g1TdKIhsIPYciVrik6q5Mmv3Vvl++ntDUwl1sOCYVfrpnpx
         zldU/8DqN8Bc6X3pFTHKPzOuLx4cp2wUcqj/dkzCxDxD8f8P0MCPgG8Q9qZkOxKDY6Et
         eCttX0uuaAWfE/6vJ3tBmGgKkkJCnM3hjJgh5YdLdR0yCQ0jDrQZgAmu+XUyVKNBp5Wi
         6JOQ==
X-Gm-Message-State: AOJu0Yy2FISYIDPrfLQ+Td4lhTMcBttE9/k0CA7gJlmgX8XDrxaTvDeH
	ApApioK3RqpygchgvWCGBjd0mRQ2PuhsaH/YPH+gjU7c
X-Google-Smtp-Source: AGHT+IGbHLOYOkN4hp5cIsS3b+Q2Hizmv+3QQmLM6rz+RonUB8kjny3jlBM6W5kjmzN95N0qveWJSg==
X-Received: by 2002:a05:600c:5409:b0:40d:3786:dad1 with SMTP id he9-20020a05600c540900b0040d3786dad1mr293867wmb.19.1703069032967;
        Wed, 20 Dec 2023 02:43:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3? ([2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3])
        by smtp.gmail.com with ESMTPSA id x12-20020a5d650c000000b003366c058509sm1894342wru.23.2023.12.20.02.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 02:43:52 -0800 (PST)
Message-ID: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
Date: Wed, 20 Dec 2023 11:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20231220
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
 <u-boot-amlogic@groups.io>; Wed, 20 Dec 2023 10:43:56 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1946

Hi Tom,

Please pull into next branch support for the new GXL MDIO mux along
with a Linux v6.4 DT sync, this will permit using upstream Linux DT
as-is on GXL & GXM based boards.

Thanks,
Neil

The following changes since commit a6f86132e30a407c7f96461df53c62fbe52e2b54:

   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next (2023-12-18 09:56:58 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20231220

for you to fetch changes up to 4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb:

   ARM: dts: sync Amlogic GX DT to Linux v6.4 (2023-12-19 11:24:38 +0100)

----------------------------------------------------------------
- Add support for new GXL MDIO mux, with driver and Linux DT sync from v6.4

----------------------------------------------------------------
Neil Armstrong (2):
       net: Add Amlogic GXL MDIO Mux driver
       ARM: dts: sync Amlogic GX DT to Linux v6.4

  arch/arm/dts/meson-gx-libretech-pc.dtsi            |   4 +-
  arch/arm/dts/meson-gx.dtsi                         |  21 ++--
  arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  13 +-
  arch/arm/dts/meson-gxbb-odroidc2.dts               |  26 ++--
  arch/arm/dts/meson-gxbb.dtsi                       |  18 ++-
  arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
  .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  12 +-
  arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  16 +--
  arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |   3 +-
  arch/arm/dts/meson-gxl-s905x-p212.dts              |  68 ++++++++++
  arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  21 ++--
  arch/arm/dts/meson-gxl.dtsi                        |  43 ++++---
  arch/arm/dts/meson-gxm-khadas-vim2.dts             |  15 +--
  arch/arm/dts/meson-gxm-wetek-core2.dts             |   2 -
  configs/beelink-gt1-ultimate_defconfig             |   2 +-
  configs/jethub_j80_defconfig                       |   2 +-
  configs/khadas-vim2_defconfig                      |   2 +-
  configs/khadas-vim_defconfig                       |   2 +-
  configs/libretech-ac_defconfig                     |   2 +-
  configs/libretech-cc_defconfig                     |   2 +-
  configs/libretech-cc_v2_defconfig                  |   2 +-
  configs/libretech-s905d-pc_defconfig               |   2 +-
  configs/libretech-s912-pc_defconfig                |   2 +-
  configs/p212_defconfig                             |   2 +-
  configs/wetek-core2_defconfig                      |   2 +-
  drivers/net/Kconfig                                |   7 ++
  drivers/net/Makefile                               |   1 +
  drivers/net/mdio_mux_meson_gxl.c                   | 138 +++++++++++++++++++++
  28 files changed, 342 insertions(+), 90 deletions(-)
  create mode 100644 drivers/net/mdio_mux_meson_gxl.c

