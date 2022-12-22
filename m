Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44649.1671713860503066010
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713857;
	bh=amTKewpy8HJZX7ef8eq+VOGAn+eJXL4Li6N1/Q3VCzo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ImfaTd17SGIFXchBhsC5p77DG9+nmR/GGCPANuRgx6CIxTzB/WO1kXwh0dJ4FajnY
	 iFAfKyw8oTlJw32LSQ6Ft2jGgzTfsaG++H727CHlt+Qn2x+9ZBD8jHdytSPLpQj+zA
	 LJ5n1XgeVpv6EvDILER4wrtlVCG7swkYftpvcGb/21uZfHFfTEOAd+TL+nTk8I4HEm
	 +HGm8RtAeLkfeR+leF7Tr+m5bnzsbxhc7TdfmZQK6/Oa4vHUtH4WYVg29G1gpkq08Q
	 /bG5S3MmUATla6s9Og674dwJ4aFWyidqplloHt4Cg7O/q2kfIIGz4zEEJ82TS4G2PW
	 ex+xMpqqAToWw==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 0/5] arch-meson: introduce efusedump command
Date: Thu, 22 Dec 2022 15:57:22 +0300
Message-ID: <20221222125727.47893-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Keeping the commands code in an arch/ is not correct. This patchset
moves the meson smc commands from arch/arm/mach-meson to cmd/meson
folder and also adds a new 'efusedump' command with which user can=20
print efuse memory.

Alexey Romanov (5):
  asm/arch-meson: add missing meson_sm_write_efuse signature
  arm/mach-meson: move smc commands in cmd/meson
  doc/usage: cmd: documentation for meson/sm command
  cmd/arm: meson: sm: introduce efusedump command
  doc/usage: cmd: sm: documentation efusedump cmd

 MAINTAINERS                          |   1 +
 arch/arm/include/asm/arch-meson/sm.h |  28 ++++
 arch/arm/mach-meson/sm.c             | 144 --------------------
 cmd/Kconfig                          |   7 +
 cmd/Makefile                         |   3 +
 cmd/meson/Makefile                   |   5 +
 cmd/meson/sm.c                       | 190 +++++++++++++++++++++++++++
 doc/usage/cmd/sm.rst                 |  48 +++++++
 8 files changed, 282 insertions(+), 144 deletions(-)
 create mode 100644 cmd/meson/Makefile
 create mode 100644 cmd/meson/sm.c
 create mode 100644 doc/usage/cmd/sm.rst

--=20
2.25.1

