Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07DE7716C
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 09:41:22 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.61029.1732666445733940774
 for <u-boot-amlogic@groups.io>;
 Tue, 26 Nov 2024 16:14:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EkfHWk1D;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: trini@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-466847440a6so22042521cf.2
        for <u-boot-amlogic@groups.io>; Tue, 26 Nov 2024 16:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732666444; x=1733271244; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPGps0lhjB2EaFANpr58/4wAgQt5ecX6l0RD+4fxhE=;
        b=EkfHWk1Dus6os97iHnqcfmmLgGxZGtYZF4+Ksmomr6MZp3v9NhLDwhjAWdmFNY4MiM
         wcLlkARfYHdVjs46/y+12yE53woMuxRBz4DVDiaxKASuMl2YY6HVv7MjYIOXwiG+Z+33
         +T0gNiXDBbav5iloY5ZNjlhx8U4x+n5oOM5vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732666444; x=1733271244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjPGps0lhjB2EaFANpr58/4wAgQt5ecX6l0RD+4fxhE=;
        b=FXZ7r6upSd/MTpwPHMyC3UrEMd4fFEh/Eg/O3Bu7zeIYh8gvydw8i+JRsvvD6UW34e
         KFBIoGL0dmrE+fsYd13Pnz5cq/InndCezVhTbKODsoh8pLPRcWAuIiIpaAmKvsZ4w5to
         YdsmJiYet89Fxj/dWKUOI26h9hDw+l92ZTshjSRxB4M2OVagfvgBrFS6gGmpuLgPlbpE
         egtx1/fqzSYbfgOBxDjJxKHQaGlSypUZ6OgiGzhAQDH+TA6K23KL3dlyuYVhlhteLtzh
         P3Cga9JJfCGor8/AVWJCXIphZxKAGqLY1w+UHCvUCmeWuLtoz/YQnfD/mT29XvNQS8uv
         OQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCVKJt7yAt+QEu8w84koCF9NIBP2XPvhApNKUfPx7TuUsRAJQW25HbHUmaAHCyY3hO5gkfCQI4rlfbpzO6gItg==@groups.io
X-Gm-Message-State: AOJu0YzPqkfciOaFMRKO+fWtLFkpGlqcuNedfUR/dJ53IhGSzRhzKGZW
	C0/slIOafPP5jQ3bq72DPl8C+jjr9VyfVVM1rrKpzMZajJhzJdvItwOJ5xVoyIOhnECDp/crrH6
	ei8c=
X-Gm-Gg: ASbGnct3Xo5sNImoiK5VCYNCrhnCMHo/vQ/OcW6L0vNmvlXwlZbRrcGWQDXSx/kHN8F
	0veIQanwulMlkYQ19enBXyWR7YV+dtD2Jr7w2IxSHJD21fQ+JaSE32CmxfvoKY3EYb/mVkBwUL2
	RCq5J74Ibos+CzdDN6gk3w2umvhgO1CYMS/5yO+GBaiW23ur4IbRlUKxG2+t+AaoxcyOhdhCFmC
	8alM/gkebRWOxCO+9lybO75eKwaozfwYUn9dSUokqb3E9/Bxg==
X-Google-Smtp-Source: AGHT+IGSOYYE2fzjIdNm6l/raqNBfYtljSEoZLcMayymF7Pd1OULjil5pTLRCbBXC/QLyzheCTPn2A==
X-Received: by 2002:a05:622a:47:b0:45d:9357:1cca with SMTP id d75a77b69052e-466b351e8c4mr12178551cf.14.1732666444577;
        Tue, 26 Nov 2024 16:14:04 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466aedab15asm8370451cf.66.2024.11.26.16.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:14:03 -0800 (PST)
Date: Tue, 26 Nov 2024 18:14:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	Lukasz Majewski <lukma@denx.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Julien Masson <jmasson@baylibre.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20241126
Message-ID: <20241127001401.GY3600562@bill-the-cat>
References: <87plmip1m6.fsf@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <87plmip1m6.fsf@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=eESSw2uDTlcb2Hj5VhU1"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 05 Dec 2024 09:41:22 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2591

--Groupsio=eESSw2uDTlcb2Hj5VhU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 02:26:41PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some new developments for next:
>=20
> Android:
> - bootstd: Implement bootimage v2 support
> - bootstd: Support non-A/B in bootmeth_android
> - Migrate VIM3 and VIM3L to use bootmeth_android
> - bootstd: Additional test for bootimage v2
> - bootstd: Optimize load time when reading partitions
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23573
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d9=
11:
>=20
>   Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20241126
>=20
> for you to fetch changes up to abadcda24b100b8eb0f138085cca6595518cec85:
>=20
>   bootstd: android: don't read whole partition sizes (2024-11-26 10:04:40=
 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=eESSw2uDTlcb2Hj5VhU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdGZEkACgkQFHw5/5Y0
tyzP9wv9Fzlng0EllbkrDdRFFmGe0i/nTaZH3/FkghTmOVqH9X2hj26r5xldiOQS
L3uaqGDcA0Q6sQSMWie9kPFidTFIOgXneCYntyL7hFmkvOgFt3nAIcDvXcgKzeov
eNFskgo1GRlye2KLV42DHjBzWQ0ozIXbfgC6n5Pf8bkifYAv6B6xgSG4bcNdx8Oy
Qc8lkNffcuGJBpteB23QJ10JD8WGPqgSF/VHTDdjNWSirIDm8/BCHzz/VR/FfXC0
K8vaZt3+eNgWM1QFwaewdBs+sLaJVHd2uCcqPSjXBUNVrGa9mmFtG3GpTbOO3sB1
Lbpcxxbq4gGrLPhySK+AL5MiAx+hyweHZW96AG3ed/6WqOoRT5ZC3RwpA+bMAfip
STtp8FPkOdVExVDtGY74RLBUtNXXwn5qQlquLzg1ZlvA9zpR14e+mbBL+0onzORs
k3TD7hEYudjHH3R0ZQsW8smxsadSPWyyZGQipLcDAw3SWyTsehTIuDAdCUkfetos
397H1LJV
=Uz2+
-----END PGP SIGNATURE-----

--Groupsio=eESSw2uDTlcb2Hj5VhU1--

