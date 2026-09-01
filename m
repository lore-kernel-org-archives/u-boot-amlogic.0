Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D26C624D3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 16:36:00 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.696.1788280556057234564
 for <u-boot-amlogic@groups.io>;
 Tue, 01 Sep 2026 09:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ca3qwXNj;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so65500f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 01 Sep 2026 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788280554; x=1788885354; darn=groups.io;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvyNiMWS4QyDaAZzf0SqqbYnm0Hecypi/7pNVDxGqfE=;
        b=ca3qwXNjQqHMmO1RaEQ+YKNN3/ccHycv0/Ay+F2/cGg/tUfE293X+05pxJAqcdXb5e
         g8oQQ0ryHdSWRN/xVi5HOAxMq5V4/ohw/cnay5DnDcPozsePsqw58HnXIdcl5kkWWoIi
         tLGWS5VojO0dFJeBz2vrx86fdk2C1P9OPt7L4JoDf21TLgvSs3cix9kyXLeeEvy854Bz
         AKOqrdswjgzFxGyfi8BF1RHGLN210RUwZrKpI0Xp+ySPLvAMIT1ZrLBtuyLf+TqOxFPx
         WVnqef135s5/q4mRAN5F49l/juIBcYG/QGhrh9otW0XajgchsqR2em286b6E8sFdEJTA
         N2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280554; x=1788885354;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvyNiMWS4QyDaAZzf0SqqbYnm0Hecypi/7pNVDxGqfE=;
        b=IG9a7ZaYsBfYdIxDDBHKdmlKnSed0dbk84aKWZ/17jTkVeOlBz70PtUTGNwG+ufTY0
         r63XeKVQft3sV4s6z95K5onLztBwCdemS6ZWawomV9uCPZLkyFWSRMZsHYxnJdhgdnLT
         9Cm2h84XQ5QBlA8dh4icse1fFi34+YUyFoEqRLZuBubF84yIIu4q6bfCEEwSdFMtYVpT
         D9xo6gm4YqmonThjaINdmVPt1MLqwlBp1a/Fs5uGCtw33eY0rcMcHfb1Ny7kUSHHSwqr
         fgeuD5JZyJACyj82xd5AKiEJLLmYlGF1KrbN/qaUGKXchaHwyy+yHSzGGXxrBGvMgx/A
         kLAg==
X-Forwarded-Encrypted: i=1; AHgh+RrHm5Zlbd28A2kn7aeFxnii7aR9lxsznFiVIIOYmYpQHpScKTH0ZXkWfMVORt6Sm9dpGOkba5aoIVPVN+fpoQ==@groups.io
X-Gm-Message-State: AFuF++nxi8T4zDv+ghw6bMgczHBi9OmLgAX8aY9vcG0rdFOFOyxbL0QY
	HPzDaXWkQuP4rUAUEKrrCe3l97W8qiF7DD5LKHnQA8fuJxZJOk4Xg/xCQ8K91W4H+yfwFC+CpxP
	B2JFChMk=
X-Gm-Gg: AR+sD11eDFQV1PVFglU5C4IqqtZSQ/273meeYukXGYbfwqxxQj0NafVs2oj74GMy2Zt
	yyg4aL6XMTMdLg2mDaShJLCKca0VC+Ldb5Of/hhpALoYn59woJxohSkaj0Ymax5g+jZSs4d2iMC
	JANPDZoXy//aVbibAmTyCzvn57W76FFWX2+6vOmcv2MX+4mzdN442DJOCGHBDxCXHkykQEzTHiS
	HAPGakdSP7BAcpZToEkpu2uIkfKL3J0IvM/QXCVmgDAKww5lNdSDunuWWPQhnWdTsSbPgqYLOWq
	Qrh6PFw6sGz4f+0ECunO8ANM3WBreJstLtvOfcQDAhmXRfMHDy3k9rYu49jCjbqbT6y60+joXdX
	K6G231wQ+jJOaUl5ipNtSH6LmKmeLvgyeY5BxiiVZLCMJ74amt96w8/7C3qRzZ3Wei/GQEqPr75
	fd+bMBsINBDQZ6uptnHPESXF1Oo6tqzoaD+e7kDDWsV9Wy20W7aQTVPZDFl5FiRQFjHByhQ9uA0
	KdzJk06FP6hobkl+A7wzhT4LjoiuuGF9+WzQQxtJ0Q0GEJNTL5C/g==
