Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.10873.1614092790659458093
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Feb 2021 07:06:31 -0800
Received: by mail-wm1-f46.google.com with SMTP id p3so2730302wmc.2
        for <u-boot-amlogic@groups.io>; Tue, 23 Feb 2021 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=rZ3fXtmXxwtTBPtC7d1mn00eYv1FEBloGYQJmbYAf7U=;
        b=frQ1KmDzBh7Nqs96FSoSkAs+OLAfFsXpclY7jaEkcJPd5Qj2NVfXkhpGOr1w9b/C2u
         HEfW90IzkG9WNUIuo1aUpP/noU81LIqs80KaZC6eJ9QW3NbNovU+3F2rX/fcOZpz/PrC
         CwhZHPgNIjOF506KXRQDejLx10L32T2SaMn7LQR6qqlYttRUqhV2Z7yDIk+gR1cGD7S8
         YvdIbqfpSWb7aiNJnGDoOmohkHV8rNYrE22q6DGh63uVzIbPuFL8wcTwvuo8dZKOroQv
         sY7dVLgIRlSuUGrOJEbXgGXK47ryIqxYisVnZbZFMxdNlmudg+STOXltPAR5x/noRfvy
         xX9g==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210223
References: <37445fd3-321a-21ee-8813-81ac50244d6c@baylibre.com>
 <20210223150409.GW10169@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <ef96309c-2b0a-ff79-b849-43cd45078e91@baylibre.com>
Date: Tue, 23 Feb 2021 16:06:25 +0100
MIME-Version: 1.0
In-Reply-To: <20210223150409.GW10169@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=08SJx7mJ7etpsuylq93C"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=08SJx7mJ7etpsuylq93C
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23/02/2021 16:04, Tom Rini wrote:
> On Tue, Feb 23, 2021 at 03:58:25PM +0100, Neil Armstrong wrote:
>=20
>> Hi Tom,
>>
>> These changes adds support for reading the ADC key on the Khadas VIM3 &=
 VIM3L, in the same
>> time it adds plumbing for ADC keys and a test for sandbox.
>> This time with s/treshold/threshold/.
>>
>> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogi=
c/pipelines/6480
>>
>> Thanks,
>> Neil
>>
>> The following changes since commit 496f49464d90b564da5f1a2f4eecb5553e01=
edf9:
>>
>>   Merge branch '2021-02-16-assorted-improvements' (2021-02-16 15:14:34 =
-0500)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-bo=
ot-amlogic-20210223
>>
>> for you to fetch changes up to ceeb50b3bf074960ddfa541b7be3732b38e15c99=
:
>>
>>   button: add udevice forward declaration (2021-02-23 15:55:53 +0100)
>>
>> ----------------------------------------------------------------
>> - adds adc-keys button driver
>> - fix meson-saradc driver to get reference voltage
>> - add adc-keys test for sandbox
>> - enable adc-keys for VIM3 & VIM3L boards
>> - fix button.h build
>=20
> I applied the PR yesterday, so just an incremental change to fix the
> "treshold" thing please, thanks!
>=20


oops I misread, pushing asap

Neil


--Groupsio=08SJx7mJ7etpsuylq93C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmA1GfEACgkQd9zb2sjI
SdFxDQ//XJ0EC4i4vgMMPDUAqjkI/Hgs7Tu5J7lIm1Hyw3T85FFvtoaldjeX/7lG
zqwhcplZ3DOSYzmw5zpO+TGsVid0UKIm8w/w3endMGpwrRR0F+ZeSLS1BlAaW348
CziBawEV8jfumAk9KNgCvqmmEVG8j5TyuBkVpkSzx1LyqOexyzv4oHomDQW6LvML
c0HpjWGRfIuxQJyPLwaUgp1x6flT6DG5/6Y+Pt3NCOSUxPOE9gzvdmJqrpXcX+OP
p0rH8XTHGuBYRkO1xth3eeKVji/Lc3q/kQRYoEDwU1+cClh8CYtOGYnRXluAb+tU
2mtThUARqGtbEnNrmFQDm0aNAIVcPtXAiZNIIFsbpp5cpMn/WucB/CY/0Bcz0AvC
X/ChAVAoLOe+SosMLhlte+FWzGotNlgjBEdETi2oWtJ2YfR9mB6PehAMPFqKMq7I
U6m88uvsQs8DE2pFDJMbFT0pk/dgO3TEVUNaVAYd9m9DDBhcSD+Do502e60qpMLG
KpaHu45ZWufAAvJAw7Y8DBhSpXoDn2uRkoodAISo1uRohxTt2ePfRC/SgzB/qJ29
/WjwXLjoJqUGllRTGdVsjH/uF8//G6s2ie1/KXfJpKoh23oUjNe6T1rT02B/Md+w
w5UEPIC1NSiP8NWu+wZZppCZgS6FR62UC6ZAEKIw2GX3eSp50J4=
=Bl4H
-----END PGP SIGNATURE-----

--Groupsio=08SJx7mJ7etpsuylq93C--
