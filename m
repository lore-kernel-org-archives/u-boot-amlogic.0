Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.8642.1650634019332596714
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:26:59 -0700
Received: by mail-wm1-f53.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so5374805wms.2
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=mmxovyI8phFcgwLKS2z9Il/UUjJwqqMwQHxHTSsyPfM=;
        b=bsSlZ3ORAW3GrMBWVjxmJLDlLeLm2jAr2D/InT/CJ2j4HqjdFronbZgXDL7bzDxEm6
         QzHOtRWXv/vlUfA6l6oaSeACdNN3nKQrIPcECUMCObAom1bAlwFjyz0YufjgzasK1tlf
         vVXYsaS8b/vY7s5SmxhOYyyxUvJUVVyIC2h5yTnAYQR81oF+vOI9MrKGYYb4t6QDX7si
         si0gJ79DWuGK9QXGSoqskLBmoJdYmmYuiADpE/CxK8RVYm07+AF7xnQBayoF8W/IOdQy
         leP51zZx64wa9Zxn/XcdnZJzIOiwXWT3nkmuHRrpmaReehfXEnSplolunbrE3q7JKbT2
         u0HQ==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <93ba1522-906d-dc05-0fcc-01fa294ef05c@baylibre.com>
Date: Fri, 22 Apr 2022 15:26:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] board: amlogic: jethub j100: enable saradc in dts
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-6-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-6-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Prepare to use ADC channel 1 to check the hardware revision of the board.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
> index 5783732dc6..00a0b268af 100644
> --- a/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
> +++ b/arch/arm/dts/meson-axg-jethome-jethub-j100.dts
> @@ -359,3 +359,8 @@
>   &cpu3 {
>   	#cooling-cells = <2>;
>   };
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vddio_ao18>;
> +};

Please move this in a -u-boot.dtsi file to keep the main DT in sync with Linux.

Neil
