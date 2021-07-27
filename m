Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.8606.1627374870280104712
 for <u-boot-amlogic@groups.io>;
 Tue, 27 Jul 2021 01:34:30 -0700
Received: by mail-wr1-f47.google.com with SMTP id q3so14237820wrx.0
        for <u-boot-amlogic@groups.io>; Tue, 27 Jul 2021 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1dACjLnr1I3+8X1NUENsK2wW/9qfPUticKyDd8OSIU=;
        b=qkIYniG3yh5f/X4r0veEzIZjBVx/tDIjxmnc+xmVnd8Q07/EWT5/AhxKNKQMkBubX2
         /hPYkeSnxI1DAxOqCAUMTtC81WJB2Y9PJz+jwUKPhpKOcP8xsf2sONYFTpfN+57Ggurc
         S0V3QJ5QqoWzrdoV61AHjey32HCeRyntNZw1tDFsv+dXUwzHEKc/e3q8CaH5lxPsDtxZ
         xoNHAtZX5RHzjWytG25RI0JuZ7QdPU5U1P0WRHAcsdBzYaTCJPzlT9PLjFHdezAmkrgS
         rTL2D1MlAaJUSa7AuDb3qtJGNQYQ5FCxaATRdrOSsmi/uk3PwIaMpxBXKvvlgnleoycw
         6P6A==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] phy: meson-axg-mipi: Access parent ofnode through dev_ofnode()
References: <20210514205421.65093-1-alpernebiyasak@gmail.com>
 <20210514205421.65093-2-alpernebiyasak@gmail.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <909652bd-cdc2-23e6-7ae7-a2d13bea6a7d@baylibre.com>
Date: Tue, 27 Jul 2021 10:34:27 +0200
MIME-Version: 1.0
In-Reply-To: <20210514205421.65093-2-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 14/05/2021 22:54, Alper Nebi Yasak wrote:
> With commit 84a42ae36683 ("dm: core: Rename device node to indicate it
> is private") and commit f10643cf8a4c ("dm: core: Access device ofnode
> through functions") accesses to the "node" member were replaced with
> dev_ofnode(). Also apply that replacement here.
> 
> Fixes: 4547551aa019 ("phy: Add Amlogic AXG MIPI PCIe Analog PHY driver")
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> 
>  drivers/phy/meson-axg-mipi-pcie-analog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/meson-axg-mipi-pcie-analog.c b/drivers/phy/meson-axg-mipi-pcie-analog.c
> index 7106c23d508f..236ea1ce5ca7 100644
> --- a/drivers/phy/meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/meson-axg-mipi-pcie-analog.c
> @@ -211,7 +211,7 @@ int meson_axg_mipi_pcie_analog_probe(struct udevice *dev)
>  {
>  	struct phy_meson_axg_mipi_pcie_analog_priv *priv = dev_get_priv(dev);
>  
> -	priv->regmap = syscon_node_to_regmap(dev_get_parent(dev)->node);
> +	priv->regmap = syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> 



Applied to u-boot-amlogic,

Thanks,
Neil

