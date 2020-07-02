Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.1856.1593676752425255317
 for <u-boot-amlogic@groups.io>;
 Thu, 02 Jul 2020 00:59:13 -0700
Received: by mail-wm1-f67.google.com with SMTP id 22so25680545wmg.1
        for <u-boot-amlogic@groups.io>; Thu, 02 Jul 2020 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iBqaXY857+Aahgu/Gf5E5TGAw9YKSDRAM+HpyZD665o=;
        b=wHqMLPlSQBqsFkSXSj/Py0MbrYy+nAleevcNWTGGitVZ6Bv1omhtKXqh17e090anZP
         i6roBPkSj/Vy+fBivxBnBaYO3EhWlEsdDCAo+vpGVQ7yVoZW9/Gt3jS4izo/aFeqc1zY
         h+ZMzE+W5fzH/vYy34SaV02JRhgqthhphb6wexFW6kx7F4n44CPBmjmBiD9gVwk5kAUd
         /w60bzJWvkRs77jZloXUUwIOcU9ycalcQPSwffMh8NNN0luCpyMneAAK/zeWjWwS+Dzg
         tXIfkfWAW0JVCVcAJQWZLH0Cmq0Julq9pWt6nFfs47F2skSzYxKOV5hDwiDnVsk+mJDY
         8Sgg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] u-boot support for ODROID-C4
References: <20200505202217.7849-1-b.galvani@gmail.com>
 <CANAwSgT3AcsQkE47CusmC_rCnVo_FRuWaRbivUyxzPXFSjCmSA@mail.gmail.com>
 <bf6bf3e9-ef60-9d3f-4d32-5b79f5b94b4b@baylibre.com>
 <CANAwSgR8jX+Z+xZ3EXHQbq80dswn6WjaF-vyJHjyxQREVf+Mfg@mail.gmail.com>
 <eb5df59e-4d45-99d1-c131-bc630fd772d8@baylibre.com>
 <CANAwSgQu6c0V-ujGk3R3BkZTRY_Z7KPjP1BF2srnYYNQjdb9UA@mail.gmail.com>
 <32f06e45-4425-6970-e173-791ff87ae9e5@baylibre.com>
 <CANAwSgSH-ZzE+TsrjNUp+OL4w3xDg7RMc9HOaKU+Yh-hu=1ZbQ@mail.gmail.com>
 <b8b89fe1-9fe8-fc8d-3e1a-1e44b9417719@baylibre.com>
 <CANAwSgRk=oNZ46OBdKqp_BOKyOUGhMnQO2D1mSusH-a9xCBtuw@mail.gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <19112043-cb93-eaf5-5fae-b628c1d6b3bb@baylibre.com>
Date: Thu, 2 Jul 2020 09:59:07 +0200
MIME-Version: 1.0
In-Reply-To: <CANAwSgRk=oNZ46OBdKqp_BOKyOUGhMnQO2D1mSusH-a9xCBtuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Anand Moon <linux.amoon@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 01/07/2020 18:09, Anand Moon wrote:
> Hi Neil,
> 
> On Wed, 1 Jul 2020 at 20:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 01/07/2020 16:43, Anand Moon wrote:
>>> Hi Neil,
>>>
>>> On Wed, 1 Jul 2020 at 18:38, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 01/07/2020 13:31, Anand Moon wrote:
>>>>> Hi Neil,
>>>>>
>>>>> On Wed, 1 Jul 2020 at 13:22, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 30/06/2020 18:02, Anand Moon wrote:
>>>>>>> Hi Neil,
>>>>>>>
>>>>>>> On Tue, 30 Jun 2020 at 18:30, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 30/06/2020 13:33, Anand Moon wrote:
>>>>>>>>> Hi Beniamino,
>>>>>>>>>
>>>>>>>>> On Wed, 6 May 2020 at 01:53, Beniamino Galvani <b.galvani@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> these two patches add initial u-boot support for Hardkernel ODROID-C4.
>>>>>>>>>>
>>>>>>>>>> https://wiki.odroid.com/odroid-c4/odroid-c4
>>>>>>>>>>
>>>>>>>>>> Beniamino Galvani (2):
>>>>>>>>>>   arm: dts: import ODROID-C4 device tree
>>>>>>>>>>   boards: amlogic: add ODROID-C4 support
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you respin this patches, I would like to see these get merged in
>>>>>>>>> the current u-boot release
>>>>>>>>>
>>>>>>>>> -Anand
>>>>>>>>>
>>>>>>>>
>>>>>>>> The Odroid-C4 could re-use the new Odroid-N2 board support I submitted at [1]
>>>>>>>>
>>>>>>>> Anand, is the MAC address stored stored the same way on the C4 ?
>>>>>>>>
>>>>>>>> Neil
>>>>>>>>
>>>>>>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/
>>>>>>>
>>>>>>> I gave this patches a try on latest u-boot but I cannot make my Odroid
>>>>>>> C4 to boot up uinsg microSD card and eMMC
>>>>>>> Here are the logs.
>>>>>>
>>>>>> The PHY config must be wrong and it misses the -u-boot.dtsi to enable HDMI.
>>>>>>
>>>>>> Can you test my custodian test branch with my C4 support patchset ?
>>>>>>
>>>>>> https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic/-/tree/u-boot-amlogic-test
>>>>>>
>>>>>> This one is used in Armbian 5.4 release and our KernelCI lab.
>>>>>>
>>>>>> Neil
>>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>> There seems to be a typo in the build instructions in #
>>>>> doc/board/amlogic/odroid-c4.rst
>>>>> instead of *g12b*, it should be *g12a*
>>>>>
>>>>> See below I get following build warning, which I fix locally,
>>>>>
>>>>> ./buildc4c.sh: line 78:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>> ./buildc4c.sh: line 81:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>> ./buildc4c.sh: line 84:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>> ./buildc4c.sh: line 87:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>> ./buildc4c.sh: line 90:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>> ./buildc4c.sh: line 92:
>>>>> /home/amoon/mainline/u-boot/amlogic/w400/odroid-c4/fip/g12b/aml_encrypt_g12a:
>>>>> No such file or directory
>>>>>
>>>>> After that fix I am able to boot my board using eMMC and microSD card.
>>>>
>>>> Thanks for testing, I'll push my serie rebased on v5.8-rc1 and fix this typo.
>>>>
>>>> Neil
>>>>
>>>
>>> Thanks, I see the same issue with random mac address just like N2.
>>
>> Yes, my branch was not using the N2 board support with eFuses MAC readout,
>> can you test my last patchset I just sent ? It should use the MAC from eFuses or
>> generate an unique address with the SoC serial number.
>>
> Thanks
> 
>> Please apply the patch in [1] before the new Odroid-C4 serie.
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20200618144037.23392-1-narmstrong@baylibre.com/
>>
>> Neil
> 
> I do not know the reason but your patches are not showing up on u-boot
> patchwork.
> 
> [0] https://patchwork.ozlabs.org/project/uboot/list/

Good question !

Neil

> 
> -Anand
> 

