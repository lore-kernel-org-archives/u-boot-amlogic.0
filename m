Received: by mail-wr1-f67.google.com with SMTP id g7so14000193wrx.2
        for <u-boot-amlogic@groups.io>; Mon, 02 Sep 2019 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G/TXexuAWJmj4mxUz050jDh2e1nwpp1Qcja3FEo3OiA=;
        b=yFhrGX4Pd/YGPnwAh5TKAez8jhUBlmunFUIsPOfCgnGCEgIvHPVHMXAPZ2bf+aGQfP
         0pFl6OVhBHgmqCi4L3hia+2YSI2nD+IPkh34fes7D5Aj6FsycBCY0zNKE3PnnP49HsNJ
         iqtMCWXb9nWfCf5lFCR5TTEQ1+JIusiRjB4N//8EZD43RBz51AaA3qyimvOqRgYQHfAX
         DqqbhKE4K5SgSdNUkP0LL+yMdRHugnHQs0wP7Y1PHITMHMJ73BjUJjlyEnj976LEqwob
         xMLlQMsWQCpUovtuqHEbtf39330hmbpVBrMDOCbNsVPjwKWKATDJuBFKgw0F1hMwcT14
         4ITw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm: dts: Import and update DT for Khadas VIM3
References: <20190902022851.9228-1-afaerber@suse.de>
 <20190902022851.9228-2-afaerber@suse.de>
 <865e1398-4da5-fc3c-4ce7-93e8f2d08439@baylibre.com>
 <9069bbc4-e890-0feb-3a1c-729344d00dee@suse.de>
 <c179af5e-d099-5ea3-87d9-6aaae0467ac6@baylibre.com>
 <bdf46216-096b-53c3-d2e8-9193e9504b88@suse.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <08ef7ab1-adbf-b848-01f0-11676e508a90@baylibre.com>
Date: Mon, 2 Sep 2019 15:08:58 +0200
MIME-Version: 1.0
In-Reply-To: <bdf46216-096b-53c3-d2e8-9193e9504b88@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Albert Aribaud <albert.u.boot@aribaud.net>, Gouwa <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

On 02/09/2019 14:45, Andreas Färber wrote:
> Hi Neil,
> 
> Am 02.09.19 um 14:10 schrieb Neil Armstrong:
>> On 02/09/2019 14:03, Andreas Färber wrote:
>>> Am 02.09.19 um 12:03 schrieb Neil Armstrong:
>>>> On 02/09/2019 04:28, Andreas Färber wrote:
>>>>> In Linux meson-g12-common.dtsi was introduced as well as new g12b nodes
>>>>> and headers, as dependencies of new meson-g12b-a311d-khadas-vim3.dts.
>>>>
>>>> Can you precise the Linux commit ID you sync'ed from ?
>>>
>>> It was yesterday's linux-next.git (via cgit), adding tag next-20190830.
>>
>> Please don't use linux next, it's not a stable tree, either wait for 5.4-rc1
>> or use kevin's amlogic-dt64-2.1 tag, since it will be kept in the final
>> merge.
> 
> Well, in my view linux-next would contain whatever vX patchset Kevin
> applied to his tree... let's wait for -rc1 then.

Sorry to be picky, but yes let's wait -rc1 since I'll anyway wait until next U-Boot
release cycle to send these patches to Tom.

> 
>>>
>>>> The best would be to sync from the v2 dt64 PR from kevin :
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/tag/?h=amlogic-dt64-2.1
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>>>> ---
>>>>>  arch/arm/dts/Makefile                              |    3 +-
>>>>>  arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++++++++
>>>>>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
>>>>
>>>> Can you also sync the s922x version ?
>>>
>>> Why? No such model is being sold: https://www.khadas.com/vim3
>>>
>>> In any case, if you or someone has such a pre-production model you can
>>> add it as follow-up. In fact you could even entirely replace this import
>>> patch if you so desired, it's intentionally separate.
>>
>> Didn't want to offend you, don't sync it if you don't want...
> 
> It was an honest question. So I take it you have such a prototype?
> 
> What I do feel offended about is that my NanoPi K2 patch got ignored and
> someone else's got merged without crediting or even notifying me. I've
> become rather hesitant to send U-Boot patches for new boards since, as I
> don't have much time for it lately and I'd rather spend it productively.

I was not aware you did the Nanopi K2 support... since I only managed the Amlogic
U-boot patches in a Custodian and send PRs to Tom since early this year,
I can't really be accused of ignoring a patch you sent 2y ago before I sent a single
patch to the U-Boot ML about Amlogic SoCs support:

commit 486221564920e8fcb9a58854a485dac1f8f4d1d3
Author: Neil Armstrong <narmstrong@baylibre.com>
Date:   Thu Oct 12 15:50:30 2017 +0200

    ARM: dts: Synchronize Amlogic from Linux Mainline 4.13.5

> 
> https://patchwork.ozlabs.org/patch/762194/
> https://patchwork.ozlabs.org/patch/762483/
> https://patchwork.ozlabs.org/patch/934377/

As you can see, Thomas McKahan did the work and I simply posted the patch
to the list.

> https://gitlab.denx.de/u-boot/u-boot/commit/eee45b4f545902a9089f68331c925898da813ac0
> 
>>>>>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
>>>>>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
>>>>>  arch/arm/dts/meson-g12b.dtsi                       |   39 +-
>>>>>  include/dt-bindings/clock/g12a-clkc.h              |    6 +
>>>>>  include/dt-bindings/power/meson-g12a-power.h       |   13 +
>>>>>  .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
>>>>>  9 files changed, 3238 insertions(+), 4 deletions(-)
>>>>>  create mode 100644 arch/arm/dts/meson-g12-common.dtsi
>>>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
>>>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
>>>>>  create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
>>>>>  create mode 100644 include/dt-bindings/power/meson-g12a-power.h
>>>>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
>>>>>
>>>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>>>> index aac1b83d49..6de5e4c62a 100644
>>>>> --- a/arch/arm/dts/Makefile
>>>>> +++ b/arch/arm/dts/Makefile
>>>>> @@ -141,7 +141,8 @@ dtb-$(CONFIG_ARCH_MESON) += \
>>>>>  	meson-axg-s400.dtb \
>>>>>  	meson-g12a-u200.dtb \
>>>>>  	meson-g12a-sei510.dtb \
>>>>> -	meson-g12b-odroid-n2.dtb
>>>>> +	meson-g12b-odroid-n2.dtb \
>>>>> +	meson-g12b-a311d-khadas-vim3.dtb
>>>>
>>>> Same here, can you also build the s922x variant ?
>>>
>>> Again, I don't see why, in particular when we don't have a defconfig
>>> using it. If you intend to add one, you can still add it later
>>
>> Since I maintain the whole stuff, it would have saved my time.
> 
> Sorry, no time to redo this patch the next ~3 weeks due to travels.
> It was not scripted.
> 
> Thanks for your quick review.
> 
> Regards,
> Andreas
> 

Thanks for doing this anyway,
Neil
