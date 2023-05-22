Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.20109.1684757395549715639
 for <u-boot-amlogic@groups.io>;
 Mon, 22 May 2023 05:09:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1684757393;
	bh=7liJ2sHUVr8NBtnzSSad1IOzgYRPqI2bjz8pkD6QWf4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kIrN+r1Es4t8eHnO775c646qp6ON7b3kpg1qqdqSTXvu8qyyM8wJV1ZbAma/tPtDc
	 2rvTI+pGnwwLcwxHSjzRHDRXaRZXWwqel7J7AlxjW0M/4/QU+yOLSopplsjxrNZRrU
	 Ddn/mo9Ugq/dyEC0Tzavy8rfnbxtQIRE4PlIg820AFenTwfuwFgyFhvBHuj+eqma6h
	 ARWZoNWW3gNb6NGisULAV5Kw8mj/EtnerJMqg854YSotQMX5TxdPTKC1hoySc6az4G
	 QWLr0T4s4ApzrpRvi4nU5qQER4kMXrYzmcfMENHNLdO02JRn4EqPBM9/BsZOix3CV9
	 +qgV8qAsDlCjg==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 0/3] Meson Secure PWRC Driver
Date: Mon, 22 May 2023 15:09:38 +0300
Message-ID: <20230522120941.63962-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, jh80.chung@samsung.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Hello!

This patch set adds support (driver and sm functions) for working with
power domain controller using secure monitor for Amlogic A1-series.
Additionally, in the future, the driver can be used for other Amlgoic
SoC series, such as S4.

Alexey Romanov (3):
  arch/arm: meson: sm: introduce power domain functions
  drivers: meson: introduce secure power controller driver
  arch/arm64: meson-a1: dts: move pwrc node to bus

 arch/arm/dts/meson-a1.dtsi                 |  12 +-
 arch/arm/include/asm/arch-meson/sm.h       |  30 ++++
 arch/arm/mach-meson/sm.c                   |  14 ++
 drivers/power/domain/Kconfig               |   7 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/meson-secure-pwrc.c   | 160 +++++++++++++++++++++
 include/dt-bindings/power/meson-a1-power.h |  32 +++++
 7 files changed, 250 insertions(+), 6 deletions(-)
 create mode 100644 drivers/power/domain/meson-secure-pwrc.c
 create mode 100644 include/dt-bindings/power/meson-a1-power.h

--=20
2.38.1

