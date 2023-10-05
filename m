Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web10.10943.1696496097509167448
 for <u-boot-amlogic@groups.io>;
 Thu, 05 Oct 2023 01:54:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DE42D120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696496094;
	bh=1THhUAnqtPeESjH2GeqCMEmxelbReBPELYUPipCg6mQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hAL7yqg6weperfGQsbe/x7DNs/kstk2UJGmuKx1DTDSLHLbik2uVvhPIQxaiKuhz9
	 O6gxtCqaF8YWxigS4xZ+kQ76l+L6KznakoFdulFqe5Hpr3gBxyrLv0CHvQ3BhpdHFa
	 eLJnWqFP4yyBObpQqf2+edWpT5ZIEwFSFTPzGnAuDYxkhNIQ0r3tE6o0auBX1Gb1VB
	 I1z6HGiVNd5lzQV+mi8MQfABjM8AR9Vg13zDL3ZgMg9VY1ITBiNc99u6fFAei3DmSl
	 rs5bdzJoklrHzPe+XYPPzc8zMLr54UQkdp52uGP2QjVEWgdo6dkHPlsbF0jDq+Hoet
	 lqvgXKfaRqksw==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 6/8] a1: clk: Add missing USB_PHY_IN and USB_PHY gates
Date: Thu, 5 Oct 2023 11:54:27 +0300
Message-ID: <20231005085434.74755-7-avromanov@salutedevices.com>
In-Reply-To: <20231005085434.74755-1-avromanov@salutedevices.com>
References: <20231005085434.74755-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>, Alexey Romanov <avromanov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

From: Igor Prusov <ivprusov@salutedevices.com>

We use this clocks in dwc3 driver.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

