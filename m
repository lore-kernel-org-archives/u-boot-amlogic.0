Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.web11.7153.1576836695976476387
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Dec 2019 02:11:36 -0800
Received: by mail-wm1-f65.google.com with SMTP id t14so8586773wmi.5
        for <u-boot-amlogic@groups.io>; Fri, 20 Dec 2019 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h8YW537XgG8b6LA7O057k/ZlodtuLwa2QfAcj9yCBx4=;
        b=whbbg7ix+97GtOWASRCJOKPNI+9LGK0Rizjf5kPl5mM/Afijix1gDOiZo6Eci/Eu12
         XLmRk6/eqVK/LopestLmH+xGqAwaBLWlwMuW0PvsdtXXtnR0Wv2/XIyVfHKmxkXYkcJg
         8Zget6I4VF8V4FsWCiKs+pPvhqmKQ2RBa36ps8jTA/ZnPGM1FXXKisqAmVm52+neCUi6
         jr9ZfSjwbTAnZn79+zD/GaLzODNcMGtUDL5os3CMfuxLauEzJ7n3oXpT9Cr3dh6qDuEj
         jod6ak/uAYi/JJhk1NQVvbd5ORMRhzow6f7nAnRDQ/JOgLARbIjvWehQd3s6DUCdcdWK
         RNQw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/2] amlogic: add Khadas VIM3L support
References: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8f33ca88-836b-918a-5725-61ee2209c04e@baylibre.com>
Date: Fri, 20 Dec 2019 11:11:31 +0100
MIME-Version: 1.0
In-Reply-To: <1576056054-4458-1-git-send-email-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Christian Hewitt <christianshewitt@gmail.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 11/12/2019 10:20, Christian Hewitt wrote:
> Khadas VIM3L is a new revision of the VIM3 board that swaps the premium
> A311D chip for Amlogic's mid-range S905D3 chip.
> 
> Christian Hewitt (2):
>   ARM: dts: Import Khadas VIM3L DT from Linux 5.5-rc1
>   boards: amlogic: add Khadas VIM3L support
> 
>  arch/arm/dts/Makefile                   |   1 +
>  arch/arm/dts/meson-sm1-khadas-vim3l.dts |  95 +++++++++++++++++++++++
>  board/amlogic/w400/README.khadas-vim3l  | 132 ++++++++++++++++++++++++++++++++
>  configs/khadas-vim3l_defconfig          |  62 +++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
>  create mode 100644 board/amlogic/w400/README.khadas-vim3l
>  create mode 100644 configs/khadas-vim3l_defconfig
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Will push for next U-Boot release.

Neil
