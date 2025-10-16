Return-Path: <funderscore@postmarketos.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E76CCD199
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 15:26:28 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
 by mx.groups.io with SMTP id smtpd.web11.29.1760628380400772878
 for <u-boot-amlogic@groups.io>;
 Thu, 16 Oct 2025 08:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@postmarketos.org header.s=key1 header.b=M+ddTd+F;
 spf=pass (domain: postmarketos.org, ip: 91.218.175.183, mailfrom: funderscore@postmarketos.org)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1760628378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRAdyH80COzGvOaCUW3uw+c2RzqupLFmxszvF4CBqcg=;
	b=M+ddTd+F+JoIC04Y0LPcdL/yhwSvDGDkx55ExzPdtLFKSZ1F90NbQCyGFw4FMBDFP/vEha
	2XWlWiDlXdnagGoKdamhcMOkY4EScJ9arx/1kaXFJavAFlw55pI6DHk9iAShmz1zX28pRE
	QshZy2uF0DwNWnONsxkdsBGJRk8BZYUsHwmTB8L+p2/Rkd7xrqxLqB7Ryf7+6sk6m2dRiM
	enXL3YCJcX6n9pwXuZ9MRebrDUtyFLYGck1eqqx91alccxxabmx6ZP0nmMlEuqgyJfG2k8
	mBCZJg+wHsbzPffiFmN5z/BgfW6QPXrrO4wcSLl2X+2ZkSGXmIFRg8x2rOxjnQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 15:26:15 +0000
Message-Id: <DDJUO5KUY4O0.2ZL250CXB438@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v4 6/8] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino Galvani"
 <b.galvani@gmail.com>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
 <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
 <fc4dbf76-cba2-495c-a4e6-e3f9fc770690@cherry.de>
 <DDJ3ADEZWAMW.27UXI62EV28ZZ@postmarketos.org>
 <88297023-efd7-47bd-bd4d-a03dff1c2e19@cherry.de>
In-Reply-To: <88297023-efd7-47bd-bd4d-a03dff1c2e19@cherry.de>
X-Migadu-Flow: FLOW_OUT
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 16 Oct 2025 15:26:28 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2821

Hi Quentin,

On Thu Oct 16, 2025 at 9:21 AM UTC, Quentin Schulz wrote:
> <...>
>
> Yesterday me was convinced binman is generating the SPL binaries but it=
=20
> isn't the case :) Sorry for the noise.
>

No worries!

>>> Typically it is generated with:
>>>
>>> u-boot-spl {
>>> };
>>>
>>=20
>> ...but I think this is much cleaner, so I'll go with that.
>>=20
>
> And this is essentially
>
> blob {
>      filename =3D "spl/u-boot-spl.bin";
> };
>
> Because tools/binman/etype/u_boot_spl.py is inheriting Entry_blob whose=
=20
> default "filename" property is "spl/u-boot-spl.bin".
>
> TIL :)
>

Yep, but I think maybe `u-boot-spl {};` might be cleaner than just
`blob`..

>>> ?
>>>
>>> If you're trying to enforce a max size, then we have Kconfig symbols fo=
r
>>> those, probably SPL_MAX_SIZE and then I believe binman enforces those
>>> one way or another. If it doesn't, then many boards and architecture
>>> have a problem and we should fix that so you can rely on it.
>>>
>>=20
>> I did know of SPL_MAX_SIZE... Might have just overlooked it though.
>> I think this should be the proper way to do this, yeah.
>>=20
>
> If I were you I'd triple check though, because I'm not entirely sure it=
=20
> does what you want. I quickly checked on Rockchip and I think this is=20
> rather enforced at the mkimage level in tools/rkcommon.c where we store=
=20
> the max size of the xPL (size of available SRAM to U-Boot (third member=
=20
> of spl_info struct)) and compare the size of the xPL (TPL if there's=20
> one, SPL otherwise). See rkcommon_check_params().
>
> Though that tool predates our use of binman for generating the images on=
=20
> Rockchip, so maybe Binman checks properly. I vaguely remember having=20
> binman shout at me that my xPL was too big (likely because it detected=20
> an overlap with the offset at which U-Boot proper is expected). One way=
=20
> to be sure is to artificially increase the size of the binary and check=
=20
> if it fails when expected to.
>
> FYI, on Rockchip we went for a unique binary (u-boot-rockchip.bin) which=
=20
> contains both the xPL and U-Boot proper at the expected offset. Then you=
=20
> just need to tell users to flash the binary at the offset the BootROM is=
=20
> expecting to find the xPL header. It's rather convenient (but is a bit=20

