Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.4416.1632209250709871008
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Sep 2021 00:27:31 -0700
Received: by mail-wr1-f53.google.com with SMTP id d21so36244098wra.12
        for <u-boot-amlogic@groups.io>; Tue, 21 Sep 2021 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0PwEDGTPRro2alS0ClsR6YAslDSZVxP1VEPJKCmYxU=;
        b=pXBORA0DRt3Qg3EbdaM3pWY+pszf7AcgfCCY28gjtlidf9wlc7hH3QCZhV1sVHsA8C
         dX94rNphIWjMCBArP9drBU+xabO6sjqTYBpvSg5b9r3rXJUVC9+9R08j7+ZiVv0g0VV5
         EI9I8nWp9ubrM0obvzTdM25HFL/q+Z2Eyy77StolsEMA1nE7r/LH0xPqTmIbczx3basC
         WX3HEyorISxIlhofKa6qogjBa03RxXwplz3jbk/NSzshMnHlJ+CLp5xmCGK/X4mKdAN2
         Gu44p5wCv+h/x+vDj+h2lZYOFIHLPJtFI+etFg9q3obD23valkDndqeTDd+WsGNIsvnd
         snaw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] pci: pcie_dw_meson: fix usb fail when pci link fails to go up
References: <20210908123212.382716-1-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <160d1e30-f95a-948c-8fb6-6083c6722ca0@baylibre.com>
Date: Tue, 21 Sep 2021 09:27:28 +0200
MIME-Version: 1.0
In-Reply-To: <20210908123212.382716-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Art Nikpal <email2tema@gmail.com>
List-ID: <u-boot-amlogic@groups.io>

On 08/09/2021 14:32, Neil Armstrong wrote:
> On Amlogic A311D, when the PCIe link fails disabling the related clocks
> makes USB fail. For an unknown reason, this doesn happen on the S905D3 SoC.
> 
> Mimic the Linux behavior by not considering a link failure a probe failure,
> and continue even if the PCIe link is down.
> 
> Reported-by: Art Nikpal <email2tema@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pci/pcie_dw_meson.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
> index 0525ecbea6..07da9fa533 100644
> --- a/drivers/pci/pcie_dw_meson.c
> +++ b/drivers/pci/pcie_dw_meson.c
> @@ -319,15 +319,9 @@ static int meson_pcie_init_port(struct udevice *dev)
>  
>  	pcie_dw_setup_host(&priv->dw);
>  
> -	ret = meson_pcie_link_up(priv, LINK_SPEED_GEN_2);
> -	if (ret < 0)
> -		goto err_link_up;
> +	meson_pcie_link_up(priv, LINK_SPEED_GEN_2);
>  
>  	return 0;
> -err_link_up:
> -	clk_disable(&priv->clk_port);
> -	clk_disable(&priv->clk_general);
> -	clk_disable(&priv->clk_pclk);
>  err_deassert_bulk:
>  	reset_assert_bulk(&priv->rsts);
>  err_power_off_phy:
> 


Applied to u-boot-amlogic-next

Neil
