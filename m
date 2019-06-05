Received: by mail-wm1-f65.google.com with SMTP id 16so1271728wmg.5
        for <u-boot-amlogic@groups.io>; Wed, 05 Jun 2019 01:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/EmW9P4wEHn/mbeCPRQlWFTlN2DTV7wAnpHfvxTnOek=;
        b=P/MlMp8HHMjtnyJ6rX9xopSH2c5htPhllju7exw6fpNfAyHXfmFyb4GZz9J4icq7so
         3a/y+hAusSEjqb8jH3slGmtk6GbEqHb4EiBglQkVMJX6j76xTvUiIjkTvNCsZaVfI7Uh
         rDV7FD79IPsCwMEU9IEbZWuN/7B6AeN7qb0H6Lw61oQVyYe52Dvo6qUBRu2Ef5WmmI55
         UCWDiT/j77B3DB/6vN7zSGjuLRit0coFqiRe6SjxH6I9W34oQ2tPxx50NlVWJxZjEAsf
         /z+M9zkQnJFyGEj26TNkbnb3MXAQZ/ws6mT+D9WSLs6XEFfPgERAl0NNsC4jaeKFtOJC
         iWwA==
Return-Path: <mohammad.rasim96@gmail.com>
Date: Wed, 5 Jun 2019 11:18:18 +0300
From: "Mohammad Rasim" <mohammad.rasim96@gmail.com>
Subject: Re: [PATCH] pinctrl: meson-gxbb: add hdmi related pins
Message-ID: <20190605081818.ttvwdkmyqzwwps46@manjaro.localdomain>
References: <20190604202637.6421-1-mjourdan@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20190604202637.6421-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Maxime Jourdan <mjourdan@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de, Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 19/06/04 10:26PM, Maxime Jourdan wrote:
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
> --
> 2.21.0
>
Tested-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
