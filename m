Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web08.11022.1650477314254168336
 for <u-boot-amlogic@groups.io>;
 Wed, 20 Apr 2022 10:55:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650477310; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=4Jm305w9YA8P7Y3AduS9qCUJfb14SUJIZiCceA+a6Mc=;
	b=dp6iaVzynYGLajlTQ88/lGeq1tJAbB0od0qYid3ZHwOmvAc7/9bN796a4wsTJX7oh4FVwX
	Mcu4buBUJdngj9Gk+dp09R2JPZvXt66bb+9kU5c/udC6lAD7YbQSHTYjVDUH47U5xmejeL
	vP60bgofPqL2SOnM1bK+BIszi+vH/4JhcMc5yeot0qIsu5rxL2FHBYgJohPW7hc8tZ7EHX
	2nKmHAZhxAmO1LlCiYCysqULYE9o6YUkrpa858WjNIkAfjE28z/iPLat85nbtFjbnFf/jm
	TgodCkqdOST+dZO6zF8XABJktqBOJZnYjROi3vwQ4ES8utMue77PQNLEvX1mZg==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH 0/5] meson: add clk and adc support for JetHub D1 (j100)
Date: Wed, 20 Apr 2022 20:54:57 +0300
Message-Id: <20220420175502.2449249-1-adeep@lexina.in>
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


Vyacheslav Bocharov (5):
  clk: meson: add minimal driver for axg-ao clocks
  clk: meson: fix driver name for g12a-ao clocks
  adc: meson-saradc: add AXG variant
  board: amlogic: jethub j100: enable saradc in dts
  board: amlogic: jethub j100: enable saradc in config

 .../arm/dts/meson-axg-jethome-jethub-j100.dts |  5 ++
 configs/jethub_j100_defconfig                 |  5 ++
 drivers/adc/meson-saradc.c                    |  2 +
 drivers/clk/meson/Makefile                    |  1 +
 drivers/clk/meson/axg-ao.c                    | 83 +++++++++++++++++++
 drivers/clk/meson/g12a-ao.c                   |  2 +-
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/axg-ao.c

--=20
2.30.2

