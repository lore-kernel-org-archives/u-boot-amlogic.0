Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10858.1672835770155003065
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:36:10 -0800
Received: by mail-wm1-f52.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so26302062wms.4
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGmATZ2O7B2PzpSeMSASFtLWAklaNVEUSI2g1xFCWQ8=;
        b=rBisXMgmRMXL7LzAzzLP/TCv8uI38tFJxF+PenDJySK6wPIokoS5wqPmHr0EEZwNbX
         /lb27mZ0x8W0Ezfwcnh958hZb+vD+9+UXKbFt82FExFpjfJJGNMeEqkdMI9o66WKJCWO
         CUG3o69w79UaEPOPPD1gbpXbfOnzdmzma/wu9XG9NaJGfG4O8UbGXKVvn6i5+oAjdYap
         43VvUDEmWwuYYUhTcxtby8IJCupKX57QA9pmS6pSGFobTyzsuO1Vek9ZPoKvIjk4SQpg
         +niIPHKo3GMXnhRokc8J2zXs4Q8Yb9akg8TpMnyc//yZLL3JEsfWiH7N9h0fgXywpCgG
         OD1A==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <e6dfc557-1a36-c0b0-70d3-fbbca534dbe0@linaro.org>
Date: Wed, 4 Jan 2023 13:36:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] doc/usage: cmd: sm: documentation efusedump cmd
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-6-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222125727.47893-6-avromanov@sberdevices.ru>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Le 22/12/2022 à 13:57, Alexey Romanov via groups.io a écrit :

Same here, add a short description.

With that:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   doc/usage/cmd/sm.rst | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
> index 3a70c137ec9..beb53b3f46d 100644
> --- a/doc/usage/cmd/sm.rst
> +++ b/doc/usage/cmd/sm.rst
> @@ -38,6 +38,10 @@ sm efusewrite
>     Write into efuse memory bank, starting from <offset>, the <size> bytes
>     of data, located at address <address>.
>   
> +sm efusedump
> +  Read <size> bytes starting from <offset> from efuse memory bank and print
> +  them to the console.
> +
>   Configuration
>   -------------
>   
