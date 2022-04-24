Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.15567.1650788531407740374
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788528; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=yCVtbs3XIgzcLUjPA9VFlrVNV35lzkVAA9B57aW7stM=;
	b=t9BEzy+hNaoEiX9E434EW5vfLaYAg0a8x5j8zxt67xXsSrMMif2LOTd392DHygzxiQA7eZ
	RhXX++R6qvvAkYvHnUTCiVth5cyLL7UW6QXMr5W0TvkM4L/qWGPSFc0ZwjKGQmWucKdLT5
	WSiE9+4HsqrkbMlQYV7yOSlgHq79LT9H+pz+K74DsFroHLfVK+5hXFgzT+Lh50rYlU/QJo
	vC74OdTY8uLzAqNdtwRU/iV5sL3DjbxO2tEf+xdkpLjG+tIxrpWgZsyIS31oZV9rwU6TfM
	TzWqDlmnq+l2nD7sHXdPT1ec7YKBPGCO75lFUk2yk3DXh8hjDIAyIpsE7zw/Sw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 0/6] meson: add clk and adc support for JetHub D1 (j100)
Date: Sun, 24 Apr 2022 11:21:53 +0300
Message-Id: <20220424082159.757622-1-adeep@lexina.in>
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
- remove unnecessary check (gate->reg =3D=3D 0) in g12a-clk-ao driver
- enable saradc in dts/board config for JetHub D1 (j100)

From v2:
- remove unnecessary check (gate->reg =3D=3D 0) in axg/g12a clk-ao driver=
s
- move j100 dts changes to -u-boot.dtsi
From v1:
- move clk-id check to .request function for axg/g12a-ao clk driver


Vyacheslav Bocharov (6):
  clk: meson: add minimal driver for axg-ao clocks
  clk: meson: fix driver name for g12a-ao clocks
  clk: meson: update driver for g12a-ao clocks
  adc: meson-saradc: add AXG variant
  board: amlogic: jethub j100: enable saradc in dts
  board: amlogic: jethub j100: enable saradc in config

 .../meson-axg-jethome-jethub-j100-u-boot.dtsi | 10 +++
 configs/jethub_j100_defconfig                 |  5 ++
 drivers/adc/meson-saradc.c                    |  2 +
 drivers/clk/meson/Makefile                    |  1 +
 drivers/clk/meson/axg-ao.c                    | 86 +++++++++++++++++++
 drivers/clk/meson/g12a-ao.c                   | 17 ++--
 6 files changed, 114 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100-u-boot.dts=
i
 create mode 100644 drivers/clk/meson/axg-ao.c

--=20
2.30.2

