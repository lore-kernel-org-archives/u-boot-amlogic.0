Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D438CDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 14:45:52 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.13817.1697121951846130092
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Oct 2023 07:45:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xILASOdk;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso1041238f8f.1
        for <u-boot-amlogic@groups.io>; Thu, 12 Oct 2023 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697121950; x=1697726750; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQmvVMs1lpKB7yKsOR+g1RA9u6SfgTKAAqZIoZf4Wcw=;
        b=xILASOdktCqE0VbES5BCSg/gL3gzAeMVvhdpiHZ1941/3g2whEB1CgAaSaHlw0L//c
         F+aHsn61BcbJm3cFbpqL7rfYkriphToJF7BITENAG3C+nNX8oGzf1PW4VRrW4HhG17+P
         aq9mEsIFEcvtYzGKxuVBmMlUkhRx2L9gTcZKj48ZPO8pU4ll+M7jFlNWJ0WtyRCXP+6p
         zSATKfwerpllCmN6apT5M3vm+pfaFsQzuCNsc4V2JD3SmY37/3XhdG7JM0pJyccHH4Gh
         2CPR7D+CTz2F6Pw/DgYznSH07dNb1kiHtAoU3iyIbf6SUnjcYH8flcrKAQCDtnh1F9y/
         roNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121950; x=1697726750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQmvVMs1lpKB7yKsOR+g1RA9u6SfgTKAAqZIoZf4Wcw=;
        b=aSYZ2hzz2k0IEVkhkWv75vYYVxwSyr3cmwX2MEWMBGqFTs4enPDzZXaevYJSu3CLpC
         e0GEjFITjWW5nV7wQkw2jauK7qzfzh+kmoM7JJWjdvFOyg2mZueDlGzTED0FFcDrPU8H
         ePSENn2m05+SPF9yEl1pE3C5AFTcm954cUwmNHt754PgZOZTyjYVn/AmZOz0ID+NeKJM
         0c/siTIb839lGk+SBfcIMds5U688H+ve5DgEscjfqt+O+iNUxVQEzHQy28ISEOPr/ZHc
         dd1yZJ5TplT0AhvR+1BEHwXBihz65UMfIumR9N2LnnoT9bYuLhy/r4V50ZpnuBxDkS+E
         dmgA==
X-Gm-Message-State: AOJu0YzFIVVeb/G51vilsj+C0nl4Zb64C+z+PcnJ9Z2XFE8L8EkFkDuO
	YX+VzQNOE1NKnQsAWfmwYtledg==
X-Google-Smtp-Source: AGHT+IFFrAJoMELUKze5PydgjoRb5eegygb5r63fmYXvuvBrYrhOHSdpotJG8YBgWfSuMxQJU5ccLg==
X-Received: by 2002:a5d:484a:0:b0:320:1d1:71c4 with SMTP id n10-20020a5d484a000000b0032001d171c4mr21313209wrs.23.1697121950186;
        Thu, 12 Oct 2023 07:45:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d423:df8b:7f17:7909? ([2a01:e0a:982:cbb0:d423:df8b:7f17:7909])
        by smtp.gmail.com with ESMTPSA id bq6-20020a5d5a06000000b0032d895d24desm4223559wrb.65.2023.10.12.07.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:45:49 -0700 (PDT)
Message-ID: <c6a96994-71f7-4b27-8d95-42f6003512c3@linaro.org>
Date: Thu, 12 Oct 2023 16:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org,
 post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org,
 jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20230921081346.22157-1-avromanov@salutedevices.com>
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
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 12 Oct 2023 14:45:52 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1753

Hi,

