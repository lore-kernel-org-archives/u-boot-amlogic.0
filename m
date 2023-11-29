Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05977C46CA3
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 11:59:23 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.16050.1701220068507947110
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Nov 2023 17:07:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=APBuVGf/;
 spf=pass (domain: konsulko.com, ip: 209.85.128.170, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5d21b9a5808so6486107b3.2
        for <u-boot-amlogic@groups.io>; Tue, 28 Nov 2023 17:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1701220067; x=1701824867; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NC2f3xkI7kkHdZU/XNX7vMMWSooY3/NfdKSY2BNvfc=;
        b=APBuVGf/e74WmqYCBDVJFw1aVHqxt9mztKi3krBaL6O3LkPfDeg0AmGL4712IJ7uAq
         sFMbpSWtu3tfj4M9kKGK0PJ/QczxmLUb95jf8hLNmk1vzTa/uXp/wQHTaP+UnkAvUL5B
         4scK3ytEdw+/DA/PbUy74QohgpB2LKJOe9Gew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701220067; x=1701824867;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NC2f3xkI7kkHdZU/XNX7vMMWSooY3/NfdKSY2BNvfc=;
        b=IngfHub6geHiBsDyTsaug7NmQ6tC7oAC23P5ijbPD46Mg8cdDibp7yAkn9zouv24Zl
         pF27hoD3chAU4ZozX/hYRJyF2eBmQ1vgO33iujrmrSywaXp2hjD1xLiADm6Eq9ChN+Fg
         mWVTwZXMZTgBG6Q9TKd+tKXA2NewrYss2m1Ml0uFp1gclFjfWx33VGTlCbIGQtvz6/Eq
         +RHH1y5OB+l2tA/4LLztMCw5s5rCaiTCa0FLFO2zSrRGyD/3MleZiBC4yEI6ITESuAvN
         U5U3fzrjSEZg0aXMY4rdrei6pdE94vS1qDkJzPOOa/NBfe/ZT9z78PeOiSZwD/xcYCeD
         VdWw==
X-Gm-Message-State: AOJu0YxpaqNt84sPRkxyMDdBZJ599SyPKp4h9OWjIGJCTZ9C3NQMJVVM
	u4I1hsEZItuJE1jBxpZZyXkk7g==
X-Google-Smtp-Source: AGHT+IHuXfs9a89cLuoIfWXPSZ0LR8F1j+FQR7GQVgiGl2rpAKsBvntNRpoXkCnDR9LqvxiYNg+rrg==
X-Received: by 2002:a05:690c:3383:b0:5d0:57a6:5f21 with SMTP id fl3-20020a05690c338300b005d057a65f21mr9507403ywb.2.1701220067721;
        Tue, 28 Nov 2023 17:07:47 -0800 (PST)
Received: from [127.0.1.1] (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com. [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
        by smtp.gmail.com with ESMTPSA id c8-20020a81df08000000b0059ae483b89dsm4187338ywn.50.2023.11.28.17.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 17:07:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, Simon Glass <sjg@chromium.org>, 
 kernel@sberdevices.ru, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Dahl <ada@thorsis.com>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Andy Fleming <afleming@gmail.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Chanho Park <chanho61.park@samsung.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>, 
 Scott McNutt <smcnutt@psyent.com>, Stefan Roese <sr@denx.de>, 
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>, 
 u-boot-amlogic@groups.io
In-Reply-To: <20231114110257.2488-1-ivprusov@salutedevices.com>
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH 00/13] Import "string" I/O functions from Linux
Message-Id: <170122006592.601086.5973028773184530437.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 20:07:45 -0500
MIME-Version: 1.0
X-Mailer: b4 0.12.4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 29 Nov 2023 11:59:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1891

On Tue, 14 Nov 2023 14:02:44 +0300, Igor Prusov wrote:

> This series imports generic versions of ioread_rep/iowrite_rep and
> reads/writes from Linux. Some cleanup is done to make sure that all
> platforms have proper defines for implemented functions and there are no
> redefinitions.
> 
> 
> Igor Prusov (13):
>   sandbox: move asm-generic include to the end of file
>   x86: Add defines for ins/outs functions
>   mips: io.h: Add const to reads functions params
>   mips: io.h: Add defines for read/write/in/out functions
>   riscv: io.h: Add defines for reads/writes functions
>   riscv: io.h: Fix signatures of reads/writes functions
>   nios2: io.h: Add defines for ins/outs functions
>   powerpc: io.h: Add defines for __raw_{read,write} functions
>   xtensa: io.h: Add defines for ins/outs functions
>   asm-generic: Import functions from Linux
>   spi: meson_spifc_a1: Switch to io{read,write}32_rep()
>   treewide: Include linux/io.h instead of asm-generic/io.h
>   musb-new: Remove implementation of io.h functions
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



