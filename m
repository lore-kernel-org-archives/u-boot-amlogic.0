Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C575C48277
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 08:14:33 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web11.21641.1704299526842405981
 for <u-boot-amlogic@groups.io>;
 Wed, 03 Jan 2024 08:32:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JbTuH+sf;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42836ebe0a8so4831531cf.1
        for <u-boot-amlogic@groups.io>; Wed, 03 Jan 2024 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1704299526; x=1704904326; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrnFlq3WzJ7E5rmvtlT/0PV/VV2iMFOCKXpIUUuO6x4=;
        b=JbTuH+sfM0+gGMXW4swQo38hHXvvmmH8i5pLAc+GBmFsG/yoEP8mB+GDVNfgSSmg/H
         A94mjyQgxzSLfaPxF7cSxwQN+7aAvpRvmEQk7y8yuU2OOvJ2e81CMPTx+4oZLJazrvMW
         Pe6qXsWR6M5Zi+CkTwepmmsPpY8AXXi+awShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299526; x=1704904326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrnFlq3WzJ7E5rmvtlT/0PV/VV2iMFOCKXpIUUuO6x4=;
        b=jNiEUMspqF/58lt97aIia4/SOKg/6Wo2cpPHFwjrNKhpcul1GjT3hyx68Hgx45KQQ8
         dOzMehFSaEnawCje6+N5UaGK5YjrzsNiAKNdrOXe6pJw+aMpVKngYIXNqRyY49acl77B
         /41adf54B0+BTJXDJVb0A4ojlbyj8pz/0EchsREEyoUx15co6sjeoqXU4kfWT2YvIp8c
         yNqT8fP+hMwZRa9ez83IzG2A3rc1BHXf0+CbvSJV3S2Q7TEmM4+nUG28losy3GSvOFUC
         QPPrm/sfpZX0DG3t7TRGzuxfjRRRQj2iiFKvwTpoUqvhJ1hxaaTZ5GJWgykqwFMR1r9z
         lAIw==
X-Gm-Message-State: AOJu0YzYsefEbFmn0Eh8cJO9rJhXDowPQxWy4ISNr7VgmcMG6aug4G5c
	ajYrI0oxg/OZF6ArrteTWb2eX8LGBwkVEA==
X-Google-Smtp-Source: AGHT+IFWKVxwaXEaZqBekpJSGUmqMkZnZk4DvcRe9G0zx0/HwdeZJbCrrO7BVZtmWFo0ReFO9jPZCA==
X-Received: by 2002:ac8:5d42:0:b0:428:1837:bb8 with SMTP id g2-20020ac85d42000000b0042818370bb8mr8438346qtx.127.1704299525912;
        Wed, 03 Jan 2024 08:32:05 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com. [2603:6081:7b00:3119::1005])
        by smtp.gmail.com with ESMTPSA id y8-20020ac81288000000b004283435fef5sm1402465qti.34.2024.01.03.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:32:04 -0800 (PST)
Date: Wed, 3 Jan 2024 11:32:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh+dt@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	neil.armstrong@linaro.org, caleb.connolly@linaro.org,
	ff@shokubai.tech, daniel.thompson@linaro.org,
	dgilmore@fedoraproject.org, pbrobinson@gmail.com,
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
	b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
	seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
	jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
	mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing subtree
Message-ID: <20240103163201.GL1610741@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=F4aeTERquNc1AS4tHmKC"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 08 Jan 2024 08:14:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2031

--Groupsio=F4aeTERquNc1AS4tHmKC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
[snip]
> > +In order to maintain devicetree files sync, U-Boot maintains a Git sub=
tree for
> > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is =
regularly
> > +kept updated with every new kernel major release via subtree pull as f=
ollows::
>=20
> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> had in the original repo). I don't think it's relevant.
>=20
> We're not likely to regenerate the tree, but any clue what 'git
> subtree pull' would do in this case? It could happen if we switched to
> git-filter-repo.
>=20
> > +
> > +    git subtree pull --prefix devicetree-rebasing \
> > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > +        <release-tag> --squash
>=20
> I'd put this in a script to run. Documentation tends to be not quite
> correct. A script could also be smarter and figure out <release-tag>.

Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
something using subtree, I do hope to learn some lessons from what you
do there. The first thing is that given the size/nature of the commits,
I had figured I'd be the one doing this as a subtree pull+squash then
push, rather than posting to the ML since it'll be huge and
un-reviewable, but with a note sent off to the ML that people should be
aware the next sync has been done and retest as needed. But Sumit, were
you planning to do some of this instead?  The second thing is that if we
move the subtree part in to dts/ instead (where we will still have the
Makefile/Kconfig we have today and then our Makefiles within the
directories, this might get more complex and so really require a script
to keep it from getting error prone?

--=20
Tom

--Groupsio=F4aeTERquNc1AS4tHmKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVi/oACgkQFHw5/5Y0
tywF4wv8Cv8VwZUmNoNGn+CVaQS7mVoUPKfdE7jjURICGdCzyyr/VV9Y4OyK0wAF
9MbFtVq/xI357dY9MXVbo4oigm2b8g89P41lalE6xiNC+dtfGWhSsTANobLKhPXI
EdPe5NM/r7tETPIXAfonjJGiMY5ejjwernsDiJuOb/RCmEApbdcoE66lilc192T1
V667ITnZq4dlMXfhzCjZHPaHxc8ByE7H2hrZuPe75Kkg/XQANb9Lco9KWd8/fGhi
v9C8E50DXQLz83X+sYhQar9BxGaQGTqmKRTavqlACxSBdLw8VJnVcBBcG+OM+oER
QQvuyWHWu8NVMQaoskk4/RUTClRle+s1cq2hyrqV9LspJS0jpa0pYLTWfYCVW0VM
5JASAjJZH5qjuQEjB8q1mPo493RqZr0MaClwz5fQE2BMwXyJARID3VwmicoiqxN5
dsjI6LsXxxmaUeujGxccjNUYKpq83eU3L/zOtAD1Im4uWTmxVQHagLz4vAsiNkXa
V8jRTaY5
=/kID
-----END PGP SIGNATURE-----

--Groupsio=F4aeTERquNc1AS4tHmKC--

