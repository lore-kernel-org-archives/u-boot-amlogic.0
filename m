Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.40682.1675085073292926926
 for <u-boot-amlogic@groups.io>;
 Mon, 30 Jan 2023 05:24:33 -0800
Received: by mail-wm1-f41.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10015405wmb.2
        for <u-boot-amlogic@groups.io>; Mon, 30 Jan 2023 05:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVT4TobwYHIBQ1pLweMr9v/plKqwRHYP4uD0p4BLvFI=;
        b=ZcIykyqzi4jTRtPE4OXT5CdvkfU8L55kAWFgGs1CcD54UiQpOCJKdccjIT8LxqXTkm
         Od9vjYr+ZbGirBUg78MO8uOZCKXcD0HOFru3j+Cwb0WSQ1BNrVIseZyQcc2zh8P6AHiH
         LXhqIqmHH0M3EhPGHtPF0sCFY6i9OILsML+x/Xra0HrrW4vCICIGxfPS/SNMIUlO97Xx
         RBySDzSxMjL79MHp+gBuzN5U0W/yp/kyO4ETJZI8dHwBY20ffi/ESc8K3vG7KsGeUXgG
         EPtRsdUIfQQBdfQuJI0LuwecGWYvnrRQ1iokim6wyBAJq/Hs4OcOYaQ++CQugFJADiG1
         k3Sw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230126-u-boot-odroid-n2l-v1-0-c60f695e0f6c@linaro.org>
References: <20230126-u-boot-odroid-n2l-v1-0-c60f695e0f6c@linaro.org>
Subject: Re: [PATCH 0/2] ARM: meson: Add support for Odroid-N2L
Message-Id: <167508507110.3597060.1090194074751777004.b4-ty@linaro.org>
Date: Mon, 30 Jan 2023 14:24:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 26 Jan 2023 10:48:19 +0100, Neil Armstrong wrote:
> ODROID-N2L is a variant SBC in small form factor and some peripherals
> are removed from ODROID-N2PLUS based on S922X SoC.
> 
> - On-board ethernet is removed
> - On-board RTC is removed
> - USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
>   are available
> - Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
>   is recommended or a tall passive sink is optional
> - 3.5mm earjack is removed
> - IR remote receiver is removed
> - MIPI DSI port is added
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] ARM: dts: Import Odroid-N2L support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/5017e305ee1c12b757b68f1ed3cfa05d191da3e8
[2/2] ARM: meson: Add support for Odroid-N2L
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8f5e9de121003bfd9a64a5b3a503c0fbd02af823

-- 
Neil

