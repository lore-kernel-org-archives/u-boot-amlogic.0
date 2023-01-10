Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.100825.1673348226487033177
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 02:57:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1673348224;
	bh=mwIaO/3Wb77GdZxsAMfhKEXkz/K/ltEP1VjVbPnzKtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lbDRv6BfFl6hgVP4sGKjAcq5Wa3KLvfWorHxTjQTgYvzTVEEDEUIf2Fwq8xXKKZCE
	 UGlBWy6nbOTiBCyf8ycCCUbKyYHp6RSmKIsqUdzOOUwF0dLeUhmBUCLPNXRtZjJAQE
	 3pHhhJZeY/yPTi7TyKL+xNGfnLYN4/8NTZnC71K6nlGiR2WUR5NvBajafSTwIjHCHC
	 35nuKAEeDb5Nfo/4imxVRO7OuA8CpnGvCeFZnhy4y/8t7SBeIGeO9iYB6AL2gp0obv
	 D+JjOTuZown1eosfGgEb88Jqen22R7ANIYvGWzvaynepCU2+9pIUz9G4Hms7LN1Zh7
	 AZ/DI65iNGDAA==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v4 3/5] doc/usage: cmd: documentation for meson/sm command
Date: Tue, 10 Jan 2023 13:56:48 +0300
Message-ID: <20230110105650.54580-4-avromanov@sberdevices.ru>
In-Reply-To: <20230110105650.54580-1-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>
List-ID: <u-boot-amlogic@groups.io>

Added docs for Meson Security Monitor command.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 doc/usage/cmd/sm.rst | 44 ++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst  |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 doc/usage/cmd/sm.rst

diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
new file mode 100644
index 00000000000..c41227f4b3b
--- /dev/null
+++ b/doc/usage/cmd/sm.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+sm command
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 770418434ad..e34b98dae24 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -61,6 +61,7 @@ Shell commands
    cmd/true
    cmd/ums
    cmd/wdt
+   cmd/sm
=20
 Booting OS
 ----------
--=20
2.25.1

