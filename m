Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F72C47DDB
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 08:59:00 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.19861.1706195045857994931
 for <u-boot-amlogic@groups.io>;
 Thu, 25 Jan 2024 07:04:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=I+UtSfBL;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7838af983c1so482908285a.3
        for <u-boot-amlogic@groups.io>; Thu, 25 Jan 2024 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1706195045; x=1706799845; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHj+GY+dKxCo9JwwpM78JMUy6biA2WMU4dqQ3GsXW2I=;
        b=I+UtSfBLP5A5ki/ZJlHawRuf+vouEjEatAfkm8Pb52ESBZ/w7/rOGymIdLBUGw56Kr
         NtlbcIhHs2o8q37wLDrHzAPiOJFEb7ZRrkM6vf/mOocihLz392UVLzS7EUy0TTLrXA7K
         w4o9zf1IfpcxiGm2J3jGyANCPlMUruvxOnxAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195045; x=1706799845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHj+GY+dKxCo9JwwpM78JMUy6biA2WMU4dqQ3GsXW2I=;
        b=TKCzPAXOZre4ixPn+Ft0+YT/rHIRZE0WPdE6mMvF1nDUe5rl7mDI6W2ndz5RaUN+qv
         Mf7hDhZCoexZS3b4G3txTE/V1p8e853hX9vLIYHlo5B4Gaf9mWLDDPtUOd6JSqpFkZyf
         ySirQ/rDRAEmr90hL9kyGuaEBFZ6I+zVS5olis9KmvRqKnClXkL9zQ7JIzz+5Km92DPk
         8W2sWi2dy1OxUUUobDbmRttMtAw9dU9H8RAo+mI3ZjJJDKkKQQVahkcaRN/ajrIpocbW
         GomG0wJSiKhK8i8otqh/0j4I3aCWBDI5vV21kvsMpOgMYo7y/utgafBrt3RJEehriR8K
         3lhQ==
X-Gm-Message-State: AOJu0YwM7SkCCLu5p65B5GJXViWz0jn4HVx2Q9s6OABZOm4GFLts9RGn
	tVzhf9qjqcSN1keR/tdTBuVNYnq5sELUjxGVSLv0zs1n98g8g7l4S5ldCYpyUbQ=
X-Google-Smtp-Source: AGHT+IGuohF7IVVqZS0ugmYETim1ESaYT8qCB9JPSkJ38LIl/3VaeLcW7S0hYsVnBgG1OEVKcTtYcA==
X-Received: by 2002:ad4:5c44:0:b0:684:e4e3:3a49 with SMTP id a4-20020ad45c44000000b00684e4e33a49mr1688219qva.48.1706195044631;
        Thu, 25 Jan 2024 07:04:04 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id ny18-20020a056214399200b006868e6d8b37sm4206977qvb.23.2024.01.25.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:04:04 -0800 (PST)
Date: Thu, 25 Jan 2024 10:04:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
Message-ID: <20240125150400.GM3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=uTEx4khFVz9XgAwZ16mr"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 26 Jan 2024 08:59:00 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2087

--Groupsio=uTEx4khFVz9XgAwZ16mr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:

[snip]
> But at this point we have to move away from apprehensions about DT ABI
> breakages and provide real examples of the DT ABI breakages in the
> past. Are you aware of any DT ABI breaking change backported to Linux
> stable releases? This is the sort of information we would like to make
> DT bindings maintainers aware about.

Well, how far back are we going? There was a serial related one, but it
was probably closer than not to 10 years ago and lessons have been
learned from it already.

The real breakage comes in the form of (from the Linux kernel):
commit 37685f6a63eeca2135d1f704e7638409a071b1f6
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue Feb 19 08:46:33 2019 -0800

    ARM: dts: am335x-evm: Fix PHY mode for ethernet

    The PHY must add both tx and rx delay and not only on the tx clock.
    The board uses AR8031_AL1A PHY where the rx delay is enabled by default=
,
    the tx dealy is disabled.

    The reason why rgmii-txid worked because the rx delay was not disabled =
by
    the driver so essentially we ended up with rgmii-id PHY mode.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

And this is of the style "the DTS was wrong before so we can break it".
This is the specific example (as the board is in my lab) that comes most
clearly to mind but there have been similar examples in 2022/2023.

The other just as painful examples I think may be where Marek is
concerned and it's around nodes being renamed for correctness. We've had
a number of cases where a - turned to _ (or vice versa?) and whoops,
platform stops booting. Down the line, tooling would catch that, and
it's a problem of not being able to use better tooling until we have the
updates that might break the boards that need the better tooling.

And really this gets to the crux of the problem, how much testing do we
insist happens prior to a re-sync being merged? Do we want to go with
the whole of the dts files are re-synced, or do we leave it per vendor?
I think it's been noted that a subtree merge commit doesn't really "git
send-email" well.

I really am inclined to start with keeping everyone to the release tags
for everyone and merging them as soon as the next window opens. I
_think__ and we'll be able to find out quickly enough, that we can
cherry-pick fixes from upstream in to our subtree and have subtree Do
The Right Thing in the next merge window.

[snip]
> > I think upstreaming the bootph* properties would still take a while, bu=
t
> > is not relevant to the aforementioned question.
> >
> > Assume there is a sync, would the current in-tree -u-boot.dtsi files ge=
t
> > updated to work correctly with the newly synced DTs ?
>=20
> As long as they contain nodes/properties (eg. bootph* etc.) which are
> compliant with upstream DT bindings then yes they should work
> correctly with the newly synced DTs.

This is a good specific example. The bootph* properties should _now_ be
easier to get accepted upstream as our tooling handles the transitive
property of them correctly and so they don't need to be manually applied
so much (a problem upstream maintainers had, after the binding was
accepted, was the sheer number of them being added, this is now fixed).
But also applying these properties via -u-boot.dtsi was tripped up in
resyncs where the parent node was renamed for correctness and there's no
tooling that we had that complained. In the future, this would have been
caught because we would have been dtbs_check clean, or at least clean
enough that I'd be running it and caring about deltas from before/after.

--=20
Tom

--Groupsio=uTEx4khFVz9XgAwZ16mr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyeF0ACgkQFHw5/5Y0
tyx5ugv+PBFaZTYi7jWCJPRlFphI1G24s6Zqd9w4jX8oLzdsfpuVygzycneYrtyb
4+i6bSOLLwjZnGwqps9JTMtqAJ/oOLdIHo9/7MTKmdUeX70R/1FKGGxlgO3/jMJj
0IUo5NW9dZsUyIR3OD0/Se3ZmzE85QGLpe9oSwOcZQXGw9iyskdAnJlTdQ/hdnbw
8HpHoDk0JT7ikqFhFx7zgFurpkkfv95/SiH8JDyzUi/jwRGQSjfFcVQSdoFwNZg8
msMkyNVoh4iWtAaIY1KulO1S/T3SHOh30DEMrjEqmAMY/mkRtxE0BwPzuXidWR79
Jq+E9PulWxgbBJ8Kcrrnd4SXfqZ0XZKniBwijgfomM10Rz3oXb8mZkEPcxtp4+Tb
EcxLD1+QKYKLSu/LWATXRDbSh1rflowvAOyc2Bxh8PXof8RvsHs/W7ajzXoZ6zY6
NwyOCmG2fqEqfBaYrltHbC7XIz1VDzTfPDb9yVImhUFhJSslOCO8tNmldb8WIRxf
zpQ6wuPb
=195M
-----END PGP SIGNATURE-----

--Groupsio=uTEx4khFVz9XgAwZ16mr--

