Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web09.6067.1581928960263651861
 for <u-boot-amlogic@groups.io>;
 Mon, 17 Feb 2020 00:42:41 -0800
Received: by mail-wr1-f67.google.com with SMTP id m16so18517955wrx.11
        for <u-boot-amlogic@groups.io>; Mon, 17 Feb 2020 00:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oy1el1euawnFqzeH6d6pex4StE/Kd+NbpBsEEPWMbt4=;
        b=rROuIvk7e2LcMywHiPID9CZCMU2IB30ECSbiuoisgGaiXjrAyqgraB/tN5cdRIfH4B
         FVtg1MqilDmtJ4IC/Oj0H5woC79TyZOP7r0xVnOcylSs9ZYK6C0rr1yb0X0w5xGuuTAJ
         XTsO6/LfIzPhZXPGiAIEokQyoWjngoEw3L/3LR0RVJHReBnYQGSQBJIqQR69hHRAg8eB
         /yVzjpe9XJGVAsMi3d8MIWBvOCwdCWDqxRv84rjfx71guNM+QVdnDEtvk6yNn16OPNFe
         cdP837e2aDpGPrTNY/elAq5EwqyiM+kiQlUQzhjCSS3IybM4o9f/OoREGgDTKgRpq9iD
         y+Qg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/1] clk: meson-g12a: missing break
References: <20200215201054.5139-1-xypron.glpk@gmx.de>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <85b8f2b9-7a3d-c644-d496-b1c3c7a645c7@baylibre.com>
Date: Mon, 17 Feb 2020 09:42:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200215201054.5139-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

On 15/02/2020 21:10, Heinrich Schuchardt wrote:
> Add missing break for CLKID_PCIE_PLL in switch statement.
> 
> Reported by CppCheck.
> 
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Fixes: 08e09c263fdf ("clk: meson-g12a: Add PCIE PLL support")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> Looking at the code it seems obvious that something is wrong in commit
> 08e09c263fdf but I have no board for testing.
> ---
> 
>  drivers/clk/meson/g12a.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 686d94ebfe..cada80e6b5 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -804,6 +804,7 @@ static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id)
>  		break;
>  	case CLKID_PCIE_PLL:
>  		rate = meson_pcie_pll_get_rate(clk);
> +		break;
>  	case CLKID_VPU_0:
>  		rate = meson_div_get_rate(clk, CLKID_VPU_0_DIV);
>  		break;
> --
> 2.25.0
> 

Thanks,
Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to u-boot-amlogic

Neil
