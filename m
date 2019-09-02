Received: by mail-wm1-f68.google.com with SMTP id p13so14398764wmh.1
        for <u-boot-amlogic@groups.io>; Mon, 02 Sep 2019 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cic04h/XVPzq1JwvpCS3BsFyTbxO2ADBGBkFcvJQLDU=;
        b=oJVOlRIWZzhc5gyJeBEI//OXPJHr7LBaqfOmRxZFqIk213NrLjRj2vg59aFkjVY0HP
         O2HsLMCtSsNQaAbnqR1MAUau7pIdX68pQHJc8bJBT7raQMRrzPSl2wpfioy+6rQ2E/MB
         8Fr3UUxViDuQeXCi/TTY3d7RAV3Cr9SNxGJqeX6VkJ1rLm4loADQP7EAdOPcgQr6Zcy6
         Oi7G3kItrEJ+H3045PsY0S5mMheKYSRntzyBAbodR0KYmRtFT8IyZCq3dyM+mH11HE5c
         n0nZc/OwrKZ9cW1htgyDgw6yQUTwPemkxFKn4lLe4ONX3eZ65R5SFfSHSJBlK+ykLrQ+
         aUsw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm: dts: Import and update DT for Khadas VIM3
References: <20190902022851.9228-1-afaerber@suse.de>
 <20190902022851.9228-2-afaerber@suse.de>
 <865e1398-4da5-fc3c-4ce7-93e8f2d08439@baylibre.com>
 <9069bbc4-e890-0feb-3a1c-729344d00dee@suse.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <c179af5e-d099-5ea3-87d9-6aaae0467ac6@baylibre.com>
Date: Mon, 2 Sep 2019 14:10:56 +0200
MIME-Version: 1.0
In-Reply-To: <9069bbc4-e890-0feb-3a1c-729344d00dee@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Albert Aribaud <albert.u.boot@aribaud.net>, Gouwa <gouwa@khadas.com>
List-ID: <u-boot-amlogic@groups.io>

Hi Andreas

On 02/09/2019 14:03, Andreas Färber wrote:
> Hi Neil,
> 
> Am 02.09.19 um 12:03 schrieb Neil Armstrong:
>> On 02/09/2019 04:28, Andreas Färber wrote:
>>> In Linux meson-g12-common.dtsi was introduced as well as new g12b nodes
>>> and headers, as dependencies of new meson-g12b-a311d-khadas-vim3.dts.
>>
>> Can you precise the Linux commit ID you sync'ed from ?
> 
> It was yesterday's linux-next.git (via cgit), adding tag next-20190830.

Please don't use linux next, it's not a stable tree, either wait for 5.4-rc1
or use kevin's amlogic-dt64-2.1 tag, since it will be kept in the final
merge.

> 
>> The best would be to sync from the v2 dt64 PR from kevin :
>> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/tag/?h=amlogic-dt64-2.1
>>
>> Thanks,
>> Neil
>>
>>>
>>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>>> ---
>>>  arch/arm/dts/Makefile                              |    3 +-
>>>  arch/arm/dts/meson-g12-common.dtsi                 | 2435 ++++++++++++++++++++
>>>  arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   15 +
>>
>> Can you also sync the s922x version ?
> 
> Why? No such model is being sold: https://www.khadas.com/vim3
> 
> In any case, if you or someone has such a pre-production model you can
> add it as follow-up. In fact you could even entirely replace this import
> patch if you so desired, it's intentionally separate.

Didn't want to offend you, don't sync it if you don't want...

> 
>>>  arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 ++
>>>  arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  544 +++++
>>>  arch/arm/dts/meson-g12b.dtsi                       |   39 +-
>>>  include/dt-bindings/clock/g12a-clkc.h              |    6 +
>>>  include/dt-bindings/power/meson-g12a-power.h       |   13 +
>>>  .../reset/amlogic,meson-g12a-audio-reset.h         |   38 +
>>>  9 files changed, 3238 insertions(+), 4 deletions(-)
>>>  create mode 100644 arch/arm/dts/meson-g12-common.dtsi
>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
>>>  create mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
>>>  create mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
>>>  create mode 100644 include/dt-bindings/power/meson-g12a-power.h
>>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
>>>
>>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>>> index aac1b83d49..6de5e4c62a 100644
>>> --- a/arch/arm/dts/Makefile
>>> +++ b/arch/arm/dts/Makefile
>>> @@ -141,7 +141,8 @@ dtb-$(CONFIG_ARCH_MESON) += \
>>>  	meson-axg-s400.dtb \
>>>  	meson-g12a-u200.dtb \
>>>  	meson-g12a-sei510.dtb \
>>> -	meson-g12b-odroid-n2.dtb
>>> +	meson-g12b-odroid-n2.dtb \
>>> +	meson-g12b-a311d-khadas-vim3.dtb
>>
>> Same here, can you also build the s922x variant ?
> 
> Again, I don't see why, in particular when we don't have a defconfig
> using it. If you intend to add one, you can still add it later

Since I maintain the whole stuff, it would have saved my time.

Neil

> 
> Adding Gouwa for insights.
> 
> To my knowledge the VIM3L will have S905D3, not S922X. VIM3 is A311D.
> 
> https://www.khadas.com/post/khadas-vim3-won-t-use-s922x
> 
> Regards,
> Andreas
> 

