Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD569E7719D
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 13:50:49 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.18930.1736517044845998414
 for <u-boot-amlogic@groups.io>;
 Fri, 10 Jan 2025 05:50:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=up0LAoHy;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso1646849f8f.0
        for <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736517043; x=1737121843; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19dZ0vvC9UHMg3CGyyhDaeLs4xds3eo7VpvKyDa6RiM=;
        b=up0LAoHyPGRw6d8Bevf1td6KJYo/AjR65iMMVMVXQHO0Fmgc8zwdn7SKAv67rmo4ea
         GZoUKSclkK7ysqtYF2LbrFYL1LB6ZlOAIsiN2lJhL/5mriizdpaM/aj1lLY7oFUnshQt
         tW9ccYg+sfQV240eyp+BlKk/6WiCtFgYnqYx8gkaBjKNQ/Zxm/tUwB0BNFjyW7UgaDBT
         70GMP0Ltx/p1X+O+kkqr3r5rvSHiD0f7haYRuTzxeevK0N/BO0Ntag72SsGvoB4zHM16
         rQiCSWrlZU/jDcIHfETKLsukNDwQ1HNbS7sp8YwgAKXhC/Cu70GmppX5TRl2U/9SuymU
         FYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517043; x=1737121843;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19dZ0vvC9UHMg3CGyyhDaeLs4xds3eo7VpvKyDa6RiM=;
        b=PqupH8ABCa6xTucNZVcFmtsJL3x/DakNeb8nOt2WZs/zvmAjBS8SOA9FioQuj8cBW1
         l5Ks89OJQ3M6G9AmqOb4E6OPhkgtWO/3H+Mxa7DaUKoF3mKlIgsrGtcdRd7ySX9PyTi6
         Y2zMESnqQSBD7O0uI53pUzCxI3sJ/YRkwVIhPuIIIa+dzYNnG8zO90aexxmEqEjOpCmU
         NOU9bCjd3LBdvoMvZ4LkXb1RNZTj1g/6O1BMSkbaFGMJ9m38uSUeyJmfGjQPj9KYFyMY
         T+oU9IM0ZPLmVe2GdXDeW3WCQ8IkHZwbkmi+rWjqt64fl0gUTEQ/YuD1f9kSR0k28Oao
         U7/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Dw86i+XJgbdo1iTk1v36/hLXFn43s4T2R8FW5O2ZxGe9gJppS4acUb605q4Ob+gtSTuFCOF71lqD0SQu9g==@groups.io
X-Gm-Message-State: AOJu0YxsQ85XM7Eoh37mknUyByieiiJ18gTmmAU1JlNzD/duZPAqNpEj
	A3e92iK5BjrXTDF4W5oTdR9BffgxVcexxoKBVy1RGORcJO4wxb18aLd+zaxqWX2DV4aWHbkOdyW
	d
X-Gm-Gg: ASbGncsrIkKntWLMp6MBUycMURod7E19HB0YOvOiUcIBZuJHFZo2q1NjaNJAl2nEVkU
	C6qkAZWw0haPc0fQ/jDUyDwhD7c0ejiKWN2Dr0/1Yt15lJG5kxPf1qdl0pgBn5Bl5QVSvPnWwor
	njl9/MeKayjYL2khgNTW6I2CJH40+MSLARhu5XXleLANNGP6rZyglDa0njTGweY984OadjdA/pu
	i1apR37wAMQpqHh+iKEc+o5RDnwNxc3Lc19Tw1H82vMZmmhALSDcDs/tJ871zAftorhHh3kpaOj
	SF+JuWXFc6aa2Xpw1raXeufQnEssee4wsw==
X-Google-Smtp-Source: AGHT+IF1/kW2WEsbM9xyHRkyN9eWb0jwtARBK0ITq8iZ9fN0Cci8gwFM+mm7fkjEiOVL2CAgEQASHw==
X-Received: by 2002:a05:6000:186e:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a87338d84mr11847897f8f.39.1736517043289;
        Fri, 10 Jan 2025 05:50:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8? ([2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38ef6asm4708475f8f.60.2025.01.10.05.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 05:50:42 -0800 (PST)
Message-ID: <095fd831-8ce3-4edd-a722-c0fde2f50932@linaro.org>
Date: Fri, 10 Jan 2025 14:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] board: odroid-n2: Update docs for signing
To: =?UTF-8?Q?Baltaz=C3=A1r_Radics?= <baltazar.radics@gmail.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20250110111335.9221-1-baltazar.radics@gmail.com>
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
In-Reply-To: <20250110111335.9221-1-baltazar.radics@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 10 Jan 2025 13:50:49 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2612

On 10/01/2025 12:11, Baltazár Radics wrote:
> The previous instructions resulted in a bootloader that wouldn't fit in
> an MBR gap. I have updated the docs based on upstream's build process.
> 
> Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
> ---
> 
>   doc/board/amlogic/odroid-n2.rst | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
> index 883720f8fb..5222a21c80 100644
> --- a/doc/board/amlogic/odroid-n2.rst
> +++ b/doc/board/amlogic/odroid-n2.rst
> @@ -54,10 +54,9 @@ image so it is necessary to obtain binaries from sources published by the board
>       $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
>       $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>   
> -    $ DIR=odroid-n2
> -    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 $DIR
> +    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 odroidg12
>   
> -    $ cd odroid-n2
> +    $ cd odroidg12
>       $ make odroidn2_defconfig
>       $ make
>       $ export UBOOTDIR=$PWD
> @@ -74,12 +73,8 @@ Go back to the mainline U-Boot source tree then:
>       $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
>       $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
>       $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
> -    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
>       $ cp u-boot.bin fip/bl33.bin
> @@ -113,7 +108,7 @@ Go back to the mainline U-Boot source tree then:
>                                             --level v3 --type bl31
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
>                                             --output fip/bl33.bin.enc \
> -                                          --level v3 --type bl33 --compress lz4
> +                                          --level v3 --type bl33
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
>                                             --output fip/bl2.n.bin.sig
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
> @@ -124,11 +119,7 @@ Go back to the mainline U-Boot source tree then:
>                                             --bl33 fip/bl33.bin.enc \
>                                             --ddrfw1 fip/ddr4_1d.fw \
>                                             --ddrfw2 fip/ddr4_2d.fw \
> -                                          --ddrfw3 fip/ddr3_1d.fw \
>                                             --ddrfw4 fip/piei.fw \
> -                                          --ddrfw5 fip/lpddr4_1d.fw \
> -                                          --ddrfw6 fip/lpddr4_2d.fw \
> -                                          --ddrfw7 fip/diag_lpddr4.fw \
>                                             --ddrfw8 fip/aml_ddr.fw \
>                                             --level v3
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

