Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.3789.1622101399825873525
 for <u-boot-amlogic@groups.io>;
 Thu, 27 May 2021 00:43:20 -0700
Received: by mail-wr1-f48.google.com with SMTP id x7so3630915wrt.12
        for <u-boot-amlogic@groups.io>; Thu, 27 May 2021 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHH9jvJyBEVG+kzt1GL8TcSGJK06GyFqIORdBj0oVMk=;
        b=Ue0C4YekmwtaIcDg542K5hKi0JRyfzhG4TGIEXQdhoRO7YNrwTmoafbm+CBMyH1PCs
         nKcSOtpu9hOSNG/mStD1e5zeGw+ptlhGqde66W1JfCJRKAemeC8hYrh/u/mfiXyf2mG6
         kRaoh/cf9q7DkLuJNGI/PybkFz5Do00vAHgYaKSpjkDKeZrPKEniOVYmVYuKGwTnKMD/
         l7blWFyBOYR4qEG5+dLv5lwZPAL2SL0Q7r2iKB0oRCTxn9BJW6IihoB2VqctIaqKjNp9
         rbWEJiqYdHbZtKcV53nm/v7xqdO3e7Z0Xr/wQvVSpgjuebJbdtICvNlugLBjfiQ+q0sU
         BICg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] VIM3: mmc_get_env_dev correct non emmc boot sources
References: <20210527073528.87293-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <20a598ac-6abf-82d9-2595-b2f6c6113039@baylibre.com>
Date: Thu, 27 May 2021 09:43:16 +0200
MIME-Version: 1.0
In-Reply-To: <20210527073528.87293-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, m.szyprowski@samsung.com, christianshewitt@gmail.com, jh80.chung@samsung.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 27/05/2021 09:35, Artem Lapkin wrote:
> need return -1 if boot source is not EMMC or SD ( for example it will be
> useful if we have multy env sources configuration and device was booted
> from SPI flash and env need read from SPI not from mmc )
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index 6cd5f2e1..71aaa0d8 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -19,9 +19,15 @@
>  
>  int mmc_get_env_dev(void)
>  {
> -	if (meson_get_boot_device() == BOOT_DEVICE_EMMC)
> +	switch (meson_get_boot_device()) {
> +	case BOOT_DEVICE_EMMC:
>  		return 2;
> -	return 1;
> +	case BOOT_DEVICE_SD:
> +		return 1;
> +	default:
> +		/* boot device is not EMMC|SD */
> +		return -1;
> +	}
>  }
>  
>  /*
> 

Looks fine, I'll let other comment on it and apply it if it's ok for everyone,

Neil
