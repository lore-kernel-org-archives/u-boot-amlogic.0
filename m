Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mx.groups.io with SMTP id smtpd.web12.7927.1604642261171479882
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Nov 2020 21:57:41 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201106055738epoutp04f5d2bfcc8dead602a1d4fc98f4d3631e~E1aH_MF0B3102931029epoutp04C
	for <u-boot-amlogic@groups.io>; Fri,  6 Nov 2020 05:57:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201106055738epoutp04f5d2bfcc8dead602a1d4fc98f4d3631e~E1aH_MF0B3102931029epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604642259;
	bh=jxUQ8t3/JeSwLRcIlZm19UWE3FzBdZtl9IHwoy1/cgc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oDASPQ9280evL0w0expkMRGRRGHYJe1sZUXwnS2wvLJkzDcxr+ac6vLZD/gql8Vbe
	 lgsXqcHzB2pCvRhuPORXzn78XsGbrUmHtcG21YlfTrBVkBRX44BOxABmgaN9NMTolW
	 81FZR6axgPGM6GH9jHv5ajsr2xf3ohKOJtCta4XM=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] Fix the potential warning without DM_REGULATOR
Date: Fri,  6 Nov 2020 14:57:46 +0900
Message-Id: <20201106055748.20042-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <CGME20201106055729epcas1p23448d11a25acd6168d3a514a2c17e6ce@epcas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: narmstrong@baylibre.com, agust@denx.de, u-boot-amlogic@groups.io, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

When CONFIG_DM_REGULATOR is disabled, there are some warnings.
This patch-set is fixed them.

drivers/phy/meson-g12a-usb2.c: In function 'phy_meson_g12a_usb2_power_on'=
:
drivers/phy/meson-g12a-usb2.c:70:35: warning: unused variable 'priv' [-Wu=
nused-variable]
   70 |  struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
      |                                   ^~~~
drivers/phy/meson-g12a-usb2.c: In function 'phy_meson_g12a_usb2_power_off=
':
drivers/phy/meson-g12a-usb2.c:86:35: warning: unused variable 'priv' [-Wu=
nused-variable]
   86 |  struct phy_meson_g12a_usb2_priv *priv =3D dev_get_priv(dev);
      |                                   ^~~~
  LD      drivers/phy/built-in.o
  CC      drivers/video/simple_panel.o
  CC      drivers/video/meson/meson_dw_hdmi.o
drivers/video/meson/meson_dw_hdmi.c: In function 'meson_dw_hdmi_probe':
drivers/video/meson/meson_dw_hdmi.c:382:18: warning: unused variable 'sup=
ply' [-Wunused-variable]
  382 |  struct udevice *supply;
      |                  ^~~~~~

Jaehoon Chung (2):
  phy: meson-g12a-usb2: fix the potential build warning
  video: meson: meson_dw_hdmi: fix the potential build warning

 drivers/phy/meson-g12a-usb2.c       | 4 ++--
 drivers/video/meson/meson_dw_hdmi.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

--=20
2.29.0

