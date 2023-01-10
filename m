Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web11.101217.1673348221909133595
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 02:57:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1673348219;
	bh=fs5tXNAjwPSKjwFRQThgUa9cyo2IMAGPfQq4bVLeWwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=sfhMIVinvVja+O0aHw1oa42VIZ1JAbRJvZDBRIQ3Gmx4GhQ0nOj1oHfr7w9TEpTP0
	 4tP+p+TmHRdCpfHRgzq98LUXVMwuH7FwSypT6Vv4GC9pjO/0n7090XPL7bMi/48Ybu
	 +y7jMyysuAhV3lRsfv1GoFaXtsQN2FHb9oRUf8YSxRmc9VU1zhl/I7X7XhDo15rgI0
	 uoQHFtgBhRCIZyRqabvK5zzrY58ERJn5ezLprtCb/dQCX3oqNHe7TJqBrJEaTcF1lT
	 xAo4CLlbuWBsN49kkwVMIiZ85tP3iyLytu8YjNgitVxncQlxJTxIo6PhzEewqBQRq7
	 gzmZYpL1ZEiFg==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v4 0/5] arch-meson: introduce efusedump command
Date: Tue, 10 Jan 2023 13:56:45 +0300
Message-ID: <20230110105650.54580-1-avromanov@sberdevices.ru>
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
 doc/usage/index.rst                  |   1 +
 9 files changed, 283 insertions(+), 144 deletions(-)
 create mode 100644 cmd/meson/Makefile
 create mode 100644 cmd/meson/sm.c
 create mode 100644 doc/usage/cmd/sm.rst

--=20
2.25.1

