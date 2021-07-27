Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.8501.1627374864124625107
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:34:24 -0700
Received: by mail-wr1-f52.google.com with SMTP id c16so4312433wrp.13
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DEFcPe1SbilL9f5ZDCEkK3o5dKWdWbqvOUS/UxIdaa0=;
        b=XXXkMZPkhi3jSSWhwsuyp/EybXHY0pADRBW/FFrCMZ5aHKXXc6wMAHaahifjI7D4tO
         5/+JDRuGZavpP0nkQSTsZ8t/tpLIELlltnlNKO3Yz7QxfAoKKq38gFnjSmIbAChsOhNE
         P/TN2lWzQf5OuYG6vc14lm0JQxMP/IZA3fzMJpyHKbK01mtIHkEU/DVn520iAHbc4QF4
         usrgHzbAg+pTVLbG3vy85TNdcPAz3/EnVw1pWNCLd1mUe4uUQdap0GrkmlT4JDf99ABx
         +S37z7XtBOYWdyXOLSXb0IpFA1ndeXeN8w16T7tikJ6avZs9DYj96cSE8VgNGuCa3BS8
         sLpw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] phy: meson-axg-mipi: Rename "priv_auto_alloc_size" to "priv_auto"
References: <20210514205421.65093-1-alpernebiyasak@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <54092893-ea21-172d-036d-a67431b569c2@baylibre.com>
Date: Tue, 27 Jul 2021 10:34:21 +0200
MIME-Version: 1.0
In-Reply-To: <20210514205421.65093-1-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 14/05/2021 22:54, Alper Nebi Yasak wrote:
> With commit 41575d8e4c33 ("dm: treewide: Rename auto_alloc_size members
> to be shorter") "priv_auto_alloc_size" was renamed to "priv_auto". Apply
> the rename to these two drivers as well.
> 
> Fixes: 4547551aa019 ("phy: Add Amlogic AXG MIPI PCIe Analog PHY driver")
> Fixes: 7ef19503bacf ("phy: Add Amlogic AXG MIPI D-PHY driver")
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> 
>  drivers/phy/meson-axg-mipi-dphy.c        | 2 +-
>  drivers/phy/meson-axg-mipi-pcie-analog.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/meson-axg-mipi-dphy.c b/drivers/phy/meson-axg-mipi-dphy.c
> index 8b2469793ddc..cf2a1cd14c7f 100644
> --- a/drivers/phy/meson-axg-mipi-dphy.c
> +++ b/drivers/phy/meson-axg-mipi-dphy.c
> @@ -389,5 +389,5 @@ U_BOOT_DRIVER(meson_axg_mipi_dphy) = {
>  	.of_match = meson_axg_mipi_dphy_ids,
>  	.probe = meson_axg_mipi_dphy_probe,
>  	.ops = &meson_axg_mipi_dphy_ops,
> -	.priv_auto_alloc_size = sizeof(struct phy_meson_axg_mipi_dphy_priv),
> +	.priv_auto = sizeof(struct phy_meson_axg_mipi_dphy_priv),
>  };
> diff --git a/drivers/phy/meson-axg-mipi-pcie-analog.c b/drivers/phy/meson-axg-mipi-pcie-analog.c
> index 276e6004e5ee..7106c23d508f 100644
> --- a/drivers/phy/meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/meson-axg-mipi-pcie-analog.c
> @@ -229,5 +229,5 @@ U_BOOT_DRIVER(meson_axg_mipi_pcie_analog) = {
>  	.of_match = meson_axg_mipi_pcie_analog_ids,
>  	.probe = meson_axg_mipi_pcie_analog_probe,
>  	.ops = &meson_axg_mipi_pcie_analog_ops,
> -	.priv_auto_alloc_size = sizeof(struct phy_meson_axg_mipi_pcie_analog_priv),
> +	.priv_auto = sizeof(struct phy_meson_axg_mipi_pcie_analog_priv),
>  };
> 



Applied to u-boot-amlogic,

Thanks,
Neil

