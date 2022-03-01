Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.7692.1646140131154166644
 for <u-boot-amlogic@groups.io>;
 Tue, 01 Mar 2022 05:08:51 -0800
Received: by mail-wm1-f45.google.com with SMTP id y5so7510898wmi.0
        for <u-boot-amlogic@groups.io>; Tue, 01 Mar 2022 05:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PF/psHT0P6qUkXH31UF5ytx5lH5qmDGs2zST/dHF9sQ=;
        b=p0iCNkt0K0bP5LIgky+OLB49lMjUL4WCkLiSpsnehOwHrlFSw7KnhT+u1v30P5GT2x
         Cj92qdUcax+sHOxJeVKs7M+Kvi3Q6TIwKTWg2YMr+gqHvTA3ZgkWzBWhfZuRbTiO0RIa
         p1AoX4qWBrBn1HDWMH/k7AO2uEQJylu0gFZEjzi0ktNyRbQa7bkWkQFVCZ2GWlmh7qOx
         BK2r/V6VGS+t32di5wErFuZXwdcqmW0Yf15JspL/cWSdKrV97E5tsZoBHgCH/TugTbTO
         KxSmAiBCzJq0lMvJVc9JVWnecmOxbtbf0a+6PLFy8/6VJf774wNuD2jFE58xKM2daiIj
         JcOQ==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <176e0d79-56c3-e31a-f204-f477417ddafc@baylibre.com>
Date: Tue, 1 Mar 2022 14:08:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drivers: adc: fix return value if timeout occurs
References: <HE1P192MB00097C66713AB8FE99E5E904DA029@HE1P192MB0009.EURP192.PROD.OUTLOOK.COM>
 <CAOf5uwnRCYBichDESuvJAxRUyH2vQm4ph_eXOdBVC46xp1DBJw@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <CAOf5uwnRCYBichDESuvJAxRUyH2vQm4ph_eXOdBVC46xp1DBJw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 01/03/2022 13:48, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Tue, Mar 1, 2022 at 1:38 PM Francois Berder <fberder@outlook.fr> wrote:
>>
>> Because unsigned integers cannot be negative,
>> timeout variable is never less than zero. Hence, checks
>> in Amlogic Meson ADC driver to detect timeouts always
>> evaluated to false. Fix that.
>>
>> Signed-off-by: Francois Berder <fberder@outlook.fr>
>> ---
>>
>>   drivers/adc/meson-saradc.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/adc/meson-saradc.c b/drivers/adc/meson-saradc.c
>> index 1a45a3a265..a48200a769 100644
>> --- a/drivers/adc/meson-saradc.c
>> +++ b/drivers/adc/meson-saradc.c
>> @@ -192,7 +192,8 @@ meson_saradc_get_fifo_count(struct meson_saradc_priv *priv)
>>
>>   static int meson_saradc_lock(struct meson_saradc_priv *priv)
>>   {
>> -       uint val, timeout = 10000;
>> +       uint val;
>> +       int timeout = 10000;
>>
>>          /* prevent BL30 from using the SAR ADC while we are using it */
>>          regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>> @@ -246,7 +247,8 @@ static int meson_saradc_calib_val(struct meson_saradc_priv *priv, int val)
>>
> 
> Can you use regmap_read_poll_timeout?

Good point, it's weird I haven't use it at submission.

Neil

> 
> Michael
> 
>>   static int meson_saradc_wait_busy_clear(struct meson_saradc_priv *priv)
>>   {
>> -       uint regval, timeout = 10000;
>> +       uint regval;
>> +       int timeout = 10000;
>>
>>          /*
>>           * NOTE: we need a small delay before reading the status, otherwise
>> --
>> 2.30.1 (Apple Git-130)
>>
> 
> 

