Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.10600.1696493989839553845
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:19:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F3D7D12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696493984;
	bh=Z9XL3+1PdnER1Fprpyh+GaxkA703vjBwsuCAjl1c4NI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=HnKYOatvIM5CipLwrDxDlxOcKXpj/TZmmgpI/trzCekmbU5sbZUW7douOpXZD/Zvt
	 HBgSVayYpVqsW4+g6aYabtoGQJ96pmILtNaWMkS4pYFjALxkUmdzKkiYZu6EAW3xOO
	 1h5Sp9Bu0vkyGXi+GOY3rfKZ9pviBW0LeD9UiE0fEzpGj+3ey1yG8d8YQPp3P/0euT
	 CFAPMzPmRffhZPsVySwjqUfaUhytQKM0vPSXhv2uXUqBK0AoGD25P7wYxHz7udiXBt
	 xY5ATswo+rM3N2sW10SPBr3SCpistJiEKw00F/OBewnu06VoqDNk3MKqqOck45eon2
	 o+hBWWFAMg+Kg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1] drivers: sm: fix build warning
Date: Thu, 5 Oct 2023 11:19:30 +0300
Message-ID: <20231005081936.72178-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>, Igor Prusov <ivprusov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

This fixes following warning during u-boot build:
WARNING: unmet direct dependencies detected for MESON_SM
  Depends on [n]: SM [=3Dn]
  Selected by [y]:
  - MESON64_COMMON [=3Dy] && ARM [=3Dy] && ARCH_MESON [=3Dy]

Fixes: 9849712e7655 ("drivers: introduce Meson Secure Monitor driver")

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 drivers/sm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
index b4cc3f768e..f0987275d2 100644
--- a/drivers/sm/Kconfig
+++ b/drivers/sm/Kconfig
@@ -3,7 +3,7 @@ config SM
=20
 config MESON_SM
 	bool "Amlogic Secure Monitor driver"
-	depends on SM
+	select SM
 	default n
 	help
 	  Say y here to enable the Amlogic secure monitor driver.
--=20
2.25.1

