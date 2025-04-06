Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DCC369A3
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by mx.groups.io with SMTP id smtpd.web11.33221.1743975399505095486
 for <u-boot-amlogic@groups.io>;
 Sun, 06 Apr 2025 14:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kwiboo.se header.s=fe-e1b5cab7be header.b=lC72ChQK;
 spf=pass (domain: fe-bounces.kwiboo.se, ip: 149.28.215.223, mailfrom: srs0=13a0=wz=kwiboo.se=jonas@fe-bounces.kwiboo.se)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743975399;
 bh=LhF8iIruZIjXTXahS3CyXouER0wMXyq0Mx+1/q4IJOU=;
 b=lC72ChQKw0SM3f1rKQEmkq3ZtTWIEWCnyvBoc8Q3vRqT4pbykuOIDzR9aCuLlHPOUj3mWWBjA
 oCun0Y2ljCJN86snJVP1lC/5Hfx9zLKidzjFfpVdRYKesqWYjpBV0o+/XdQzSDQ3ZovcqjiQaOQ
 pSxFz4oIQgAmPEKQnM7yfmO5bMP7Rw//mZiG6XMPe0iAMH8RnnscsSl31fgiZ4A1YCRm1KNfHhj
 5zc3O5GtmO6Aj8OvP85v+3ik+zJZO+9kwhLleN+3gcpkDL/A56ikSW9CNVcuG9byfjuxr+BOvmo
 wOGGrVhffAlqS/k+amGBYyRDf0DRErJM88qgSnqqR5Og==
X-Forward-Email-ID: 67f2f3e290f253d89dba0fd0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <a1026fc5-de0c-4a88-891e-1bdb5b98b705@kwiboo.se>
Date: Sun, 6 Apr 2025 23:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] designware: Use the remove() method with related drivers
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot-amlogic@groups.io
References: <20250405221308.498047-1-sjg@chromium.org>
 <20250405221308.498047-2-sjg@chromium.org>
 <dc4dec57-6fba-4224-9f84-1cc63c58eacd@kwiboo.se>
 <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTim=Fq9rv0BfypZoje=i+HU_ZTdFK_GSQoZSsESWm=Jqg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2658

Hi Simon,

On 2025-04-06 23:10, Simon Glass wrote:
> Hi Jonas,
> 
> On Sun, 6 Apr 2025 at 21:02, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 2025-04-06 00:12, Simon Glass wrote:
>>> Several drivers make use of the designware Ethernet driver but do not
>>> implement the remove() method. Add this so that DMA is stopped when the
>>> OS is booted to avoid memory corruption, etc.
>>
>> The designware Ethernet driver core should not need the remove() ops as
>> the eth_ops.stop() ops already should stop DMA. And the eth-uclass
>> pre_remove() ops already call the eth_ops.stop() ops.
>>
>> All these drivers seem to use designware_eth_ops and thus have correct
>> stop() ops configured and should really not need the remove() ops.
>>
> 
> That's interesting. I wrote that code about 9 years ago so perhaps can
> be forgiven for forgetting.
> 
> Very few drivers set the DM_FLAG_ACTIVE_DMA flag, certainly not the
> designware ones. So how would they be removed?

Ahh, I see, remove() is only called for devices with ACTIVE_DMA or
OS_PREPARE. So I guess that was probably the issue all along?

There is some confusion that dm_remove_devices_active() does not remove
device_active()=true devices and instead only remove ACTIVE_DMA and/or
OS_PREPARE flagged devices.

> 
>> Side note, this also misses the gmac rockchip driver that uses its own
>> eth_ops instead of designware_eth_ops, however it also use same stop()
>> ops as all these drivers.
> 
> Hmm yes I saw that but then apparently forgot to include it.
> 
> I can perhaps redo this patch to add the DMA flag.

Maybe eth_post_probe() or similar should add the OS_PREPARE or
ACTIVE_DMA flag for all eth-uclass, to ensure remove() and thus stop()
gets called when dm_remove_devices_active() is called.

There is probably no need to add all these remove() ops, as they would
still not have been called by dm_remove_devices_active().

Regards,
Jonas

