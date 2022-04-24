Received: from mx.msync.work (mx.msync.work [185.250.0.168])
 by mx.groups.io with SMTP id smtpd.web12.15483.1650788536378345509
 for <u-boot-amlogic@groups.io>;
 Sun, 24 Apr 2022 01:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1650788530; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=c9TDDL81pqutqfD5CmSuE8RTtZR60o7ccaoZlTd8nyQ=;
	b=HkwLNzs6Z98AWCgEAel2v8YJjY82Yk4fqOjUVbw+DtmxwFyXsw+6sZKaZpGx/juGpMCDrJ
	AAPgIOOhp1KusIys3V2JfAuJHF9JAd1Moqdb1HFpAKGSkohdheHjhu7LAsV7lUO2tQMrfh
	maZDI3f2rsSUlK/DNJlWzvfgEcDI/oDf3oejLimNze2ZBjSM/Q2HZwNYtgfeWc0PHdaotL
	sqZpYGyCdRF+TVLWq4tYutTCeHLLlCO2c8o9NclBJ5G9Npp/U8gr84Pi38f9AhB2IQS5IP
	s+3YFQvcwKCT0Lg6qlTzcihTJVMueOE2JE+cLXenKIgJN/R00mMtId0dQbskXw==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v3 6/6] board: amlogic: jethub j100: enable saradc in config
Date: Sun, 24 Apr 2022 11:21:59 +0300
Message-Id: <20220424082159.757622-7-adeep@lexina.in>
In-Reply-To: <20220424082159.757622-1-adeep@lexina.in>
References: <20220424082159.757622-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Enable ADC in board config file

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

