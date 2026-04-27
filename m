Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32331FF885A
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 07:37:59 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48654.1777305019786774395
 for <u-boot-amlogic@groups.io>;
 Mon, 27 Apr 2026 08:50:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DTmJEiLy;
 spf=pass (domain: konsulko.com, ip: 209.85.167.177, mailfrom: trini@konsulko.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479d68a9062so4432198b6e.1
        for <u-boot-amlogic@groups.io>; Mon, 27 Apr 2026 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777305019; x=1777909819; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W+/rCbHjWgeDfmOLnEAqkCjwrfBbMfS5HTd07ZBIuw=;
        b=DTmJEiLyZNQxI3bKtIDcbV00OIBsG10zuMHE6tEdKRv7RU+WolU5/4yRINHpP2hIzs
         lOjct78aHP32A+/Oeeap1AvcShtyX9mJwXNtdMu4A57/N34o+y8zeIDCBBdUWx5lxn9b
         YxpIY52dms0SGv3h6OUjjQPbzYyGpJwviDtKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305019; x=1777909819;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2W+/rCbHjWgeDfmOLnEAqkCjwrfBbMfS5HTd07ZBIuw=;
        b=pfCH5mohtBGTnOBDtucAsuq2J1wKQSB03v7ts+UvRXPr6ToApnXYeVLtfgwK9yx5y8
         YCfpWoLCJAsKL2rzHN74WYfLwZTiwaTVv+3qy4GJWIfSJfyUIRwe77d0XK2GTPBh0bHO
         oRvMmBI/rwHOHTeiVN58dNxN/c1OP5CMaeb8l+h51+1qnrQLLWaj/3S+qpN2cFJzM8+f
         hc5K1z33hO+sSBGRlhW6N63gJJJDPiRtUv6PovvynZhsLS03SAwgmqCtGn5n3pjJWVq8
         3lGHq3hUoQWHySmTflfvv0/ftm/6TlloYlNX/l2guOOaDPG+sE/AkQywQpNGBxkKytrD
         9rjg==
X-Gm-Message-State: AOJu0YwXsylMzw044iwnz2jx9nSJdiHdcaOwtjLlY+m0rkoVBd8M9+Wo
	1xK0s9GDlfd6DaSVSTfwt2vq6KYneCN7ViXLSQ56yIcC5CihxEs+Ga8ggMwu7U8jJBdc2BDbnvu
	UChrAUVAK226P
X-Gm-Gg: AeBDieva5C+95R70j8zX0dk0MCYAOyeLNPR2h6nwN7cuPcrkWq1yp9eeFc7qHJeYCOh
	+WFDxjO0UZaqIPAkhd2lcMZt9YZZQr0E+OrKM504yEWXBajwR/JEIj1hRUu1W7cuw9O5Oi3WoH+
	fqQbPVlSTjNodnYDPI8JGo3n21xFkbCFTt9pWFJUwdDr9SfAQcBEzquxaoDL/G3Gqf+bZlgJSVT
	Yx/p0vzJmuIF4r1akMqR8fRT49sBUPxrqyLN5XdiMNqR9x2K8kPkX68rnIztlWlpVFWTWrPUsfy
	gT74fA+2CCwm4xMnFZmdWNbNVkJ53sgm3xLBgrT4ASOu7pkkA/tnpuGyu1VfszgMlzoGObmSQhc
	EfWLm1r83ATL/dvmbxcDCGxZ/JHp8d+V0ahhI6L1pbtIeCeKFQirJxU1mVRWFk2IuJ9O941Ek87
	2Medb29OilYb7LfBBXkZQozeH6MuUpyR78aKTMiWJJFKPWfcMGY4zLoLxxGu8YFivkdZTyOQcVh
	gGXNtzP2mjs7z+VxYXjQ0Omt8U0EVyhHfr8IEQpA+rhkswExsN2rDOWw/bX
X-Received: by 2002:a05:6808:1791:b0:47b:beb4:6c82 with SMTP id 5614622812f47-47bbeb4ad6fmr10844804b6e.16.1777304530569;
        Mon, 27 Apr 2026 08:42:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c1c8cd7c2sm824896b6e.2.2026.04.27.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:42:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
References: <41f5a6a9-6a0b-4df4-abd3-aee0a7297ba6@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20260427
Message-Id: <177730452980.3468459.13288390272488234397.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 09:42:09 -0600
MIME-Version: 1.0
X-Mailer: b4 0.14.3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 28 Apr 2026 07:37:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2983

On Mon, 27 Apr 2026 09:53:54 +0200, Neil Armstrong wrote:

> Here's a short set of Amlogic changes, first fixing MMC init when switched
> to Linux 7.0 DT, and adding support for EFI capsule on disk on Libre Computer
> boards.
> 
> Thanks,
> Neil
> 
> The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom



