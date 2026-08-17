Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A2C61DC4
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 12:53:35 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.281.1786987550811602308
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Aug 2026 10:25:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: tanurelinux@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2357808f8f.0
        for <u-boot-amlogic@groups.io>; Mon, 17 Aug 2026 10:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786987549; x=1787592349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFo0gfc51SFOfFL7GnMdVFsfPa0CU7VhwBUDHAb31Xg=;
        b=bb9drNT/FjFTfOsZoqWeXO6Px30OTRz/ifIQxfC3OuJAhZOgH9zy9+mw8ngvEgU9Eg
         9Gqkdd2uqJuDqujAOxePwBQP//h6jIxUuv99hTjfCf7X3466y90EqNunuHqSkl93C6Dq
         W2EsHb57eBmoHpVFBMBlvSC5XDzphJTNKqYGed7/jzndXgGAzsbDeKfIFxIPx2wWt6Oj
         WqRug3WQ3HuBKuITxrcrurcf6Kf95F/WUAkiRdCzPDkGZrsc3L/mAEtyLRNtOvFac9rD
         BunpJ6LDkOESA1GI+bIHycg+gAv0ijLL37VpAPXFml/HQgTh9S43NBqipd2XwSUk8wMI
         7rYg==
X-Forwarded-Encrypted: i=1; AHgh+RrhA4EBGNTzUxV8UJ4zrSmEOB/76Bi0wT9asvoP9twjj2QuAz0s7zvOITiG2E9N4WofQeJgASEKi+Q8KLXiWA==@groups.io
X-Gm-Message-State: AOJu0Yz14vn+KHxY/p6ELtSw3NyJTX4bpzYtzdp0SORKFt/QYDNa/vzt
	Et6fwCi6kel5zagZrZCQI0r1mV88IgrKWWgZo9GJdFA50C3eqaX3Cd61
X-Gm-Gg: AR+sD10ZhjwnF9cplIZHA/tkEG1r6nJPid3Y6XuIUiEiDeSyIvkuBXGM5WJPPA/Qmx1
	D3VCJrbZgVpmTWiE2iQ3aWhCczG8EUie7EOF6g+QqtcKHmDdLcy+9MHW9PB92VtfvyUgMG8frVt
	Na6K8xySh/SAwb5MM9hj8BTOdiALy8cabDIZeqS3ZhNSA5i9a6sbH+XHfvI3Zsuv8AgpcBhgwZN
	1d462/7XAauk5YaCkgfAGxrhSZCONsx8WtInEaGcAwDYSFhvdiKHyakZvo0aonLwUT635g0Zdps
	L7ymCFFQRjgwqGy9zUWxpdH+yUaeMVvYUE4hTp9inYOertzQ5zy/m1zDNOr7i2o9KPiN3SJwmb5
	uMh903EUdsOB5PQ+KGOg8XhudqSEVTH7o0KzVSw5U+kV3c7mFh64rVjcye6lfRMtPYkYlT9l/Gg
	HyRKlmqSfFfPBAVQeRGcuMlgPlcyCN24FKJltbkyE2kM+uER32NtElETMvCpzzKgB3Ka/dz1RYG
	EOVZANjZ7h66QswwEJ3f5Vydz4E4V7v
X-Received: by 2002:a05:6000:46d4:b0:481:f33d:6445 with SMTP id ffacd0b85a97d-482a907b955mr2168213f8f.7.1786987548797;
        Mon, 17 Aug 2026 10:25:48 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c55bsm5240047f8f.20.2026.08.17.10.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 10:25:48 -0700 (PDT)
Message-ID: <d2de2aa9-328b-4779-a6a2-bf2f54cca441@linux.com>
Date: Mon, 17 Aug 2026 18:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
 <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
 <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <d7a85b8f6f65f7caabb45ebaff5380335030bb2f@postmarketos.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 24 Aug 2026 12:53:35 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3033

On 16/08/2026 18:41, Ferass El Hafidi wrote:
> (didn't mean for this to be off-list sorry about that)
> 
> On Sun, 16 Aug 2026 10:42, Lucas Tanure <tanure@linux.com mailto:tanure@l=
> inux.com > wrote:
>> On 10/08/2026 15:01, Ferass El Hafidi wrote:
>>> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io"=C2=A0
>>> <tanure=3Dlinux.com@groups.io mailto:linux.com@groups.io > wrote:
>>>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>>>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>>>> baud rate register, while older SoCs divide the crystal by 3. Add the
>>>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>>>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>>>> the configuration the vendor BL2 programs on T7 hardware.
>>>>
>>>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>>>> div-by-2 on G12A, but both modes work there and switching would risk
>>>> regressing boards that have shipped with div-by-3 for years.
>>>>
>>>> Also drain the transmitter before changing the baud rate so in-flight
>>>> characters are not garbled, as the Linux driver does.
>>>>
>>>> Assisted-by: Claude:claude-fable-5
>>> =C2=A0
>>> As I understand it, LLM-assisted patches are not welcome in U-Boot rig=
> ht
>>> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-=
> cat/
>>> =C2=A0
>>> AFAIK there isn't an official AI policy yet, but it seems the concensu=
> s
>>> on that matter is currently "please don't". Sorry.
>>
>> Ok, I will drop this line.
>>
> 
> Please do not drop this line. I appreciate the transparency towards your
> use of AI. I would wait for someone more knowlegable about AI use
> discussions to reply.

Ok, I will reply with v2 with all comments fixes and keeping the Ai 
line. And I wait for the Ai talk.

> Best regards,
> Ferass

Thanks
Lucas

