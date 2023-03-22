Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.44474.1679495190962801982
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Mar 2023 07:26:31 -0700
Received: by mail-wr1-f52.google.com with SMTP id r29so17255602wra.13
        for <u-boot-amlogic@groups.io>; Wed, 22 Mar 2023 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679495189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMsP7k9u0BifOXxPgTrdy3eTcp51uWjvZjThoXo5Bbo=;
        b=WOZpWwvwsncE6OiyRAL3GqaNkRtRMtQsxim4So61KFWo98VcxLqwVeXla3p/2RaBD2
         yNCgkIuetkdRRSOgRhYTTNKOwkKFS7zndjEwdiVg20xoCNrOhScArpCKdBIP0hsGawmn
         Lu0LFwYU+6L5ym0KMDu3ZjN/AUGNdNJpqJ+PyZoFVzh9CuwfswKZtfuaVJok8NJsD9cl
         BfpJr27VEB9zGWXn8z6fAwsHp0UjQNO0RtoLRhaJuBhiHO1a3azej/cK1q/crCfgdZ2m
         yVPx++Wnb+FlmlV0SJncg9eo0tCAEukLccmKOgkWscjZbEnD3hzKe0ToGoTmuXNRV02C
         7l/g==
Return-Path: <neil.armstrong@linaro.org>
From: "Neil Armstrong" <neil.armstrong@linaro.org>
In-Reply-To: <20230320114609.930145-1-christianshewitt@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
Subject: Re: [PATCH 00/33] doc: board: amlogic: spring clean-up of Amlogic docs
Message-Id: <167949518881.2761490.386711054164333230.b4-ty@linaro.org>
Date: Wed, 22 Mar 2023 15:26:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org, Christian Hewitt <christianshewitt@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On Mon, 20 Mar 2023 11:45:36 +0000, Christian Hewitt wrote:
> Amlogic documentation spans U-Boot support from 2015-current resulting
> in older content being harder to follow. And due to many international
> contributors the docs also contain grammar quirks.
> 
> This series reworks all board documents to be more consistent. There is
> deliberate emphasis on using the amlogic-boot-fip repo for signing tasks
> as this is easier for most users to follow. The original/longer signing
> process (described as Manual Signing) has been tidied up.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[01/33] doc: boards: amlogic: update documentation for index page
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/862b7c1fcc5e94c7d91cc9caf22c7b6205b7fffd
[02/33] doc: boards: amlogic: update documentation for boot-flow
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4ce746b8cf07ed4c532a36fda587104d667bf54a
[03/33] doc: boards: amlogic: update documentation for pre-generated-fip's
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3d1744b392ae57adfa1c068acb9f94a44cc82070
[04/33] doc: boards: amlogic: update documentation for Beelink GT-King
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d0d4a85d14b18dda87ef0111a03644a9886aebd4
[05/33] doc: boards: amlogic: update documentation for Beelink GT-King Pro
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/c03d19d5dc0e20dde9c4b34feb0f47c59a82a640
[06/33] doc: boards: amlogic: update documentation for JetHub J100
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/cf43c9f7d3c7b4b83a94a9ff961b0807f4f92c47
[07/33] doc: boards: amlogic: update documentation for JetHub J80
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/47ab069e9a9dd047dcad3c984d8e6cbcb6e26a04
[08/33] doc: boards: amlogic: update documentation for Khadas VIM
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/329794577adf7e53ba1e0c3a86686e21655965c1
[09/33] doc: boards: amlogic: update documentation for Khadas VIM2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e3de21c60685d15fd5746b23a7d72545889580cd
[10/33] doc: boards: amlogic: update documentation for Khadas VIM3
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/de54d4cc16b9d4bfdda196dac5bdbd0d8128cd02
[11/33] doc: boards: amlogic: update documentation for Khadas VIM3L
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3240318b212d46e1e5ea4af92eec6b26b67f5ad4
[12/33] doc: boards: amlogic: update documentation for LaFrite
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/cb197ca63debc82d23a8ca419623278839b6ff48
[13/33] doc: boards: amlogic: update documentation for LePotato
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ba07d965dd5ee74e66c32bc5a3fce5c69ed4b2d2
[14/33] doc: boards: amlogic: update documentation for NanoPi-K2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7c7ecc84f1c1edb79e7e2b1e0070b288cf1e22fc
[15/33] doc: boards: amlogic: update documentation for ODROID-C2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/665633ec055d15989e187861ea419518bf517017
[16/33] doc: boards: amlogic: update documentation for ODROID-C4
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4760b2e8e2e46ad61ab7ed91733786d9a9e4696c
[17/33] doc: boards: amlogic: update documentation for ODROID GO ULTRA
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/144ffe96aa1638028593afa2b669bcf08ac0ad38
[18/33] doc: boards: amlogic: update documentation for ODROID-N2/N2+
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/11a1fc1d305e773f27135adad56cbcc5e1c2bd6a
[19/33] doc: boards: amlogic: update documentation for ODROID-N2L
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/6ba5d42c42752829b22f80748972716d5bb27c59
[20/33] doc: boards: amlogic: update documentation for P200
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f0b8c1f6a54b8ef45972a18e969250d859c9a866
[21/33] doc: boards: amlogic: update documentation for P201
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/db6b333e37c2a98e2bcc09a5545635aaeb2c1301
[22/33] doc: boards: amlogic: update documentation for Q200
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3ce3109c3783c27aa18b0a17eb6d8ead23f92d85
[23/33] doc: boards: amlogic: update documentation for Radxa Zero
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1b23862b4177151b477d740e8760d45978549926
[24/33] doc: boards: amlogic: update documentation for S400
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/aabf0dcb31dce2443975ab21871fa32077a89e1f
[25/33] doc: boards: amlogic: update documentation for SEI510
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d784394073bcb1884628621899d41a6b82c626e8
[26/33] doc: boards: amlogic: update documentation for SEI610
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/02b7453f2b573ca9fba83cc671a7732e090df020
[27/33] doc: boards: amlogic: update documentation for U200
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d7a3034b40894c7d065de1b4070da7cef8574150
[28/33] doc: boards: amlogic: update documentation for W400
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d00df62bdafd7ac570a08f7f812f547155a394f8
[29/33] doc: boards: amlogic: update documentation for WeTek Core2
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/433ed65e21eb3778b460d550a0d5af3cb4e5d7ca
[30/33] doc: boards: amlogic: add documentation for BananaPi CM4IO
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/4f94b51561ea2e6b9e5b12ca7b2dbedf96ca81ab
[31/33] doc: boards: amlogic: add documentation for BananaPi M5
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e2b60c150c3b6a418e286945cc337d6efffa1f11
[32/33] doc: boards: amlogic: add documentation for GS-King-X
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/d0072d1bd98477ae3ab701633db9630c242846d8
[33/33] doc: boards: amlogic: add documentation for ODROID-HC4
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f288eeb66306187d97cc45a2781e0804cc840093

-- 
Neil

