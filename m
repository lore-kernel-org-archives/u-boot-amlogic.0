Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CCC4828F
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 14:03:12 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.14801.1706710443776003900
 for <u-boot-amlogic@groups.io>;
 Wed, 31 Jan 2024 06:14:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=J/JLVtu9;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78407987510so127775985a.3
        for <u-boot-amlogic@groups.io>; Wed, 31 Jan 2024 06:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1706710443; x=1707315243; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3W90rjn/izBF2Ey64S+X9R/Q2UfxbQp+wUS5psRRsU=;
        b=J/JLVtu9fhDW+Fq0Jj5xjXwS8fFhNoEDPGLmEopxyJ9jj4tkbWdyha6OOiAqLGArPJ
         74aABxuWIhmU13675HwLf8KVNGs5AQi68aKGBlgl+tjPYx/n+++RYdCZUZJd0a4mUf2M
         IWPHegTwP0dAngqC+8HwDKbhKc0hYcg/NIp9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710443; x=1707315243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3W90rjn/izBF2Ey64S+X9R/Q2UfxbQp+wUS5psRRsU=;
        b=Nbg79j1jTVSjLaowZIdYid6qtDkNyWeVv52a9p7Jy97C2P3RD8r/Hkyk2XiDWiHKSB
         N3ciYqqH+fuI6mllIUdWCi/HhMiiTquic0CzS6b7k5OyVQPk9EEY25UZRw1N5LekPhdH
         SGCkdmyQwtBK7DvybpK8ROuENF6Rtp5P/4QLkmChLYT/tS58M1uPt/jJqWw27uJSMDIt
         0oHW0/GD6SsunA+bvbOBMcs/boHH4cuAqq2hblHpvLR/8nWIYkza3JXB3NcZ0TtL2uej
         k1dLrohL90gPLlLEYdmwV2BblpK5v3o0txKfVNT0vcc0ycNhZLNE7lkLLX1j7SdLc1Qc
         bFVA==
X-Gm-Message-State: AOJu0Yw6Vx1Tld8j/lb2hUuACdGLV7fyUpdafaL8z4YDOq7Bx7h09lgM
	r/6kRlsblcUt4/KcdyY1dobIdt2N0aPKpsmInLtCm5MwfkCu74NSpQwRoTQyGh/kgdFhrHP5FAY
	8
X-Google-Smtp-Source: AGHT+IE8TD5ymR6r6NClD5wfQlHDL3/wlPbeB5a4BSsZw1gUkhwKQgHsWkoM8lqm9GaEfblufxufAQ==
X-Received: by 2002:ad4:5cc1:0:b0:684:6077:f923 with SMTP id iu1-20020ad45cc1000000b006846077f923mr2187489qvb.5.1706710442827;
        Wed, 31 Jan 2024 06:14:02 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id w15-20020a0cc24f000000b0068c55087a1asm2483583qvh.74.2024.01.31.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:14:02 -0800 (PST)
Date: Wed, 31 Jan 2024 09:13:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
	Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
	sjg@chromium.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, mibodhi@gmail.com,
	bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance within U-Boot
Message-ID: <20240131141359.GT1152441@bill-the-cat>
References: <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
 <20240125231933.GY3652023@bill-the-cat>
 <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
 <115d5376-8cf9-474a-9344-223df4ee1d6a@amd.com>
 <CAFA6WYMP0=LOJhHYvXSB9CA-EaSD0+dfxZcb6U0BTgfRiGk4hQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYMP0=LOJhHYvXSB9CA-EaSD0+dfxZcb6U0BTgfRiGk4hQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=uI41Wm9zt7bUobvJuFqC"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 01 Feb 2024 14:03:12 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2096

--Groupsio=uI41Wm9zt7bUobvJuFqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 06:26:54PM +0530, Sumit Garg wrote:

[snip]
> So I did a demo experiment for this here [1] where cherry picking DT
> fixes into subtree just worked fine with the next uprev. Steps
> followed:
>=20
> $ cd <U-Boot tree>/
> $ git remote add dt-rebasing
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-reb=
asing.git
> $ git fetch dt-rebasing master
> $ git cherry-pick -x --strategy=3Dsubtree -Xsubtree=3Ddts/upstream/
> 9de355a75fdeffc26486508107bf644ca2749fdb
> $ ./dts/update-dts-subtree.sh v6.8-rc2-dts
>=20
> If you would like it to be documented then I can do that for the next rev=
.

Yes please.

--=20
Tom

--Groupsio=uI41Wm9zt7bUobvJuFqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW6VaQACgkQFHw5/5Y0
tyzrWAv+JwCM9eINJZTuM2JcdpyAKCxDICAg+KZNG6bYtKczZAkx0lZJFIWLepUW
MqIyqr/lX+kBYYXlOGkGlljBntTOk/XkQKiYAbvbErnJS1CdcxxKMSFYzkRjfHYO
RXn8PR/307hhcd4sQcoR2r8v12MJz4/3bcMTzdMa00Z+Y3IMYalc1ZiD7ARFJUCR
8dlPjGSH7sj9ua7GfvcaOmHj9UTNmwtshaL532xvHfIjYMFEjaN2VW4fISO8P8WJ
nllR9EhctDPwiRsOKAySjZXZ0EUPtOz8Nvh0H83aaeAmjsKAe/KtEwleIT793Vu/
OfFJ0o3K7R64MFtPTWaN+yXJIYrVmHmpCaGHPhm3KKgoSA6zS/TNwApooy9+JjZs
f2mT/ZPsxoOeanIc9LKwcdGqzPDqg8ZlLK2ILpYygrZhwMANZB1cjPgOCvbYKF03
qSgy5BZKI4C8o1L1oymLn8fDDoOe59k9NL/xnh4lOnj7/EWy8OWTosZJbgy58N4A
c9fLhRlS
=8e4O
-----END PGP SIGNATURE-----

--Groupsio=uI41Wm9zt7bUobvJuFqC--

