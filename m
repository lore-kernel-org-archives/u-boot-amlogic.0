Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.38442.1601913723181170636
 for <u-boot-amlogic@groups.io>;
 Mon, 05 Oct 2020 09:02:04 -0700
Received: by mail-wr1-f66.google.com with SMTP id n18so2387767wrs.5
        for <u-boot-amlogic@groups.io>; Mon, 05 Oct 2020 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdr10IkcxALZs5Lr73ElWl9ufOp10e6DKH/O/nbK3TI=;
        b=SEVG70HdpnAUOjCYNTR7qkitMzSUSNfRiHBKJnclfxHnFZ9hep4b6lxN0riuWEDWC8
         bS5mIqx230isoWKlMtd2woccVgvAQrbBlvaorNyDkJX0tebX4Xab7VbujMf58JZzTWBS
         0kmnB3SLCDMpwFxpu0qNyf4OzdH9TWnOwpBD5PlMPgYZnNMgOwcuBDYtmmlfbxINth6p
         C3lVR1g837zvGKp58Gtg8MgII9zMlhiaZAJdjSh0O8jn+qNejzU5yI+g9pve9OWUG50S
         4Q8d3K/lSeigTinOHrJDFlVx6hyrcFFxHu3hFxoxvWoecVfnJIgBrV2SCGfHmycdJOQs
         w6nQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] pinctrl: meson-axg-pmx: fix gpio request
References: <20201002090540.1022341-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a4dd074f-1ce0-08f5-96af-8528ccb7d73b@baylibre.com>
Date: Mon, 5 Oct 2020 18:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <20201002090540.1022341-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 02/10/2020 11:05, Neil Armstrong wrote:
> The AXG pmx driver gpio request offset needs the pin base to have the
> correct pin number.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> index c6cb941d0a..cfe94cf9e1 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
> @@ -165,7 +165,10 @@ const struct pinctrl_ops meson_axg_pinctrl_ops = {
>  static int meson_axg_gpio_request(struct udevice *dev,
>  				  unsigned int offset, const char *label)
>  {
> -	return meson_axg_pmx_update_function(dev->parent, offset, 0);
> +	struct meson_pinctrl *priv = dev_get_priv(dev->parent);
> +
> +	return meson_axg_pmx_update_function(dev->parent,
> +					     offset + priv->data->pin_base, 0);
>  }
>  
>  static const struct dm_gpio_ops meson_axg_gpio_ops = {
> 

Applied both to u-boot-amlogic

Neil
