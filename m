Received: by mail-wm1-f68.google.com with SMTP id n25so7059097wmk.4
        for <u-boot-amlogic@groups.io>; Thu, 11 Apr 2019 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=CiIZ6USLO5jlbgQx8DjPoFzttBsrsemgKi0i8XxmVbE=;
        b=oY+3hKe3sfuhV4Qx4nNuSJblXCC3JmUDAqpuzB4rtQFtQ/xVAsZd31+fqxK/Kv4RGR
         HBA3AHwXd4gCIGuoei4IEdnOaoOtWperI2utGW7ie7o4jNB9H4gucTPlflULhH8bQsKZ
         JHPgfqsvjg+isRswMKUW5fk0jhNGTnI/5RPkXbKY5rKGI+cye3qk5AcnyryKkM61ZdnT
         2kU9sHI6V606a+qmrlJi9LWiD9BiCjd/5oYTtEzpvi9br5lxW+l0yI90X10TiLgT62qI
         acK1AOixy8AexHK1KvHKJ/HeAEjMT7WbWRqgKkjzSsa1XqYW1f11Z/rO0NQHs8r47Cw7
         iz3Q==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20190411
References: <0ccf82f4-9490-b40c-419a-93eea9691992@baylibre.com>
 <20190411145214.GC4664@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <8af18e5e-cd15-14f2-0a20-b327e837ff1e@baylibre.com>
Date: Thu, 11 Apr 2019 16:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190411145214.GC4664@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=0KeEreshqanqpg6YhtId"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>, baylibre-upstreaming@groups.io
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=0KeEreshqanqpg6YhtId
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/04/2019 16:52, Tom Rini wrote:
> On Thu, Apr 11, 2019 at 01:16:26PM +0200, Neil Armstrong wrote:
>=20
>> Hi Tom,
>>
>> This PR adds support for 3 more Amlogic boards, support printing SoC
>> revision information, add AXG family support for I2C and Reset, then
>> fixup the AXG pinctrl defintions.
>>
>> Thanks,
>> Neil
>>
>> The following changes since commit 48ff1bc4f0a97c3291d0c87c2717fc1d79da=
5ef5:
>>
>>   Merge branch '2019-04-09-master-imports-fs' (2019-04-10 08:18:18 -040=
0)
>>
>> are available in the Git repository at:
>>
>>   git://git.denx.de/u-boot-amlogic.git tags/u-boot-amlogic-20190411
>>
>> for you to fetch changes up to 2c4e3cf21257f962e69264fe91ff2cc23cbd041a=
:
>>
>>   pinctrl: meson: axg: Fix PIN and BANK offsets (2019-04-10 16:54:59 +0=
200)
>>
>=20
> NAK:
>    aarch64:  w+   libretech-ac
> +(libretech-ac)     sandbox_timer_add_offset(test_add_time); \
> +(libretech-ac)     ^
> +(libretech-ac) include/regmap.h:289:2: note: in expansion of macro 'reg=
map_read_poll_timeout_test'
> +(libretech-ac)   regmap_read_poll_timeout_test(map, addr, val, cond, sl=
eep_us, \
> +(libretech-ac)   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +(libretech-ac) drivers/spi/meson_spifc.c:169:8: note: in expansion of m=
acro 'regmap_read_poll_timeout'
> +(libretech-ac)   ret =3D regmap_read_poll_timeout(spifc->regmap, REG_SL=
AVE, data,
> +(libretech-ac)         ^~~~~~~~~~~~~~~~~~~~~~~~
> w+(libretech-ac) drivers/spi/meson_spifc.c: In function 'meson_spifc_txr=
x':
> w+(libretech-ac) include/regmap.h:277:4: warning: implicit declaration o=
f function 'sandbox_timer_add_offset' [-Wimplicit-function-declaration]
>=20

I'll investigate on that.

sandbox_timer_add_offset should not be used here, I'll find out why...

Neil


--Groupsio=0KeEreshqanqpg6YhtId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcr1T8AAoJEHfc29rIyEnRhcoQAL5QAWpyiXOn9zlaewdxP7dr
H0okpPKTOj/dBltniHH/FQbK6JEmpg6DRFkvclj1CuvaUlzJMjumMCtUEP+bThEO
iFGv4GrMt8HUSJScIqiZ6CoDSh8ppIHTaXlCaM+41Zjt3O0rTnn1M4aEf6cuMTwQ
cpwuY+l+UQZYr1b3A4mn9BiPlv+QWeQonD1XrO6z6wYtKK5CwYCoyBLiJblxJ6em
k5/rtQGSfyLqvtFANqUB5Tm4Gm8SlbIsvlLFbvnB5xnHyN1M8HOBn2wOe442FSPG
9lo2aUDNkrT9Qi2TbmnP1kLYEKfPo9J9E//y4KCoc2VaY76F0/uGxqIYKzJ1Wgx1
D+8Mt0BpJo9wZ27hfG7o/eva9K/MhkhOrzZ50M+cNWz3dqz2u+E7uWTM9Y/lX1Vi
fJiLU0q1mD2TFlKY2aXqydFYP3Il8/K6NlDnfSeeGxdMjlo/3YU24XwMtOv65Fj6
/eDkqJDxNhCVFIMBu2sA+Kn+aKkqykLPK5X7P4q3elhWfY0w4Snko/8TqIVzZ50R
M8DncsJzbI5QOh8KoJ1f9/c0JyWXMxJn/frW3cw4Wk0ZyRSL04pt3FfIxQg/xs/B
lHrLuZGstVOFJP76gSD+nyJlXSj8/zJ1Hljh1RbPOIJnwaAasaMjH1+P7ZniNODm
hHIE06rm48+1DuJRL/LI
=2Bcu
-----END PGP SIGNATURE-----

--Groupsio=0KeEreshqanqpg6YhtId--
