Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4AC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 08:55:24 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.9427.1714121723180608774
 for <u-boot-amlogic@groups.io>;
 Fri, 26 Apr 2024 01:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=dYo9+pBI;
 spf=pass (domain: linaro.org, ip: 209.85.208.169, mailfrom: neil.armstrong@linaro.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so21845241fa.3
        for <u-boot-amlogic@groups.io>; Fri, 26 Apr 2024 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714121721; x=1714726521; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThS2pAcdkE9Vvi2vp4kH2KJVfGKZVMmPaHazF3BdhZ0=;
        b=dYo9+pBIRvGZf9H3F3UPQZqYKanRdez4n37S19DwtPxalA6IHMBbE4NDMlv8VLzHfB
         H75iOPDuto4u2bRYIvmZFmpO4l65B7gTgS9Nwoi0YIbZTyaCLtAS6xK8KEzCq+65qdRp
         1TFEv+QFyeERnc/+J7B1rKHAkzbG+rsdYrUH2LCo0MV8hEFT+UWS+ciYyniZvNPns9H4
         Ku9KXuccerC9uluCryj/ZDeU/1xe4IzzNmhf8Tad+6YvC3V7AdGHGCCX/nTE9ie6wM++
         3zSj2BKYDoAxBk/bp/vRwy6Xp3XYkMizCpZpGff7fLsdbVwcuZ2EJULkFRPsb+JhhQpA
         BmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121721; x=1714726521;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ThS2pAcdkE9Vvi2vp4kH2KJVfGKZVMmPaHazF3BdhZ0=;
        b=MCdvhVaTlp63hXjhsunGF9KfpBPQ/sah4YsNVINN+e1oawwNpvMfJLTIiieeb6b9Hw
         VKtJQ2wW7CiRg9aHM6vCU5V86SIW03F+SWknquMwO/CnLy1DLEP/ZfWgyoBUGmiiafPr
         qd8f5FkqoO/mmN3/buLz5n/0c5+N+kOHHLQIYW0X33+TbVBUvHkmhjrLoxoAcraU9GkE
         FpNCMC4JgSGkuRFiaqRZfRE4qLFtXz7JnbOdDVTEy/jvlJTOwKQfqrUa/D2Uk/1Hcm4w
         tOlbjAbKDmUYeiL6qWZq5ewK6ysGCSRZFfyUrhNc+e3trZHEwP02tdGKA59gwUQpl+LF
         EkZA==
X-Forwarded-Encrypted: i=1; AJvYcCWCt0ME6KOLVmKKupENsGb2tqgqKYpC9VcjoRaFPdv70a1pIT3kRTTvHBJYE17zj2S9PXO1Hr99idkKCU9ZG4DnULqlPntqMBQ=
X-Gm-Message-State: AOJu0YwfRgM8FiVhjCeKSgQVugLR/VifeolDeJYe0eKQ8WDmwcA5yKN2
	MX5cSRfqbJGd5UBjW55QlM1kl4MPkw6WJ2ZFERhRVnB7+R1hkxd4F9tkDmPs3JU=
X-Google-Smtp-Source: AGHT+IGGBm/+mGnwWYIHfM/p7bDsOaljrEyWOLsjWiPDZtEw8dKGlg5UYgyH3VgBrLweixnq/qiwXQ==
X-Received: by 2002:a2e:a4a4:0:b0:2db:7b:1a7b with SMTP id g4-20020a2ea4a4000000b002db007b1a7bmr1055495ljm.46.1714121721067;
        Fri, 26 Apr 2024 01:55:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb? ([2a01:e0a:982:cbb0:f335:a8c9:f9da:cddb])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm19463446wmq.17.2024.04.26.01.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 01:55:20 -0700 (PDT)
Message-ID: <f3c7627e-fdd4-4b1d-9c4b-6cec3bde18f9@linaro.org>
Date: Fri, 26 Apr 2024 10:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm: dts: meson-axg: add NAND controller node for AXG
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@sberdevices.ru,
 oxffffaa@gmail.com
References: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
 <d272b0f6-2f21-4601-b347-f83eac4f12d4@linaro.org>
 <21b14ae5-1f92-6c7b-2c65-20ef3cb5820d@salutedevices.com>
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
In-Reply-To: <21b14ae5-1f92-6c7b-2c65-20ef3cb5820d@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Apr 2024 08:55:24 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2279

On 26/04/2024 10:40, Arseniy Krasnov wrote:
> Hi,
> 
> On 26.04.2024 11:21, Neil Armstrong wrote:
>> Hi,
>>
>> On 25/04/2024 19:50, Arseniy Krasnov wrote:
>>> nfc: Synced from Linux commit 7ca2ef33179f ("Linux 6.6-rc1")
>>> nand_all_pins: Synced from Linux commit be18d53c32b2 ("Linux 6.7-rc3")
>>
>> No need to sync DT anymore, this is handled by OF_UPSTREAM and for next release
>> it's already aligned with v6.9 DT.
>>
>> Please try your patches with master or next branch of U-Boot repo.
> 
> Ok, so I can remove "Synced from" from commit description, thus make it empty, and test that patch applies correctly
> on uboot master/ next ?

It won't apply because arch/arm/dts/meson-axg.dtsi doesn't exist anymore, DT comes
from dts/upstream, however if you need to add u-boot specific changes you can
still update arch/arm/dts/meson-axgi-u-boot.dtsi

Neil

> 
> Thanks
> 
>>
>> Neil
>>
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>>    arch/arm/dts/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
>>> index 3f5254eeb4..4f6fdd5523 100644
>>> --- a/arch/arm/dts/meson-axg.dtsi
>>> +++ b/arch/arm/dts/meson-axg.dtsi
>>> @@ -430,6 +430,27 @@
>>>                        };
>>>                    };
>>>    +                nand_all_pins: nand_all_pins {
>>> +                    mux {
>>> +                        groups = "emmc_nand_d0",
>>> +                             "emmc_nand_d1",
>>> +                             "emmc_nand_d2",
>>> +                             "emmc_nand_d3",
>>> +                             "emmc_nand_d4",
>>> +                             "emmc_nand_d5",
>>> +                             "emmc_nand_d6",
>>> +                             "emmc_nand_d7",
>>> +                             "nand_ce0",
>>> +                             "nand_ale",
>>> +                             "nand_cle",
>>> +                             "nand_wen_clk",
>>> +                             "nand_ren_wr";
>>> +                        function = "nand";
>>> +                        input-enable;
>>> +                        bias-pull-up;
>>> +                    };
>>> +                };
>>> +
>>>                    emmc_ds_pins: emmc_ds {
>>>                        mux {
>>>                            groups = "emmc_ds";
>>> @@ -1906,6 +1927,21 @@
>>>                    resets = <&reset RESET_SD_EMMC_C>;
>>>                };
>>>    +            nfc: nand-controller@7800 {
>>> +                compatible = "amlogic,meson-axg-nfc";
>>> +                reg = <0x0 0x7800 0x0 0x100>,
>>> +                      <0x0 0x7000 0x0 0x800>;
>>> +                reg-names = "nfc", "emmc";
>>> +                pinctrl-0 = <&nand_all_pins>;
>>> +                pinctrl-names = "default";
>>> +                #address-cells = <1>;
>>> +                #size-cells = <0>;
>>> +                interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>>> +                clocks = <&clkc CLKID_SD_EMMC_C>,
>>> +                     <&clkc CLKID_FCLK_DIV2>;
>>> +                clock-names = "core", "device";
>>> +            };
>>> +
>>>                usb2_phy1: phy@9020 {
>>>                    compatible = "amlogic,meson-gxl-usb2-phy";
>>>                    #phy-cells = <0>;
>>


