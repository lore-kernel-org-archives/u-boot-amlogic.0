Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F2C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web11.14673.1704901276521403688
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 07:41:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cx/08Gkj;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: seanga2@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4299c013215so20636691cf.0
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704901275; x=1705506075; darn=groups.io;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SArZp9pMAmgP2iEITMdp9D0gjBrKMnw6hOYYl6CohA=;
        b=cx/08GkjCOA/vCFjnbfJT1fajJfPWVG9xrfU1LE2QSHva0c9iBncKLw6SS79AVBvkN
         h23eENKtY4xhPWpX3hEvCkAeBmD3wyeAUXoDAN1OrDbKAYF6vhbA+XW/L9gq6LqHWmfC
         4W5iVzc6oBJhqojnbdRWptWXJsW3jkOzBPqLvs7rHr02dAkxG19mFn6pZ0GqughLV9z+
         jAKStV1I/g6LWcdPHv5w7xMj8xZwJVQBuHXCPpyojRPv5OtyWu59FiJPA0DjbG3V6UHr
         a6tOqzZ+Ucc5zJg/4XmPwFGHkDV8PKPODwyFxtJuPWzAyakr0nw3bEC+hP/e5L5q3jGi
         c8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901275; x=1705506075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SArZp9pMAmgP2iEITMdp9D0gjBrKMnw6hOYYl6CohA=;
        b=P0TpSZqXoWdzaJEkR0zOHs2HnCEnK+6G5bPeGdasc/Xk8IZ7tBUI8XWCjeyik5Wj5U
         LWgJYxvy0ePWnIMgOI40Q1DKXfxRgOMm1UR2WgZ6quVHMS8xx0HaHJot30HxUXHwT+yx
         qBh1p0pp0UaUaIYM2R/NGXbKJNbmPLluLDdaqx6eQqRh8f1zuIgK9QL6jsk7BHp1u/GV
         NFFZ7gcTZ2mEpOV+PCMhFte7mWCkqND4BC0UJ+KqmuEnq9qA7wYQf1iB7Bk+DA1yUSGT
         ZZbqA1TEPy5fqNnSH5LYRGjgTSjL8/8ROBHKDUkEp+ZHtxBZ8K/d1FBQ/kvx3RcyjDYu
         KKZw==
X-Gm-Message-State: AOJu0YwH8+ZjfD1nVGtvExfdtp70Obn2aGoscH5meFcvQA5iPVFtOLkz
	sv0aUgehKO++itLq0Sf1y+0=
X-Google-Smtp-Source: AGHT+IHZqgJt+HI64+jyhpA8MyD8T46LfOUm21Sl0Nem7wr+EP2h4Ws2Oz47LANOlmNJnLLRH2PucA==
X-Received: by 2002:ac8:7d0f:0:b0:429:b8cc:8697 with SMTP id g15-20020ac87d0f000000b00429b8cc8697mr391469qtb.36.1704901275531;
        Wed, 10 Jan 2024 07:41:15 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net. [108.48.157.169])
        by smtp.gmail.com with ESMTPSA id ge8-20020a05622a5c8800b00429bd898838sm85494qtb.47.2024.01.10.07.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:41:15 -0800 (PST)
Message-ID: <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
Date: Wed, 10 Jan 2024 10:41:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
To: neil.armstrong@linaro.org, u-boot-amlogic@groups.io,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
 <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2071

On 1/10/24 04:23, Neil Armstrong wrote:
> Hi Sean,
> 
> On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
>> Amlogic SoCs embeds an hardware clock measure block, port it
>> from Linux and implement it as a UCLK_CLK with only the dump
>> op and fail-only xlate.
>>
>> Based on the Linux driver introduced in [1].
>>
>> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
>>
>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Should I take this via the amlogic tree ?

If you like.

I will be doing a PR sometime before the merge window ends.

--Sean

