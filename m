Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CDCD11BF
	for <webhook@archiver.kernel.org>; Mon, 25 Mar 2024 14:07:23 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.52653.1711374703600821165
 for <u-boot-amlogic@groups.io>;
 Mon, 25 Mar 2024 06:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gzAEL1/0;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a2290b48eso349743385a.3
        for <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1711374702; x=1711979502; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdqewitPjkQnwUMvABUV58bfo0FHWqi/mm/IVHh+ZjQ=;
        b=gzAEL1/0YQb/VlQdJyGCkciDyZJkb+Ha3aTjHUA6ZnBvdVxtOMysvZjQEpVYN6M/cv
         nOrVthdE2K32L6f5VHM6bc/BVG1Z1WUy4STUVjw942JLNHkFFy86Dq1PcXw55G5lKrE5
         jD9DTxjSxEvLi6U5WkS2Bhh676qV2p1a51cDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374702; x=1711979502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdqewitPjkQnwUMvABUV58bfo0FHWqi/mm/IVHh+ZjQ=;
        b=geBmWMmSMyXkXCICWO5r1RDomaTEWjHddnFnBjX928QqBqU/xwMRYDTF2b5OLioO7N
         iZcARHVpBR6vMMTXKVY3Zt2AhuxuR6+YAOW8MfmKlh4A+FeKQ+4XfWiQLx11XjXssb5m
         xsr3OURBNrRtPBdcwQwmUGkkQU4bx9kBBZ7hZKot+b+blkFs5SCZJZfPzUH36CXYp3r9
         YRh+eKnFvU8OKep6uL7OEnVZ2z7uIb7c7B9Ee3zX/d+hhQ0rdduY59xLn5aFqWSPQmdK
         ajcZZvtSkgsC/7dRqaen+NJw+w3HQRJqcOgC+7Gi5k1ymOLGoZwfl6vktYaztoqeLBof
         XsoA==
X-Gm-Message-State: AOJu0Yywm9GR2LZqGBD3yCzlmhWcqeYTZwfSFB+GDF0iraYep5PDGQ7+
	20KlF+XBdO4DKqDtBOyHZYqUm/QUMgwFD75Xb3t3PHcaCRA9d0/8MyJgY7SKd5N3obZWkGbIP6K
	6
X-Google-Smtp-Source: AGHT+IFYoQhE/hr3z/iQPdAOG5TahMIqBQK/oYP8eyQqMD7lmOAyAMhWsMUiWOX2ZXD5m0Qa1mIKsg==
X-Received: by 2002:a05:6214:1308:b0:691:e21:736c with SMTP id pn8-20020a056214130800b006910e21736cmr9252973qvb.30.1711374702646;
        Mon, 25 Mar 2024 06:51:42 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
        by smtp.gmail.com with ESMTPSA id 15-20020ad45b8f000000b00690b21ff926sm4103245qvp.137.2024.03.25.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:51:42 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:51:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-fixes-20240325
Message-ID: <20240325135140.GD3442575@bill-the-cat>
References: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b3c9af94-9b6e-4dd8-b5f7-7a59a3520e24@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=kn8VU58Iye6a0uNPXuIQ"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 25 Mar 2024 14:07:23 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2247

--Groupsio=kn8VU58Iye6a0uNPXuIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:45:43AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this set of last minute fixes
>=20
> Thanks,
> Neil
>=20
> The following changes since commit bd0aedde3ea3691616c17c720e2d25351308c0=
a1:
>=20
>   board: toradex: verdin-am62_r5: Increase SPL_STACK_R_MALLOC_SIMPLE_LEN =
(2024-03-22 11:10:51 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240325
>=20
> for you to fetch changes up to d54f87f09a36ac20154955297b7c999b368b0443:
>=20
>   board: amlogic: fix buffler overflow in seria, mac & usid read (2024-03=
-25 09:16:19 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=kn8VU58Iye6a0uNPXuIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYBgWwACgkQFHw5/5Y0
tyzRMgwAqXs1Lo9/UyO+AZHbXT3trxezE7nZq60Fbvm+cFKHct0St32AA/Rbve70
14MMgfPp/7MCOr9Dtz+M989XyhTRcwOprAg26BhKKiF7ob+Zjm2001Xh/QlVagJ9
ilsjFXOQvZCogQ4UNomv61Vw3DaKgtCLHUybW1sX9/PAgKslukA1PsLnaUhyeAgW
beEDygF+pyRqxebWSYseh+YiV/ffZHSfnyicXQH2sPrZnlbdWChs/C95Tj+OeC91
JBQgeUcP9kiIzJ84tl2gWf27UE20t6S1wGPuWkLOOmAALAr5dUy0Fd7rt9mUNxnF
Xk3IxLnBIct9XES5tCC7LgRkVxXKDOTi/Pa1zKwPqp6DOTPmTWLU7IlKRAoU0Jm6
axqQpBQVNVyGfkfz/VSm2l43wpg7i/XHeGCraiV1ahtFR85LpZuqd3kGsCVhHZBB
SqMGQe5bcX34IXSazUXs3AJS8unpoN7SrpB8fdhUoJC1P/v4g7Ef/qhi/msYI8vW
vg7LGKiv
=wRQh
-----END PGP SIGNATURE-----

--Groupsio=kn8VU58Iye6a0uNPXuIQ--

