Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2328CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 07:17:56 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.181201.1697491891758427274
 for <u-boot-amlogic@groups.io>;
 Mon, 16 Oct 2023 14:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sCx7WR82;
 spf=pass (domain: konsulko.com, ip: 209.85.128.176, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7af20c488so62072127b3.1
        for <u-boot-amlogic@groups.io>; Mon, 16 Oct 2023 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1697491891; x=1698096691; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/gAf/EABho+QTfFripeOBlDO7xxuYzMfx/GcCZgmJE=;
        b=sCx7WR82z+qA3BLu89gZS/UVRIiSFuHmyB2OOOXWDODoXW6psZOB1OfCdpyFnW3cuw
         8Yjlz6gIfw93np2sI1jMonaOkUsoILez/4o8bXiAh9ZeP/m4A5sGQboZ7p93uuIg0NJm
         VPV/PG2WVYeUhRkNzKC8Fl8XFiX5qHdvfCJ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491891; x=1698096691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/gAf/EABho+QTfFripeOBlDO7xxuYzMfx/GcCZgmJE=;
        b=UFCD7dGVXfFE7yMGef84pMblNPaVVTOEWprdou7jH27esRq42tIDLcEoXM7LozKkcU
         O42ZKRIMQRms+NDPt/r/NlJiTeZgedyrYt0wbXJEwQ8u/C4H4lxpr/vTjbT1bq3TpCJk
         jiQXGrLhp4UomS975zQOkkJbktZaxWRrxBcnzs/OoGRDWBH8E2lO5YClmH2LUZW15fjG
         NYpvOHCxsApUhcqONMl03TTewdD3JDNsoYlW/zVIeOuSJXy+OYRKko7dibVI8cn0hx4f
         SvwTUib5reMOHAyNoWonYW21VTJc+qzydlH3nu+EoPb7Pzu20F24IWKwuY5ZZMrDyGRq
         bPxQ==
X-Gm-Message-State: AOJu0Yxb2qFr5Qaw9UEczQdZtXq1oKmDeR5A+x1QtgkcNStAZStu/7Ol
	5cRzs+xOvfvFj/wenMVN+hnwGw==
X-Google-Smtp-Source: AGHT+IHBWBz9G66m+zFcBe9wXEqYolCoHi34ES48TOsxVax3oxsyhb50xLxHCpOfL1G79OYqDht54g==
X-Received: by 2002:a0d:df49:0:b0:58c:b8b4:2785 with SMTP id i70-20020a0ddf49000000b0058cb8b42785mr389942ywe.45.1697491890896;
        Mon, 16 Oct 2023 14:31:30 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com. [2603:6081:7b00:6400::f48])
        by smtp.gmail.com with ESMTPSA id o187-20020a8173c4000000b0057085b18cddsm33263ywc.54.2023.10.16.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:31:30 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231015
Message-ID: <20231016213128.GG3119521@bill-the-cat>
References: <555f51df-c50f-4118-bf74-3619965cd828@linaro.org>
MIME-Version: 1.0
In-Reply-To: <555f51df-c50f-4118-bf74-3619965cd828@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=TW2rYB2wW2LGGQRr32so"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 17 Oct 2023 07:17:56 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1760

--Groupsio=TW2rYB2wW2LGGQRr32so
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 08:48:06AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A set of changes mostly concerning Amlogic A1 & S4 SoCs for USB, Secure M=
onitor
> and RNG bringup.
>=20
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18138
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 997bef3c6d22d12c7fd092fb831bf94d114c9f=
6f:
>=20
>   Merge branch '2023-10-11-port-gen_compile_commands_py' (2023-10-11 13:2=
5:01 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231015
>=20
> for you to fetch changes up to 7cd53e0d5203f8e25bb69d2e675769888fcbc754:
>=20
>   arch: meson: use secure monitor driver (2023-10-15 12:23:48 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=TW2rYB2wW2LGGQRr32so
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq60ACgkQFHw5/5Y0
tyw9KQv/b/u9f+J3xK5NxblPBD5ZM8y4r8TWs5FMVgVMMTwkE3YiuKcH/IWsm9DZ
WUUlMUxxPp2HpcMYzLZu6JA0Ga/rixasNBGrV3wv16Kx9ixriP5IZu1+RApzjCns
2Yn5BUfmbnIgBCMadpNsEYGQQqT4ANgq04GlOvXcY3iTg6FiMvVZRsg+5u9Blzfx
lVHVjzEtcA+FlJWmC/AcvcR+fG6KEgjJw85yG9qCySxFeL/rssODPf4X8oHdaZ7l
eejLA7OFiMvvRp8x8ebvXuS/EpnU16baqZhJ7sQFqLVS9QaFg3DzH5rTxeUpAPjI
vq+7ZN6ul7fHsE60M9SKThDRxIJ05eKIdrIp1HfV0ZPTrbl3lRDymT8BqXLyCqAu
Yt/cfYzcn/C5UU6L/MaTI1GyHL20JfnD7cDPrUkVpP96kbL1z4x7zxMG3GNc2nkQ
CwL6veRyer9W8+/7F3HGneFarYLcQUvE0osa+SuI+hT2uNe5okjPwl2gl2lsDW48
PTQYoL6s
=V8y4
-----END PGP SIGNATURE-----

--Groupsio=TW2rYB2wW2LGGQRr32so--

