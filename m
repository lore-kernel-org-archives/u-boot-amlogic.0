Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE29D6DDFD
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 13:14:22 +0000 (UTC)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
 by mx.groups.io with SMTP id smtpd.web11.2202.1731610778622608762
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Nov 2024 10:59:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gxSA2lMM;
 spf=pass (domain: konsulko.com, ip: 209.85.221.180, mailfrom: trini@konsulko.com)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50de14e7d8cso443423e0c.1
        for <u-boot-amlogic@groups.io>; Thu, 14 Nov 2024 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1731610777; x=1732215577; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmyaJTy0P0D0Xkyj/Ucld+TRFm4Kl/uDXkKb7tYsPFc=;
        b=gxSA2lMM6E5Gd+wg9yPTvAubksaOOGXITT0WsD9+nqabClgNG61LEltnMsKqCPesRH
         p2B81AVfpK2z5hkXa2ZNdmQisopMQSMoiOWtXwl8PLlrv3fClnIX+tKkcE5/XP4mR5hK
         jEbSZolZWDzUW0zFKPR2QiNtvq2QjMi9dcKAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731610777; x=1732215577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmyaJTy0P0D0Xkyj/Ucld+TRFm4Kl/uDXkKb7tYsPFc=;
        b=Su96XkO6Z5oI/S/0uAK+IqqL0wgUZR3pisw+jPqmRRalAFHOEG4qYkhTgOMR+nfHI6
         T8TFmrPtHWYpDL0vS1Et7DGBPEGAmF1jGUsOiNVvbim+l0+VIelao1jfHbofYjYzov65
         UDnhZ2CD4ThxPw3KU2dFTvNIYIxV/eHamesqvcyTUcL2Vt8ppSExzhPSY7RuJZsKrtDj
         Z8UO4dm+ktxEj7ueNvUHmGw93EcxdP9InKnZonQE1rE66+RBPjWuacxXKojFF9mfh+QA
         TCKCARch2KGfh/hiepP3vmP0a8/whZJIvFU3StPsC3sJJkdAizPcXivhT89sfuzLaJu1
         JLnQ==
X-Gm-Message-State: AOJu0YzF3IEIzkChz85PheGb39OIxaPqUVTorVuWBVlFeGDxB7hGg2Dw
	i6C469q+OgvxlpFjtHuUvYzH3Jgwyh3nNYCBq78IGdRgTkJnBmrUWzVzbBrPJ7Y=
X-Google-Smtp-Source: AGHT+IHCVeJCTCdL5GKp5pegN395jvV0QZcNOEVuLTh492zzOzcKoViKi/ueSlMPot8LqhmcZD8RHQ==
X-Received: by 2002:a05:6102:50ac:b0:4a4:8fc3:9b7 with SMTP id ada2fe7eead31-4ad62b9073bmr193946137.14.1731610777586;
        Thu, 14 Nov 2024 10:59:37 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c99d7ebsm78486985a.35.2024.11.14.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:59:36 -0800 (PST)
Date: Thu, 14 Nov 2024 12:59:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20241113
Message-ID: <20241114185933.GL3600562@bill-the-cat>
References: <6d6d1630-838b-460b-ac4f-1c4923bfb40b@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6d6d1630-838b-460b-ac4f-1c4923bfb40b@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=0EYz627dE4uoxpHBzDa2"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Fri, 15 Nov 2024 13:14:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2558

--Groupsio=0EYz627dE4uoxpHBzDa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 06:45:23PM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Here's a small fix for khadas-vim3{l} android config, and a drop of
> obsolete dtsi and include bindings in favor or the upstream ones.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd2=
71:
>=20
>   bios_emulator: fix first argument of pci_{read,write}_config_* function=
 calls (2024-11-04 18:01:58 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20241113
>=20
> for you to fetch changes up to 1cdb4e03e684d94456dee0cc30c935d7e25b263d:
>=20
>   dt-bindings: interrupt-controller: remove arm-gic.h from include/ (2024=
-11-13 17:25:07 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=0EYz627dE4uoxpHBzDa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2SI4ACgkQFHw5/5Y0
tywYUQv6A5GLwvO2YgrKax6PHubBrhnF+OqcJnDUDnkb+oc4y+u5wttgR+jZf3aL
Zj2KpDGuKzPKYzQS7+ufJW9l7h37IHiEFd7evwLt/LziMu0rRYc0wjxz57ov+6cq
ZCgakI2th9pjFAR6zj+iRfARVJafAuB/oNL1wS0skzt4tgyPITrR5KA6DkcqB5Je
lynYPqcQxBM/9J6KDqtKxjqsC9Q3uWHm3NzG/eE+Oe/jYIcOCP2UYdc+Q2AiFYaa
DaoR4FjB5dQj+vvPiYWtkGd1V9wLPF9hOQy28tQC9fkS0KJ/tSit+LFahbULPYWL
o05XQ0+aeAUnsgl76lh5CtkJ0iNNM5UqlSfbPDTPKQ/PIRJwk0ZvmV18rx0S8avY
s2KIlctRRnmrJ3B7RQ2bnaZWr5oJOpQCs+OJg5ZdZdSHNXaypGqP1lT9DtqcnAIn
WF48Unx8efSx32QQ4YK0eNDPNBFOkZAkqdzSr8u4Nvt0umKcyFu84u9h7956jSot
QEwZlGMr
=7nJ7
-----END PGP SIGNATURE-----

--Groupsio=0EYz627dE4uoxpHBzDa2--

