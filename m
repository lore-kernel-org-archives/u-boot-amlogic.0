Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B6FC72D2
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 07:41:04 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15341.1774019729906802008
 for <u-boot-amlogic@groups.io>;
 Fri, 20 Mar 2026 08:15:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Sfq+XnO2;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc1aced74so105562985a.2
        for <u-boot-amlogic@groups.io>; Fri, 20 Mar 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1774019729; x=1774624529; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vypP5FMiNTVA6057pEyRk0YVHq+tlwl/GSTFrXkkB30=;
        b=Sfq+XnO2a2aWjtqrdP1dBOYMJxNmhgBupdfawLBZnICjJku4311myXBh1iRG4K98OJ
         mYi4WVl8bt0S82wS+LGX2iZRwm5PgMh9n4k+l79qKBg1mPxq1Bx0RVmip9IXcrf5H5MH
         ON4IPc841nWmo/ze7+BRQk1DKlfIfR8R/f1ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019729; x=1774624529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vypP5FMiNTVA6057pEyRk0YVHq+tlwl/GSTFrXkkB30=;
        b=hzYWLLRcNbHcXDbLPT9ygRH+XKcweXklp5rn1lLOHP7HGbLB6M2wIxzydFMU2EZud/
         2gsbfDh1QA1hVnR1GVwg2mK0LEuInGtKSZ1vXhzCIfnnWnomeHQOwEJuIN4S1y4kfqn1
         5aGW3gWQyD1vzMCqt0haQ8J9n8XPiWW2iAP7E3V7HR6tLPz7jnLzkhLGjoJY0hcfl28s
         asgGNhTqRW+WiBVlOkIjpiDlb5X25b9YxHfLWzropHxVvmke3cjym7xfUErz/M9z44Sp
         3aU7+UDVe4iqgKxb0gpI06XOe9h3fBEefAZpDNiqwEAc1i7689TkqD6q395n2jl94YTB
         tXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUDP8CiuA20lzr3QDI9i7DnnQvkJqfqPPwNfMVNj4tJ/0b4i9ImfuK7NQBt2DBCJvTcooSMXjfQfRwcXLxPyg==@groups.io
X-Gm-Message-State: AOJu0YyELMF0RzjHW9VyBWbPb24lvyxf/3kuDsvuHtAYCg38l62lmX8X
	GeBpHAU2kQzCyG+Sm8R6AF7Jsw9V5wWb5qgtUMTm/WTZ4NXQL7DHphQflPMn8GukttUvi9LxxKy
	z2LWh9I0=
X-Gm-Gg: ATEYQzzOR1lRMDrXnAtc0pBVryTUDl7df6bfPwu+geuKRoP6azBPbmjl1QrFSMs3Q51
	XKWyqbfkbnI01JKAlhZQw8IKBSYatC5o3yNJy+T6XcAPHVQx+NXbhx6ViYgWLEjYlEtRpQNnMfQ
	ECLuQNyBIIUaGhfwA1KzJ6SI+EYJACJ5ClRJG0kkYEDmefaWJqmBdRjN4UdiURPUJE3qaOEpTal
	jzq59T2PJOtW1tLKZeDcwDbZBG8J4C26+nOdv1UJ6bRmwi4TFDX/D1UWtikeqDG+XX7wY9K/WzX
	1PSAKV66xGcNG1VdvoZG/49I2cq1rFLggvHJ8SkoquGifrOTqYGvU1iq2OBCulRGA9BuLlOaCdx
	dIvxKiy+2Ee/Y3i/AIq9nwY/N65+rcJit25hHmWhhQ8Cfm+5LSUi6DJPHA+/FnKrzfbqxI2/OT4
	Fakdy3cKg9eDgmiByPwIqKcwlOPNFDvpA8TtroPv8PtKmIuw2Gk4t9kbJhXrtrD4GV5AYaTicnZ
	VNG2rYChZdkQAPi2+EGYwtMRhCD4tZxCd17qqW/ElpUjZTs
X-Received: by 2002:a05:6820:62a:b0:67b:f4a3:b796 with SMTP id 006d021491bc7-67c22f958e7mr2136599eaf.55.1774019370694;
        Fri, 20 Mar 2026 08:09:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net. [189.203.97.235])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c251a58dfsm1277241eaf.0.2026.03.20.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:09:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:09:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
	Lukasz Majewski <lukma@denx.de>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
	Paul Barker <paul@pbarker.dev>,
	Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
	uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com,
	Sumit Garg <sumit.garg@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andrew Goodbody <andrew.goodbody@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Glass <sjg@chromium.org>,
	Paul Sajna <sajattack@postmarketos.org>,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 15/40] clk: restrict clk/imx to MACH_IMX
Message-ID: <20260320150927.GB502704@bill-the-cat>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
 <tc612f.1958x6s93grqj@postmarketos.org>
MIME-Version: 1.0
In-Reply-To: <tc612f.1958x6s93grqj@postmarketos.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=4FdcDjTdklHzaoQstA1h"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 23 Mar 2026 07:41:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2934

--Groupsio=4FdcDjTdklHzaoQstA1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 09:25:14PM +0000, Ferass El Hafidi wrote:
> On Thu, 19 Mar 2026 20:56, "Casey Connolly via groups.io" <casey.connolly=
=3Dlinaro.org@groups.io> wrote:
> > Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
> > drivers get compiled for all platforms with CLK_CCF enabled.
> >=20
> > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > ---
> > drivers/clk/Makefile | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 5f0c0d8a5c28..f96d57a3223a 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) +=3D clk-stub.o
> >=20
> > obj-y +=3D adi/
> > obj-y +=3D airoha/
> > obj-y +=3D analogbits/
> > -obj-y +=3D imx/
> > +obj-$(CONFIG_$(PHASE_)MACH_IMX) +=3D imx/
>=20
> I think this is not necessary. drivers/clk/imx/Makefile already requires
> that imx config options be enabled for the driver to be compiled in.

Almost all of them do. I see:
$ rg obj.*CLK_CCF drivers/clk/
drivers/clk/Makefile
10:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk.o clk-divider.o clk-mux.o clk-ga=
te.o
11:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-fixed-factor.o
61:obj-$(CONFIG_SANDBOX_CLK_CCF) +=3D clk_sandbox_ccf.o

drivers/clk/exynos/Makefile
10:obj-$(CONFIG_$(PHASE_)CLK_CCF)       +=3D clk.o clk-pll.o

drivers/clk/imx/Makefile
5:obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-gate2.o clk-pllv3.o clk-pfd.o

But exynos is guarded by CONFIG_CLK_EXYNOS to start with. So I think
this is right, and also something that could just be standalone and
picked up shortly as it's a build cleanup.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Groupsio=4FdcDjTdklHzaoQstA1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCab1jIwAKCRAr4qD1Cr/k
CjdCAQCgnFWFQ/O1pXOo/rj9vi9RzSILtD9BX3tunzOiyXst+QEA9c8UGn0xwevE
3kHJZ86ibblj5T9B/MJ/PecPqlx1Jgo=
=GY9m
-----END PGP SIGNATURE-----

--Groupsio=4FdcDjTdklHzaoQstA1h--

