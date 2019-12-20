Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web09.7360.1576836952097418588
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:15:52 -0800
Received: by mail-wm1-f67.google.com with SMTP id p9so8354634wmc.2
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z5RQbsHiHnMFTuaNtCHJej2D4i7jVchlL+p9mXHY990=;
        b=jvO/bMnZItEF6cY5poiA4s6ZdvKK916PWufXBieqVUbi7JoanNUvUagDFQ2b25sWu2
         eyW85GUvroFmtmzUZVCM45x+5EK1J1vaGVA0UeuIIaen76N6lsEg3wbi9VX4V7MqJhbK
         d4fc3NXydXPwNFeqjNyY3AySqY7fB2nChiekYFRGMCFNYDg2R1HDLTcCgIDgx8w4OZyv
         eyZNn97RyXnsZoM55y+vXaRkV7URpH1l4Y9xejwo0dW9JSiUOPL+048gsB4GPF70QZr9
         5GI60c3xQsvMNjV5kQIqlSWMCsH+TfMYeBI0ysWpxnowqSEwZniV/j0s7QJQwWL8zZtv
         EBEw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/5] clk: meson: reset mmc clock on probe
References: <20191219183620.1423118-1-jbrunet@baylibre.com>
 <20191219183620.1423118-4-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c579cb63-4400-7abe-2e05-3d31d86c0e7c@baylibre.com>
Date: Fri, 20 Dec 2019 11:15:48 +0100
MIME-Version: 1.0
In-Reply-To: <20191219183620.1423118-4-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Kevin Hilman <khilman@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

On 19/12/2019 19:36, Jerome Brunet wrote:
> On some SoCs, depending on the boot device, the MMC clock block may be
> left in a weird state by the ROM code, in which no decent clock may be
> provided. Reset the related register to make sure a sane MMC clock is
> ready for the controller.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg.c  | 7 +++++++
>  drivers/clk/meson/g12a.c | 7 +++++++
>  drivers/clk/meson/gxbb.c | 7 +++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 32cbf752aed8..0ba6c303e122 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -290,6 +290,13 @@ static int meson_clk_probe(struct udevice *dev)
>  	if (IS_ERR(priv->map))
>  		return PTR_ERR(priv->map);
>  
> +	/*
> +	 * Depending on the boot src, the state of the MMC clock might
> +	 * be different. Reset it to make sure we won't get stuck
> +	 */
> +	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
> +	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
> +
>  	debug("meson-clk-axg: probed\n");
>  
>  	return 0;
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 1b2523bbf1fe..03d885d986b8 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -976,6 +976,13 @@ static int meson_clk_probe(struct udevice *dev)
>  	if (IS_ERR(priv->map))
>  		return PTR_ERR(priv->map);
>  
> +	/*
> +	 * Depending on the boot src, the state of the MMC clock might
> +	 * be different. Reset it to make sure we won't get stuck
> +	 */
> +	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
> +	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
> +
>  	debug("meson-clk-g12a: probed\n");
>  
>  	return 0;
> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> index abb5337e7829..aedba991603f 100644
> --- a/drivers/clk/meson/gxbb.c
> +++ b/drivers/clk/meson/gxbb.c
> @@ -886,6 +886,13 @@ static int meson_clk_probe(struct udevice *dev)
>  	if (IS_ERR(priv->map))
>  		return PTR_ERR(priv->map);
>  
> +	/*
> +	 * Depending on the boot src, the state of the MMC clock might
> +	 * be different. Reset it to make sure we won't get stuck
> +	 */
> +	regmap_write(priv->map, HHI_NAND_CLK_CNTL, 0);
> +	regmap_write(priv->map, HHI_SD_EMMC_CLK_CNTL, 0);
> +
>  	debug("meson-clk: probed\n");
>  
>  	return 0;
> 

looks sane, but should be tested on other platforms to make sure
it still works.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
