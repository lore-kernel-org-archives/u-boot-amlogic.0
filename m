Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF5C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 07:52:36 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web10.2099.1720119045501805000
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Jul 2024 11:50:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cYe5xy9F;
 spf=pass (domain: konsulko.com, ip: 209.85.210.50, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-701f397e8ffso517740a34.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2024 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1720119045; x=1720723845; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlPKAxcdp7uHTf40f9Qzt4qAZY3oOYLTi3e7PH68b6k=;
        b=cYe5xy9F4WYWC0aPYl03LPzZkuZbvRYi1bSYC0IyIIIzv0vmIuoZizKNjAvOB266mp
         S1VcVUOtuRw0NAhUO6p7h6El84gds99RD4EICCLkAAu1XxaGS7ubZh2uwBtIoNWcyRGU
         Ou3SfYY4SDxuTehRDrTft0fGJdYvdiCJkXdVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720119045; x=1720723845;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlPKAxcdp7uHTf40f9Qzt4qAZY3oOYLTi3e7PH68b6k=;
        b=VzclSawO31hDWOx/wZzkCm7MJvpYvcInrEobfODAS0N8FCyBDe8TuDfUxyJYxMnl9t
         XHdo//k0S7Ttm4D1JpjL6ysf6UecCkO+PPwN57IUOA5eKji0VKSZjDH2lJHCVxGSAkGu
         QY17ofsxZBbDNgWqLboy1cfwLEZEvpfqCRH/Cgq13kxkDpg8wJhwGM5qiU1/K1IKdNvQ
         MGJQjJhm/YTbg0Q7QmzYFPGwSpytypCwWI9cMH9dmHR5+M9HkjtDiKOnFQPR4xgd3qCd
         JoZMtWrDJkDwLZ63rpen+sgAvvF9N58DQEceZlYOtEplcsoOVnMKHTcXqG2aFgJnyeks
         je2g==
X-Forwarded-Encrypted: i=1; AJvYcCVVMkLpmljbpkxtpzZNJ6BRKGw7ONfDZEBvhHBL0Wc9T9KylVOTx1+PRMEYYwO4bIufGd09HyodFUHaJRoD3E3qf8zuHQxbzuY=
X-Gm-Message-State: AOJu0YyYpLSkn5Vk2lkt0z6diB+aeVnGA/H7lBZ51kKf2HzMEF01ABP/
	fZ+JUIzukPCHVQPtkqaVWeF2cIVNK+A08Q4HRTprZkuydNleID7kIR8d2e9Sz2s=
X-Google-Smtp-Source: AGHT+IFKMYVLcYTDxMgwlnWohBLxAXBZRdaTWzdn2w8R0XGhRVBR91/lpfH2H4+m6At8eYov9A0RFw==
X-Received: by 2002:a05:6830:206:b0:700:cf6e:e261 with SMTP id 46e09a7af769-7034a80cfbamr2692107a34.31.1720119044693;
        Thu, 04 Jul 2024 11:50:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7ac8dccsm2454997a34.34.2024.07.04.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:50:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
Cc: Alexander Gendin <agendin@matrox.com>, 
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
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH 00/14] testb: Various tweaks and fixes for Labgrid
Message-Id: <172011904231.1502730.5769264481687986280.b4-ty@konsulko.com>
Date: Thu, 04 Jul 2024 12:50:42 -0600
MIME-Version: 1.0
X-Mailer: b4 0.13.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jul 2024 07:52:36 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2352

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

Applied to u-boot/master, thanks!

-- 
Tom



