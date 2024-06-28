Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043AC30659
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 11:57:25 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.16835.1719581220675708394
 for <u-boot-amlogic@groups.io>;
 Fri, 28 Jun 2024 06:27:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=phobos-20191101 header.b=pV5jhr+e;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 951EB882D6;
	Fri, 28 Jun 2024 15:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719581218;
	bh=mnbA2OdO99mTN6WqYtNoEThk73Pueo/uLr09Ckx+SYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pV5jhr+eWmVjyo8ogvjyAAwGj5yt7CG1O0PWgsuUrMnfPdPsBmLtWFUZuPKdNXHs9
	 b8scU++2u1L09f1/kg3jbEvqS0Wc1qoj6urvNMiKShVUidrr51dsNCgxI1MI3HO3C4
	 O2dIdTObheVoSou5McngQJy8BaTaQw924CQ0i83t3Jj4DJFC4hZkJFRa2uYz155ja0
	 MP9o5NPeMeAeeAsTshscrrzzMFPj79fAu0BZATmpDwbA2aKm80IUB0EudVWMw2Rr1w
	 rMZW/RIntQjON6NPj4yc/YTiwe/hluxRr+aKBMk6GYh+B3JNxSxUx6RohpWcZj6+YL
	 qsISyGrNcyKhQ==
Message-ID: <616b231b-0291-4bb3-93d9-85970419ed62@denx.de>
Date: Fri, 28 Jun 2024 14:54:26 +0200
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTgAqOXbkcJxYKxM4gn6_oOg7+nyaBK-Y34r_zVaPBScvA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 01 Jul 2024 11:57:25 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2349

On 6/28/24 9:32 AM, Simon Glass wrote:
> Hi Marek,

Hi,

[...]

>>>> @@ -473,8 +483,6 @@ static int regulator_pre_probe(struct udevice *dev)
>>>>                                                   -ENODATA);
>>>>           uc_pdata->max_uA = dev_read_u32_default(dev, "regulator-max-microamp",
>>>>                                                   -ENODATA);
>>>> -       uc_pdata->always_on = dev_read_bool(dev, "regulator-always-on");
>>>> -       uc_pdata->boot_on = dev_read_bool(dev, "regulator-boot-on");
>>>>           uc_pdata->ramp_delay = dev_read_u32_default(dev, "regulator-ramp-delay",
>>>>                                                       0);
>>>>           uc_pdata->force_off = dev_read_bool(dev, "regulator-force-boot-off");
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> This is reading a lot of DT stuff very early, which may be slow. It is
>>> also reading from the DT in the bind() step which we sometimes have to
>>> do, but try to avoid.
>>
>> Actually, it is reading only the bare minimum very early in bind, the
>> always-on and boot-on, the rest is in pre_probe, i.e. later.
> 
> Yes, I see that. Also it is inevitable that these properties need to
> be read before probe(), since they control whether to probe().
> 
>>
>>> Also this seems to happen in SPL and again pre-reloc and again in
>>> U-Boot post-reloc?
>>
>> What does, the uclass post_bind ?
> 
> I mean that this code will be called in SPL (if the regulators are in
> the DT there), U-Boot pre-reloc and post-reloc, each time turning on
> the regulators. We need a way to control that, don't we?

I would assume that if those regulators are turned on once in the 
earliest stage , turning them on again in the follow up stage would be a 
noop ? This is the point of regulator-*-on, to keep the regulators on.

>>> Should we have a step in the init sequence where we set up the
>>> regulators, by calling regulators_enable_boot_on() ?
>>
>> Let's not do this , the entire point of this series is to get rid of
>> those functions and do the regulator configuration the same way LED
>> subsystem does it -- by probing always-on/boot-on regulators and
>> configuring them correctly on probe.
>>
>> To me regulators_enable_boot_on() and the like was always an
>> inconsistently applied workaround for missing DM_FLAG_PROBE_AFTER_BIND ,
>> which is now implemented, so such workarounds can be removed.
> 
> That patch seemed to slip under the radar, sent and applied on the
> same day! We really need to add a test for it, BTW.

Which patch ? My recollection of DM_FLAG_PROBE_AFTER_BIND was that it 
took a while to get in.

> My concern is that this might cause us ordering problems. We perhaps
> want the regulators to be done first. If drivers are probed which use
> regulators, then presumably they will enable them. Consider this:
> 
> - LED driver auto-probes
>     - probes I2C bus 2
>     - probes LDO1 which is autoset so turns on
> - LDO1 probes, but is already running
> - LDO2 probes, which is autoset so turns on
> 
> So long as it is OK to enable the regulators in any order, then this
> seems fine. But is it? How do we handle the case where are particular
> sequence is needed?

Did we finally arrive at the point where we need -EPROBE_DEFER alike 
mechanism ?

