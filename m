Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983D8CCFA16
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:41 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web11.15310.1727268496259786733
 for <u-boot-amlogic@groups.io>;
 Wed, 25 Sep 2024 05:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=LUv051IG;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0DA9F88363;
	Wed, 25 Sep 2024 14:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727268494;
	bh=YyPyGijE2wAEVvrrSqSVu98U/0LY+Z3cFTaHvNKWdcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LUv051IGbnRJBQh6Q3iv9zLndq1JNMQAO0bkLYz+7YjzScBWyK9LbxsrBvjNdYmTJ
	 DWxAg++LnqOgGqv8SaZvjviBqVRajPJbhikdIzvvpG95LR4OFPGcqhHBE06tjVV1jN
	 43+rVjnCortkwvd9IihGLK0Xdbidrr3cl1byTFJlb2ZCI1zm8qqpYq3iXPBtZI5NRe
	 IsO8HmwXGCdajqSFq02voogYXbVPxgmaI+C8zgrx+C8vOkg+GaTsqbrRESSlcdHQDM
	 6B6EEAlBEt0PAV2tOsL8N2y1LL3hs/dVE/CTK/sSmPs/H/D2uBR7G3WBIuSh3Vw3AX
	 +WxIpnNuD/ZCw==
Message-ID: <5f2103ff-cc78-46b6-b008-127678c23592@denx.de>
Date: Wed, 25 Sep 2024 14:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kostya Porotchkin <kostap@marvell.com>, Matteo Lisi
 <matteo.lisi@engicam.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
 <20240916162758.GE4252@bill-the-cat>
 <CAPVz0n1krz0GxwEXA+FFr1DHVz-c4R4zm++Ji1KhmBTab9m_2g@mail.gmail.com>
 <20240920164856.GI4252@bill-the-cat> <20240924234406.GX4252@bill-the-cat>
 <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n09xf42O1X7QBO8nraDV86EEUOdw+S7qZdr327v0gcQ1A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 30 Sep 2024 12:45:41 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2420

On 9/25/24 12:18 PM, Svyatoslav Ryhel wrote:

[...]

> Hello there!
> I was digging this when I had some free time and found that with
> patches from Marek the only difference is that function
> i2c_get_chip_for_busnum is not called for PMIC's main i2c address

Is it possible this is called earlier, before UART output is 
initialized, so it does not show up in the log below ?

Could it be that it is called before your pinmux is properly 
initialized, hence no UART, and that is why the I2C communication fails?

So far, I only found Toradex Tegra T20 board here, no T30.

