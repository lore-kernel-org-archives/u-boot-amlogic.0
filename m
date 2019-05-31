Received: by mail-wr1-f66.google.com with SMTP id h1so5880933wro.4
        for <u-boot-amlogic@groups.io>; Fri, 31 May 2019 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4GVckRnReGUbCzqIb33c4fXJW5STaybprL4EDcDmry4=;
        b=aHBJ/Cc7XzG9U2x/6t7hC7jjzzkD23Ycr9VP4f61phXFODcb+GDQDtJzjsAZmkmylA
         Q24yizumsHPKjj5Gg7RpM3Ezap1Mih39dbr++pIbd9LeAn9tKGOU3V2SHN1z5P4r8jsS
         DL40HgY4v6+vloG71Drc6eO7AIFuJLrA7neYBhMA4BXi+P/QGYTTwi8XfyCl9FLEoCpM
         Fjj3vpYmzJeAvRRZUJ7MQg8yAuF6/AfFVwuD8zZIM7vFMocWGM3E4WHRtQR2jcRZAf9k
         jPoTP6D+b50dspjsR5vaLae8FUPIGYahb8qqq5TpjVtSXQqtka42pLtBk1wQBV80aSDA
         7oBQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/3] ARM: meson-g12a: Add missing support from Linux 5.2-rc1
References: <20190528085038.8088-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b1669ba4-7fe2-26b1-2c27-a13cbc04ca8d@baylibre.com>
Date: Fri, 31 May 2019 10:20:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190528085038.8088-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 28/05/2019 10:50, Neil Armstrong wrote:
> This patchset :
> - Syncs the G12A DT from v5.2-rc1
> - Add support for the G12A PCIE PLL, introduced in v5.2-rc1
> - Add missing DT to fill the gaps, that will be synced in Linux 5.3-rc1
> 
> Neil Armstrong (3):
>   ARM: dts: sync Amlogic G12A DT with Linux 5.2-rc1
>   clk: meson-g12a: Add PCIE PLL support
>   ARM: dts: Add missing DT for Meson G12A support
> 
>  arch/arm/dts/meson-g12a-u-boot.dtsi           | 216 ++++++++
>  arch/arm/dts/meson-g12a-u200-u-boot.dtsi      |  63 +++
>  arch/arm/dts/meson-g12a-u200.dts              | 147 ++++++
>  arch/arm/dts/meson-g12a.dtsi                  | 465 ++++++++++++++++++
>  drivers/clk/meson/g12a.c                      | 103 ++++
>  include/dt-bindings/clock/g12a-aoclkc.h       |   2 +
>  include/dt-bindings/clock/g12a-clkc.h         |   5 +
>  .../reset/amlogic,meson-g12a-reset.h          |   5 +-
>  8 files changed, 1005 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/meson-g12a-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-g12a-u200-u-boot.dtsi
> 

Applied to u-boot-amlogic
