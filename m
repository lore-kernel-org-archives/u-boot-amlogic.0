Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82EC54E69
	for <webhook@archiver.kernel.org>; Mon, 11 Mar 2024 08:51:38 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.101768.1709566078095970716
 for <u-boot-amlogic@groups.io>;
 Mon, 04 Mar 2024 07:27:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OvMhuey6;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7882a0bcfbaso34280085a.2
        for <u-boot-amlogic@groups.io>; Mon, 04 Mar 2024 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1709566077; x=1710170877; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uwaHUKjmFHQBAWSTTcNHyEi0v1Q1D8l2ks0KzzdO90=;
        b=OvMhuey6anXZXk9AtI+80bNAlPLFCWPvcZhg4WX2ol5fqNICELaCF2unRBFFcYRTok
         WCwGtZly9ttJ7tVYJe2CzbkmhHm/Saf49yr5HoxzGVMGkliTf7+k2aAC1DfR9JEbzbQG
         NlwHqgJFKoNgqyVwK3lpfw6FW4wGCAbrjepbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566077; x=1710170877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uwaHUKjmFHQBAWSTTcNHyEi0v1Q1D8l2ks0KzzdO90=;
        b=Dx4nFnly7KU0f+hMv1tfdH/tG2Hcu/iwCQsw0VxRn/NEkzLjc+G5mJFo4zTmf57WwO
         L5jPnBou70HdjIhqLAWVPGzutaH/a3J434/NHuXknCPyeOgaTTe67bPjEVngI1IVOJfO
         9vdC7rqx4uSMDJgAqoPjkR7QRMV7GbAOoTJVc928K0PlGXsQyauIhogwsYdX9YWFaZJt
         lxNFGF92piXtB/9/4TZGoQxqThW2/JglU4uemqodpQU9Jr7PbBWY7+erXxakg6JFKVO3
         FKc3jMeyaZzskoLdxM3l8VTtFuXJnGxQCio/MymIftWVqEu+/K6UuF2tW1XMv8JjpjoM
         kUvA==
X-Forwarded-Encrypted: i=1; AJvYcCV5JYJoK2S75HITHCD1nM1HZc5113I0cykiXXVGeXOxTjeqjU6d2dM5yumO2+eCCxh7TNrQ+nlHP/vhvFjwvNauOPBXrNIiARs=
X-Gm-Message-State: AOJu0YwBGqAq+H4f00sR0xbpnK7rl3ve5Q5ByAcMOFDn2XlVQjLhaU8p
	xFxRZyIH/rT9fOb2Sc1POvi1zHVH1dSBnpmkBbu9UGFVjiV2hWwq7og+XWlwU9g=
X-Google-Smtp-Source: AGHT+IHF876t80XWppK/NlpzetTMzUyA3PlTQyXhh7PdAxua8v9j5T76fV/y+tHaXiT4WP9zkfqYXw==
X-Received: by 2002:a05:620a:471e:b0:788:22ad:c880 with SMTP id bs30-20020a05620a471e00b0078822adc880mr6591225qkb.5.1709566077008;
        Mon, 04 Mar 2024 07:27:57 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com. [2603:6081:7b00:7f::1002])
        by smtp.gmail.com with ESMTPSA id x10-20020ae9e64a000000b0078803b1a3d3sm3816541qkl.86.2024.03.04.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:27:56 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Kovacic <luka.kovacic@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Simon Glass <sjg@chromium.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Etienne Carriere <etienne.carriere@linaro.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Alexey Romanov <avromanov@salutedevices.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Lin Jinhan <troy.lin@rock-chips.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Grzegorz Szymaszek <gszymaszek@short.pl>, u-boot@lists.denx.de,
	u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/1] rng: eliminate common.h include from RNG drivers
Message-ID: <20240304152753.GX1523872@bill-the-cat>
References: <20240212234448.39552-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20240212234448.39552-1-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=fftXy2Fjuq9SfpJrklHP"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 11 Mar 2024 08:51:38 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2155

--Groupsio=fftXy2Fjuq9SfpJrklHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:44:47AM +0100, Heinrich Schuchardt wrote:

> Usage of common.h is deprecated.
>=20
> * Remove common.h from RNG drivers.
> * Sort includes.
> * Add time.h to sandbox driver.
> * Add linux/types.h to rng.h to provide size_t.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=fftXy2Fjuq9SfpJrklHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6HkACgkQFHw5/5Y0
tyzw1wv+JeTwaJaK5UzvL9LWZGDQ6/R6461oWelyXMgFp4x77sm0nxuf+brduo1y
LbAX7tXjPBeeq6TsHfrQccvy4iKbfYg+GhyI4QjEiL2i2uPr2D/Gu7nACz1YQ/5O
+FUowtLvU2RsZj1XnuuX2flY34DSx3pmdK2Ui98Thd64NqK4xZFCL64dU3rhl62P
T7Obfq5s+7+KhI3qFyxI/BWUQu3O8tzaCrZjIEsKm/Hyj8ZzB1r4zinWZPX16jmi
Cs2fX/P61197NBEha1yDyL7JqP8TUfiUfSosi+OAIajmAO8ZDERT6lrMQNIKc9x2
/yLad8rDHG8VKhwP5oUo68xuh02+E4BGDgYItGYhYKO5R3k+ZZw0io7S2khvurmB
xo/Ixde5EERYzsr7EDnrBYDzIrLPSW4S/oAiKBifu1ATmtPvnjtbxKUhHFwTKsVn
EJQvbfLVuM7OM+gAJEptBLqAiO4EOWNYKnrwJ9Tk0p3ELJsgKjtHy3Meigp67ktv
WZeDTcv9
=TUhl
-----END PGP SIGNATURE-----

--Groupsio=fftXy2Fjuq9SfpJrklHP--