This is also how Amlogic works here. There's a single
u-boot-meson-with-spl.bin binary which contains the @AML bootROM header,
raw SPL binary, and the rest are fit images. The issue mainly lies in
the bootROM only reading up to 0xc000 bytes, and with the header taking
0x1000 bytes (there's padding, so that SPL gets loaded to 0xd9001000),
this means we only have 0xb000 for the entire SPL image.

> "bloated" by zeroes if U-Boot proper is much later in the storage medium=
=20
> compared to the end of the xPL, e.g. by default on Rockchip proper is=20
> almost ~8MiB after the start of xPL) because regardless of the device or=
=20
> configuration, the flashing instructions are the same. We still expose=20
> the xPL and proper files individually if you want to flash them by hand=
=20
> (which comes in handy when you want to use those 8MiB for storing e.g.=20
> the U-Boot environment(s) and not erase it whenever you flash U-Boot).=20
> Food for thoughts :)
>
> [...]
>
>>>> +				};
>>>> +
>>>> +				atf {
>>>> +					description =3D "ARM Trusted Firmware";
>>>> +					type =3D "firmware";
>>>> +					os =3D "arm-trusted-firmware";
>>>> +					arch =3D "arm64";
>>>> +					compression =3D "none";
>>>> +					load =3D <BL31_ADDR>;
>>>> +					entry =3D <BL31_ADDR>;
>>>> +
>>>> +					atf-bl31 {
>>>> +						filename =3D "bl31.bin";
>>>
>>> I believe this is already the case if you set BL31 environment variable
>>> to bl31.bin. I would simply remove it and let the user decide what's
>>> best for them. For binman this comes from the -a atf-bl31-path=3D${BL31=
}
>>> argument.
>>>
>>> The benefit is that you can now point to a BL31 outside of U-Boot's
>>> tree, which is super convenient for debugging TF-A, or with build
>>> systems like Yocto or Buildroot.
>>>
>>=20
>> You can already point to a BL31 outside U-Boot's tree, and this is what
>> I've been always doing when testing.
>>=20
>
> Reading tools/binman/etype/atf_bl31.py and=20
> tools/binman/etype/blob_named_by_arg.py, it seems if BL31 env variable=20
> is set (and thus passed via -a atf-bl31-path to binman) then the=20
> filename property of atf-bl31 node is replaced with BL31. So you're right=
 :)
>
>> But I think having it check for a bl31.bin inside the tree when $BL31 is
>> not set is a sane default IMO .. but correct me if I'm wrong and it's
>> considered poor practise.
>>=20
>
> No opinion on this.
>
> [...]
>
>>>> +				};
>>>> +
>>>> +				scp {
>>>> +					description =3D "SCP firmware";
>>>> +					type =3D "scp";
>>>> +					arch =3D "arm"; /* The Cortex-M core is used as SCP */
>>>> +					compression =3D "none";
>>>> +					load =3D <SCP_ADDR>;
>>>> +
>>>> +					scp {
>>>> +						filename =3D "scp.bin";
>>>> +					};
>>>
>>> I would recommend to attempt mimicking what's been done for atf-bl31
>>> (then you need to add a new argument to the lists of arguments for
>>> binman in the root Makefile). See above for benefits.
>>>
>>=20
>> One can already `export SCP=3D../path/to/scp/firmware` and have binman u=
se
>> that.
>>=20
>
> Indeed, it is passed via -a scp-path to Binman. And this mimics what's=20
> been done earlier in this patch for atf-bl31, so I guess this checks out=
=20
> :) Sorry for the noise.
>
> Cheers,
> Quentin

Thanks,
Ferass

