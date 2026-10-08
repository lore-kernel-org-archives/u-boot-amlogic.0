Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42F7CA6013
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 12:46:20 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14496.1791463579564784209
 for <u-boot-amlogic@groups.io>;
 Thu, 08 Oct 2026 05:46:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=inAueu/c;
 spf=pass (domain: linaro.org, ip: 209.85.128.54, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so3000275e9.1
        for <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791463578; x=1792068378; darn=groups.io;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
        b=inAueu/cAWtsspmdeIXpP3xFJwXYdj7m1HrMmoCBb5x1B2pd9iII2GIoLEwQvdGdYq
         WaALHwNmFLMOpBs9trKmCFqNC3mbpW0KxM8xcNYWWHarEUcpdo6VWoLMfxL/i1q1C8Gu
         2jnQ+lYg2UWBGytFAo3Q1lFJeXUZNUjzI4GxCUrajE0cl58gwsj+VdTXBDJatNRBHjEs
         yko2S1MD2fLC2rUuyNYYJv5+zD0wKMmZanOCkZstm9+85khqifgUMiMjO/T8bq7FnTbP
         ks46qcLCQZl7ZXyyMVLzC7SjNJFD82dxTTi6ahUIt2LMB0zQWpw/8Q57pRBXviqk2xhi
         p5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463578; x=1792068378;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXinAbatRsEMtUtBMVWkeQwgMl1Rc2vT60N5Ns1XSc4=;
        b=Y3H1fd3Tte3fUtFHjvOup2hAcLo8vxC+LzZBNrgQmzWCWin50dmjeW3fnLMvmB5TSV
         I1FTLSSUGCvPpFvU6cRwWv8HWGcgGVbGzgOMntsachT8rN0W7OZG57P6OzdclRZrLb2P
         Ae+pqi60VY0qLiwK5emwKNkunWk4nyZnj70qIIWCgm1RyMiRmos/7VlZQ956ee/dOoHm
         KNGSBrQV4Uv/0EVsFSLPJLEDVAyEWo8RMkdpL4rL8Q3JY8hVzrO/LS+agywzvAkcVwqj
         fRd1NEE4LKwdst9jizKrhKIAZiGuMzTxrtxTUhoyFm3L/6fd9ZJ7pbBf5/FHMlA3Hrm2
         9cvg==
X-Gm-Message-State: AFuF++ncwMHxjBalV/FmzrEsy/ETCZC3F3+sgENtOSzm2PHU+zHjOAzU
	NfOEM5TqHH4p8e10FwwhrL16HBkYIHd2LmQnDYNcWLdm6qKffKt/6OYa8HvCc9NHYQw=
X-Gm-Gg: AYBFou3wT61rrXDg2FdazibNUO17pm6lo2+/uF4VZm4yd8lt2UXYG2kdM7yVx9LHgCQ
	TClR/XYA+1a4JCdUfNWBxD8TVA5J8ZjLoUYMSXjDymyH3jMRcHQUdhxMbllAsVsVhqRoY26AhWe
	kLCMty84pS8JpNWCVe8TJuBEC7MA4LDxPM+92X0BtSK7PUttmt2dfDt7K51/gHizZ1EQU+x8P2R
	qLLgjk9Cs9ibcJcVR/drQzGJ/Tqn/gRmmnFrRdK5EeOwQ4s2qq8NolS1W2+9UVEzp4M/wQOlhxD
	vZ723/dx1UaRbOvNw/4p3eqJeCCbEc1GzU1oXGOkhFXGth4vJZV6saLGeAlACzzlIF/tYXKhcPD
	9D7/VxybKkm06BsFH/DDoDgW7rNVE3OnmfviemhROdhAxHMGrciUSm8pmw8g5qKrIAxWsnOOCpV
	ZSIQRLI7XtPse4HTp8G120mqS7KynCkXD4xP76Qaj0bm46geMsMUAFHuK9RcRrI6I6htIRzhYQd
	PMcfMG3MfpVub/8vN30
X-Received: by 2002:a05:600c:3e08:b0:4a0:1cfd:314 with SMTP id 5b1f17b1804b1-4a180455651mr109791165e9.26.1791463577722;
        Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d04c0fsm11015183f8f.10.2026.10.08.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:46:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
References: <20260910-remove_sei_android-v1-0-b7bcbcef3834@baylibre.com>
Subject: Re: [PATCH 0/3] configs: sei510/sei610: drop Android support
Message-Id: <179146357691.183177.6890118451387915702.b4-ty@b4>
Date: Thu, 08 Oct 2026 14:46:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 08 Oct 2026 12:46:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3122

Hi,

On Thu, 10 Sep 2026 16:04:21 +0200, Guillaume La Roque wrote:
> Remove Android support from SEI510 and SEI610 while retaining generic
> board support. Both boards switch to meson64.h, leaving the shared
> meson64_android.h header unused, so remove it too.
> 
> Fastboot remains enabled, but "oem format" is removed along with the
> Android partition layout.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/3] configs: sei510: drop Android support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/bea8681a949120c5c6b030ae9af8972cb0c35d28
[2/3] configs: sei610: drop Android support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e06e8b3e79707753936e0e881113fe76cbe5534b
[3/3] configs: remove unused meson64_android.h
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/aeb24d97a378ea1199ae54b6c272a32b60fcdca3

-- 
Neil


