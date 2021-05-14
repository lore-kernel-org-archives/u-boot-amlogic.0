Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.10579.1621007063033688656
 for <u-boot-amlogic@groups.io>;
 Fri, 14 May 2021 08:44:23 -0700
Received: by mail-wr1-f41.google.com with SMTP id q5so10985260wrs.4
        for <u-boot-amlogic@groups.io>; Fri, 14 May 2021 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eXrnlyrt3MqDYArsVpMYKmImT4OP790ioGyEInWNnXw=;
        b=FJliVbK//yQcg5aKx1u8PqQyxHQz1Fi/lj3MikkMNgMkDsI9WiLYKYmNSjzQtOXYkH
         tAW69WecATMcFiBo7Zxy7G/FAdePvxWBLYhiEY/h/M/wqRCYJifrgJpDUqKVxqrIgx4a
         /VbsPX2bEP6Xoab/KEGrT6h/9eIs8KvpYnHjbWlXn3GWX0dXfyiGDIj3tCmMccKgrcVk
         IgcLnvMzZ7/fEXCWxQ3IAMwBsYd7SzHU5D1k/7aihKd8nmJDYQcyJHJOAQYO9NlQlJz4
         aPD/ogrHYI7ixJPbvzmAfig6VntkyZNjVXYkwkDuXQ+yYgRU+cA2jvwHnZYkQn8S340g
         h1lg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] net: dwmac_meson8b: do not set TX delay in TXID & RXID
References: <20210505075526.3838291-1-narmstrong@baylibre.com>
 <CAGi-RUKfw-VQ0MJKDJkPo6kOOGkKVfMqzrX86tK47REx9tdLww@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <286d5df2-7a32-6b76-af61-bd9b72f5955b@baylibre.com>
Date: Fri, 14 May 2021 17:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAGi-RUKfw-VQ0MJKDJkPo6kOOGkKVfMqzrX86tK47REx9tdLww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, martin.blumenstingl@googlemail.com
List-ID: <u-boot-amlogic@groups.io>

On 05/05/2021 20:47, Ramon Fried wrote:
> On Wed, May 5, 2021 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> When the PHY interface is set as TXID & RXID, the delays should be taken from DT,
>> but first they should not be hardcoded since the PHY driver will set them.
>>
>> Fixes: 798424e857 ("net: designware: add Amlogic Meson8b & later glue driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/net/dwmac_meson8b.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
>> index c0b6ef4994..40cd8370b0 100644
>> --- a/drivers/net/dwmac_meson8b.c
>> +++ b/drivers/net/dwmac_meson8b.c
>> @@ -59,8 +59,6 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
>>         switch (edata->phy_interface) {
>>         case PHY_INTERFACE_MODE_RGMII:
>>         case PHY_INTERFACE_MODE_RGMII_ID:
>> -       case PHY_INTERFACE_MODE_RGMII_RXID:
>> -       case PHY_INTERFACE_MODE_RGMII_TXID:
>>                 /* Set RGMII mode */
>>                 setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
>>                                                      AXG_ETH_REG_0_TX_PHASE(1) |
>> @@ -69,6 +67,15 @@ static int dwmac_setup_axg(struct udevice *dev, struct eth_pdata *edata)
>>                                                      AXG_ETH_REG_0_CLK_EN);
>>                 break;
>>
>> +       case PHY_INTERFACE_MODE_RGMII_RXID:
>> +       case PHY_INTERFACE_MODE_RGMII_TXID:
>> +               /* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
>> +               setbits_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RGMII |
>> +                                                    AXG_ETH_REG_0_TX_RATIO(4) |
>> +                                                    AXG_ETH_REG_0_PHY_CLK_EN |
>> +                                                    AXG_ETH_REG_0_CLK_EN);
>> +               break;
>> +
>>         case PHY_INTERFACE_MODE_RMII:
>>                 /* Set RMII mode */
>>                 out_le32(plat->regs + ETH_REG_0, AXG_ETH_REG_0_PHY_INTF_RMII |
>> @@ -90,8 +97,6 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
>>         switch (edata->phy_interface) {
>>         case PHY_INTERFACE_MODE_RGMII:
>>         case PHY_INTERFACE_MODE_RGMII_ID:
>> -       case PHY_INTERFACE_MODE_RGMII_RXID:
>> -       case PHY_INTERFACE_MODE_RGMII_TXID:
>>                 /* Set RGMII mode */
>>                 setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
>>                                                      GX_ETH_REG_0_TX_PHASE(1) |
>> @@ -101,6 +106,16 @@ static int dwmac_setup_gx(struct udevice *dev, struct eth_pdata *edata)
>>
>>                 break;
>>
>> +       case PHY_INTERFACE_MODE_RGMII_RXID:
>> +       case PHY_INTERFACE_MODE_RGMII_TXID:
>> +               /* TOFIX: handle amlogic,tx-delay-ns & rx-internal-delay-ps from DT */
>> +               setbits_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_PHY_INTF |
>> +                                                    GX_ETH_REG_0_TX_RATIO(4) |
>> +                                                    GX_ETH_REG_0_PHY_CLK_EN |
>> +                                                    GX_ETH_REG_0_CLK_EN);
>> +
>> +               break;
>> +
>>         case PHY_INTERFACE_MODE_RMII:
>>                 /* Set RMII mode */
>>                 out_le32(plat->regs + ETH_REG_0, GX_ETH_REG_0_INVERT_RMII_CLK |
>> --
>> 2.25.1
>>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> 


Thanks,

Applied to u-boot-amlogic,

Neil

