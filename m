Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E68C04FF8
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:15 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.24782.1713283600255483689
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Apr 2024 09:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pm/MrqY4;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-699320fcbc1so24372836d6.3
        for <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713283599; x=1713888399; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zudjLydLlprH1FXH7ANF4MrkoqmWrSa4F0lk9M5Ad7s=;
        b=pm/MrqY4ZNSFPMffXiYDL/7uY9o7EIdHDpbTk9U9eDPRRBucVVjfAAlwGfgzLId4VE
         mrL9mwuYvVdt00ng2t3CM6rpqORj6ycaFTmc+vNVnne08pV9XNr0/36BsF5Yyzc1r5NO
         SO3WB+lMC0xSA5/bIUzP3UeT5DR5OD2Zs4rZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283599; x=1713888399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zudjLydLlprH1FXH7ANF4MrkoqmWrSa4F0lk9M5Ad7s=;
        b=NsMRYndfHKrBp9BsJD0tlUfUm7BoJipG+8wzrBn6aT8yjivDyncmv5Bz8UVaGwTCE7
         SCFHnScMDwjJLhlT9JAKi/RzzhVurx+Ak+n19VXqNMFIyhsKWPDP0e5WCvsCR80k+shH
         /zq5ZKciV+83/lVMDb5yqXvYoAVBRnu60PFh4FbOL7fFstL3qajtFBqmjditWIVBz/py
         TpdiuGkqptfXUHTnKBrzTj3lseRznOuMtBX9nx2fPVBbG6X+e5l0/3W22obF7tdSmyWL
         7b87AIMkxRKY6jt3GibQeR5n3tgl4esZT39uAccQJUXrIu9CS6nNXKpuLC8R5AVgIi9t
         iZYw==
X-Forwarded-Encrypted: i=1; AJvYcCWBz15AcDw2O+1L8z9gWbHRVuVO+xMZ0QFuKLRNbhqIw21Yl4rs7zEIrA8DKC7gc6gH6PJYUyWZnX36smghQVJLTC76Y7Q5sGw=
X-Gm-Message-State: AOJu0Yyjig3G6bvCAsw3DQRHVSoCFErUqOdRg/QwWwPcAE5dXFqDRtKR
	tECjlAQurKTUFFWGlRp5DTJRS55dllU4ja8CRxEXzUqWEs+0eNPNHEa6Sqgu/mA=
X-Google-Smtp-Source: AGHT+IGxRcxCzHs1tvGEv+jXW+Vg+7JJ2kiKVDJLv1TTU36yaq2HZXfkIRRBiavBwttfFKMvBXvxiA==
X-Received: by 2002:ad4:510f:0:b0:69b:7ed1:7a79 with SMTP id g15-20020ad4510f000000b0069b7ed17a79mr673197qvp.35.1713283598702;
        Tue, 16 Apr 2024 09:06:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35])
        by smtp.gmail.com with ESMTPSA id k10-20020a0c970a000000b0069b447066bbsm7595296qvd.78.2024.04.16.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:06:38 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:06:31 +0200
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Aaron Williams <awilliams@marvell.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Anastasiia Lukianenko <vicooodin@gmail.com>,
	Anatolij Gustschin <agust@denx.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Doug Zobel <douglas.zobel@climate.com>,
	Enrico Leto <enrico.leto@siemens.com>,
	Fabio Estevam <festevam@gmail.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Grzegorz Szymaszek <gszymaszek@short.pl>,
	Heiko Schocher <hs@denx.de>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Lukasz Majewski <lukma@denx.de>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Matthias Winker <matthias.winker@de.bosch.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?utf-8?B?UGF3ZcWC?= Jarosz <paweljarosz3691@gmail.com>,
	Peng Fan <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Sean Anderson <seanga2@gmail.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Shiji Yang <yangshiji66@outlook.com>,
	Simon Glass <sjg@chromium.org>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Viacheslav Bocharov <adeep@lexina.in>,
	Yanhong Wang <yanhong.wang@starfivetech.com>,
	"open list:VIM3" <u-boot-amlogic@groups.io>,
	"moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
Message-ID: <20240416160631.GO1054907@bill-the-cat>
References: <cover.1713250508.git.michal.simek@amd.com>
 <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
In-Reply-To: <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=g0qh8MKXuciE0KNLRhhW"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 17:00:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2273

--Groupsio=g0qh8MKXuciE0KNLRhhW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:55:19AM +0200, Michal Simek wrote:

> Convert UTF-8 chars to ASCII in cases where make sense. No Copyright or
> names are converted.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

Now, how did you test / find these? Given names a CI test is unlikely
to be doable but if it's otherwise scriptable I can put it in my loops
and just fixup as needed (like I do today for adding <common.h> for
example).

--=20
Tom

--Groupsio=g0qh8MKXuciE0KNLRhhW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYeogcACgkQFHw5/5Y0
tyyunQv7BArCU1xcrO+M1bVi2Mxx/0iq718pZj7b9yLXe8ArTp+0A2ih7/qm0EB8
MYQpBG4DT+ugG8iLSE6eKhUZB/2niAd06z2rdMCwVgRAT6Qqwhf7T7E+wyJVeCu4
OCkozeNuWZP4qe+NW8R8DkJqVxI7sMk5hLY26H6XIW//GsRCFzLRAr+b8ZlGVBtH
CJ+DSL6gFl2RWP+fqXtr5W3o0J3b6e37u4swFmEvfPR1MqKOFqnWbZJLCgHEDNiQ
An4GZAYiUzpNp5YT73Tf8UPBCBcwR9QWnxK2+4tO3GOCseNGkAcvnuWCCk+Dg5/O
bPIPSR81SDMS5oUQy6OfFdbuPFseWkSWhbV0n6VKKAywo8CvTvHY+LHufST9Gvoo
387W+5/WdRwsiVJRsmtnLbIjavGxpbmpRcVrrvYtsynj0qJBR7pc9uGG0tCdoYGl
Um/2RChbaSIhRfZKCImo6tWTLU9chEBhBzOX7wGJSdkczvHtbMahUnvP8pLt/jMa
JlCQ3PRT
=gijj
-----END PGP SIGNATURE-----

--Groupsio=g0qh8MKXuciE0KNLRhhW--

