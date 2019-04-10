Received: by mail-wm1-f65.google.com with SMTP id q16so2943931wmj.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Apr 2019 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=njNaXvTUUG0SHLQxwxgOi8BUVx5zXrxkBsaoahOSIOE=;
        b=iNnJdm2xKpCsyAak66epK2B58FA7D5Rsn7Pi66NofAr45ElnhlJydJYMVPzUKRuDxR
         wd0I4KLV4J4nXQIv2lON2QovnbPgShc/dGotEwPZ9tqpbacK5YmRYCLBuIucvjKmbuwF
         HjmnKddFd5px1rbXdgd0J+Jr05PJ6pQlOgZUoMblNm+lqItFUJqTX/saS89PM8mlzb2i
         1KXgFiAtznRtFoyOufVqsSyrWn1Co6joDM5cVMchDW+YyM20CjZ3Mgn3OuS/nHnAnN6x
         zZwZEhdqs+zdMeoBoI1DVHz1FnDk98fy/a4GPZGwJpz059g8pqVGrKA9To1zrhI5YZZo
         XRzA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] reset-meson: Add AXG reset compatible
References: <20190326102544.10102-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <29b305e1-ee3f-5963-9741-22025c014838@baylibre.com>
Date: Wed, 10 Apr 2019 16:53:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190326102544.10102-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 26/03/2019 11:25, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 92f04695ec..31aa4d41e8 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -69,6 +69,7 @@ struct reset_ops meson_reset_ops = {
>  
>  static const struct udevice_id meson_reset_ids[] = {                          
>  	{ .compatible = "amlogic,meson-gxbb-reset" },                                  
> +	{ .compatible = "amlogic,meson-axg-reset" },
>  	{ }                                                                     
>  };  
>  
> 

Applied to u-boot-amlogic

Neil
