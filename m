Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.102970.1696317952326906571
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 00:25:52 -0700
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so613644f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 03 Oct 2023 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696317951; x=1696922751; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRpSIp615rSgorl7ZN5XH35mOJr2XFYUgEk86KUPY44=;
        b=iYt6e+LfOPHQckHFLHq+Ke7AJiwc8deSQZIfPzNCWtTDJ6KH1cH59BoBhTYGbW+NpL
         dbmvELGh8yk0KbJJHk7I+XanZAo4yxj4xqWhpZ6wyZK5qVqaVrH5eVTQZecogAHP6mUu
         OO1HZ/zA7G90wmvYaupdsjyrk8WSK5qRXISCeaWvXYkOOjjuEwhTH0Ga5efJ0I8s2LWA
         ZO9y2wjofLygQpEEuL1i9kB6WSwuq4HchVzLjVHIyvZvT2I7pLE05Hw03Wuv37vZ6ADq
         wIQvtn30SXbqutTC51qeRKdQR15i+MWTjIsaK1Qcd5ciqKeFcdCZfwPRDrNuPR+4W2sw
         h32Q==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <c4e8ac42-cef6-442d-8d0f-ea91a34cc6e0@linaro.org>
Date: Tue, 3 Oct 2023 09:25:48 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/8] phy: move clk enable/disable in init/exit
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-5-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-5-avromanov@salutedevices.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2023 18:58, Alexey Romanov wrote:
> It is better to place clk_enable() in phy_meson_g12a_usb2_init()
> and clk_disable() in phy_meson_g12a_usb2_exit().
> 
> For more detailed information, please see comments in the review of
> a similar driver in the Linux Kernel:
> 
> https://lore.kernel.org/all/CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com/
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/phy/meson-g12a-usb2.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
> index 2e366b16ae..7b028784a0 100644
> --- a/drivers/phy/meson-g12a-usb2.c
> +++ b/drivers/phy/meson-g12a-usb2.c
> @@ -160,6 +160,14 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(CLK)
> +	ret = clk_enable(&priv->clk);
> +	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> +		pr_err("failed to enable PHY clock\n");
> +		return ret;
> +	}
> +#endif
> +
>   	ret = reset_assert(&priv->reset);
>   	udelay(1);
>   	ret |= reset_deassert(&priv->reset);
> @@ -252,6 +260,10 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
>   	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> +#if CONFIG_IS_ENABLED(CLK)
> +	clk_disable(&priv->clk);
> +#endif
> +
>   	ret = reset_assert(&priv->reset);
>   	if (ret)
>   		return ret;
> @@ -289,13 +301,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
>   	ret = clk_get_by_index(dev, 0, &priv->clk);
>   	if (ret < 0)
>   		return ret;
> -
> -	ret = clk_enable(&priv->clk);
> -	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
> -		pr_err("failed to enable PHY clock\n");
> -		clk_free(&priv->clk);
> -		return ret;
> -	}
>   #endif
>   
>   	return 0;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
