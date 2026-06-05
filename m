Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE2ACD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 08:05:11 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3522.1780646708847213812
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Jun 2026 01:05:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Zbl/g2lw;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so10406035e9.0
        for <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 01:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780646707; x=1781251507; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JR2bitoz0QCc1Yap2SKEioLTtT6EY9vPpNJiIckdNts=;
        b=Zbl/g2lw/SfE5Ulm6SWJ06G9oLo9g2giaKCkxM/jR2PcSWOU2PlktKQ7nbIvn11/Je
         10qOvtpVNhi5c+KlKZq3psbo6+JeSW1bMrl0TegFP59TnYNtgW0heJlakowrZC0nH2fJ
         peppPbDQ9GAZu4AyIoVichwV7V9bKLLVJxQiuCel0BgNIpmKx54fe9DJU/Dx5HvSwa/o
         LW9X8AqPyayT7VnkJk3hdYN81xUQVujguWZlcibJILLruNWap1snUV6pT5nhF4+EWi35
         U20oc4lGg8KmpAtHio8a1maKYlDktOXTepD0/HzK1LZ5F6OIeC0p/20lV1CD8uxGftgl
         PWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780646707; x=1781251507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:from:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR2bitoz0QCc1Yap2SKEioLTtT6EY9vPpNJiIckdNts=;
        b=FJk6VdZvA/aC5wrWmJyNCrgVmU8EM4MARiodPgPDFVVybWbZE72kR/pjsyZcrSyUFE
         EPFV8raRIh4ftOlKruKRcOia/8XX2ToHF9rWSphjTrV4YPIx/9G3QGi0P0r3j+z+3Pyr
         UIiI35b5blviZgOgR9HilW0txGSeY5YAU/x1sGdhojMX3/CfzC4444gtbTw2OOOSE8/k
         9ZhYtzDaR5tZRCFIEc8u0zNl12+sMFvb1hgyMVfAmS3kA/swjqoEn8Dncu7d0vQVxdj+
         YaM3Zf0gIOzEk3zyf6NZYImho4LN1ajmjaVyhxoBL/gHLSklRYbpfFN24LpVvc49WszF
         5acw==
X-Gm-Message-State: AOJu0YwRHcJOvPvYzGcCHCVFXgiy6xSujsmVWT3JT9V+6zheV6m3wN4s
	ODxgrO69LLwcJ6MSV+gvj1GbM2WRbzN/idvKT+cFXDIczxBin+c0DktTuM0Mt+jt5GI=
X-Gm-Gg: Acq92OH4wMOkS5qxoCtZI+6WEWDyU3UHkI30bMH5y8uNnWK83opKfsow1ejeKIabIye
	S8XApCetwLPhNvThGxJgn8/tBGwDkhE1WOKETo7ztrjwPS62yIekVBX8XBtNdg3P1Bl6UxOF4oc
	1PYoWvYL+TuZxAipoEEnbK2STTi6pa36nMtUwlCdl+wQHoDqX8Tw0imjmyr4sx8HLZ2eDUKV/Bq
	hMWTeCgd79WuaOwo+Ic0yvVsAYvObwn41qKgan7mySXKFCwltKRzX6XorjKpfH2raQa7p5cs3dK
	M2uY/LYyfqIAVMDTXkOXJ0FzMa6XUEIe7NyVbFp001XMjso3iWbQF2tJQzKDp+38aZznY2rMlVR
	t3rwHrpSXtD58Xu5VerA9cPhTXNmbwVtiEv4Fb8LzwHtOj8bX/0UZaXh5qXLGVPcvPVZttoi6zk
	mLVrkGvz5qePm0Cw7qwiUEQ+RkcHFlkLhX1chhNqYI3zKkqiSF37cb4vEBKaoxvkDCZvN3nrpBI
	1xIwfrC4lXNj3aGlA==
X-Received: by 2002:a05:600c:37c9:b0:490:a296:fdad with SMTP id 5b1f17b1804b1-490c2600e5amr33841165e9.24.1780646706887;
        Fri, 05 Jun 2026 01:05:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668? ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm18345458f8f.14.2026.06.05.01.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:05:06 -0700 (PDT)
Message-ID: <a79659e0-d2be-48bc-8a82-8b74847490b7@linaro.org>
Date: Fri, 5 Jun 2026 10:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] doc: boards: amlogic: update documentation for Beelink
 GT1 Ultimate
To: Karl Chan <exxxxkc@getgoogleoff.me>, u-boot@lists.denx.de
References: <20260605075617.6690-1-exxxxkc@getgoogleoff.me>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Cc: "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>
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
In-Reply-To: <20260605075617.6690-1-exxxxkc@getgoogleoff.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 05 Jun 2026 08:05:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3002

