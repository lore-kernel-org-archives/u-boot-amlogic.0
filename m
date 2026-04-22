Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE15FA1FCB
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 15:54:43 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86114.1776873281858806942
 for <u-boot-amlogic@groups.io>;
 Wed, 22 Apr 2026 08:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=sNbNpsbL;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.176, mailfrom: funderscore@postmarketos.org)
Date: Wed, 22 Apr 2026 15:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1776873279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSvV/YsZs8s+uc/E5MAN/mtwGsBehxds7qAIBdhZKyc=;
	b=sNbNpsbLDh2zVta8mbBu7HZZaFd5stYmEJ2xhiW1ryrnv92OP0iRKMJ7NRe08II7xGibcQ
	kUPMLCHbKO1T7oKcsxWm/+jgEZCosyMR8GWjZQYaUOpjfh/gCE14U17pBtWpexKlzcukop
	bWuNKJsKdCI1P5veF63naSF7N0pVsR+EJDLhDZqj7/IrjKnrv1l4ddKifqhSqjL/A1g1OF
	DD3iQtA1GaP2Jmd0seFHp/98VIZLriTJC5/lTUd39IouXCfBSDCyxqvXBJMZtV3z3+PYXZ
	UrmnFb8/9aWYT++vAg8C1FDsdRo5Udcy0ZboANYP61u7kFOZimaVsij1+7DobA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, Peter Robinson <pbrobinson@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>, Ferass El Hafidi <funderscore@postmarketos.org>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] clk: meson: do not fail when setting SD_EMMC_x_CLK0
References: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
In-Reply-To: <20260422-u-boot-amlogic-test-v1-1-b5790d3c04e0@linaro.org>
Message-ID: <tdwk56.2ups5wleej3c0@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 22 Apr 2026 15:54:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2978

Hi Neil,

On Wed, 22 Apr 2026 08:48, Neil Armstrong <neil.armstrong@linaro.org> wro=
te:
>Since Linux v7.0, the MMC controllers has the following properties:
>  assigned-clocks =3D <&clkc CLKID_SD_EMMC_x_CLK0>;
>  assigned-clock-rates =3D <24000000>;
>Which causes mmc controllers to fail in probe.
>
>Make sure we do not fail until we properly implement rate setup.
>
>Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>---

This works on my board, thank you! Here's my:

Tested-by: Ferass El Hafidi <funderscore@postmarketos.org> # on lepotato

> drivers/clk/meson/g12a.c | 5 +++++
> drivers/clk/meson/gxbb.c | 5 +++++
> 2 files changed, 10 insertions(+)
>
>diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>index a7a42b2edb6..f33938e1419 100644
>--- a/drivers/clk/meson/g12a.c
>+++ b/drivers/clk/meson/g12a.c
>@@ -946,6 +946,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *c=
lk, unsigned long id,
> 	case CLKID_HDMI:
> 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
> 						rate, current_rate);
>+	case CLKID_SD_EMMC_A_CLK0:
>+	case CLKID_SD_EMMC_B_CLK0:
>+	case CLKID_SD_EMMC_C_CLK0:
>+		/* TOFIX: implement rate set for MMC clocks */
>+		return 0;
> 	default:
> 		return -ENOENT;
> 	}
>diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>index 218be45c2cb..bf46f4d50bc 100644
>--- a/drivers/clk/meson/gxbb.c
>+++ b/drivers/clk/meson/gxbb.c
>@@ -900,6 +900,11 @@ static ulong meson_clk_set_rate_by_id(struct clk *c=
lk, unsigned long id,
> 	case CLKID_HDMI:
> 		return meson_clk_set_rate_by_id(clk, CLKID_HDMI_DIV,
> 						rate, current_rate);
>+	case CLKID_SD_EMMC_A_CLK0:
>+	case CLKID_SD_EMMC_B_CLK0:
>+	case CLKID_SD_EMMC_C_CLK0:
>+		/* TOFIX: implement rate set for MMC clocks */
>+		return 0;
> 	default:
> 		return -ENOENT;
> 	}
>
>---
>base-commit: 052988aa29bfd506d7ce207fbb3f5374a5dbecbb
>change-id: 20260422-u-boot-amlogic-test-6bd61f679c90
>
>Best regards,
>-- =20
>Neil Armstrong <neil.armstrong@linaro.org>
>

--
Best regards,
Ferass

