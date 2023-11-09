Return-Path: <adeep@lexina.in>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C6C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 13:50:15 +0000 (UTC)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 by mx.groups.io with SMTP id smtpd.web11.121780.1699537805915947446
 for <u-boot-amlogic@groups.io>;
 Thu, 09 Nov 2023 05:50:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lexina.in header.s=dkim header.b=YFKn0Z9a;
 spf=pass (domain: lexina.in, ip: 62.182.159.68, mailfrom: adeep@lexina.in)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05F55152533;
	Thu,  9 Nov 2023 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1699537802; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8Z3bKFTFI9DvnKZS+aizOzy3+ePZo/b1/2lImY/Gnd0=;
	b=YFKn0Z9aifbhFmBsGUBeiSsDo+Ing2Aq/0Efk7f2GKI3Hf/wptGwnt58lyEiHrWv1QryPd
	V/dR7MoA9d7u6lcnJ/SOHfxY+UfJRyYDpQFX0gsKzqYoLTl2ZJINNl31iHhoLI7+3f8LDS
	+dCHSMfHUbaDjrDbhv9MSLVzD8MqBujVCai6e83Pqxgbx5AZgoS60Aw8f+JqkM07UotQnd
	kNRXwUHVbxgWHYwdxy8OEZE2rT2Tu43218TBGrrA0LLBZqrrIoI+VwoJ7BwFlaw03nWjE3
	dHOmGPAM/RwtgwJptfHwS62GiHH1cw784YRk7ho3PUPJt/H8JMo/hmQuzi6KjA==
Message-ID: <c89408dd98f78aace3f04c3fdba5702b3045a743.camel@lexina.in>
Subject: Re: [RFT PATCH 2/2] mmc: meson-gx: set 270 core phase during the
 identification
From: Viacheslav <adeep@lexina.in>
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
	 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
	 <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Date: Thu, 09 Nov 2023 16:49:59 +0300
In-Reply-To: <20230915160130.352099-3-jbrunet@baylibre.com>
References: <20230915160130.352099-1-jbrunet@baylibre.com>
	 <20230915160130.352099-3-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 09 Nov 2023 13:50:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1855

After running some tests, I've noticed inconsistent behavior with the eMMC:
 On a cold boot (following a shutdown), the eMMC operates as expected withi=
n U-Boot.
 On a hot reboot (via the kernel's reboot command), the eMMC sometimes (not=
 always, but if
fit in error, next need to do poweroff) does not work:
    U-Boot is able to read the dtb file but won't boot kernel completely, o=
r
    U-Boot might fail to read from the eMMC altogether.

This behavior had not occurred before (when the phase was set to 270 on axg=
).

On Fri, 2023-09-15 at 18:01 +0200, Jerome Brunet wrote:
> It has been reported that some devices have problems with a 180 degree
> core phase. Setting 270 helped some of these devices. Other continue to
> struggle (while it works fine with 180 in Linux ... :sigh:)
>=20
> Poking around the HW, it seems that setting a 270 core phase during the
> identification, then using 180 for the rest of the operations, helps the
> device operate correctly.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/mmc/meson_gx_mmc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index c6168792cbae..284be2b9dca4 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -54,9 +54,14 @@ static void meson_mmc_config_clock(struct mmc *mmc)
> =20
>  	/* Clk always on */
>  	meson_mmc_clk |=3D pdata->version->clk_always_on;
> -	meson_mmc_clk |=3D CLK_CO_PHASE_180;
>  	meson_mmc_clk |=3D CLK_TX_PHASE_000;
> =20
> +	/* Core phase according to mode */
> +	if (mmc->selected_mode =3D=3D MMC_LEGACY)
> +		meson_mmc_clk |=3D CLK_CO_PHASE_270;
> +	else
> +		meson_mmc_clk |=3D CLK_CO_PHASE_180;
> +
>  	/* 1GHz / CLK_MAX_DIV =3D 15,9 MHz */
>  	if (mmc->clock > 16000000) {
>  		clk =3D SD_EMMC_CLKSRC_DIV2;


