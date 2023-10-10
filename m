Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.87452.1696932396835433976
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 03:06:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B60AA100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696932391;
	bh=FhJSx0xE7uw3byqpH5VR1ZRAtlK+et3fJ8T6QwjavNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=tubTqHpxV40yG0Gxnah++piMAL9PLJ12g5hsdpbwzAl2chIZ7KKfqG3aKoli2fjRF
	 /XpYIjbf/MgTTlKqiHbhAKPw6ax9aLB0LEiii3Cnfwjrpdo3SSqRM6DRSbIwkaUzmK
	 aujB8upAJMftpNWdQdsDKeGFQV3J7VcyI+sUI93pHwLziMXTHvxuigPPj/AHZj1qxX
	 4FTcGxGUAnOIndPPbqmrT8qnF5GwIBTeXhiinlxWIQSRzzsNqvJwrI3jblivnaBe/t
	 RxU6H7jdrZeMSTauHjg96PNAoxyew7w6BctpDiinzbTc2VQiSL7wSDfW9/nkji0x58
	 L6seDsc7yylUA==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 0/2] Meson A1: add HW RNG and AO Secure nodes
Date: Tue, 10 Oct 2023 13:06:15 +0300
Message-ID: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Hello!

This patchest adds HW RNG and AO Secure definition
in device tree for Amlogic A1-series.

V2:

- Rebased over latest amlogic U-Boot branch.

Alexey Romanov (2):
  meson-a1: dts: add hw rng node
  meson-a1: dts: add ao secure node

 arch/arm/dts/meson-a1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

--=20
2.25.1

