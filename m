Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF06C46CCD
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 14:41:39 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web11.23486.1702564038632904272
 for <u-boot-amlogic@groups.io>;
 Thu, 14 Dec 2023 06:27:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XVY2yhGr;
 spf=pass (domain: konsulko.com, ip: 209.85.128.172, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e2e873ed29so17242717b3.0
        for <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1702564038; x=1703168838; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1rT4X24RxFTVAeVxlohuRYtYsDoo/0UaWUuOpzhbBk=;
        b=XVY2yhGrP4W6GxubjQrh/wU/t/AdFFDN4TXFSIGGrwKd9GPeY2mDiWzl/bIndyCjkV
         apzES8S6hqoqhjHwXZ+H3QWix29Le11ZuD9XPjR7940UZmniWmpBoNIbjCd3h0vn0Ki0
         wCI730gH0RwhYl3LjZ9HpYt47tV8nU0PLLSbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564038; x=1703168838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1rT4X24RxFTVAeVxlohuRYtYsDoo/0UaWUuOpzhbBk=;
        b=A9PllhW654oWLoYX4MSrKcxtdTiJWKjGy7cUhmIi9VSU15okPWbQIkF2eVoB4iITAu
         B2NoZwAvFO6BhyJgWbszn5Y11JHnpFfq7fD1F37cXE9Ep7jz/2O5bXCe+DI6dQ6ZcVpt
         3kumMtUZXPIKASJkRIHEOEaVH0sFyZRbcocCi6Wkq4ewO5ggQghA5FW+cqZQHl7DtoMs
         LZUx9C9g6rWhv6ZkeQ7TJ6zUonkzVs2pqBzWAEL6Cj1DJb2fx8rQ2j6milemr4giNC6q
         JMfBZ0Z2qZrX2jZhgf1tQKPNkMmIvdOSbtb5gqxhRlYlE+YQhQs3oBAi0UxuCsrSkBqu
         GSUg==
X-Gm-Message-State: AOJu0YyKDSzrgjEx/Cpmdt4IyXvwZj9RVu91ZKOQ3Ypvkyo+QcXJC1va
	dWtNmvmGGY5XV5Am+vcyYo5xEg==
X-Google-Smtp-Source: AGHT+IFdGe/aNYSRbcyQON5YvCW/CXqM+sNraLlFKAjTEj+yurI5A5iO+c+KLXW2v3xawcoT5QBHzA==
X-Received: by 2002:a0d:c044:0:b0:5d7:1941:2c34 with SMTP id b65-20020a0dc044000000b005d719412c34mr7893253ywd.97.1702564037744;
        Thu, 14 Dec 2023 06:27:17 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com. [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
        by smtp.gmail.com with ESMTPSA id n193-20020a0dcbca000000b005e2e8b26925sm1200969ywd.61.2023.12.14.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:27:16 -0800 (PST)
Date: Thu, 14 Dec 2023 09:27:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
	u-boot-custodians@lists.denx.de, sjg@chromium.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org, neil.armstrong@linaro.org,
	caleb.connolly@linaro.org, ff@shokubai.tech,
	daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
	pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
	maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
	michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
	peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
	marex@denx.de
Subject: Re: [PATCH 1/8] Azure CI: Exclude devicetree-rebasing subtree for CONFIG checks
Message-ID: <20231214142713.GZ2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-2-sumit.garg@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20231214135103.1606605-2-sumit.garg@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=0r3Qa1nTyXYd4J6qUVGO"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 14 Dec 2023 14:41:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1925

--Groupsio=0r3Qa1nTyXYd4J6qUVGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 07:20:56PM +0530, Sumit Garg wrote:
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .azure-pipelines.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index d6f3fa423c6..f100c4493e6 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -65,7 +65,8 @@ stages:
>        # have no matches.
>        - script: git grep -E '^#[[:blank:]]*(define|undef)[[:blank:]]*CON=
FIG_'
>                    :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
> -                  :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
> +                  :^include/linux/kconfig.h :^tools/ :^devicetree-rebasi=
ng/ &&
> +                  exit 1 || exit 0
> =20
>    - job: docs
>      displayName: 'Build documentation'

The GitLab tests needs an equivalent change.

--=20
Tom

--Groupsio=0r3Qa1nTyXYd4J6qUVGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7ELsACgkQFHw5/5Y0
tyy8xAwAkJMrVTvV1C6S5lnwh7Mmpy5A+CwcKAs49b6s2TLAISy2hgCMmzuNxm2c
V34luEX2TYSLP94sa8lvEHUUrr+59FTLa4FXMXQeme+9VfPtpMdVMIhk1uqFGvJG
J0Tpnaxjeh/x3Uu+TXwA/xWvtpQj1OwS39YNzS2DrK4zu1LTxZ/2sLA/siE3gQ75
mWjjgUFupW8t5A1qQOaYHeBhYI4nCwhY3525IIu3hLHpZyIHbsSw8uATR1h2afN1
f/urLS0FzpvN6HX3AZFkwlHHD9doxmPDIvej6HEZSlzk51wbAnxagnNT9mI70b+F
LEbhX5449eC4B+DRSMgfnJRwmZw5fQm2xQEgZPNz4iE/JC02ErXPX6VAmChtMpSH
E1LiFPIS2Tyi/X++Uya+yEioUL5Pe+ozNuOx6bzE2ggph2/nyHNaf3D6A+kQ3PVl
94QHPKsL5CKJQdH0WmzRMNVXWPjzeV+cnalaUX+d5NXjzjPBmLh4mu9pDzNh+AM0
pdf7z7VQ
=4UIP
-----END PGP SIGNATURE-----

--Groupsio=0r3Qa1nTyXYd4J6qUVGO--

