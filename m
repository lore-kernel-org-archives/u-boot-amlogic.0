Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CDC48BC0
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 08:45:54 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.2264.1706896958714622284
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Feb 2024 10:02:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Gn7MH/A+;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c427136b0so11948346d6.1
        for <u-boot-amlogic@groups.io>; Fri, 02 Feb 2024 10:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1706896958; x=1707501758; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ikCoWzu3aYA7x3gUE8fRZkoqiwKJc4G1nAp4b+pRdwU=;
        b=Gn7MH/A+PSNLi3euXpt4q5Phq/N8i+gqXR6ewbfqZPMJjwKuBbxFlKlAtaCccT6khG
         a3PLW8+m9SWHJrhlChxLMIFcMjkm/qMLncmejhues9qtTpOr//VYK/efa+mTEBAxqiPl
         Sj7ZVsvSg547V1KNihOwr7J/qAxx/35nv7+rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896958; x=1707501758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikCoWzu3aYA7x3gUE8fRZkoqiwKJc4G1nAp4b+pRdwU=;
        b=QbkPzQYPikFwfapSlNGTOBPkb5SVlmm2nyP+LepqxLn6rqBHfiLyKOquVvmAo2458w
         EINh8W9hpKNr6j5rNsWnEdCfBQsK/RVTthT6oBTah5n41SrGrA0APwqXwvs5e/ArlG8U
         S6h/x6urfcE7p5gAgIxZ778d9242QeiexJpYMOrb2fMCMYcitH6CnqeedAblfE5L42qP
         OVK5FpuqtJPJP44wQdnjniYH6sO3c8bIsr721k1bIiGTBp6NW/WYap/47nNOB+4NruyP
         LNPX90m+bk5SKBtSLo+vcCdOFIC8RrGqZGVKgmOnuLCK02KQDTyyGMeAEjszHl7HNqMu
         f0iQ==
X-Gm-Message-State: AOJu0Ywyod9CcdBIw/KT4DBVNXRVKXf36U509fqK9rx45t64drIRtH1I
	YVedbNarxqeqEHRjeiTZsnRFDoH8R84KVRLP3CfHVsPL56GDI1rejbxEewub6+fS5zEblkvETXA
	0
X-Google-Smtp-Source: AGHT+IEL6a+emR8iVTn61JN3UiFucOkdPsKv/VPusMoWlgEr1PM/7xxyFuB4O8nB5kllUMmX6tTL3w==
X-Received: by 2002:a0c:f281:0:b0:68c:8a61:fd2d with SMTP id k1-20020a0cf281000000b0068c8a61fd2dmr1373108qvl.2.1706896957666;
        Fri, 02 Feb 2024 10:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqYnApDsIbF7+SQWcdA8wxQ0Vm7lWpvtHafg+9lcD4KhLCSZLkmcx6WHuPVghYaKRnd2UrIMopejdGV8USsvfYo4isfXlbSIYufr2S3D7/kD4H84P3FSsfpcA+dfFaMnJ5z1OPdjtAtOxR+T+OmQYC2gSekY4FWne3mKbFnHQQcnjiFeZC4x1CCJ+prrOYf2vEWavYrabUvLnf0rUuOaYHehHFK2btABp21Tefdzi7ciarQNIhxoJ2mtpWzez4mXLXSA5ttaBL6V9/syHcuGc8+11qBc462lVrdR41PlBiMS29jq09BwlK6Y1GnPxGMW0FE17XU5kp9F9oQsyWx/fEdgI12TkPlijiZIM9e5NrwmreW310yU879GLL/+yXQAlKkta8wPpu55uxUFdwY91Fk6WXDLhlrDjPX6PqYkmpd/nkn11GhvWJ6pNOcqNXEb0he2ebRUCNnwlZsz1INb46G/3Wbpj2QWTYM3GHN8orF49jyubEq5fHvA8nETFlG5DVMtqzUlL1JuQFWFRzHhaFeJW+geH0WKBdMAsQueNFncmM6mpZNbBe+AFomF6gCfKlBsu2xw0NiLqTvm26OjLokzKsxwJnh2/ayvP3d8TDHRebuLziLfjCbAaq2NVfCTPlm6es0/2UfJnEvtQbkhMkTH6BNb2NVm4fsSRPE18Q4aYl4KqobuaXdp7T+I6v+qx++JD6P2JfURSwu9X9I2z4iOBk4ZgSqk3PzJG9/cy5Qv2PBP5hLdPUAbpMmh9SlhMQwIQVa84pDhG92G3S1TBcxuYGQXoUze9rzZrBedm5LYrqA3n6CxVPE8ehNnfbyYoRHFDu91D7/D9MvD3jklInAmmyOYviz+mTyoOR04CD1ypJ4HdCIrEZ3b/x7LuYVA5olA==
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com. [2603:6081:7b00:3119::1001])
        by smtp.gmail.com with ESMTPSA id qq2-20020a0562142c0200b0068c8b31787bsm327048qvb.139.2024.02.02.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:02:37 -0800 (PST)
Date: Fri, 2 Feb 2024 13:02:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
	festevam@gmail.com, nm@ti.com, andre.przywara@arm.com
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance within U-Boot
Message-ID: <20240202180226.GF1152441@bill-the-cat>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20240202130534.1051438-1-sumit.garg@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=g4LY8nIiKMJehGdKDBZg"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 05 Feb 2024 08:45:54 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2111

--Groupsio=g4LY8nIiKMJehGdKDBZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:

> Changes in v5:
> --------------
> - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> - Created v5_dt branch for testing purposes:
>   https://github.com/b49020/u-boot/tree/v5_dt
> - Patch #6: Added support to cherry-pick fixes in subtree update script.
>   Also, used https:// instead of git://.
> - Patch #7: Fixed inappropriate documentation update.
> - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
>   tree.

OK, for v6 please push this through CI. I've started a run now to check
other things, but just sandbox currently fails to build right now.

--=20
Tom

--Groupsio=g4LY8nIiKMJehGdKDBZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW9Li8ACgkQFHw5/5Y0
tyxvZAv/ft70KJ7IMe6F7NhgZx9lco9F1vb/PYGDoB6LvMfR8g0NhUVJdR1KMIXe
bLPAzQH761Zwa5OSyOJjiv3kCMPKSmcFXaSlvaHurLpIHhEN3600pXOeEIbBHRx9
MrzKPQ2ITZChkwpvuxJKYDeDP+54kOXPGLyM+en6Z+KaDDuaa4pM50hvkCB7o0fV
LalPr46rUoT3/J2alHFhgNtT6EOMfwg0kFPDkmNtoMkst+aPDTvDS76Sdprj1usO
VOpfr+b+JUdDT0r+iSMyX8j4eKEhxoZmGJkHbnqGK1nARZDDrh3gvPG1KbLCGmpT
Iq5nxpTSiGVqdr9xu6o922kTt+PQ/XBsyA3WviO8wYj0hOLFmwWVPBBx670rPlme
41bOGoW8Q1hXpSTJDj4BShvskZZt3Oza92LOGY1ojDVCg2E8MkDoXsHO0qp4eLBQ
1dC/fBK93Pcg/UDET2mPYMi8CBiDu914FqzOvNkKfcoMphZzJ20UqUWAVO2b4QFY
qMwPAnSZ
=Locy
-----END PGP SIGNATURE-----

--Groupsio=g4LY8nIiKMJehGdKDBZg--

