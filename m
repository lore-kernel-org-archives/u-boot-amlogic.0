Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B5C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:33:27 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.4145.1743790857612832544
 for <u-boot-amlogic@groups.io>;
 Fri, 04 Apr 2025 11:20:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Fe2mP5nG;
 spf=pass (domain: konsulko.com, ip: 209.85.210.41, mailfrom: trini@konsulko.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c27166ab3so1522961a34.1
        for <u-boot-amlogic@groups.io>; Fri, 04 Apr 2025 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1743790857; x=1744395657; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLU6c4YPgUzLnlPgjsDGc1RAWFxiSZuQGPNa2XdQReM=;
        b=Fe2mP5nGBinS4kq8ICKaDZACA4E309p+tfB4lG5AkI11Bf6sxLTZESmyVQo1LhnFBs
         +svHoSK3bQAsgdiYcpwBtsY6mT3PdJvSI09y+/KDCe2KD0SIOUretl1dW9jkZ0CJ8GQG
         Qh12oodWTZ/w4cv8KE0OmWFzMS4PXtKdXHKJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743790857; x=1744395657;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLU6c4YPgUzLnlPgjsDGc1RAWFxiSZuQGPNa2XdQReM=;
        b=I8hhrFKQV9e21GaIHj1Xoy/3ztKaijsBzL6uaaHY9t9AvlOC37wuG2rbbj/xElcFmV
         HhNfbxFOGJzliUxynuNlTItQDVMYLhUH02UoQR9Movm+5eydPVHmMHnRA0QNhjqBAbMJ
         GPquwmWzE0qY8xE1I49bi9X6lwNG+qDoWj0kwNHOwelW8TKJHiKPVOcqIJCWdhOWptjl
         +6+VOFQDS5KsfdZBBVVwVXNi3EcY4DBwZEgbKNokvYmkPwi2zxC2kR+i0PcegSUORsEr
         0aBJgDDjtV+nC1efpQABgr2cdAG2MXTEtuNYJN7XeHDr+Llex5m9vaqEch4xxfbK9UiD
         5YYw==
X-Gm-Message-State: AOJu0YyBf+kD91/JHAUA5Yu1KktlBGezRvM0Gk9ajzCPLAKVle9Hg4j0
	8eX2B4PSi9eqjYqplgRzOpgf3bTZS57NnMxIuI52SwLUmllC/cIzQEUA5IMikrf70Jk6TMYRTvu
	l
X-Gm-Gg: ASbGncsRc3i9/UqhHosOShMOzakrgy3YdzkRZ9jpWVToM3BLRgBT7Ev5hTreNy2PX65
	LrcN1kJGiFw/XVMWixBvK0zG1QLnECK07bv0fvJFp9x66WJwLhbaURZZFstiRrCDXB1HDKMZjgK
	KQ0P2KqOP+07g8FKN1u486+hKWN/h2ClCEOjGkPTBVJSIl1tMBFDeISv7P8SUn+sFf30/nUmw2h
	nfmZQ9lar2EgtvWHd3mUnKE19ficcMbh6qZ62h73Ch4dGsP0iGRtSEbQ/OQjnAkkpp19JVfhnWj
	aru/6YsnD71SjXLj7k7OlsofNhNrb3modRhLiVLtFzJ3z5zbn73qOptyf8PUeEKJxFYO2W+XoB/
	pmfN3
X-Google-Smtp-Source: AGHT+IHY56MiBVPk3CnFaj3e3weQmoHEMPxcSEaluUKgsSVnhd66A1SnaFqJLjhDxRylkBynSMCZAA==
X-Received: by 2002:a05:6830:dc1:b0:72b:a175:2f0d with SMTP id 46e09a7af769-72e365c000bmr3055045a34.0.1743790856902;
        Fri, 04 Apr 2025 11:20:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net. [187.190.205.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e3051171dsm752144a34.20.2025.04.04.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:20:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
References: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20250404 into master
Message-Id: <174379085596.2587039.1164818831056569907.b4-ty@konsulko.com>
Date: Fri, 04 Apr 2025 12:20:55 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 07 Apr 2025 07:33:27 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2655

On Fri, 04 Apr 2025 10:40:31 +0200, Neil Armstrong wrote:

> Here's a last minute fix for the libre-computer boards fixing the capsule update feature.
> 
> Thanks,
> Neil
> 
> The following changes since commit 82b69fc4224432d5aefa7ca750d950374cbc7fb2:
> 
>    Merge tag 'efi-2025-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-04-03 07:31:28 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom



