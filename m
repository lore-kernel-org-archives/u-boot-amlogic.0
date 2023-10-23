Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D3C25B6B
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 09:09:05 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.126331.1698080327683459186
 for <u-boot-amlogic@groups.io>;
 Mon, 23 Oct 2023 09:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=j4UiV2Pl;
 spf=pass (domain: konsulko.com, ip: 209.85.128.170, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7af52ee31so35157497b3.2
        for <u-boot-amlogic@groups.io>; Mon, 23 Oct 2023 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1698080327; x=1698685127; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ko9XlvHFPJxlI2L65YuIoQ3aajd/bROWlOYAR4wWKA=;
        b=j4UiV2PlA6g3pZGGRWQlxskbw829Vcb5qzbFXPxOTGu86dwfJyikZToMxF/WJqdijN
         6KR3TWo7/MMKN+kuRcV6p4Qh4w6KN4q9G3Qi34NMEhtXPmVjEy5vOJUAyVAZXAH2o5c2
         HCX7fGORzSJ6Cg4nlfwrPvZsVeYiskFrhPNOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080327; x=1698685127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ko9XlvHFPJxlI2L65YuIoQ3aajd/bROWlOYAR4wWKA=;
        b=mivARZeZrPaJVripenhxFi72QbMQc08rTF+4Ew7Ga8P2j8G1Nkhn79b4x6V9ooFAmo
         YK8l/4XB7OTtT5SrakwWkMOA62/m2BaEmyfpZ8EOBCzIxfGKed/BZWV+cJtQ1QdV5Usd
         /gxFJMUJb3IPkGkgDzUk6HknE9WNo4KmxyQpeGkMQ5QFlQAQlWtozS6ysS35srehroFn
         SwVU/ClZemv9z4aQ+ivC93jX7RFGy1W/BdzFIy8m+Bo+6/KwHQyKMX2sOO5eHQ/AEk/Y
         eWbRs6vZHNUxQV2fO8AMVMd8SuzK1OAVvE6QlgxKZmN8OeggqVV1sQ2BGKwkbYNMefXs
         OD4Q==
X-Gm-Message-State: AOJu0YwRfUi49TVReHTDWapAUDVfcA/mNBOsYp13cw2zViq5Pf6WnhCt
	nOfuY9273FHg00dmXFjm6hhaVQ==
X-Google-Smtp-Source: AGHT+IGDk2joj8IXWQ7mckJidp1ddDNrjz3TcGUzt84nsLFsLdqzUEzg22llA2N4G2xrILzx3q9oOQ==
X-Received: by 2002:a0d:d54d:0:b0:583:b186:d817 with SMTP id x74-20020a0dd54d000000b00583b186d817mr10719003ywd.27.1698080326786;
        Mon, 23 Oct 2023 09:58:46 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com. [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
        by smtp.gmail.com with ESMTPSA id p2-20020a0dff02000000b005a7a4e3816esm3291194ywf.89.2023.10.23.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:58:46 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:58:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231023
Message-ID: <20231023165844.GN496310@bill-the-cat>
References: <42fa4e61-93ea-4b99-a5a3-1ffc3ab36cd9@linaro.org>
MIME-Version: 1.0
In-Reply-To: <42fa4e61-93ea-4b99-a5a3-1ffc3ab36cd9@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=WtcHCKNr3c6txVcmIDFc"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 26 Oct 2023 09:09:05 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1799

--Groupsio=WtcHCKNr3c6txVcmIDFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:02:30AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> An important fix for USB Gadget on G12/SM1 boards and a welcome DT sync f=
or the Amlogic A1 DT.
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18256
>=20
> Thanks,
> Neil
>=20
> The following changes since commit e65b5d35c9116485366bb08138043d51220551=
da:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-sh (2023-10-17 09:15:56 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231023
>=20
> for you to fetch changes up to 14a21f1a80afc58d52dc72e35f27d3a47d36c082:
>=20
>   arm: meson-a1: dts: Sync DT with Linux (2023-10-18 09:46:01 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=WtcHCKNr3c6txVcmIDFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pkQACgkQFHw5/5Y0
tyz4igwAs5F4pJqW9pMLaoD39YaJZ13BMDMG4a9qSOy+D/n0+baWgaOaWHCxcInN
KAF3fUvc2E8UGsJogRH/g3CSwt83tOhZGa0U1k8YG4UFWtJCn3Nxw13jz58vJeQ3
mRsRG97lq3B/7smxP3FTkmZylxPfYf7gDHAtuTaeTqivFD76iBkt2VmTGqsA0uSC
0JatAn7cWWBHRUtYOK6GeJVgzXzd6z7euM7RD74Wh5KuVjpQVPZ2m+VOhVf8I16M
e8fj/En4qMYX9BfFLfOx5t6fmDMUMO3gWuww5gYRDq+mUlFSJVgS8xBRXtZyEFyL
1rR+EpJcDZBOmRZ0+fR3Du08ME7SufyKtYqYs0WB+ERwZiOCoVVYNVwMECLtckvz
cB/1sPmyeQ+pZt0EzLS6xz1WZ+7F5rPti5bc5lyGYqtC6Otzhap8KZWteWEkJiKs
SmVIpNrwjKYJrEKWAPhWcDmmSGrsCVRgd/YYvlPqafzAowPo1DEiVwGqeuFeCZEY
jmkSXBMa
=TJeW
-----END PGP SIGNATURE-----

--Groupsio=WtcHCKNr3c6txVcmIDFc--

