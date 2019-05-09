Received: by mail-wm1-f66.google.com with SMTP id b203so2128774wmb.4
        for <u-boot-amlogic@groups.io>; Thu, 09 May 2019 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=uQsN1Zwg4LGAsqQ7tSkFR8rtlz5RB6b9QoFd72mW6zU=;
        b=m2XQ93joFdsp+xfueRiUCLHFge1d9ywwzL8obNf6UYvphoOQ0NK08nNfFBxsEb3mE7
         dL9L+9jPTnv31BJsDWImcl0/USKKPYGeHIiJmOPS+yKKSyiO3MNoS3EZSgdIVbigglJg
         Z4UEduf3yx9+FjkWdJfORmGzO2kE0crmway/LK2sKQzHbIpznqYa9tL6SZwpfOXoOfWq
         c2tmaQp8sMg4R6vvijHvt/MWeHCMmWZ4ltactJFXt3oMTEwTXookrwbgC//TYQAbF5oi
         m2JUhlYWJlhhvZ6yrb5YxHVv/sD8SihTU70lKM6U1gUj9Pg3Onj3Bw367Wq5GjYlO7xJ
         ponQ==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PATCH v3 0/3] ARM: meson: Add G12A USB Support
References: <20190507084339.14723-1-narmstrong@baylibre.com>
 <037a2b22-393a-7df6-9217-5ae797ef5179@denx.de>
 <7156ec2e-8180-6f18-13a9-43829c002428@baylibre.com>
 <d84fff92-914f-0709-570d-f4a113478766@denx.de> <20190507175422.65af8731@jawa>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <38ce1af2-82bd-f753-9a75-687eee93926b@baylibre.com>
Date: Thu, 9 May 2019 10:44:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190507175422.65af8731@jawa>
Content-Type: multipart/mixed; boundary="Groupsio=YvJK63Xcp1ywCApk5Lcz"
To: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=YvJK63Xcp1ywCApk5Lcz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Lukasz, Marek,

On 07/05/2019 17:54, Lukasz Majewski wrote:
> On Tue, 7 May 2019 17:16:52 +0200
> Marek Vasut <marex@denx.de> wrote:
>=20
>> On 5/7/19 5:11 PM, Neil Armstrong wrote:
>>> Hi Marek,
>>>
>>> On 07/05/2019 15:05, Marek Vasut wrote:  
>>>> On 5/7/19 10:43 AM, Neil Armstrong wrote:  
>>>>> This patchset adds support for USB on Amlogic G12A SoCs.
>>>>>
>>>>> This patchset is composed with :
>>>>> - PHY Drivers
>>>>> - USB Control Glue driver
>>>>> - G12A board setup for Device mode
>>>>>
>>>>> Device Tree nodes will be added in a separate patchset when
>>>>> applied on a tagged Linux tree.
>>>>>
>>>>> The Amlogic G12A USB Complex is composed of :
>>>>> - 2 USB Controllers :
>>>>>  * DWC3 for USB2 and USB3 Host functionality
>>>>>  * DWC2 for USB2 Peripheral functionality
>>>>> - 2 USB2 OTG PHYs, only a single one will be routed to either
>>>>> DWC2 to DWC3
>>>>> - 1 USB3 PHY shared with PCIE funcionnality
>>>>> - A Glue to control PHY routing, setup and OTG detection
>>>>>
>>>>> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs,
>>>>> including routing of the OTG PHY between the DWC3 and DWC2
>>>>> controllers, and setups the on-chip OTG mode selection for this
>>>>> PHY.
>>>>>
>>>>> This drivers supports the on-probe setup of the OTG mode, and
>>>>> manually via a setup function in the G12A common board code.
>>>>>
>>>>> Changes since v2:
>>>>> - rebased on u-boot master
>>>>>
>>>>> Changes since v1:
>>>>> - switch printf() to debug() in patch 1
>>>>>
>>>>> Neil Armstrong (3):
>>>>>   usb: dwc3: Add Meson G12A USB Glue
>>>>>   phy: meson: add Amlogic G12A USB2 and USB3+PCIE PHY drivers
>>>>>   mach-meson: g12a: add DWC2 peripheral mode support
>>>>>
>>>>>  arch/arm/include/asm/arch-meson/usb.h |  12 +
>>>>>  arch/arm/mach-meson/board-g12a.c      | 126 +++++++
>>>>>  drivers/phy/Kconfig                   |   8 +
>>>>>  drivers/phy/Makefile                  |   1 +
>>>>>  drivers/phy/meson-g12a-usb2.c         | 216 ++++++++++++
>>>>>  drivers/phy/meson-g12a-usb3-pcie.c    | 345 +++++++++++++++++++
>>>>>  drivers/usb/dwc3/Kconfig              |   8 +
>>>>>  drivers/usb/dwc3/Makefile             |   1 +
>>>>>  drivers/usb/dwc3/dwc3-meson-g12a.c    | 456
>>>>> ++++++++++++++++++++++++++ 9 files changed, 1173 insertions(+)
>>>>>  create mode 100644 arch/arm/include/asm/arch-meson/usb.h
>>>>>  create mode 100644 drivers/phy/meson-g12a-usb2.c
>>>>>  create mode 100644 drivers/phy/meson-g12a-usb3-pcie.c
>>>>>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
>>>>>  
>>>> Looks good to me, pick this via the meson tree please.
>>>>  
>>>
>>> No problem, but Lukasz wanted to pick it up.
>>>
>>> Lukasz, I can push it through u-boot-amlogic tree, is it ok for
>>> you ?  
>>
>> I don't care either way, whatever is comfortable for you two.
>>
>=20
> Yes, please - use the u-boot-amlogic tree. Thanks in advance.

Done, thanks.

Neil

>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
>=20



--Groupsio=YvJK63Xcp1ywCApk5Lcz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJc0+huAAoJEHfc29rIyEnRte0P/jOTWNtQuCyoDahfaM0WiK39
NGaWd/9wVeTmiEW16ZabfZiUinUiSR9xXQHreOEG9xj2jR5bTH+Egae6ZEw0xhyg
5EBkBpgZNgNG2UlJc0bhqdXOvgAKVCC9boCwLPHpf1ie+qf6xS7gq6LRQDvywj8Q
oBXtkaQcUgQ2iHZRk31+qh62dqz2zORyRsmzcp5IATr9D+OeAqJYqRyHTLV4nHf5
pqVFAzNFW73SLsV3XOuulQcKGKpncGukWtVcteWlQC5+s0aZ6SFd86/2i3MmdMor
nckq812BbeTUTNhzkR/fPoWXy0pMojQh/wLLvkIJ2AUWjj5/QfF+7vDrPhrLMPBL
KJy3Cs0WkhciBhNdWYGNW9f/Ve67dAarkCUlw3SMxC6nA/ckc5qEgMEbzWkmips/
zEdepqGwk5SxBKcWvUDOs0ZvwriKAS+5RPWJ2d2czz3LbfPtfThhvnyDgmHapWP7
WH1RbCbMWnhxy35y6Ft5S5Gm+c3b3gLQR4Wk2JObqxLl2gJbTC3LHkQ3Iw16J2PC
5kRnCe3b02d58n/yG9GlShof5Zwahx2ld0W/U2B/eFh7LZA+ob2PpkFThKFEii2k
GArhrw8vA1lnMF7lSMXhfuDzW5xQmu8FLhDf2m2ZG/m3a7V7WQgKUjICiBHA636s
oASOsnqpBet2rUBf/grD
=Dnja
-----END PGP SIGNATURE-----

--Groupsio=YvJK63Xcp1ywCApk5Lcz--
