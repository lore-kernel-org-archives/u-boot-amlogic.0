Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA351CAC582
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 08:14:22 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.7648.1757319255679368865
 for <u-boot-amlogic@groups.io>;
 Mon, 08 Sep 2025 01:14:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=hkrqYk/e;
 spf=pass (domain: linaro.org, ip: 209.85.221.41, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so3830991f8f.1
        for <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757319254; x=1757924054; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NM4Rxl7DqxDVxdEdqKM+hPbHynu1pPjxSy/EbaxJIFI=;
        b=hkrqYk/eOINvzLvR8IHEWG6Ly6IjxFPUY9Ho2ZawbwXJubrUzM/rGZ5K/pcGeEYvWS
         k8ZVMNl+pcbVS9myb17kt6pvgTKNyi6k/4xeJKERokhOnjbY+2N/fqnYzvXuIueqjQM/
         wAR172ptWMdg7MzKWoeFAyIrfbMz6CUN+6HSYwGPd7+HKEnJHnpw1ShYl6gTGGuzv6UA
         Z/JbrenrcvkVeAyCUHHkDJkDHY8SCV/tZEA8buIgs7zzh9OwORD5Qrxtc8TSmq5i621m
         jZX1iDZ60HvFv05ixXnN9JpEIWv49KLSQkl7fW7bDEHLYy+jU3Dmrrcv1yWGier1Y4kj
         KhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319254; x=1757924054;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NM4Rxl7DqxDVxdEdqKM+hPbHynu1pPjxSy/EbaxJIFI=;
        b=UNY+P39qyIeGHb/LCiJB01uhBiuzGtS7hH2lDv7Eg3nDtIKXY69jhK2IVNLZgMS54/
         lDOdjO4GIjAXQRgTnSEIYe42TWYo7qfvqmg1bIt+2GcuNw3JvgRrhMSERw6d0NZhcSNl
         WE7hFI66UFp23tRYoA6g5/o21QLT5eQO2r4N/pbYdvDn1Rp2hrncBIRSbrUySnvmMu9s
         Rd5O2h0YV0N3pZXoJichhe9UUre9a2pi7WGDokABGYJk6/QbNaYleFaBoVkQkirtEi3w
         Zqn5twvRrMjhVJmXaUaJnKSUb9ClCSboVC0DYEI8lmQ9rhvnUViPzweGEkL60+3C/Irf
         cKFw==
X-Forwarded-Encrypted: i=1; AJvYcCUYSNSyZcc3lmTsffJMjj/hFSdICdttN4JPoaisJewF2LiY6WFOSCf3CIKDVaPIzkA8bqxHKiZGtIhh77/WfQ==@groups.io
X-Gm-Message-State: AOJu0Yy9S7DkKbLFiWCcJMZ6bf+i7LI0mnDZRFO35ACLucMFC/ajKY3a
	fFaWY1xyYERIJZ5Qdz0JMl8NaWeUeioj1OSre36YA2B8Qxm1Fao8Sv4Ulfq+A8AtH2U=
X-Gm-Gg: ASbGncuNEs54XOxM0tauWUv4c2OIGh+yUZTNqmb42S9Fprhnb6ECuTFZldHEkEPnAND
	AJzPkjHbjWPJbPkh/b7WU6UfIiJSqIldMRDeN35qcrLFjucS0snCh3CuapEkRNuq96ErYV1Wd+f
	JRhUiwqGV1czPkaFZjGdjMm4OtyPZY9NWT9xbDLerjbAFk32kSJB+w681F63amzxGMd2IYDciiC
	Vt0bnDPoQDgKZIfJTT7sXKRHuSmpFuCsgb4oiuz4lT4G9zkJMSz3+JJYhSLRUSt/QaXYDG+w9Eo
	RGq8WzfRt/g/xtlPkZTNXRHL2grXdCYt1SN8axanG9Mv8+4ru7TxmoxXuflGqqA2lEWQhepqmDW
	dpTZ+lCEccoZMad2N5Hbt476NThRi7/g2NhafZdzEeuatGfhDZ5iYVXDfbCebDd1tAFTrt/SUJX
	OVj2WVXb0KYA==
X-Google-Smtp-Source: AGHT+IGCCh1yMeCjGS+g1djYBDYmR060GW/NgY+2zDUdYn7ooNPts98l3UQPUoP6SAkLFXsPe7BCXQ==
X-Received: by 2002:a5d:5f82:0:b0:3e7:42ae:d3dd with SMTP id ffacd0b85a97d-3e742aed713mr3577686f8f.53.1757319253941;
        Mon, 08 Sep 2025 01:14:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d690f2ebb9sm31008901f8f.20.2025.09.08.01.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:14:13 -0700 (PDT)
Message-ID: <76c5f608-a5fa-4922-b786-c987035ba6f9@linaro.org>
Date: Mon, 8 Sep 2025 10:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 7/9] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-7-37395d9ff5af@postmarketos.org>
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
In-Reply-To: <20250907-spl-gx-v1-7-37395d9ff5af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Sep 2025 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2756

