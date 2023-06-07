Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.3303.1686125002317528443
 for <u-boot-amlogic@groups.io>;
 Wed, 07 Jun 2023 01:03:22 -0700
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f61530506aso70767415e9.1
        for <u-boot-amlogic@groups.io>; Wed, 07 Jun 2023 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686125000; x=1688717000;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmDY3snUqS1KGqYjrlBlc6GeUlyg5cWITIbFZdQYcCE=;
        b=MuBVV94ZhRfbNDfM4WhNsIjP9Qa3du+GVRywmA9mJug55Ip3Zq2YhH8B2m9KCqDUQn
         tch3IKYkcUYHZBKM+7JHVa8uoEse5Ib+nY7tqKyl95nTaD94IBoyASW4p/iCb4RRpIE+
         Oo4vLFQkxenxzoOjFFmmQfl6rgd+SFs6Yj9nVBJ5DGoTJDMBe19TbAHfpTIz1GJWInHI
         wiLKeIf6jPmEmSzBqFhjqdeDFXRLPIXEqc1gmu3HPIuY6F8QFoh7zpJs7YtCco6OHgTV
         1/DNJh7r8eFjBA6ds0kMlIuRa1Bkp0Kza+9iH5URr8bbvtJZXLet0dHAjpC3MosuOx9i
         yriA==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <5699d7cb-0861-a21a-2928-eb2e7e80f63d@linaro.org>
Date: Wed, 7 Jun 2023 10:03:19 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] serial: meson: fix meson_serial_pending() tx logic
References: <20230606-fix-meson-serial-pending-v1-1-6a54d4a01f76@baylibre.com>
In-Reply-To: <20230606-fix-meson-serial-pending-v1-1-6a54d4a01f76@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 06/06/2023 18:07, Mattijs Korpershoek wrote:
> According to the dm_serial_ops documentation, pending() should:
>> @return number of waiting characters, 0 for none, -ve on error
> 
> And:
>> It is acceptable to return 1 if an indeterminant number
>> of characters is waiting.
> 
> With the current implementation, we have:
> * FIFO is full           -> pending() returns 0
> * FIFO is partially used -> pending() returns 1
> * FIFO is empty          -> pending() returns 1
> 
> This is not the same as what the documentation requires.
> 
> Moreover, since [1], arm reset now flushes all console devices
> (including serial) before the cpu gets reset.
> Because of the flawed logic:
> 
>    => reset # user calls reset
>    flush() is called
>    _serial_flush() is called
>    ops->pending(dev, false) # never returns false
>    # board hangs indefinitely without resetting.
> 
> Fix it by using AML_UART_TX_EMPTY instead of AML_UART_TX_FULL.
> 
> [1] commit c5f4cdb8eb60 ("console: Use flush() before panic and reset"),
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Tested with:
> => reset # vim3 board no longer hangs
> ---
>   drivers/serial/serial_meson.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index d026f5a7a8e5..934de2ab2358 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -201,7 +201,10 @@ static int meson_serial_pending(struct udevice *dev, bool input)
>   
>   		return true;
>   	} else {
> -		return !(status & AML_UART_TX_FULL);
> +		if (status & AML_UART_TX_EMPTY)
> +			return false;
> +
> +		return true;
>   	}
>   }
>   
> 
> ---
> base-commit: a1fd9cb41fb1fda2283a089f9c97e5eed4d4940a
> change-id: 20230606-fix-meson-serial-pending-890e11467215
> 
> Best regards,

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
