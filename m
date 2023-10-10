Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web11.87454.1696932397373118848
 for <u-boot-amlogic@groups.io>;
 Tue, 10 Oct 2023 03:06:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 90EBB100010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696932393;
	bh=Y5nVu+FrxAUa0QuV2owxreQLfkB3cs+zRrLItUKy+JU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ccZGLWgLFMykdvH5ubbQdC+/wGWju5IqZA+uN8cpUYNGmgdCU+CJ3oZPS802oTvXs
	 EkpeURuLxM89r9ZLx6k9CO+YstD5p4RNzKQo3StkUZvYMzszyuLmFVolvX+nRXLz+Q
	 t1wsGvcG0hKiXsObAt3gYNHA+Ey2BOsBwlXoXvQxbp8OTtZthE3yWEzpCc42v2r/qd
	 kmfBW44omRHv4zYB7PdlmjScm74TCVWqacIAxo/jO8A2gxZ/OaDuqqSEOzr+GnBaC+
	 cr1ohajSyTXOPL8XCptLq7rRvHdyij68RoAK9bqFkk9wbuFCf787sO1CfoCvD2Z0Pk
	 wNUWWqpvo334g==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 2/2] meson-a1: dts: add ao secure node
Date: Tue, 10 Oct 2023 13:06:17 +0300
Message-ID: <20231010100623.74475-3-avromanov@salutedevices.com>
In-Reply-To: <20231010100623.74475-1-avromanov@salutedevices.com>
References: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

ao-secure node can be used to get information about the board,
so, for example, using show_board_info() we can get following
information for board with Meson A1 SoC:

SoC: Amlogic Meson A1 (A113L) Revision 2c:a (1:a)

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/dts/meson-a1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/meson-a1.dtsi b/arch/arm/dts/meson-a1.dtsi
index e6e72d4004..e3a42c5b24 100644
--- a/arch/arm/dts/meson-a1.dtsi
+++ b/arch/arm/dts/meson-a1.dtsi
@@ -129,6 +129,12 @@
 				compatible =3D "amlogic,meson-rng";
 				reg =3D <0x0 0x5118 0x0 0x4>;
 			};
+
+			sec_AO: ao-secure@5a20 {
+				compatible =3D "amlogic,meson-gx-ao-secure", "syscon";
+				reg =3D <0x0 0x5a20 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
=20
 		gic: interrupt-controller@ff901000 {
--=20
2.25.1