On 21/09/2023 10:13, Alexey Romanov wrote:
> Hello!
> 
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> In the future, it is necessary to completely get rid of raw
> smc_call() calls, replacing them with the use of SM_UCLASS
> based drivers.
> 
> V2:
> 
> - Add SM UCLASS
> - Add SM sandbox driver
> - Add test for sandbox driver
> - Meson Secure Monitor driver now based on SM_UCLASS
> - Fix include order in arch/arm/mach-meson/sm.c
> 
> Also, during the discussion in V1 of this patchset, it was
> discussed to create MESON_SM_UCLASS, but I considered such
> a uclass to be too arch-specific. That's why I suggest
> SM_UCLASS, which is not so arch-specific: secure monitor can
> used for whole ARM devices, not only for Amlogic SoC's.
> 
> V3:
> 
> - Fix typos in commit messages
> - Use uclass_first_device_err() instead of uclass_get_device_by_name()
> - Return -ENOSYS instead of -EPROTONOSUPPORT if SM_UCLASS option not
> implemented
> 
> Alexey Romanov (8):
>    drivers: introduce Secure Monitor uclass
>    sandbox: add sandbox sm uclass driver
>    sandbox: dts: add meson secure monitor node
>    sandbox: add tests for UCLASS_SM
>    sandbox: defconfig: enable CONFIG_SM option
>    drivers: introduce Meson Secure Monitor driver
>    arch: meson: sm: set correct order of the includes
>    arch: meson: use secure monitor driver
> 
>   MAINTAINERS                 |   1 +
>   arch/arm/mach-meson/Kconfig |   1 +
>   arch/arm/mach-meson/sm.c    | 116 +++++++++++----------
>   arch/sandbox/dts/test.dts   |   4 +
>   configs/sandbox_defconfig   |   1 +
>   drivers/Kconfig             |   2 +
>   drivers/Makefile            |   1 +
>   drivers/sm/Kconfig          |   9 ++
>   drivers/sm/Makefile         |   5 +
>   drivers/sm/meson-sm.c       | 198 ++++++++++++++++++++++++++++++++++++
>   drivers/sm/sandbox-sm.c     |  76 ++++++++++++++
>   drivers/sm/sm-uclass.c      |  55 ++++++++++
>   include/dm/uclass-id.h      |   1 +
>   include/meson/sm.h          |  19 ++++
>   include/sandbox-sm.h        |  18 ++++
>   include/sm-uclass.h         |  72 +++++++++++++
>   include/sm.h                |  67 ++++++++++++
>   test/dm/Makefile            |   1 +
>   test/dm/sm.c                |  65 ++++++++++++
>   19 files changed, 656 insertions(+), 56 deletions(-)
>   create mode 100644 drivers/sm/Kconfig
>   create mode 100644 drivers/sm/Makefile
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 drivers/sm/sandbox-sm.c
>   create mode 100644 drivers/sm/sm-uclass.c
>   create mode 100644 include/meson/sm.h
>   create mode 100644 include/sandbox-sm.h
>   create mode 100644 include/sm-uclass.h
>   create mode 100644 include/sm.h
>   create mode 100644 test/dm/sm.c
> 

This serie breaks other boards:
+binman: Error 1 running 'mkimage -d ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-u-boot-spl -n px30 -T rksd ./idbloader.img': Error: SPL image is too large (size 0x3000 than 0x2800)
+Error: Bad parameters for image type
+Usage: mkimage [-T type] -l image
+          -l ==> list image header information
+          -T ==> parse image file as 'type'
+          -q ==> quiet
+       mkimage [-x] -A arch -O os -T type -C comp -a addr -e ep -n name -d data_file[:data_file...] image
+          -A ==> set architecture to 'arch'
+          -O ==> set operating system to 'os'
+          -T ==> set image type to 'type'
+          -C ==> set compression type 'comp'
+          -a ==> set load address to 'addr' (hex)
+          -e ==> set entry point to 'ep' (hex)
+          -n ==> set image name to 'name'
+          -R ==> set second image name to 'name'
+          -d ==> use image data from 'datafile'
+          -x ==> set XIP (execute in place)
+          -s ==> create an image with no data
+          -v ==> verbose
+       mkimage [-D dtc_options] [-f fit-image.its|-f auto|-f auto-conf|-F] [-b <dtb> [-b <dtb>]] [-E] [-B size] [-i <ramdisk.cpio.gz>] fit-image
+           <dtb> file is used with -f auto, it may occur multiple times.
+          -D => set all options for device tree compiler
+          -f => input filename for FIT source
+          -i => input filename for ramdisk file
+          -E => place data outside of the FIT structure
+          -B => align size in hex for FIT structure and, with -E, for the external data
+          -b => append the device tree binary to the FIT
+          -t => update the timestamp in the FIT
+Signing / verified boot options: [-k keydir] [-K dtb] [ -c <comment>] [-p addr] [-r] [-N engine]
+          -k => set directory containing private keys
+          -K => write public keys to this .dtb file
+          -g => set key name hint
+          -G => use this signing key (in lieu of -k)
+          -c => add comment in signature node
+          -F => re-sign existing FIT image
+          -p => place external data at a static position
+          -r => mark keys used as 'required' in dtb
+          -N => openssl engine to use for signing
+          -o => algorithm to use for signing
+       mkimage -V ==> print version information and exit
+Use '-T list' to see a list of available image types
+Long options are available; read the man page for details
+make[1]: *** [Makefile:1124: .binman_stamp] Error 1
+make: *** [Makefile:177: sub-make] Error 2

PLease see: https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/jobs/710823#L2912

Neil

