Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B98C35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:43 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by mx.groups.io with SMTP id smtpd.web10.63836.1702651522302584504
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Dec 2023 06:45:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=eN5Ni/h0;
 spf=pass (domain: kernel.org, ip: 145.40.73.55, mailfrom: conor@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9F0B3CE25C6;
	Fri, 15 Dec 2023 14:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E70FC433C7;
	Fri, 15 Dec 2023 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702651518;
	bh=eTizyG1i+D4qJqO7bZVnGQxpyheLJU4kMJLMZwamF+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eN5Ni/h0cmBHhP3tgrRObmAOdrf5lNcOOhq0FU/+/q9fVdfeBfoVonu+FlXafe/Ag
	 118KwOcO2Nji923n/8xWnYU1D7oheOARcos4u5zXdj03mZEdRXgfVkOo6fqGybKXpm
	 0PEuq97yMSGX1syURZfm/p3YmhfaYUpY9l2+pORDQzbeqRpDMXApcUgOsUDpebS7D8
	 REbJJzIC3woDR1rn31KWty9Is4TkjqLtwi7giOCL8t1nyFBdPCF6S+9hbQazTcSYFW
	 z3wXChBMonwVk2yU5h2Oc/DNv3OYB0wrlR3urW+0VKCmlDfrNnVLr2FWFWwS4szMHj
	 Ob51IQ9wq42Iw==
Date: Fri, 15 Dec 2023 14:45:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org,
	Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	sjg@chromium.org, krzysztof.kozlowski+dt@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
Message-ID: <20231215-sputter-puzzle-128dc9f85d73@spud>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
 <20231215133743.GV2513409@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20231215133743.GV2513409@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=amKpacsZufvxfD9fZyLi"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:43 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1938

--Groupsio=amKpacsZufvxfD9fZyLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:37:43AM -0500, Tom Rini wrote:
> On Fri, Dec 15, 2023 at 08:50:51AM +0100, Krzysztof Kozlowski wrote:
> > On 14/12/2023 20:48, Rob Herring wrote:
> > >>
> > >> I think some of the important questions to ask are, how often / like=
ly
> > >> are the breakages to occur? It seems like these days it's either:
> > >> - U-Boot had an early version of the binding and we already state we
> > >>   don't support backwards compatibility here. It should be on the
> > >>   maintainer to be proactive in this case.
> > >> - It's a "the DT was wrong about the hardware, sorry not sorry it's =
an
> > >>   incompatible DTS change now". This too is hopefully the kind of th=
ing
> > >>   that at least board maintainers will be more actively aware of nee=
ding
> > >>   to deal with in U-Boot, if it's really a problem.
> > >=20
> > > A common issue in the kernel is with forward compatibility when
> > > platforms add new resources from a new provider. Then the kernel
> > > expects a driver for the provider and waits for the dependency. Of
> > > course, older kernels don't have that provider driver and so the
> > > dependency is never met. Not sure if u-boot will have similar issues?
> > > At least you should/could know if the provider driver exists or not.
> > > (The kernel doesn't because modules.)
> >=20
> > If some U-Boot platform decides to aggressively sync with kernel DTS,
> > then probably the kernel subarch maintainer should be aware of it.
> > Mentioned forward compatibility issue is a result of assumption that
> > there are no out-of-tree upstream consumers of our DTS. I am certainly
> > not aware of any such consumer for Samsung. If someone told me (me
> > wearing Samsung hat), hey U-Boot now cares, I would start caring as wel=
l.
> >=20
> > The usual argument of contributors wanting to break the backward and
> > forward compatibility, is "there is no other OS depending on this"
> > (recent discussion with Johan about order of interrupts:
> > https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
> > You need to tell the maintainers of that platform, that now they have
> > other OS/firmware/bootloader depending on DTS compatibility.
>=20
> I think this hints at one of the bigger impacts this might have.
> Reminding everyone that other projects do use the device trees and have
> for years.

TBF, we do try to ask these questions as much as possible, usually (for
me at least) citing U-Boot or the BSDs as users. It largely seems to me
like we are all bark and no bite though, so a project like U-Boot having
a defined "schedule" as you suggest below would add more meaning to our
questioning.

> Without rehashing history, BSD does use the trees as-is and
> for platforms U-Boot supports they are supposed to be re-synced
> periodically.

I know this is the theory, but I also know that how well this is
implemented varies wildly per-platform. I generally don't pay all
that much attention to the various arm platforms, but I do pay
attention to what's going on for RISC-V and there appear to be no
active maintainers of individual platforms and the architecture
maintainers are not aware of the status of the equivalent patches
for Linux when they apply patches.

In recent memory, this has lead to the clock indices in the DT
differing between U-Boot and Linux for one such platform, which, IMO,
is an insidious difference that is hard to spot during review and highly
unlikely to crop up while comparing dts files, since the defines were named
identically. To be clear, I am not expecting the architecture code
maintainers to be aware of the minutiae of the various RISC-V platforms,
but rather suggesting they might have an easier time reviewing if both
projects' dts files and binding headers were tied together.

That said, automatically synced devicetrees will, as has been pointed out,
require the platform maintainers in Linux to be more aware of the affect of
what they accept on other users, but it will also require the equivalent
maintainers on the U-Boot side to engage too, so that the "upstream" dts
files do not change in a way that screws the usecase in U-Boot.

Also, if people send fixes to the U-Boot copies of these devicetrees,
would the plan be to request that these are sent to Linux and the fixes
pulled in via a resync after each -rc release of Linux (or similar, just
throwing some example schedule out there)?

Cheers,
Conor.

> This series moves us from an ad-hoc method to a defined
> schedule.
>=20
> And presumably some of the Samsung platforms will get moved over to this
> framework, especially the newer ones being submitted recently :)




--Groupsio=amKpacsZufvxfD9fZyLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXxmdwAKCRB4tDGHoIJi
0tYzAQCU3qqAUtD6CJncuB11pCa7H8tylsPvqaLwE/bkEuwPiwEA1p/Y5d3Wime3
k/O36WRv/xzGQVA2XOXJX7rjSEgjtwg=
=jZno
-----END PGP SIGNATURE-----

--Groupsio=amKpacsZufvxfD9fZyLi--

