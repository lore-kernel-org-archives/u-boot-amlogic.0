Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.3715.1692692667421629143
 for <u-boot-amlogic@groups.io>;
 Tue, 22 Aug 2023 01:24:27 -0700
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-313e742a787so2537051f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 22 Aug 2023 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692692666; x=1693297466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xky6lykeXWJ7KdcEhtptv9VMBp2Elqi4FU3Ze9PGhHA=;
        b=PFEEc9uD+KzxWd4Nu/dQkGAgg9hGQwhyKfegCwVObgPSwFFkTWAOBHeoy/4qLpgBdk
         AG+UdoDU/+6k4QZbofEz+Xpj4y52hgcMz6vNHKBbmAetUwpc4kZyR/fwxxJ5w/pi6ixc
         y9Xq+s9H9/1CajOCvkntpexze8mxBtmLQC0qRAzO/dbOXJ9Caji1o9V//nYNkym13exy
         4F6r62hgpNUR8TWcl65jvLn4lzf99vTy5Qkb6oWzEglYzMupXUnd78G+RG1ypYoTW1ZW
         R3SO1DbPpAOckBphkh+4sYk4Q7WYD6lqi3NReQbb6gLDIl+uzdO1eimRPbCWH0cupYdM
         0mww==
Return-Path: <neil.armstrong@linaro.org>
Message-ID: <7a9f5cf0-d7b2-4477-8a56-a3aa7f764e2a@linaro.org>
Date: Tue, 22 Aug 2023 10:24:23 +0200
MIME-Version: 1.0
From: "Neil Armstrong" <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor driver
References: <20230706112020.24528-1-avromanov@sberdevices.ru>
 <20230706112020.24528-2-avromanov@sberdevices.ru>
 <CAPnjgZ1AqUYxAU0BNhxZLXc+y_h5XKbuoLBDekbkqzaJeon-1Q@mail.gmail.com>
 <20230707084313.vecmsr5z3aj4gqxs@cab-wsm-0029881>
 <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
 <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
 <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Glass <sjg@google.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Alexey Romanov <AVRomanov@sberdevices.ru>, "narmstrong@baylibre.com" <narmstrong@baylibre.com>, "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, kernel <kernel@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

On 21/08/2023 21:11, Simon Glass wrote:
> Hi Neil,
> 
> On Mon, 21 Aug 2023 at 03:16, neil.armstrong@linaro.org
> <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 16/07/2023 01:40, Simon Glass wrote:
>>> Hi,
>>>
>>> On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>>>
>>>> On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
>>>>> +AKASHI Takahiro
>>>>
>>>> Me?
>>>
>>> Yes, I'm asking for your help to try to clean this stuff up.
>>
>> The thread is long and hard to answer directly, but as AKASHI
>> said there's no point to add a SMC class since it's only the message
>> passing instruction, and there's no point using remoteproc since the
>> firmware runs on a separate secure state of the same CPU.
>>
>> And I don't see how we can actually define a finite set of ops because
>> none of the secure firmware interfaces has even similar functions.
>>
>> So a new UCLASS for each firmware interface should be added, not sure
>> this is scalable or required since those firmwares are mainly SoC or
>> vendor specific, except the PSCI or other ARM specific interfaces of course.
>>
>> So I think UCLASS_FIRMWARE is good enough since it avoids using UCLASS_MISC,
>> but it should be probably documented somewhere that the ops are implementation
>> defined.
> 
> Yes it needs docs...but what exactly is the 'firmware' uclass? I
> assumed it was for loading firmware into a device, but it seems that
> it is something else?

Nop, it's based on the same "firmware" naming as Linux, which is an interface
with a system control firmware like PSCI, SCPI... not to interact with loadable
co-processors.

Systems do have multiple interfaces implemented like PSCI, SCPI, OPTEE and other
vendor specific ones like Alexey is changing, all via the same instruction call.

> 
> Perhaps we should have a UCLASS_SVC (supervisor call) or something
> like that, rather than continuing with firmware?

I have no opinion on that, I don't think the call type is significant here.

Neil

> 
> [..]
> 
> Regards,
> Simon

