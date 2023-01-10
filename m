Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.104764.1673360860906231559
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 06:27:57 -0800
Received: by mail-wm1-f46.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso10096826wms.5
        for <u-boot-amlogic@groups.io>; Tue, 10 Jan 2023 06:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfJFvFFJ2jUn6KqjthcKZ7wOYUf5fooT4kY/gVAdX3M=;
        b=GhY2woQPe5sE/c1DnVupHh6w/hL1iWhWsSH2F1EnE7t/nfniK13eaATbdOeDJ1fNvC
         qmIvEKemSbFcWxKa3pM28YKn+VZmQvS+9jBcuneirUMHLCMGNWkkxqgmoHRfwbAMKEtt
         r2LRi9FPhfQUkUDzphYSvvnm95UU7/ByFFlqMKTOJzQNgGoml4dgnjfsAuFnVvHscg0K
         pDwvaLq3AS5IMRU3JS3a49FoJjchF/wWgABWYcMcgnQuprWgpDWITyELy51DSEMF+7cB
         LuzcQ7jCPrvduXjf1TVPkfRWMCInErOS1z964VrPiJ9gskPmZTuu2rsuSj+hLR0vSqZh
         Ze3Q==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230110105650.54580-1-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
Subject: Re: [PATCH v4 0/5] arch-meson: introduce efusedump command
Message-Id: <167336087600.1975362.17451337193505877896.b4-ty@linaro.org>
Date: Tue, 10 Jan 2023 15:27:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com, Neil Armstrong <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@sberdevices.ru>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Tue, 10 Jan 2023 13:56:45 +0300, Alexey Romanov wrote:
> Keeping the commands code in an arch/ is not correct. This patchset
> moves the meson smc commands from arch/arm/mach-meson to cmd/meson
> folder and also adds a new 'efusedump' command with which user can
> print efuse memory.
> 
> Alexey Romanov (5):
>   asm/arch-meson: add missing meson_sm_write_efuse signature
>   arm/mach-meson: move smc commands in cmd/meson
>   doc/usage: cmd: documentation for meson/sm command
>   cmd/arm: meson: sm: introduce efusedump command
>   doc/usage: cmd: sm: documentation efusedump cmd
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/5] asm/arch-meson: add missing meson_sm_write_efuse signature
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/12d782734927818b9d2f197e3905410632b01fcc
[2/5] arm/mach-meson: move smc commands in cmd/meson
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/311106a1c6eebdc5d0284faae30bf9087227a6c1
[3/5] doc/usage: cmd: documentation for meson/sm command
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/23435cfb3a2b672d7006d2d7e04276bd39fbb1a5
[4/5] cmd/arm: meson: sm: introduce efusedump command
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/38e29404b8630ff7e761c37d6d9fd927135a7810
[5/5] doc/usage: cmd: sm: documentation efusedump cmd
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/12e561f63a16e29b89a9138a929719427736da27

-- 
Neil
