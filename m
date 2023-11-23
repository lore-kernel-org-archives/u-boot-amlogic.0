Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FEAC61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:54:17 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.91387.1700747657120822869
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Nov 2023 05:54:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=gRXfuVbK;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-332d2948170so573305f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 05:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700747655; x=1701352455; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJpr3+fyAGRTUefeZpsurulP9PoXpduP7/N5jSc43zU=;
        b=gRXfuVbK1xB4l0TB+uzK5GppCO9lVXdY5ZpeADY5ZSVOq+vi1EGVKYlPmDkk2mElXd
         GRMqCF5x7SdFsgF6l9EYGob0Jnh7+WlRmLCIG2dMqiLmTwrVz/L/+lDWu8UrHDurYfyT
         QMTP8EpENjyiBCDR0TjC+E8sdgeNjqL2Sj/3ZU+6uNlMSBvEcWyCOFXc2YnmUUKIsvVX
         AR+lsy/7eDpU/Wb85QQq0hT0mSOIpAgvajZKbVChva2DAv4ZnwURF5Kmt8SBhf9d5VCA
         Rz1WdTTF0h/3eyki2ViObJIWi8Oh4FgNqGEYY1jeBVL/duJ2zay/MuyTgjM0TgXM362N
         p4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747655; x=1701352455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJpr3+fyAGRTUefeZpsurulP9PoXpduP7/N5jSc43zU=;
        b=tM4Wa+MWDOVEJD6WxEQ5k5NdjxJhZQ16tLE8W8NBIlNPHqsvLv/BCRyDb8YGiYNjTQ
         OGFFKpdOzBMhTHdKOd1tBwMDDQjIWzktpvJS1T46MmekHnuhX/iARd8h2mYr/syfp1TW
         FLYT+TnqOZgddPdkzuP5uTpxqHyvRCNB6X+1E1MigdvSraAnSeYaDd6sOaRTSMOAz+0r
         g469O1NX0+I4KrpQiiSgzQQeTXRXzNwr3ZrlmwDIi0jGTqX7LAoiyZAHbMsQl13MlXlq
         USyVirePUsf5Xxj7eY1LSaS57Zqi59QE6kJG4i7hDSsfXgwhHRgd8DrpcLs3bC/7e+KI
         V8DA==
X-Gm-Message-State: AOJu0Yx4Rz3QVlbFpVQ6GmOI6Um9maL69X6xbpCuRLvzOFYGOjJGJe0i
	uFaeNqDB39uYgZMuEcSVWIQPbQ==
X-Google-Smtp-Source: AGHT+IFedjVasmmSr3GdW7tD49jLTlTMZYYam6Gdk+Zgj/3yTerdS4q/XnFyjLpQ54WBaDuvOk5LVQ==
X-Received: by 2002:a5d:5f8e:0:b0:32f:7734:a0fa with SMTP id dr14-20020a5d5f8e000000b0032f7734a0famr4997414wrb.2.1700747655531;
        Thu, 23 Nov 2023 05:54:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba? ([2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba])
        by smtp.gmail.com with ESMTPSA id v10-20020adff68a000000b003316db2d48dsm1700397wrp.34.2023.11.23.05.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:54:15 -0800 (PST)
Message-ID: <c7704004-3ce5-44da-8010-99157eb7b0a1@linaro.org>
Date: Thu, 23 Nov 2023 14:54:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Content-Language: en-US, fr
To: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20230915160130.352099-1-jbrunet@baylibre.com>
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
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:54:17 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1889

On 15/09/2023 18:01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 

I got a regression with this patchset on the BPI M5 (SM1) SDCard, u-boot pytest results:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5603936884
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5603936884/artifacts/test-log.html
Same device but without the patch:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5601899556
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5601899556/artifacts/test-log.html
Same branch but on A311D gives expected results:
- https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/jobs/5603932746
- full HTML log: https://amlogic-foss.gitlab.io/-/amlogic-u-boot-autotest/-/jobs/5603932746/artifacts/test-log.html


eMMC devices gets 26MHz speed instead of 52MHz, and SD reads and writes gives random errors:

=> mmc info
Device: mmc@ffe07000
Manufacturer ID: 15
OEM: 0
Name: AJTD4R
Bus Speed: 26000000
Mode: MMC High Speed (26MHz)
Rd Block Len: 512
MMC version 5.1
High Capacity: Yes
Capacity: 4 MiB
Bus Width: 8-bit
Erase Group Size: 512 KiB
HC WP Group Size: 8 MiB
User Capacity: 14.6 GiB WRREL
Boot Capacity: 4 MiB ENH
RPMB Capacity: 4 MiB ENH
Boot area 0 is not write protected
Boot area 1 is not write protected

=> mmc dev 0
  ** fs_devread read error - block
switch to partitions #0, OK
mmc0 is current device
=> mmc read 0x00200000 0 1000
MMC read: dev # 0, block # 0, count 4096 ... 0 blocks read: ERROR
=> mmc write 0x00200000 200000 3e8
MMC write: dev # 0, block # 2097152, count 1000 ... 0 blocks written: ERROR


I ran the test twice to be sure.

Neil

