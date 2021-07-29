Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.7214.1627550519778280584
 for <u-boot-amlogic@groups.io>;
 Thu, 29 Jul 2021 02:22:00 -0700
Received: by mail-wr1-f41.google.com with SMTP id c16so6012116wrp.13
        for <u-boot-amlogic@groups.io>; Thu, 29 Jul 2021 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QS6xf5H/9+2yq2x9Roj5Qok40hsDZ1EOH5hZeHHRDVU=;
        b=CVTJGd/dIO+jHRpSn4gkRTeo9xK2LGixHVZ2CCtNGlD/S5gI557d34nxKJUY6/69tx
         V/y/d+OCcapIa44iJYE99TnjJg+hGRDCQTV/nmeyqeCgaLmiobRFifWEe7IpfzCNgyT1
         Cq4oPA2dUYgir4OjSx4wV8127rwOU3I3TUeSYBVZ8ELzpgJO7Lx1/KdZAUobgmiEvB3+
         25+b8JCBIJW5Nj+2+TPsEqn5YcRWE8usTz6J1sms8v62tDF5svDfeRAeRymUPYx9ncx/
         p/ULg7nL3CC4WdUxVRSsQurPjqyDSDJLCIdzNMEJ9oq2sr5ZYMObtoV6jMeB3Jwvja4t
         48ug==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/6] configs: meson64_android: fix bad indent in EXTRA_ENV_SETTINGS
References: <20210729072113.208099-1-mkorpershoek@baylibre.com>
 <20210729072113.208099-3-mkorpershoek@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <344b228d-5042-1e72-eed1-c40a589ec5f2@baylibre.com>
Date: Thu, 29 Jul 2021 11:21:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210729072113.208099-3-mkorpershoek@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 29/07/2021 09:21, Mattijs Korpershoek wrote:
> both lines seem to be joined together which is not the case for the
> meson64.h EXTRA_ENV_SETTINGS.
> 
> Add a newline for consistency.
> 
> Signed-off-by: Guillaume La Roque <mkorpershoek@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/configs/meson64_android.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
> index c47d51c853..661de76fd7 100644
> --- a/include/configs/meson64_android.h
> +++ b/include/configs/meson64_android.h
> @@ -127,7 +127,8 @@
>  	"kernel_addr_r=0x01080000\0"                                  \
>  	"pxefile_addr_r=0x01080000\0"                                 \
>  	"ramdisk_addr_r=0x13000000\0"                                 \
> -	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" BOOTENV
> +	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"        \
> +	BOOTENV
>  
>  #include <configs/meson64.h>
>  
> 


Acked-by: Neil Armstrong <narmstrong@baylibre.com>
