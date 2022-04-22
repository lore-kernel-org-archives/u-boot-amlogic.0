Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web09.4933.1650605370209096222
 for <u-boot-amlogic@groups.io>;
 Thu, 21 Apr 2022 22:29:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650605365; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=T+JPQUl18J2MLEDZj2fmotScxq6Oi+HgMC9DWngqrn8=;
	b=jsq90jvCgwJaQnPGibVXET0r8Ww+nZxDa83pLv8uMWoxIIYJl8y2ND/FvrFIfGsyaqbd8Q
	UNPzjJJqEaWb7FwxTu8wHBr2c87+hzBDxGMjtRgPnoL4mvbyVd4eYtgX/DEOi4wK1ncw4R
	m5H/Vh2XOKEqEt27gTyOtSwmhoCR7jfI0QFALy68d6Pb1TgtnSylhSplxfYWxgblhvU1aD
	f8iqwPOO6/j2sfdW0woovU2t5d5MAqRiAU4rIegJhwAZxWRSV59l+2JbcKFBAWK9kgryyu
	mICMjovPqpTKPxcVwD525V6Qm6y9zz+/uuvjXkcrJgLarX6WN/0R4xdg0tJ2sA==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2 6/6] board: amlogic: jethub j100: enable saradc in config
Date: Fri, 22 Apr 2022 08:29:14 +0300
Message-Id: <20220422052914.1836694-7-adeep@lexina.in>
In-Reply-To: <20220422052914.1836694-1-adeep@lexina.in>
References: <20220422052914.1836694-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Enable ADC in board config file

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 configs/jethub_j100_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
index 1c6db9f6a0..a30940bf1c 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -17,6 +17,7 @@ CONFIG_REMAKE_ELF=3Dy
 CONFIG_OF_BOARD_SETUP=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=3Dy
+CONFIG_CMD_ADC=3Dy
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_EEPROM=3Dy
@@ -34,6 +35,10 @@ CONFIG_OF_CONTROL=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_DM_I2C=3Dy
 CONFIG_SYS_I2C_MESON=3Dy
+CONFIG_ADC=3Dy
+CONFIG_SARADC_MESON=3Dy
+CONFIG_CLK=3Dy
+CONFIG_CLK_MESON_AXG=3Dy
 CONFIG_MMC_MESON_GX=3Dy
 CONFIG_MTD_UBI=3Dy
 CONFIG_PHY_REALTEK=3Dy
--=20
2.30.2

