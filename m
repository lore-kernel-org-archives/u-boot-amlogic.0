Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4953CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:20:34 +0000 (UTC)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
 by mx.groups.io with SMTP id smtpd.web11.12278.1759918832263263768
 for <u-boot-amlogic@groups.io>;
 Wed, 08 Oct 2025 03:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=JziB8VzP;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.170, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759918829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Fio1GgnLxb0NG5p2wh5X335/fapAEjK4PmSquGCdOs=;
	b=JziB8VzP6BRHEkl1HBltdQ83w925pBJ/HkoiswBATVbjMtuR/+AoOiS7SKcMrA05gpPLPd
	nkStXp7KqqfzngGv0ZlkIo1uBYqttztavFEFwnzGNvCnrTRnLMerCx6pBtOXnfStVQGQ/7
	ebKvqtKmNnDPKU9RhI+Y88FDsWjA5xwtShVPQ8kceZ6rNGJBPKh8OarfIsD3sckuy/xbHs
	ZRr11fttNxOcMTQTL4FnSxqF7x1WuEkDh011YUC00kpihnvek4cYnVCWPJiqqMDpxDZtXE
	sGBzuYu11ZfBgW1mbWTO5AvI8Fe+h3sW9YMc4DXGx7RmhEYNv21adWxfgQWDqQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Oct 2025 10:20:27 +0000
Message-Id: <DDCV5NS2JCXR.2M8NRPUEZWC62@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>,
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH RFC 0/9] initial U-Boot SPL support on Amlogic GX SoCs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Ferass El Hafidi" <funderscore@postmarketos.org>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng
 Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 08 Oct 2025 10:20:34 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2798

On Sun Sep 7, 2025 at 2:36 PM UTC, Ferass El Hafidi wrote:
> This RFC/RFT patch series adds support for U-Boot SPL booting on Amlogic
> GX SoCs, replacing the historical "bl2.bin" binary that runs as BL2 on
> these boards.
>
> Boards tested:
>  - Libre Computer LaFrite (S805X, 512 MB)
>  - Libre Computer LePotato (S905X, 1 GB)
>  - Videostrong KII Pro (S905)
>  - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
>  - (ODROID-C2 (S905) - at some point early in development)
>
> Each of these boards were tested booting mainline u-boot and TF-A BL31,
> either from an SD card or using Ymodem, and then booting to Linux.
>
> More testing is, of course, very much welcome.  In particular, further
> testing of other boards that could not be tested, of the ODROID-C2, and
> of the 2 GB LePotato would be appreciated.
>
> Currently known issues:
>  - LPDDR2/LPDDR3 support not implemented
>  - some DRAM rank modes are not supported
>  - eMMC booting is broken (pwrseq?)
>  - SPI boot is untested
>  - we are quite limited in space, so e.g. the clock driver does not fit
>    (TPL might be considered in the future)
>
> See doc/board/amlogic/spl.rst for building and installation instructions.
>
> This patch series depends on Jonas Karlman's amlimage work, which was
> sent in the mailing list [2].  It has been rebased for resending as part=
=20
> of this patch series.  Thanks Jonas!
>
> I would like to also thank Libre Computer and MNT Research for donating
> boards to me and the rest of the linux-amlogic community for the
> invaluable help.
>
> [1]: https://scm.dersco.re/amlogic/u-boot-kii-pro.git/commit/?h=3Dwip/spl=
-aquaman-2025.08&id=3Dd030951d0aaac04f1e2cc8a8eb01eb662a782f21
> [2]: https://lore.kernel.org/all/20250103215904.2590769-1-jonas@kwiboo.se=
/
>

Hi all,
Thank you for all your feedback, I sent a v3 that hopefully addresses
them all:

	https://lore.kernel.org/u-boot-amlogic/20251008-spl-gx-v3-0-5999637df4b9@p=
ostmarketos.org/T/#t

Cheers!

