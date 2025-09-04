Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBDCAC581
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:39 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.35202.1756979855621769213
 for <u-boot-amlogic@groups.io>;
 Thu, 04 Sep 2025 02:57:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=VG0tCKms;
 spf=pass (domain: linaro.org, ip: 209.85.128.45, mailfrom: neil.armstrong@linaro.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so5797905e9.0
        for <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756979854; x=1757584654; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3POGfZGDyyhRv03yWjCoIknRoKZGkOSARQajjMkpOY=;
        b=VG0tCKmsQ31QZkSYonrVwWzesIsgg1IGTpmD2u6NLVDuxIXX+02TxBdq5y5UKhge2I
         Em+BTZsNnKAdWlTk6PA9BtyunKCKb24jXoqBrxZn8Dnbi+3ABnHpw8G7bFdKeRDlClyw
         olRFDoeiFtPg9+Qsv2so0li7RYnzYMu6fHvr+rUAzkT946G2u32WArIHJjdfu5jE7JJk
         F5ojxGX2VzgybMyXD+Gus79rPtcztr+bN01jEo0RpWhwveKtzC7W5s3bPIUmCE2GD98m
         smiX8nizXIKWpHOXqQ+STvrkcSwUsLhAKH69OP0joVZ2tVATtbeXV03S/ygM+oZviHR6
         yGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979854; x=1757584654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3POGfZGDyyhRv03yWjCoIknRoKZGkOSARQajjMkpOY=;
        b=tGJtHVFz6QHHHFMzvdSf624AhULZjrtEoVV4VszSH8INJMKcGmWxZ/2MgS2EmvVnxI
         GqDT1Oz8YJRScFa7MpHLh/3DT5wGZ2YgGDy3Jry6T6zEe0fZ7ILFdxtBOsmu364KmYsM
         NNrZxrW3JWPOGTKBsmXenocPMIWd/hlp0BX3pro/DJvwI8NJUEKo9SaRdiue5vXO0lMM
         O0nTJz+ukcKQPfeSYQxlMAxcDcf6z8YACmGR4ZtSlRrKFNQpJiViSsAyUB+2NDkA95Zr
         bqBw2BLH/vhhR97m2xG9y8sHJLUUhg4M4vnnRVXbTFSeIcmVmxbgCbUinlb9vOdw6O5y
         roBg==
X-Gm-Message-State: AOJu0YxJgLIwc9hdSOTXZAPRX932cCFw8LSUUjTIpeGWmoQ+sqU/FFtN
	jfCskJcVNqzffGuQzWzFGK36Kw1UP+wtRKDjRvpXaZ5B44xc+EXD0MnaJJ3BLE11rv6HlMTdXll
	4La7kY6+F0w==
X-Gm-Gg: ASbGncue9FCC13sY8PNLiWUBfxvbBCG8UTfUARE7LHgBQfS4bx3lHmCInK1gETFeWiu
	U3Tmhf4wKUbqRfxGUnghxs6cSsh1/G1hjG7+ukEtTtvHoqCFH8lYxC/Bh3E7sq3SySx9h3qvj+G
	+uI1evs769kDWDK/hfppdAUeNxAz5x5LOZXAF7u71Gjy6Dk9kckdBCM1ziDKEhtjOacX6Nl843S
	XpldPGCGZXX6dd/v9HHF1w+tSRqdhq02X2MFYK/4VHzBraq6zP3q7evaL8sXxmh4Fb/poleZxiJ
	wEGzGS45rKoCrxEWEcEUtyteVWrW2+1PvsGiy1f2I+fdTEv8cM8Gp2zYR2GMK2IlJRG8HSj52+a
	dfDr3ZfMz0EAhSJeGo28dX+luienmSRk4eJbzOr1doTVMWBIeIIYYsg==
X-Google-Smtp-Source: AGHT+IH+Yfs7NuGyGtKKf7InDIoMxHtmm1njuRgowUdhbCvE/SzypbjlcfPWFKO/Tkea8vmiaOA+cA==
X-Received: by 2002:a05:600c:c4ac:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45b85526106mr174218625e9.5.1756979854035;
        Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
References: <20250722-meson_saradc-v1-1-1ab45d53da9d@linaro.org>
Subject: Re: [PATCH] adc: meson-saradc: uint cannot be less than zero
Message-Id: <175697985356.2904655.7249459124998381725.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 04 Sep 2025 09:57:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2740

Hi,

On Tue, 22 Jul 2025 15:06:14 +0100, Andrew Goodbody wrote:
> timeout is declared as a uint but then tested for being less than zero
> which must always fail. Change the while loop for a pre-decrement on
> timeout and test timeout for being zero.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] adc: meson-saradc: uint cannot be less than zero
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/9504c710153f3b15812460b6a48e166e112f66eb

-- 
Neil


