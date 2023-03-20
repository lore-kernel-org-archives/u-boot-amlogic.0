Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.12431.1679315031712347849
 for <u-boot-amlogic@groups.io>;
 Mon, 20 Mar 2023 05:23:52 -0700
Received: by mail-wm1-f50.google.com with SMTP id o32so972216wms.1
        for <u-boot-amlogic@groups.io>; Mon, 20 Mar 2023 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679315030;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKSX/sOzIw4aFU1Lfx+m/zM0/Meyavyej2x5oudpaHc=;
        b=e2aIBDONURJ+44ulx0GfeCkNFXmxkhGDNNgpzu2SmiMLT3ADi29KAW+MInR9JU1ZN7
         ZsEVPyNMQiDlyCSw6K4OQjDeHtPk6ClNiNaB2wnwbF23Oa3z+r0N4O58/nzi3b6w34cu
         a6l2r1vo7bgoZA8BM7HLCKFwnhfU+dnWQ0en7oBeQoxyq1VhNqCWWShe6YbQKk9ELkrN
         YnhGTLQxcv40tcyDCtfrbMvMsQZGCx4QlyNuP5nhLSs2XSgHOtCaSzcKR5t9XadN2wMq
         YwOYtUO+w0Q0fWxAO9Q8pY6lhfIuoKWPdh9bEK9ffT8HnQl6L4MM9salobNDcWT4/UTC
         gTkQ==
Return-Path: <christianshewitt@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH 30/33] doc: boards: amlogic: add documentation for BananaPi CM4IO
From: "Christian Hewitt" <christianshewitt@gmail.com>
In-Reply-To: <5e29634d-0751-5b1b-5bfa-4a85f536f672@linaro.org>
Date: Mon, 20 Mar 2023 16:23:47 +0400
Message-Id: <3CBB7476-13B0-410F-9F19-1323157F1FFC@gmail.com>
References: <20230320114609.930145-1-christianshewitt@gmail.com>
 <20230320114609.930145-31-christianshewitt@gmail.com>
 <5e29634d-0751-5b1b-5bfa-4a85f536f672@linaro.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, linux-amlogic@lists.infradead.org
List-ID: <u-boot-amlogic@groups.io>


> On 20 Mar 2023, at 4:13 pm, Neil Armstrong <neil.armstrong@linaro.org> wr=
ote:
>=20
> On 20/03/2023 12:46, Christian Hewitt wrote:
>> Add build instructions for the BananaPi BPI-CM4IO carrier board with
>> BPI-CM4 module.
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  board/amlogic/u200/MAINTAINERS       |   1 -
>>  board/amlogic/w400/MAINTAINERS       |   2 +
>>  doc/board/amlogic/bananapi-cm4io.rst | 152 +++++++++++++++++++++++++++
>>  doc/board/amlogic/index.rst          |   1 +
>>  4 files changed, 155 insertions(+), 1 deletion(-)
>>  create mode 100644 doc/board/amlogic/bananapi-cm4io.rst
>=20
> <snip>
>=20
>> +
>> +U-Boot Signing with Pre-Built FIP repo
>> +--------------------------------------
>> +
>> +.. code-block:: bash
>> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=
=3D1
>> +    $ cd amlogic-boot-fip
>> +    $ mkdir my-output-dir
>> +    $ ./build-fip.sh bananapi-cm4io /path/to/u-boot/u-boot.bin my-outpu=
t-dir
>=20
>=20
> This should be bananapi-m2s since the same is used, or we should duplicat=
e it for cm4io/cm4.

https://github.com/LibreELEC/amlogic-boot-fip/tree/master/bananapi-cm4io

^ It=E2=80=99s the same FIPs that were submitted for M2S but for packaging
reasons I cloned them (users struggle to find images not explicitly
named for their board). I=E2=80=99ll submit patches for the M2S and M2-Pro
boards once this series is accepted (hopefully).

Christian
