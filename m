Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.105638.1696332539705006459
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 04:29:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B5711100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696332537;
	bh=3F4Uk2alvwuEN4Hwjp7PJnAPyi65bY3vqxP9QG8HS4Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gSmSRuWOOa1JcqP60IP+qauKzERBpMr7O7zdn/QmJJQeViQ3IGRIUYJrjKXO22I18
	 BJN+d2PiRLh8HsPilSYCpnADhr1oyIw2CyE2keLpPWfIwHjV4xmFhFgAGA6CgJvNzx
	 Ws/vJHE51Wr5SPMk0j7PCOgDnuOVzFHllQY5BVJT/eM01RnDfH4foMl9z0mRSbTSEr
	 IEhJkB+jGz3CCm1Zib4dn3NjSi9ReKgXCk906d2FunwunXP7mlpjESH3GgGlS0Sxh1
	 +x3aSVhDh4cxgy8xHPQT3BprKfM/lAcRcnO9Npyk+SQWXa4eWa9uLq22pM7//ywR1o
	 t+NwXCWDNWdmg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 8/8] ad401: enable USB stack
Date: Tue, 3 Oct 2023 14:28:34 +0300
Message-ID: <20231003112838.41503-9-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Currently we have all drivers for use USB stack on A1-series
SoC's. Let's enable USB options for the Amlogic AD401 reference A1
SoC board.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 configs/ad401_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index 529e553bac..b02ff47b7a 100644
--- a/configs/ad401_defconfig
+++ b/configs/ad401_defconfig
@@ -51,4 +51,7 @@ CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
 CONFIG_SPI=3Dy
 CONFIG_DM_SPI=3Dy
+CONFIG_USB=3Dy
+CONFIG_DM_USB_GADGET=3Dy
+CONFIG_USB_GADGET=3Dy
 CONFIG_WDT=3Dy
--=20
2.25.1

