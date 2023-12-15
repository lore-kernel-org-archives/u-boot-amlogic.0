Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF1FC46CC5
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:04 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.58146.1702626656481785344
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 23:50:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iKewCv+X;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: krzysztof.kozlowski@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bfa7f7093so398456e87.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 23:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702626654; x=1703231454; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBYf5C5JLYooP1qIl7TuyyWTINewyfi35Jj4MHvjh+M=;
        b=iKewCv+XylpvyRpWtBQp+4tPyRMk3dxyFBv4nng8DoXbYGCPXAW54YmZNbPiSLcZUJ
         vEhvfvWuoEIKboyaVzFXb1uTX8uhVCAKYhaOsQ15zd8LQ5Tgbyt6rytC6V9Wlt9LXNjD
         9M8Qe4WFUjlkcoVPKmKHRX/ZKbp0OoyAbEEsJPMOKIb8RUoBPv4Dpqtnv5fwh9njTm4H
         /hNUX+GuX57uF/dqcrQw+mFuxD+QGoGj/GtQhi81BY3hP/+BCGPs0qgnm9463Y/U8px6
         /Bm8hOajUY/mvcz6ygGuqdnkQvwF9inAM2sBDo/R/uTrXey4NNVu1g9lqIHeWPRNWvbc
         5rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702626654; x=1703231454;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBYf5C5JLYooP1qIl7TuyyWTINewyfi35Jj4MHvjh+M=;
        b=VqVOoIZl1HpjMAwHotJwxRLusv4SaDHNWaC0tgfn1IgwgKcwRtIBQypTE6pYuZMcGe
         /PFrqiWCq/9Zb/r6InGWswu/WG/Xhp1o810SKSURFDhocNNAP50XA8GlkR26ljnvXNNW
         T8UWrNAn8gp4ug1M0/hxbME46NgSwUIv9gojAsw4RIhZyhGvKv07OAtHd3RLR4WFrywo
         qU/DNVKBcjXRwDVT01U77LtOYHJiCHfXU5ngsW0ZT7BKUzV0Ds7zpOun8DWfxXKzDgAN
         CkSbIr9PmTWlzGZ+J5Rq8/lpJdMAcK1i1CjEE2CUy4DywbPRBRibrzWhxFWH7O54E5g2
         DXmg==
X-Gm-Message-State: AOJu0YwITKpvAqDHRhQ7DExbVc5K+iHdfngH1kY+By1k1Bmb04iGYEZY
	c0maDvjCSKrMM9nDFB7axlEWsQ==
X-Google-Smtp-Source: AGHT+IEvnYmaGnCQqMgDkvwxHA0ahmOGCHQzNRYjPwiY7GxzcMA7YV3MPXaujbALpUOxwCuaTTV0SA==
X-Received: by 2002:a05:6512:689:b0:50d:1968:9f8e with SMTP id t9-20020a056512068900b0050d19689f8emr7820001lfe.100.1702626654382;
        Thu, 14 Dec 2023 23:50:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id mt29-20020a170907619d00b00a0a5a794575sm10497533ejc.216.2023.12.14.23.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 23:50:53 -0800 (PST)
Message-ID: <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
Date: Fri, 15 Dec 2023 08:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
To: Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 14:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1934

On 14/12/2023 20:48, Rob Herring wrote:
>>
>> I think some of the important questions to ask are, how often / likely
>> are the breakages to occur? It seems like these days it's either:
>> - U-Boot had an early version of the binding and we already state we
>>   don't support backwards compatibility here. It should be on the
>>   maintainer to be proactive in this case.
>> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
>>   incompatible DTS change now". This too is hopefully the kind of thing
>>   that at least board maintainers will be more actively aware of needing
>>   to deal with in U-Boot, if it's really a problem.
> 
> A common issue in the kernel is with forward compatibility when
> platforms add new resources from a new provider. Then the kernel
> expects a driver for the provider and waits for the dependency. Of
> course, older kernels don't have that provider driver and so the
> dependency is never met. Not sure if u-boot will have similar issues?
> At least you should/could know if the provider driver exists or not.
> (The kernel doesn't because modules.)

If some U-Boot platform decides to aggressively sync with kernel DTS,
then probably the kernel subarch maintainer should be aware of it.
Mentioned forward compatibility issue is a result of assumption that
there are no out-of-tree upstream consumers of our DTS. I am certainly
not aware of any such consumer for Samsung. If someone told me (me
wearing Samsung hat), hey U-Boot now cares, I would start caring as well.

The usual argument of contributors wanting to break the backward and
forward compatibility, is "there is no other OS depending on this"
(recent discussion with Johan about order of interrupts:
https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
You need to tell the maintainers of that platform, that now they have
other OS/firmware/bootloader depending on DTS compatibility.

Best regards,
Krzysztof


