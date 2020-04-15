Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web11.18079.1586967264775554777
 for <u-boot-amlogic@groups.io>;
 Wed, 15 Apr 2020 09:14:25 -0700
Received: by mail-wr1-f66.google.com with SMTP id j2so518446wrs.9
        for <u-boot-amlogic@groups.io>; Wed, 15 Apr 2020 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rls8Uyyk5wxibKxew5YxPwZXHzm4Rrs8MBBfkS4KMkM=;
        b=pNgUC2ngmRHRZNpi0Qf3Hjdc0k6cstFXF+U1DvXtGMY2NupdAXtop4bvNf7iVxojMj
         5IHtqJvL2wDEazyCcCr3w+N8HAc4n9wAhPyZd5CuTJdpz1tRrbOc400ennRJWZS/Ig6z
         gVc/gFFUWt9LveWFBWDHZnmBDeXut6JMV1lcXADFaybM1A3ZOJze6IHpDBKrf5S35czB
         vJrtdg/6OZz+JMNpQfLJ2fKJZgvFZvQFzlB9mf3BvL1W5i1dpYTJkQzeULLFWGSMToa7
         pklr8d41hKdFNPtEc9Q9RWtsDolbpuJwygY1oo6AlwlrXdrXRuwykp1CKcYtDWXI0+4f
         hOqQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 01/10] generic-phy: add generic_phy_get_by_node()
References: <20200330092732.7198-1-narmstrong@baylibre.com>
 <20200330092732.7198-2-narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <3980a842-2242-f033-0778-c62b59515f68@baylibre.com>
Date: Wed, 15 Apr 2020 18:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200330092732.7198-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: u-boot@lists.denx.de, marex@denx.de, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Tom, Marek,

On 30/03/2020 11:27, Neil Armstrong wrote:
> Add generic_phy_get_by_node() to get a PHY phandle from a node instead
> of a udevice.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/phy/phy-uclass.c | 17 ++++++++++++-----
>  include/generic-phy.h    | 27 +++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 5 deletions(-)


Are you ok with this change ?

Neil

> 
> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> index e201a90c8c..de2c3d2b8e 100644
> --- a/drivers/phy/phy-uclass.c
> +++ b/drivers/phy/phy-uclass.c
> @@ -31,20 +31,20 @@ static int generic_phy_xlate_offs_flags(struct phy *phy,
>  	return 0;
>  }
>  
> -int generic_phy_get_by_index(struct udevice *dev, int index,
> -			     struct phy *phy)
> +int generic_phy_get_by_node(ofnode node, int index, struct phy *phy)
>  {
>  	struct ofnode_phandle_args args;
>  	struct phy_ops *ops;
>  	struct udevice *phydev;
>  	int i, ret;
>  
> -	debug("%s(dev=%p, index=%d, phy=%p)\n", __func__, dev, index, phy);
> +	debug("%s(node=%s, index=%d, phy=%p)\n",
> +	      __func__, ofnode_get_name(node), index, phy);
>  
>  	assert(phy);
>  	phy->dev = NULL;
> -	ret = dev_read_phandle_with_args(dev, "phys", "#phy-cells", 0, index,
> -					 &args);
> +	ret = ofnode_parse_phandle_with_args(node, "phys", "#phy-cells", 0,
> +					     index, &args);
>  	if (ret) {
>  		debug("%s: dev_read_phandle_with_args failed: err=%d\n",
>  		      __func__, ret);
> @@ -88,6 +88,12 @@ int generic_phy_get_by_index(struct udevice *dev, int index,
>  
>  err:
>  	return ret;
> +}
> +
> +int generic_phy_get_by_index(struct udevice *dev, int index,
> +			     struct phy *phy)
> +{
> +	return generic_phy_get_by_node(dev_ofnode(dev), index, phy);
>  }
>  
>  int generic_phy_get_by_name(struct udevice *dev, const char *phy_name,
> diff --git a/include/generic-phy.h b/include/generic-phy.h
> index 95caf58341..5873ffb2e0 100644
> --- a/include/generic-phy.h
> +++ b/include/generic-phy.h
> @@ -193,6 +193,33 @@ int generic_phy_power_off(struct phy *phy);
>  int generic_phy_get_by_index(struct udevice *user, int index,
>  			     struct phy *phy);
>  
> +/**
> + * generic_phy_get_by_node() - Get a PHY device by integer index on ofnode
> + *
> + * @node:	the device node
> + * @index:	The index in the list of available PHYs
> + * @phy:	A pointer to the PHY port
> + *
> + * This looks up a PHY device for a client device based on its ofnode and on
> + * its position in the list of the possible PHYs.
> + *
> + * example:
> + * usb1: usb_otg_ss@xxx {
> + *       compatible = "xxx";
> + *       reg = <xxx>;
> + *   .
> + *   .
> + *   phys = <&usb2_phy>, <&usb3_phy>;
> + *   .
> + *   .
> + * };
> + * the USB2 phy can be accessed by passing index '0' and the USB3 phy can
> + * be accessed by passing index '1'
> + *
> + * @return 0 if OK, or a negative error code
> + */
> +int generic_phy_get_by_node(ofnode node, int index, struct phy *phy);
> +
>  /**
>   * generic_phy_get_by_name() - Get a PHY device by its name.
>   *
> 

