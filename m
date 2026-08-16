Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BDC61DB9
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:25 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7851.1786877377054534485
 for <u-boot-amlogic@groups.io>;
 Sun, 16 Aug 2026 03:49:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: tanurelinux@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a37a2b7000so2946194a12.2
        for <u-boot-amlogic@groups.io>; Sun, 16 Aug 2026 03:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786877375; x=1787482175;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qIqtk3+OKTaS6CZOGcaGLjVT9i7tgzbV7HjiaxEBHk=;
        b=F5+hCghK5pG2U72PbilfXjhv0lzpTv/UJLzBkQ83sG0HEMA6wyNRDse4wHvqHiR42C
         WWYLpeI7rTk2bGfq33AZ7JEr2zbowJl1sAo8bUxsVZXWWk+nNyRJTmuT3Ex8Y/baT90+
         gCPQmtln0v4MJzk5IQ2toSYb54VLGZSy8rxFCCmQYbnPSxyoZ69AQ8y22FMsOHx4VVx1
         Pn8lk0C28U9CWELnPgD//yTUEOH9BcKZSGZ4EaZXq4/jwonqcZQHdqpNNVMDCy5kHlLq
         LD+f5e3ftxiVm15cEzQvlP61JyCjtI8m14pUma0GG7hxQtGiv7E9RkesfF6y25P6Qx/s
         iGSA==
X-Forwarded-Encrypted: i=1; AHgh+RotEHhevBt//i5g4Kr2gsqh8XnLRiGlL+ZexUdzaxAUDDChpKkhqZBabYu3LBDaHrCX2F3TM9/WEszihEIPyA==@groups.io
X-Gm-Message-State: AOJu0YzOKwoWAxhFely08i6RgrIws2qWhjvWxyWt7ojOTGx/N6AQEOtV
	2GEMETGpB5k7emhe4/NBe+TeKXogEqNTzCxn3u0wTgkDKsbVBdgJUigZuyTcaw==
X-Gm-Gg: AR+sD11GpqcHlDAi8gOuMyEqlhsHUlqI6Nktj/+4UiMLV/dO0gr4Oe519E/yUj7f52F
	54WTbwj/dWgoZn5LeketF/K8g8ctplvqQZVqpMxrBQ3/BkpUxMlhMPDIbEocRDca1UKKI0L/VDT
	SwpKD2q6lQj8oK59qFpkC4vopS5zWwx2Nyh1l8nqTW7jfSM9ucULE2FQH2kdEPV1gInsUHcj4of
	VMCDbtWcYCYokLxbdHdvvx219F/Qli5jVyK6tos5MnvtGUVRdHmDmhBDz/3+AqAWy40zb2R1xm3
	hWvn3wh5ZaR2WE69tj978At2U4nAIP8cvtGMaqDJhLneIitOwyo0HewH6nYSZmbdJ3dTERYBVuB
	H/wo8hyqEWYOVlRb/skyh5Y1eXHlO/clf8+CKOyJC883VCbGcT6KinX4jDqyVXycvaone7yD+sY
	j1q8sGlYFHAL4rB/5wdj/7qIPB4Wp8TQXOoc3XOJ+9Dh/moBKsVs2dYFwnHCK8ADZhTy7LoUo5L
	FB53x9+qtlP5sp4aqPnvQ==
X-Received: by 2002:a05:600c:828c:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-49989345963mr255109655e9.10.1786876967129;
        Sun, 16 Aug 2026 03:42:47 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ddaesm50443565e9.7.2026.08.16.03.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 03:42:45 -0700 (PDT)
Message-ID: <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
Date: Sun, 16 Aug 2026 11:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <tjk4ry.249pxi1g19ygb@postmarketos.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3027

On 10/08/2026 15:01, Ferass El Hafidi wrote:
> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" 
> <tanure=linux.com@groups.io> wrote:
>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>> baud rate register, while older SoCs divide the crystal by 3. Add the
>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>> the configuration the vendor BL2 programs on T7 hardware.
>>
>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>> div-by-2 on G12A, but both modes work there and switching would risk
>> regressing boards that have shipped with div-by-3 for years.
>>
>> Also drain the transmitter before changing the baud rate so in-flight
>> characters are not garbled, as the Linux driver does.
>>
>> Assisted-by: Claude:claude-fable-5
> 
> As I understand it, LLM-assisted patches are not welcome in U-Boot right
> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-cat/
> 
> AFAIK there isn't an official AI policy yet, but it seems the concensus
> on that matter is currently "please don't". Sorry.

Ok, I will drop this line.

