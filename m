Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1100DC46CD8
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 08:39:44 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.72843.1702667999367527446
 for <u-boot-amlogic@groups.io>;
 Fri, 15 Dec 2023 11:19:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WhRUQKyL;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f11ccd8e7so7352126d6.3
        for <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702667998; x=1703272798; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtrcrJlr6NeQHIK2RkW/lpzI31QtzOIlHI31PNSBLU8=;
        b=WhRUQKyLeGhYOE5+ukUnhsnGQi/E1O0WH5IOjMm+/JtEc93+oF2f67leMkikEsNYZ7
         MWq5rc1mU2EKvLXIXTAIztbsblWP3QGXHV/26ln9uxpuFUB9Hw69zifaVtlVRKe4/fAs
         j4yhn7CQtxWTb40c0EyR8P0xrpsiC66WdqmBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667998; x=1703272798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtrcrJlr6NeQHIK2RkW/lpzI31QtzOIlHI31PNSBLU8=;
        b=DrnLXsCb0sjE93jKC+5EK1jkjI8sd9U7E4fG3f5jgliQY85PYutktgZekyZRwuGgzU
         PKeBkx4naUkynoxhiVF2TDvC37iZg2N5/J65xf1ayqL4FR+IE36LntaLQ86BZjGqmczc
         l/7eOVGLeMW7aPj58xzsZnE+35dnAtYhOqZvSvyb1eqVLY1IvJ5v0hTaab65cxDK2igz
         SM86m8JFhqlpbXqoh1taT6DpEguM4AhX41PEvXbvzjmq0txwO1ZYYT7b4rOIzzHkc8Lo
         ud0Um79ISOv9TvKZbDbN35J7LqsbXAqTSAR13mlV5O8rOzHxvE6msufwnIt1QEHGyn/j
         L3kw==
X-Gm-Message-State: AOJu0YyHD16A9dPCwu7BJLmCj9pYBQYQfyJe3flZ3VuL1LRBKqF/4dvc
	EbH4z2CzPsijdfmhPzeSPyN+RA==
