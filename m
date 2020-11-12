Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web12.4127.1605188132755096559
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Nov 2020 05:35:33 -0800
Received: by mail-wr1-f68.google.com with SMTP id r17so6053403wrw.1
        for <u-boot-amlogic@groups.io>; Thu, 12 Nov 2020 05:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2wl0kXr04kQQ8O7qC9XQnkO75HS1M5RhEW9ziNB6sB8=;
        b=eVcsUi56r/Fg13Kqxg2ky1gdXDLqiVkqvHSpfVLydJeaneZcMh5DgeEqRIfcSdl8BY
         l4u3/DrBw499KqSFXBkikxRtZ8k+2i9GXChkAHWIKXDST9REOk/3Uf7vM8GI/0clrv16
         Mz/JuGU147YkiP3Mt0060KWyaWoemHc7nPBjnSNHmQSOQaWvNT27veUwhP++If/shkmh
         CEyyPXoge348MuQu76PqFNVtVPlL3Jgf3XPjgkYLKxhde4DCcYTU6fr3ihbF30kB/QkX
         5cOyC+h4kYd8WhpURyoGwxtonzpGVaCRVo3tNqUQTijLwjs8niayRGUZs/WKSay7X9fo
         dZRQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH RESEND v2 0/2] arm64: meson: add libretech cc v2 support
References: <20201106094555.34241-1-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <5eec188b-cabf-45b8-ef1c-5a32f2eec649@baylibre.com>
Date: Thu, 12 Nov 2020 14:35:29 +0100
MIME-Version: 1.0
In-Reply-To: <20201106094555.34241-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

On 06/11/2020 10:45, Jerome Brunet wrote:
> This patchset adds support for the Amlogic based libretech cc v2.
> Like the v1, this revised platform used the s905x SoC.
> 
> Changes since v1:
> - Move Makefile change to patch #1
> - Amend documentation for libretech cc v2
> 
> Jerome Brunet (2):
>   arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
>   arm64: meson: add support for libretech-cc v2
> 
>  arch/arm/dts/Makefile                         |   1 +
>  ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 +
>  .../dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 ++++++++++++++++++
>  board/amlogic/p212/MAINTAINERS                |   1 +
>  configs/libretech-cc_v2_defconfig             |  82 +++++
>  doc/board/amlogic/index.rst                   | 117 +++----
>  doc/board/amlogic/libretech-cc.rst            |  15 +-
>  7 files changed, 480 insertions(+), 61 deletions(-)
>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
>  create mode 100644 configs/libretech-cc_v2_defconfig
> 

Thanks,
Applied to u-boot-amlogic-next
