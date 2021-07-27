Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.8534.1627374599389694571
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:30:00 -0700
Received: by mail-wm1-f49.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so1733109wmq.2
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T49yyFD3Meqc61vJ1Z42JLkWqV2sb8It9/WAU00vzSs=;
        b=EWYRnghNwIRrK+rrYWrSlmvsZmcBpOTdFqwT+AzVioLder0M3uysmOIydinywIS9vS
         PK6YvwUF9duS4B/iD8mrlF33xPBq00qDdWAkSiphzLk//2qmv89thJUWWZJSIcjP8V9Q
         rRX+KSucGXHGzUcO4KkH7c13aiP53w0sfAbt16OTsuTKtrOOgFRYE3nySQ/59csIT8xb
         zMx4ZXk8S8BiqkjwvvA7jUm0q9YgkPvhhNnmaMVNgHCLW2w1PQLv7SNMrtyw5vKifLQ6
         l3MhmhDus7vihI054UltmYiY0CLOMwYBgte9PLOWWERsW9mS86f94SO+VXcdyzEIQWTA
         0oiQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] board: amlogic: vim3: fix phy-names property setup
References: <20210713064847.2468652-1-art@khadas.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5a4f5e9f-cc76-2795-4761-5c85a00f9ccf@baylibre.com>
Date: Tue, 27 Jul 2021 10:29:56 +0200
MIME-Version: 1.0
In-Reply-To: <20210713064847.2468652-1-art@khadas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Artem Lapkin <email2tema@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, khilman@baylibre.com, christianshewitt@gmail.com, martin.blumenstingl@googlemail.com, art@khadas.com, nick@khadas.com, gouwa@khadas.com
List-ID: <u-boot-amlogic@groups.io>

On 13/07/2021 08:48, Artem Lapkin wrote:
> phy-names was improperly implemented resulting in an inoperable USB-OTG
> port.
> 
> - phy-names = "usb2-phy0\0\0usb2-phy1\0";
> + phy-names = "usb2-phy0\0usb2-phy1";
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  board/amlogic/vim3/vim3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
> index c8ebd676..6a67a39c 100644
> --- a/board/amlogic/vim3/vim3.c
> +++ b/board/amlogic/vim3/vim3.c
> @@ -109,8 +109,8 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
>  		}
>  
>  		/* Update PHY names (mandatory to disable USB3.0) */
> -		len = strlcpy(data, "usb2-phy0", 32) + 1;
> -		len += strlcpy(&data[len], "usb2-phy1", 32 - len) + 1;
> +		len = strlcpy(data, "usb2-phy0", 32);
> +		len += strlcpy(&data[len], "usb2-phy1", 32 - len);
>  		ret = fdt_setprop(blob, node, "phy-names", data, len);
>  		if (ret < 0) {
>  			printf("vim3: failed to update usb phy names property (%d)\n", ret);
> 


Applied to u-boot-amlogic,

Thanks,
Neil
