Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.1357.1696364978302112340
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 13:29:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CBA7212000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696364975;
	bh=dsiEHt6ow/N44v/QWEjoW4CbZm0nNHdufWMIfcaYiXQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LeVNBWciJV5IcHzR4ST2BdwKsbKu+XM4E5S5wsakEbvA0A5woY3q0Sb3hdpVBBuj7
	 x0gFqjkylgEUdBgdEQG4h8FiWjxuvLVeGjCLnOZbJ3lPzy++BveCEKwXmdz9U5Qvh7
	 7YNlsJmiU/miIRRoXa+wACtG7WBKl11LQElx2GmLGYCMkqBZQTnF5AmMWTb7AG5/D4
	 0nDMDlylyXhOhwBa9AfIOWp+sPaudn4YzIsumKlXFK9fEDMOjf7l4LsMqevJl1iIar
	 dWAhmb/lmdycLl5asTWMgZ3V9RPfy6FOO+OjXciVxpXfeAGfT5KTZOPppjZ98ptFB8
	 QjRjjQRzyRGow==
From: "Igor Prusov" <ivprusov@salutedevices.com>
Subject: [PATCH v1 2/2] ARM: amlogic: ad401: enable SPIFC
Date: Tue, 3 Oct 2023 23:29:08 +0300
Message-ID: <20231003202908.16654-3-ivprusov@salutedevices.com>
In-Reply-To: <20231003202908.16654-1-ivprusov@salutedevices.com>
References: <20231003202908.16654-1-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

From: Igor Prusov <ivprusov@sberdevices.ru>

Enable Amlogic A1 SPI FLash Controller support.

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
---
 configs/ad401_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index 31752cc7f5..9a88e20a6a 100644
--- a/configs/ad401_defconfig
+++ b/configs/ad401_defconfig
@@ -51,4 +51,5 @@ CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
 CONFIG_SPI=3Dy
 CONFIG_DM_SPI=3Dy
+CONFIG_MESON_SPIFC_A1=3Dy
 CONFIG_WDT=3Dy
--=20
2.34.1

