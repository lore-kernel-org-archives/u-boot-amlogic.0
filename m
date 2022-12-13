Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.82029.1670956301278726047
 for <u-boot-amlogic@groups.io>;
 Tue, 13 Dec 2022 10:31:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1670956298;
	bh=pnrF9wWt0BUw4pm7/hPxcm1+GYdbYZbIkzvmMBUCp5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ekc+o2C8khKrzrRDLPNoy4BOc/9O+y0/Jf/f3nTFi5Hqba6MvW3AcuTt5ccsC17jR
	 Td+BI3xJvcyB9DCU7j5PBvCA+hqYmRCbymdJvTA6nN0/i08W94/63p03FqhwYBvr0C
	 as760X5gNeXlKQmpoe0H7f72pMgcg8avPAmx476EfkD0cljiII10FPW83c30JFLB9w
	 fpm5MRpMjeAklVrKvK+rgAxcH6CLQ4kl1MbgGwSZwj3mN41MeD3djVfM+QNH/Jl8Sk
	 U9gp3q3k4lFjelplUuYqZyEoOUyzbRFQoaIfJfT+V/WAkXIJXZero5hW0iPKJ6ZFR1
	 HsCo3jFGh22Cw==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 0/3] arch-meson: introduce efusedump command
Date: Tue, 13 Dec 2022 21:31:26 +0300
Message-ID: <20221213183129.75915-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Keeping the commands code in an arch/ is not correct. This patchset
moves the meson smc commands from arch/arm/mach-meson to cmd/meson
folder and also adds a new 'efusedump' command with which user can=20
print efuse memory.

Alexey Romanov (3):
  asm/arch-meson: add missing meson_sm_write_efuse signature
  arm/mach-meson: move smc commands in cmd/meson
  cmd/arm: meson: sm: introduce efusedump command

 MAINTAINERS                          |   1 +
 arch/arm/include/asm/arch-meson/sm.h |   2 +
 arch/arm/mach-meson/sm.c             | 144 ---------------------
 cmd/Kconfig                          |   7 +
 cmd/Makefile                         |   3 +
 cmd/meson/Makefile                   |   5 +
 cmd/meson/sm.c                       | 187 +++++++++++++++++++++++++++
 7 files changed, 205 insertions(+), 144 deletions(-)
 create mode 100644 cmd/meson/Makefile
 create mode 100644 cmd/meson/sm.c

--=20
2.25.1

