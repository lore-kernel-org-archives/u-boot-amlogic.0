Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.26398.1683618718648018388
 for <u-boot-amlogic@groups.io>;
 Tue, 09 May 2023 00:51:59 -0700
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so29519875e9.1
        for <u-boot-amlogic@groups.io>; Tue, 09 May 2023 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683618717; x=1686210717;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFfmZkkmr9JCgz3HzdYWUu9F2mN8+Y5TiQBR+FlvOmA=;
        b=TKByP2CUS/lQGTAHmEwfLstYWAdWwvRgFHU5UjfUuzyehNbyCWDtDD7TUdL9zwGAfJ
         wbgBOn9oi5VXn5/ZRyyEhhbmYXQynJXUKQfvvMKvOTKxHxR/tu2yBm6xm4LI+2O3g0nA
         luixiverN+GWAv+HT/lQ/CHD1RDjLoRIHuhp8egSGEsX4KpMuiwke6kEFkvikkkFUMwV
         jOnSN1QebLAguJQABgge4oaOQWmj5QnAr+qftwDr/TTqKqtMSHIxOGRXuFba/XXWnbnv
         A+1bbLOI/hzNf6Rd2oYoLsJVc15PEiwUFVlZR7kfv9RYvFgfAp7TzH8NgKFfOaGXBmcf
         XP5g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 0/5] Amlogic A1 SoC Family Support
Message-Id: <168361871627.3278480.5132152433631835705.b4-ty@linaro.org>
Date: Tue, 09 May 2023 09:51:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Igor Prusov <ivprusov@sberdevices.ru>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Fri, 05 May 2023 15:56:34 +0300, Igor Prusov wrote:
> This patch series adds basic support for Amlogic AD401 development board
> based on Amlogic A1 SoC family
> 
> Changelog:
>  v1 -> v2:
>  - Add MAINTAINERS for new board instead of using one in the repo root
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/5] ARM: dts: Add Amlogic Meson A1 DT from Linux 6.3-rc7
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f3e143302c81add70c5856f46dc035f3b8b2a0ac
[2/5] ARM: dts: sync meson-a1-ad401 from Linux 6.3-rc7
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d0ead36dc0fd312a4a9dfa2ac3befe618c5d3e2f
[3/5] ARM: meson: add A1 support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a010e2619819752a7c0973d3b95fe9698445e7f5
[4/5] pinctrl: meson: add pinctrl driver for Amlogic A1
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b5602e7e7fb491caef80bdbc2e97443c0239d8ae
[5/5] board: amlogic: add support for AD401 board
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fc232868c89978af2c94d3f4d0a49e0f6f3d74b0

-- 
Neil

