Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web10.27390.1650880925827367283
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 03:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650880922; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:
	 disposition-notification-to; bh=5PSo/DBlmxTU4kTXVf0m8eAgo5Gav7zP68gURn0BDxQ=;
	b=tUpC11qBeOmD7nQhXyP8tX42zL4EySLQAOlYh/OLI/Fk1pBI8L5Bpko32T8v1aLMBFHZ3E
	ABiq8eCqawntw1ncxz5fdAjJqMrPCXEl+AwOxXX97EJWdVea6dGtwBLpQydqp/4tEoTYKV
	7GeM3aN9w2gNzPkFqMyb6PHW6a6S92Kb7s3B/EXteoiCvfl7yzBLNvDH/yxd9onW+aZvgl
	b18weAWT3uyS0gkZVQSA0vjl0glbeU+d1Obs0mODx3uulE9TGpCsliltwPChOeeQyMlMp9
	9YtDBo1yaWVCbWeLnGvfdUoa0erooYZfAeCwDbIDCSJeRtWydVkvNL5CNjn2zQ==
Subject: Re: [PATCH v3 0/6] meson: add clk and adc support for JetHub D1 (j100)
References: <20220424082159.757622-1-adeep@lexina.in>
 <165087151696.2737808.12423374901852555018.b4-ty@baylibre.com>
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Message-ID: <ebb905f3-c2ab-3373-de9a-7528200b84dd@lexina.in>
Date: Mon, 25 Apr 2022 13:01:58 +0300
MIME-Version: 1.0
In-Reply-To: <165087151696.2737808.12423374901852555018.b4-ty@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, u-boot-amlogic@groups.io, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

25.04.2022 10:25, Neil Armstrong wrote:
> Hi,
> 
> On Sun, 24 Apr 2022 11:21:53 +0300, Vyacheslav Bocharov wrote:
>> Prepare to use ADC channel 1 in JetHub D1 (j100) to check the hardware
>> revision of the board.
>>
>> - add support for AXG in saradc driver
>> - add simple clk-ao driver for AXG (base is taken from g12a)
>> - enable saradc in dts and board config file
>> - fix typo in the g12a-clk-ao driver name
>> - move clk->id check to .request function for g12a-clk-ao driver
>> - remove unnecessary check (gate->reg == 0) in g12a-clk-ao driver
>> - enable saradc in dts/board config for JetHub D1 (j100)
>>
>> [...]
> 
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

Thanks. Let me know if additional testing or rework is needed.

> 
> [1/6] clk: meson: add minimal driver for axg-ao clocks
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dcccf730043197464f7bafdb1abcebcb7fd828b0
> [2/6] clk: meson: fix driver name for g12a-ao clocks
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4da098656228535539be40f76806ad6657b94407
> [3/6] clk: meson: update driver for g12a-ao clocks
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/66a657b7c6082fe374c99d5b2a7e0d911091dbe4
> [4/6] adc: meson-saradc: add AXG variant
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a4a73f466c1d2189aa5f8612f2f90ec9a727ea0
> [5/6] board: amlogic: jethub j100: enable saradc in dts
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ee8094f69646825d2c30b8bb9082e976f023f710
> [6/6] board: amlogic: jethub j100: enable saradc in config
>        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a718f5524d492fb5708e884cb1db21384f826c00
> 

