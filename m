Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EE1091928
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 21:30:39 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7009.1773955829521819020
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:30:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=ZIzfDroT;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.179, mailfrom: funderscore@postmarketos.org)
Date: Thu, 19 Mar 2026 21:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1773955825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8gsU8+14tCdDaf1sLrt3CPQIm6pFdSHpcqyO8iv77JI=;
	b=ZIzfDroT7vwNskZzudrKJWgnD34kUGUDK44RZFkmSeVhVU5hPfjfF8tNBixOVcOgwMnzHU
	ogX1fGKuObRmZHjchIRGM50Tc9xfgGd0fI+T71QrbrWfJd3u6MzI0P5B34DmvEWi4aejLH
	DMk8hh3JOb+Jzs0IoCn9lYHq7ox//fOJPX6lQMuxOK9zjef00yCNz48M8nyBsQcNWCmiMP
	5yFN7ZynxzqK7sNDdclrqjizQWrBHrPwBonKYn7kzKeUkdjIENa6BKS/C5c9CBiRVMfgNc
	m0n1o1fv+nY4UyrUQ7gti7aDdo605jIi7ZjBtqV1W+9NbeLDh5mac2bgY+gCDg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, Stephen Boyd <swboyd@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 15/40] clk: restrict clk/imx to MACH_IMX
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org> <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
Message-ID: <tc612f.1958x6s93grqj@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 21:30:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2922

On Thu, 19 Mar 2026 20:56, "Casey Connolly via groups.io" <casey.connolly=
=3Dlinaro.org@groups.io> wrote:
>Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
>drivers get compiled for all platforms with CLK_CCF enabled.
>
>Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>---
> drivers/clk/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>index 5f0c0d8a5c28..f96d57a3223a 100644
>--- a/drivers/clk/Makefile
>+++ b/drivers/clk/Makefile
>@@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) +=3D clk-stub.o
>=20
> obj-y +=3D adi/
> obj-y +=3D airoha/
> obj-y +=3D analogbits/
>-obj-y +=3D imx/
>+obj-$(CONFIG_$(PHASE_)MACH_IMX) +=3D imx/

I think this is not necessary. drivers/clk/imx/Makefile already requires
that imx config options be enabled for the driver to be compiled in.

Best regards,
Ferass

[PS: had to remove a few people from CC, because my email provider does
     not let me CC that many people, sorry!]

> obj-$(CONFIG_CLK_JH7110) +=3D starfive/
> obj-y +=3D tegra/
> obj-y +=3D ti/
> obj-$(CONFIG_CLK_THEAD) +=3D thead/
>
>--=20
>2.51.0
>
>
>
>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>Groups.io Links: You receive all messages sent to this group.
>View/Reply Online (#2906): https://groups.io/g/u-boot-qcom/message/2906
>Mute This Topic: https://groups.io/mt/118408050/8399868
>Group Owner: u-boot-qcom+owner@groups.io
>Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13198341/8399868/7974=
98721/xyzzy [funderscore@postmarketos.org]
>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

