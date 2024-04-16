Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245BC05052
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:15 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.25709.1713284896096470622
 for <u-boot-amlogic@groups.io>;
 Tue, 16 Apr 2024 09:28:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FuO9ydea;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: trini@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-696609f5cf2so26581606d6.3
        for <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713284895; x=1713889695; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqcHMg+io5TRH47p0UVmvNME9n6tMmHq8yiZwGXoRr0=;
        b=FuO9ydeaWJH6ON6TtGlN0Xkq14zeXyXv8Yii0tTRQzX0b7pTZk2paX24t3R8GuzW7a
         1822wjMLUhGeZeoIiKZ21u8B1QkcjB02z1awSf+QwF3ptMPNk8EjGEU8wfIPAiSuCwqw
         7dnWDS8IXO59iqTGKUt9SS/oR3CiCyXLfsd4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284895; x=1713889695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqcHMg+io5TRH47p0UVmvNME9n6tMmHq8yiZwGXoRr0=;
        b=kkojh5n480rPV5HsULL8JNgF4bFXVTTT5vYK5T9hS3PNK9dYiPkLTYd4KXhZITQ0M1
         YUsq5wIqsF2BnAPi2b8HGt95+34IV6YhrqTpGFHXvkeD35BU0wqff5FIqucvWePw7iFS
         iILR226xGHhcNemn/8D5Y4RgVHNlAuSG5BRHieoxUD5UFC42UqSqJTwMr4esoce7EvRd
         LJrUBLoYUR6HVhb3eGLXabJkfdt+Ip3XHF39pTUH6adkIflXJgL6HPrTarfdPei0mc08
         BScb90WMg6kBf+qIBjR+8ZQZohT9slsMKvoZXfTheKDi3kh1mhPDk0DUZ6QpE0JWPcbM
         riwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4S3ScxFRMOwOBF0Y2aeMHz0WcZ+6/M1bx6JCbV4Rzd5wU2JNoYoiOnipv4u9wXAz4BZ22MVDP317WwclSK/7H1X/gdSDtgLg=
X-Gm-Message-State: AOJu0Yzvgc5hlaW0G5HNjsUjbxzsumfbnYMF9V94HiK0wRPB566khVds
	aGz8PCIV7vDBerAsENPg65SDVzu4Hbp4qHJGUZd6TlCbSqJBNHD8fFjs5GzqOPg=
X-Google-Smtp-Source: AGHT+IEL94VJrEVoPYjUqrOkB9/X0f8WrQ+EyhOfaP3jywV6st9dfv8dm8YAc3A5xO45C2b2nfOdlw==
X-Received: by 2002:a0c:c60f:0:b0:69b:2aa8:dc66 with SMTP id v15-20020a0cc60f000000b0069b2aa8dc66mr12430164qvi.28.1713284895011;
        Tue, 16 Apr 2024 09:28:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35])
        by smtp.gmail.com with ESMTPSA id gs15-20020a056214226f00b0069942a53f46sm4709704qvb.53.2024.04.16.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:28:14 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:28:07 +0200
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
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
	"moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
Message-ID: <20240416162807.GP1054907@bill-the-cat>
References: <cover.1713250508.git.michal.simek@amd.com>
 <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
 <20240416160631.GO1054907@bill-the-cat>
 <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
MIME-Version: 1.0
In-Reply-To: <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=RSMzDK3k0rBBwjtxxMb9"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 16 Apr 2024 17:00:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2275

--Groupsio=RSMzDK3k0rBBwjtxxMb9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 06:19:48PM +0200, Heinrich Schuchardt wrote:
> On 16.04.24 18:06, Tom Rini wrote:
> > On Tue, Apr 16, 2024 at 08:55:19AM +0200, Michal Simek wrote:
> >=20
> > > Convert UTF-8 chars to ASCII in cases where make sense. No Copyright =
or
> > > names are converted.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > >=20
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > Now, how did you test / find these? Given names a CI test is unlikely
> > to be doable but if it's otherwise scriptable I can put it in my loops
> > and just fixup as needed (like I do today for adding <common.h> for
> > example).
> >=20
>=20
> There seem no to be too many non-ASCI strings outside of comments.
> Should we care about non-ASCII comments?
>=20
> $ find . -name '*.h' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./include/configs/tec-ng.h:13:#define CFG_TEGRA_BOARD_STRING    "Avionic
> Design Tamonten=E2=84=A2 NG Evaluation Carrier"
> ./arch/mips/mach-octeon/include/mach/cvmx-pko3.h:369:   MEMALG_SUB =3D 9,
>      /* mem =3D mem =E2=80=93 PKO_SEND_MEM_S[OFFSET] */
>=20
> $ find . -name '*.c' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./drivers/mtd/nand/raw/nand_ids.c:65:   {"H27QCG8T2E5R=E2=80=90BCF 64G 3.=
3V 8-bit",
> ./drivers/video/dw_mipi_dsi.c:861:MODULE_AUTHOR("Yannick Fertr=C3=A9
> <yannick.fertre@st.com>");
> ./board/bosch/acc/acc.c:440:    .SRT =3D 0, // Set to 1 for temperatures
> above 85=C2=B0C
> ./cmd/2048.c:65:                                printf("   =C2=B7   ");
> ./cmd/2048.c:79:        printf("        =E2=86=90, =E2=86=91, =E2=86=92, =
=E2=86=93 or q        \n");

I think we need to keep the "2048" game ones as it's part of the reason
(can we display certain things properly) it exists but comments and
general strings should be fixed. And I think I can use the above
examples to put something in to my scripts to catch new additions.
Thanks!

--=20
Tom

--Groupsio=RSMzDK3k0rBBwjtxxMb9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYepxEACgkQFHw5/5Y0
tyxKngv+KN55TwUiPhzrmZO2E12hsvfYQydZ4xJsZ4fieMjAzsN54feusrRz29cQ
hjWIR8ZsIHFVdZ9nMAuI6jB1Oz1W8Y2ku5CgHRjq7J5Qybtu5Wr4x9myGNjPaUVz
UaatipZz0t6ENjMt9R0UAON15wZeX8tjsSIvs2Rv82sznSSUYxICnUkPgYDO1ace
MQjpWgQlqx/0p3wmmDd9GCCgxL3EAzvMAvZ0LifmJtwQFo1XzZ8T2gRaWMtUhjKQ
FcNwnt8oWFTwfwE7H1G97vopNTI5aOeeBmZTOdKBrbr4bf1BEXiUDIKVtYORtzJA
Zh4gz0l6TBMuZd3hXn9KPh8zr9GiK3mPOXqdF8guY6T9qh8n3hvvEHVEdw8JOzqs
eDOCHo418A33Ls3uHyGVzuCkia+CAE/EqF8fe13TqBKE/G5kjUUE1C5PMFPYy2TM
JGdiGIc0PFpScZIjvly818MwfH248mbI6ApQq0o8KG9p9Osl95D6kkBraJYSF+Xh
MYkTRKnc
=ZzGS
-----END PGP SIGNATURE-----

--Groupsio=RSMzDK3k0rBBwjtxxMb9--

