Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.103436.1696318068104059536
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:27:48 -0700
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-32329d935d4so616958f8f.2
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696318066; x=1696922866; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JoGW1PL7iE2wfeVTeRF473P6kJ0k+9TWP+BP9Jo/Wk=;
        b=OXhvHW6R84fzx1KwKWyD/hPddfouLc1n5jCCPYrtDQCpLxCchZcEVGUMUg29Fk54Ur
         WC9JhA6VRlRXwr3ebYZJb8dDF1NdYuKk7APwrJtvXG9k+RnCzntbllydv+IMMiBUbBg6
         5dZzD9TzELO8YC328ntg/z58BsDPeM6quslHbaavVU8xto327H20+iR7RWjPaMwzZNVF
         TUYR+lFZRirfBo/kKN93Bo5ciwf+vIxgvchJqV+M65yEZ6BVz1OwME3u6P+aOXIzZ5b2
         mEZfSrZftoHytGG0VJiP1pjcuuyJ3BYFdHgc+7DU3f9P9srJtbA7cRUlHcjQU/1LFJ37
         SJ7g==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <0d3d89f1-ec88-432f-9b17-2fb718a6bd3c@linaro.org>
Date: Tue, 3 Oct 2023 09:27:44 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 6/8] a1: clk: Add missing CLKID_USB_PHY_IN gate
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-7-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-7-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> From: Igor Prusov <ivprusov@salutedevices.com>
> 
> We use this clock in dwc3 driver.
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/clk/meson/a1.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index 3aec42f33b..1540e1875b 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -238,6 +238,9 @@ static const struct meson_clk_info *meson_clocks[] = {
>   	[CLKID_FIXPLL_IN] = CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
>   		EXTERNAL_XTAL
>   	),
> +	[CLKID_USB_PHY_IN] = CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
> +		EXTERNAL_XTAL
> +	),
>   	[CLKID_SARADC] = CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
>   		-ENOENT
>   	),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