> 
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>> drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
>> 1 file changed, 38 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/ 
>> serial_meson.c
>> index cc71381f87e..d909fedcfc4 100644
>> --- a/drivers/serial/serial_meson.c
>> +++ b/drivers/serial/serial_meson.c
>> @@ -62,26 +62,49 @@ struct meson_serial_plat {
>> #define AML_UART_REG5_USE_NEW_BAUD    BIT(23) /* default 1 (use new 
>> baud rate register) */
>> #define AML_UART_REG5_BAUD_MASK        0x7fffff
>>
>> +/* Driver data flags */
>> +#define MESON_UART_XTAL_DIV2    BIT(0)
>> +
>> #if CONFIG_IS_ENABLED(DM_SERIAL)
>> -static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>> +static u32 meson_uart_xtal_div(struct udevice *dev)
>> +{
>> +    /*
>> +     * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
>> +     * crystal divided by 2, older ones divide by 3.
>> +     */
>> +    return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
>> +}
>> +
>> +static u32 meson_calc_baud_divisor(struct udevice *dev, ulong 
>> src_rate, u32 baud)
>> {
>>     /*
>>      * Usually src_rate is 24 MHz (from crystal) as clock source for 
>> serial
>> -     * device. Since 8 Mb/s is the maximum supported baud rate, use 
>> div by 3
>> -     * to derive baud rate. This choice is used also in 
>> meson_serial_setbrg.
>> +     * device. Since 8 Mb/s is the maximum supported baud rate, use a
>> +     * divided crystal to derive the baud rate. This choice is used 
>> also in
>> +     * meson_serial_setbrg.
>>      */
>> -    return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
>> +    return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), 
>> baud) - 1;
>> }
>>
>> -static void meson_serial_set_baud(struct meson_uart *uart, ulong 
>> src_rate, u32 baud)
>> +static void meson_serial_set_baud(struct udevice *dev, struct 
>> meson_uart *uart,
>> +                  ulong src_rate, u32 baud)
>> {
>>     /*
>> -     * Set crystal divided by 3 (regardless of device tree clock 
>> property)
>> +     * Set the divided crystal (regardless of device tree clock 
>> property)
>>      * as clock source and the corresponding divisor to approximate baud
>>      */
>> -    u32 divisor = meson_calc_baud_divisor(src_rate, baud);
>> +    u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
>>     u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
>>         (divisor & AML_UART_REG5_BAUD_MASK);
>> +
>> +    if (meson_uart_xtal_div(dev) == 2)
>> +        val |= AML_UART_REG5_XTAL_DIV2;
>> +
>> +    /* Drain the transmitter before changing the baud rate */
>> +    while ((readl(&uart->status) & (AML_UART_TX_EMPTY | 
>> AML_UART_XMIT_BUSY))
>> +           != AML_UART_TX_EMPTY)
>> +        ;
>> +
>>     writel(val, &uart->reg5);
>> }
>>
>> @@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
>>         return ret;
>>     ulong rate = clk_get_rate(&per_clk);
>>
>> -    meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
>> +    meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
>>     meson_serial_init(uart);
>>
>>     return 0;
>> @@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice 
>> *dev, const int baud)
>> {
>>     /*
>>      * Change device baud rate if baud is reasonable (considering a 23 
>> bit
>> -     * counter with an 8 MHz clock input) and the actual baud
>> -     * rate is within 2% of the requested value (2% is arbitrary).
>> +     * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock 
>> input)
>> +     * and the actual baud rate is within 2% of the requested value 
>> (2% is
>> +     * arbitrary).
>>      */
>>     if (baud < 1 || baud > 8000000)
>>         return -EINVAL;
>> @@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice 
>> *dev, const int baud)
>>     if (ret)
>>         return ret;
>>     ulong rate = clk_get_rate(&per_clk);
>> -    u32 divisor = meson_calc_baud_divisor(rate, baud);
>> -    u32 calc_baud = (rate / 3) / (divisor + 1);
>> +    u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
>> +    u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
>>     u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - 
>> baud;
>>
>>     if (((calc_err * 100) / baud) > 2)
>>         return -EINVAL;
>>
>> -    meson_serial_set_baud(uart, rate, baud);
>> +    meson_serial_set_baud(dev, uart, rate, baud);
>>
>>     return 0;
>> }
>> @@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
>>     { .compatible = "amlogic,meson-uart" },
>>     { .compatible = "amlogic,meson-gx-uart" },
>>     { .compatible = "amlogic,meson-a1-uart" },
>> +    { .compatible = "amlogic,meson-s4-uart", .data = 
>> MESON_UART_XTAL_DIV2 },
>>     { }
>> };
>>
>> -- 
>> 2.55.0
> 
> Best regards,
> Ferass


