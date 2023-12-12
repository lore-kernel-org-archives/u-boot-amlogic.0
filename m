Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F59CC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 14:03:31 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.2305.1702389804128065376
 for <u-boot-amlogic@groups.io>;
 Tue, 12 Dec 2023 06:03:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ZTMJqvXE;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336121f93e3so1858377f8f.0
        for <u-boot-amlogic@groups.io>; Tue, 12 Dec 2023 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702389802; x=1702994602; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5wrypY0Fao/rFN36xFxRLeHIuKKTfCkF0Dt4zGRz8I=;
        b=ZTMJqvXEOVC0baGEcfTreO1Rhg7tVSII+X1eNU3D1UYKDkxMdmbB4luRgXA2oTa8Cp
         7tIDUST+/WGR5HAKHnrll5oXdrKEV0hu3Wq3jH1JphMRrDuKSzLBocnxXYaK58EebJXh
         6UwatiP8XNn+tXBZ8Y+awOA4EkATrxOv28b58cWh+mr7dpVtsJCw84n6GYvjm98KEI2e
         AI5DSDP/HRlxhIq/oZpOn1PLW4Yz6F8NLgPTRFKPo8pQL9O2VB9gkjpq19XxFM2Lv7oZ
         SCuaWmuavZp6lbqQmxffisG+wycS00zFbMPVXnvMTN68aeW3y4XGXruGPpD8IqBwjgfa
         4T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389802; x=1702994602;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w5wrypY0Fao/rFN36xFxRLeHIuKKTfCkF0Dt4zGRz8I=;
        b=wWo1KXVpAxInjnxh6uWffGc7z8XxnmUGsue2JAUIWpZETYS8Z788er3/IouI6Ecl9A
         P0GKlQOA0UfIHT4yi5r/HqcqeXLfLlqjSCibfl6tBidy7+C/eJg3V7jjmcRA3+yywBX2
         sWZnaZRhnD4E2BEcbozCHC+FuHQiS+rn0Q8kD64qY7wECuQQx1Z4qYB1tS/N9mXfwHCP
         sFh1X8cVmhaFNkm6xNvzWJYwaPYpdKGG5BIEOmdtAWwW3wvU5u4IISAMAo7QAAP9AQYs
         bf7xD5BAaghXMHZR2EkFzy3zJObPGkJdNcoPsHmm+Bnhuc7wDdkQImd1PWS9BIAwIOnm
         cy4w==
X-Gm-Message-State: AOJu0Yy08W1Q8bUGBd4xyOw9S3aLMG+27g3d4auUDIeLNnwI/wM2poP4
	ctdtnyilcFmrU4ELwm/4zJTQejYdlVyfkd/XzXY5vgHR
X-Google-Smtp-Source: AGHT+IGKhVNlpXYbjjaenxbHT3i4NBylkVLW356xM+DqvbFlnSBtG1Kz/NxHXTpEIPQGooS+AwXVDQ==
X-Received: by 2002:adf:fb49:0:b0:333:2fd7:95f4 with SMTP id c9-20020adffb49000000b003332fd795f4mr3778018wrs.47.1702389802506;
        Tue, 12 Dec 2023 06:03:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5894:fa62:26b4:bf82? ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d574c000000b003363654301esm193942wrw.98.2023.12.12.06.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 06:03:21 -0800 (PST)
Message-ID: <a5cbd4fe-dd24-40ae-a61c-c2af27d5e0ee@linaro.org>
Date: Tue, 12 Dec 2023 15:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm: dts: meson: add NAND controller node for AXG
Content-Language: en-US, fr
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru,
 oxffffaa@gmail.com
References: <20231130122712.189700-1-avkrasnov@salutedevices.com>
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
In-Reply-To: <20231130122712.189700-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 12 Dec 2023 14:03:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1909

Hi,

On 30/11/2023 13:27, Arseniy Krasnov wrote:

Can you add a reference to the Linux patches that you submitted so
we know it will be safe to sync the DT from Linux when they are merged ?

Thanks,
Neil

> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>   arch/arm/dts/meson-axg.dtsi | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
> index 3f5254eeb4..c01ace3ff1 100644
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
> @@ -1906,6 +1927,20 @@
>   				resets = <&reset RESET_SD_EMMC_C>;
>   			};
>   
> +			nfc: nand-controller@7800 {
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +				pinctrl-0 = <&nand_all_pins>;
> +				pinctrl-names = "default";
> +				compatible = "amlogic,meson-axg-nfc";
> +				status = "okay";
> +				reg = <0x0 0x7800 0x0 0x100>,
> +				      <0x0 0x7000 0x0 0x800>;
> +				clocks = <&clkc CLKID_SD_EMMC_C>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +			};
> +
>   			usb2_phy1: phy@9020 {
>   				compatible = "amlogic,meson-gxl-usb2-phy";
>   				#phy-cells = <0>;


