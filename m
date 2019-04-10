Received: by mail-wm1-f66.google.com with SMTP id y197so2946620wmd.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PUiqR/4/UBrFxrLUF5VMfuAOVpiHmrqWF6htGx4HhQM=;
        b=bcIySXf80cDYMZA7UVejwkGGnA323QOw2Ni8uMdyzVnkYKFBoRqTCA8pUMdXl/i0c1
         0akgVxPcOsVlKtEUr5dSoQ1IaGVlE/Q38bxiT6DISh0mwJsTpTw8vT6YshCoim2f0MXG
         uz1xmvNtcw5dBQo5Uy0vnSWxrBUwJo95r1MLe67ZgUcSYE2fSBDxV649eLcpuLqqrMI5
         Ec5iWsi5SEIJsy61Loci0EKaedbDsXK0NqqV4cngiTW07VYJhXTeydsQm5WEknu5tbKe
         zdMZQZ3e5vrh/HzvYVmYh9/L48/J7d05LVNYzM8xygo+lwBGXb59ViRlaDTvpvxnJobt
         oRIA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] i2c: meson: add configurable divider factors
References: <20190322134932.17103-1-glaroque@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <36dfbb7b-9f4d-4e8e-9da6-b5080c075023@baylibre.com>
Date: Wed, 10 Apr 2019 16:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190322134932.17103-1-glaroque@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Guillaume La Roque <glaroque@baylibre.com>, hs@denx.de, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 22/03/2019 14:49, Guillaume La Roque wrote:
> This patch add support for I2C controller in Meson-AXG SoC,
> Due to the IP changes between I2C controller, we need to introduce
> a compatible data to make the divider factor configurable.
> 
> backport from linux:
> 931b18e92cd0 ("2c: meson: add configurable divider factors")
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  drivers/i2c/meson_i2c.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/meson_i2c.c b/drivers/i2c/meson_i2c.c
> index 7d06d95cf3..ee59bac123 100644
> --- a/drivers/i2c/meson_i2c.c
> +++ b/drivers/i2c/meson_i2c.c
> @@ -41,7 +41,12 @@ struct i2c_regs {
>  	u32 tok_rdata1;
>  };
>  
> +struct meson_i2c_data {
> +	unsigned char div_factor;
> +};
> +
>  struct meson_i2c {
> +	const struct meson_i2c_data *data;
>  	struct clk clk;
>  	struct i2c_regs *regs;
>  	struct i2c_msg *msg;	/* Current I2C message */
> @@ -229,7 +234,7 @@ static int meson_i2c_set_bus_speed(struct udevice *bus, unsigned int speed)
>  	if (IS_ERR_VALUE(clk_rate))
>  		return -EINVAL;
>  
> -	div = DIV_ROUND_UP(clk_rate, speed * 4);
> +	div = DIV_ROUND_UP(clk_rate, speed * i2c->data->div_factor);
>  
>  	/* clock divider has 12 bits */
>  	if (div >= (1 << 12)) {
> @@ -253,6 +258,8 @@ static int meson_i2c_probe(struct udevice *bus)
>  	struct meson_i2c *i2c = dev_get_priv(bus);
>  	int ret;
>  
> +	i2c->data = (const struct meson_i2c_data *)dev_get_driver_data(bus);
> +
>  	ret = clk_get_by_index(bus, 0, &i2c->clk);
>  	if (ret < 0)
>  		return ret;
> @@ -272,11 +279,24 @@ static const struct dm_i2c_ops meson_i2c_ops = {
>  	.set_bus_speed = meson_i2c_set_bus_speed,
>  };
>  
> +static const struct meson_i2c_data i2c_meson6_data = {
> +	.div_factor = 4,
> +};
> +
> +static const struct meson_i2c_data i2c_gxbb_data = {
> +	.div_factor = 4,
> +};
> +
> +static const struct meson_i2c_data i2c_axg_data = {
> +	.div_factor = 3,
> +};
> +
>  static const struct udevice_id meson_i2c_ids[] = {
> -	{ .compatible = "amlogic,meson6-i2c" },
> -	{ .compatible = "amlogic,meson-gx-i2c" },
> -	{ .compatible = "amlogic,meson-gxbb-i2c" },
> -	{ }
> +	{.compatible = "amlogic,meson6-i2c", .data = (ulong)&i2c_meson6_data},
> +	{.compatible = "amlogic,meson-gx-i2c", .data = (ulong)&i2c_gxbb_data},
> +	{.compatible = "amlogic,meson-gxbb-i2c", .data = (ulong)&i2c_gxbb_data},
> +	{.compatible = "amlogic,meson-axg-i2c", .data = (ulong)&i2c_axg_data},
> +	{}
>  };
>  
>  U_BOOT_DRIVER(i2c_meson) = {
> 

Applied to u-boot-amlogic

Thanks