On 07/09/2025 16:36, Ferass El Hafidi wrote:
> Add binman configuration to meson-gx-u-boot.dtsi to automate building
> bootable images using amlimage.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/dts/meson-gx-u-boot.dtsi | 142 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
> index 9e0620f395e81048273690af4cee4b196ee7b0a7..d05f869c06ebefa08f5480327e4a72bbaa9a5e94 100644
> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (c) 2019 BayLibre, SAS.
>    * Author: Maxime Jourdan <mjourdan@baylibre.com>
> + * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
>    */
>   
>   / {
> @@ -15,6 +16,16 @@
>   	soc {
>   		bootph-all;
>   	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +#if defined(CONFIG_BINMAN)
> +	binman: binman {
> +		multiple-images;
> +	};
> +#endif
>   };
>   
>   &vpu {
> @@ -30,3 +41,134 @@
>   	      <0x0 0xc883c000 0x0 0x1000>;
>   	reg-names = "hdmitx", "hhi";
>   };
> +
> +#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)
> +/* binman configuration on GXBB and GXL */
> +
> +#if defined(CONFIG_MESON_GXBB)
> +#define BL31_ADDR 0x10100000
> +#else /* GXL */
> +#define BL31_ADDR 0x05100000
> +#endif
> +
> +/*
> + * On GXBB the base address of the SCP firmware doesn't matter as SPL will
> + * send the firmware to the SCP anyway, and can get the base address from the
> + * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so set the
> + * base address to what GXL BL2 would load the binary to.
> + */
> +#define  SCP_ADDR 0x13c0000
> +
> +&binman {
> +	u-boot-amlogic {
> +		filename = "u-boot-meson-with-spl.bin";
> +		pad-byte = <0xff>;
> +
> +		mkimage {
> +			filename = "spl/u-boot-spl-signed.bin";
> +#if defined(CONFIG_MESON_GXBB)
> +			args = "-n", "gxbb", "-T", "amlimage";
> +#elif defined(CONFIG_MESON_GXL)
> +			args = "-n", "gxl", "-T", "amlimage";
> +#endif
> +
> +			blob {
> +				size = <0xb000>; /* The BootROM loads 48K max (header is 4K) */
> +				filename = "spl/u-boot-spl.bin";
> +			};
> +		};
> +
> +		fit: fit {
> +			description = "ATF and U-Boot images";
> +			#address-cells = <1>;
> +			fit,fdt-list = "of-list";
> +			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
> +			fit,align = <512>;
> +			offset = <CONFIG_SPL_PAD_TO>;
> +
> +			images {
> +				u-boot {
> +					description = "U-Boot";
> +					type = "standalone";
> +					os = "u-boot";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					entry = <CONFIG_TEXT_BASE>;
> +
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				atf {
> +					description = "ARM Trusted Firmware";
> +					type = "firmware";
> +					os = "arm-trusted-firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					load = <BL31_ADDR>;
> +					entry = <BL31_ADDR>;
> +
> +					atf-bl31 {
> +						filename = "bl31.bin";
> +					};
> +					hash {
> +						algo = "sha256";
> +					};
> +				};
> +
> +				scp {
> +					description = "SCP firmware";
> +					type = "scp";
> +					arch = "arm"; /* The Cortex-M core is used as SCP */
> +					compression = "none";
> +					load = <SCP_ADDR>;
> +
> +					scp {
> +						filename = "scp.bin";
> +					};
> +					hash {
> +						/*
> +						 * The hash is used by the SCP and passed to it
> +						 * by U-Boot SPL.
> +						 */
> +						algo = "sha256";
> +					};
> +				};
> +
> +				@fdt-SEQ {
> +					description = "NAME";
> +					type = "flat_dt";
> +					compression = "none";
> +				};
> +
> +			};
> +			configurations {
> +				default = "@config-DEFAULT-SEQ";
> +				@config-SEQ {
> +					description = "NAME.dtb";
> +					fdt = "fdt-SEQ";
> +					firmware = "atf";
> +					loadables = "scp", "u-boot";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&vpu {
> +	/delete-property/ bootph-all;
> +};
> +
> +&apb {
> +	bootph-all;
> +};
> +
> +&sd_emmc_b {
> +	bootph-all;
> +};
> +
> +&sd_emmc_c {
> +	bootph-all;
> +};
> +#endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

