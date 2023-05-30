Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.1012.1685461927887289855
 for <u-boot-amlogic@groups.io>;
 Tue, 30 May 2023 08:52:08 -0700
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so4957148e87.1
        for <u-boot-amlogic@groups.io>; Tue, 30 May 2023 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461926; x=1688053926;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tcH0NR469DMpKoS2D6jvRipmniWKgHKI9p1IVXP+sQA=;
        b=yocHotQsEH1201eGE1tNYtgMUc5jnBWE+nYbpmdqHwShpR7Cws6D+7DzcmNjyy6DLr
         v0c4tPW/e+ID/Bp4hhnB4ZFu0pB0EUIlfhq+KlrP/TrQxUwpovo4kEf5gwvg1hWkxsw6
         MFaQ3H0cU5nr4eTLWT7OOKME7bQqGPioaaVQi9p1i6oPwDCeohNn3Edlb3nzqutQp/j2
         V91JLPyktZsgFcXApGcRiaTs9l+ihbHE2/QNKfoNwZ18WEaVAgTeEhkMybElrqI5x42Y
         jeQ630v5QPFthOzGnAdrcj9fA5jOy9e4eln983ha4Fq4o/OErFEAMHM0mEFRJwIZLZcV
         5AZw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <c7042606-8397-33d4-1808-dde606575d95@linaro.org>
Date: Tue, 30 May 2023 17:52:03 +0200
MIME-Version: 1.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/3] arch/arm64: meson-a1: dts: move pwrc node to bus
References: <20230522120941.63962-1-avromanov@sberdevices.ru>
 <20230522120941.63962-4-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230522120941.63962-4-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 22/05/2023 14:09, Alexey Romanov via groups.io wrote:
> This is necessary so that pwrc can be used together with
> peripherals when described in a bus node. For example,
> in the future, this will be USB.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   arch/arm/dts/meson-a1.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> index 9776b2d8798..f3560cbc3a4 100644
> --- a/arch/arm/dts/meson-a1.dtsi
> +++ b/arch/arm/dts/meson-a1.dtsi
> @@ -65,12 +65,6 @@
>   
>   	sm: secure-monitor {
>   		compatible = "amlogic,meson-gxbb-sm";
> -
> -		pwrc: power-controller {
> -			compatible = "amlogic,meson-a1-pwrc";
> -			#power-domain-cells = <1>;
> -			status = "okay";
> -		};
>   	};
>   
>   	soc {
> @@ -161,6 +155,12 @@
>   			#address-cells = <0>;
>   		};
>   
> +		pwrc: power-controller {
> +			compatible = "amlogic,meson-a1-pwrc";
> +			#power-domain-cells = <1>;
> +			status = "okay";
> +		};
> +
>   		usb: usb@fe004400 {
>   			compatible = "amlogic,meson-a1-usb-ctrl";
>   			reg = <0x0 0xfe004400 0x0 0xa0>;

The DT should be the same as Linux, so there's no reason why this would be moved out of the SM node.

Neil
