Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37C1091927
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 21:33:59 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7082.1773956037397551990
 for <u-boot-amlogic@groups.io>;
 Thu, 19 Mar 2026 14:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@postmarketos.org header.s=key1 header.b=gQxKCp57;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.185, mailfrom: funderscore@postmarketos.org)
Date: Thu, 19 Mar 2026 21:30:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1773956034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8NIwjUKQtcXq7NUx5Qtp+sx2LMNQUWDJhkj54mLwEs=;
	b=gQxKCp570z5fbGqqoURMKniXq072iFXWEko+AaI39lGN6nWFL8Us27mIhcxEYiX9H/te1r
	Q0VHtliF3re0R95h/gFPO3y08x5dnEHZLA//tgh80jzUrfBjGDJ8rf6QQX/UCa4xfvYX5W
	ykzRyWXEaKBdCYuixNcVFiqDyZovLRtLFp350+GRvGxIQX8feFDXEqOa3rRL13PyG3upoZ
	lkbA2PpOkuW7RoPM7QYcv4UW40YVbVLd1BhF6u++Uo60V0hbgQ2qGCMw/blQUlPL0p8xgw
	2SGc/Ls8mDjWs82I54j2nVFMbpEzPtYl5tuPaIl6WNKhDTFgalri5RkfQUQ89g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, Stephen Boyd <swboyd@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Michal Simek <michal.simek@amd.com>, Manikandan Muralidharan <manikandan.m@microchip.com>, Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, David Wronek <david.wronek@mainlining.org>, Naman Trivedi <naman.trivedimanojbhai@amd.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Conor Dooley <conor.dooley@microchip.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, Varadarajan 
 Narayanan <quic_varada@quicinc.com>, Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to U-Boot
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
Message-ID: <tc6181.3ppuo0c75vwxp@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 19 Mar 2026 21:33:59 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2923

Hi,

On Thu, 19 Mar 2026 20:56, "Casey Connolly via groups.io" <casey.connolly=
=3Dlinaro.org@groups.io> wrote:

>    This RFC provides a proof of concept for using the full Linux CCF in
>    U-Boot and consequently porting full Linux clock drivers with extrem=
ely
>    minimal changes.
>
>    [...]
>
>    =3D=3D=3D Memory/perf overhead =3D=3D=3D
>
>    The memory and size overhead of CCF is undoubtably bigger than uCCF,
>    although I suspect the difference is less than it might seem at
>    first glance. In particular: clk_core is only ~50 bytes larger than
>    struct udevice on ARM64, and an additional 120 bytes is saved for ea=
ch
>    U_BOOT_DRIVER used by uCCF.
>
>    On the other hand, the CPU overhead is probably more significant,
>    but not an unreasonable cost to ensure correctness and propagate rat=
e
>    changes across the clock tree.
>
>    Just comparing the binary size of sandbox64_defconfig with uCCF vs
>    CCF_FULL, CCF_FULL results in a 135k size increase in the binary. I
>    haven't done any more detailed analysis here (still haven't got buil=
dman
>    to play nice...).
>
>    =3D=3D=3D SPL =3D=3D=3D
>
>    This RFC doesn't have any SPL specific support, I think this role is
>    better fulfilled by UCLASS_CLK.

It is worth noting that not a lot of boards actually use the existing
CCF port under SPL.

	configs$ git grep "CONFIG_SPL=3Dy" | wc -l
	550
	configs$ git grep "CONFIG_SPL_CLK=3Dy" | wc -l
	179
	configs$ git grep "CONFIG_SPL_CLK_CCF=3Dy" | wc -l
	25

As far as I know, this is most likely because that existing CCF is
already quite huge for such a small environment like SPL (SPL_CLK is
already quite big, especially with its dependency on driver model, which
is fine but some devices are so restricted when SPL runs that even
DM is too big to fit). So I wouldn't bother trying to support SPL with
this.

Just wanted to share this, FYI.

Best regards,
Ferass

[PS: had to remove some people from CC, because my email provider does
     not let me CC that many people. Also sorry for those who got this
     email twice]

