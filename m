Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web10.20088.1586973322659102685
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Apr 2020 10:55:23 -0700
Received: by mail-wr1-f65.google.com with SMTP id h9so956118wrc.8
        for <u-boot-amlogic@groups.io>; Wed, 15 Apr 2020 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=An/acjq45ZssCxyR/HhXSRwxzPmy9eQ+PdagFoEdpws=;
        b=aNl7g9ScZgIb1mX+9OnAV8W+MP477pziHuvgqfQw73Wwoa4TMH+QYmG4zjxU9fWK1R
         1OFPRZArnkGlP99VU0Hia4r6S50rP8vV25dyezsXHA2YqdutUimPib6ntTi9HaMbu34H
         DRQw0CfurcqM3cBJsFtL/9ARt3/kahyIRpH5FFGNQ4AXiBUnYTDu0P2Wpb+fGyyyU2SM
         iS6KpP+IiS1cqdnEI/lH6ol3fRxMu8kPHttt6GkgT3qwnX8zfI6CyRqp+xYwNRkz5EdO
         4kUlyxmbDALuueh9meIkEFYcuyJ8jpbfHSFlxdDQ1Vk/9kDxg5RRXT9jo9S2rwZEocpE
         omxQ==
Return-Path: <jbrunet@baylibre.com>
References: <20200415155830.2649-1-narmstrong@baylibre.com>
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] ARM: dts: add missing meson-gxl-s805x-libretech-ac-u-boot.dtsi file
In-reply-to: <20200415155830.2649-1-narmstrong@baylibre.com>
Date: Wed, 15 Apr 2020 19:55:19 +0200
Message-ID: <1jk12gmy60.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
Cc: u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>


On Wed 15 Apr 2020 at 17:58, Neil Armstrong <narmstrong@baylibre.com> wrote:

> The libretech-ac u-boot.dtsi file is missing to enabled DT nodes changes
> to enable Video output on U-Boot.
>
> Fixes: 671b1db8f8 ("arm64: dts: meson-gx: vpu should be probed before relocation")
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks
Tested-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
>
> diff --git a/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> new file mode 100644
> index 0000000000..c35158d7e9
> --- /dev/null
> +++ b/arch/arm/dts/meson-gxl-s805x-libretech-ac-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +#include "meson-gx-u-boot.dtsi"

