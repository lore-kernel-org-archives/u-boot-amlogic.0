Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mx.groups.io with SMTP id smtpd.web09.25471.1604286415709046128
 for <u-boot-amlogic@groups.io>;
 Sun, 01 Nov 2020 19:06:56 -0800
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201102030652epoutp013774ba08ec4dba9b033ec685be95144e~Dkf3zsyVO0738007380epoutp01P
	for <u-boot-amlogic@groups.io>; Mon,  2 Nov 2020 03:06:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201102030652epoutp013774ba08ec4dba9b033ec685be95144e~Dkf3zsyVO0738007380epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1604286412;
	bh=S0OD12cnZ8p0WdM1nfprTjIfjfqGoLfws40ALGCCkx4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DuTPG/2+A8f9/aGapAiRGQIHXov/Kss8lnfijbTbAENl9AUwjLnpIHapph0eqa7rF
	 X3DHgh9Gbajz3ZecO86X15GxIfDMTQsBlrLguRUsTZqn+cKlLjyKm8Nf91XJyMkTH2
	 stXfB3tmOZ3rdkw6Dlvd4HVZfBqliTQKckQ0WyWA=
From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] configs: meson64: relocate config_distro_bootcmmd header
Date: Mon,  2 Nov 2020 12:07:06 +0900
Message-Id: <20201102030706.2577-1-jh80.chung@samsung.com>
MIME-Version: 1.0
References: <CGME20201102030646epcas1p35d5804491644c065158d5aa91238f154@epcas1p3.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, narmstrong@baylibre.com, Jaehoon Chung <jh80.chung@samsung.com>
List-ID: <u-boot-amlogic@groups.io>

Relocate a config_distro_bootcmd header before defined
CONFIG_EXTRA_ENV_SETTINGS. Otherwise it can't change to specific
environment.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/configs/meson64.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index cee690068022..52cc01f73da3 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -69,6 +69,8 @@
 	func(DHCP, dhcp, na)
 #endif
=20
+#include <config_distro_bootcmd.h>
+
 #ifndef CONFIG_EXTRA_ENV_SETTINGS
 #define CONFIG_EXTRA_ENV_SETTINGS \
 	"stdin=3D" STDIN_CFG "\0" \
@@ -83,6 +85,5 @@
 	BOOTENV
 #endif
=20
-#include <config_distro_bootcmd.h>
=20
 #endif /* __MESON64_CONFIG_H */
--=20
2.29.0

