Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.6786.1619164617555785134
 for <u-boot-amlogic@groups.io>;
 Fri, 23 Apr 2021 00:56:58 -0700
Received: by mail-wr1-f52.google.com with SMTP id w4so43656394wrt.5
        for <u-boot-amlogic@groups.io>; Fri, 23 Apr 2021 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QGeGQ/LWvXn4Gxzu+DjgKujEqvIXxJY0IYH14pwM4Lg=;
        b=FODX5v8yd9NGD00hgJgaPngBoQbu/QQUol/UGTeHbJlkw+qLw+99bVgXMg6wpbFDcq
         +8KH9OZjSvy0Gj6XLd3CW5XwZ5txcZ//FAwZpvTEbGJQuqrwkADSn1irwwaRAZY2eL2c
         N89aOCJ3zmsSkPVMXUCnRYHS4NQ8tkUjVKytwKLeAIgIVvQThIWWbyJx/Zfllwd5P4RF
         RdaxaxSkp7kRTx93R7SfIqgYbpHgY7qMsnuCQn8S1mqfRZM3c89c7MqLjPim0FoYuKTU
         Yf5ytk3QqYTVIxSz13TY5JBXsftYmNEutqiLUXQZf46zfzTLFPK36B6rXDh4w3cdH9ge
         W0gg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: designware: fix PHY reset with DM_MDIO
References: <20210421085801.3100215-1-narmstrong@baylibre.com>
 <CAGi-RU+ojgv=VE6p3nK0Qso3ZpDKHqd9HAhgxRH9r_1hmyu2fA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <a07c6327-ac90-ecc9-1adf-f06cee2f79d0@baylibre.com>
Date: Fri, 23 Apr 2021 09:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <CAGi-RU+ojgv=VE6p3nK0Qso3ZpDKHqd9HAhgxRH9r_1hmyu2fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Mark Kettenis <mark.kettenis@xs4all.nl>
List-ID: <u-boot-amlogic@groups.io>

On 23/04/2021 02:12, Ramon Fried wrote:
> On Wed, Apr 21, 2021 at 11:58 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The dw_eth_pdata is not accessible from the mdio device, it gets the mdio bus plat
>> leading to random sleeps (-10174464 on Odroid-HC4).
>>
>> This moves the dw_mdio_reset function to a common one taking the ethernet
>> device as parameter and use it from the dw_mdio_reset and dm_mdio variant functions.
>>
>> Fixes: 5160b4567c net: designware: add DM_MDIO support
>> Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/net/designware.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
>> index b8ba00b7c0..5d92257e74 100644
>> --- a/drivers/net/designware.c
>> +++ b/drivers/net/designware.c
>> @@ -91,9 +91,8 @@ static int dw_mdio_write(struct mii_dev *bus, int addr, int devad, int reg,
>>  }
>>
>>  #if defined(CONFIG_DM_ETH) && CONFIG_IS_ENABLED(DM_GPIO)
>> -static int dw_mdio_reset(struct mii_dev *bus)
>> +static int __dw_mdio_reset(struct udevice *dev)
>>  {
>> -       struct udevice *dev = bus->priv;
>>         struct dw_eth_dev *priv = dev_get_priv(dev);
>>         struct dw_eth_pdata *pdata = dev_get_plat(dev);
>>         int ret;
>> @@ -122,6 +121,13 @@ static int dw_mdio_reset(struct mii_dev *bus)
>>
>>         return 0;
>>  }
>> +
>> +static int dw_mdio_reset(struct mii_dev *bus)
>> +{
>> +       struct udevice *dev = bus->priv;
>> +
>> +       return __dw_mdio_reset(dev);
>> +}
>>  #endif
>>
>>  #if IS_ENABLED(CONFIG_DM_MDIO)
>> @@ -142,9 +148,10 @@ int designware_eth_mdio_write(struct udevice *mdio_dev, int addr, int devad, int
>>  #if CONFIG_IS_ENABLED(DM_GPIO)
>>  int designware_eth_mdio_reset(struct udevice *mdio_dev)
>>  {
>> -       struct mdio_perdev_priv *pdata = dev_get_uclass_priv(mdio_dev);
>> +       struct mdio_perdev_priv *mdio_pdata = dev_get_uclass_priv(mdio_dev);
>> +       struct udevice *dev = mdio_pdata->mii_bus->priv;
>>
>> -       return dw_mdio_reset(pdata->mii_bus);
>> +       return __dw_mdio_reset(dev->parent);
>>  }
>>  #endif
>>
>> --
>> 2.25.1
>>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> 

Thanks,
Applied to u-boot-amlogic

