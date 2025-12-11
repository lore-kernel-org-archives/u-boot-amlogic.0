Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F5D41C20
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:31 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6654.1765449982386432880
 for <u-boot-amlogic@groups.io>;
 Thu, 11 Dec 2025 02:46:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=avC9Zmsu;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632b0621so4755895e9.2
        for <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 02:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765449981; x=1766054781; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjU/qtEORsATqELis3tzXQGkdA9nwv2oBCY8a8BMm44=;
        b=avC9ZmsuxXyCuU2qCGn3JzJAxna/A6ZUzBGiLbhihySpLjg/Mi+1SbZfmKmqlvDRi6
         O1rhxTJG+fc6WZy3u7biKQlGbMiJp9zQkHApzMEnuKak5iKSBw0WzH2FCYNnrn3uKK54
         UaOAstNTgZ5o+qQaEh/BBtf/Ofe/NbpxczWapyUd7GMbJq0dg1Ft9nJX0He4Z9kkP17J
         6FU3IFezRhtDQHpblLblapEXGHI8mlqvPBRLbVioTnwjdyrL7/R2UPbv4K95uRyWdfJx
         imWRIw2StW5dNUCswAXc8JhS2Ot1X8IuO7xrx2MuwU27yc96CD+NcjK6NQsLaC3AqLEK
         fmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449981; x=1766054781;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cjU/qtEORsATqELis3tzXQGkdA9nwv2oBCY8a8BMm44=;
        b=kLGOez7z19WH7AlNRjBq534l317LdQeVPHLxB7h0QlyEd0V9OHjxwejVExXDdzKoNP
         SHBocP/l74pm0qZiHNIbZm6Im9lmFJ82/z4zoJUPpWTcyAVc/ao9FFnBcEOOhsHg+oEh
         EBbhBBYuFGm07e6Xi1Uk8s155NxTwC3qdXEBha2rKDrShJtseylRRn71XpQ6toGyTq1Y
         PTpmXgAHDLPh1PvEB+Ls60C5KZbx+akQxCnJN03EPGZjSHHv4gC9zhG/2g9OPMxud2XW
         m29uXaqT0i8cqki0OyAtdEbMi67OkO7revlpi4KSOpN/iRyTMkfVPu0AHjaCKLf1MPQg
         2OKw==
X-Forwarded-Encrypted: i=1; AJvYcCXCHVyOGDlnTxwtH/VT4lm0wAGDojfuUVS1NNPlGsOOdyER6R0GEUx/2x6Q/Az5yYz9BwTmRs1ONoXVJ9SZqw==@groups.io
X-Gm-Message-State: AOJu0Ywik7DTXPm0Lm17BLv7e6PXvhZSEX6CSikupT6g5AlXDW1t5Vjs
	opnLxi02IicX0h97gO9ssje809jOuBT1z+yXH2NdComqW1GFB74cVNZdxllnWLblVtI=
X-Gm-Gg: AY/fxX5QWV6xobJ4itVfZdUMb/oIXVB32Ez9aPwgY4BBDAVWKL+tNMa2fIlhgSgv0fT
	OFm+Kstr1g4/BWgGA0l5/2u+Tl6Z8WN5qREZslcbFiOFZtn5RYMW0lkzcBIR514PMMCHsdtZ3rx
	xm0dBIoOsuekoHaSqg/e2XYdiNNbv3XiDggiaaY1Fa5NzMCZG+b/i5iM6u8HeZa0aC6rWOihfjJ
	WUmCVDgKLNCBBinG24jEATO4JpXnx3bQGmdzV+s5aGwq88zvF1c0tVOgipIDODVo1MWvhJhtzkX
	ONrfutgl6X/NDu65wAnv6TtaVHunNVjck91VC1oPG9swU9PfGTPZ++wHE/HCYayvgNouS5MD/hN
	DJTMA3dmihSFcL9oZqnNM9o/qnB/hR9jirkhap6kSpEPkv/IC/Rr8fJ2WevW/vNq8ctHsSP4AhN
	e0UTFdvzEA4m32vV7axGk7Kc/LoXxielw=
X-Google-Smtp-Source: AGHT+IEA/H1FughEtKqoDJcFk4wSBsJLyQKJTQ3KqrdtRaVvhDIBFDv6t2+uKkhLRQeJilwWVW6x4g==
X-Received: by 2002:a05:600c:8b16:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47a8375ab5fmr57920085e9.15.1765449980721;
        Thu, 11 Dec 2025 02:46:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:46:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: nick@khadas.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 trini@konsulko.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Nick Xie <xieqinick@gmail.com>
In-Reply-To: <20251209055750.43594-1-nick@khadas.com>
References: <20251209055750.43594-1-nick@khadas.com>
Subject: Re: [PATCH] mmc: meson_gx_mmc: reduce maximum frequency
Message-Id: <176544998017.2550755.9916407957719921322.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 11 Dec 2025 10:46:31 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2868

Hi,

On Tue, 09 Dec 2025 13:57:50 +0800, Nick Xie wrote:
> Reduce the maximum frequency to 40MHz to be compatible with
> more eMMC. And the Amlogic vendor U-Boot also use the maximum
> frequency of 40MHz.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] mmc: meson_gx_mmc: reduce maximum frequency
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/867750c2d9b1f42e9a6e54e4f816fae04cff0dd7

-- 
Neil


