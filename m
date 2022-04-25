Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.26407.1650871538316577256
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 00:25:38 -0700
Received: by mail-wm1-f49.google.com with SMTP id p189so8705120wmp.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Apr 2022 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYN4K8aYQRDC/C3dJRFnV32o/lO9GYwOClYIUq/CULY=;
        b=ya/ZFo649k5qOZ0NvhQNzjEzGVnclpG4pMHvKQ6ZOIWFJLxzmV8OCuVN66IObfEoOc
         HarjOeExdOv/XH5+Ml/tuu0Opau+3OBxI+59AjEs3wWRhv+bAOz8uuXNUK5Hs78emRDp
         B891azNwqYo4gZuDsR8JjaRaZLRf4bt80QJivvNW1QFCPqTgkcEQujiZ290h4fITb+hc
         wWT+J3CM/VGkheiDvyZOkipORSeg+bPjLSR3SBERtLo3bxHq2DAT+4z36xOIJST0UsQH
         gyvSeRM5yunwANdj2OWM1DdArsKnhKJNkF1xTTeVX76N+UBQhjY8nuwrtCZDwHpEkOFn
         PSuw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/6] meson: add clk and adc support for JetHub D1 (j100)
Date: Mon, 25 Apr 2022 09:25:37 +0200
Message-Id: <165087151696.2737808.12423374901852555018.b4-ty@baylibre.com>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lukasz Majewski <lukma@denx.de>, u-boot-amlogic@groups.io, Sean Anderson <seanga2@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>, u-boot@lists.denx.de
Cc: Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Sun, 24 Apr 2022 11:21:53 +0300, Vyacheslav Bocharov wrote:
> Prepare to use ADC channel 1 in JetHub D1 (j100) to check the hardware
> revision of the board.
> 
> - add support for AXG in saradc driver
> - add simple clk-ao driver for AXG (base is taken from g12a)
> - enable saradc in dts and board config file
> - fix typo in the g12a-clk-ao driver name
> - move clk->id check to .request function for g12a-clk-ao driver
> - remove unnecessary check (gate->reg == 0) in g12a-clk-ao driver
> - enable saradc in dts/board config for JetHub D1 (j100)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/6] clk: meson: add minimal driver for axg-ao clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dcccf730043197464f7bafdb1abcebcb7fd828b0
[2/6] clk: meson: fix driver name for g12a-ao clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4da098656228535539be40f76806ad6657b94407
[3/6] clk: meson: update driver for g12a-ao clocks
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/66a657b7c6082fe374c99d5b2a7e0d911091dbe4
[4/6] adc: meson-saradc: add AXG variant
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8a4a73f466c1d2189aa5f8612f2f90ec9a727ea0
[5/6] board: amlogic: jethub j100: enable saradc in dts
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ee8094f69646825d2c30b8bb9082e976f023f710
[6/6] board: amlogic: jethub j100: enable saradc in config
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a718f5524d492fb5708e884cb1db21384f826c00

-- 
Neil