> 
>>
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
>>> ---
>>>
>>>  drivers/net/designware.c    |  2 +-
>>>  drivers/net/designware.h    | 12 ++++++++++++
>>>  drivers/net/dwmac_meson8b.c |  6 ++++++
>>>  drivers/net/dwmac_s700.c    |  6 ++++++
>>>  drivers/net/dwmac_socfpga.c |  6 ++++++
>>>  5 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
>>> index eebf14bd51a..d4d31925fca 100644
>>> --- a/drivers/net/designware.c
>>> +++ b/drivers/net/designware.c
>>> @@ -805,7 +805,7 @@ clk_err:
>>>       return err;
>>>  }
>>>
>>> -static int designware_eth_remove(struct udevice *dev)
>>> +int designware_eth_remove(struct udevice *dev)
>>>  {
>>>       struct dw_eth_dev *priv = dev_get_priv(dev);
>>>
>>> diff --git a/drivers/net/designware.h b/drivers/net/designware.h
>>> index e47101ccaf6..8c9d0190e03 100644
>>> --- a/drivers/net/designware.h
>>> +++ b/drivers/net/designware.h
>>> @@ -247,6 +247,18 @@ struct dw_eth_dev {
>>>
>>>  int designware_eth_of_to_plat(struct udevice *dev);
>>>  int designware_eth_probe(struct udevice *dev);
>>> +
>>> +/**
>>> + * designware_eth_remove() - Remove the device
>>> + *
>>> + * Disables DMA and marks the device as remove. This must be called before
>>> + * booting an OS, to ensure that DMA is inactive.
>>> + *
>>> + * @dev: Device to remove
>>> + * Return 0 if OK, -ve on error
>>> + */
>>> +int designware_eth_remove(struct udevice *dev);
>>> +
>>>  extern const struct eth_ops designware_eth_ops;
>>>
>>>  struct dw_eth_pdata {
>>> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
>>> index fde4aabbace..b2152f8da9b 100644
>>> --- a/drivers/net/dwmac_meson8b.c
>>> +++ b/drivers/net/dwmac_meson8b.c
>>> @@ -145,6 +145,11 @@ static int dwmac_meson8b_probe(struct udevice *dev)
>>>       return designware_eth_probe(dev);
>>>  }
>>>
>>> +static int dwmac_meson8b_remove(struct udevice *dev)
>>> +{
>>> +     return designware_eth_remove(dev);
>>> +}
>>> +
>>>  static const struct udevice_id dwmac_meson8b_ids[] = {
>>>       { .compatible = "amlogic,meson-gxbb-dwmac", .data = (ulong)dwmac_setup_gx },
>>>       { .compatible = "amlogic,meson-g12a-dwmac", .data = (ulong)dwmac_setup_axg },
>>> @@ -158,6 +163,7 @@ U_BOOT_DRIVER(dwmac_meson8b) = {
>>>       .of_match       = dwmac_meson8b_ids,
>>>       .of_to_plat = dwmac_meson8b_of_to_plat,
>>>       .probe          = dwmac_meson8b_probe,
>>> +     .remove         = dwmac_meson8b_remove,
>>
>> There is no reason to add the dwmac_meson8b_remove function above, you
>> could just use designware_eth_remove directly here.
>>
>> Same for remaining drivers below.
> 
> Yes, I wasn't sure which way to go on that. I'll remove them.
> 
>>
>> Regards,
>> Jonas
>>
>>>       .ops            = &designware_eth_ops,
>>>       .priv_auto      = sizeof(struct dw_eth_dev),
>>>       .plat_auto      = sizeof(struct dwmac_meson8b_plat),
>>> diff --git a/drivers/net/dwmac_s700.c b/drivers/net/dwmac_s700.c
>>> index 969d247b4f3..cfb37c3aa71 100644
>>> --- a/drivers/net/dwmac_s700.c
>>> +++ b/drivers/net/dwmac_s700.c
>>> @@ -44,6 +44,11 @@ static int dwmac_s700_probe(struct udevice *dev)
>>>       return designware_eth_probe(dev);
>>>  }
>>>
>>> +static int dwmac_s700_remove(struct udevice *dev)
>>> +{
>>> +     return designware_eth_remove(dev);
>>> +}
>>> +
>>>  static int dwmac_s700_of_to_plat(struct udevice *dev)
>>>  {
>>>       return designware_eth_of_to_plat(dev);
>>> @@ -60,6 +65,7 @@ U_BOOT_DRIVER(dwmac_s700) = {
>>>       .of_match = dwmac_s700_ids,
>>>       .of_to_plat = dwmac_s700_of_to_plat,
>>>       .probe  = dwmac_s700_probe,
>>> +     .remove = dwmac_s700_remove,
>>>       .ops    = &designware_eth_ops,
>>>       .priv_auto      = sizeof(struct dw_eth_dev),
>>>       .plat_auto      = sizeof(struct eth_pdata),
>>> diff --git a/drivers/net/dwmac_socfpga.c b/drivers/net/dwmac_socfpga.c
>>> index a9e2d8c0972..8e7a9975d28 100644
>>> --- a/drivers/net/dwmac_socfpga.c
>>> +++ b/drivers/net/dwmac_socfpga.c
>>> @@ -130,6 +130,11 @@ static int dwmac_socfpga_probe(struct udevice *dev)
>>>       return designware_eth_probe(dev);
>>>  }
>>>
>>> +static int dwmac_socfpga_remove(struct udevice *dev)
>>> +{
>>> +     return designware_eth_remove(dev);
>>> +}
>>> +
>>>  static const struct udevice_id dwmac_socfpga_ids[] = {
>>>       { .compatible = "altr,socfpga-stmmac" },
>>>       { }
>>> @@ -141,6 +146,7 @@ U_BOOT_DRIVER(dwmac_socfpga) = {
>>>       .of_match       = dwmac_socfpga_ids,
>>>       .of_to_plat = dwmac_socfpga_of_to_plat,
>>>       .probe          = dwmac_socfpga_probe,
>>> +     .remove         = dwmac_socfpga_remove,
>>>       .ops            = &designware_eth_ops,
>>>       .priv_auto      = sizeof(struct dw_eth_dev),
>>>       .plat_auto      = sizeof(struct dwmac_socfpga_plat),
>>
> 
> Regards,
> Simon


