Received: by mail-wr1-f66.google.com with SMTP id n4so13371552wrw.13
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IUC8H4xgn4HYX4E9zM3HRgkA0iA9V2TubOnJ36nb61Y=;
        b=1YDyYglyyQFtw7UtsM/SEi8pTDPtAfNVcgSwv0krWYGd7bmD00YgAvXEL4eUODCnPu
         Q49vUdBJk1h3kNCqH29XXMwAbXqGX3sxZKYu5dq5YMO/ybb8RSbDafaSjp2dj4VrjSct
         VFQP9IDSke/WLAgZGyA4/5s8CIJmCIfR4R1k6RytRBFHqbzP1q2EmsGlwNIInEsYi31W
         vi/RCSe9s+GXqiWSyQZstFbTGuiRw55Ba/N7CxxzdL0Bllc5KKjue3ShEYW8To2YU86u
         AxYQef9gVk9OIRaGg8N4w3F/BqvdRGnmIQ29fcVzRqMll1WtdBYxIlgaPtsC2Y2grRV7
         VtaA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] pinctrl: meson-gxbb: add hdmi related pins
References: <20190604202637.6421-1-mjourdan@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <95656209-86e4-84bc-14da-3acf3b757000@baylibre.com>
Date: Wed, 5 Jun 2019 11:03:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190604202637.6421-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Maxime Jourdan <mjourdan@baylibre.com>, u-boot@lists.denx.de
Cc: Jerome Brunet <jbrunet@baylibre.com>, Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 04/06/2019 22:26, Maxime Jourdan wrote:
> The GXBB pinctrl is missing pins related to HDMI, namely hot plug
> detection (hpd) and I2C (sda + scl).
> 
> This fixes HDMI support for GXBB in u-boot.
> 
> Reported-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> index 59b5be6211..9e2e151164 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> @@ -61,6 +61,10 @@ static const unsigned int eth_txd1_pins[]	= { PIN(GPIOZ_11, EE_OFF) };
>  static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
>  static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
>  
> +static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0, EE_OFF) };
> +static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1, EE_OFF) };
> +static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2, EE_OFF) };
> +
>  static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
>  static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
>  static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
> @@ -232,6 +236,11 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
>  	GROUP(eth_txd2,		6,	3),
>  	GROUP(eth_txd3,		6,	2),
>  
> +	/* Bank H */
> +	GROUP(hdmi_hpd,		1,	26),
> +	GROUP(hdmi_sda,		1,	25),
> +	GROUP(hdmi_scl,		1,	24),
> +
>  	/* Bank DV */
>  	GROUP(uart_tx_b,	2,	29),
>  	GROUP(uart_rx_b,	2,	28),
> @@ -351,6 +360,14 @@ static const char * const eth_groups[] = {
>  	"eth_txd0", "eth_txd1", "eth_txd2", "eth_txd3",
>  };
>  
> +static const char * const hdmi_hpd_groups[] = {
> +	"hdmi_hpd",
> +};
> +
> +static const char * const hdmi_i2c_groups[] = {
> +	"hdmi_sda", "hdmi_scl",
> +};
> +
>  static const char * const gpio_aobus_groups[] = {
>  	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
>  	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
> @@ -383,6 +400,8 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
>  	FUNCTION(uart_b),
>  	FUNCTION(uart_c),
>  	FUNCTION(eth),
> +	FUNCTION(hdmi_hpd),
> +	FUNCTION(hdmi_i2c),
>  };
>  
>  static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
> 

Applied to u-boot-amlogic
