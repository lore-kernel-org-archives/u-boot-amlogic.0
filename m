Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D63C4332F
	for <webhook@archiver.kernel.org>; Sun, 29 Oct 2023 14:34:15 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.35873.1698454261816107332
 for <u-boot-amlogic@groups.io>;
 Fri, 27 Oct 2023 17:51:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IFzJVr9Q;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7781b176131so179528385a.1
        for <u-boot-amlogic@groups.io>; Fri, 27 Oct 2023 17:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1698454261; x=1699059061; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaRG/avuTv5thM0LVFZL6X7q5POE8HT5+/B9sVSvo2g=;
        b=IFzJVr9QJCr5tvadETyn8U0j3sidHAFLYYyZsmL5JkaiYWlquyIP/edRiQF99PVP9t
         6mMf8JWbi0QBLm0xIDSoWrFdaA7kCNR1S57zkZrDwJSvtHQsBVm/b0XlX1mAPOFUB6C/
         N6aoTamBwQ5xRlZFWQI1k6i+7091tpRgJFCnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698454261; x=1699059061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaRG/avuTv5thM0LVFZL6X7q5POE8HT5+/B9sVSvo2g=;
        b=f2BYmPeVamoKuhZ0d0Zw76aYtmFBm9a++L5pNcQ44UfeDcxECInLlGGHFB2FlvieqU
         6lfu7hNBrZ24tZTPCqNILfnf97zMqB4a6bv4MDOsPHWWBMvIEM9MGyzbISHPupYBN1SP
         jHEdRiZJI6RfBe5wqvkYr6r0ceMHIYIZmX4CYf+nOfisBXCQ7Lmn+vEFr1Y/i71cvjr/
         MlvimdT/o4mwxoRCBGIborELNZR3YqbAzsD9Gu3db0UTZ/sHNCKC3PZOxMjuevEZBqkS
         oGbHIPq4wA7jPjzdW7SgyXiASiqNBM6smt3WPgGkC0SdtJDQ9wvUgPVN7ES81kLp2Mxp
         mSCQ==
X-Gm-Message-State: AOJu0YxNokOi3EPd1OJno3Dsyr2/8zuj4q4FT0FYMFdQ/U+FnpDdjUYd
	ZifeaEiLpjmpDZaF4r92jY/JVA==
X-Google-Smtp-Source: AGHT+IGxRFm2+7pkCkNa7RUCH8vf23NrppI3nzBPu1s9QmVO8xkn4AArjKLCDIG7QVD2Eau4gT4Cdw==
X-Received: by 2002:a05:620a:2a11:b0:774:3963:41a5 with SMTP id o17-20020a05620a2a1100b00774396341a5mr4523763qkp.13.1698454260926;
        Fri, 27 Oct 2023 17:51:00 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com. [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e70c000000b007770673e757sm1050695qka.94.2023.10.27.17.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 17:51:00 -0700 (PDT)
Date: Fri, 27 Oct 2023 20:50:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231027
Message-ID: <20231028005058.GE496310@bill-the-cat>
References: <4839b54f-1e61-4c46-b1ed-40a2ea0f9c08@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4839b54f-1e61-4c46-b1ed-40a2ea0f9c08@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=EEiFDRnYcl3kdDDnQ6fI"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Sun, 29 Oct 2023 14:34:15 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1807

--Groupsio=EEiFDRnYcl3kdDDnQ6fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:38:41AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> A late PR to:
> - fix environment saving for new Android boot features on vim3*_android
> - Add SPIFC support for Amlogic A1
> - Add DFU RAM boot step when booting over USB, fixing full USB boot for G=
12/SM1 boards
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18322
>=20
> Thanks,
> Neil
>=20
> The following changes since commit fb428b61819444b9337075f49c72f326f5d120=
85:
>=20
>   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-2=
4 19:12:21 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231027
>=20
> for you to fetch changes up to 892e04bc965400772e1b84e6450a7919deca0e0b:
>=20
>   ARM: amlogic: ad401: enable SPIFC (2023-10-26 17:56:58 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=EEiFDRnYcl3kdDDnQ6fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU8WvIACgkQFHw5/5Y0
tywdNwwAlaoPyHh3HTSbXyohw2fq1XQCg38haLkcJkx3Db1zWm/FlZ+QOcJGknOD
3bcSAyX8HOzYFTb5IANVQIkZpo+8MgQhLE+GRysNTq0xKuwxnAl6l+EtAtbuyENy
NPdY0aCLtnHU6jmDr5+OF4vayMsauUwxMBpz2mIt9jgb7gs2hJDJ/HRSI6mbw/HS
GiHcszULP/1mxfKaNMKCuhpcPw+6uj6tcyb3CXEPjw/5Ayp/FcjtcpGINEIoP9/z
oaZioBR8UJ7W131hwRDQxUIbLx/UdVICuiRFdLaGcmAC6Ja8ljFcniHNEZpbmgBv
+EooI5ikjRFArkH7KwpNZp/J1H2kiCq3aMmtIAS8RiGO2kAep2MEWnArqoWTQc+f
MeBOWl9WFuzZnW17f3TzGiLSly9aLIyoWCKKVL4CGfMSel3XFSs9KERpy2/xq16G
GpIb2t+oW7T02lNlE0mXSAxvQgM2ur03a0erq9L72GY5Xw8zdK8J0vF3184kwzxf
Y1rnYxPs
=5MBd
-----END PGP SIGNATURE-----

--Groupsio=EEiFDRnYcl3kdDDnQ6fI--

