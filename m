Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.15962.1687450776580339724
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Jun 2023 09:19:36 -0700
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fa71db4208so9836805e9.0
        for <u-boot-amlogic@groups.io>; Thu, 22 Jun 2023 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687450775; x=1690042775;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5pMhKSfW7+c75s2JarvkMYhtAVBShQbhbg1Xi6MDsDk=;
        b=Kj55HXPIycbxs0EIPx6eXqTrxGM7XTO8JHQce+dn+LK5/BaV78KnhAW9jrCF40Vakg
         gDRLMg8o/L35cqdJHF4LZk+pBhXNlxbwnYwQ7Jab4LNa3VeMzdDnlJ+Im7SxZ83FIEbK
         n1pSDnrTPpiV/Qnzb700UEK0oQosTVX3oCc8kbMg/oNGm5Ts+ihEGRWZbr94s0jk6znn
         n9E7SHb7ThgSf8vn2q1vf0/n2zWy6MYEg5fMOETnNgTlEaNrbkMcxP4dNBddjjf1gyGs
         i2IdTtmWSwbqKlUql1oHY/ACnpKoCdcCR8JQNbbhrB1L3oPeZcVIMijZstml488DsVJG
         kqeA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <89fe8b9f-729d-f761-0e57-0defb2b95d3a@linaro.org>
Date: Thu, 22 Jun 2023 18:19:33 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] meson-a1: dts: add hw rng node
References: <20230621132953.83343-1-avromanov@sberdevices.ru>
In-Reply-To: <20230621132953.83343-1-avromanov@sberdevices.ru>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 21/06/2023 15:29, Alexey Romanov wrote:
> Add support for hardware random number generator
> of Amlogic Meson SoCs.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   arch/arm/dts/meson-a1.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
> index f3560cbc3a4..1f57c137384 100644
> --- a/arch/arm/dts/meson-a1.dtsi
> +++ b/arch/arm/dts/meson-a1.dtsi
> @@ -140,6 +140,11 @@
>   				clock-names = "xtal", "pclk", "baud";
>   				status = "disabled";
>   			};
> +
> +			hwrng: rng@5118 {
> +				compatible = "amlogic,meson-rng";
> +				reg = <0x0 0x5118 0x0 0x4>;
> +			};
>   		};
>   
>   		gic: interrupt-controller@ff901000 {

Weird, you introduced amlogic,meson-rng-s4 previously but you don't use it here ?

Anyway please add those to Linux first, them sync the DT to u-boot afterwards,

Thanks,
Neil
