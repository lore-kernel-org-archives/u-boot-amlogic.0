Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web12.5147.1650605366401249291
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605362; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=pFcZ/IrzJdCdkVj734zHk3FM8C611bCayfXUyx5mkwc=;
	b=f1gTe1v3gxY0+yD2B5xaNuiyA0I+vlVEHJ+HLhkQ1LfUi+aOZqQBsAaNcv8TVAyxYVW6HU
	4UVx2AAki4u8lE+QVash074WEEP5uSmXV/uC4TSg8emkhlrHlFWnFZPAlbPaRlW+GD1EIB
	jfULi9J3I15uGiujg2nQ3C5bTGNUdBN0h8CFKaNPf39Z4wxbt5ADYH93NJIsCwMkyiQx/d
	xz1SogjrvlgeOGI5ipBqhStSO2j8pJp+nkg8VQtkt3qmVvN7RD5ejLDs/tHHeCvaFZNezK
	RZIB4UbE8ZIzVTltTatiW6s7pHjWvLqgkbBbhzQJKuLMwHxdqYhc2Dytn+1kDQ==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 0/6] meson: add clk and adc support for JetHub D1 (j100)
Date: Fri, 22 Apr 2022 08:29:08 +0300
Message-Id: <20220422052914.1836694-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Prepare to use ADC channel 1 in JetHub D1 (j100) to check the hardware=20
revision of the board.

- add support for AXG in saradc driver
- add simple clk-ao driver for AXG (base is taken from g12a)
- enable saradc in dts and board config file
- fix typo in the g12a-clk-ao driver name
- move clk->id check to .request function for g12a-clk-ao driver
- enable saradc in dts/board config for JetHub D1 (j100)

From v1:
- move clk-id check to .request function for axg/g12a-ao clk driver

Vyacheslav Bocharov (6):
  clk: meson: add minimal driver for axg-ao clocks
  clk: meson: fix driver name for g12a-ao clocks
  clk: meson: update driver for g12a-ao clocks
  adc: meson-saradc: add AXG variant
  board: amlogic: jethub j100: enable saradc in dts
  board: amlogic: jethub j100: enable saradc in config

 .../arm/dts/meson-axg-jethome-jethub-j100.dts |  5 ++
 configs/jethub_j100_defconfig                 |  5 ++
 drivers/adc/meson-saradc.c                    |  2 +
 drivers/clk/meson/Makefile                    |  1 +
 drivers/clk/meson/axg-ao.c                    | 89 +++++++++++++++++++
 drivers/clk/meson/g12a-ao.c                   | 14 ++-
 6 files changed, 112 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/meson/axg-ao.c

--=20
2.30.2

