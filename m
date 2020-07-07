Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.web11.19247.1594136794907800263
 for <u-boot-amlogic@groups.io>;
 Tue, 07 Jul 2020 08:46:35 -0700
Received: by mail-wr1-f68.google.com with SMTP id r12so45624392wrj.13
        for <u-boot-amlogic@groups.io>; Tue, 07 Jul 2020 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=qXnUwNbIlu+I0n4z/AJi3VJlT4mXZvOjmmKhQ/YmJvI=;
        b=nNnXfCYb2mtK/3FitETgW/ApbGDZWfHvfvxDV4LlnkIavSgRAwTwF9Ln49RCP1Vgb3
         D0b5sNwkUodJn0QZXV6RjSqOT2ZD+w16s5PH1OM+8uzrEt0aGnBY0zcQscCAGlYuL4Pv
         7SBRbugcZnc1iv9YeWqTS7tzpFiONA/SbXupSMs+GAMsDRmUm3Zj3YCAJkHVrRsIY86F
         pn5aQsxbjxcev/lDYAr9tvYT6uTzYuwXTnLd6liiCKwOubOn7xhPo5GFngK6MgMVWdN9
         W2njd5j/uxoITThq8EZYrkv0F9iY8gd52Q7gRioYarvQWELhAk3Lkr00dOz8BImZ6fjY
         fCjw==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 7/7] arm: meson: change trace level for phy errors managed by uclass
References: <20200703153646.28533-1-patrick.delaunay@st.com>
 <20200703153646.28533-8-patrick.delaunay@st.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <fec15eb5-3385-a763-bd2b-c64dd17d9bc6@baylibre.com>
Date: Tue, 7 Jul 2020 17:46:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200703153646.28533-8-patrick.delaunay@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Patrick Delaunay <patrick.delaunay@st.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
List-ID: <u-boot-amlogic@groups.io>

Hi,

Le 03/07/2020 =E0 17:36, Patrick Delaunay a =E9crit :
> As the error message is now displayed by generic phy functions,
> the pr_err can be change to pr_debug.
>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@st.com>
> ---
>=20
> Changes in v3:
> - add update for mach-meson board-gx: new generic_phy API usage
>=20
>  arch/arm/mach-meson/board-gx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-g=
x.c
> index c4cc11f1de..b4fde46fcb 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -196,8 +196,8 @@ int board_usb_init(int index, enum usb_init_type init)
>  	for (i =3D 0; i < 2; i++) {
>  		ret =3D generic_phy_init(&usb_phys[i]);
>  		if (ret) {
> -			pr_err("Can't init USB PHY%d for %s\n",
> -			       i, ofnode_get_name(dwc2_node));
> +			pr_debug("Can't init USB PHY%d for %s\n",
> +				 i, ofnode_get_name(dwc2_node));
>  			return ret;
>  		}
>  	}
> @@ -205,8 +205,8 @@ int board_usb_init(int index, enum usb_init_type init)
>  	for (i =3D 0; i < 2; i++) {
>  		ret =3D generic_phy_power_on(&usb_phys[i]);
>  		if (ret) {
> -			pr_err("Can't power USB PHY%d for %s\n",
> -			       i, ofnode_get_name(dwc2_node));
> +			pr_debug("Can't power USB PHY%d for %s\n",
> +				 i, ofnode_get_name(dwc2_node));
>  			return ret;
>  		}
>  	}
>=20

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
