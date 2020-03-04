Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web11.3827.1583284667556648104
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Mar 2020 17:17:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1583284664;
	bh=bCxP2T9n7zxRIobmeqwpLJ3Jw00HkrHIRb1ZzuO/1dg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=JFY8UBcvRtJ586DTsYChJ5Qn7zFyAA+yuKF5vtVmTTzUHLHkcusu41NLT9kpRaYTj
	 09bxylP0arEdcQltrsmDMdOUctsAAaJE//EpD1Ul6Kzo2Uz3yUjaEiAQ/cY4idQtWO
	 3LEW38l7sj6VLgeeASZNUvayNrmhCktaDXSllnAQ=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 0/2] drivers/rng: add Amlogic hardware RNG driver
Date: Wed,  4 Mar 2020 02:17:36 +0100
Message-Id: <20200304011738.33763-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

The first patch simplifies the Kconfig for hardware RNG drivers and enable=
s
the Sandbox RNG driver for all Sandbox instances.

The second introduces a hardware random number generator driver for Amlogi=
c
SOCs. This second patch had been sent before but the preceding patch was
missing.

Heinrich Schuchardt (2):
  drivers/rng: simplify Kconfig
  drivers/rng: add Amlogic hardware RNG driver

 configs/sandbox64_defconfig |   1 -
 configs/sandbox_defconfig   |   1 -
 drivers/rng/Kconfig         |  17 ++++-
 drivers/rng/Makefile        |   1 +
 drivers/rng/meson-rng.c     | 120 ++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 4 deletions(-)
 create mode 100644 drivers/rng/meson-rng.c

=2D-
2.25.1

