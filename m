Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.21474.1605689870877631720
 for <u-boot-amlogic@groups.io>;
 Wed, 18 Nov 2020 00:57:51 -0800
Received: by mail-wm1-f47.google.com with SMTP id c198so308825wmd.0
        for <u-boot-amlogic@groups.io>; Wed, 18 Nov 2020 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m4ZQSWe9wQcmjvQE2+yI9LS1JV0foo3lWSkz8c1annI=;
        b=hhYp8JYIKXZH6/1D2/SixselFjhdNhycX+sc9epJNbhi1gNkOhUu2J54qlUgi0zOLP
         9CzYxoar7e6WBVwiR+cQ7Y1cn9i1ehit7TweyW9tM2j0kWxZ4sXDhcghVd6/My4gD4Rn
         JoOXB0p18tqar2+tJ+31Ycj6fqfChUKqFJZ6hCciqM8iTWbzNAejcgPh+3ADK4fdqVVN
         AnaotOfCXxy8aGp/AbBd26Qzn5eA2cwWIm/qWZ7rLD+IqVWOT/zXmrUXpt2WNdZhgUaA
         a09CqP82eYViY6ZMrTRArzw2dEmKRiGFzh6VxRndRSWsWnA9lcrZkDlWb3e9cEM968Zi
         zYMA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: meson-gxbb regression since u-boot v2020.04
References: <CAMeizLdpoevi6Fj-X=abWe2QKuvdrJ4gkS_=2yzpBmrnO-RDaQ@mail.gmail.com>
 <f1afd339-241d-1708-8a07-9daa008cdfd5@baylibre.com>
 <CAMeizLcQGkmsZ3MOb8uHGKGxFYfWpEK6Y1YF7OPWLJzs765KRQ@mail.gmail.com>
 <1jblgpj8zd.fsf@starbuckisacylon.baylibre.com>
 <CAMeizLc163WqCM-MVGFSSZnrZ_6mwVTrtje4Vp86d8z4gDw-SQ@mail.gmail.com>
 <032e222c-1f46-0efc-d92b-ee848fc2c12e@baylibre.com>
 <CAMeizLdD8MZLpPhmhCx-q5CDAVOFA4ig=s3imZCdYVs=+eBSeQ@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <9d895f25-8141-a2c1-3e65-e90533fedb1c@baylibre.com>
Date: Wed, 18 Nov 2020 09:57:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAMeizLdD8MZLpPhmhCx-q5CDAVOFA4ig=s3imZCdYVs=+eBSeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anton Arapov <arapov@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

Sorry for the delay

On 13/11/2020 17:37, Anton Arapov wrote:
> Hi,
> 
> On Tue, Oct 27, 2020 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 26/10/2020 18:56, Anton Arapov wrote:
>>> On Mon, Oct 26, 2020 at 4:35 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>> On Mon 26 Oct 2020 at 15:59, Anton Arapov <arapov@gmail.com> wrote:
> [snip]
>>>>> On Mon, Oct 26, 2020 at 3:50 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [snip]
>>>>>> On 26/10/2020 15:36, Anton Arapov wrote:
>>> [snip]
>>>>>>> Could you suggest what could be done in order to fix the issue? Where
>>>>>>> should I look?
>>>>
>>>> Now if just removing the "bias-pull-up" is making it "go" for you, it
>>>> would be interresting to know what actually happened, what did you
>>>> inherit from the ROM code?
>>>>
>>>> IOW, could you compare the registers linked to the pin bias a let us
>>>> know what changed with and without ?
>>>
>>> Jerome, I am new to u-boot story. Your request made me look into pdf
>>> and registers and this is what I found:
>>>
>>> I built two u-boot builds with odroid-c2_defconf, (1) with the patch,
>>> (2) - a commit before the patch
>>> (1) dd5f2351e9 arm64: dts: meson: sync dt and bindings from v5.6-rc2
>>> (2) b3d69aa596 clk: meson: reset mmc clock on probe
>>>
>>> I found the registers and offsets at page 87 of
>>> S905_Public_Datasheet_V1.1.4.pdf mentioned earlier.
>>>
>>> u-boot build (1) with the patch, can NOT boot from eMMC:
>>> => md.b 0xc8834528 # PU/PD-EN
>>> c8834528: 01 7a 0f fc 00 c0 00 f0 ff ff 7f 00 00 00 00 00    .z..............
>>> => md.b 0xc88344f0 # PU/PD
>>> c88344f0: 01 7b 4f fc ff bf 00 f0 bf ff 6f 00 00 00 00 00    .{O.......o.....
>>
>>
>> Indeed, this makes Pull-Up only on these pins:
>> BOOT0
>> BOOT9
>> BOOT11
>> BOOT12
>> BOOT13
>> BOOT14
>>
>> and the dtsi instructs to set Pull-Up on:
>> BOOT0 to BOOT7
>> BOOT10
>>
>> so there is a bug on the pinctrl u-boot driver here...
>>
>> Can you trace the drivers/pinctrl/meson/pinctrl-meson.c and drivers/pinctrl/meson/pinctrl-meson-gx-pmx.c ?
> 
> Neil, I've just recovered from "probably covid" .... 
Hope you will recover, I still have symptoms 8months later...

> Could you give me
> a hint as to what you mean by trace here?
> Point me to the document perhaps?

You did well, there is no other simple tracing except print.

> 
> I've added additional printouts to the relevant)hopefully) code and
> see that it tries to set pull-up on BOOT 0...7 and 10.
> 
> pinconfig emmc: set_state_simple op missing
> clk_set_defaults(emmc)
> clk_set_default_parents: could not read assigned-clock-parents for
> 000000007bf45c20
> ofnode_read_prop: assigned-clock-rates: <not found>
> pinctrl_generic_set_state_subnode(pinctrl@4b0, emmc): count=0
> pinctrl_generic_set_state_subnode(pinctrl@4b0, mux-0): count=2
>         >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f0 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f1 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f2 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f3 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f4 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f5 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f6 : (1) PIN_CONFIG_BIAS_PULL_UP
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344f7 : (1) PIN_CONFIG_BIAS_PULL_UP
>         >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc88344fa : (1) PIN_CONFIG_BIAS_PULL_UP
> pinctrl_generic_set_state_subnode(pinctrl@4b0, mux-1): count=1
>         >> pinctrl-meson.c: meson_pinconf_group_set() periphs-banks
>                 >> pinctrl-meson.c: meson_pinconf_bias_set() :
> 0xc8834530 : (0) PIN_CONFIG_BIAS_DISABLE

Hmm it doesn't give enough details, but the overall pinctrl logic is ok.

Can you trace further to see the actual register address and the value before and written ?

Thx,
Neil

> 
> wdyt?
> 
>> We fixed the AXG and G12 ones, but maybe a bug subsists on the GX side.
>> But it's weird it doesn't appear on GXL.
>>
>> Neil
> [snip]
> 

