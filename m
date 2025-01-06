Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B892CE77188
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 17:32:33 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.61179.1736175330114743066
 for <u-boot-amlogic@groups.io>;
 Mon, 06 Jan 2025 06:55:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QLdWtMsZ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dce7263beaso128003316d6.3
        for <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1736175329; x=1736780129; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Cif8x3R7y5WlHJfH41699o7uCzdcT+aVwxsIWHOzN8=;
        b=QLdWtMsZ/xy7fvFDzyu6blKo2CTXLPoEngrkiG0oKgnpaVbrBXeqM9GMuLqAzez9U7
         9fFzGJQ4LX3DaVjVKGtMRk05SpjGvp8HgyoMhGDlj/v/g31ntPTWgbGc1v1RS0Hp9WEO
         YP5W0rA7NYPHIC/GYbu88DDPY0TiXz4OE3MGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175329; x=1736780129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cif8x3R7y5WlHJfH41699o7uCzdcT+aVwxsIWHOzN8=;
        b=EUC7xc1dQbh5kOsgHxp1A6VR3tOOGQkeRiuQmeTJ/USZm0KEGLWYyO/308BhBJyB7H
         DK7KFU2YC0AB4MCD5pAnicslhVL2CPCiksAU8Ao2PPjrkLd6UfepqeprmRdvhm98pY4g
         gkdsABu9SOwnunTDQFMzV/szIoKtclpT9rz10PmfUdFVpx6GL+0Bg3A3wCrp21jnYhYA
         U0SEffU8qOZI+L8noRrk3sVHv9Yo/NvUN7qBLSPsOuwHJ4I/3gynvdmzYNeH3fy7v70Z
         47lj2hrQ0TI0ehuXVfIWJJ+aLSczdhGoa8hZcsp9BMZ5+wp3/+5F2duKMc6QnTLf6feM
         WVZg==
X-Forwarded-Encrypted: i=1; AJvYcCXRaJtb31Ca4/pcS7kBMUpFbkT16XPCFz/PPNl5Qh//2EBME5PjJBu0fEgyj9Ka0P/3AlUqIUVigpPhO0DbgQ==@groups.io
X-Gm-Message-State: AOJu0Yzi8fwdau6KPR7MF6FP78y5mvSaVzKpiqZs9R6Iod4tnil+jRV0
	gpVmZ4syTjsOQtKpRKPdyQCs5qCyRQM1NzXt2MGSzogvqx0E5CG5x7rcSnL4amQ=
X-Gm-Gg: ASbGnctlDFtWGVCPvGWTKjpa0cW8zndFfWsKdhj2rqfsykHXfQhscxvninFAIz0MfPp
	b0L/HUrWgy5rOCH6Pf4LuYcUg6YU2okaVLfV1hhvuziQLcQR/+2h6TTc/PSj/t7gYlTqaTqH0j1
	KiG8JVw94yjfvsNVutzF7USTHJ/U/ETJPLuZnMocD1j0fzjlAJXLVNCqWuva0sB36X4i6N6UKJ0
	QEJjUKTlPQPP14KgbBzJxDNKdeLLcYQDB/g9hp6w58EtcM6BSTA6KEOvw==
X-Google-Smtp-Source: AGHT+IGJvoNIglhLC0i3wY6ht+uZHAWjt/0i1zT/fScjHhD+yNh5F7CYSVk3W1R1s69qC+vWBsL3gw==
X-Received: by 2002:a05:6214:250e:b0:6d8:a84b:b508 with SMTP id 6a1803df08f44-6dd2333ae04mr922259936d6.12.1736175329041;
        Mon, 06 Jan 2025 06:55:29 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd180eaad2sm171176496d6.6.2025.01.06.06.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:55:28 -0800 (PST)
Date: Mon, 6 Jan 2025 08:55:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Ferass El Hafidi <vitali64pmemail@protonmail.com>,
	u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] tools: mkimage: Add Amlogic Boot Image type
Message-ID: <20250106145525.GZ3476@bill-the-cat>
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-2-jonas@kwiboo.se>
 <f06f4ee6-6b47-44e6-992b-a06617f3d237@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f06f4ee6-6b47-44e6-992b-a06617f3d237@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=QZCP1UQxCpJErl7DpKsN"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 06 Jan 2025 17:32:33 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2609

--Groupsio=QZCP1UQxCpJErl7DpKsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 10:27:39AM +0100, Neil Armstrong wrote:
[snip]
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>=20
> Via which tree this should be merged ?

Your amlogic tree when ready, thanks!

--=20
Tom

--Groupsio=QZCP1UQxCpJErl7DpKsN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd77t0ACgkQFHw5/5Y0
tyzqsAv/W264moiVUmw0aaHFLBYIgpbOwtxoKtwCI2Gkx7qcPKCi4Y+ZJjnhLoob
pnJrTNMr5Af69NsYHBGmWgd5zMv5XiZ4Y6Z4kDrW7agWVwP1VBw7liEC9+gPGYKB
DiN/z9Fmrt7ozcC5Stw9DDKSq3yCd6jS9hQZ8nzVkqmrJ+nFeAIJ8vZYdianSOPX
e5XsSiDb9iIaFGI5lQXASokVOZpYfwejpyR1OqgE5XwZ8LJw2mKNMhB2/7PCSlMU
rPDlwiJL2NGYUREitofUAickan4I93wuylEvaQxh+n8KEhiEcWWQ9mkUCapW8K3y
wdAc+SLiuT4UwKtjD9KFniEYMRCnFoMCkA+wp4wc8qH6Ybyu5AcQrCOoBBoolaOD
ewULHqjgdrUj3ifzK3T1ds3mWwowWX/d8ULi82k9IhtDNKy+zL72/UWCpyuX9h1p
3Hk8NJAmQvgYeOyaBSt3HS6nuI8wNmRl8HX1X5ugvrVM9iFvQsecyTwuf2+KCdDZ
fyHRvD0l
=LJeK
-----END PGP SIGNATURE-----

--Groupsio=QZCP1UQxCpJErl7DpKsN--

