Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE4CD1296
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 15:11:42 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web10.2665.1712364229744660570
 for <u-boot-amlogic@groups.io>;
 Fri, 05 Apr 2024 17:43:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dOmL0u92;
 spf=pass (domain: konsulko.com, ip: 209.85.128.176, mailfrom: trini@konsulko.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6151e2d037dso31204337b3.3
        for <u-boot-amlogic@groups.io>; Fri, 05 Apr 2024 17:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712364229; x=1712969029; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8vBL4b0RJV08YyaiA3px4pJnJfKLmKkGgPlD2yQT6JQ=;
        b=dOmL0u92XixVhrpqd9cbZ1gXvmp52zVmMjZOW4eofuDCIzIzJ4g0NEE17I+fBD3SMV
         q5YtP/E7P9zHZU/YEBg8rNPbY5QAgbw5MgZhIS1DQ24xtp5QBccsdk65sQZAzr+cc1YL
         uzozvQ1Vbg4e4z5Oixw28+AFwLXlIal2abpcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712364229; x=1712969029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vBL4b0RJV08YyaiA3px4pJnJfKLmKkGgPlD2yQT6JQ=;
        b=G1sa3gDiDxsAjkf9wnOnNNccOjrBNQGm17361iIfD8kHagLWcIuiaHbfHluLpQtyMW
         M6Yx/V7XzZ4V/u/HWWNKCmJ69cTMD20wg8Lpk0XYJKP0OZTk7fBriyxzbN9Yd9NXvZDZ
         gbylclcwvyYJr4U3xtfuYdu2UlALZde2U3tQOgFAKPQa2QL8DV0lZvQobY9fWa3yFTkR
         IT5g4KfPj0bYoNYpZIS1EyhliZjCu71g3hvFZeIxs/jNCnOh4MZCc/bR2b4kolXR7Esb
         xSSYX3MuTDHJfn9wlTGaN3z4d9tWUArg8MKvAnL8FTRMmaVkTS9thcgrgz6l3tgioGPu
         PBrw==
X-Gm-Message-State: AOJu0Yz9nzlH4j7UgV237kcLaXLMQf/APEAYH5FJpRZhK/VvvsIrALXB
	e5loTfiEZtgBdYbKI9JnhHffNNI/llgYus0vLmWVAWCCF1AwQV77nRictR69iJliX22XeI+AMbt
	++uY=
X-Google-Smtp-Source: AGHT+IGjOWjQkD+5XSKbNE1NQ3bOBPUfzJ/IV3qfqNRS2edwn4b1CCUxd2llOtOkS+DnaTqiL5t3aQ==
X-Received: by 2002:a81:c251:0:b0:60a:2c16:da3f with SMTP id t17-20020a81c251000000b0060a2c16da3fmr2964497ywg.28.1712364228933;
        Fri, 05 Apr 2024 17:43:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
        by smtp.gmail.com with ESMTPSA id ew10-20020a05622a514a00b00432bcd630c8sm1243539qtb.93.2024.04.05.17.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 17:43:48 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:43:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20240404
Message-ID: <20240406004315.GC114971@bill-the-cat>
References: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
MIME-Version: 1.0
In-Reply-To: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=2BedWudwWlmM07IZnLOh"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Tue, 09 Apr 2024 15:11:42 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2268

--Groupsio=2BedWudwWlmM07IZnLOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:52:53PM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull this migration to OF_UPSTREAM for all Amlogic SoCs family
> except the newer A1 family.
> In Addition, there's a few fixes & updates for the jethubj100 board.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea=
1a:
>=20
>   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu (2024-04-02 22:37:23 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20240404
>=20
> for you to fetch changes up to 114df8b5339e503b50b6ac1a61bf1daac57c2e11:
>=20
>   dts: meson: Drop redundant G12A, G12B & SM1 devicetree files (2024-04-0=
4 18:48:46 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Groupsio=2BedWudwWlmM07IZnLOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQmqMACgkQFHw5/5Y0
tyxu6wv9GcxGpcELDwU+mn70PrdDGHUQ/Z2uC42t80etcf8BzDrBELby47wVzJ+R
STJ1I9EINjyYKFBJPZlG17PZ/GOcOiWpaAkbEdsIj+skLzjVkQ559Azg6Nw1LTRW
46QvPAlraIAHJ/RkOI1qzJ0SzZUlMgRtIoMdsTGTtmdacp67oyLlLXwEShIfGQ93
64brsQEVyO9nCUa5GbWnd7vPVqglk2Y7TdIqfAQTdHk02wFOCD2/6zVRhuhsPS6E
wWR/oslI4msoBf5ySbCLH+LRU9/mYu5QIFA9sSh3sreME7AL4O5Ykof1FqRF1nA3
cP++5wuGWue+q+z+A80tOlIeeQ1P5tEg0KOvHnIgverxyR18w2Qgid7JiPtKX5un
db2wjDrQi63gHgmo5Q37wP6PHVE/UFo9XchL+awYdRFJU3QjKZfn1gtVTkha0xbI
uQstaVxPYII1T9fnEgLYqrfgKAm2PPBPqxxuSaxu2NU91fuccbaRLQArDw30tMl8
nJa394uW
=rA8r
-----END PGP SIGNATURE-----

--Groupsio=2BedWudwWlmM07IZnLOh--

