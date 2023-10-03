Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.103411.1696317929203626252
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:25:29 -0700
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-32488a22810so569623f8f.3
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317927; x=1696922727; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQhOFoEAhUQ8MM8lzRTBmRbrIKO+On2/xFqVETc6Fsc=;
        b=fA26KDFnuqp3b1g/9lfmFc95ixwpOf4ZgbEGKleOyUwyXZInu0jSu7gsgBPn1bRh6r
         VJI9EM9jThpOjVBAOBsnCzsuYHlXY8F2Mi+CnxEGMoyfJ+uZKNWmK8B6mF/UPO8GuE8+
         H1Bqrpt4rSP/WWYXcI9SbMA81qNahWObeT7QHjey6PbRRi+UmNuucXFaTy2PedVrig8A
         zUlpjl/Fe++OM68M/oQEbvMCTHIfqe+9jk80F1eYiUzlMLCTd2hyIuNH/VkUEX22WOX2
         7/zt64VIDzovGh1bStgBh5ExobXpK43kDvd1fKPEbgVkg2FVaf+uavmCPfw1XENsbzFH
         krcw==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <090b7afc-38e0-4fda-a143-b8737e24bc0d@linaro.org>
Date: Tue, 3 Oct 2023 09:25:25 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/8] reset: add support for Amlogic A1 family
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-3-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-3-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> This patch adds reset support for the Amlogic A1 family.
> We add the structure meson_reset_drvdata, which in the future
> will allow this driver to be used for other families by declaring
> only the correct parameters reg_count and level_offset.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/reset/reset-meson.c | 42 +++++++++++++++++++++++++++++++------
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 64bc696f13..9d0c8b354f 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -13,18 +13,26 @@
>   #include <reset-uclass.h>
>   #include <regmap.h>
>   #include <linux/bitops.h>
> +#include <linux/delay.h>
>   
> -#define REG_COUNT	8
>   #define BITS_PER_REG	32
> -#define LEVEL_OFFSET	0x7c
> +
> +struct meson_reset_drvdata {
> +	unsigned int reg_count;
> +	unsigned int level_offset;
> +};
>   
>   struct meson_reset_priv {
>   	struct regmap *regmap;
> +	struct meson_reset_drvdata *drvdata;
>   };
>   
>   static int meson_reset_request(struct reset_ctl *reset_ctl)
>   {
> -	if (reset_ctl->id > (REG_COUNT * BITS_PER_REG))
> +	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
> +	struct meson_reset_drvdata *data = priv->drvdata;
> +
> +	if (reset_ctl->id > (data->reg_count * BITS_PER_REG))
>   		return -EINVAL;
>   
>   	return 0;
> @@ -33,9 +41,10 @@ static int meson_reset_request(struct reset_ctl *reset_ctl)
>   static int meson_reset_level(struct reset_ctl *reset_ctl, bool assert)
>   {
>   	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
> +	struct meson_reset_drvdata *data = priv->drvdata;
>   	uint bank = reset_ctl->id / BITS_PER_REG;
>   	uint offset = reset_ctl->id % BITS_PER_REG;
> -	uint reg_offset = LEVEL_OFFSET + (bank << 2);
> +	uint reg_offset = data->level_offset + (bank << 2);
>   	uint val;
>   
>   	regmap_read(priv->regmap, reg_offset, &val);
> @@ -64,15 +73,36 @@ struct reset_ops meson_reset_ops = {
>   	.rst_deassert = meson_reset_deassert,
>   };
>   
> +static const struct meson_reset_drvdata meson_gxbb_data = {
> +	.reg_count = 8,
> +	.level_offset = 0x7c,
> +};
> +
> +static const struct meson_reset_drvdata meson_a1_data = {
> +	.reg_count = 3,
> +	.level_offset = 0x40,
> +};
> +
>   static const struct udevice_id meson_reset_ids[] = {
> -	{ .compatible = "amlogic,meson-gxbb-reset" },
> -	{ .compatible = "amlogic,meson-axg-reset" },
> +	{
> +		.compatible = "amlogic,meson-gxbb-reset",
> +		.data = (ulong)&meson_gxbb_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-axg-reset",
> +		.data = (ulong)&meson_gxbb_data,
> +	},
> +	{
> +		.compatible = "amlogic,meson-a1-reset",
> +		.data = (ulong)&meson_a1_data,
> +	},
>   	{ }
>   };
>   
>   static int meson_reset_probe(struct udevice *dev)
>   {
>   	struct meson_reset_priv *priv = dev_get_priv(dev);
> +	priv->drvdata = (struct meson_reset_drvdata *)dev_get_driver_data(dev);
>   
>   	return regmap_init_mem(dev_ofnode(dev), &priv->regmap);
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
