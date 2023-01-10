Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.100826.1673348229549359026
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Jan 2023 02:57:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1673348227;
	bh=IoNbyRY5iz61FJ9hQ+r4hQgIzuQEXLurxhe99LoZqBw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CqHvAqiRnyYjN7YCtZnqlNkThOQr3Zn4YzTzENWgZov4Vm7CiqLwmRK9rZM0iVRTm
	 d6lcxkEQJDbBuZX6Fno91S25NcsMYerxNYctNouJJZJrFzbauYpQQOrx1J/fSrWXha
	 GJx/BtTa+8+mUumdokaTTdnQI0bOsdtBe8wqKYy1tigJ/9b3/yjn/Pj0HZWFzqPZ2A
	 e9QNhG+TUN1GjptjDCRXzLXaQvcXgOTX43hM6l1SWqEQuViA3FEOD8oHVjf4WcechC
	 LsW6pGn3Vl4zopQDwMJOvtXWqQa/uyVF1yqtQfde8ZbU23NnyKKMcdtdwBqMJenlmw
	 E6k17eEUhbmTA==
From: Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v4 5/5] doc/usage: cmd: sm: documentation efusedump cmd
Date: Tue, 10 Jan 2023 13:56:50 +0300
Message-ID: <20230110105650.54580-6-avromanov@sberdevices.ru>
In-Reply-To: <20230110105650.54580-1-avromanov@sberdevices.ru>
References: <20230110105650.54580-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com, trini@konsulko.com, sjg@chromium.org, mkorpershoek@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@sberdevices.ru>, Neil Armstrong <neil.armstrong@linaro.org>
List-ID: <u-boot-amlogic@groups.io>

Added docs about sm efusedump command, that reads bytes
from efuse memory bank and print them to the console.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 doc/usage/cmd/sm.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/usage/cmd/sm.rst b/doc/usage/cmd/sm.rst
index c41227f4b3b..f6524a1c2e3 100644
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

