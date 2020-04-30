Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.5819.1588249679333492480
 for <u-boot-amlogic@groups.io>;
 Thu, 30 Apr 2020 05:28:00 -0700
Received: by mail-wr1-f68.google.com with SMTP id d17so6624240wrg.11
        for <u-boot-amlogic@groups.io>; Thu, 30 Apr 2020 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afo1v00l1608OlwPi8k8d/LRXOO3to2VRIxaPIHmi/0=;
        b=sszOAZssogFRM6UnK0qEN7k5QqIW1ICyDIy5MPOh9H1T1LtX/xdhMJ5ECxQs5BZmV4
         XKYguXnqkEmwPBQ9XcpGLKJ6I+MD0oTLnRR7FxsxSSQ7xKCyfbfBWGXEouCHoMv7yDtV
         3+TphYylXI1iG+vFw89RiDuLivLLTn/0x1OX+Z6p1W7x4VnPG4LVqvzVkWhONcUrm5+9
         Pj3tTLikEK2qLd+PK1A6Ipk1WDb9bYvmnWxvnqas9XQn/8iJa8f9YQ4wx1fa+B0qRy/f
         E3bXP8F9gnYzMXSREnCk0HmGjc3RvbanTRE9JPEze6DaonvTl2lGkT0i04fIcUYG8H4u
         LUYA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] gpio: emulate open drain & open source in dm_gpio_set_value()
References: <20200429080634.355-1-narmstrong@baylibre.com>
 <CAPnjgZ03-q+Li0t1xpLaPnKquX-Rts9Jp6uD77iaxvb6cfY4sQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <0d92a05f-049f-06cd-18f6-bebd04555f48@baylibre.com>
Date: Thu, 30 Apr 2020 14:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ03-q+Li0t1xpLaPnKquX-Rts9Jp6uD77iaxvb6cfY4sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@st.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 29/04/2020 20:04, Simon Glass wrote:
> Hi Neil,
> 
> On Wed, 29 Apr 2020 at 02:06, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Handle the GPIOD_OPEN_DRAIN & GPIOD_OPEN_SOURCE flags to emulate open drain
>> and open source by setting the GPIO line as input depending on the
>> requested value.
>>
>> The behaviour is taken from the Linux gpiolib.
>>
>> It notably permits enabling a GPIO regulator used as Open Drain on the
>> Amlogic G12A/g12B/SM1 platforms for HDMI output feature.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpio/gpio-uclass.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> Can you update the GPIO test please?
> 
> Regards,
> Simon
> 

Sure,

Thanks,
Neil
