Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.10547.1674548707810555155
 for <u-boot-amlogic@groups.io>;
 Tue, 24 Jan 2023 00:25:08 -0800
Received: by mail-wm1-f49.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12246897wma.1
        for <u-boot-amlogic@groups.io>; Tue, 24 Jan 2023 00:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iq7drxR/iPXEJkTtiiQsWawwEBC/FB4dJO2krGtIa6c=;
        b=ClehyN0zCwnQZRHlbkQuObBxEn76JFoKdaOEqmuxsFG9BvNdQHGJTs+q7UNZzbJpNv
         8rf+pT0CXrWxhv8hm04gLXt0YqJTv6Lx1cYLnK22QOC7G/IYFtN0Tgo9ALaFxCyhL5mk
         kuADcGhwVDeT1ka96MPQvXlFV/TuML1Rq2ROrZraP7wbdbuBKJvVaEJRbDVvGL2iWvWR
         JFwTuEeYTf925W0fYLoEFENAV+rdISOWD9BwWtwoegsQM9O8jsIMa/Gv96+aw0VULKxH
         I9m8LbrAHD+hnAu9bDhGXUCuIJzaZzxYlKdPzVSNG402aVhfhro61e+GTBXX2luXt5QV
         01pw==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230119-u-boot-odroid-go-ultra-v1-0-f96bab9db396@linaro.org>
References: <20230119-u-boot-odroid-go-ultra-v1-0-f96bab9db396@linaro.org>
Subject: Re: [PATCH 0/2] ARM: arch-meson: add support for Odroid Go Ultra
Message-Id: <167454870559.2974637.16320055978262936528.b4-ty@linaro.org>
Date: Tue, 24 Jan 2023 09:25:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 19 Jan 2023 14:44:17 +0100, Neil Armstrong wrote:
> This adds initial support for the Hardkernel Odroid Go Ultra.
> 
> The Odroid Go Ultra is a portable gaming device with the following
> characteristics:
> - Amlogic S922X SoC
> - RK817 & RK818 PMICs
> - 2GiB LPDDR4
> - On board 16GiB eMMC
> - Micro SD Card slot
> - 5inch 854×480 MIPI-DSI TFT LCD
> - Earphone stereo jack, 0.5Watt 8Ω Mono speaker
> - Li-Polymer 3.7V/4000mAh Battery
> - USB-A 2.0 Host Connector
> - x16 GPIO Input Buttons
> - 2x ADC Analog Joysticks
> - USB-C Port for USB2 Device and Charging
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] ARM: dts: sync Amlogic ARM64 DT from v6.2-rc1
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2acbc33b3d19128cb673a980116e9e33fbc5161f
[2/2] ARM: meson: add support for Odroid Go Ultra
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/640192d04f9c4003959c967d11b2f98c3756c451

-- 
Neil

