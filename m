Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.6364.1697097520364636086
 for <u-boot-amlogic@groups.io>;
 Thu, 12 Oct 2023 00:58:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6274B120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1697097516;
	bh=HSN+h1ZU5OZhniXORnglf8yQPTNAnEyruvEeEPOHI7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vj8zpmGN+D/utNU1eaTyuvdjrD6AC04a+NAhPeAI0bgSTcQUR+Ci7kP3T9IDCjq0+
	 TuP1bLzpdM31mghOEkOz5RV5aDrWYHr0gsKfMism/IL5UEEtCv4kgMCDBUC5i5yl50
	 Cp3jvHyjHJMU20nE0DT6+HBOliQEbte2rAL0CyLAAZO+H1GcVo65ui4B0w6voelgtV
	 ic5SDNcrttRl7DduGcF9/T2L7xFcIZprYQZXJmpSd8BWgflQ2FroIK5faUWqm58yZI
	 kOgNW9sjoYHkGbu0JCRIG53G7Bt6Fe8UB4acylRIwmUQ/Q1KCIrTFKEHp2So2kNKch
	 fOd6X/qqUq95A==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 0/1] hwrng: meson - add support for S4
Date: Thu, 12 Oct 2023 10:58:24 +0300
Message-ID: <20231012075828.22685-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sughosh.ganu@linaro.org, xypron.glpk@gmx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Hello!

This patch adds support for Meson S4 series
hardware number generator using new algo.

V2:

- Sync with Linux version.

V3:

- Fix compiler warning "makes pointer from integer without a cast"

Alexey Romanov (1):
  drivers: rng: add support for Meson S4

 drivers/rng/meson-rng.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

--=20
2.25.1

