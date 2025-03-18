Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5888C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 16:06:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.498.1742313981392162961
 for <u-boot-amlogic@groups.io>;
 Tue, 18 Mar 2025 09:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=orR2984E;
 spf=pass (domain: linaro.org, ip: 209.85.128.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso27370355e9.2
        for <u-boot-amlogic@groups.io>; Tue, 18 Mar 2025 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742313980; x=1742918780; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWaWpeZxNvP7SpV0ZNApUVcLRnavCoScAR0tW6hGmiE=;
        b=orR2984EGmBjb6iar/ZfNdu/I2pUtAve2CVcjSu4kIVx1Q/AYs3I8aQnf/bcMiPhvd
         aQgPf9WBITVnUTGw1nP2+k6ajBzyjmQx4nfVI/iWZFb3mkOIEtUILDK26hdCWTbRVT7v
         ORkiBpGPTwNNgRFsb2Q1z5zAzIFR/tRWIdJOn6hTjwOmDyidI6s9IuyFKjtOE2lssNp3
         5/TUrgDJOC3rj8neLWnkcx95MeXiH1jkrgLj0Tl4E8d4x5AlEXcdJ+LFagMMa10NZ7Vg
         2+PVOmSDvUjmIXhpge0MJ/4yVvo8+o+H6pAG3usRUxOXdv/yZiy0ZMBPJlcL2IFEDzqI
         8GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313980; x=1742918780;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWaWpeZxNvP7SpV0ZNApUVcLRnavCoScAR0tW6hGmiE=;
        b=twU4BKsmniyovKpK1VVJ4FORDdawd9kjGf3warNZEj45qQjxY6nF62+uW0WNhRau/E
         qaY4q50Zedun6Cp+exs1HHSBfxNJmDVwJ++ioxTz3LYrgAH2W3N7PEd3ThQ7sIltts/7
         YfocBNn91FeVSdmzSv/g9TA3d9TxWwevHTRAam1LduNSLHC+K8Si8+pzthLW2csTNeGW
         ZRY2lnUYDXCqZq5z7RNd+EJ7C30mVyoYZ1oC38dw4Ycs1197FgBsunuHjHKVHUhw5R+f
         a73e8gREIFczb1SIGwDoNcQeJfq9Fg+P4RtFO/YmtgsJiW0YYPbZCVF/94X7IZMjqOxr
         4cfg==
X-Gm-Message-State: AOJu0YwG6pu4KtD2XqUBjKa8CiUSkKtZgFTV8UCZ/7+d/txGsbO2kniP
	pu8hUAJGZTwaXt02CqNbGJ6zrESeu3M1c2FYuOjjV5wfriUYFECl4PbfGyHtHhKB9IOGu11niOi
	Q
X-Gm-Gg: ASbGncveqMLdz7l50dFFf8O/ZCVi+ks/wIrAUR2O8OS/tZT7akYZyV7PKy02fkP779h
	Y9E8hSeX9E65I80IV1L+CLx8yzOxPJTVoUBIK9u9WcEjgK+7H0j0zQ7nrW13SNXUKqjVGCwa4+X
	Rz+d/44KqzpUlSDTbjImOCMRAnQTtgqiN32owuxSRG119AEBcgMK+wom5mUhBmAW+N/yBOvFbvY
	C58z/Tf4d4NYEZR9Fl+Qb72Z1yr4fSI2x5bVeRPOS4dJ7j2QhX3auPHgtRpzvLpkoFiUkWiaXKx
	5PmBReWxxt+FYzmAMP6tn6UZovdeZCWxlJtphMi2ZYyjpHzvaVRGPIpIo8Ag8iPOUp1FB+BPemn
	qTZ/nWrrQTJ6XM7rWbqrwzQ==
X-Google-Smtp-Source: AGHT+IEj4YZposyR3KNZaAB0g3jjgnXTLdusIpOcmC0illv8PLBDcW8sId2LzoAZV1GThGM7RYMccw==
X-Received: by 2002:a5d:588e:0:b0:390:fb37:1ca with SMTP id ffacd0b85a97d-3972121b9a5mr17946264f8f.53.1742313979764;
        Tue, 18 Mar 2025 09:06:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff? ([2a01:e0a:3d9:2080:eac1:f2d4:84a8:c5ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm138366635e9.26.2025.03.18.09.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 09:06:19 -0700 (PDT)
Message-ID: <76380583-858e-4d69-a412-25ddef988705@linaro.org>
Date: Tue, 18 Mar 2025 17:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20250318 into next
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
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 18 Mar 2025 16:06:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2632

Hi Tom,

Here's a small set of changes for Amlogic SoC support.

Thanks,
Neil

The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:

   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20250318

for you to fetch changes up to e80b586cfc73ee123dae42d5d85543798ff7a3c5:

   board: odroid-n2: Update docs for signing (2025-03-18 15:27:25 +0100)

----------------------------------------------------------------
- odroid-n2: Update docs for signing
- support Amlogic chip_id v1 and v2

----------------------------------------------------------------
Baltazár Radics (1):
       board: odroid-n2: Update docs for signing

Evgeny Bachinin (3):
       arm: meson: unify type being used for socinfo
       arm: meson: sm: get rid of SM_CHIP_ID_SIZE
       arch: arm: meson: support Amlogic chip_id v1 and v2

  arch/arm/include/asm/arch-meson/boot.h |  14 ++++
  arch/arm/include/asm/arch-meson/sm.h   |  48 ++++++++++++-
  arch/arm/mach-meson/board-info.c       |  13 ++--
  arch/arm/mach-meson/sm.c               | 120 ++++++++++++++++++++++++++++++---
  doc/board/amlogic/odroid-n2.rst        |  15 +----
  5 files changed, 182 insertions(+), 28 deletions(-)

