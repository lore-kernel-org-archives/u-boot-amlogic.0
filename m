Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.9677.1695892089218979828
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Sep 2023 02:08:09 -0700
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-504b84d59cbso2302319e87.3
        for <u-boot-amlogic@groups.io>; Thu, 28 Sep 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695892087; x=1696496887; darn=groups.io;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48oe697wjuP71+52tb7vf8tr+xTvdyJJinslg3eV4H4=;
        b=qOZYQ8+bbb9C9+0Y/+JUVOM1Ru4A+uoL40+g51HrlLmXj8q+b1GUoSIsUxzGvrncJ4
         qVr9b4MoOk5wvs8ZuC7F74zjXqM8B6495b6IPiXYfTLu7SoW/uUppi5ZXBbWpvpUwv3K
         8D9PvC9u88+irumg2VSR8R4UprxyXxzMa6hmKdsJjdPkaZxLjYu68Nj0vzECPZnft2jx
         vpZVwvApaqIdGRtjN7hhjBuiTdT2Mu1X+HVZ06d//XEqeZzv0MTM1kS2Z5hWOpSyOhnz
         Q1bwpwCkUNGm/Dsg/99/zza/4F6vIHwyO7Sav4jtewvFyJFJVpfDeap/Rmn2L/+HhML8
         sgXg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
Message-Id: <169589208560.3562382.4777414752510341666.b4-ty@linaro.org>
Date: Thu, 28 Sep 2023 11:08:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org, post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org, jh80.chung@samsung.com, paul.barker@sancloud.com, Neil Armstrong <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 21 Sep 2023 11:13:33 +0300, Alexey Romanov wrote:
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/8] drivers: introduce Secure Monitor uclass
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/126fbbefd89e0baa7e1a8ecdc4e00b9ff9e776ea
[2/8] sandbox: add sandbox sm uclass driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ac830089c0075d1f6ee51e22d51244f7f1a2554f
[3/8] sandbox: dts: add meson secure monitor node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0b488d719015c3b77685dd116a0095b4677e84a3
[4/8] sandbox: add tests for UCLASS_SM
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/80da22b9e45d2cd7d1eaed4e94724def7d4c7970
[5/8] sandbox: defconfig: enable CONFIG_SM option
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b655672dabcf4f6f5ffe2fb92abd447ea0a20101
[6/8] drivers: introduce Meson Secure Monitor driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e7c31d9ee0606dc52a15eb6e8ef5e46978608681
[7/8] arch: meson: sm: set correct order of the includes
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a0fe285b1f625ff872b1cb8c79abb072cc154ece
[8/8] arch: meson: use secure monitor driver
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4908461153e8b194703c5ae757a5032df3af2c50

-- 
Neil

