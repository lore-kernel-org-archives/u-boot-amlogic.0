Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.6969.1587469931811345497
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Apr 2020 04:52:12 -0700
Received: by mail-wr1-f66.google.com with SMTP id t14so16080192wrw.12
        for <u-boot-amlogic@groups.io>; Tue, 21 Apr 2020 04:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bs3E9nsHvtWvGlxeJOGCGlR7x4ONyh+CcLsVxUzbCiU=;
        b=H+HzviKGaZIAQqKqZTM6MOnlZMQTNh3T0kljZ7IZvFGHzZvCfk5qdqghQaRKqhg57X
         xzogvKEQgJrJM4M6vFRazQByKq02L+fEl4cw6qRyuMzAViJ113sw1w4i6/PIBd6Bt6z9
         c9HTOx5f82qLXL2y/VkkZJq/M3K0NNfU302n1Mx1AbQiFLZZcFr0jrxmNAVA6KIEAXHF
         4uSIrOphUcJQBcYEy1rRc5kjJ5JXgfvLSQTLWVIXCFD9SMSOtv34SRbOuFwL26mN15l5
         WUYy4gjClebAH5Jy7wO+upg0vT2VzNjnkKfpwq0rIok+9NMFuCLkm8URRMiY83s7yK+B
         NKdA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] clk: meson: g12a: add missing SD_EMMC_A controller gates
References: <20200420134630.19935-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ca9078ee-ec95-05d9-b6bd-cd7c6c782902@baylibre.com>
Date: Tue, 21 Apr 2020 13:52:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200420134630.19935-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 20/04/2020 15:46, Neil Armstrong wrote:
> Add missing SD_EMMC_A controller gates needed for probe of the A
> controller, otherwise leading to a freeze of the SoC after b3d69aa596.
> 
> Fixes: b3d69aa596 ("clk: meson: reset mmc clock on probe")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index c1976aa1ef..6089f8474e 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -112,6 +112,7 @@ static struct meson_gate gates[NUM_CLKS] = {
>  	MESON_GATE(CLKID_I2C, HHI_GCLK_MPEG0, 9),
>  	MESON_GATE(CLKID_UART0, HHI_GCLK_MPEG0, 13),
>  	MESON_GATE(CLKID_SPICC1, HHI_GCLK_MPEG0, 14),
> +	MESON_GATE(CLKID_SD_EMMC_A, HHI_GCLK_MPEG0, 4),
>  	MESON_GATE(CLKID_SD_EMMC_B, HHI_GCLK_MPEG0, 25),
>  	MESON_GATE(CLKID_SD_EMMC_C, HHI_GCLK_MPEG0, 26),
>  	MESON_GATE(CLKID_ETH, HHI_GCLK_MPEG1, 3),
> @@ -127,6 +128,7 @@ static struct meson_gate gates[NUM_CLKS] = {
>  	MESON_GATE(CLKID_FCLK_DIV4, HHI_FIX_PLL_CNTL1, 21),
>  	MESON_GATE(CLKID_FCLK_DIV5, HHI_FIX_PLL_CNTL1, 22),
>  	MESON_GATE(CLKID_FCLK_DIV7, HHI_FIX_PLL_CNTL1, 23),
> +	MESON_GATE(CLKID_SD_EMMC_A_CLK0, HHI_SD_EMMC_CLK_CNTL, 7),
>  	MESON_GATE(CLKID_SD_EMMC_B_CLK0, HHI_SD_EMMC_CLK_CNTL, 23),
>  	MESON_GATE(CLKID_SD_EMMC_C_CLK0, HHI_NAND_CLK_CNTL, 7),
>  	MESON_GATE(CLKID_VPU_0, HHI_VPU_CLK_CNTL, 8),
> 


Applied to u-boot-amlogic
