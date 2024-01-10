Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2988C47DB1
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 08:11:04 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
 by mx.groups.io with SMTP id smtpd.web10.10583.1704890447931630301
 for <u-boot-amlogic@groups.io>;
 Wed, 10 Jan 2024 04:40:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eP4txW2D;
 spf=pass (domain: linaro.org, ip: 209.85.222.48, mailfrom: sumit.garg@linaro.org)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ce3e5bc2afso794127241.3
        for <u-boot-amlogic@groups.io>; Wed, 10 Jan 2024 04:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704890447; x=1705495247; darn=groups.io;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiNP/CdCDMxbnqAs22umrAsFNDnrljBF/5SYQI5VfME=;
        b=eP4txW2DfStnRIVjOeG7Hj2MJa+/C4bdaAvrOQhDUDmx2L2juxpTkznumUyZ0f/klG
         yKZ4NE7Sn4oMqOE/KaZIQMhnVlfNTYs+BYQsuF8LOlz8HGx5zOWfJGYvrU8fj+a5f9Ol
         bWK2+cpoABGb22KTUBxYl+ZKjgyfkclA5Umj/za3x/phz7YJwjEDmVsIDe+v3gth+9Aj
         6rqWV78mcIwpZeV8VtOWfkRFTpKUK4wOIucyTgVSoV7qWxATnxX67RmmGnGENnEc0MJp
         RdOjMxBML+k2XheGVe4ULzfTIHcOE0m4lSQKSzfKc7UpCw3UacNrF+RRXc7vHUPkFIDZ
         XDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890447; x=1705495247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiNP/CdCDMxbnqAs22umrAsFNDnrljBF/5SYQI5VfME=;
        b=sRo0mMLwsnwgRf9uFbFCVGUfKdwWCgIDBcdyOoJpW31hYBnKD/gA4axGXkuHD5vZ2i
         dhy+pIEpXsEXv64XjBaRRLf74NRM1K/zQewbD9mpGY/H8XYuC55jlkxHJnbjoBHk9Guy
         c8Jogiwo6EtSCczqCkd0l1HW1EBAzTmQv77KOJ6k1K+2SzGZHrf7knCqW4/IcGSPGNo3
         TjkJHAKAEW2KVGJIb+OqdgZ+Y5xV686S75OuflSpWuBG0NfgIBd2AEkRxCZGEPHoCQ+c
         3kHJqmFnk65mE70i/fnPX7ZXQgXa8RO3NUQ7kVzJkEw8y59NK5XGPFUwoub8LGEa4qGK
         e7AA==
X-Gm-Message-State: AOJu0Yydqily+rpr0HaCP9cZOlraZwSqszKA8oZVjK9g36pMPdosTKfF
	9bFOFYdi4mIvdCqV4hufYwcNUH6dhSXc3LB25BIJ1FpVmd4MpQ==
X-Google-Smtp-Source: AGHT+IFl6KFsHuwHd/CdScW0T1KYhrmLggZw7TF7qpbc6F/4WvFZ4/bwntVfXP02bpo+mwCgb/pP4XJBkI8iJPikO64=
X-Received: by 2002:a05:6102:41ac:b0:467:b84:62a9 with SMTP id
 cd44-20020a05610241ac00b004670b8462a9mr910845vsb.32.1704890446895; Wed, 10
 Jan 2024 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240110103547.719757-8-sumit.garg@linaro.org> <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
In-Reply-To: <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Jan 2024 18:10:35 +0530
Message-ID: <CAFA6WYMr8TPbNv8mxCoo+uZ2NngJ+3dm8dpT0qoZWRbe1qB2RA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] doc: devicetree: Align documentation to use Kconfig options
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
	u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
	ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
	xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
	rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
	rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
	mark.kettenis@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 15 Jan 2024 08:11:04 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2070

On Wed, 10 Jan 2024 at 18:01, Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, Jan 10, 2024 at 7:37=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
>
> >  History
> >  -------
> >
> > -U-Boot configuration was previous done using CONFIG options in the boa=
rd
> > +U-Boot configuration was previous done using Kconfig options in the bo=
ard
> >  config file. This eventually got out of hand with nearly 10,000 option=
s.
>
> It seems that the original text should be preserved here.

Ah, you are right. I can preserve that in the next spin if I receive
further feedback otherwise I hope Tom can fix it up while applying.

-Sumit

