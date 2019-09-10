Received: by mail-wr1-f68.google.com with SMTP id l16so18025403wrv.12
        for <u-boot-amlogic@groups.io>; Tue, 10 Sep 2019 00:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uHA7Co5rPPDOc75vDf8tPLeay6lPldmQjLrFCmP1bWM=;
        b=ZLmZ1y/uXc+bMWfJrBZWcDZyp2z3oNBFr5qsaKwY7kVJU6diaf3w6/193jpJ20tKOy
         ovTNN6ePuN6wAmxgH5Qrl3y3jQJ6LXOKJZKf0AbBVw4hlYL1HL/nGAcYYWgvJWuYTBMh
         KzsYzsk51qsXuUuKO9FEMV6OQHv1BR9hXhgK/WtRfJjKXnb/rE18RoNGSowU3TNKc3KW
         iM7kzxTWJkI2jqIKwA5Jc1ccvtW9g5stS+qFDXYA9PRN4s96HOm1IAIN8heIHvg/Ptn8
         1LUFkqWiZqsgtgEmz8/Hwgj7R1UnzNtJH9fgLPfacG6q+3bI5EFGsjC5yGII7QehXZMs
         2uDA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add support for dis_u2_susphy_quirk
References: <1568055159-27982-1-git-send-email-narmstrong@baylibre.com>
 <CAEUhbmUQ3kE79jnQ20FFBit2W-96x+bKFEnGc0yZugBrNdr0Zg@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <2a299283-7f5b-15ce-cf38-6ebd30a5cecb@baylibre.com>
Date: Tue, 10 Sep 2019 09:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAEUhbmUQ3kE79jnQ20FFBit2W-96x+bKFEnGc0yZugBrNdr0Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, Yuri Frolov <crashing.kernel@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Bin, Marek,

On 10/09/2019 03:56, Bin Meng wrote:
> On Tue, Sep 10, 2019 at 2:52 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This quirk is necessary for the Amlogic GXL SoCs otherwise the
>> Port 2 PHY doesn't get out of suspend and U-Boot resets the board after:
>>
>> XHCI timeout on event type 33... cannot recover.
>> BUG: failure at drivers/usb/host/xhci-ring.c:474/xhci_wait_for_event()!
>> BUG!
>>
>> This quirk is also handled in the dwc3 core code, but until the
>> xhci-dwc3 driver uses the dwc3 core, the quirk must be handled here
>> to fix USB support on the Amlogic libretech-cc and libretech-ac board
>> when a device is only plugged in the OTG port.
>>
>> Cc: Yuri Frolov <crashing.kernel@gmail.com>
>> Cc: Bin Meng <bmeng.cn@gmail.com>
>> Fixes: dc9cdf859e ("usb: dwc3: Add DWC3 controller driver support")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/usb/host/xhci-dwc3.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
> 
> Thanks for your efforts tracing this down!
> 
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> 

Should I take it into my amlogic tree or you'll handle it ?

Thanks,
Neil
