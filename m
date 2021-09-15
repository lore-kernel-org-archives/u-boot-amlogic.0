Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.4640.1631693729569716616
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Sep 2021 01:15:30 -0700
Received: by mail-wm1-f45.google.com with SMTP id g128so1421575wma.5
        for <u-boot-amlogic@groups.io>; Wed, 15 Sep 2021 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6e2x0akOMNS7f8Q1CGXrFTjZjLUKTZcF2K7uEKxqqlo=;
        b=5vU8NxNqlGVi9mmBnZSiSHuOa9R86JmKZTJLpW+kCdKk1JFb/LWa4j4KHcXkMBcaoW
         JBfPmp4DK6rzmcndUMgyFmJ8e+QGQpMGOceA5iZ5s41QZM6yJS1BeviLxk70yDvR3nFn
         m7lmonwlK6GtsYsu7HUkbtJNnKbs+JX+ZveRtD9S6/hgpxjd1eol/k3vD906Lno/dTgG
         nn0kN5cBzlzYJUryD5IlLZlvRueiz1VvDejXFs9wK2d/D70hPiGeti15NsDO3Ye8Otux
         FJPzscauzyRuW2gNye3MOeshBarofri3HfXSP7i93ukNP2ehMIFTc/axzaSw9x8R/2eI
         Pa9A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/9] ARM: meson: Sync Amlogic DT from Linux 5.14
References: <20210908141728.585797-1-narmstrong@baylibre.com>
 <978e5c89-fafb-def9-a9ca-f6891f46eef2@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <f2990b55-5e3e-6e43-96d7-fcf207dad7f0@baylibre.com>
Date: Wed, 15 Sep 2021 10:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <978e5c89-fafb-def9-a9ca-f6891f46eef2@lexina.in>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 15/09/2021 09:49, Vyacheslav wrote:
> 08.09.2021 17:17, Neil Armstrong via groups.io wrote:
>> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
>> index b9efc84692..3f5254eeb4 100644
>> --- a/arch/arm/dts/meson-axg.dtsi
>> +++ b/arch/arm/dts/meson-axg.dtsi
> ...
>> +
>> +        usb: usb@ffe09080 {
>> +            compatible = "amlogic,meson-axg-usb-ctrl";
>> +            reg = <0x0 0xffe09080 0x0 0x20>;
>> +            interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>> +            #address-cells = <2>;
> 
> Hi.
> I have looked through the dts for axg and found that a usb node use "amlogic,meson-axg-usb-ctrl" that is not supported in uboot. In linux-kernel it exists in drivers/usb/dwc3/dwc3-meson-g12a.c
> In previous dts usb node used amlogic,meson-gxl-usb-ctrl and it worked good.
> 

You're right, "amlogic,meson-axg-usb-ctrl" is missing in the drivers/usb/dwc3/dwc3-meson-gxl.c driver

I'll add and resend the serie.

Neil
