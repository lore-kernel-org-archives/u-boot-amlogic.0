Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BD7C3065A
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 09:43:59 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.22125.1719395033802451134
 for <u-boot-amlogic@groups.io>;
 Wed, 26 Jun 2024 02:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=KXjbvIxx;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4249196a361so23944285e9.0
        for <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395032; x=1719999832; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBpK95HsKn8tqL5eWnQabaZgJfuPWAfbgXD9A1iKlM0=;
        b=KXjbvIxxm3FcM4GQAQ+i7bXU0KeVpzK6qH8sD+uD32j9efigGeECT3XnNIDPwlUg6v
         Nx62OorSzuMh4t24gjvp8tMgBoSnpCLs3LO4j1Mfc2jUHHuOxsQz8ndasYu/wI0bqvZ+
         WaOqhwPWk35U13uasY5pjYxIxToHf/5F8sjjdOY7wlYGfaBfGbGIyafe9u2JXAPOP2b3
         8kiaGkjo9iY01WWN6tp/U6FeP7e2dw82Rofoycst/2wbolHdCURpUsgaxSmAGJSPuP+h
         kELLCdjT1w3fdiT59AkXGqaMAUVilAzDBZnbhmsBj2McJ967c9Hx+JmmET5hcwkra6Qq
         oyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395032; x=1719999832;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBpK95HsKn8tqL5eWnQabaZgJfuPWAfbgXD9A1iKlM0=;
        b=ZbabsZUyii/CNrUj1/aKM6NyZAEEfDAdtyE+i9Yu80VS3ntG+TTtLi6/TZ/wkML7gz
         1ZxIZ6kR+mtAZvOfo2iz5vTur+F8TTBfGGmMXKxbqKO2gfwffqYxvp8aXhXMkgBZJMO0
         jNPAlPvEEX56113BTAchLeXFstuNSL3KJTLGnpm/l9ilElB4HDJOSV3bVUgBf094Z3j0
         WzMgheu9nk9E9R9TbCwb75vX5MMjXYuADPqMYOhWS1GuNSSTkqO0aKDDYDBH8RmQu2H1
         vndehkAqYOiRB6EahGu+7saG+tRM+jn20+gS1hRFgd5bIskDoQfLNvXRK3eM0rSpzgMr
         kuFw==
X-Forwarded-Encrypted: i=1; AJvYcCVfXrtnt2fE2tiVVpMnU6WiGn6JtgjC1gTH1wnIhuuYeura+tvlwGpjc/ilx1WeyUH8yc+OGvwnKww9+Su1bAnCg9tiFiM65Lk=
X-Gm-Message-State: AOJu0YzHL5l7SqP8Zcab4xyNMh1kWHbV2o18cm+gDDF9fZ4VrgI26Rl9
	54c2MGWZP3zTfcAVth6U/cJJnx+WqpksJklB47reBpTWFHI0bD2ePQn8DVwMNRE=
X-Google-Smtp-Source: AGHT+IFYe7ftfjzkblkfpRPeZIk86qwv8keN8jYFzlQXl4kQ42DD2A78YF70uB+DPJyZoBo23QG2DQ==
X-Received: by 2002:a05:600c:4348:b0:424:a774:2ba with SMTP id 5b1f17b1804b1-424a7740338mr17148975e9.14.1719395031710;
        Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84692c0sm18857175e9.43.2024.06.26.02.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:43:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexander Gendin <agendin@matrox.com>, 
 Allen Martin <amartin@nvidia.com>, Andre Przywara <andre.przywara@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Nishanth Menon <nm@ti.com>, Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/14] testb: Various tweaks and fixes for
 Labgrid
Message-Id: <171939503058.2754394.2844444802537886889.b4-ty@linaro.org>
Date: Wed, 26 Jun 2024 11:43:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Jun 2024 09:43:58 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2330

Hi,

On Sun, 23 Jun 2024 14:30:19 -0600, Simon Glass wrote:
> This series includes a number of mostly unrelated changes which are in
> service of running U-Boot on a lab using Labgrid.
> 
> Changes in v2:
> - Add new patch to update u-boot.cfg with CFG_... options
> 
> Simon Glass (14):
>   trace: Update test to tolerate different trace-cmd version
>   dm: core: Enhance comments on bind_drivers_pass()
>   initcall: Correct use of relocation offset
>   am33xx: Provide a function to set up the debug UART
>   sunxi: Mark scp as optional
>   google: Disable TPMv2 on most Chromebooks
>   meson: Correct driver declaration for meson_axg_gpio
>   test: Make bootstd init run only on sandbox
>   log: Allow tests to pass with CONFIG_LOGF_FUNC_PAD set
>   test: dm: Show failing driver name
>   test: Decode exceptions only with sandbox
>   test: Check help output
>   Update u-boot.cfg to include CFG also
>   smbios: Correct error handling when writing tables
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[07/14] meson: Correct driver declaration for meson_axg_gpio
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/96e1a156e90a0674b21c56e7121b17a9211176ec

-- 
Neil


