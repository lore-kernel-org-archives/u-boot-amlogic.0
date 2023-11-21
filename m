Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D45C636D4
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.39545.1700572554698550038
 for <u-boot-amlogic@groups.io>;
 Tue, 21 Nov 2023 05:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UK5KqfGk;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-677fe97ddf8so18871996d6.3
        for <u-boot-amlogic@groups.io>; Tue, 21 Nov 2023 05:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700572554; x=1701177354; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBBD5EHmhRSLa28zpgHcGntYet6+ErJ4N7/pCjAJSpE=;
        b=UK5KqfGkTuNbrsrUF90LGpio3aEb5SUqWAJCL21l+/JWkoZ2IuccDXAX11IkHryxip
         tXgCWRNMb3eNR76irGCPCkTVpNGH6E4TzyQbOmSrbW+wWWNvI1M481Y6/cSMZZKPaiRZ
         2wTuL6DmlqG1l2WtV6AWpNzY29Q+Q/2CEGdp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700572554; x=1701177354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBBD5EHmhRSLa28zpgHcGntYet6+ErJ4N7/pCjAJSpE=;
        b=gM3l0Fs/BmCS+jaJsnWhUr6UKiVjddwbEZbRNrajZDArG0H6HnvXfEOWIkbzUPBkBt
         sgL8jachcpfGoZoRw9yHRHDc3wQXL3+32m74VDLTn1CAijM2bc+HNlOyc4iFYiRAcSWW
         Ko54svsKjtIh3nx6OBoPF9HZqy1O47EvLGZBREfkdLxRGpokWkItvtcG3V/5HiGf6kSh
         jfHXke3qs9wGYVpksGN+rXJGwAHA6WkOoqcGP2GNfyfZ3omVkpdGdeQWS3yqOtzjbvLc
         Nx8qg9wBOCz8Ph4wCV8jYzedUSqUw0EujCExJfq0JX215V7Ss7r33T8aEmJFx9A+TXEE
         oxxA==
X-Gm-Message-State: AOJu0YwvVemTwTVkkj911eivb9y6WaYz7tIMRfZ6DBb7QglWiEDtfdZx
	1qajS4l0FMQ/KAAk/cjsBWfIZExQSsB2D/7zQqRNaw==
X-Google-Smtp-Source: AGHT+IFbNiceepEhdqJZzGR5L2hWNYMJWf3lxLNlVnihoCi7dNW0Tk7/4hXxsphQXRlHUNOqozYmPw==
X-Received: by 2002:a05:6214:1948:b0:679:e640:2790 with SMTP id q8-20020a056214194800b00679e6402790mr5051104qvk.40.1700572553793;
        Tue, 21 Nov 2023 05:15:53 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com. [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
        by smtp.gmail.com with ESMTPSA id qh10-20020a0562144c0a00b00677f605f12asm3748848qvb.79.2023.11.21.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:15:53 -0800 (PST)
Date: Tue, 21 Nov 2023 08:15:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Subject: Re: [PATCH] libretech-cc: Populate SMBIOS information
Message-ID: <20231121131551.GP2513409@bill-the-cat>
References: <20231120201609.619598-1-trini@konsulko.com>
 <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a653e096-cf28-4573-856f-d52dae233b46@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=7MK98VdwXTN1aq9qCp6u"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1885

--Groupsio=7MK98VdwXTN1aq9qCp6u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 10:18:04AM +0100, Neil Armstrong wrote:
> Hi Tom,
>=20
> On 20/11/2023 21:16, Tom Rini wrote:
> > Enable CONFIG_SYSINFO_SMBIOS and populate the nodes so that Linux can
> > eventually display this information
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Posting this as this was the easiest platform for me to test some SMBIO=
S
> > related patches on and I needed to populate the nodes so I could check
> > things in dmidecode once Linux was up.
>=20
> Sorry to be late a the party, but can't this be dynamically found from DT=
's compatible & model ?
> Since I'll probably need to add this to all boards, it seems like a dupli=
cate of what's already in the DT.

Part of the "fun" as to why we have the binding here is that while we
could use the top-level model property, there's not a corresponding one
for manufacturer. I'm fine ignoring the patch I posted here and having a
longer discussion about populating SMBIOS more usefully, globally, as I
think has been suggested a time or two.

--=20
Tom

--Groupsio=7MK98VdwXTN1aq9qCp6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVcrYcACgkQFHw5/5Y0
tyw6JAwAhNxlw4AzLR5HWq+K1nPqOfzQdmbS+RAlGevb6y0rGbU0GXlWjSE3FuZb
1JqjqA2XZ3Tf9i5aMVM52aopoYqsHtnZEmTmx1TGBeOGKjd+2RHiNwMG80+hZwUe
58bGVn+1YbwM2dgw29hB896KQEtf7dQKTElhI5JA3YJhyZMEgPCLKSI/fktkPSjg
Rp01YTZI/R2QsR5PIALA1jrXP5UmX/ttuFecuxM4hBzJdTLEKdHkFCKE+gT6LUVi
awzbjdu8TOSslhC1IRUp6lhbIhxP83PuKja5iunRu7zTyp8CHlSYa95yT8ix6o1v
fhy3irNU7oMxqlg84iZKp/lDrGL1ToGQngYh3jqgx+FyHWBoCVRRAheML3letKuk
FJBMkeV9wUm5zCQ71bth1qbcP1aL6Tw0nXXhFVtPeyJRQYZ4x4He6XJFTfsNmlv9
1BO6Du+uRsv5AksPoiPbEDrBSPMNvHTI/4Mzl1uKISuYOeQH+WNXXA55VzDsCr8V
/zaPTdqT
=kli4
-----END PGP SIGNATURE-----

--Groupsio=7MK98VdwXTN1aq9qCp6u--

