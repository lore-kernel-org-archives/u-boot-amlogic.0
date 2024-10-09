Return-Path: <neil.armstrong@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D61CFC500
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 07:01:02 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.18601.1728485383875701661
 for <u-boot-amlogic@groups.io>;
 Wed, 09 Oct 2024 07:49:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@salutedevices.com header.s=mail header.b=F2VrZyVv;
 spf=pass (domain: salutedevices.com, ip: 37.18.73.165, mailfrom: ddrokosov@salutedevices.com)
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7A46D100012;
	Wed,  9 Oct 2024 17:49:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7A46D100012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728485380;
	bh=ijUwT2DqMD1I4Z1/bu8+z55HnX+8TSBWLq4TV5OInTY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=F2VrZyVveGVrGP95b/+Pnc0xZLtehIwKtEftMpEk5YFBjIM+s3zdWvE27IO2HJy0U
	 LLt2KYmmxeIOUY+Ikyk6C7pWoJE+f9P/vkUwCVxl2frXt+OaEZO7n6qjxDKbw9yvX9
	 BY6/dx21QixE0F49vmBx4QmJLjphtMJB8XnbjCSrhKN8vWvl5gimQ9avGT6Sc3Szwp
	 7s3TyYNBvAyTkdjzVQBB/Tx5pcLNeA6XDv1JnayZ6V9d58X1wkgmC2RcEcEV2comQd
	 iduyOPW7NNKkijP5zF7e1b3n33FSCY6GCdE9yMCa+9CB03WWc/ajt9oxHd88BLWsnd
	 RR9CNgJn4nbJQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  9 Oct 2024 17:49:40 +0300 (MSK)
Date: Wed, 9 Oct 2024 17:49:39 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Guillaume LA ROQUE <glaroque@baylibre.com>
CC: Igor Opaniuk <igor.opaniuk@gmail.com>, Mattijs Korpershoek
	<mkorpershoek@baylibre.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Tom
 Rini" <trini@konsulko.com>, "Andrew F. Davis" <afd@ti.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, Mario Six
	<mario.six@gdsys.cc>, <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
	<rockosov@gmail.com>, <kernel@salutedevices.com>
Subject: Re: [PATCH v3 0/6] android_ab: introduce bcb ab_dump command and provide several bcb fixes
Message-ID: <20241009144939.kqlhop4amwgqioup@CAB-WSD-L081021>
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <c3dae5c8-6465-471c-b262-99b925eeac37@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <c3dae5c8-6465-471c-b262-99b925eeac37@baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.226.150]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188334 [Oct 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/09 12:25:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/09 13:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/09 13:11:00 #26724486
X-KSMG-AntiVirus-Status: Clean, skipped
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: <u-boot-amlogic.groups.io>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <u-boot-amlogic@groups.io>; Mon, 14 Oct 2024 07:01:02 -0000
X-Groupsio-URL: https://groups.io/g/u-boot-amlogic/message/2469

Hello Guillaume!

Thank you for the quick testing results!
I really appreciate it!

On Wed, Oct 09, 2024 at 04:05:51PM +0200, Guillaume LA ROQUE wrote:
> Hi,
>=20
> just test this series on Khadas vim3 board and it's working fine
>=20
> bcb ab_dump mmc 2#misc
> Bootloader Control:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [misc]
> Active Slot:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _a
> Magic Number:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x42414342
> Version:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> Number of Slots:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> Recovery Tries Remaining: 0
> CRC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xd438d1b9 (Valid=
)
>=20
> Slot[0] Metadata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Priority:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Tries Remaining:=C2=A0 6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Successful Boot:=C2=A0 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Verity Corrupted: 0
>=20
> Slot[1] Metadata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Priority:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Tries Remaining:=C2=A0 7
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Successful Boot:=C2=A0 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Verity Corrupted: 0
>=20
>=20
> Thanks for your patches.
>=20
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>=20
>=20
> Le 08/10/2024 =C3=A0 22:18, Dmitry Rokosov a =C3=A9crit=C2=A0:
> > The patch series include changes:
> >      - move ab_select_slot() documentation to @ notation
> >      - move ab_select command to bcb subcommands
> >      - introduce the ab_dump command to print the content of the BCB
> >        block; it's useful for debugging A/B logic on supported boards
> >      - fix the slot suffix format in the ABC block to align with offici=
al
> >        Android BCB specifications
> >      - add a test for the ab_dump command to verify the accuracy of eac=
h
> >        field within the ABC data displayed, it's also useful for testin=
g
> >        slot_suffix problem code paths
> >=20
> > Changes v3 since v2 at [2]:
> >      - return "Legend" block for bcb command
> >      - additionally, verify the CONFIG_ANDROID_AB configuration alongsi=
de
> >        CONFIG_CMD_BCB to ensure that the A/B scheme is used for the
> >        designated board.
> >=20
> > Changes v2 since v1 at [1]:
> >      - move ab_select_slot() documentation to @ notation
> >      - move ab_select command to bcb subcommands per Simon and Mattijs
> >        suggestions
> >      - redesign ab_dump as bcb subcommand
> >      - use spaces instead of tabs in the ab_dump command output
> >      - print hex values in the lowercase
> >      - add RvB tags
> >=20
> > Links:
> >      [1] https://lore.kernel.org/all/20240725194716.32232-1-ddrokosov@s=
alutedevices.com/
> >      [2] https://lore.kernel.org/all/20240911214945.15873-1-ddrokosov@s=
alutedevices.com/
> >=20
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > ---
> > Dmitry Rokosov (6):
> >        include/android_ab: move ab_select_slot() documentation to @ not=
ation
> >        treewide: bcb: move ab_select command to bcb subcommands
> >        cmd: bcb: change strcmp() usage style in the do_bcb_ab_select()
> >        cmd: bcb: introduce 'ab_dump' command to print BCB block content
> >        common: android_ab: fix slot suffix for abc block
> >        test/py: introduce test for ab_dump command
> >=20
> >   MAINTAINERS                               |   1 -
> >   boot/android_ab.c                         | 116 +++++++++++++++++++++=
+++------
> >   cmd/Kconfig                               |  15 +---
> >   cmd/Makefile                              |   1 -
> >   cmd/ab_select.c                           |  66 -----------------
> >   cmd/bcb.c                                 |  98 +++++++++++++++++++++=
++++
> >   configs/am57xx_hs_evm_usb_defconfig       |   1 -
> >   configs/khadas-vim3_android_ab_defconfig  |   1 -
> >   configs/khadas-vim3l_android_ab_defconfig |   1 -
> >   configs/sandbox64_defconfig               |   4 +-
> >   configs/sandbox_defconfig                 |   4 +-
> >   doc/android/ab.rst                        |  12 ++--
> >   include/android_ab.h                      |  17 ++++-
> >   include/configs/khadas-vim3_android.h     |   2 +-
> >   include/configs/khadas-vim3l_android.h    |   2 +-
> >   include/configs/meson64_android.h         |   4 +-
> >   include/configs/ti_omap5_common.h         |   4 +-
> >   test/py/tests/test_android/test_ab.py     |  31 ++++++--
> >   18 files changed, 252 insertions(+), 128 deletions(-)
> > ---
> > base-commit: fbe16bc28014dc1ed957f5fee7e53d6eee781aa9
> > change-id: 20241008-android_ab_master-d86d71c839ae
> >=20
> > Best regards,
>=20
>=20

--=20
Thank you,
Dmitry

