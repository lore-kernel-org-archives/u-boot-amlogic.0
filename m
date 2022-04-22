Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.8443.1650633974091852919
 for <u-boot-amlogic@groups.io>;
 Fri, 22 Apr 2022 06:26:14 -0700
Received: by mail-wr1-f42.google.com with SMTP id q7so3426900wrm.5
        for <u-boot-amlogic@groups.io>; Fri, 22 Apr 2022 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=drF/6tODiNRE4qTqoXauMIHsHYdNVg1XQhVb/c8xdH8=;
        b=MCaM7/KkMElOvAGP2V0nwFINnSVj6jM/ubf/gBfvjFyU+9YZtIt0HMlD+5jky37zGb
         7KjvTy+kOIAgt1wo7d3M+TO7KE+v7YSJHf10beB4yPk28zPS0VM1wirLAq4plaUUfw4q
         +hronGLwuJO+ZsKgnAdGpP/YZu6P3D6btbYc5GCUe7EYkY7bxe2+w3DRBeZ+r6/fqvMO
         Mw3mVl6MMqmhLRHvnePbk5/CmAFpBXPL3m8quX/Ub3PQxDgFO7VHosVcBxwP7U36xjar
         nb8BGyPGyVmzZFVowesYpkg7l6vM3bBe4xCe9XGmvjvqZbtB5w5SinhKymBw4GSctqwS
         xTMw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <e02c72f3-b65f-7654-5fe5-1e33220ae307@baylibre.com>
Date: Fri, 22 Apr 2022 15:26:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/6] clk: meson: update driver for g12a-ao clocks
References: <20220422052914.1836694-1-adeep@lexina.in>
 <20220422052914.1836694-4-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220422052914.1836694-4-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 22/04/2022 07:29, Vyacheslav Bocharov wrote:
> Move clk->id check to .request function
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/clk/meson/g12a-ao.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 17b11eb52a..22c85cff1d 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -28,9 +28,6 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	struct meson_gate *gate;
>   
> -	if (clk->id >= ARRAY_SIZE(gates))
> -		return -ENOENT;
> -
>   	gate = &gates[clk->id];
>   
>   	if (gate->reg == 0)
> @@ -63,9 +60,18 @@ static int meson_clk_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int meson_clk_request(struct clk *clk)
> +{
> +	if (clk->id >= ARRAY_SIZE(gates))
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
>   static struct clk_ops meson_clk_ops = {
>   	.disable	= meson_clk_disable,
>   	.enable		= meson_clk_enable,
> +	.request	= meson_clk_request,
>   };
>   
>   static const struct udevice_id meson_clk_ids[] = {

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
