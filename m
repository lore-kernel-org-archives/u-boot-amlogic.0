Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.26789.1650871278456879128
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Apr 2022 00:21:19 -0700
Received: by mail-wm1-f45.google.com with SMTP id y21so8707171wmi.2
        for <u-boot-amlogic@groups.io>; Mon, 25 Apr 2022 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=WBISsVDMcgNvwDGc7n1t4HRZZHhQxykenp2V9mkqXDU=;
        b=Mlyyywcv1UbS3IWKbXJpajvVVHMytV2B28l36a0ft3jqpr6ILzC0VyZ3DnIBfof0PT
         598NANH80PWWeZTkNKCqfe4138f/CYeBnWYozkzD/gR0c1LllVFl+zxRULa4Xdqny8t6
         DLY59NdSGTOgT7BEbKmsMR25utgFxSmlgO+Fa0kKxZMB/+FZLxZBQwQ6Etmfn4XohyXp
         qLltDaYO/0QyNjaY7tAmQSg1ypzbAEcMN6/gQwpnfU2V523z6yYPPE5o3ag4KNxAPfsN
         tNOL0VK+46bY40amkxnMxJL4ZVKgKZ+2MUqaoptFUKtmf8O0Rv6hT2+5TEMkwNtGJA7O
         W8kw==
Return-Path: <narmstrong@baylibre.com>
Message-ID: <6b9cf5c4-20b4-92b5-c934-3c7c2402db47@baylibre.com>
Date: Mon, 25 Apr 2022 09:21:18 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/6] clk: meson: update driver for g12a-ao clocks
References: <20220424082159.757622-1-adeep@lexina.in>
 <20220424082159.757622-4-adeep@lexina.in>
From: "Neil Armstrong" <narmstrong@baylibre.com>
In-Reply-To: <20220424082159.757622-4-adeep@lexina.in>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Vyacheslav Bocharov <adeep@lexina.in>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

On 24/04/2022 10:21, Vyacheslav Bocharov wrote:
> Update g12a-ao clk driver:
> - move clk->id check to .request function
> - remove unnecessary check (gate->reg == 0)
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/clk/meson/g12a-ao.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
> index 17b11eb52a..1a855a6896 100644
> --- a/drivers/clk/meson/g12a-ao.c
> +++ b/drivers/clk/meson/g12a-ao.c
> @@ -28,14 +28,8 @@ static int meson_set_gate(struct clk *clk, bool on)
>   	struct meson_clk *priv = dev_get_priv(clk->dev);
>   	struct meson_gate *gate;
>   
> -	if (clk->id >= ARRAY_SIZE(gates))
> -		return -ENOENT;
> -
>   	gate = &gates[clk->id];
>   
> -	if (gate->reg == 0)
> -		return 0;
> -
>   	regmap_update_bits(priv->map, gate->reg,
>   			   BIT(gate->bit), on ? BIT(gate->bit) : 0);
>   
> @@ -63,9 +57,18 @@ static int meson_clk_probe(struct udevice *dev)
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
