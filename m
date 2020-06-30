Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.14590.1593522017967245991
 for <u-boot-amlogic@groups.io>;
 Tue, 30 Jun 2020 06:00:19 -0700
Received: by mail-wr1-f66.google.com with SMTP id j4so17582476wrp.10
        for <u-boot-amlogic@groups.io>; Tue, 30 Jun 2020 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JSfxDPm9bd6t1RICW9dqkafCRzOyO0Iv5o3xDAnwLVE=;
        b=sWe9yTaeYNbFK9W8L1eJhC16aBOl4l96LehbKt8RlD+Fl5en97mgxJOlLHNsVFLn4l
         oK8AxumWvnBKaXPlmwWjGneN8MU4lzChvEFt+bb2vMrCj9A5z+x+imtUhlijvEz5eIxH
         kygqUkZNJLjNpANDVCL7ZE+VGyNUT7b8FfMDbzdCFX0wtfR7v8gi8BNNTD4u99TOBGsu
         qsIDlE7fj1szDVh4v07sv+mkZ0/u49nVX84a7nVNbC4CjzBv/LILk76aIt8i2UsjAyqa
         ZW1OPrsKtzIJMIfJ7Lwu7yXDgunPA4GQwJEvSzohZ4zvu/jjl+6xukO3mA5dcrVk1aJf
         /rCg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
References: <20200505202217.7849-1-b.galvani@gmail.com>
 <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com>
Date: Tue, 30 Jun 2020 15:00:14 +0200
MIME-Version: 1.0
In-Reply-To: <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 30/06/2020 13:33, Anand Moon wrote:
> Hi Beniamino,
> 
> On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
>>
>> Hi,
>>
>> these two patches add initial u-boot support for Hardkernel ODROID-C4.
>>
>> https://wiki.odroid.com/odroid-c4/odroid-c4
>>
>> Beniamino Galvani (2):
>>   arm: dts: import ODROID-C4 device tree
>>   boards: amlogic: add ODROID-C4 support
>>
> 
> Can you respin this patches, I would like to see these get merged in
> the current u-boot release
> 
> -Anand
> 

The Odroid-C4 could re-use the new Odroid-N2 board support I submitted at [1]

Anand, is the MAC address stored stored the same way on the C4 ?

Neil

[1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/
