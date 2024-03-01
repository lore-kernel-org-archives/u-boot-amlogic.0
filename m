Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BAC54E6A
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:38 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.21924.1709297840807745982
 for <u-boot-amlogic@groups.io>;
 Fri, 01 Mar 2024 04:57:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Ax+OPmmz;
 spf=pass (domain: konsulko.com, ip: 209.85.128.170, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608e3530941so22703767b3.1
        for <u-boot-amlogic@groups.io>; Fri, 01 Mar 2024 04:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1709297840; x=1709902640; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfyMlUMzx3VQsS3R7T2GSZESD8+Lnpcy3TEyzInipfc=;
        b=Ax+OPmmz0HqNcmHIrznnMlRz+AhRxfGTT2v2ecdYnqDCjCaMZb9Q8hKkDjfXZfWYPU
         uGhRqhNoNG+oMzKc124MfMnAxVMCU0nRAyw0mCYVAV5mQb4FK78g6Knpct53cvDAJ8P/
         r+LaP89gFs52yChwZ0D/R9z99CXluCgsVfQME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709297840; x=1709902640;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfyMlUMzx3VQsS3R7T2GSZESD8+Lnpcy3TEyzInipfc=;
        b=U7iWFqFRfpSdh4oYlRxQigzBVc0UQwNZd5qnCClOFv865/oKLJR9MzBHM5CbLF9xCU
         +cUeJl0LgnLr+raDT3mHGIEBWZGbTYWhEM1CuJsPhpnz2B8Y7bVQcIZ18h74L6VetKkU
         DsrG5ZNyVfRxeSQQy9A8u3/OKSdJl0nxpw8h1xNKQTtNulXGZ0ihwwLOS/fTLA/+5DwS
         igVfWuaDMDiuXLU29fvw1I2YeTK81WbYKVo6diLjD9dIy87xxFJrj+KWEJSuNhaaN7eJ
         W3DVpYlNApmmQ0MbrThzoLy7wV7rSDAf9OhF/TMgc0BA/drhkSjaUmTJA4WfkuGOaZIo
         FZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtP+8Z2sx63eFdXmFAgQMLeOJ6KGapJqCwnIlpKOm/rO7IzDewpki6/tkzxfxdxALpxvbRPz3Tv+xqImqpS+rip81pVvrR5oM=
X-Gm-Message-State: AOJu0YxyKVSQV4sgZodf7EzYEFLjTOAjRHWWOYEOo7/bJe6MA7Uge4NF
	B9TLSjqAX/v8rO2Y83d8w+eay1mxW/Iands5nyiwEXsxGJnOdIk67YNjME83iw8=
X-Google-Smtp-Source: AGHT+IE36fYDLRMwuBncyAlDNJME588hBikKsruL2lYhp4q3b15W/ENqtUFEHz1leqG8GNPy2YaFNw==
X-Received: by 2002:a81:4ad4:0:b0:608:7f87:fceb with SMTP id x203-20020a814ad4000000b006087f87fcebmr1323914ywa.38.1709297840040;
        Fri, 01 Mar 2024 04:57:20 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
        by smtp.gmail.com with ESMTPSA id u125-20020a0deb83000000b00604ad97f2d9sm941660ywe.110.2024.03.01.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 04:57:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Cc: sjg@chromium.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor@kernel.org, neil.armstrong@linaro.org, caleb.connolly@linaro.org, 
 ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com, 
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within U-Boot
Message-Id: <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
Date: Fri, 01 Mar 2024 07:57:18 -0500
MIME-Version: 1.0
X-Mailer: b4 0.13.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2152

On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:

> Changes in v6:
> --------------
> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> - Patch #3: Incorporate fix for sandbox CI failure.
> - Patch #6: Incorporate shell script comments from Marek.
> - Patch #8: Incorporate documentation review comments from Paul.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



