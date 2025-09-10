Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F9CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 10:28:20 +0000 (UTC)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
 by mx.groups.io with SMTP id smtpd.web11.14061.1757500098444640827
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Sep 2025 03:28:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=mpbsHP9t;
 spf=pass (domain: postmarketos.org, ip: 95.215.58.179, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757500095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRzDKo2Ur/uDONDCOk5YPoxIUMD3fdTbt4VdrayqtPM=;
	b=mpbsHP9tGUNF0pXKOQVcafdhDQ6mlwtVpTDs4dtUXnuifnXvGE0f5iSTnQp3YF30Cswbp8
	Xz3zBrsB7K4e+bLxaCEROn6n7/5Sbo2rWBc1VE9D995/JIx0fwFGnFAnRRrmHQ/99oIS6+
	m2QEwYqqd5n+KRMwb5rLimZCZJeSZNbjdBDrMa73ya8XMBvZsyit8AJVTCV5IS3pQcJjVD
	mjE61PS+/EnwF93Gf+p7uMXcui29kfHMaCEa1MzvTx9Q4VWs/yLwcIihmS7COVz64L6Euz
	PiMGUmQx/XIikQjZ5XO7Q1nVepjzXypO3ZHKnSEsPzdsr/oPGY9/M1+GfiPQrQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 10:28:00 +0000
Message-Id: <DCP1S6QI5CTQ.GOZ7Y0SAT27O@postmarketos.org>
Subject: Re: [PATCH RFC 5/9] arm: meson: initial u-boot SPL support for GX
 SoCs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <neil.armstrong@linaro.org>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-5-37395d9ff5af@postmarketos.org>
 <b6d9c116-f37d-4793-ba53-f94ed95130dd@linaro.org>
 <DCNKQM04PWE0.35QSN1T1Z5CEZ@postmarketos.org>
 <c1012805-6f06-4855-be4e-6167409c80a0@linaro.org>
In-Reply-To: <c1012805-6f06-4855-be4e-6167409c80a0@linaro.org>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 10 Sep 2025 10:28:20 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2763

On Wed Sep 10, 2025 at 7:02 AM UTC, Neil Armstrong via groups.io wrote:
> <...>
>>=20
>> Sure!  I will also explain here to clarify.
>> Basically this is sending the SCP firmware (aka. bl30/bl301) to the SCP.
>> Historically (in GXBB) this was done by bl2.bin, but (to save space?) it
>> was moved to BL31 in GXL:
>>=20
>> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-=
a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#129
>>=20
>> and BL2 would give image info for bl30/bl301 to BL31.  I patched this
>> upstream so we don't have to do that in SPL:
>>=20
>> - https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-=
a/+/refs/heads/master/plat/amlogic/gxl/gxl_bl31_setup.c#105
>>=20
>> Whether we can move SCP fw loading to BL31 on GXBB is .. an interesting
>> thing that could be considered.  That way we could possibly also save
>> some space in U-Boot SPL.
>>=20
>
> Would be nice, but keep it as-is for now!
>

Yeah, something for later :)

>>>> +void meson_power_init(void)
>>>> +{
>>>> +	/* TODO: Support more voltages */
>>>> +
>>>> +	/* Init PWM B */
>>>> +	clrsetbits_32(GX_PWM_MISC_REG_AB, 0x7f << 16, (1 << 23) | (1 << 1));
>>>> +
>>>> +	/* Set voltage */
>>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1120MV))
>>>> +		writel(0x02001a, GX_PWM_PWM_B);
>>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1100MV))
>>>> +		writel(0x040018, GX_PWM_PWM_B);
>>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VCCK_1000MV))
>>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 22);
>>>> +		clrsetbits_32(GX_PIN_MUX_REG3, 1 << 22, 1 << 21);
>>>> +	} else {
>>>> +		clrbits_32(GX_PIN_MUX_REG1, 1 << 10);
>>>> +		clrsetbits_32(GX_PIN_MUX_REG2, 1 << 5, 1 << 11);
>>>> +	}
>>>> +
>>>> +	/* Init PWM D */
>>>> +	clrsetbits_32(GX_PWM_MISC_REG_CD, 0x7f << 16, (1 << 23) | (1 << 1));
>>>> +
>>>> +	/* Set voltage */
>>>> +	if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1100MV))
>>>> +		writel(0x040018, GX_PWM_PWM_B);
>>>> +	else if (CONFIG_IS_ENABLED(MESON_GX_VDDEE_1000MV))
>>>> +		writel(0x0e000e, GX_PWM_PWM_B);
>>>> +
>>>> +	if (IS_ENABLED(CONFIG_MESON_GXBB)) {
>>>> +		clrbits_32(GX_PIN_MUX_REG7, 1 << 23);
>>>> +		setbits_32(GX_PIN_MUX_REG3, 1 << 20);
>>>> +	} else {
>>>> +		clrbits_32(GX_PIN_MUX_REG1, (1 << 9) | (1 << 11));
>>>> +		setbits_32(GX_PIN_MUX_REG2, 1 << 12);
>>>> +	}
>>>> +}
>>>
>>> Seems much of the code is duplicated between GXBB and GXL, so I wonder =
if it would'nt
>>> be cleaner to have spl-gxbb an spl-gxl ?
>>>
>>=20
>> You mean separate power init functions (meson_power_init_gxbb/gxl)?  Sho=
uld be doable.
>
>
> I mean even separate files, it would avoid any #ifdef stuff
>

Got it.

Thanks!

