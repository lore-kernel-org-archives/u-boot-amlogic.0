Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.107694.1696339259879094321
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 06:21:00 -0700
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3248aa5cf4eso970913f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696339258; x=1696944058; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI59aYosQYHU2guYGI0SzdHSoKj72+JZp8wirAuCrGE=;
        b=lCSP46WIh6jWS8usks0WEFbL/K73ayQjlNJk9yExcQVfhKlv6NfkGI+Bym4mA2frSs
         83n5SbXoxJJQdICfMNRHBBf83jUKrwETVw+WPpX0o2lCgSFS+xU9KmGFwL9UZezknMK8
         EAYcNA+iogdBBg//HlH3bo4CEJF0anKT8Ph1IwMPACoVharhM6OMhfrokd1q/v6IUYhM
         gQiFDf3ZRSnQzPNl03CIZnuJYjnZgVLtJ7+9s7yFD8XI45/3ze+F7sP4o+asIoa0bOYi
         Kb90DFKQ4louKG8NQ//OVbXUcPgzNmA4utWl5QjQ9AhZ2EVKthdNjUOcmnZiNX2vFClT
         HfOg==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <a0fef13f-0f39-4595-abb2-2859f0bb18a4@linaro.org>
Date: Tue, 3 Oct 2023 15:20:56 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
References: <20231003112838.41503-1-avromanov@salutedevices.com>
 <20231003112838.41503-7-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-7-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

On 03/10/2023 13:28, Alexey Romanov wrote:
> From: Igor Prusov <ivprusov@salutedevices.com>
> 
> We use this clocks in dwc3 driver.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/clk/meson/a1.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 3aec42f33b..1075ba7333 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -238,6 +238,12 @@ static const struct meson_clk_info *meson_clocks[] = {
>   	[CLKID_FIXPLL_IN] = CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
>   		EXTERNAL_XTAL
>   	),
> +	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
> +		EXTERNAL_XTAL
> +	),
> +	[CLKID_USB_PHY] = CLK_GATE("usb_phy", A1_SYS_CLK_EN0, 27,
> +		CLKID_SYS
> +	),
>   	[CLKID_SARADC] = CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
>   		-ENOENT
>   	),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
