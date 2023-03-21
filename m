Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.5972.1679375463198202989
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 22:11:03 -0700
Received: by mail-wm1-f53.google.com with SMTP id m35so8777090wms.4
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679375461;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCtWwQR28Tf7UMC/1iAqkjlhqVHUlwW/Ubw19PfkJIY=;
        b=eiH13baf9XvbYOtixpZdx6iT9FxgMS/+Cf3V+wNSt2y0sN66RF6nKo44Z/IYBjD6JR
         e/gb40Kb2GhOCHMwq7GKgPxLQI0POhGWIPD7b2wswBFg9xqCtYH5v01tMmqis3CInio2
         oh1WpwDEL3b91e89mBZwk/sOoHeUHCfnH4UubLymCjuVi8N4jNgbnqi25vj6soLrBH9G
         GCLB70NM7wa80lpGMb9VG1KV/GVAyzf1sTTZv1Rkfh0AXr/f+cpCKDpl/xgT7ttt8NqI
         EXAfAk0PCrDjBXTVlui4EyoqQUICp0Bj535kCl757L0Cuc4IQgFELsxigFMncFm9cbT9
         UfCQ==
Return-Path: <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH 29/33] doc: boards: amlogic: update documentation for WeTek Core2
From: "Christian Hewitt" <christianshewitt@gmail.com>
In-Reply-To: <CAPnjgZ1HW1x3CJ27icDifh4+hjUJjpwCM--FtatzJhrWjkEueA@mail.gmail.com>
Date: Tue, 21 Mar 2023 09:10:58 +0400
Message-Id: <4DEEACF6-2D41-499E-A2E0-C2DD31E28B03@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
 <20230320114609.930145-30-christianshewitt@gmail.com>
 <CAPnjgZ1HW1x3CJ27icDifh4+hjUJjpwCM--FtatzJhrWjkEueA@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>


> On 20 Mar 2023, at 10:40 pm, Simon Glass <sjg@chromium.org> wrote:
>=20
> Hi Christian,
>=20
> On Tue, 21 Mar 2023 at 06:05, Christian Hewitt
> <christianshewitt@gmail.com> wrote:
>>=20
>> Improve documentation.
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> doc/board/amlogic/wetek-core2.rst | 83 +++++++++++++++++--------------
>> 1 file changed, 47 insertions(+), 36 deletions(-)
>=20
> This should really move to binman. Would you like to take a look?
>=20
> I sent a patch for this a while ago but it needs something to review
> and try out.
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20220110031413.1970836-3=
9-sjg@chromium.org/
>=20
> I am happy to do more on it as needed.

Hello Simon,

For now this is just a cleanup but longer-term (won=E2=80=99t be quick) I c=
an
take a look. Do you have that series rebased against current and in a
repo somewhere for easier cherry-picking?

Christian
