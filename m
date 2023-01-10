Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.103572.1673358175489519592
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 05:42:55 -0800
Received: by mail-wm1-f47.google.com with SMTP id ay40so8820624wmb.2
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGj7p+gLO4gBrK14bQxNNeQodFcKTkyI582NtyIN5Xg=;
        b=odfcSCSx/+6fxWmzotNFmgL11pNE5FH8Nr1+h/bQm3G5D/E4BbWdp4IKrGFNzlquI4
         IuC/ZXv2t/UxdVY8u9k8ooxF+h4BFxz2FJKJYGqp7B+P8jkKyVPuwyy1fNxZlDIP8kRJ
         wVqUcghWxOjadSQt7pfyqt46vQJ6Mr7E36DHEuzOuOrIT6t+MqDyVuxAHVAKADjWFQhu
         4bFdibHueyl9kEmOTGJ8cY8Nfk4FLNyb80r7I4i0psCSgOmQUT5zjohRwjdMvSxBhT04
         yMxkb/Z6/PMQ44EWnkRrErIuLSCbs43Di8M5+KexZBzqMDr9UuNlheP9oXIsPM6+L/Np
         zd8A==
Return-Path: <mkorpershoek@baylibre.com>
From: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 5/5] doc/usage: cmd: sm: documentation efusedump cmd
In-Reply-To: <20230110105650.54580-6-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
 <20230110105650.54580-6-avromanov@sberdevices.ru>
Date: Tue, 10 Jan 2023 14:42:52 +0100
Message-ID: <875yde8q03.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Alexey Romanov <avromanov@sberdevices.ru>, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

On Tue, Jan 10, 2023 at 13:56, Alexey Romanov <avromanov@sberdevices.ru> wrote:

> Added docs about sm efusedump command, that reads bytes
> from efuse memory bank and print them to the console.
>
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  doc/usage/cmd/sm.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
> index c41227f4b3b..f6524a1c2e3 100644
> --- a/doc/usage/cmd/sm.rst
> +++ b/doc/usage/cmd/sm.rst
> @@ -38,6 +38,10 @@ sm efusewrite
>    Write into efuse memory bank, starting from <offset>, the <size> bytes
>    of data, located at address <address>.
>  
> +sm efusedump
> +  Read <size> bytes starting from <offset> from efuse memory bank and print
> +  them to the console.
> +
>  Configuration
>  -------------
>  
> -- 
> 2.25.1