X-Received: by 2002:a05:600c:a00d:b0:49a:252d:52f5 with SMTP id 5b1f17b1804b1-49cdc45253dmr187165335e9.11.1788280521515;
        Tue, 01 Sep 2026 09:35:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3b72:e9ec:2552:5b90? ([2a01:e0a:106d:1080:3b72:e9ec:2552:5b90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9266be71sm793470805e9.2.2026.09.01.09.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:35:21 -0700 (PDT)
Message-ID: <afe6836f-5366-4177-ab57-7563380e8b74@linaro.org>
Date: Tue, 1 Sep 2026 18:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260901-typo-v1-1-89ea773a9a05@arm.com>
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
In-Reply-To: <20260901-typo-v1-1-89ea773a9a05@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 01 Sep 2026 16:36:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3085

On 9/1/26 18:20, Vincent Stehlé wrote:
> The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using the
> following command:
> 
>    find '(' -type d -name .git -prune ')' -o -type f -print |\
>      xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'
> 
> This can be verified by pre-processing, for example with the following
> commands:
> 
>    make libretech-cc_v2_defconfig
>    make spl/arch/arm/mach-meson/spl.i spl/common/spl/spl_atf.i
> 
> (Adjust as needed for cross-compilation.)
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm/mach-meson/spl.c | 2 +-
>   common/spl/spl_atf.c      | 8 ++++----
>   include/atf_common.h      | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
> index 28a63f39d36..73445064e4d 100644
> --- a/arch/arm/mach-meson/spl.c
> +++ b/arch/arm/mach-meson/spl.c
> @@ -84,7 +84,7 @@ void board_init_f(ulong dummy)
>   
>   		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
>   		spl_ep_info.pc = CONFIG_SPL_TEXT_BASE;
> -		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECPTIONS);
> +		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXCEPTIONS);
>   
>   		regs.regs[0] = 0xc0000000;
>   		regs.regs[1] = (unsigned long)&spl_ep_info;
> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> index 17acd3665df..cb0604ce034 100644
> --- a/common/spl/spl_atf.c
> +++ b/common/spl/spl_atf.c
> @@ -75,7 +75,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>   	bl32_ep_info->args.arg3 = fdt_addr;
>   	bl32_ep_info->pc = bl32_entry ? bl32_entry : 0;
>   	bl32_ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
> -				     DISABLE_ALL_EXECPTIONS);
> +				     DISABLE_ALL_EXCEPTIONS);
>   
>   	bl2_to_bl31_params->bl32_image_info = &bl31_params_mem.bl32_image_info;
>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl32_image_info,
> @@ -91,7 +91,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>   	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
>   	bl33_ep_info->pc = bl33_entry;
>   	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
> -				     DISABLE_ALL_EXECPTIONS);
> +				     DISABLE_ALL_EXCEPTIONS);
>   
>   	bl2_to_bl31_params->bl33_image_info = &bl31_params_mem.bl33_image_info;
>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl33_image_info,
> @@ -149,7 +149,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
>   	bl_params_node->ep_info->args.arg3 = fdt_addr;
>   	bl_params_node->ep_info->pc = bl32_entry ? bl32_entry : 0;
>   	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
> -						DISABLE_ALL_EXECPTIONS);
> +						DISABLE_ALL_EXCEPTIONS);
>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>   		       ATF_VERSION_2, 0);
>   
> @@ -166,7 +166,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
>   	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
>   	bl_params_node->ep_info->pc = bl33_entry;
>   	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
> -						DISABLE_ALL_EXECPTIONS);
> +						DISABLE_ALL_EXCEPTIONS);
>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>   		       ATF_VERSION_2, 0);
>   
> diff --git a/include/atf_common.h b/include/atf_common.h
> index 03cfcc69cd7..9ef1ef186e1 100644
> --- a/include/atf_common.h
> +++ b/include/atf_common.h
> @@ -69,7 +69,7 @@
>   #define DAIF_IRQ_BIT (1<<1)
>   #define DAIF_ABT_BIT (1<<2)
>   #define DAIF_DBG_BIT (1<<3)
> -#define DISABLE_ALL_EXECPTIONS	\
> +#define DISABLE_ALL_EXCEPTIONS	\
>   	(DAIF_FIQ_BIT | DAIF_IRQ_BIT | DAIF_ABT_BIT | DAIF_DBG_BIT)
>   
>   #ifndef __ASSEMBLY__
> 
> ---
> base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
> change-id: 20260901-typo-465ee352485c
> 
> Best regards,
> --
> Vincent.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

