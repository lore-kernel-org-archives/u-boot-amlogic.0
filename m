Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D939ECD3420
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 16:26:32 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.3014.1725294383208874210
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Sep 2024 09:26:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Zfs3qi6r;
 spf=pass (domain: linaro.org, ip: 209.85.221.47, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c7d14191so770516f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 02 Sep 2024 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725294381; x=1725899181; darn=groups.io;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0IRX6WpW/9MmbP4RjtAoTzg2pR3yhtmDYoE75t5k3c=;
        b=Zfs3qi6rVkM9sCDz93gOEYJrpB9lWzLaoPEnYGqzls9Ky60xsin7syW5ZdrghUqVde
         Q3gnXDXrUmdXEz9v0GmIh6RFxbczk2ByZdIIktFhQwYNd5nZMNbq8/FYcbFaaqtEZeu9
         Bw8QhuKIfSOb1NUyyLjne1/Ff2K27Mu3Gk7H9bdaHV08nCMxtB0fYj59ICNZxSnDQbyo
         FVn7u3OBhuXkcWiCqayS7bS+/luZkjhGgEbRZPVEnZClqfzUakBUnFHfUo2/MB1j07sS
         olKh5wYNpGYwV+ENEqjeSIW8zrTxrXOprDd21FbuOHS7NFCQ2YWCJ92SBLjDKAWEAWF1
         n/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294381; x=1725899181;
        h=content-transfer-encoding:organization:autocrypt:content-language
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0IRX6WpW/9MmbP4RjtAoTzg2pR3yhtmDYoE75t5k3c=;
        b=R9Bow+UEPb2qQM5Z5/Djq6hWPkV5EvBcMCiMZABfCRwsmLkfEX3PLGPsq9ouIs8cBG
         nq2eNFmWVuTZX3umtTA+HKec0rAz64uQM04Aq0X0Dgq9GV8IeOPtGmI/33JXUFoUflT8
         cxxrMkb8GUzj8wyHli73A3StnRDmTqAdMH5thQb2ZQ05hsw+ISCoFm1CCd24RiOyJT6C
         K8AFbrMiX+zM493xjWrr81EYhVwGqrbOa3CpuB0wci6EUIYgwTL9bzHwf//25MwJwRWA
         Jsuk7aCpkqe4m4ZXx1gBy+J8Uqba8c3ezINzk9IWBpwFZsSZIsXDSVOVSLtklJ87v7we
         aP3Q==
X-Gm-Message-State: AOJu0Yy94+FRH4WC12SNPltEhxF1bFAcgMPlIhpjq/b3aZecww4oqDN9
	41cxv3y90oVe/u0WbD8/PgqkQWvMlcHAOdji/ngvbCumu0we8xWIQ46j7XIQU9E0S+gPmWngtrP
	M
X-Google-Smtp-Source: AGHT+IEkQ86FRaqwu3nwXwwIeuSM10p8VSHHU3bEodYOQhl1hwK0nUiYLrTGt/Tm3krPQg1BhW0fRQ==
X-Received: by 2002:a5d:47cb:0:b0:363:ac4d:c44f with SMTP id ffacd0b85a97d-374a91a4118mr7694892f8f.17.1725294380976;
        Mon, 02 Sep 2024 09:26:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa? ([2a01:e0a:982:cbb0:7dba:3cd0:a1f4:e3fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bfbfc7b7sm6898110f8f.88.2024.09.02.09.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:26:20 -0700 (PDT)
Message-ID: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
Date: Mon, 2 Sep 2024 18:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20240902
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
 <u-boot-amlogic@groups.io>; Mon, 02 Sep 2024 16:26:32 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2383

Hi Tom,

A simple set of changes to allow using the bootrom NAND pages, ported from Linux.

Thanks,
Neil

The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb4074:

   Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-08-24 14:03:28 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20240902

for you to fetch changes up to 35ff967a99e97b523732096628bdbc78758922f6:

   mtd: rawnand: meson: read/write access for boot ROM pages (2024-08-28 16:05:45 +0200)

----------------------------------------------------------------
- meson_nand: R/W support for pages used by boot ROM

----------------------------------------------------------------
Arseniy Krasnov (3):
       mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
       mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
       mtd: rawnand: meson: read/write access for boot ROM pages

  drivers/mtd/nand/raw/meson_nand.c | 84 ++++++++++++++++++++++++++-------------
  drivers/mtd/nand/raw/nand_base.c  |  3 ++
  include/linux/mtd/rawnand.h       |  5 +++
  3 files changed, 65 insertions(+), 27 deletions(-)

