Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web10.21058.1593608920390754515
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Jul 2020 06:08:41 -0700
Received: by mail-wr1-f66.google.com with SMTP id q5so23740517wru.6
        for <u-boot-amlogic@groups.io>; Wed, 01 Jul 2020 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MxjOctL8FSUqCNpzGMgRo0ce5+g447QkiCZJPXwmQtA=;
        b=Jj04qmbVoOeJim2SHmQ34KH7QdyOKjN9uqFNQbuB5f+nbDxfyFYRUB3N1v1/RzC2i4
         qiHEiaRaa3jJN9KG/Qru5OpYvZLURxmaxQgrSX7wDz34N44QkdnnzUF6HhTa8DvhiOWh
         dO3UXOTFtJe0kPeyAh5lrLwaJnf+0bOeOjIc1q8BjR0heWzs+C8TDkmIQh0YQCS5/Zcl
         osSul8WeHbZJzVd1Wzy97J+BLCmH/RD1jYJNqI1noeupbTWVQHQuXG3KwR8WIdlC9QiS
         hRz0yVhUF+YaZBRb4Ra/95KsQD/NJgztQ0tG4L8gPekKyhR+KQyEJREfziYwClYHevlJ
         rxWg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
References: <20200505202217.7849-1-b.galvani@gmail.com>
 <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
 <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com>
 <CANAwSgR8jX+Z+xZ3EXHQbq80dswn6WjaF-vyJHjyxQREVf+Mfg@mail.gmail.com>
 <eb5df59e-4d45-99d1-c131-bc630fd772d8@baylibre.com>
 <CANAwSgQu6c0V-ujGk3R3BkZTRY_Z7KPjP1BF2srnYYNQjdb9UA@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <32f06e45-4425-6970-e173-791ff87ae9e5@baylibre.com>
Date: Wed, 1 Jul 2020 15:08:36 +0200
MIME-Version: 1.0
In-Reply-To: <CANAwSgQu6c0V-ujGk3R3BkZTRY_Z7KPjP1BF2srnYYNQjdb9UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 01/07/2020 13:31, Anand Moon wrote:
> Hi Neil,
> 
> On Wed, 1 Jul 2020 at 13:22, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi,
>>
>> On 30/06/2020 18:02, Anand Moon wrote:
>>> Hi Neil,
>>>
>>> On Tue, 30 Jun 2020 at 18:30, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 30/06/2020 13:33, Anand Moon wrote:
>>>>> Hi Beniamino,
>>>>>
>>>>> On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> these two patches add initial u-boot support for Hardkernel ODROID-C4.
>>>>>>
>>>>>> https://wiki.odroid.com/odroid-c4/odroid-c4
>>>>>>
>>>>>> Beniamino Galvani (2):
>>>>>>   arm: dts: import ODROID-C4 device tree
>>>>>>   boards: amlogic: add ODROID-C4 support
>>>>>>
>>>>>
>>>>> Can you respin this patches, I would like to see these get merged in
>>>>> the current u-boot release
>>>>>
>>>>> -Anand
>>>>>
>>>>
>>>> The Odroid-C4 could re-use the new Odroid-N2 board support I submitted at [1]
>>>>
>>>> Anand, is the MAC address stored stored the same way on the C4 ?
>>>>
>>>> Neil
>>>>
>>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/
>>>
>>> I gave this patches a try on latest u-boot but I cannot make my Odroid
>>> C4 to boot up uinsg microSD card and eMMC
>>> Here are the logs.
>>
>> The PHY config must be wrong and it misses the -u-boot.dtsi to enable HDMI.
>>
>> Can you test my custodian test branch with my C4 support patchset ?
>>
>> https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-test
>>
>> This one is used in Armbian 5.4 release and our KernelCI lab.
>>
>> Neil
>>
> 
> Thanks.
> 
> There seems to be a typo in the build instructions in #
> doc/board/amlogic/odroid-c4.rst
> instead of *g12b*, it should be *g12a*
> 
> See below I get following build warning, which I fix locally,
> 
> ./buildc4c.sh: line 78:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> ./buildc4c.sh: line 81:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> ./buildc4c.sh: line 84:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> ./buildc4c.sh: line 87:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> ./buildc4c.sh: line 90:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> ./buildc4c.sh: line 92:
> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
> No such file or directory
> 
> After that fix I am able to boot my board using eMMC and microSD card.

Thanks for testing, I'll push my serie rebased on v5.8-rc1 and fix this typo.

Neil

> 
> -Anand
> 

