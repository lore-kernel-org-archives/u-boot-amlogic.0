Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.12471.1679315110734055734
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 05:25:11 -0700
Received: by mail-wm1-f46.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso7369966wmq.5
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679315109;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hbYe87C1ax7n2gUxfYefOp4CtanFQWHmul8SCrZFOBg=;
        b=Jnuru+ugnRyx+FSA1ergwvCdAydNXxsWVv3Ri6zD2IU2rKfgHJbCGh3M17afwv1oQB
         Cum6Un6UsIqsOvgxT0ZQ8bpk3qXnSK8nV6J0H4KWm25XaYwR7KDa4ahmn7+UXuoaug0A
         OH1cb93hharg0gk3KFjPVWbiaCXowamGonQM6uCDE/Kunob9J6P165fE5JyNcX9WZ4np
         q/jwJEQlrM4zTqlI/R+GBczM8Ceea26CmFpMl7PHn/oA8OA0TDMmFuaI5N/lDLVwdymX
         aut9ZNKDh4dhxIITz8JeZw2oRJw10/OKGvwdGJeQPYQ2iNffTLNHuMog+JviFvfSIRSS
         W+Ew==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <4a49100c-2ab4-09f5-780c-1a734f0bd1f1@linaro.org>
Date: Mon, 20 Mar 2023 13:25:08 +0100
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 30/33] doc: boards: amlogic: add documentation for BananaPi CM4IO
References: <20230320114609.930145-1-christianshewitt@gmail.com>
 <20230320114609.930145-31-christianshewitt@gmail.com>
 <5e29634d-0751-5b1b-5bfa-4a85f536f672@linaro.org>
 <3CBB7476-13B0-410F-9F19-1323157F1FFC@gmail.com>
In-Reply-To: <3CBB7476-13B0-410F-9F19-1323157F1FFC@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>

On 20/03/2023 13:23, Christian Hewitt wrote:
> 
>> On 20 Mar 2023, at 4:13 pm, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> On 20/03/2023 12:46, Christian Hewitt wrote:
>>> Add build instructions for the BananaPi BPI-CM4IO carrier board with
>>> BPI-CM4 module.
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>>   board/amlogic/u200/MAINTAINERS       |   1 -
>>>   board/amlogic/w400/MAINTAINERS       |   2 +
>>>   doc/board/amlogic/bananapi-cm4io.rst | 152 +++++++++++++++++++++++++++
>>>   doc/board/amlogic/index.rst          |   1 +
>>>   4 files changed, 155 insertions(+), 1 deletion(-)
>>>   create mode 100644 doc/board/amlogic/bananapi-cm4io.rst
>>
>> <snip>
>>
>>> +
>>> +U-Boot Signing with Pre-Built FIP repo
>>> +--------------------------------------
>>> +
>>> +.. code-block:: bash
>>> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
>>> +    $ cd amlogic-boot-fip
>>> +    $ mkdir my-output-dir
>>> +    $ ./build-fip.sh bananapi-cm4io /path/to/u-boot/u-boot.bin my-output-dir
>>
>>
>> This should be bananapi-m2s since the same is used, or we should duplicate it for cm4io/cm4.
> 
> https://github.com/LibreELEC/amlogic-boot-fip/tree/master/bananapi-cm4io
> 
> ^ It’s the same FIPs that were submitted for M2S but for packaging
> reasons I cloned them (users struggle to find images not explicitly
> named for their board). I’ll submit patches for the M2S and M2-Pro
> boards once this series is accepted (hopefully).

Ack, so no changes needed then !

> 
> Christian

