Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.1355.1696364977224772603
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 13:29:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 156DB120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696364974;
	bh=s6jeEFzjsBh+weEvalez4WeFgPIWUdsftv18ab+XHc8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=m901MLbyaVhVWTIgDkOa8Mhq8ogI7oQdGLvxMAXn6k/sY/cT7pH3jeml4897BX9i+
	 Hx4DOFjmf+Lrc7EFYb5o9+QRPZbF7Cd2ynpznJ/mlb50Q/pfU1txM4XA3LcfPII1OR
	 xQuWzmKmYmDm0BrH02EtvEz24Zby46wFZgNV+eG2dukOZ3hGlcmKWqgCa77w9LQ6Oh
	 ofd744akDR0Blr1pE79JvEHmFQ4EYcCGtfvQDnm7e2k9l9w1CIThSLPeecd3064ktE
	 AVSW+AG1UEBQvFTryuTyhKE4maFY7O6D7iVFSTyne3Y6cvSGI6LXRr3S+1pU/Nz8QE
	 btiUesTRkE7Xg==
From: "Igor Prusov" <ivprusov@salutedevices.com>
Subject: [PATCH v1 0/2] ARM: amlogic: Add A1 SPIFC support
Date: Tue, 3 Oct 2023 23:29:06 +0300
Message-ID: <20231003202908.16654-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

A1 family boards have new version of SPIFC controller, that is
incompatible with meson_spifc driver. This series ports A1 SPIFC driver
from Linux and enables it for ad401 board.

Igor Prusov (2):
  spi: add support for Amlogic A1 SPI Flash Controller
  ARM: amlogic: ad401: enable SPIFC

 configs/ad401_defconfig      |   1 +
 drivers/spi/Kconfig          |   8 +
 drivers/spi/Makefile         |   1 +
 drivers/spi/meson_spifc_a1.c | 384 +++++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 drivers/spi/meson_spifc_a1.c

--=20
2.34.1

