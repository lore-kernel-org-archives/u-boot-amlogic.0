Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6405AC61DF7
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 13:12:47 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.11700.1700228532845009459
 for <u-boot-amlogic@groups.io>;
 Fri, 17 Nov 2023 05:42:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tYFn+LW6;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: trini@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77891c236fcso121368185a.3
        for <u-boot-amlogic@groups.io>; Fri, 17 Nov 2023 05:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1700228532; x=1700833332; darn=groups.io;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfyDHB+N3owUK8W8VFcS2jYrYFuPnpyV0JdX32dFYyo=;
        b=tYFn+LW6C7/SuZbwlmAaeipWL1ZuJ5Q1VuP82BH94joSPbYuxD+9bbT1kjSvwvO0NR
         9iRwJmUrMP+CY9Y0CtZkMC0I29haHMVynt6YNXMs6t71UX1eCDP8bACSXje2T4KE8NSL
         b6Xfxv7bTqXE38C8T4lebHSbrBIg+VMlagN/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700228532; x=1700833332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfyDHB+N3owUK8W8VFcS2jYrYFuPnpyV0JdX32dFYyo=;
        b=ummLH0E707Qmq6QApfrlbFHHl0o3G7HIHDDkCcLY+KK2dIAlg3cx2CZ5Kirn3Q9azp
         zDukHvxz5vZIpB4KgnOX7vOkCQG1sPbLpcBysoUh3XQICuCjM5nza/OvBzo7lSG2KbNE
         E56BJiGRBAKKFZRUugC5ZyDRWXli8c+LhyHvpIHY/E3WvpIjbqA0XKLtCG1uc+Tc1+UQ
         rb3Ng36elYDkfd9nsSbXXbT4fJM4vOjOs+mbFhOND2YPcqSrHSlgCG18M3jgGJ96LQYG
         xzyMVYlIGAql+C61Q9XuTFacw6u6F9cR98vmmukBsPW16qri1j5sRBPqOkguxNCoqSxQ
         OkMQ==
X-Gm-Message-State: AOJu0YwccdxBorGZPZHe7fuJXhZm08CCrrQsTE7L+GI7uZNhQgK6O16R
	1GU6bJbjIV/nF5oL5w/eJySJgg==
X-Google-Smtp-Source: AGHT+IH3we5nSR15aJk11C4O0myLBh51z8mPGsa1uHDGjh7m7AAuYM6gdc+opITGTPIEHbQZ1FjU8Q==
X-Received: by 2002:a05:620a:1790:b0:765:aac3:7667 with SMTP id ay16-20020a05620a179000b00765aac37667mr15256405qkb.0.1700228531895;
        Fri, 17 Nov 2023 05:42:11 -0800 (PST)
Received: from bill-the-cat (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com. [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
        by smtp.gmail.com with ESMTPSA id rg3-20020a05620a8ec300b0077a02b8b504sm604954qkn.52.2023.11.17.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:42:11 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com,
	Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	u-boot-amlogic@groups.io
Subject: Re: [PATCH 2/3] spi: meson_spifc_a1: Use define for time interval
Message-ID: <20231117134209.GV170968@bill-the-cat>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109200943.2.I02c5c81c1a5a06b51600672691f448909af473ea@changeid>
MIME-Version: 1.0
In-Reply-To: <20231109200943.2.I02c5c81c1a5a06b51600672691f448909af473ea@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=3YH9mFqGGfprlZnZvqIM"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Thu, 23 Nov 2023 13:12:47 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/1881

--Groupsio=3YH9mFqGGfprlZnZvqIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:10:03PM +0300, Igor Prusov wrote:

> Use USEC_PER_MSEC define for timeout to sync code with Linux version.
>=20
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Groupsio=3YH9mFqGGfprlZnZvqIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbbEACgkQFHw5/5Y0
tyyfSgwAr1PEdp40UgE0vOg+plgq1LIGvOAJh09pJCVy+hlRSjc5imzI1ORcBcoY
apB44dexXv1Y+iB9FhOiV0ya6+aGigjG34+35rRXSR4ZtqTCycEinVXiFsl2Bnst
FgyYVB3mntfcOS1Nwq0pg64g/R7SpVihfbVo5UskF2on4+zaKZOW6ifud1Gh8rJ9
qEk3c3YAB/ckhSRXY1QpcH6S5yOiS91lMrTfK6JazInnLP1j9JyyNHPjkdiSgO4V
ednHzwQz+rtJqPzFC8YEr36gv7EnUvjvuCjwow6L7nJIu6FTRMEcDJkBlETBdkHf
6934Oa/mRvpD5RNj8OP2OlcmBic4rJV++oclDFZDY8Gy6NiC8rbHJVFDfJCNDFgw
DvnZPXCsaO7kVNWynATTCbN+Pl50ewdrKclud1SNKIXtgSlrx74X9N5FO8xYQBTk
3hfz/LWHrR+6MhBd3hy/1Z5qymmbN9aBEgqj6Ey1SyM3prqZ6XRV2tIVP7/m+65s
+mV++4YS
=rmHF
-----END PGP SIGNATURE-----

--Groupsio=3YH9mFqGGfprlZnZvqIM--