X-Google-Smtp-Source: AGHT+IEXSZCKchxGWNoVq1SMxj+4CTcV+mepkoZuc3c4CPgAyUIRFQ/5wpilBU7u/z6VfE4xPil6hg==
X-Received: by 2002:a05:6214:1cc3:b0:67f:2335:5ef2 with SMTP id g3-20020a0562141cc300b0067f23355ef2mr575416qvd.89.1702667998372;
        Fri, 15 Dec 2023 11:19:58 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com. [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cbf42000000b0067ec8702d1dsm5319558qvj.137.2023.12.15.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 11:19:57 -0800 (PST)
Date: Fri, 15 Dec 2023 14:19:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
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
Message-ID: <20231215191954.GA2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
 <20231215133743.GV2513409@bill-the-cat>
 <20231215-sputter-puzzle-128dc9f85d73@spud>
MIME-Version: 1.0
In-Reply-To: <20231215-sputter-puzzle-128dc9f85d73@spud>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=96j7kJuH0AjUPFQQQ5F7"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 18 Dec 2023 08:39:44 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1940

--Groupsio=96j7kJuH0AjUPFQQQ5F7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 02:45:11PM +0000, Conor Dooley wrote:
> On Fri, Dec 15, 2023 at 08:37:43AM -0500, Tom Rini wrote:
> > On Fri, Dec 15, 2023 at 08:50:51AM +0100, Krzysztof Kozlowski wrote:
> > > On 14/12/2023 20:48, Rob Herring wrote:
> > > >>
> > > >> I think some of the important questions to ask are, how often / li=
kely
> > > >> are the breakages to occur? It seems like these days it's either:
> > > >> - U-Boot had an early version of the binding and we already state =
we
> > > >>   don't support backwards compatibility here. It should be on the
> > > >>   maintainer to be proactive in this case.
> > > >> - It's a "the DT was wrong about the hardware, sorry not sorry it'=
s an
> > > >>   incompatible DTS change now". This too is hopefully the kind of =
thing
> > > >>   that at least board maintainers will be more actively aware of n=
eeding
> > > >>   to deal with in U-Boot, if it's really a problem.
> > > >=20
> > > > A common issue in the kernel is with forward compatibility when
> > > > platforms add new resources from a new provider. Then the kernel
> > > > expects a driver for the provider and waits for the dependency. Of
> > > > course, older kernels don't have that provider driver and so the
> > > > dependency is never met. Not sure if u-boot will have similar issue=
s?
> > > > At least you should/could know if the provider driver exists or not=
.
> > > > (The kernel doesn't because modules.)
> > >=20
> > > If some U-Boot platform decides to aggressively sync with kernel DTS,
> > > then probably the kernel subarch maintainer should be aware of it.
> > > Mentioned forward compatibility issue is a result of assumption that
> > > there are no out-of-tree upstream consumers of our DTS. I am certainl=
y
> > > not aware of any such consumer for Samsung. If someone told me (me
> > > wearing Samsung hat), hey U-Boot now cares, I would start caring as w=
ell.
> > >=20
> > > The usual argument of contributors wanting to break the backward and
> > > forward compatibility, is "there is no other OS depending on this"
> > > (recent discussion with Johan about order of interrupts:
> > > https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
> > > You need to tell the maintainers of that platform, that now they have
> > > other OS/firmware/bootloader depending on DTS compatibility.
> >=20
> > I think this hints at one of the bigger impacts this might have.
> > Reminding everyone that other projects do use the device trees and have
> > for years.
>=20
> TBF, we do try to ask these questions as much as possible, usually (for
> me at least) citing U-Boot or the BSDs as users. It largely seems to me
> like we are all bark and no bite though, so a project like U-Boot having
> a defined "schedule" as you suggest below would add more meaning to our
> questioning.
>=20
> > Without rehashing history, BSD does use the trees as-is and
> > for platforms U-Boot supports they are supposed to be re-synced
> > periodically.
>=20
> I know this is the theory, but I also know that how well this is
> implemented varies wildly per-platform. I generally don't pay all
> that much attention to the various arm platforms, but I do pay
> attention to what's going on for RISC-V and there appear to be no
> active maintainers of individual platforms and the architecture
> maintainers are not aware of the status of the equivalent patches
> for Linux when they apply patches.
>=20
> In recent memory, this has lead to the clock indices in the DT
> differing between U-Boot and Linux for one such platform, which, IMO,
> is an insidious difference that is hard to spot during review and highly
> unlikely to crop up while comparing dts files, since the defines were nam=
ed
> identically. To be clear, I am not expecting the architecture code
> maintainers to be aware of the minutiae of the various RISC-V platforms,
> but rather suggesting they might have an easier time reviewing if both
> projects' dts files and binding headers were tied together.
>=20
> That said, automatically synced devicetrees will, as has been pointed out=
,
> require the platform maintainers in Linux to be more aware of the affect =
of
> what they accept on other users, but it will also require the equivalent
> maintainers on the U-Boot side to engage too, so that the "upstream" dts
> files do not change in a way that screws the usecase in U-Boot.

Yeah, it will hopefully lead to better coordination between maintainers
in some places. There are SoCs where the kernel DTS people are the
U-Boot DTS people too. All in all, I should probably CC more people than
I usually do on these resync patches just to try and head off any
tricky changes like you've mentioned above.

> Also, if people send fixes to the U-Boot copies of these devicetrees,
> would the plan be to request that these are sent to Linux and the fixes
> pulled in via a resync after each -rc release of Linux (or similar, just
> throwing some example schedule out there)?

The way we've always tried to operate is that changes should be pushed
to Linux and resynced down, or at least submitted simultaneously. If
there's some specific bugfixes that need to come in out of cycle I
_think_ subtree handles cherry picked commits in a reasonable fashion.

--=20
Tom

--Groupsio=96j7kJuH0AjUPFQQQ5F7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8ptYACgkQFHw5/5Y0
tyyKBgv7BVSQkeprEQzWJTMp0f8pdUUA3HMyTAiUkAxp0EKkaqIOmthMjZDBiVcV
NSklXHapjPYN0s3HThDaBxd1TKSenmjXDFWyOldF7JQ8zEf/VHprawfbculgLg0g
E1NNovps2Hawt05fxmbjQ2Fxqa50dcW4pgbgbYju+W0Au+y5IrZzThlchzdgfav5
SRA/eafuv9qSZALg7ifKdO2vrOgR6FKgE3LsFmUECH5xtVYL87fhuGXV1nXNkLkG
/9aPkAokOZi7FWppoSaOY47hxZVGReccdBxLKEE4vwYQSwimfhDzOMXBzWwzfPK6
s2lOucq0Sq+5o/ToCLWNm4/VTZziKY8iPnfqcA/oe8f1F4amUbaK2vNU0Whv9n0F
TgcHqqpFwghkYQs7HTWxaIUXt6sxc2F0Xopw4lJ8w+/qigq+XtHifZYJ3lGW7bIr
qsc+3njtxl25wG3mAZwNZCizvdCstCSVhBN2TzfXj8JdSGCUS+NBIDWrJDyGYR/9
RL8oUsFy
=1/sk
-----END PGP SIGNATURE-----

--Groupsio=96j7kJuH0AjUPFQQQ5F7--

