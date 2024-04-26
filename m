Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A5C04FFE
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 08:21:34 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.8869.1714119689127320287
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Apr 2024 01:21:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=cMrIFuCO;
 spf=pass (domain: linaro.org, ip: 209.85.208.180, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso20068131fa.2
        for <u-boot-amlogic@groups.io>; Fri, 26 Apr 2024 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714119687; x=1714724487; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdlMorqme09z0hgXtFiVhjo8t9ZBg96TuMKwAPPdPKo=;
        b=cMrIFuCOZ974ip26ZSMr4r4iMZOmVMJiPW8XHz8IAorfX6WFu3i2bAYQuixmqET2f6
         mBdxqpCquIUVUopp4fWDQWcLxd3U5N5m877W8XMTVQKcXKGuLc/ooDTQSF2QA6mzkxcL
         piAw4xb7fYwZi5112ASSktfDeWTlR+ftHBdgqaxad6Ev20yjESDCBHpyohRh3AmznYvt
         Htf/HjKS8HVkr424gpaucPR8eTCPOMDPKhxPtpaITFNk/SiKoNB41ZqlbM83eXzEpKek
         sM6e4u8z1xwubVbwuxyrORRTpxIMkfWPSs4yDjm+1GzzAWfJjl4Rfb0Y+JOUHWXBcrD8
         qT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119687; x=1714724487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LdlMorqme09z0hgXtFiVhjo8t9ZBg96TuMKwAPPdPKo=;
        b=HtSl2fr1qN5hZdsWhyc4Rjj6lnnQdTKVtO8fZA/neqTnjclfAcxw8MBGTIQGqMPDci
         Xd6F1z+eoel7wnSOYDn87lsH+22PNrT6+DRI5XRgc/7nlqxO/LJ9wUWyvnLDNx2PlvlT
         9cRqwe5iIIgt9ow0IInoAXk1ntCko6P9TYP6dCG5ztLIx+wF3EdDAKSkPo664Nij1WQS
         XCuLYStv2ajK2f8G+PbGZVuYHF8Y/YKXfIE8lUl6jJftwq7d38t4pqbMTQ8e6KyKyTK7
         a5KHoIhOQnAGLX1Oaov+NI1PbpEvgufE7laB5qwmxyeFGZfTdHcLIkvlJORplvzGbjo8
         0jhg==
X-Forwarded-Encrypted: i=1; AJvYcCUQx2yWRRN+W2etADU57i5jN4NSNyTDTirsWQnmgdhfHjucxabH0KcRHKyhPzkeV88ZN7ByjkFGhNmEJVO2uHVMmSUIqMEQCF0=
X-Gm-Message-State: AOJu0YyGvcNtTw6XKBc+dbNxm/g8Gm6qtzB9LTPshZ52eSxOGJenB1Ai
	omiVHQH7JvomZ8mk5wxYtXWgMwuQU8oP03kClBhL6mPeCglGmeG2SK5ybqYnomw=
X-Google-Smtp-Source: AGHT+IGwj1rv1BmHu5I+nibAjIOS9EzM4+JDhC72189g2OoM0x6JTUB3GknjV/NAmjCJOXNPRkW/oA==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id n4-20020a2eb784000000b002d6f6987ecfmr1123902ljo.9.1714119687144;
        Fri, 26 Apr 2024 01:21:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb? ([2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d434b000000b0034a2d0b9a4fsm20581577wrr.17.2024.04.26.01.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 01:21:26 -0700 (PDT)
Message-ID: <d272b0f6-2f21-4601-b347-f83eac4f12d4@linaro.org>
Date: Fri, 26 Apr 2024 10:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm: dts: meson-axg: add NAND controller node for AXG
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru,
 oxffffaa@gmail.com
References: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
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
In-Reply-To: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Apr 2024 08:21:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2278

Hi,

On 25/04/2024 19:50, Arseniy Krasnov wrote:
> nfc: Synced from Linux commit 7ca2ef33179f ("Linux 6.6-rc1")
> nand_all_pins: Synced from Linux commit be18d53c32b2 ("Linux 6.7-rc3")

No need to sync DT anymore, this is handled by OF_UPSTREAM and for next release
it's already aligned with v6.9 DT.

Please try your patches with master or next branch of U-Boot repo.

Neil

> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>   arch/arm/dts/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
> index 3f5254eeb4..4f6fdd5523 100644
> --- a/arch/arm/dts/meson-axg.dtsi
> +++ b/arch/arm/dts/meson-axg.dtsi
> @@ -430,6 +430,27 @@
>   					};
>   				};
>   
> +				nand_all_pins: nand_all_pins {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7",
> +							 "nand_ce0",
> +							 "nand_ale",
> +							 "nand_cle",
> +							 "nand_wen_clk",
> +							 "nand_ren_wr";
> +						function = "nand";
> +						input-enable;
> +						bias-pull-up;
> +					};
> +				};
> +
>   				emmc_ds_pins: emmc_ds {
>   					mux {
>   						groups = "emmc_ds";
> @@ -1906,6 +1927,21 @@
>   				resets = <&reset RESET_SD_EMMC_C>;
>   			};
>   
> +			nfc: nand-controller@7800 {
> +				compatible = "amlogic,meson-axg-nfc";
> +				reg = <0x0 0x7800 0x0 0x100>,
> +				      <0x0 0x7000 0x0 0x800>;
> +				reg-names = "nfc", "emmc";
> +				pinctrl-0 = <&nand_all_pins>;
> +				pinctrl-names = "default";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_C>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +			};
> +
>   			usb2_phy1: phy@9020 {
>   				compatible = "amlogic,meson-gxl-usb2-phy";
>   				#phy-cells = <0>;


