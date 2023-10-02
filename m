Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [45.89.224.132])
 by mx.groups.io with SMTP id smtpd.web11.87629.1696265951361701843
 for <u-boot-amlogic@groups.io>;
 Mon, 02 Oct 2023 09:59:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CF12E12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1696265949;
	bh=3b5w/aDsnGyyt1omlwg8u3VeNLLKGUi6lQAhzJ9Xys8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dKCgsFt4fA4G2FPT8QGknoi8cJgjDbMRxwhVVtXzOo/JW6m9LSjqc2qb7qLTGVenP
	 aHL/zUJTVnqYibeHX2mwmSlehZeDTmDtJv4ePhDRwdbpcvbdyuwNV/DXlJYFFhlPRl
	 dIv3pK3B9NKHL0Gdz51sDGqROROvdrNDvAsXkSYMz5KlCPh29bnhs+KH0ObxlJKUUD
	 wOu96wsgXITU23APvijiWVa7vIYvaffsEMSP2rLuzu2GoiNmLk266L0eLxFe6up1Ui
	 3iJBFnI+Rpf2/zuJ7r12iZwfdGwCo1Y2bjJgb598EeJmdV8f8GOSPunIfrwThxNvns
	 nIHfkaKoUbbfg==
From: Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 6/8] a1: clk: Add missing CLKID_USB_PHY_IN gate
Date: Mon, 2 Oct 2023 19:58:50 +0300
Message-ID: <20231002165857.19512-7-avromanov@salutedevices.com>
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: neil.armstrong@linaro.org, narmstrong@baylibre.com, sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru, Igor Prusov <ivprusov@salutedevices.com>
List-ID: <u-boot-amlogic@groups.io>

From: Igor Prusov <ivprusov@salutedevices.com>

We use this clock in dwc3 driver.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 drivers/clk/meson/a1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 3aec42f33b..1540e1875b 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -238,6 +238,9 @@ static const struct meson_clk_info *meson_clocks[] =3D =
{
 	[CLKID_FIXPLL_IN] =3D CLK_GATE("fixpll_in", A1_SYS_OSCIN_CTRL, 1,
 		EXTERNAL_XTAL
 	),
+	[CLKID_USB_PHY_IN] =3D CLK_GATE("usb_phy_in", A1_SYS_OSCIN_CTRL, 2,
+		EXTERNAL_XTAL
+	),
 	[CLKID_SARADC] =3D CLK_GATE("saradc", A1_SAR_ADC_CLK_CTR, 8,
 		-ENOENT
 	),
--=20
2.25.1

