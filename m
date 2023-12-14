Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF0C46CD4
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 14:23:04 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.38833.1702584915593628200
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 12:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sm2CPJEy;
 spf=pass (domain: konsulko.com, ip: 209.85.128.172, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e266e8d39eso29749087b3.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702584915; x=1703189715; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoKxmCRm3Sr15GNm3SqsSkHNIJv8+ft/NupKZLa75p0=;
        b=sm2CPJEyAU0eDjjE4s+3Pq/ZqQGc/YrY07TrIm3H8eU89Xona03rzMBkcZDttSjiZR
         F9QlV4sPHlgH9QDWE5QWAQ9O07l4zN64XpnCOr7dCBBeUM5nU9HkvRg8XirBfTjjZE8u
         y5ZUrNmVqAIM/oLjD6EBnXsUftUNoriMoDE8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584915; x=1703189715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoKxmCRm3Sr15GNm3SqsSkHNIJv8+ft/NupKZLa75p0=;
        b=A+W89t4BGq4jIsF6gm+B3FlLW5EQ/7gHzNoTkj6BYymPKCPPoMbcPQfq+Gqq80EFdZ
         u4gSJFfDk2OqdI0mAT5lRUiQ/hus/XHouEngj5YWegc5TWlAbBUZtWU9YPjgrOTcaHOD
         UOwQ11LJ+/S0UwJg1Qw3GCu9rrZupeuigEYBzdI+78D30lsmpbMoZ3fZR/YV1+vc6YNR
         CzUFwdoWWuAUSr/dnincFWBO+1piWdkvKdPph3tO7EXrbvpXV7aw7P+cpx1pytq7oHid
         hLBmOqZEyeMfPkVjuX5Dn8oHhZUXQM34N96dIfgpZeurEsw1QX9x/6wzRv6/1IHXDI2r
         g4iQ==
X-Gm-Message-State: AOJu0YwaLCj4PISFjTYe4u+xUdDRMQG6DqXrMLvVy8tcHsUEKzfbruzB
	rm5Xn2czWr9CanVuMVXz19r1+g==
X-Google-Smtp-Source: AGHT+IGcgMU12rXcdUy6ujOp3LPFUj1y95FRucqW1kQ3okzU67pSdsYhNhir3rpier+Rb4hkWjOETA==
X-Received: by 2002:a0d:d304:0:b0:5d3:e2a2:8bcd with SMTP id v4-20020a0dd304000000b005d3e2a28bcdmr8406120ywd.5.1702584914768;
        Thu, 14 Dec 2023 12:15:14 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com. [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
        by smtp.gmail.com with ESMTPSA id x145-20020a0dd597000000b005e2fb7fad5asm1369996ywd.78.2023.12.14.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:15:14 -0800 (PST)
Date: Thu, 14 Dec 2023 15:15:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: neil.armstrong@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within U-boot
Message-ID: <20231214201511.GR2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=AcPTmMiNvr5Lie5bDcIx"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Dec 2023 14:23:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1931

--Groupsio=AcPTmMiNvr5Lie5bDcIx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 01:48:42PM -0600, Rob Herring wrote:
> On Thu, Dec 14, 2023 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Thu, Dec 14, 2023 at 03:53:11PM +0100, neil.armstrong@linaro.org wro=
te:
> > > Hi,
> > >
> > > On 14/12/2023 14:50, Sumit Garg wrote:
> > > > Prerquisite
> > >
> > > s/Prerquisite/Prerequisite/
> > >
> > > > -----------
> > > >
> > > > This patch series requires devicetree-rebasing git repo to be added=
 as a
> > > > subtree to the main U-boot repo via:
> > > >
> > > > $ git subtree add --prefix devicetree-rebasing \
> > > >        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/dev=
icetree-rebasing.git \
> > > >        v6.6-dts --squash
> > >
> > > So I think the big question is: when should the subtree be updated ?
> > >
> > > Because as we discussed in the previous GH pull request, if a binding=
s changes
> > > was made in the upstream Linux DT, then the subtree update should wai=
t until
> > > the u-boot support is merged before updating. This could cause a lot =
of frustration.
> > >
> > > And this could cause a lot of regressions, even more if both Linux an=
d U-boot are
> > > not maintained by the same people.
> >
> > I think some of the important questions to ask are, how often / likely
> > are the breakages to occur? It seems like these days it's either:
> > - U-Boot had an early version of the binding and we already state we
> >   don't support backwards compatibility here. It should be on the
> >   maintainer to be proactive in this case.
> > - It's a "the DT was wrong about the hardware, sorry not sorry it's an
> >   incompatible DTS change now". This too is hopefully the kind of thing
> >   that at least board maintainers will be more actively aware of needin=
g
> >   to deal with in U-Boot, if it's really a problem.
>=20
> A common issue in the kernel is with forward compatibility when
> platforms add new resources from a new provider. Then the kernel
> expects a driver for the provider and waits for the dependency. Of
> course, older kernels don't have that provider driver and so the
> dependency is never met. Not sure if u-boot will have similar issues?
> At least you should/could know if the provider driver exists or not.
> (The kernel doesn't because modules.)

I think we'll be fine, but time will tell. And perhaps the more frequent
re-syncing will make any sort of corner cases show up more quickly and
be something we can figure out how to resolve going forward really.

--=20
Tom

--Groupsio=AcPTmMiNvr5Lie5bDcIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7YkwACgkQFHw5/5Y0
tywceAv/SdTLgyhe8sCnAnCxl5PsSBjY4d/MpKCVjWWcGAYWn3lbV3cRV6+DtTPS
8NFBXdQzZaj/Tt/9qa7nXYieBQMqzWWJ8oAB7SOknGTdvGyEpXjeE100wPpQ/pPA
Ch+llUH8Ol6kSuiDB+jUJ1htYCcTpE7+koaMaG3fN0SZE6xjBk1kUnlJg+mRc/fY
JJVzQzjK8n0NTAVVn3qLuAc+JCKG/dVIdzkol8LB/3sWQMXQe73ETVXR3+eTZAJO
uRtSuUG4Q0awMU0fLRdfi0YG0wkJ0g8M2JzD1GlGzI1OalSvVGbOf7qK6bkFgdwY
yh7VWOhHH9h+ON3uZVGNxEy1NPQ0Z0kYUiMaTI8mVd6rnH4NcPrWOeGW8R8guLGR
NaY3WgtziZmlODw4nTIBf9jVmDq/+HkvLVRoj3D5U/tAuJhcRc7Mfiq7LNGaVa2U
UG2UOtMuRFku6SFVfhC4APNTaPCv74+WJs1cInTLE3SXVcAVKh6HTvQeJFed2l2y
VDe8f97P
=4AWg
-----END PGP SIGNATURE-----

--Groupsio=AcPTmMiNvr5Lie5bDcIx--

