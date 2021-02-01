Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web11.31466.1612171669769449171
 for <u-boot-amlogic@groups.io>;
 Mon, 01 Feb 2021 01:27:50 -0800
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210201092746epoutp01cc70102994eb00852342cee3b6728760~flZbd750a2821328213epoutp01T
	for <u-boot-amlogic@groups.io>; Mon,  1 Feb 2021 09:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210201092746epoutp01cc70102994eb00852342cee3b6728760~flZbd750a2821328213epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1612171666;
	bh=HX+ugw6TIbmk/AtFhXpUlx3ggJN7HE0aJgoJzHKFk6c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OqHgVVAsBCGH8s3pHyDuJa96MvLJmoUynysfdNzMHRYqD7SgZ1YTj9i8H7v6YHz8x
	 4q5c37cHYiyEcQdH6KIoYetaxxFOFENunW0Hmj1tAvn2k/imHsnEcLIyNdiPUMWvy1
	 OqqH6GwWWafJ+eQ3aQJ92had363ThjwhYtdfMwA8=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/3] Add mmc-pwrseq file to use common function
Date: Mon,  1 Feb 2021 18:28:03 +0900
Message-Id: <20210201092806.14314-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <CGME20210201092741epcas1p192c302145ca54c2fac6db4c093ea5a48@epcas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, narmstrong@baylibre.com, sjg@chromium.org, kever.yang@rock-chips.com, yangbo.lu@nxp.com, faiz_abbas@ti.com, u-boot-amlogic@groups.io, philipp.tomsich@theobroma-systems.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Some Socs need to use H/W power-reset before probing eMMC.
Its function can be resued with same behavior.

Jaehoon Chung (3):
  mmc: pwrseq: add mmc-pwrseq file to provide a generic interface
  mmc: meson_gx_mmc: use mmc_pwrseq instead of meson_mmc_pwrseq
  mmc: rockchip_dw_mmc: use mmc_pwrseq instead of rockchip_mmc_pwrseq

 drivers/mmc/Kconfig           |  8 ++++++
 drivers/mmc/Makefile          |  1 +
 drivers/mmc/meson_gx_mmc.c    | 41 +++-------------------------
 drivers/mmc/mmc-pwrseq.c      | 51 +++++++++++++++++++++++++++++++++++
 drivers/mmc/rockchip_dw_mmc.c | 41 +++-------------------------
 include/mmc.h                 | 14 ++++++++++
 6 files changed, 80 insertions(+), 76 deletions(-)
 create mode 100644 drivers/mmc/mmc-pwrseq.c

--=20
2.29.0

