Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E8CD8CA8
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:49:50 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.148005.1781588985926107265
 for <u-boot-amlogic@groups.io>;
 Mon, 15 Jun 2026 22:49:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FF2ju+Zn;
 spf=pass (domain: linaro.org, ip: 209.85.128.48, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso26557245e9.2
        for <u-boot-amlogic@groups.io>; Mon, 15 Jun 2026 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781588984; x=1782193784; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fxd+K80st5FXZDug+dKjoKLIRU7KqnF8MuF5j4ZaA0=;
        b=FF2ju+ZnQPEJi7CMCtq3x3WTXBuf7e/W0w7mzr8wdxnYUK4Y3MT2cZFiaT+89eFo64
         DDf9OsgwqMEKnIePFeOFG+fxRQETodOj5Ji2KIoismQy0yXbz9JUBBClHIUf/Tkj9FyG
         mawxZmFsNE8OrHf8qO5tpbCzpYoWPBrayAMtW/XiIR/QLbei1dw7fXRY7iDaFp4DBCDg
         MeoVLuMSHEgIvhGcERYov7dDhVURxBtwmjZJvlGHXJs1II27n4gy6DfQH9DZT/SgWT1r
         hbFBKpdXec2LXXup976hlflKFNknWGyk/1jlyPVm4YMYfP1gLkeKKrRomGe46uU6yJTD
         cYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781588984; x=1782193784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fxd+K80st5FXZDug+dKjoKLIRU7KqnF8MuF5j4ZaA0=;
        b=TynsKmo2IqR6HIeUYcYF7ln63+9yYaWg2+picjUDJJ73H1JqFdJ+pPoZsjzwT0UAux
         oIMPhDR1hHTDUr1b3L2SH4eIG6rd33khdRlr5zJ1D8epL5jXBoPRqJdJ0TCpYKbj6dyj
         eHhNgBB2Ks2Q28DVCrAJfK4VGoZb5BGrYAnZbBYCt31if9QZ3MnBGsxcJC1de27rCOA2
         jM/L+lCAHxJ8Tq+vs7O6pQq44rFIxQiHHXVUSSGwzjl5H6A0IgSp9Nghk6tTqYW5RHMH
         aRyrjw0ij+M5/4QBkD9pxyCldwr7aCZBFjqR2EglKbZrtBDg4U0yPlMdzjrmqPJgYNok
         NU/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/MoReaej8stsvCLM9erNF6eXW82w2yUmEhyqk88aD3ec2D6zZAZ1s+g2/b+d1T7PkyV279ldAz/vFvbLYHNA==@groups.io
X-Gm-Message-State: AOJu0YwquInloFMJoLKqKxT94TvbCPWLq0F3QuPakKWt4jswW+BQniPb
	OtzPHQ6ZI7FD5/3Ud65Vvrslv7j5oxHYwux8qcK4mhzvWXfqr33D2tYN7mE9ul+HT1VtNWqo2al
	IG/Mi4sE=
X-Gm-Gg: Acq92OEEVaoo8KB/Qedx0YCD7QDY6g40lXqWocSwm1OUzm0hn1tmBZGhHFgFK/p/8iy
	n6Pm7RQipYT6mjMoTzvr8m3jYJ85CZe9ZYSdFycOW992jlFJq05wanj5GGJqzmaQnzyLZsh06IB
	ofkUJc2fEBQjP0gW7AaZtsgH4j9H9XZ8tgl2XTw0VCyBHwVV2G6ZAQL3IA1NLrm3a6CO9ZG1dLS
	CO6xEFbrII0bd0NSftu1Rlsg3Gc0EZppJX0qEzO+D/Mx+YNQzgACCfoz/F9lwuEDLYgwPaQAhQP
	Guv02b6vbKsMbOi+ng/kpZTjrTOWkLRWirnB9grsaGtOru1jGJmfdJ9LC+czLJobf8avmQKQWs+
	xNWtD2ZoTKIm8KTNr0IFLJThazPdlcUU6Vz3asu6dODmKrTyaEcJZiGT8c8kJGgAcmA5jWBeydu
	gY39J2e8tewz/q6MHNIn/fKvZM6uRNprw8
X-Received: by 2002:a05:600c:474a:b0:490:b475:af32 with SMTP id 5b1f17b1804b1-4922ffb63ffmr26055335e9.23.1781588984098;
        Mon, 15 Jun 2026 22:49:44 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.84.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4b2e8esm251364845e9.0.2026.06.15.22.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 22:49:43 -0700 (PDT)
Message-ID: <465e4752-2c8b-4acc-9ef6-a3c365fcbcd4@linaro.org>
Date: Tue, 16 Jun 2026 07:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] doc: boards: amlogic: update documentation for Beelink
 GT1 Ultimate
To: Karl Chan <exxxxkc@getgoogleoff.me>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
References: <20260611192814.5353-1-exxxxkc@getgoogleoff.me>
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
In-Reply-To: <20260611192814.5353-1-exxxxkc@getgoogleoff.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Jun 2026 05:49:50 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3008

On 6/11/26 21:28, Karl Chan wrote:
> fix formatting

What did you fix and why ?

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


