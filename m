Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.10852.1672835743295700314
 for <u-boot-amlogic@groups.io>;
 Wed, 04 Jan 2023 04:35:43 -0800
Received: by mail-wr1-f49.google.com with SMTP id bs20so30687148wrb.3
        for <u-boot-amlogic@groups.io>; Wed, 04 Jan 2023 04:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXLb3h4We2++awgCmOziiAnOUzxIS2OlTtXS+bQ5WI4=;
        b=BKh6EL98wpVLIQ3Yp00kCcoHePEQtJuVRXEAlLbiY9ECxLgbka4yvB7O/ATSiXoVuR
         f2ul6yqu7S1SQI0O8qiUNlBtAfT/HoB+/1ej7PniVYjDeDw/gy6lbIeHfmPf77/31fBM
         gjx7bfqpRQsf76sUwn/U+rrKzC0ZFnlophKUSc8M9X+9LzDCl+H88qAQnbDTGvULvlzp
         nC7GqBesRe1CWGOIxQUB8GgtYUEJYxyvFGKH3jQBcq57t/Lpsvs1QOxfViLmZCEwOzRd
         fiKzR2mmzGU1BtKzoZwc2kx9z4BLsrfNjLrzXZFF145xQitbb+Y2ZZnSQNyomQJYGomb
         lcXQ==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <d4b8016b-b47e-c101-d9f6-622bf166e4d9@linaro.org>
Date: Wed, 4 Jan 2023 13:35:40 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/5] doc/usage: cmd: documentation for meson/sm command
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
 <20221222125727.47893-4-avromanov@sberdevices.ru>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20221222125727.47893-4-avromanov@sberdevices.ru>
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: u-boot-amlogic@groups.io, avromanov@sberdevices.ru, narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Le 22/12/2022 à 13:57, Alexey Romanov via groups.io a écrit :

Please add a short description of the change in the commit message.

With this added:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   doc/usage/cmd/sm.rst | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 doc/usage/cmd/sm.rst
> 
> diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
> new file mode 100644
> index 00000000000..3a70c137ec9
> --- /dev/null
> +++ b/doc/usage/cmd/sm.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Meson Security Monitor command
> +==============================
> +
> +Synopis
> +-------
> +
> +::
> +
> +    sm serial <address>
> +    sm reboot_reason [name]
> +    sm efuseread <offset> <size> <address>
> +    sm efusewrite <offset> <size> <address>
> +    sm efusedump <offset> <size>
> +
> +Description
> +-----------
> +
> +The sm command is used to request services from the secure monitor. User
> +can call secure monitor to request special TEE function, for example chip
> +serial number info, reboot reason, etc.
> +
> +sm serial
> +  Retrieve chip unique serial number from sm and write it to memory on
> +  appropriate address.
> +
> +sm reboot_reason
> +  Print reboot reason to the console, if parameter [name] isn't specified.
> +  If parameter specified, set reboot reason string to environment variable
> +  with this name.
> +
> +sm efuseread
> +  Read <size> bytes starting from <offset> from efuse memory bank and write
> +  result to the address <address>.
> +
> +sm efusewrite
> +  Write into efuse memory bank, starting from <offset>, the <size> bytes
> +  of data, located at address <address>.
> +
> +Configuration
> +-------------
> +
> +To use the sm command you must specify CONFIG_CMD_MESON=y

