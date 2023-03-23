Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.76489.1679585910759990260
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 08:38:31 -0700
Received: by mail-wm1-f51.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so1144902wmq.2
        for <u-boot-amlogic@groups.io>; Thu, 23 Mar 2023 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679585909;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5ztXOldgBUHsTc8vqW9in2DMYhalEKyTgDQj3aqFmw=;
        b=EmtH9hjwZwtp/CoRG5DqjcK1PDdppqYjdBU/tcEjAUJSCYTtJcRvyU9pc0bAadSpuX
         f2Zz27D6wgq6pXIElEKlIdb7TxC6NNqLs0vLayg5N7PqWDdQlZUAUMEhwsqGoRbwov83
         MJQVYa+HbFrOlWmw3zv0rSKC0kJVsfxAhlpKmbHvGpitqEAyHAPXv/Me0ZVF574LYEnw
         xx6kkcwl+j1W7DlS7fZsCv3b6V5jFpJngZw2w0pbS5X0d0NNWDxW9RlXD4rWzdcG1mw3
         okiZsbpgFDgExaZQNrHslacQLwNPeVSabz2xJl0ovGPvAsvwljawInhTdyKV9hlF7ckA
         YqXg==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230323143142.780306-1-christianshewitt@gmail.com>
References: <20230323143142.780306-1-christianshewitt@gmail.com>
Subject: Re: (subset) [PATCH v2 00/14] boards: amlogic: add BananaPi/Radxa/WeTek boards
Message-Id: <167958590859.727591.8895385261532366632.b4-ty@linaro.org>
Date: Thu, 23 Mar 2023 16:38:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Thu, 23 Mar 2023 14:31:28 +0000, Christian Hewitt wrote:
> This series adds support for the following boards which are
> tested and booting fine with 2023.04-rc4:
> 
> - BananaPi M2-Pro (S905X3)
> - BananaPi M2S (A311D or S922X)
> - Radxa Zero2 (A311D)
> - WeTek Hub (S905)
> - WeTek Play2 (S905)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[01/14] docs: boards: amlogic: add bananapi-m5 to u200 maintainer file
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/86e59bdd4d55c46fbe7bd856fa16e27c970f407f
[03/14] ARM: dts: add support for BananaPi M2-Pro
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4170731c4a9dfb5583d45453f323be7975521c18
[04/14] boards: add BananaPi M2-Pro defconfig
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d33260a5054b716baa5336f2c788e0e07ae46417
[05/14] docs: boards: amlogic: add documentation for BananaPi M2-Pro
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b2fc35e5f138c6e7449c925324891dbbb70bb400
[06/14] ARM: dts: add support for BananaPi M2S
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/56a92bd4f443634ea6a50bb4b7269e1c04c9e00b
[07/14] boards: add BananaPi M2S defconfig
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/43c67ddf59ff7a4dc62fc0d4c49fe3d54463bc66
[08/14] docs: boards: amlogic: add documentation for BananaPi M2S
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/40f1eea84e2845deda5ce5fbf6c4f8fb1bb85463
[09/14] ARM: dts: add support for Radxa Zero2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3016f6fb9e4c506ce751b36215cc1ac44aca31b0
[10/14] boards: amlogic: add Radxa Zero2 defconfig
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2c57d114d2716e75fa0b4e8f0149215437f603a8
[11/14] doc: boards: amlogic: add documentation for Radxa Zero2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/37eda34cb5afb230df00b7ebc74c8164b89cbc4c
[12/14] ARM: dts: add support for WeTek Hub and WeTek Play2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b07e8fb073aa1b847e9ceb563b76808c88be2af9
[13/14] boards: amlogic: add WeTek Hub and WeTek Play2 defconfig
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/fcb0fb2bd6d9e4042bed21685da893f5765305eb
[14/14] doc: boards: amlogic: add documentation for WeTek Hub and WeTek Play2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f097eedf0c04fc6307e22b4b707aa3b47c921b4c

-- 
Neil

