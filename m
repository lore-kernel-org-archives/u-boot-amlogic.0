Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web10.14358.1603726538177848146
 for <u-boot-amlogic@groups.io>;
 Mon, 26 Oct 2020 08:35:38 -0700
Received: by mail-wm1-f65.google.com with SMTP id 13so12103857wmf.0
        for <u-boot-amlogic@groups.io>; Mon, 26 Oct 2020 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yZp4f3d6Ocva9Bu8Oja2ayRtPO298TvNNOdqsl7PPh4=;
        b=1+zGBZZjRhd5OvdVSz5d+2roihE9/cZ0HW9wFgPdvwTcgggyY5gsFNU7t1GIVxZ86d
         1ObJk++11JrYlBQPogB2pwffIYfokgLm1kJTCy/5+IFIV8mtSt1ArJhCBd4gCzaXXn8W
         ST/3T9bshdPOSD0bi8mKhQ1U+lJfg0Ox+WmR35/oo8T3nh4oCXXoy4zdQUrK6ZQEdb/E
         uBqhkEGLuF38b+JxOwg5Yx1GUIrAjghhybQQOgjGmEkTC/qF4oJRbBuSdXMUugzNOtz8
         glk/egySbA/scrcfmDz7ap9kEf/GKx78CjsoaJZ5lpdidKk9GQ1IV8ri8PQbK3dIqTwP
         rE2Q==
Return-Path: <jbrunet@baylibre.com>
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com> <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com> <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
In-reply-to: <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
Date: Mon, 26 Oct 2020 16:35:34 +0100
Message-ID: <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Anton Arapov <arapov@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>


On Mon 26 Oct 2020 at 15:59, Anton Arapov <arapov@gmail.com> wrote:

> Another observation is that u-boot with mentioned patch can't
> find/initialize ethernet on a brand new Odroid C2, rev0.2 20171114.
> But after booting without this patch at least once - ethernet is found
> and working fine. And amazingly it keeps working even after the patch
> is applied again later.

That would be amazing indeed

>
> @
>
> On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi,
>>
>> Thanks for the report.
>>
>> Next time, please send the email to u-boot-amlogic@groups.io
>>
>> It's weird this fixes the issue, because the BOOT_0 to BOOT_8 have
>> default Pull-Up by default,

But it isn't necessarily what you get out of ROM code, which is reason
for setting up bias in DT initially.

>> and Linux works fine with this.

This part is weird ...

>>
>> S905_Public_Datasheet_V1.1.4.pdf pages 17 & 18
>>
>> Maybe there is another issue in pinctrl instead ?
>>
>> Neil
>>
>>
>> On 26/10/2020 15:36, Anton Arapov wrote:
>> > Neil, Jerome,
>> >
>> > the commit:
>> > https://gitlab.denx.de/u-boot/u-boot/-/commit/dd5f2351e99aad8fcbedbc1305b8b51b09952336
>> > introduced "bias-pull-up" for emmc:
>> > https://gitlab.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/meson-gxbb.dtsi#L411
>> > and breaks booting from eMMC on the Odroid C2 board.
>> >
>> > uboot output:
>> >   => mmc dev 1
>> >   Card did not respond to voltage select!
>> >
>> > removing bias-pull-up fixes the issue, though it is not the fix
>> > obviously.

There has a fair amount of issue linked to the mmc of these SoCs, it is
difficult to keep track of what happened each time.

As mentioned above, these properties have been introduced to, at least,
get things consistent. If you look at the vendor kernel, they apply
pull-ups too.

>> >
>> > Could you suggest what could be done in order to fix the issue? Where
>> > should I look?

Now if just removing the "bias-pull-up" is making it "go" for you, it
would be interresting to know what actually happened, what did you
inherit from the ROM code?

IOW, could you compare the registers linked to the pin bias a let us
know what changed with and without ?


>> > Any hint would be helpful.
>> >
>> > Thanks,
>> > Anton
>> >
>>

