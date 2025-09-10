Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E3CAC58E
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 12:15:29 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by mx.groups.io with SMTP id smtpd.web11.29416.1757536253435771860
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 13:30:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@canonical.com header.s=20210705 header.b=RvOquAq+;
 spf=pass (domain: canonical.com, ip: 185.125.188.122, mailfrom: heinrich.schuchardt@canonical.com)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A6B9A46634
	for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757536250;
	bh=WWtJEueR8toJzVWql32mzVcG/XLTCSyDwFAanKV5stM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=RvOquAq+XUIwz2Vy+UXFE0nJptOu6VdFAAyhedGK5h7xcKuQVDrTv9MvTdFpodpn/
	 b4hkY3Hok9vA+G+2vsHY3bgMZu1yQkX0rLBssz1/mJStx4mZMBq80z1AogmOUGHkYr
	 dDXdBKYeb+j6G/GIvCXWSGA8QP6YpK72EaNO4F7nsYZ8opSrs9DblJPJX21rJRnJFD
	 WWNIyPPfOOITTCs7BgIUv1nYEFAnolP1fewuAjm0oxkzg0bG1r+pQupBa9bMIjINRi
	 STny4Y5KyqRcBAFCgNkkpDdc9Qv9oMN0f/m+aF6MhcmTvVFt6BCgTbz2HVniDioE/g
	 SPs5QsZO/60Ow==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afe6216085aso23666b.1
        for <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 13:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536250; x=1758141050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWtJEueR8toJzVWql32mzVcG/XLTCSyDwFAanKV5stM=;
        b=RH2IBkaXKqDcuS0eAYvk8rNAs00S2ZsaujkTFKdDkMRPPssoA3Y3IlYjpu5Jo29z9l
         4BjVfQMDiL5zk/rATXvVP7gT6DFQlwGagjo6ZesG99jLPk8LWghp6ftjsJ9ZkLAMeiMD
         bqqa0kUzkCAkdjJbIGMV9tR7+WcJAoUvl5wDYwpd/uVUStBvVClrbJNp89bnDFrm2wta
         +7Q8+ObX+TBfkxECUrd5rtSBpEzVOjS0bIHJJToPg3irQRwrFdscCT/osFgza423dkUl
         Phhb1osA4oAO3DVjm5P3XqqVDdwDcTibH0Gj/xTm97oDigG800+T+btiYiys+3BZ0IXl
         ogbw==
X-Forwarded-Encrypted: i=1; AJvYcCWOxZZusBzrHVh5FEyV32riIQlKPoAg+tSdTo7aZNoDkchzVIJo2x4XaHNDCKGexsjHqQP0L5+NKSIwSHNenw==@groups.io
X-Gm-Message-State: AOJu0YwO9DsKxq/KoYtEr8kwg89fBpn+2IubdSX/oCUA+om8abuBP3jp
	YraQZnGplncRIMTf5OGE+FHjSPmbCXkC+YJS64pZBt0t4Fp4plzf9XKBIGtqA0ugS6qF+u8bGEd
	Dlf6ieku2rh3IERluuXgyMuj9aEwbWmDHJuMZ1d1n9fy8y+9RgrnoFg93G5Gidgpwk7teNqi3eZ
	bO
X-Gm-Gg: ASbGncu7XMxFBukyZEFLhdwe8hiH476LhR0fb09syzUZg6vCULmRJg7cl1j+RqjFnUh
	asSGggP4jfp51DUcSOW5mCAFvq3P9JW2ixxqibQzqoDxgWlGGTqG/1G1rUKurwqcOxgrGa3eXDV
	1gHgQXEwpb3j5msupzb8oKYN4GyUEOiA8WyOEpBvLw0jL1iP2jZqLuUEv6ztMw6OALpel51dhnj
	53QXktBtOvSmBhI/phK18t2f8QI5RzYOX0bVH7kgnGVjcUwSxgDVFdYDC1Ak0b3tNYMBL94ewd7
	aueX6kEuXnidUl5fkLDmCXcZBWfd6/PKC08rrSYEd5WNl3q1CGDPuj2oR7ul61W/9yKDmxgjtXz
	kNGGFeBS6N6cE9AnBflcJX2fBGDxyBbZxYnx2Lw==
X-Received: by 2002:a17:907:c24:b0:afe:cded:bf96 with SMTP id a640c23a62f3a-b04b1459092mr1503431266b.6.1757536250002;
        Wed, 10 Sep 2025 13:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzVNkc0ArbU5OHdk4zS4dfA9ywnKE1HaGII+qKISdGrRW0AcFuNb0RtUE39/joSb+vVf7G/g==
X-Received: by 2002:a17:907:c24:b0:afe:cded:bf96 with SMTP id a640c23a62f3a-b04b1459092mr1503428866b.6.1757536249557;
        Wed, 10 Sep 2025 13:30:49 -0700 (PDT)
Received: from [192.168.103.116] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830ab7e2sm229528466b.34.2025.09.10.13.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 13:30:48 -0700 (PDT)
Message-ID: <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
Date: Wed, 10 Sep 2025 22:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Sep 2025 12:15:29 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2780

On 9/10/25 22:14, Ferass El Hafidi wrote:
> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
>> <...>
>>> +static int meson_serial_getc(void)
>>> +{
>>> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
>>> +	uint32_t status = readl(&uart->status);
>>> +
>>> +	if (status & AML_UART_RX_EMPTY)
>>> +		return -EAGAIN;
>>> +
>>> +	if (status & AML_UART_ERR) {
>>> +		u32 val = readl(&uart->control);
>>> +
>>> +		/* Clear error */
>>> +		val |= AML_UART_CLR_ERR;
>>> +		writel(val, &uart->control);
>>> +		val &= ~AML_UART_CLR_ERR;
>>> +		writel(val, &uart->control);
>>> +
>>> +		/* Remove spurious byte from fifo */
>>> +		readl(&uart->rfifo);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	return readl(&uart->rfifo) & 0xff;
>>> +}
>>> +
>>> +static int meson_serial_tstc(void)
>>> +{
>>> +	struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
>>
>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=y and
>> CONFIG_SPL=y. Shall all configurations depend on CONFIG_DEBUG_UART=y?
>>
>> Creating this dependency does not look right to me.
>>
> 
> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> right.

We should avoid the possibility of build failures for changed configuration.

Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?

Best regards

Heinrich

