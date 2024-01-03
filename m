Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F2C48288
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.17136.1704288235851360482
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Jan 2024 05:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Er4acTtw;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680c4475b8bso7091176d6.2
        for <u-boot-amlogic@groups.io>; Wed, 03 Jan 2024 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704288235; x=1704893035; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBM8xf6Pst9Vw+gDDwC+iZqU5Pa/v+w3tl5tpStgzxQ=;
        b=Er4acTtwwmPof7XO9J1x3x5dBi4QeWaCnsticMSB7or0qnbNonc9JKJfYuV3ijP7rw
         5f5mq9YI+eupkZkaqT4f8MfYyZSy2YcCKQWpDoRoVYpXqdymICTivX0jh1o6tGmvYbBq
         iILV+Szx6Aa/9PQeyv3Y2eSpYv2PvBRIfM5xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288235; x=1704893035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBM8xf6Pst9Vw+gDDwC+iZqU5Pa/v+w3tl5tpStgzxQ=;
        b=l6bsfUTBm1rE0G4kse+fB0ASWU+qhmnCPvs/OKQR5eTKQvYacA2uvtbVsnbDT3yGM8
         eihyq6nfLVuPCqn/XxotHSUbr5GWRj+E2Jydw4xCDCTh2NPKddUs+s9D4enFykXHGh0P
         w0kAM3ufNXrzX66s2xpJiAoKxNZSw9fUC47xjrDLsCM5UoBME+D8i7BuJtGA1yJt8uhG
         Zm371T0TlXvSc1FzksRUXW2ObpAgk/FEWyXBiT3cD525HV8qmWwepBTNT+UZTDs3VsPQ
         poUxW1lI0+MxiGF018aIcGzWyhKcH2XcoupADULQUvWbmqsjubQxnqjHElZOEJHnQeYf
         VITQ==
X-Gm-Message-State: AOJu0YxQbom/4PAgQ9gQ+9mp7eU1TxogGKrMn1cyepnr7l7QPY82WKrm
	RlYdARRQtoCIGuYiBlFoLGTsHzx+RCL1Lg==
X-Google-Smtp-Source: AGHT+IEX90VHBcrHhcxJM1nGmEDSt0eNw1nzyHyhoANaNhS6zbuqJYljavqw+5iZ2Os8jD0JQjO9Kg==
X-Received: by 2002:a0c:d6c8:0:b0:680:857:1bb4 with SMTP id l8-20020a0cd6c8000000b0068008571bb4mr14389645qvi.120.1704288234914;
        Wed, 03 Jan 2024 05:23:54 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id qh1-20020a0562144c0100b00680d39626fcsm8344qvb.47.2024.01.03.05.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:23:54 -0800 (PST)
Date: Wed, 3 Jan 2024 08:23:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
	u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, caleb.connolly@linaro.org,
	ff@shokubai.tech, daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org, pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB builds
Message-ID: <20240103132351.GG1610741@bill-the-cat>
References: <CAFA6WYME_0-s4aBbaKOS3Q+q9+5553qSWcL9pDMvC9VaAfAz0w@mail.gmail.com>
 <CAFLszTj0ptH7K2Y4Fc1FR1_OmK5OzAaAReR1KT5R8OZvbgrP-Q@mail.gmail.com>
 <20231231203953.GG2652760@bill-the-cat>
 <87ttnxlwon.fsf@bloch.sibelius.xs4all.nl>
 <CAFLszThKEW7rvkfiV=Y_bYtBCC2=Ue1vKOnb4a+EN4=EEYNfng@mail.gmail.com>
 <20240101233545.GI2652760@bill-the-cat>
 <CAFLszTg1F6O2MZh3Ui_ux_aQZkzvx_eY3HprFDqm0ZETwYMGfw@mail.gmail.com>
 <CAFA6WYP5Ko+VJ1MLN3W2Y9-B2osiL40PcMpqwiN0=F-k=FowjA@mail.gmail.com>
 <20240102180643.GA1610741@bill-the-cat>
 <CAFA6WYPfey+Si29eGAyaUaiacCBwGBR+f3+o8hjFRSU_j504Wg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFA6WYPfey+Si29eGAyaUaiacCBwGBR+f3+o8hjFRSU_j504Wg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=490RxynfYUySLDU343hO"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2029

--Groupsio=490RxynfYUySLDU343hO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 12:27:24PM +0530, Sumit Garg wrote:
> Hi Tom,
>=20
> On Tue, 2 Jan 2024 at 23:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jan 02, 2024 at 09:07:48PM +0530, Sumit Garg wrote:
> > > On Tue, 2 Jan 2024 at 19:36, Simon Glass <sjg@chromium.org> wrote:
> > [snip]
> > > > 2. Choose a directory target for devicetree-rebasing. I see that
> > > > 'barebox' uses 'dts' which seems better to me than
> > > > 'devicetree-rebasing/src/'.
> > >
> > > Actually as part of this patch-set we try to reuse the U-Boot 'dts'
> > > directory (via dts/arch/arm64/<vendor> soft links) since it was
> > > already taken for U-Boot specific DT Makefile. However, I am open to
> > > renaming 'devicetree-rebasing' but to me that sounds more clear that
> > > we maintain a specific subtree within U-Boot.
> >
> > Looking at what little is in dts/ here today could we just use subtree
> > and pop the contents under there, and basically ignore the
> > project-provided Makefile? Or is that not really worth it?
> >
>=20
> If we really want to avoid soft links then I did try to add the subree
> with the prefix as dts/upstream here [1]. It works well with the
> downside that we will pollute the subtree source code with U-Boot
> specific Makefiles [2]. However, the subtree pull works fine still. If
> this sounds better to you and Simon then let me know I will use this
> approach for v4.
>=20
> [1] https://github.com/b49020/u-boot/commits/use_dts_dir/
> [2] https://github.com/b49020/u-boot/commit/90eabe614e77bc30a437e7d5559c1=
ac414ac07b3

I think the symlink stuff was part of what was making it more confusing
to add new SoCs to OF_UPSTREAM so yes this looks good to me, and I
appreciate the demo commit showing an update is still easy. Thanks!

--=20
Tom

--Groupsio=490RxynfYUySLDU343hO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVX+EACgkQFHw5/5Y0
tyy61wwAhrYTcyzinZPYNNlwNwL1+CevGl/YHfLDGZSWdatx3UdAYkH42RHYDMod
Hxw7DKZ4ghldohR79eqkuDYrjRX+pFC0jSoWyG2TnoUeYgxWeyOcZjGBk7nb1KkK
Eia2v9j+OkBPpLjzQmdPLUs4KRgalQsyrEAbRJPgywU9zFVL+luoUJv2zIeWAvET
03zvCvmazJJPfURRs3OxzM/WvN5zotchQfmYJL3BbtcCkIWrXIxdBBkrKIgPjIGA
9EvXTZ7ySuNgg+fuOUJEayGQsHv0Jf+Ji/MOwJdc6mq6gC262SPfPv/4GGtYTldu
GVWkRAYKHq6+FbX39Mm1XQOeMM/GsZnCgjUsbrnR0OSN57vjb+5pyIprKWE6wnGp
/ACMHMl3FHFVONhe5hyyiDV00eFTPAuG/zaLBkgsWiHXisEjKojxCH42tc/NP/kY
PO/MRLofhZyPnpRM44onizNwe9we1KiVPRm2prSXJTSDWI966bnM995krLg6cwe9
9tUYjqOy
=Skr5
-----END PGP SIGNATURE-----

--Groupsio=490RxynfYUySLDU343hO--

