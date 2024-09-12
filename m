Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18324EED601
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 13:31:53 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.43236.1726129641985119220
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Sep 2024 01:27:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=Djbg0RaC;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5F1618897F;
	Thu, 12 Sep 2024 10:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726129639;
	bh=U0IRVS2ysmArSzzgDGhyQMVswegw5RYWHMgtYFjB8NE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Djbg0RaCOcl0lqSbzY9iRgWI9PB6x1CT1g0BPh+lxMzupUcTnT5vLyHnayyPtWeps
	 IaKXe1osdpIJKu1LAFw4rmGWYkeVYxJaCL0Ta0QewStLY/WjNqUwS1PCZybfFXMEer
	 WD3rwcooRpe5UQgt9cPYwrVz+n+YH9ahloTEv8grIKJU/JSulj9LTpGhPRZQxibCNO
	 VPfGoN2ZabBVymx0waBrmA8CccTecfkVr4BtFzNrpNl77atbGxkvsUEfK4U6T+934N
	 4HERCNtTw6r4zWaLqHaSIEHDaeONMnznYw2KDyPtGRfUILUopp9nEW/3YynsSUeXV6
	 oj8piC9cEEk8Q==
Message-ID: <e8ac6bbc-134b-49f3-ad44-05806ad74dbe@denx.de>
Date: Thu, 12 Sep 2024 10:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which are always-on or boot-on
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
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
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io,
 u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240626235717.272219-1-marex@denx.de>
 <CAFLszTjwbWdKqs_UBqXvr2F2ahoGd0-BFE-XLNr3-uq73ZLFHg@mail.gmail.com>
 <6abad4ba-b29a-47a3-addb-91e8f46ee425@denx.de>
 <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
 <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
 <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTiHy7yn0Z18GdkSLgykH0s=z8tJ=-QGf+knXPggKwyk9Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 12 Sep 2024 13:31:53 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2386

On 9/12/24 3:00 AM, Simon Glass wrote:

Hello Simon,

>>>>> Also this seems to happen in SPL and again pre-reloc and again in
>>>>> U-Boot post-reloc?
>>>>
>>>> What does, the uclass post_bind ?
>>>
>>> I mean that this code will be called in SPL (if the regulators are in
>>> the DT there), U-Boot pre-reloc and post-reloc, each time turning on
>>> the regulators. We need a way to control that, don't we?
>>
>> I would assume that if those regulators are turned on once in the
>> earliest stage , turning them on again in the follow up stage would be a
>> noop ? This is the point of regulator-*-on, to keep the regulators on.
> 
> No, there is sometimes a particular sequence needed.

If the regulators are already enabled, enabling them again will be a 
noop, do you agree ?

[...]

>>> My concern is that this might cause us ordering problems. We perhaps
>>> want the regulators to be done first. If drivers are probed which use
>>> regulators, then presumably they will enable them. Consider this:
>>>
>>> - LED driver auto-probes
>>>      - probes I2C bus 2
>>>      - probes LDO1 which is autoset so turns on
>>> - LDO1 probes, but is already running
>>> - LDO2 probes, which is autoset so turns on
>>>
>>> So long as it is OK to enable the regulators in any order, then this
>>> seems fine. But is it? How do we handle the case where are particular
>>> sequence is needed?
>>
>> Did we finally arrive at the point where we need -EPROBE_DEFER alike
>> mechanism ?
> 
> Nope. But I am concerned that this patch is leading us there. bind()
> really needs to be as clean as possible. It is one of the design
> elements of driver model which Linux should adopt.
> 
> There is always a race to be the first to init something, move the
> init earlier, etc... I don't see any general need to init the
> regulators right at the start. It should be done in a separate
> function and be optional. I am happy to send a patch if you like.
I strongly disagree that regulators which are marked in DT as 
always-on/boot-on should somehow be treated as optional-on in U-Boot , 
no , they should not. They should be enabled by the regulator uclass 
core code, for every regulator which is marked that way. If they are not 
to be enabled, they should not be marked that way in DT.

While the board code may exercise some control over enabling regulators 
earlier, it should still be the default in the core code to enable such 
regulators unconditionally.

If the concern is ordering problems between regulators, then regulators 
have to define vin-supply to describe their upstream supply in DT, which 
should address the ordering problem. DTTO for clock and pinmux etc.

