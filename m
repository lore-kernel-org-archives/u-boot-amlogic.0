Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04685C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 11:59:23 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web11.4449.1701206006900718044
 for <u-boot-amlogic@groups.io>;
 Tue, 28 Nov 2023 13:13:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Mkqlofi6;
 spf=pass (domain: konsulko.com, ip: 209.85.219.177, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db46725a531so4359621276.1
        for <u-boot-amlogic@groups.io>; Tue, 28 Nov 2023 13:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1701206006; x=1701810806; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3jN12I6YE3sXe0ZOueHe/4weMEjV1rgv+l+JNY8Kug=;
        b=Mkqlofi6B6631eNLZL/s68JncWKHekuPjyIIKn4WWJIFMD6sH9wsiLoXPl9OFrWelw
         CFhiLAz3sTa7am3iGUO0rattjsGS/7Q0m2+d8JyTsvjUnBSSX5/gewyQnDdY2FKBG/+I
         nw+skxXRyUet97q0y1HXDBvZOERVpat7nwGGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206006; x=1701810806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3jN12I6YE3sXe0ZOueHe/4weMEjV1rgv+l+JNY8Kug=;
        b=GEH888BVULuwhBYYuSZt/nu9dHhwmJnrwMeZhJvf5saIMrn7UfNsX4k5Tq/X9Oq2Uo
         6chVHqDkZ0Sk2n8InjHWym+5v4LlcipmHztZUO22kxFJe47I/jg9ZaKtvewpFBBGHMtm
         j2gOmIV3y0/5eCj4ZTq4cHCm60cdyy+uS8Eo4xVKXbnPbBNWzjKMQbq08iO651Qq5IZV
         +Le5vRptzGek8OjGouBFOWMlmSm55x2ShlSFVhcr8UjCZg++NtbC7jqm1mtO6NpTDkqB
         BRtpP+RwWAQfhmOHeWgLVURe0PhoMJNrVID7fRyhBZsAkCSw5iOwZNGeCm3OOs9FiMnB
         iTxw==
X-Gm-Message-State: AOJu0YxZjZs/8j/Ego3V26dFa39lyFtwaKAJD2AAs551ZNFP5uYUt0jn
	NqpNHmHyGU6DJDcMPafoY5VrsW95FgHRuW8A4aKxSA==
X-Google-Smtp-Source: AGHT+IGP/rYeUYrmmoOqcry/rsIG5v47c+O5TpmdSHUD97NlMDwvpTNBnbgvqWmCmim6oiSozEZ25g==
X-Received: by 2002:a25:ab6e:0:b0:d9b:8804:3153 with SMTP id u101-20020a25ab6e000000b00d9b88043153mr15993016ybi.8.1701206006059;
        Tue, 28 Nov 2023 13:13:26 -0800 (PST)
Received: from [127.0.1.1] (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com. [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
        by smtp.gmail.com with ESMTPSA id b143-20020a25cb95000000b00d0b0bbe574asm3831770ybg.44.2023.11.28.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:13:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Simon Glass <sjg@chromium.org>
Cc: Artur Rojek <artur@conclusive.pl>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Breno Lima <breno.lima@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Montefoschi <francesco.montefoschi@udoo.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Mike Frysinger <vapier@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
Subject: Re: [PATCH 0/9] sysinfo: Expand sysinfo with some more banner information
Message-Id: <170120600498.409307.13044009139201842259.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 16:13:24 -0500
MIME-Version: 1.0
X-Mailer: b4 0.12.4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 29 Nov 2023 11:59:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1890

On Sun, 12 Nov 2023 19:58:20 -0700, Simon Glass wrote:

> The show_board_info() function was adjusted to weak so that it could be
> entirely replaced with a board-specific implementation.
> 
> The intended way for boards to provide their own information is via a
> sysinfo driver. But currently there is no way to show anything other
> than the model name.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



