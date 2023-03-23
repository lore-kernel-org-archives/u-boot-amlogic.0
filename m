Received: from m239-7.eu.mailgun.net (m239-7.eu.mailgun.net [185.250.239.7])
 by mx.groups.io with SMTP id smtpd.web10.66780.1679555525829592884
 for <u-boot-amlogic@groups.io>;
 Thu, 23 Mar 2023 00:12:06 -0700
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1679555523; x=1679562723; h=To: To: References:
 Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From:
 Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=nIjx6vc9YmKyqvtaMg4lkFxKKT31vtia/D8IY56o1NM=;
 b=VTcj15KuVOyvADYAB5DEjuWXwLWEtBvy37pJBMoYW6vaxfhPNlXjanFz4ygDwGhVuOWGaJUak65biXsa3NP5at2ajMwMg9FWXCSbHf4VcmvuGX9e1tnJGOleUhhIL3w4ZUD4BQtXrWPumEEJGIods+5Iguls+3Knq7QFwWtMGnqI6sGdfpmu5BLEBfQ37OcGamQaxioNltdGWSh6vfXHP8/4uI5T8KHCrLMf4TdZg12eEImA/Vaz2OQcGJxlNHGo82Otx1ZawWdU0AvDMro59/EnldRPYqTrPaYB3GxGYLMIO1Csf7aW/BYVw41kOZIHBjBYeR4WqDurhT9mLOpR7w==
Sender: christian@hewittfamily.org.uk
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCHv2 0/3] ARM: meson: Add initial support for beelink gt1
From: Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <KFid.1679512628339564284.oldC@groups.io>
Date: Thu, 23 Mar 2023 11:11:50 +0400
Message-Id: <CFFE1487-C407-4DA4-9A24-3D49D629D260@hewittfamily.org.uk>
References: <KFid.1679512628339564284.oldC@groups.io>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: u-boot-amlogic@groups.io, exkc_maillist@list.ru
Cc: Karl Chan <exxxxkc@getgoogleoff.me>
List-ID: <u-boot-amlogic@groups.io>

> On 22 Mar 2023, at 11:17 pm, exkc_maillist via groups.io <exkc_maillist=
=3Dlist.ru@groups.io> wrote:
>=20
> Add initial support for beelink gt1
>=20
> Signed-off-by:  Karl Chan <exxxxkc@getgoogleoff.me>
>=20
> ---
>=20
> This patch is base on this patch from in pm os .
>=20
> https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/u-b=
oot-beelink-gt1/0001-add-basic-support-for-beelink-gt1.patch
>=20

Hello Karl,

You=E2=80=99ve submitted each patch with the same subject/description; each
patch must have its own subject line and description of the change
in that patch. You can use the git log to crib the format from the
previous submissions.

Your changes need to be rebased on [0] which had a large patchset
to revise documentation merged yesterday, so the doc patch will not
apply now.

I=E2=80=99ve revised and rebased my original Beelink GT1 patches [1]. You
are welcome to pick/reuse/reauthor them if you like. I have sent
the other boards in that branch to the list this morning.

Christian

[0] https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commits/u-boo=
t-amlogic
[1] https://github.com/chewitt/u-boot/commits/amlogic-next-chewitt

> ---
>=20
> .../dts/meson-gxm-gt1-ultimate-u-boot.dtsi    |  7 ++
> arch/arm/dts/meson-gxm-gt1-ultimate.dts       | 91 +++++++++++++++++++
> board/amlogic/q200/MAINTAINERS                |  2 +
> configs/beelink_gt1_ultimate_defconfig        | 85 +++++++++++++++++
> doc/board/amlogic/beelink-gt1.rst             | 65 +++++++++++++
> doc/board/amlogic/index.rst                   |  3 +-
> 6 files changed, 252 insertions(+), 1 deletion(-)
> create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate-u-boot.dtsi
> create mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
> create mode 100644 configs/beelink_gt1_ultimate_defconfig
> create mode 100644 doc/board/amlogic/beelink-gt1.rst
>=20
>=20
>=20
>=20
>=20

