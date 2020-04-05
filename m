Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by mx.groups.io with SMTP id smtpd.web10.14936.1586082065160455633
 for <u-boot-amlogic@groups.io>;
 Sun, 05 Apr 2020 03:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1586082062;
	bh=UUm+LQNT1ZrbGFn9XbzlUseP4B6Rpc/7ccZL8hj+6Rk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=ULJHsagbGiRAaOYnJ35w/XXC4KSPwperVwimGmvHqTDrn1t8YehiyPO4Fi2STlFCS
	 FxyjX/ylYTjuEcw4SkkA6T+HU8mWAopPDs8+dw09AGkLe1NpS6t/ninn2gEX5XgsnV
	 fbVdln+QFiGK1D7ut8z/uT8bkkkxeAEkWrMFFDHA=
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] arm: meson: imply DM_RNG
Date: Sun,  5 Apr 2020 12:20:23 +0200
Message-Id: <20200405102023.15217-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>, open list <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-ID: <u-boot-amlogic@groups.io>

All ARCH_MESON boards have a hardware random number generator. So we shoul=
d
enable building the RNG driver.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bbb1e2738b..eee4538c7e 100644
=2D-- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -762,6 +762,7 @@ config ARCH_OMAP2PLUS
 config ARCH_MESON
 	bool "Amlogic Meson"
 	imply DISTRO_DEFAULTS
+	imply DM_RNG
 	help
 	  Support for the Meson SoC family developed by Amlogic Inc.,
 	  targeted at media players and tablet computers. We currently
=2D-
2.25.1