Hi,

On 6/5/26 09:56, Karl Chan wrote:
> fix formating

Missing u-boot-amlogic@groups.io and myself in recipient, and please make a little more effort in the commit message...

Thanks,
Neil

> 
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
> ---
>   doc/board/amlogic/beelink-gt1-ultimate.rst | 104 ++++++++++-----------
>   1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlogic/beelink-gt1-ultimate.rst
> index a78a1a2ff25..22afae0ed40 100644
> --- a/doc/board/amlogic/beelink-gt1-ultimate.rst
> +++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
> @@ -30,19 +30,19 @@ U-Boot Compilation
>   
>   .. code-block:: bash
>   
> -    $ export CROSS_COMPILE=aarch64-none-elf-
> -    $ make beelink-gt1-ultimate_defconfig
> -    $ make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make beelink-gt1-ultimate_defconfig
> +    $ make
>   
>   U-Boot Signing with Pre-Built FIP repo
>   --------------------------------------
>   
>   .. code-block:: bash
>   
> -    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> -    $ cd amlogic-boot-fip
> -    $ mkdir my-output-dir
> -    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
>   
>   U-Boot Manual Signing
>   ---------------------
> @@ -53,58 +53,58 @@ for signing. However you can download them from the amlogic-fip-repo.
>   
>   .. code-block:: bash
>   
> -    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> -    $ cd amlogic-boot-fip/beelink-gt1
> -    $ export FIPDIR=$PWD
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip/beelink-gt1
> +    $ export FIPDIR=$PWD
>   
>   Go back to the mainline U-Boot source tree then:
>   
>   .. code-block:: bash
>   
> -    $ mkdir fip
> -    $ cp $FIPDIR/bl2.bin fip/
> -    $ cp $FIPDIR/acs.bin fip/
> -    $ cp $FIPDIR/bl21.bin fip/
> -    $ cp $FIPDIR/bl30.bin fip/
> -    $ cp $FIPDIR/bl301.bin fip/
> -    $ cp $FIPDIR/bl31.img fip/
> -    $ cp u-boot.bin fip/bl33.bin
> -
> -    $ $FIPDIR/blx_fix.sh \
> -              fip/bl30.bin \
> -              fip/zero_tmp \
> -              fip/bl30_zero.bin \
> -              fip/bl301.bin \
> -              fip/bl301_zero.bin \
> -              fip/bl30_new.bin \
> -              bl30
> -
> -    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> -    $ $FIPDIR/blx_fix.sh \
> -              fip/bl2_acs.bin \
> -              fip/zero_tmp \
> -              fip/bl2_zero.bin \
> -              fip/bl21.bin \
> -              fip/bl21_zero.bin \
> -              fip/bl2_new.bin \
> -              bl2
> -
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> -    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> -    $ $FIPDIR/aml_encrypt_gxl --bootmk \
> -                              --output fip/u-boot.bin \
> -                              --bl2 fip/bl2.n.bin.sig \
> -                              --bl30 fip/bl30_new.bin.enc \
> -                              --bl31 fip/bl31.img.enc \
> -                              --bl33 fip/bl33.bin.enc
> +    $ mkdir fip
> +    $ cp $FIPDIR/bl2.bin fip/
> +    $ cp $FIPDIR/acs.bin fip/
> +    $ cp $FIPDIR/bl21.bin fip/
> +    $ cp $FIPDIR/bl30.bin fip/
> +    $ cp $FIPDIR/bl301.bin fip/
> +    $ cp $FIPDIR/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl30.bin \
> +              fip/zero_tmp \
> +              fip/bl30_zero.bin \
> +              fip/bl301.bin \
> +              fip/bl301_zero.bin \
> +              fip/bl30_new.bin \
> +              bl30
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl2_acs.bin \
> +              fip/zero_tmp \
> +              fip/bl2_zero.bin \
> +              fip/bl21.bin \
> +              fip/bl21_zero.bin \
> +              fip/bl2_new.bin \
> +              bl2
> +
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/aml_encrypt_gxl --bootmk \
> +                              --output fip/u-boot.bin \
> +                              --bl2 fip/bl2.n.bin.sig \
> +                              --bl30 fip/bl30_new.bin.enc \
> +                              --bl31 fip/bl31.img.enc \
> +                              --bl33 fip/bl33.bin.enc
>   
>   Then write U-Boot to SD or eMMC with:
>   
>   .. code-block:: bash
>   
> -    $ DEV=/dev/boot_device
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440


