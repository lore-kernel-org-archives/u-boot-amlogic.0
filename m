Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.7165.1614068435628115378
 for <u-boot-amlogic@groups.io>;
 Tue, 23 Feb 2021 00:20:36 -0800
Received: by mail-wr1-f44.google.com with SMTP id y17so69945wrs.12
        for <u-boot-amlogic@groups.io>; Tue, 23 Feb 2021 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=ujMZzzFybnMf/RKZvPRQUSL2T5PuxjCoB6tuu8XFSXo=;
        b=M9m55lSNwyyfI3DThvq/yqeKUc4OUaitK1KEpoot2PVq8FZqJOUYvz9TrgBAp7AgvD
         9KvvLV/Xoy1v79QAlntR/fd17dGWLJoTUbVH7krT4XI98FaXwk7bWYOr/5WlVj2fabun
         krs+H7YpPBC70tLYv8gZZqXV+Pol1C6JHPMLG00I3xuACOOECjWvzhdiG9qIkBMnSHrv
         YFFWrDQVmVKqoZ5Ppo1ofRnaVVscB6XnC2MCp0p4dqQs726DR7A8N1ufD0WKeB+op0J4
         W5c5Ezkgi6rzOsEcf6deHU3NuwGSdITaDbGhqhPtc0gyfnkzFPp6kCByB7LFCAmlLDFl
         iRQg==
Return-Path: <narmstrong@baylibre.com>
Subject: Re: [PULL u-boot] Please pull u-boot-amlogic-20210222
References: <2417b7bc-0dad-64ce-c4a9-ed4d9851df44@baylibre.com>
 <20210222200304.GO10169@bill-the-cat>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Message-ID: <31900540-ae20-2a45-6863-60db4ab07949@baylibre.com>
Date: Tue, 23 Feb 2021 09:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <20210222200304.GO10169@bill-the-cat>
Content-Type: multipart/mixed; boundary="Groupsio=TICZWyGrobEUgfI6Fdnp"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, U-Boot Mailing List <u-boot@lists.denx.de>
List-ID: <u-boot-amlogic@groups.io>

--Groupsio=TICZWyGrobEUgfI6Fdnp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/02/2021 21:03, Tom Rini wrote:
> On Mon, Feb 22, 2021 at 03:30:36PM +0100, Neil Armstrong wrote:
>=20
>> Hi Tom,
>>
>> These changes adds support for reading the ADC key on the Khadas VIM3 &=
 VIM3L, in the same
>> time it adds plumbing for ADC keys and a test for sandbox.
>>
>> The CI job is at https://gitlab.denx.de/u-boot/custodians/u-boot-amlogi=
c/pipelines/6461
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
ot-amlogic-20210222
>>
>> for you to fetch changes up to 2d339efb1ff941705a770e93494427912689ce18=
:
>>
>>   button: add udevice forward declaration (2021-02-22 11:07:57 +0100)
>>
>=20
> First up, I've applied this to u-boot/master, as there's some small
> problems, but I don't want to make you recreate the tag.  That said,
> running ./scripts/checkpatch.pl -q --git on this shows that the ADC
> changes all add "treshold" fields, etc, and not "threshold" fields.  A
> follow-up to fix this, before the misspelling propagates more would be
> appreciated.  Thanks!
>=20

Thanks for seeing this, I'll fixup ans resubmit !

Neil


--Groupsio=TICZWyGrobEUgfI6Fdnp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmA0utAACgkQd9zb2sjI
SdEnvxAAqwmqKcJg1nWvewwpkFrulttStV3Z/sXcmRxQu3KWcqGJLrutC3pOMv3G
EhApnhmWnDabgTTw+0n5ZuvpEthNeOMijMMMC85/ENcYYZvZNA8Tmijee7q2LG7K
CVOTfJfPiIQGi/I/EvEikC7TGueiOkXAXlrsX5P9nYrlrCWfMgKBNZoyVvu6y5w8
cfpmyRkwZJKY5sSnIndEoZplvAcMgWu+riItgzTxm96QpZDg2C1HiMrmLT3ZX03r
pl/XfyJKb8wJbJsNU8OjK5cM2f+UXlj8kuVLtR18iktG6EtPz09WShROuoTmzIlr
pTppO4bW8McYoOkqqX+2txZhfN5x+9claYs8eOtcm1pNQ07S1yPGkQr31n1DvmYi
yEsaCMDLnyf6LgEreib4Mgn8wLPkI5g0e440dggCNAMEcWNDNHnSs6edgUej0FnQ
lW3C8RXING2iv2+Z2FrnSQxBqXpYW93/u/wstar8Xj4howYY9pVk/H1lete3hC2F
J5IN7R6fuclgN4YPYlLMN8V5NkgJc9qUfj1LhoGZRzN9aw2HlKRHmT4FvPrCEmNH
5Zc4UAQuyqWxFJN6JICV/7g27mfkSLKZUaGZyckA42qEhgogje3yEgpkcPyXvzJ3
xEXAemFAcaHJ5ZNMrEuxvsESVBRMeiI4Q4rsdp472/F46h6WmeE=
=2hSD
-----END PGP SIGNATURE-----

--Groupsio=TICZWyGrobEUgfI6Fdnp--
