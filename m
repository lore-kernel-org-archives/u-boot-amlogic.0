Return-Path: <mkorpershoek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3951D3B7CA
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 09:00:11 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.41369.1732611595480343720
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 00:59:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=uWApUjKd;
 spf=pass (domain: baylibre.com, ip: 209.85.128.46, mailfrom: mkorpershoek@baylibre.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so49333305e9.0
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 00:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732611594; x=1733216394; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LD8MmZIJbHnKQDfo8crB9BO5AKF2k0n8EcSatAkd2M=;
        b=uWApUjKdnfAlwuyV8WWo5cW+GGxiopuyAT+LEKRxW5EQmic+aKN6k6igyzQM4dHfif
         b9yJQqBJJlxk0+V1cR2DwjmO2WnTIbZptZyDH2B+A99hKfXs4GUyUojpeRUIFe5438fJ
         00SEJtc4YKez+kGgJfpGtQHkIOaXWdQDb8RWJhJTgIHRaNMtw1CXOkAnf6j9xGxp2i3u
         u2x2JmrNHWght90E4YIzh2gyozUp2Pi6fcjn7tYN+LpM7aHJdJ0eaY4fezPVkwF1PPQq
         WErbKH1eIm2gq7MfEm8nhFxfUgd8zLmB4VJ+YVAIus7sRId1noa+wwIAP8SQEEPISDvJ
         V5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732611594; x=1733216394;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LD8MmZIJbHnKQDfo8crB9BO5AKF2k0n8EcSatAkd2M=;
        b=eKLUFcAWTMqb6weh88AW46ixaWoEpanoBP99qwKpYG3U9exqgF4SgOvBknN312fRYV
         OSr4kCx0PiflwC4O3cY8d5Arxpvk2zZAdgRTczQnH2gdxU9+zccGPgIeXEl/uHLMOYko
         1TmSD9gtYKzU1mzgaJ4H2EjGQ8DsML53w7YQsOtpgtUcdtyIGZG/+KHrgIs6kWbNdSxd
         b7YYm9hzpKfbqMNGuPrU0zUbS1Wv2UQeOJOwDPwwUXZNC8GRLsdtKI5V59QkwuI1fR7B
         t3b3EDvAwDYVDA3H0YLNeifU0BbvhlUyhc/fc8Ve/Z9LpVEDYdFmkIM5yqLNNPbygPUv
         54ww==
X-Forwarded-Encrypted: i=1; AJvYcCUDx7quUEvtTylRMY/5bQH6QItAJ1IRmc1dfhmOa++Kvtox73LfRqxcgDdMhHZ1YtvXz+joQUuWhUkeQEsyYA==@groups.io
X-Gm-Message-State: AOJu0Ywp1ZutKA4QEWv4flda9oTcrOWEn9XNApPrFcARt4KEkP9RD3mt
	Yy2qh4EMObrH7K4WHWrRxc5Gbhro8+Xspa+YMv5Vi3fZjw+0qgqGD11yOrg1Rlc=
X-Gm-Gg: ASbGnctTjvLOg2fF2SNnMWk4Lb+vJCykwHRuQdkaqFX6nfT+iEOdlq/9yfHCf/p1II2
	bWCX9ZFzH2eKvoLaDATi4Zcv620zboKakgnncdwPIhSzrQos0Sq4ubKzfpmHj32x8gxvrJfJqmv
	BdJ5239aR2EYAYoe6va0VA2lIWm9kWIzsB47Dj1HqhEOmwT+BtlwV9TlUaYwvC/gSb8NZxZIgig
	n3TNv7CY3hElWeLUMawsfZ3AysBrr9d2Ux8rK81EzL1fR2KIEDqFINz6/cLfw==
X-Google-Smtp-Source: AGHT+IGlIzDqKNHLyRs9NkK/IDChm6kHRFW9xWqhYxKWt+SCBWQzWkZ4yr60+g9SsHS9aiFmdkU/+A==
X-Received: by 2002:a05:600c:4f47:b0:431:5aea:964 with SMTP id 5b1f17b1804b1-433ce42882bmr135821765e9.19.1732611593933;
        Tue, 26 Nov 2024 00:59:53 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde10eabsm157632215e9.13.2024.11.26.00.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 00:59:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
Subject: Re: [PATCH v4 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Message-Id: <173261159203.11812.5321569268294652228.b4-ty@baylibre.com>
Date: Tue, 26 Nov 2024 09:59:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 09:00:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2589

Hi,

On Tue, 26 Nov 2024 09:06:08 +0100, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] bootstd: android: add support of bootimage v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/51a2fc40d399888ee45c452d2f40fa1b0cb1456e
[2/5] bootstd: android: add non-A/B image support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9ef8b3bf8a1062c69a2417b850c30b39255f61bd
[3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/86e931535cf6c2014ef384bd7cacea94aadf1645
[4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/83a6ae671680010ae52e83554c431b095fe2b5d5
[5/5] bootstd: Add test for Android boot image v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/126254ab97691a93902d8fe02fdff0a783921c39

--
Mattijs

