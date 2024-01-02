Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E41C47DA6
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:22 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.28043.1704199863203181836
 for <u-boot-amlogic@groups.io>;
 Tue, 02 Jan 2024 04:51:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=N7pPZ9lu;
 spf=pass (domain: linaro.org, ip: 209.85.221.54, mailfrom: caleb.connolly@linaro.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3368ae75082so4938141f8f.1
        for <u-boot-amlogic@groups.io>; Tue, 02 Jan 2024 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704199861; x=1704804661; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhWCkr7KYy/BtOXz9Pfz7Vb43dnCbhDWjZp9qtUHu0w=;
        b=N7pPZ9lux3aHOlHIFJs7iq26tTyychDhtWtceeuXg/R+R5I+yy8bAoOfxCjYkYn0Rc
         SO+pZslp0GmvT0dK23e+b5BDWAc+zWtDyfqLVjXGb5l3swc8OfhtmXxeNUcfSBF92z2D
         dXdlxtFRpcQx0RpeR5v0NjBwi98U7U52MoUyhJtY29gDS9lUc9ybfxGXFI3rI3FnmvnU
         mtKRG1Hd2esqffq7BvG78Y29qJ96Iq71NlC6iz6BX/4lbvY6HHUNp7VfyRC0QxoEq0/8
         COptfhz7VHV/G3Fugb77vyn4d/98eDXGYVUbX2SxcijDatH2oX9vm+gNkGngbCeJ3fHN
         6gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199861; x=1704804661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhWCkr7KYy/BtOXz9Pfz7Vb43dnCbhDWjZp9qtUHu0w=;
        b=FigZSeHCQPXVRkU/5uEQCha+6Pn1plxbB9NAaM7gxxZ/KX+5/dW6upe93a8JyhZZZF
         QCWMxlA6vorNMqO2iYdwOB6UUgY6KKw/z3MDaUxW1FCH0NZ2177VNBsADNr4xrdxjkPn
         XYCY2IEhS/DPX4SvzFQ6PDL58Y5pdX+AeXKmVhcZVXkXUFzZogVamELD4ZliLqdCiCVy
         KSH6vzXpQ89iS2En0vJsOJ+2iH0QEbaQd4GC6OTnl6NPigwTIjHbkui5eYtQzYBcVQgb
         MJZ1PvrsNoV2wIjM076PAdLoChWIy8hnm823kXolQVQUUnCqHJj24VDZwqp+9xUCtnhT
         UJ5Q==
X-Gm-Message-State: AOJu0YyOdJfTvma5p995cwPmr9ZqwpripfPrcdr1rLVOpqaAvjtEb1Vo
	N25DjUEiBrcycmuTJ0fTry2/GH/HHXgDwQ==
X-Google-Smtp-Source: AGHT+IGxXNdX7GI0iRHERB0fiEQkwsAgzM6e5ETceMxKfQby68vcFIYP6EYpI4TQNL1XfsVERmBaxQ==
X-Received: by 2002:a05:600c:198f:b0:40d:5f64:748b with SMTP id t15-20020a05600c198f00b0040d5f64748bmr4342264wmq.61.1704199861648;
        Tue, 02 Jan 2024 04:51:01 -0800 (PST)
Received: from [172.30.140.140] (gateway.braid.business. [82.66.147.134])
        by smtp.gmail.com with ESMTPSA id b16-20020a056000055000b003372dcd739csm9176259wrf.86.2024.01.02.04.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 04:51:01 -0800 (PST)
Message-ID: <a2393800-ea34-48f4-9300-5a2821cec7e7@linaro.org>
Date: Tue, 2 Jan 2024 13:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
To: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>, sumit.garg@linaro.org,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
 <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2018

[snip]
>>>
>>>>> However, I am very much in favour of having a generalized U-Boot
>>>>> image. This might become true in some cases like U-Boot acts as a
>>>>> second stage bootloader for a particular SoC which is a unified image
>>>>> where the prior stage passes the DT to it. The Qcom effort in this
>>>>> direction can be an example here.
>>>>
>>>> Not relevant to the topic at hand, perhaps, but Qualcomm uses a
>>>> closed-source blob to jump to U-Boot and is certainly not an example
>>>> we should emulate. But yes, passing a DT to U-Boot proper can be
>>>> useful.

Just to chime in here, this limitation is true for production Qualcomm 
devices where all of the bootloader blobs are signed by the OEM (true 
for most phones). But for development platforms we can do better. I 
expect this is a topic we will keep on coming back to, so I'd like to 
just take the time to explain some of the technical details on Qualcomm 
platforms, as there is a lot more nuance than you might be aware of.

The modern Qualcomm boot chain is (roughly) PBL (bootrom) -> TZ/el3 -> 
sbl1 (secondary bootloader) -> hypervisor -> XBL_Core (UEFI impl) -> ABL 
(LinuxLoader.efi app) -> Linux

On production devices the best we can do is replace "Linux" with U-Boot, 
and if we're lucky then we can leverage features of ABL to simplify 
things like DTB selection (it supports picking from a bunch of 
concatenated DTBs, but we can just as easily implement some similar 
feature in U-Boot ourselves).

On a development board I have been successful in replacing the 
hypervisor with a stub and replacing XBL_Core with U-Boot - giving us 
EL2 and removing the entire proprietary UEFI stack. There is no reason 
that we can't go further than this.

The Qualcomm Chromebooks all run Coreboot, for sure on those it would be 
possible to use U-Boot much earlier (although there is still the 
proprietary XBL_Sec TZ blob).

The Dragonboard410c (and MSM8916 SoC overall) has been pretty much 
entirely ripped open thanks to Stephan Gerhold and the msm8916-mainline 
project. On these devices it is easily possible to run U-Boot as a 
first-stage bootloader (at least to the same extent one can on the more 
open ARM platforms, or even more open if you wish). Although the 
bootloader of choice for most of these devices is a home-grown fork of lk.

For new SoCs, with the number of Qualcomm devices out there, and 
communities like postmarketOS enabling support on so many of them... My 
hope is that we will quickly see phones being the most common Qualcomm 
devices supported by U-Boot. While it is indeed extremely unfortunate 
that we can't replace the bootloader entirely, using U-Boot as a fresh 
slate is still extremely liberating (EFI! Firmware updates! No need for 
distro hacks to update the kernel! Multi-boot! etc...). I wish we could 
focus more on how U-Boot will make supporting Linux on these devices SO 
SO much easier, and less on how broken the (usually impossible to 
modify) bootloader they shipped with is.

While almost all of the boot chain I explained above is proprietary, the 
ABL source code is publicly available (although most device vendors 
don't publish their modified production version, I suppose for fear of 
embarrassment). The statement "Qualcomm uses a closed-source blob to 
jump to U-Boot" is at the very least an oversimplification.

To be contrarian, here is an example of a phone vendor who do publish 
their ABL source code, here is the code that runs Linux (or U-Boot in 
our case).

https://github.com/SHIFTPHONES/android_bootable_bootloader_edk2/blob/sos-3.x/QcomModulePkg/Library/BootLib/BootLinux.c#L1039

My point is, there is a lot of nuance and complexity here, and we need 
to be careful about what exactly we're referring to.

Kind regards,
Caleb

>>>
>>> It's a very valid use case we need to continue to support. And to save
>>> Mark from having to repeat himself, again, it's intentionally and not
>>> changing, how the Apple M1/M2/etc platforms boot. I'm pretty sure the
>>> fact that one can use U-Boot this way is part of how engineers get proof
>>> of concept work done to show that if they had U-Boot available then they
>>> could also support X/Y/Z easier. And maybe they'll be able to longer
>>> term push internally to use bloblist to pass things along.
>>>
>>> Heck, trying to not go too far off on a tangent, maybe the m1n1 loader
>>> can implement both conventions, as both Linux Kernel[0] and Bloblist[1]
>>> use x0 for device tree, but bloblist has x1 non-zero and Linux does not,
>>> so both could be present here? Or is there some incompatibility I don't
>>> see on quick skimming?
>>
>> Right.  Some time ago I suggested Simon to lobby the Linux kernel
>> folks to change the arm64 Linux kernel entry convention to state that
>> x1 can be non-zero in which case it points at a bloblist.  If that
>> happened I'd probably do the work to make m1n1 pass a bloblist.  And
>> it would probably make the folks who want to directly boot a Linux
>> kernel from TF-A (without going through U-Boot) happy as well.
> 
> I got a lot of push-back on that. Perhaps there might be some
> willingness if it is explained that Linux doesn't need to understand
> the bloblist, just tolerate it being there. There are probably other
> people who will be more successful at pushing for kernel changes.
> 
> As you know, the handoff protocol is designed such that you don't need
> to decode the bloblist to find the devicetree. BTW I would like to put
> the ACPI/SMBIOS tables in the bloblist as well (with EFI we would
> provide pointers into the bloblist for Linux to use)
> 
> Regards,
> Simon

-- 
// Caleb (they/them)

