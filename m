Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E58FC61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:39 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27595.1787678105801099579
 for <u-boot-amlogic@groups.io>;
 Tue, 25 Aug 2026 10:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gJYkgWGH;
 spf=pass (domain: konsulko.com, ip: 209.85.221.171, mailfrom: trini@konsulko.com)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfb3347dc4so53827e0c.0
        for <u-boot-amlogic@groups.io>; Tue, 25 Aug 2026 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787678105; x=1788282905; darn=groups.io;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ir2wCyQQmdW+QgpPWYm8Q+UL+tNRwMhvcqFSqNBTYl4=;
        b=gJYkgWGHNnkiV32Lr/eHcNp7CyAUfNpYOGdX2IGZwuTdFaVrFcfRjf2h5tSevFC56w
         j9MYBLtmiYZCEyseY33uXAg9UcgsCUKpT/x8K4wtO7XVclSzsYQ0eTnxwY7WweIiayiS
         uSCjshq3jKsaYAAZ6jXDqDSpAMSle6b3sX91o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678105; x=1788282905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ir2wCyQQmdW+QgpPWYm8Q+UL+tNRwMhvcqFSqNBTYl4=;
        b=icFuj68ufaVqfxIiSug68ud5mR0/TxUAXHjAl/t0vT94C5RoRPLPxtsS4tAbtDTnn7
         3QTQClqK7yQf8xxslgDnNe9DNzS4pPrcV/FsBd4KWfB7CRinL7BO+q3CTJISw2n8Ol7e
         4ZqxtF2feLGFLeEztFttp8vpA+bZ23sTQ3RuaBrFYTmsD4x4lKNTpdLMo8ORu2XXQd6N
         bUcsJ62qS4+450cCFiez973BNVRH3K2iGi4eE0WqHLZ43Fb2wiW2a/FcUy2RzN0PQyuO
         GPgJokadFYxThxV4h6LY/NCHmWhWqNyqYMECgIxTUFuDfASrgEuv60TQQxYHqt6Z7GXN
         32+A==
X-Forwarded-Encrypted: i=1; AHgh+RqY9XbsxjQd5gsc0t/JhX88DTW+6gKQI+8RMsec+YbJR5DYN3cwsNiY/cFoB3oOq7xoRgIz0PQW2hpdEEE0BA==@groups.io
X-Gm-Message-State: AFuF++m7evSb4baFoPyT1L3acSKyDAZYBmd/rebYJwSCxLDTfkFKsUqk
	CbUlIPKystRBqoy2zZUPBoGBBY2IJe8vMlhypUjuFU7/bOAEiSBr8OnT/g5OJF68Q6PZUJn94zv
	OU4xGS6EfqzKb
X-Gm-Gg: AR+sD13X2X2PW7OyraRfx250hSY+19IhW/vBcZI336+ZWr8VxXrg8N2+TtRrHs1INBx
	jI2e/cidOmoAMghuqLEcIvT0QW+3CdSFergzSB6qSBJHQpPH1RdZU17GK9ev3K+6lpwXpE1K0Cr
	Wwz1DSgabirQlXPzcRR7jV9/60zG6rUyXGAAt1jOI8vMpmzXX9LGY/ljqJqIZD8Z+p/luA+/upd
	CqLAe0HYRb5/LldlsKqGpzw9J1A0wIObuqmpAhu83UUPVkvEXP9MUjgZ9Gr4PkPY5qvtt+Znnpb
	zL3zht1fWO8kW8l9L13Cm7Tqe2ttqqBmatr75QqGaOCMwJk0AHnAiJArdpPu4a/a5bN++MXS4bb
	LEmQRGyPhZA+BQJ/qeyz8c48aQKrxsL8TrqqfuLLw76SdumS288j9hsAi+iC49y5WTRg/rDY2hN
	1ItHNbHClaeN+ue1DwjG9EUIoXAG3I3gLogJuefHmeSRKFRz2csceB1OBeZFtonIJTj+qg8FNOM
	k+HKBSka33JDuyAAktz41Ep/X0jh/QRXPGAyNQNZmR6sonRfa+PR/g6asKWvjCEUIL8duA6k3fC
	RSHYE10c2hQ=
X-Received: by 2002:a05:6820:5710:20b0:6b1:2d0e:ca1d with SMTP id 006d021491bc7-6b1a03d48aemr186063eaf.4.1787677685051;
        Tue, 25 Aug 2026 10:08:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a0278f18sm82250eaf.12.2026.08.25.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:08:04 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:08:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io,
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
	Simon Glass <sjg@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Viacheslav Bocharov <adeep@lexina.in>,
	Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Peter Robinson <pbrobinson@gmail.com>,
	Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH next 00/45] doc: fix some issues reported by linkcheck
Message-ID: <20260825170801.GW523975@bill-the-cat>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
Content-Type: multipart/mixed; boundary="Groupsio=MdtGZDKZaAfIi0f0Zc9t"
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Wed, 26 Aug 2026 13:42:39 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/3067

--Groupsio=MdtGZDKZaAfIi0f0Zc9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 06:49:37PM +0200, Quentin Schulz wrote:

> Saw a dead link and made the mistake of running `make linkcheckdocs`.
> Now I'm knee-deep in it and cannot ignore all the dead and redirected
> links. A day later, I've had enough so this is what I managed to fix in
> that time. There are many URLs still redirecting (could be fine, but
> needs to be individually checked as some big companies have a tendencies
> to redirect to generic pages instead of issuing 404s...) or returning
> 4xx. The issue is that those 4xx also need to be individually checked
> because since the AIpocalypse has started many websites now have web
> crawler protection in place and linkcheck will trigger those and be
> denied access (or be heavily rate limited).
>=20
> Please be mindful and only run this script once, save its output and
> work on fixing individual errors without rerunning the script, otherwise
> we would only participate in hammering websites even more (linkcheck
> runs multiple workers in parallel and retries when rate-limited).
>=20
> Note that linkcheck doesn't check for links in code-blocks so our
> instructions may point at dead links also.
>=20
> At an attempt to avoid tens of people running linkcheck at the same
> time, here's the output sorted and filtered on !ok status:

Thanks for doing this, it is helpful and appreciated.

--=20
Tom

--Groupsio=MdtGZDKZaAfIi0f0Zc9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3L7QAKCRAr4qD1Cr/k
CszNAQD1v3U0BUMeH3iX1RMMSuczjI9DeLPkoxndz//Wh4UxCAEAw0Iksq08nPff
dvw7i6j5VqwcO3rfmiCud88tTPXXmAg=
=EPdk
-----END PGP SIGNATURE-----

--Groupsio=MdtGZDKZaAfIi0f0Zc9t--

