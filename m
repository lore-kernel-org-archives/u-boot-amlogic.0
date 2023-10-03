Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 by mx.groups.io with SMTP id smtpd.web10.106046.1696332538301999880
 for <u-boot-amlogic@groups.io>;
 Tue, 03 Oct 2023 04:28:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 383D510000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696332536;
	bh=UR0yEmUKLSaMRb9bayS9HVWVLhOqnWt3i4gAEsEyhNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=r0LsciQik8C50vZQmiSHzVrGQEp6mqV/Huo5fddMqc1HCYA8zzllWJJ6+bX1v1lnj
	 l29nl8hgEYpjtg9LC8T0avYYlbtoFZjt0TW5R9HCplZvQkKkUYjSWql6aWFyTiLUyH
	 jo9eYWodkLtoT4GkaI6KRE6xFbhGMlAPPcgJ6ja9jo377AeNCU6jllqfxkhnGJPYd8
	 dIbCLmUOgdZYyWk4G3TjbFwauEZ6mbHtLbJ91aALuHh6+bnPgdgSnLzRMBqlfsJ5sN
	 x16PMrhHj5N8h8i8CkWLvKxGTAEmdwudol5Z9VgVejFTr8SWXeKDXFMcMgzmtLAsCS
	 i8z4UIOIeS8Fw==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
Date: Tue, 3 Oct 2023 14:28:32 +0300
Message-ID: <20231003112838.41503-7-avromanov@salutedevices.com>
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

From: Igor Prusov <ivprusov@salutedevices.com>

We use this clocks in dwc3 driver.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/clk/meson/a1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 3aec42f33b..1075ba7333 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -238,6 +238,12 @@ static const struct meson_clk_info *meson_clocks[] =3D=
 {
 	[CLKID_FIXPLL_IN] =3D CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
 		EXTERNAL_XTAL
 	),
+	[CLKID_USB_PHY_IN] =3D CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
+		EXTERNAL_XTAL
+	),
+	[CLKID_USB_PHY] =3D CLK_GATE("usb_phy", A1_SYS_CLK_EN0, 27,
+		CLKID_SYS
+	),
 	[CLKID_SARADC] =3D CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
 		-ENOENT
 	),
--=20
2.25.1

