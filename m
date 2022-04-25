Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web09.28870.1650889896245927653
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 05:31:36 -0700
Received: by mail-wr1-f49.google.com with SMTP id v12so13813872wrv.10
        for <u-boot-amlogic@groups.io>; Mon, 25 Apr 2022 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=l6IJC10k8wKJ+q7JZUr2ZW8dFNrm3pYfVqDIoh3UHBI=;
        b=ud+IdfuLtIHQA7m7UnjdnG7FcNbf8mcFbFef6L3bSzon/mCm0zZ+G1yvadfoRbDdxF
         qXuGPGl4Busc9ZXJ10MQkAfs9ogr5foqv5Dv+///vxZj0xihJbkdJrTP2DT6sr+tPGAS
         ngYCV7yzJr3yNE+NhX6W9VTNejn6EIWvuoNUU/G3guV3/B12IFMTHVp3eIg3E/r72lpb
         vzX3uUptOAvY4NvBjFHrYOn4riNVKVaAKXB5B8p77RtVOXIxIlomsXICIx9rUMIJZ852
         /ce0sJfJ3W1nJX6kn9QC7UpNCO/TyeczPuB/y1c9gEP+a0pyu7i1e7BQ917WxRJTHgZP
         78zw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <8e5ec46a-f6e3-cb53-7342-a29fc1966fc9@baylibre.com>
Date: Mon, 25 Apr 2022 14:31:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/6] meson: add clk and adc support for JetHub D1 (j100)
References: <20220424082159.757622-1-adeep@lexina.in>
 <165087151696.2737808.12423374901852555018.b4-ty@baylibre.com>
 <ebb905f3-c2ab-3373-de9a-7528200b84dd@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <ebb905f3-c2ab-3373-de9a-7528200b84dd@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Vyacheslav <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, u-boot-amlogic@groups.io, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 25/04/2022 12:01, Vyacheslav wrote:
> 25.04.2022 10:25, Neil Armstrong wrote:
>> Hi,
>>
>> On Sun, 24 Apr 2022 11:21:53 +0300, Vyacheslav Bocharov wrote:
>>> Prepare to use ADC channel 1 in JetHub D1 (j100) to check the hardware
>>> revision of the board.
>>>
>>> - add support for AXG in saradc driver
>>> - add simple clk-ao driver for AXG (base is taken from g12a)
>>> - enable saradc in dts and board config file
>>> - fix typo in the g12a-clk-ao driver name
>>> - move clk->id check to .request function for g12a-clk-ao driver
>>> - remove unnecessary check (gate->reg == 0) in g12a-clk-ao driver
>>> - enable saradc in dts/board config for JetHub D1 (j100)
>>>
>>> [...]
>>
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)
> 
> Thanks. Let me know if additional testing or rework is needed.

So far all is ok, CI passed:
https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/pipelines/11853

Can you send a following patch to update the doc and indicate ADC is supported on AXG (and G12A, G12B & SM1 by the way) ?

Thanks,
Neil

> 
>>
>> [1/6] clk: meson: add minimal driver for axg-ao clocks
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dcccf730043197464f7bafdb1abcebcb7fd828b0
>> [2/6] clk: meson: fix driver name for g12a-ao clocks
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4da098656228535539be40f76806ad6657b94407
>> [3/6] clk: meson: update driver for g12a-ao clocks
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/66a657b7c6082fe374c99d5b2a7e0d911091dbe4
>> [4/6] adc: meson-saradc: add AXG variant
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a4a73f466c1d2189aa5f8612f2f90ec9a727ea0
>> [5/6] board: amlogic: jethub j100: enable saradc in dts
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ee8094f69646825d2c30b8bb9082e976f023f710
>> [6/6] board: amlogic: jethub j100: enable saradc in config
>>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a718f5524d492fb5708e884cb1db21384f826c00
>>
> 

