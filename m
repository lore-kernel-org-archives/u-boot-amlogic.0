Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E2C48287
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:12 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.77191.1703582199687818868
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Dec 2023 01:16:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KQ02jrPq;
 spf=pass (domain: linaro.org, ip: 209.85.208.44, mailfrom: krzysztof.kozlowski@linaro.org)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so4887853a12.3
        for <u-boot-amlogic@groups.io>; Tue, 26 Dec 2023 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703582198; x=1704186998; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3T9B07euRgfT1TYMWaav4yH7/4jAKP27oF8hHRrego=;
        b=KQ02jrPqS3yMqROQbgn7Tpxo039mHKlXZws3DjY7qE9c3vKwazFb7tLYKcZ89FJvn5
         d00z8RXih8K0SCNKT539Brz0o50UWN8UVAjNnkqsqXcefUUIU61aN91beGw8IOaA41GK
         g+1T0OqgEsZkxzLz/ZpCgrv9WNVbfploSJhoO4yPRmSC4OzaOp+NA6o2mBW/Pi+q8h25
         ph2mmzfzeuGu0A5DvqZH/ERQVoE7DAT3T6ZRqYFEIdf2TvBiBqbgcNLaj9gOFaZCVIwN
         S+oDlyZPpyp3yMaic2/6lulb2yFNXZHjgIHBtoXlwSjbp0pKz0bHRDESwwEtcINOOA/I
         KWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703582198; x=1704186998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3T9B07euRgfT1TYMWaav4yH7/4jAKP27oF8hHRrego=;
        b=UQ90e7bc5F6izWPNAhWqDzSQca4I+N+zk9d1OZ7uh3fmnL5Ip5BGklrajJyJWlQfI1
         biKFKFXog7oJcCHLZwC65uPFAWQe9rwI1TQ//CkWIajsmGssPF8m1w6GPCAgsp2zQAto
         TCMnuq+K+L/G/ZitJXh89aZI7dvCOKtTJXB9HxUd5niP3wVpjEat5tWFzr5kR7pe+BF+
         v0goaeYCvZ413ld8htK8/O/pKcFjBQyE6Eo8M1xle8M6xcF0FUrFKQdy20X9jighpA/v
         mx1+ED1QXep1KQDRGS4Akjg4V/QmAIPjwh6izqpq9fYjVYZ/6y1rEF/10fwSTkkkJxH8
         paCw==
X-Gm-Message-State: AOJu0YwbPeWB4XzkDRQtN3WhZ4EjhecZ4ONkgtEcuaCNAqztFCMDoSBd
	bM84AXFi9XZ4cOtrJZLigZIvsF0lgrR3yQ==
X-Google-Smtp-Source: AGHT+IGvxXZK/I01+75CnIhmKd22RFR/9pqd7Zcez99F3YWZ7mI0vqV5cpmy3oPHE4Sr7mWlzCJT5w==
X-Received: by 2002:a50:cd42:0:b0:553:ba1c:8a4d with SMTP id d2-20020a50cd42000000b00553ba1c8a4dmr3507840edj.103.1703582198006;
        Tue, 26 Dec 2023 01:16:38 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7d656000000b00552870b594fsm7101218edr.31.2023.12.26.01.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:16:37 -0800 (PST)
Message-ID: <23752cd4-d443-4a35-ab9d-bc637e1dbb56@linaro.org>
Date: Tue, 26 Dec 2023 10:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within U-Boot
To: Sumit Garg <sumit.garg@linaro.org>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh+dt@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
 <20231222-whole-canola-81240881c2e7@spud>
 <4a809aa2-0cc5-4ffa-a19f-06d69ae9e460@linaro.org>
 <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFA6WYPY7DmY3+Wf-=xbCpm11ub5BWTVc_C=SeSPVK0dVLTQ9w@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1966

On 26/12/2023 08:53, Sumit Garg wrote:
>>
>> The problem I want to solve is the kernel maintainers to be aware.
>>
> 
> Although Tom has already expressed in the other thread that U-Boot has
> been a long time user of upstream DT but if we want to make it more
> formal from an enforcement point of view then I liked Conor's idea. If

What did I write in my first email?

"Maybe create a subsystem profile and include it to
maintainer entries of such affected platforms?"

You really keep ignoring my emails, so I'll stop responding here.

Best regards,
Krzysztof


