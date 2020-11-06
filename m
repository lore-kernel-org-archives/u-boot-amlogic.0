Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web08.9392.1604655104225592721
 for <u-boot-amlogic@groups.io>;
 Fri, 06 Nov 2020 01:31:44 -0800
Received: by mail-wr1-f65.google.com with SMTP id c17so561851wrc.11
        for <u-boot-amlogic@groups.io>; Fri, 06 Nov 2020 01:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/lkof/1LQj9B3hNfHnGHYphitH8wRYQaZOJ6U7OZlE=;
        b=HcdjVbcioMQskfCScZ2qylcPu6nTeTucdyHfEQ22pOA2jp6KmRx0ErMIvBq2KzWD/4
         rnz/dOhEs5Na0uuYwLmT6OwyukWXtw9AAAnkQ6LeEyddx/qY0/DUB6HzjHQ47cVXT2ew
         6C0ORd9mvGd1HmL3ueg97t3Ha1CQXZpEK9tCyOoE7rm8rh64C1IjnzyQvwoLV+4Tqydi
         7/FEVJAHRli7OOCbBhtGu5U8FYTYl0X6qX+2jc4rjtLiZqS+tAhQDRYg8fwlkdEOePcq
         iio4yvbIFQs4S5CxG7Dz3yb/DAae5h4xnyc95Y4bUSqcgDJYLj3KQapEuiBf3gASdk0A
         j1NA==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/2] arm64: meson: add libretech cc v2 support
References: <20201106090752.31005-1-jbrunet@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <b93c004f-7783-7402-2e65-ed16380ee4bb@baylibre.com>
Date: Fri, 6 Nov 2020 10:29:31 +0100
MIME-Version: 1.0
In-Reply-To: <20201106090752.31005-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Jerome Brunet <jbrunet@baylibre.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Da Xue <da@libre.computer>
List-ID: <u-boot-amlogic@groups.io>

Hi,

On 06/11/2020 10:07, Jerome Brunet wrote:
> This patchset adds support for the Amlogic based libretech cc v2.
> Like the v1, this revised platform used the s905x SoC.
> 
> Changes since v1:
> - Move Makefile change to patch #1
> - Amend documentation for libretech cc v2

Seems you had a patch issue, the following patches are the same as v1

Neil

> 
> Jerome Brunet (2):
>   arm64: dts: import libretech-cc-v2 from linux v5.10-rc1
>   arm64: meson: add support for libretech-cc v2
> 
>  arch/arm/dts/Makefile                         |   1 +
>  ...eson-gxl-s905x-libretech-cc-v2-u-boot.dtsi |   7 +
>  .../dts/meson-gxl-s905x-libretech-cc-v2.dts   | 318 ++++++++++++++++++
>  configs/libretech-cc_v2_defconfig             |  82 +++++
>  4 files changed, 408 insertions(+)
>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2-u-boot.dtsi
>  create mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
>  create mode 100644 configs/libretech-cc_v2_defconfig
> 

