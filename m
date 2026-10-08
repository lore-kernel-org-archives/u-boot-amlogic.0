Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B4CA600E
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14769.1791463578808871355
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LfqzQpYI;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-486e70f2457so2351755f8f.2
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463577; x=1792068377; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
        b=LfqzQpYI/Q14si21eEYkF91MSYr8NVlJ5EW7txqqUzxUps9496mQ9A4p92ipmV8jhW
         4Zf0e0vGSYiaxrtuRK7WGFvs2yoMjocdddA1ZfS7+IGCo+6mrOKT0hxt8Z2fPvNt1l2J
         wXTkSg/yiA5jSfNQuPcIl7RQP1gzHAqeqEPWP9l2/RF92cNTEpR63N/TStdp9cn+iqcC
         n+n9VXCa+r0N7A+IZaZniPd5yetDXERxZdeIYPPQPzI6r7jPr6Tx8FLxHUVSx8/M3Guw
         lA4NIFDURShgYgTgKsnT1tZzCgtXVr0ySmJA0plEAuVOZ9FMYDTjeCyUy/Ms9PfSGnFH
         79ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463577; x=1792068377;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5YyAq6JNMEYlXagC7fj1/EDTqcL+idGHbWila2hYbBQ=;
        b=LN4a4rvMmTUwRDwYZ+aNqU5GqYsBp/PT3oWoXt5ZFj6AUos+337WWBvnsQgF6xlSNg
         bRt0nbZV6eWs7UzwNV24LzjJkBKvxGd5f9aX9VYbuUPDVRq9gBHf2gSLuKaFBhDzQbpA
         dlF2QKB8QSHoyenGhJPDOqQm8KadD8XQV6htlCmyPRijUZS75pQnwj62XxARRF/ZZAN4
         raPn9L3zqva/SGFTSAaebW9a51bMkjWxbo8prYDgeUQa7IRy8S7PF8q2ByzniM7Uu9aI
         fwHD1JingkFvFoaxqJAGAVA/U9M29elXB8+jGTnUrMTAEsUi5mQrrJe6Jl7h9rmsIX6R
         7yLw==
X-Gm-Message-State: AFq9FYJw2zRDmLSTEaKEXZDhFkFydIqFhf4HEYbP04SuE95AJCr63Lmx
	N+6UYwIuF9iOBfH0mRuLSPrZ6srGs2aAeW2iY5rbvxGSkeVIXUGhrCb2URuLSWhH4x0=
X-Gm-Gg: AYBFou22Bn5J/15bAD396KcS2tzSIvc+WP/7MFOg2w9hMTKUb/3CHV/TuzygutGLkVy
	8OpGNDzzFc2F9bADkK++eyS2Dg1S6Ueg0O+peAZiOdA6hFFXg1snhLaONF4L/NtP2oZI6xVd/1F
	9iAnT1T42KeHTH53557fitKf0hCMLKcwvhDegRUjXTysrEm26X9O7iQ2hWrGKmZJd0B1qOfx+Dk
	z9boq4jSOvbvcENrrOCSegeILrT7JEd4VbVQLkAOW8MOiNzk+ngFJWkU/s3CYj2d71bcJFW0DCO
	bObRe02v4bwRpPHKEidj6gActqmfTHzbAwfCrnkyHpi+XPQMpnWCArBGx299f+JQ/iHCxqSPGn3
	+3BUNoUSr6bLVoTmrilJRxkbd6vEcITjUZ8SkEkMFoDmAz48SXSVvOeDoTd7ocNGVnh/qOaOzBN
	+UfCDnXZZknca6EvmINcG/OU+YXvhWM2GS01iREnum7lPwNj3FFQNdkQVTOReVbwVnkI+8r2hiE
	BygzKsB7jLUMluJyx83
X-Received: by 2002:a5d:5f90:0:b0:488:75e4:f5b6 with SMTP id ffacd0b85a97d-48c728ab043mr9472730f8f.54.1791463576829;
        Thu, 08 Oct 2026 05:46:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.u-boot-project.org, Sean Anderson <sanderson@brivo.com>
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@nabladev.com>
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
Subject: Re: [PATCH 0/9] arm64: meson: Add s4 support
Message-Id: <179146357578.183177.12895968507698976143.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3121

Hi,

On Mon, 17 Aug 2026 13:15:11 -0400, Sean Anderson wrote:
> This series (along with several patches submitted separately) adds basic
> support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
> patches on it is at [1].
> 
> I developed this for a custom board, but I believe a better candidate
> for a defconfig would be the publicly-available Khadas VIM1S [2].
> Unfortunately, I don't own any VIM1S boards, but I have included a
> sample defconfig in the last patch. If anyone has a VIM1S, please test
> that patch. You will need to use AMLogic's FIP [3], as I have not yet
> gotten around to submitting a PR to LibreELEC's FIP.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/9] arm64: meson: Add s4 SoC support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0f6e4a9f1b3ba2314c58bcd66a61a8941508b58
[2/9] clk: meson: a1: Eliminate separate id parameter
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/81b3945a2096fba2ba8421641dbdabb5ad73740b
[3/9] clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/99bd1d3f515842e8801d6c8cfd556077b9ba219b
[4/9] clk: meson: Use soc-specific naming for common functions
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f615257213246dc741416b3e92a4e9e76d76d5f
[5/9] clk: meson: Export a1 functions to common file
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5dadc8a09b07f2bfa9bbf0d151b660c0beb92a90
[6/9] clk: meson: Support fractional fixed-factor clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/538d95ef9ed6413dbd735ca799dfad2fe8c6e001
[7/9] clk: meson: Support power-of-two dividers
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/10176b815d013d8825fd243ae20892cae35c249f
[8/9] clk: meson: Add s4 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5363c69e08d0f96834f4d80dcf23e11d64cfd80a
[9/9] meson: Add Khadas VIM1S support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9c048da44bed99311355450d70840bb0795e21f8

-- 
Neil


