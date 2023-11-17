Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C707C5AD4C
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.11705.1700228542770678913
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Nov 2023 05:42:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WNhqeyMR;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6711dd6595fso10799506d6.3
        for <u-boot-amlogic@groups.io>; Fri, 17 Nov 2023 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700228542; x=1700833342; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwpSEwEOllI6LcYna/uH5XoLf8aB0NQ1HjeNtDeZ/+s=;
        b=WNhqeyMRnca84Sgoe/6Twz9stLkLqmZUmpTvgqX2TzYbs3bTVPIQym2i8SKXxDY/Cv
         +okSDE6tQ0mjqeqvc+79BdZq4j+2+4xqU3mj1Ibzqmhg15nOrBmiznktktpeUkFDr314
         tkzkEWsEycjpxqf/FDIG1koC2AV6CboIj0QqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700228542; x=1700833342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwpSEwEOllI6LcYna/uH5XoLf8aB0NQ1HjeNtDeZ/+s=;
        b=DLm4dVCeS2NkPbD3fsnV4Eo67yhXpqFyDczK2jK5Z3sEduiNpGPCzNCkMySqvWe/Mx
         TIWwBtHQr8lR4bVmLD5sEsbDDHMSZvsO5cTjsb0op6z1OFqrojvaNW64qW+LxMZkrgD7
         9uvvHIpziDjVpet3cO/h51pWAh7tRu4YYcpduRJSXW943nWuoKuWhCseZwtg0d5Jgoxr
         as+ofOnYC5pRZZI4cf/WpNHFupEPQHjAH6HR+C3kppBZkD5RB6KSC/3uTzd68QibSBbo
         Mcj/D4i5PeMRG6pVzUGPL7sgmN5kQWP2XRl557n2Qw1K6iK/8NMu6LygHBwe0OlS7tfW
         F6yA==
X-Gm-Message-State: AOJu0YwXjE+n4NCt68+hyG3Oy5ntSfbuE4u6wmus5qmQagT7HmH+sZ03
	96IkbDyInbDRpbOSUScqtyr4fA==
X-Google-Smtp-Source: AGHT+IG8bs097idczyBjCQcx/JPWWKqKMp2vgvsDKMWNFO0nsL7TxnHfcJXLkkJDFppCHML52hvGjQ==
X-Received: by 2002:ad4:5ced:0:b0:66d:1ffe:bcd4 with SMTP id iv13-20020ad45ced000000b0066d1ffebcd4mr15239232qvb.44.1700228541027;
        Fri, 17 Nov 2023 05:42:21 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com. [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
        by smtp.gmail.com with ESMTPSA id n8-20020a0cee68000000b0065afbb39b2dsm636295qvs.47.2023.11.17.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:42:20 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com,
	Alexander Dahl <ada@thorsis.com>,
	Anatolij Gustschin <agust@denx.de>,
	Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
	Balaji Prakash J <bjagadee@codeaurora.org>,
	Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Bhupesh Sharma <bhupesh.linux@gmail.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Joel Stanley <joel@jms.id.au>,
	Kever Yang <kever.yang@rock-chips.com>,
	Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Michal Simek <michal.simek@amd.com>,
	Neha Malcom Francis <n-francis@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Peng Fan <peng.fan@nxp.com>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
	Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
	Sumit Garg <sumit.garg@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Weijie Gao <weijie.gao@mediatek.com>, u-boot-amlogic@groups.io,
	uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/3] treewide: use linux/time.h for time conversion defines
Message-ID: <20231117134217.GW170968@bill-the-cat>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109171004.193521-2-ivprusov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20231109171004.193521-2-ivprusov@salutedevices.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=M6N8QQelLe1Q4GlOad2n"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1882

--Groupsio=M6N8QQelLe1Q4GlOad2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:10:04PM +0300, Igor Prusov wrote:

> Now that we have time conversion defines from in time.h there is no need
> for each driver to define their own version.
>=20
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # tegra
> Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com> #at91
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org> #qcom geni
> Reviewed-by: Stefan Bosch <stefan_b@posteo.net> #nanopi2
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=M6N8QQelLe1Q4GlOad2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbbkACgkQFHw5/5Y0
tyzjMQwAs4rUe7sR2Krrdo8v0Y+HdHSbxhMrLe/+H98rOzQKwJgzI5zqQJ4lVqmQ
gxf3X+4TOHshwxet0N94fLbTFIZ8ly1cWHDU6O6H+rb+SzZVtL+s+YhCkIA9u4qO
BYCzr2CjevSy17JFYSA1yrv/MSU7FiX1bW2U/PHczFtSIyzJ7ZDZDKr0GsEw5gyr
2WX/CD/fnBAERbQi9VFeAe0ZkvhM3LkwhdaAaaR1h2TRmWdFpXtkhIxqJ8cHgjp0
ejfzMtigPROA7Ca3wyJAijLU0MvIJ/iJVQz4Auig+1PvEFaYhwxqgh9dT3fgDUOe
Ck/AnfXJBjuf6drrvE9eRFmOzvxZMsPHDR7QzpeSjcoIW4nOjNuMNjTfP3IDim93
wi3UiSTj6u5TDC9hg/gVlK1/RAm0AkS86I7cqx+GNwbyMqMFQYkWiJPRxUMMoBo5
MyJHyiyc2d+K6rzEUsCgpHCTiVxPIKnKrIdrgzvhXic3XOHGMMTPiBJWZTxOVk9J
fuaNI41E
=adIm
-----END PGP SIGNATURE-----

--Groupsio=M6N8QQelLe1Q4GlOad2n--

