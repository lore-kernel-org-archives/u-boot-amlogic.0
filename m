Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.11088.1696496099369236514
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CEC6C12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496097;
	bh=iFWikqhv7WLzRZEjex0NBgDjWJ5qis63UG5DcwSp5gc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mZCuu91is2RavP7sZZDdUeEtO7UXniIF5HQWuPYqN1tG4kVmAY392vv7WKr2nZy6g
	 uBZVI4IHjpa9l+bB1FynwoYaqKqa48x/LhT87YFTa/NZf6P5FP5S4VZL4Ppqpn2wcJ
	 cK9Ku7w//gQqtME+aJxjnrRQitkXtTHW1mp1W487LyfI4ko4axbmurmsfuOgtUsAfR
	 kI40rkFkOQyFxkLJLmgaeSWg3w1wBRdDIOhyqTslBFgrZDT2uR5XsdLa5t6kSglLqF
	 7Q4P26C5BaQ+r5UnbEoNOV1ikoGOSpOz4oyTqEaBx5M8TKypqP6eAkEOQH9ErxCRbA
	 8WjGS/n9NNWxQ==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 8/8] ad401: enable USB stack
Date: Thu, 5 Oct 2023 11:54:29 +0300
Message-ID: <20231005085434.74755-9-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

Currently we have all drivers for use USB stack on A1-series
SoC's. Let's enable USB options for the Amlogic AD401 reference A1
SoC board.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/ad401_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/ad401_defconfig b/configs/ad401_defconfig
index 31752cc7f5..b9aca3ab0d 100644
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

