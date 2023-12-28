Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F46CC47422
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:11 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web11.123201.1703772632440752478
 for <u-boot-amlogic@groups.io>;
 Thu, 28 Dec 2023 06:10:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=c9eRo97Q;
 spf=pass (domain: konsulko.com, ip: 209.85.166.54, mailfrom: trini@konsulko.com)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b7d55d7717so279053439f.2
        for <u-boot-amlogic@groups.io>; Thu, 28 Dec 2023 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1703772631; x=1704377431; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njh+aNp27+6eT5lNaMpgrVp0TK1l2Qz7DEouTHmZZNc=;
        b=c9eRo97QvjOxBqEeAzBdSJq8NKhGispGQ2O7RZlPycamaiX4F/TAGJm69GP1uhJ+x2
         L2hBoK7o1RGiJxDW+JWQq+IgfgRshtkQflfuna7b0s6oRbpcovLtfw9YWMd5w6fu0LTY
         ZZ4z+2qlRmTP1LMA/R3dnfT/OagQXhd8xF8Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772631; x=1704377431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njh+aNp27+6eT5lNaMpgrVp0TK1l2Qz7DEouTHmZZNc=;
        b=hcHI93FLwiapv+ExYDX3qJfDWwXYTsHVwACyYWFiuSVuSKy5a8mEoW6MS47TtjI6lo
         hdzjbDHbT0r/I33WQowT8SZqga/xdAfdv6efWhw2OLZS9wgBr1Dup/kSxSDvqiFWxkHR
         KoTewMOev8iXUplUoybtU7TNji+076SEqCEqwCLuEbUBd5VyeiZT5rhDohVuQ9VOgYee
         cSdh92miHF3CZlCIKjgqxwnQa1RbuEaowKoagoupgE01bUmpAJz69bya9TgLxcekIvrq
         VIzgxvqXuis0ld7WEWvfK2KL/Q1oRDh/waoiohhRnEIbuY94CnrNV0bt7GhkFmeTsDbn
         Jr5g==
X-Gm-Message-State: AOJu0Yy2ySLtyqaztJJ/XRl0BXAmMmqzFxQYKqjet5x72d7EZjoIFxmZ
	fhzM98NDo7Ahp27QsKnclZmS50hqtmsQ1A==
X-Google-Smtp-Source: AGHT+IHul2zGf/joRFQUaDfZ1+mB82NQf8CRPY2VtuzgZ9n1EjOdempm/7XS5UAUtbJRRtQ1ze7lNg==
X-Received: by 2002:a05:6e02:1445:b0:35f:f59d:f132 with SMTP id p5-20020a056e02144500b0035ff59df132mr8854393ilo.34.1703772631562;
        Thu, 28 Dec 2023 06:10:31 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id x125-20020a818783000000b005e868b1b395sm7436888ywf.100.2023.12.28.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 06:10:30 -0800 (PST)
Date: Thu, 28 Dec 2023 09:10:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
Message-ID: <20231228141028.GC2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAFLszTjW8FBYtcb-kiZ-8rUdgMd96KgZWufh1ig+mQ6wq-sGgg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFLszTjW8FBYtcb-kiZ-8rUdgMd96KgZWufh1ig+mQ6wq-sGgg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=UziaNtDSzFuRxNnu4IaC"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:11 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2001

--Groupsio=UziaNtDSzFuRxNnu4IaC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:09PM +0000, Simon Glass wrote:
> Hi Sumit,
>=20
> On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
[snip]
> > @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for cre=
ating subsets of the file.
> >  Where do I get a devicetree file for my board?
> >  ----------------------------------------------
> >
> > -You may find that the Linux kernel has a suitable file. Look in the
> > -kernel source in arch/<arch>/boot/dts.
> > +Linux kernel Git repository has been the place where devicetree files =
along
> > +with devicetree bindings are stored and maintained. There is devicetee=
-rebasing
> > +(dtrepo_) which maintains a forked copy of devicetree files along with=
 bindings
> > +at every Linux kernel major release or intermideate release candidates=
.
> > +
> > +In order to maintain devicetree files sync, U-Boot maintains a Git sub=
tree for
> > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is =
regularly
> > +kept updated with every new kernel major release via subtree pull as f=
ollows::
> > +
> > +    git subtree pull --prefix devicetree-rebasing \
> > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > +        <release-tag> --squash
> > +
>=20
> This is an internal detail and I believe it will confuse people. Can
> you put this in a section like 'Resyncing with devicetree-rebasing'
> and explain when this might be needed?...almost enver, right?
=20
I think this means the wording and sections need to be clearer, in the
document. It's unlikely most users would need this (but I can see
downstream cases), but I need to do this at least once a U-Boot release
cycle, and I want to make sure it's documented on how to do it.

--=20
Tom

--Groupsio=UziaNtDSzFuRxNnu4IaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNgdQACgkQFHw5/5Y0
tyypzAv/WiiZe8q4rknbg593JPwyIO8Gwf1lbP6VJ0G+WuJYXTRskajVOzcRRHRs
m5613Vd6FpzCpMdWUuUUGYnWNWniS+y6+RevdJCg9NeB1lrrrytu78c+CUfc4TyW
gO3lrq05b2ZddNY4HmQUjt/HKTAzbmAexxcyI8fxaFlLrfijLJ9aqlqLYrJgRBEp
+XpEvCRwxZXtPJx3mjmz9mzzh+izVJ5cjMHMRhVwFOlnFdImucfDpCW3kzISkqWb
2LcG23lGJzxSvRd7I0vl7TIu2tyeZEdPJW6vuEmuY66+0gb/IwpWESN8KAva1H+3
BYglO3zLy8V7wh9MQcKU94IAPFT2Pv3R8Tu9xcpnx+Tgm0X2HLN+vS9W41oDaypg
yECUp5z7O2JXZIxGkXxubZ/oI122c2JF2m6ChSOhFzVDhYk4NYZ95hb3kS4aNxSh
BjaYu3vrBoUN5TIUgl2cxv0NLne8e/qAupITmXdVT/gg1ES2ICOJ5lsXYNM7CCxJ
p3BPDQ7W
=l3Pi
-----END PGP SIGNATURE-----

--Groupsio=UziaNtDSzFuRxNnu4IaC--

