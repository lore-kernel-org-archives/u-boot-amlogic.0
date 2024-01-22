Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABAC47DAF
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.61320.1705881667869293488
 for <u-boot-amlogic@groups.io>;
 Sun, 21 Jan 2024 16:01:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OAiMk6Ra;
 spf=pass (domain: konsulko.com, ip: 209.85.219.180, mailfrom: trini@konsulko.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc226dca91aso2179808276.2
        for <u-boot-amlogic@groups.io>; Sun, 21 Jan 2024 16:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1705881667; x=1706486467; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLaE2WB6kVRcS8m3/wfMON0NJ3a+gdsPmNnqFQMx2E8=;
        b=OAiMk6RaDEBnDeRizivyaBtW8NHJ2T3pDTWQ3Ki4ie0KK/EQO2mzU8/3Lp3ct0h21i
         Y2A3muAiSy8+TueOTs6wE0HeBZbWrQrVPAm7XGTEmxSrnkXJssAovy0q0S9snH1Fq/ds
         7de0bv94SThTKG3Qk6BSHHR0d0BdWRSqwUtmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705881667; x=1706486467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLaE2WB6kVRcS8m3/wfMON0NJ3a+gdsPmNnqFQMx2E8=;
        b=NTemqKYiqheEnE7e+B4t3wmK4pHyiPU2X+zsVLfeVZoXr01wJ453nDw13JN/FvlU64
         +BRv5QajtxGJM2GqcXJNAME/3giqFA9F7mj0D+qfw881eaXMUwy/H0vmyMOwo1iicRhA
         3VNXYVD3Gm3hP1L1G3BhJGuLxwCxNyAEY3Q/8uy9e0PPkpDwwnMNYHgw7SMj0KwUsEZK
         ae3WKoCOxL5bJVMu+WYCn/b8K6iZMeFH7TkJZNxNnNEEydeAklNIKa/EajFblFLmaFaY
         J/WQ+by1o+LgS9t8EwV2I1y/J4Kny3PlycmwXc5Gj1mW/ey/BfxZmbNeq1t4Bjv2S5jV
         HRXA==
X-Gm-Message-State: AOJu0YxbHKy7Tk9NGlgn9TZD0tfy1FdRc2NswWbvzk0CP8AWQQdJilEb
	s+JhknZwwKydvXo498gjqOb2U+TzX1G/rj+tGpIwxqTktLHnaPR5CI/4hAUXudM=
X-Google-Smtp-Source: AGHT+IHANI/FNMjHOk2PI3xVYeR1BQj7TvPvnwxew6YbO7xjkklffUfR4ACsfMbLYLbC/e14xu3UBQ==
X-Received: by 2002:a25:b908:0:b0:dbc:daf3:61c2 with SMTP id x8-20020a25b908000000b00dbcdaf361c2mr1488469ybj.91.1705881667062;
        Sun, 21 Jan 2024 16:01:07 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id v40-20020a25abab000000b00dc25a265260sm1291477ybi.34.2024.01.21.16.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 16:01:06 -0800 (PST)
Date: Sun, 21 Jan 2024 19:01:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
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
Message-ID: <20240122000103.GE3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
MIME-Version: 1.0
In-Reply-To: <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=8UJACFulPGV1JY7wW5p0"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 22 Jan 2024 11:44:30 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2076

--Groupsio=8UJACFulPGV1JY7wW5p0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 10:41:51PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 21/01/2024 15:33, Marek Vasut wrote:
[snip]
> > Assume that there is some large breaking change in Linux 6.(n+1),
> > something which would be problematic for specific U-Boot platform (e.g.
> > i.MX) or would require a lot of work to sort out, will there be a way t=
o
> > temporarily pin DTs for specific platform to older DT version until tha=
t
> > is resolved (e.g. pin to 6.n) ?
>=20
> (Upstream) devicetree has to be forwards and backwards compatible, were s=
uch
> a breaking change to get merged without prior discussion with DT users (i=
.e.
> U-Boot) then I think the correct course of action would be to revert it.

The caveat is "unless it was wrong before", which happens more often
than is generally thought of I think. I'm not sure off-hand the best way
to deal with that.

--=20
Tom

--Groupsio=8UJACFulPGV1JY7wW5p0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWtsDwACgkQFHw5/5Y0
tywSkgv/d6a4U7YcvCgUcfwm3vPPsG+tRj+F6QJy9AsAe4vPpEfeuHA//nylwj5N
q2XKgIJCK287vw57fgm0BGQX34oaLTbhFnak0yoe9TNRHd4QWLnXku9DclCtAWWU
T/rO0JnuvU41hpTJW2IN4+SU4nKslNSuKiwU4kn8k8TqZwfsAm4GQy9fqNZpglf2
aq7C3Lo07UbXEUXLShOopfbS6/NpXG+x10UsD0FLPM9YQslDXxnHABhODyKvOjba
lqeENQjRNOWHl1pgy/gB4yp65dWdsUaRmhRdI79IqWUFsA8162/v1eUNFf5zJzXf
7vtWoZ89QFD9QNYN/67SFTiCODF07MJgH9MdF8aW/XFrKbeJOg0d9KDULLG3x/1p
NnELJKu0ZhKQnRgHJOJVFUeHV1uqsGg7lSdtlfbQD+JraAvLRoRhvaV8BZfSoawB
NGbeOzp/zeF/6o2KqsomXvDKQVEYStEQjZwBgoQAKNzCxTld/cp8UVW29ieESEGo
Eff/Upj+
=PIBb
-----END PGP SIGNATURE-----

--Groupsio=8UJACFulPGV1JY7wW5p0--

