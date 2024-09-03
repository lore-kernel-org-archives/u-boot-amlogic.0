Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC1CD379F
	for <webhook@archiver.kernel.org>; Tue,  3 Sep 2024 16:35:51 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.25885.1725376313266210190
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Sep 2024 08:11:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cxyzDuHl;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a8134aefe8so224636485a.2
        for <u-boot-amlogic@groups.io>; Tue, 03 Sep 2024 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1725376312; x=1725981112; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph1LJMHsmtpatXAcm4sqHv2XVNHFuzrN/NCdoCiW2YM=;
        b=cxyzDuHl/dEt2azusDbpYn2zBUJ4FRr7FRVrgFUNGqt8lY9dvQivZMrVGCWSaaAN2g
         rxhiPBPIi6kGQGZ4LF11QsF1msn9vCxYew0QYBSv03yWZqWmqZ2ydpNX9HOMdmE7lUna
         FZZknAOOAAMPiZz0pGXG6wEIw5Mz4rmCLjNeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376312; x=1725981112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph1LJMHsmtpatXAcm4sqHv2XVNHFuzrN/NCdoCiW2YM=;
        b=c8KeB7mCszvmA/+WRp7tl3GaJEki81sBSsNNUU7N25YFTrbadfvmModuRmaby4+K5Q
         aeD1MlaMsTdegLBTvk6EAp524K9CI515ql0kH3RuQ8R8BrmtzB+vmSbQ7+166Lijzees
         zl4c3AmdTH+aGxmRykv1HpQX6w22KCTuexw+/AimwtPmKDkJcdGxRfLOjrymbtNIhPuA
         9aJZiojtTBlArOHpO/DPuSoXprIRKG5I9Aqq7LOBV21ztOdaaAGwQJXWLotN5Wm8LTFR
         6FyE9YkqC2/cJ53Yee3ZHXWU5YITXhkhfeBp8L9brcH3tw8S+V10VJMeb0nJF22wMk3w
         k2Gg==
X-Gm-Message-State: AOJu0YwTt83mkBgwN6M1Gc29I0jkPNmdqDyfZI1KMQ8OV3jOwOy26Bth
	sTyTgjcARrwiM2N8n4KO+vHO+28VGB9tkEG5k0XI1nnXrNnWqpsK7WnEWJ2rqyw=
X-Google-Smtp-Source: AGHT+IHRd9CngohIGbaovJEUmMpGZmleyai01T9cbS5PEXOHHbuD21I8yus8SQ2M4oXxsapr5XXELw==
X-Received: by 2002:a05:620a:25c9:b0:79f:b72:fb30 with SMTP id af79cd13be357-7a8a3dc7929mr1157600185a.59.1725376312177;
        Tue, 03 Sep 2024 08:11:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c2418csm538508285a.29.2024.09.03.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:11:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:11:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240902
Message-ID: <20240903151148.GH2479150@bill-the-cat>
References: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
MIME-Version: 1.0
In-Reply-To: <024f632a-8139-4673-bbcf-0b8e5b633624@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=ykhcnKS1zZnUJztfUYj6"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 03 Sep 2024 16:35:51 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2384

--Groupsio=ykhcnKS1zZnUJztfUYj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 06:26:20PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A simple set of changes to allow using the bootrom NAND pages, ported fro=
m Linux.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb40=
74:
>=20
>   Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-08-24 14:03:28 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20240902
>=20
> for you to fetch changes up to 35ff967a99e97b523732096628bdbc78758922f6:
>=20
>   mtd: rawnand: meson: read/write access for boot ROM pages (2024-08-28 1=
6:05:45 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=ykhcnKS1zZnUJztfUYj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXJzEACgkQFHw5/5Y0
tywzngv/XRAluRlzkXAghrf+m3idRDnHEK+JMxz8xb1sFFZbcrdtSRE3OpC4bid+
wmkTHWihBa8pXlQJHG2sLX5fuWRDSi4tWZ5Ugu2mWJ6KMedQRM9TdYswi0C+XI0U
Zaf0WO15+ZmK8iLYPbH8VWEow1FQBQ5Ritm/P9EHEo1QeKBKmE4vROSsTtCIYEH0
MAJFIgS7S7aiRrg1GxG0V85xLHzKYdfNJpTLiKpWSarZHC7jSxwSYdyMoJK2T8UH
xkE3uDaWlyPlLa499uEYuiHuOJvFJi8wB3Q7Iy9i0Lij+3slUCOuI0GXYU6/vVI5
tTPlxPb8vtll+NrMxhDsMskzgpFxaDWITb2F0FjmqIBL78GiOkqUuVHFnXPwDWHX
teeQPcqq3941UaksVoS6TZuhsPRYI1oTOT1qGKmYINIRNr2v7+hsO6vR8VigGoCn
UiAKKRhnU9yge9YfNL6CgkcUYWz04t0aER3R9Sgd9mBDUKA6OluJO/n/VVD1g1w0
NYvNBrWi
=R7zy
-----END PGP SIGNATURE-----

--Groupsio=ykhcnKS1zZnUJztfUYj6--

