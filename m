Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web12.4123.1605188097446515642
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Nov 2020 05:34:57 -0800
Received: by mail-wm1-f67.google.com with SMTP id s13so5521672wmh.4
        for <u-boot-amlogic@groups.io>; Thu, 12 Nov 2020 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TsRAsCdpv5MWev4RE+3H40Mjq+Uzt2JiyWWaXWNEZNw=;
        b=JOm1ysx4y+Laz3uzDNXITqb3JbgPNtkizkahnUUwtm7lqSAz4EpPOtqA/lH/N2AIpX
         dZBihYjURDKRj8wM6VTdfJpXbuWPPR/Fj4n3Qx6alLr8+mDxExbMq80HyHKicvnBffgD
         9n0P4nzo838lEWi9jsAG3HgbNOMMdJ4Xos3yOhdFmlu5hyuVF/kDXKQP9vy6RedoPsa7
         HitJPytTlCHXK12bHRQgyQPULPjzO4UuC1zynNMwtf9Siwc6hCmzA9i9x+lLSSDEUqnb
         cyeWs2cH7SsjCHkWporRbx9eJRVX8jsQxz/lMgFgVc8FcGA3EuWi39Zuj3bq8uzPe4+H
         v2VA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] video: add TDO tl070wsh30 panel driver
References: <20201106102947.2477568-1-narmstrong@baylibre.com>
 <20201106200237.6460f2a7@crub>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <d783e87d-0f2e-dfe7-70e9-6131e964a842@baylibre.com>
Date: Thu, 12 Nov 2020 14:34:53 +0100
MIME-Version: 1.0
In-Reply-To: <20201106200237.6460f2a7@crub>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 20:02, Anatolij Gustschin wrote:
> On Fri,  6 Nov 2020 11:29:47 +0100
> Neil Armstrong narmstrong@baylibre.com wrote:
> 
>> This adds support for the TDO TL070WSH30 TFT-LCD panel module.
>> The panel has a 1024×600 resolution and uses 24 bit RGB per pixel.
>> It provides a MIPI DSI interface to the host, a built-in LED backlight
>> and touch controller.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Reviewed-by: Anatolij Gustschin <agust@denx.de>
> 

Thanks.

Applied to u-boot-amlogic-next
