Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.44652.1671713864912596899
 for <u-boot-amlogic@groups.io>;
 Thu, 22 Dec 2022 04:57:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1671713863;
	bh=yHjeNvpGpgd9Tom1+aMC2RhEagJs98dPJr+/zz5X80E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=nu6CaQQfDf7OXmgUZuyV50jeR5dLIT/slmLhh7Q7WcGrMKB4Wu+VcoNzElHqPWWHQ
	 q9kNrXORBmY2cY0SNNS7wH9gG3XPepC5bMc0slIvNEumMjZQ5Y6hMQEnxA7VV9Uyff
	 b6TOdmR4j02XXsXmtFaz3xdp8GRgNsfv01UIWIf2AX0CN4ed1Ot+ABRVOy50VH++pg
	 JGa1unBQJUWUOEMs6h2xpoornHQ0/i28qEpJA6VyYcwJTVrfaEeipGGvhUAsMt4ZoR
	 J10i2v/7ufkCMoTVpCKgD8+ZwiltmcqErUGcvzliXrqJ6oEf2rqlesH3EefuT9Qf7H
	 SutFot4g6Opsg==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v3 3/5] doc/usage: cmd: documentation for meson/sm command
Date: Thu, 22 Dec 2022 15:57:25 +0300
Message-ID: <20221222125727.47893-4-avromanov@sberdevices.ru>
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
 doc/usage/cmd/sm.rst | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 doc/usage/cmd/sm.rst

diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
new file mode 100644
index 00000000000..3a70c137ec9
--- /dev/null
+++ b/doc/usage/cmd/sm.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Meson Security Monitor command
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Synopis
+-------
+
+::
+
+    sm serial <address>
+    sm reboot_reason [name]
+    sm efuseread <offset> <size> <address>
+    sm efusewrite <offset> <size> <address>
+    sm efusedump <offset> <size>
+
+Description
+-----------
+
+The sm command is used to request services from the secure monitor. User
+can call secure monitor to request special TEE function, for example chip
+serial number info, reboot reason, etc.
+
+sm serial
+  Retrieve chip unique serial number from sm and write it to memory on
+  appropriate address.
+
+sm reboot_reason
+  Print reboot reason to the console, if parameter [name] isn't specified.
+  If parameter specified, set reboot reason string to environment variable
+  with this name.
+
+sm efuseread
+  Read <size> bytes starting from <offset> from efuse memory bank and writ=
e
+  result to the address <address>.
+
+sm efusewrite
+  Write into efuse memory bank, starting from <offset>, the <size> bytes
+  of data, located at address <address>.
+
+Configuration
+-------------
+
+To use the sm command you must specify CONFIG_CMD_MESON=3Dy
--=20
2.25.1

