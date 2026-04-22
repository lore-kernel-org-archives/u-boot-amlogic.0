Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2D9FA1FD6
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 16:28:43 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86974.1776875315106270023
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 09:28:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=q+KAW+kp;
 spf=pass (domain: linaro.org, ip: 209.85.128.49, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so92774865e9.2
        for <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776875313; x=1777480113; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubqinD/2ACj1c16EbA9jpCKhig8Vombkyn1m3I98TvY=;
        b=q+KAW+kpWg/e25+lMdM83i6TA7eJqyJEpnzmh/cgnz6C71r2Gq17+FTaQ96ILo5+yW
         6Qd5mJk2RIQbEMO87x2ur3HPkiwR9Iz769InCh7kSiGwFAOIvQwcVUY1tXwWk6x1H9Kq
         UQQUh7JwjUkY48gHYtHGOKUUbMVyCQEyOEwKD5uubfi+jsKCDjGmzk6YnDZNTAx67hUK
         /V630NsKC3h3r9BKSKPNpD74Oh6QlSNb+GmeeVOHA0xj/l+YxcEqaq1CLQVBQY7etrQP
         v/wyGuFYeFdFluwNAplCGLG27b5XU6PVCWcgNqPvXTyQAB4RNrplwaElsNNwsEzM1aR9
         HbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875313; x=1777480113;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubqinD/2ACj1c16EbA9jpCKhig8Vombkyn1m3I98TvY=;
        b=SNw3JwvyrWfX+RLJFJmAzYg63DszZObkOORjDfpRmNMm8t2198J79R5mpDsgSL5mN1
         BFNFDtacCULxTKdfvKDT8xfrzENls7Bk6ZOAb+78bRla+9dPbOX2Xje2w5LoToWCk+t5
         C5Us1cO0NfpoQHsrilOzyrJ27iTGaHuZpAkdKpoNSfbADcBkbaqb68ELFL3mnBzBxjXC
         rRQSGGxqVMLoWqqYq8xup7iowPm6sPQk3Y+Poov/ffO2INt9Jo5EN0mXw+ZVgcAa713M
         BbeCvuugDuBDiiPHA1pzW+TWb4wGMWak0/SSZ6uw7r19LTC+3X70TokCDTfyApp+690F
         iA3A==
X-Gm-Message-State: AOJu0YyvJo20h0vk4SvcGzDROzFBgacDPn2fw5hY7/+VOVYZV3xIpigF
	Bj95S4CeIj79oZWJYQ9SNybojdJgDKy4/RSUt4Bf78owMZG41aminIvSzl3pxRUK/VtUlLbT8Ro
	DtAE7REo=
X-Gm-Gg: AeBDieu3vpffTRMmVQr1bxEqyEiBmzzVXNzLliXDC35ncfn9sd7xGTKCLwMSU47Cott
	28DMqjpbmcC3TvFDXwhyjuC7gezCOKn3uv8yGmM4vOYer0nreQx1Wglmz034OEOC6F4GmIwfKCl
	ya5SsQ68xf3PpY2JMkRyvBBmHr17cwFdmz+PQ8aOXfYW/7291x6z80oW4zzkRkkcyI6GbwUTwXO
	x7F/y6VhKLiNN2I4u+IWjjG/Bn53KVorE94SlGIwXbUM/WWWU8C+kOowhMXttXXowfChaLZ5R4E
	IjLtbIWCfx5Hg02BwbUsQcSs1aDhAQZc/G0VJstBEBC67+kqPtY+OafV+lB/X9XAkXPOJ93gMfK
	bcWteadxuelPzRbIUDPUte+HRe7J4w5cVzKKR8kdbqGc8inj3LSLsuTSvZuzWlVV1EkBE7+TLUN
	LQLyWicIeJRTYFNK5YTwt1MHu7HiFVVxWgH2dJ7vwV0qStqVOnhhWJfg0=
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr345108445e9.0.1776875313425;
        Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm144898075e9.35.2026.04.22.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
In-Reply-To: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
References: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
Subject: Re: [PATCH] clk: meson: do not fail when setting SD_EMMC_x_CLK0
Message-Id: <177687531266.2025915.11674452554926179447.b4-ty@b4>
Date: Wed, 22 Apr 2026 18:28:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 16:28:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2980

Hi,

On Wed, 22 Apr 2026 10:48:58 +0200, Neil Armstrong wrote:
> Since Linux v7.0, the MMC controllers has the following properties:
>   assigned-clocks = <&clkc CLKID_SD_EMMC_x_CLK0>;
>   assigned-clock-rates = <24000000>;
> Which causes mmc controllers to fail in probe.
> 
> Make sure we do not fail until we properly implement rate setup.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] clk: meson: do not fail when setting SD_EMMC_x_CLK0
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/723f14c946cbc8c09c3acf7bb7b7da65a4eeecd0

-- 
Neil


