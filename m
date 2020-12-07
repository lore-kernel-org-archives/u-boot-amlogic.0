Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by mx.groups.io with SMTP id smtpd.web08.10046.1607361331689840281
 for <u-boot-amlogic@groups.io>;
 Mon, 07 Dec 2020 09:15:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1607361328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:in-reply-to:
	 references; bh=bw2aVtsXrOx0jDtoEYEL//WE69PbmHuJZDXVPEtFi+A=;
	b=sKfAPdcwSPs/r0UcgAatxr1PdO8etBh2rmWgq0c5fDn59DRfAtcwVlbTsfgV7XvnF1SGOV
	8eo24OzZuCTuptClRby4ACbalp63a+RahEpZM4zoMfOcgqaQRdNC+IerwMpw4h+irRLCiz
	zVedm3ecMgq4/Ixbd4IGnpmUJCTHEZ4=
From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] mmc: meson-gx: change clock phase value on AGX SoCs
Date: Mon,  7 Dec 2020 18:15:27 +0100
Message-Id: <132c6c42aee5b4f34aca3a629423641c78302ce0.1607361086.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: narmstrong@baylibre.com
Cc: peng.fan@nxp.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de, Stefan Agner <stefan@agner.ch>
List-ID: <u-boot-amlogic@groups.io>

Amlogic AGX SoCs seem to have issue communicating with some eMMC
devices (in particular with a Micron 128GB eMMC 5.1). The device
is detected with 1-bit bus width, and at higher temperature loading
pretty much anything from the storage fails: (e.g. fs_devread read error
- block).

When phase is set to 270=C2=B0 it is detected with 8-bit bus width and is
working fine accross all temperatures.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Neil,

I debugged this issue today on an ODROID N2+ not booting reliably. I am
not sure if we can safely switch to 270=C2=B0 for all SoCs with
amlogic,meson-axg-mmc, but I guess we have to try and see what happens?
I will do a bit broader testing in the comming days here.

Btw, I do see that 180=C2=B0 is also set in Linux. Do you have a patch to
address this in Linux?

--
Stefan


 arch/arm/include/asm/arch-meson/sd_emmc.h | 1 +
 drivers/mmc/meson_gx_mmc.c                | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/sd_emmc.h b/arch/arm/include=
/asm/arch-meson/sd_emmc.h
index cb16f75fc6..db5e058098 100644
--- a/arch/arm/include/asm/arch-meson/sd_emmc.h
+++ b/arch/arm/include/asm/arch-meson/sd_emmc.h
@@ -14,6 +14,7 @@
=20
 enum meson_gx_mmc_compatible {
 	MMC_COMPATIBLE_GX,
+	MMC_COMPATIBLE_AGX,
 	MMC_COMPATIBLE_SM1,
 };
=20
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index 5facbfdd9a..2c27113c10 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -64,14 +64,15 @@ static void meson_mmc_config_clock(struct mmc *mmc)
=20
 	/*
 	 * SM1 SoCs doesn't work fine over 50MHz with CLK_CO_PHASE_180
+	 * AGX SoCs don't work reliable with some eMMCs with CLK_CO_PHASE_180
 	 * If CLK_CO_PHASE_270 is used, it's more stable than other.
 	 * Other SoCs use CLK_CO_PHASE_180 by default.
 	 * It needs to find what is a proper value about each SoCs.
 	 */
-	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_SM1))
-		meson_mmc_clk |=3D CLK_CO_PHASE_270;
-	else
+	if (meson_gx_mmc_is_compatible(mmc->dev, MMC_COMPATIBLE_GX))
 		meson_mmc_clk |=3D CLK_CO_PHASE_180;
+	else
+		meson_mmc_clk |=3D CLK_CO_PHASE_270;
=20
 	/* 180 phase tx clock */
 	meson_mmc_clk |=3D CLK_TX_PHASE_000;
@@ -327,7 +328,7 @@ int meson_mmc_bind(struct udevice *dev)
=20
 static const struct udevice_id meson_mmc_match[] =3D {
 	{ .compatible =3D "amlogic,meson-gx-mmc", .data =3D MMC_COMPATIBLE_GX }=
,
-	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_GX =
},
+	{ .compatible =3D "amlogic,meson-axg-mmc", .data =3D MMC_COMPATIBLE_AGX=
 },
 	{ .compatible =3D "amlogic,meson-sm1-mmc", .data =3D MMC_COMPATIBLE_SM1=
 },
 	{ /* sentinel */ }
 };
--=20
2.29.2

