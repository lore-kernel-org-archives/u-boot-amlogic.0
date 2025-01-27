Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE9C02193
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:44:19 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web10.41277.1737936012570172935
 for <u-boot-amlogic@groups.io>;
 Sun, 26 Jan 2025 16:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PncK2NSv;
 spf=pass (domain: konsulko.com, ip: 209.85.219.46, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so32659316d6.0
        for <u-boot-amlogic@groups.io>; Sun, 26 Jan 2025 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737936011; x=1738540811; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpx8XBFbxigmyro/qfbnmSPvsTlbi1NxGll/VQ8e0dk=;
        b=PncK2NSvUWuBMkn4hc16lc2UQ67ucg2R8Jv/vdLlKX4niIsBE3ih2Wo3oyQyiOy3DX
         d3vZLgKdsx+hGScmRjfmxhvmcO3/zghAtRRZJAXyzusPcdw2Su2JTzvZpb4WxE82l0gp
         vu5DwmvscCi775qAHdSYGfUi440Z99DgKC0G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737936011; x=1738540811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpx8XBFbxigmyro/qfbnmSPvsTlbi1NxGll/VQ8e0dk=;
        b=aYJTg2IUIPIhwpjH+LkNGdZfwdmS6+ivgU+EaEvUpxeId9NkL4qG9gMkzZDHoqICFu
         qVF3jNAc+25KLVEWVF49e/sscdyhM1KUqxSy0sOnCM21QRrO9Vw/kUxymavK5Vd4iYAk
         7FYbjeH7b9CkmFhMGMWLX1sgumszU0S3vsWtTKnLa8uY/NIp4yx+qMa6k6NJRG3g8eLC
         Bw7+dNtcIhLT7gU7HMlSNgdg+/kHX+G9Pcdtk1lVq3gGXQLUX3WUu+TNECNg6YmKcpgw
         XpMe/a2pnOLqkKxnAVl0ZfFJr131sfemoV3R1c16onaZM2Ran7IkZW6eBuIcJQ3Fjzxq
         F53A==
X-Gm-Message-State: AOJu0YypLyPPdrhWdMsid9N1WbxQy5bC1bxTdY9zziT+bOU3vugB6Why
	E5BlQk95k6qhPd7qZmMzDOg4Ow071PwvCnBIwBpPrbvAX1GJ2qcYDmjmBhsV9+CbbXRmhye8u9y
	RAMEoVQ==
X-Gm-Gg: ASbGncsgpUEeYcrwyAhJ/aNCs6rzacRsJIVI2tLs4jFw9zQUd3QDcD2EagiJYO6tRMC
	J0QZcqcsgf1pNBQZ3nWr8KMNoyyzHQ1cPDuOh8hYj4WxsQVbEgHVc6k5cOuUlL01ur4w5kNMz9J
	CM6EAlnUsJLU2SdNwmHk7q1zBvxuuufAzljnhvoBbYQtYCnkh+bcb5scXZ/VBm2YLs3ovIrO44f
	L5zfWXZZJIX+O8eTK5Y0VPxbDOyKPq1ak9zOZgRgq4HdPLZgHu+CV8hYwpAjMKeKvodxsyLUOeo
	ddc2
X-Google-Smtp-Source: AGHT+IEme9BwXtrS1isLMhad9RCDTSmou8WAdlVmTxRsaz8eYTpxR1Ihz4INI6H/QzeVjOyyND/CJA==
X-Received: by 2002:a05:6214:5002:b0:6d4:1c9d:4f47 with SMTP id 6a1803df08f44-6e1b2141a31mr654998486d6.13.1737936011603;
        Sun, 26 Jan 2025 16:00:11 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e205ac4aabsm29384246d6.121.2025.01.26.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 16:00:10 -0800 (PST)
Date: Sun, 26 Jan 2025 18:00:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
	u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] Squashed 'dts/upstream/' changes from 9b6ba2666d63..8531b4b4988c
Message-ID: <20250127000007.GB1233568@bill-the-cat>
References: <20250121203147.4133618-1-trini@konsulko.com>
MIME-Version: 1.0
In-Reply-To: <20250121203147.4133618-1-trini@konsulko.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=ftUDn9g0gOsD0qmxk7wP"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 30 Jan 2025 09:44:19 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2617

--Groupsio=ftUDn9g0gOsD0qmxk7wP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 02:31:37PM -0600, Tom Rini wrote:

> 8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
> [snip]
> git-subtree-dir: dts/upstream
> git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
> ---
> This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
> and so match v6.13 release. Changes and changelog omitted due to size,
> and everyone who is listed as a maintainer of a platform with
> OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
> being marked as spam, hopefully.

This is now in master.

--=20
Tom

--Groupsio=ftUDn9g0gOsD0qmxk7wP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeWzIQACgkQFHw5/5Y0
tyy6cwv/eqlAAS6+VNNQuUyTpbWOLRXB3rk6mQ8CuslZrQ/7XUrg26HmX5rtq66m
FcnObmtU7LjAYoNJx8gK2NKoGV3PJz7g8Up+zgnNFiC/4+m0G1H2bZBa2CCbGPXV
oQsDR5KkSn9u8MkKMAo6pLesdcEQ6eIIrWRFuwl/noXQ3pw/MA/KeIUvfr3GrdAa
/janhj+3ZOQf3oApLhR/XJFnmsvMXPoaMvLmRuAnjXkwrWb+4dQ0vFB/V+cAxAdi
RYSQTzbk/RafV6Vde+6XA8ZPtlulrJ6kfpxM4Ey56zXj+v/Xa9UNZtgXB+Pljrzj
w2EigIDoETPvIHr/l+6X11n0PnOkZZW5XVYRqlLrbq6nZ0Dy4XZ//JSTdqoUGgYQ
Zz5DSAd8qEqWrq6uMykSgR6I8yv/xSBbZDR6r0xNj5OdhWKnzhN0iGuRMLtC/ckt
Fd9P6d6iJD92dU2oDRYHZ9hDesxKiMEli5DSraX/R0ikO8e24k6FdzSH88+f5wJO
99fJ6Pck
=23MR
-----END PGP SIGNATURE-----

--Groupsio=ftUDn9g0gOsD0qmxk7wP--

