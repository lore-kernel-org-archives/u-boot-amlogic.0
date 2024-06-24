Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE512C30658
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:20:48 +0000 (UTC)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 by mx.groups.io with SMTP id smtpd.web10.136213.1719220507589708811
 for <u-boot-amlogic@groups.io>;
 Mon, 24 Jun 2024 02:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thorsis.com header.s=dkim header.b=R1FjBuPS;
 spf=pass (domain: thorsis.com, ip: 217.92.40.78, mailfrom: ada@thorsis.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE8EA14835CC;
	Mon, 24 Jun 2024 11:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1719220504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4G52iIyOvuB3NMQrMFve1s34aRyuySDoK/eLdGw14Jc=;
	b=R1FjBuPSBlVtq12MISS85CiT8AU0EQOxZad+xOZx9m9+YJkjcqQEgwu8KOqUbYK39y0RiY
	rrxlKS864rhReTQ+zRoiXcxApjgS84bbFuvnkSU6rN3qna/R0rszK4R6YlfONJGfWa2U2E
	if/msrG31/PcYIH07HGNoYM9CsOFTpHrId1kdaHyt23lRB6BV+L32wyk+M+HDbcPTuKChk
	6yCB8Rq6OCJuviWEvLafSgFjot8+hIxJnBW1Td9s0fmvYXVx4ve/dlNbsDLl5Fehb+ZOGr
	cbaY9GD9Hi2dmbvJaauuFhxy6XUClVQxbnau6CxGWhi8M6LL3kFnCWp+30aJnw==
Date: Mon, 24 Jun 2024 11:14:55 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
Message-ID: <20240624-preacher-sharpness-b33541d3302d@thorsis.com>
Mail-Followup-To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	kernel@sberdevices.ru, oxffffaa@gmail.com
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20240602200836.3949773-2-avkrasnov@salutedevices.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 25 Jun 2024 13:20:48 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2326

Hello Arseniy,

Am Sun, Jun 02, 2024 at 11:08:34PM +0300 schrieb Arseniy Krasnov:
> Based on Linux kernel:
> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")
> 
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  include/linux/mtd/rawnand.h      | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c40a0f23d7..ed605b4af5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>  	if (ret == 16)
>  		chip->options |= NAND_BUSWIDTH_16;
>  
> +	if (ofnode_read_bool(node, "nand-is-boot-medium"))
> +		chip->options |= NAND_IS_BOOT_MEDIUM;
> +
>  	if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae641..4eb880d8fb 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -218,6 +218,12 @@ enum nand_ecc_algo {
>  /* Device needs 3rd row address cycle */
>  #define NAND_ROW_ADDR_3		0x00004000
>  
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this information
> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
> + */
> +#define NAND_IS_BOOT_MEDIUM	0x00400000
> +
>  /* Options valid for Samsung large page devices */
>  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG

The entries in that file are ordered numerically.  Comparing with the
same file in Linux this should go before NAND_KEEP_TIMINGS, not
anywhere in between.  Makes later diffs and ports from Linux easier.

Greets
Alex

>  
> -- 
> 2.35.0
> 

