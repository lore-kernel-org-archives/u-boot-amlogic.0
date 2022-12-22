Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44654.1671713868305107605
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713866;
	bh=YzJm2PA5bVPmuDhiYC7Nw31tyE264Ry90BJHOeUWyZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=F6mbSLWGvFvSJLUlzAEwaaEALjB0fE0LgVDyOJvWjv+ntT9ewZ+bMYY3CrAPq08qF
	 stKdHXVB6Av3gHcoq7BkpDKj/KIFtyTSJuN073sZaNrA90dn0rdaZTfKWm6n2Y5Z43
	 9JsXUoyWW2wY58y56PQponVPBZ6+mKOYpF0vECWZ6fvKfjR8GEeR/t5hKSXZpfmc2+
	 2fWMRWh0HEtxauHJ6YYevJPoVzkgyTgFtyWz1bwdHn9Cds7ZVpyOlOyIsXvc8X2t64
	 U8ZxdasLmDzYF+R6GawhOroPFBN8OdEZpKVHp6z5T86fDuFOrM8jCHqEQAKi0PDG1W
	 ndlzztdva8JJQ==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 5/5] doc/usage: cmd: sm: documentation efusedump cmd
Date: Thu, 22 Dec 2022 15:57:27 +0300
Message-ID: <20221222125727.47893-6-avromanov@sberdevices.ru>
In-Reply-To: <20221222125727.47893-1-avromanov@sberdevices.ru>
References: <20221222125727.47893-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 doc/usage/cmd/sm.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
index 3a70c137ec9..beb53b3f46d 100644
--- a/doc/usage/cmd/sm.rst
+++ b/doc/usage/cmd/sm.rst
@@ -38,6 +38,10 @@ sm efusewrite
   Write into efuse memory bank, starting from <offset>, the <size> bytes
   of data, located at address <address>.
=20
+sm efusedump
+  Read <size> bytes starting from <offset> from efuse memory bank and prin=
t
+  them to the console.
+
 Configuration
 -------------
=20
--=20
2.25.1

