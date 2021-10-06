Received: from mx.msync.work (mx.msync.work [95.217.35.189])
 by mx.groups.io with SMTP id smtpd.web10.13590.1633533128503161485
 for <u-boot-amlogic@groups.io>;
 Wed, 06 Oct 2021 08:12:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1633533119; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NozBDW9gmifdsJpBsHPa64CEf79K5BKxPd2Ve26WCtU=;
	b=D/FNH8F9Q+U/Lu3R7GevcQlXVPstyVozEIogsbs9YSThY3lOnM3Z3exCRWu3E6e63MQmtT
	WK3QzZiOcP84BWcybJ7f6DVxME5XroJQiOWwT7mhuWaIYaQwhpt4bYIelBiBjRWrXxzOM7
	1ptLCQmH2GyxLhmkiFEm3OlbzIAJDgr1peoYRF6I/L0KLkRd6tCRLp12TAcGcIcE5M0gyC
	BwVM/J7Q1NohOk7qq10XYdeWRQ1LuYMzNTxVZ00Epyh0++eqW66EUG5pqGsXZKqhzRfYcE
	eS5A/xPn/pFCQg7C88gzQrd/FSaOGjsBYMH1+7DQMbzwO2FgevbTDImjsgO2og==
From: "Vyacheslav Bocharov" <adeep@lexina.in>
Subject: [PATCH v2] ARM: amlogic: update JetHub D1/H1 configs (was: add SYS_LOAD_ADDR to JetHub D1/H1 configs)
Date: Wed,  6 Oct 2021 18:11:48 +0300
Message-Id: <20211006151148.1240465-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

- late fix for 49c8ef0e45a91ec894ef15e7d043dafe8f1c5efd commit by Tom Rin=
i.
- enable i2c, rtc, eeprom

Changes:
- add i2c, rtc, eeprom

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 configs/jethub_j100_defconfig | 8 ++++++++
 configs/jethub_j80_defconfig  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/configs/jethub_j100_defconfig b/configs/jethub_j100_defconfi=
g
index 290ce4db85..533f251855 100644
--- a/configs/jethub_j100_defconfig
+++ b/configs/jethub_j100_defconfig
@@ -11,21 +11,27 @@ CONFIG_DEBUG_UART_BASE=3D0xff803000
 CONFIG_DEBUG_UART_CLOCK=3D24000000
 CONFIG_IDENT_STRING=3D" jethubj100"
 CONFIG_DEBUG_UART=3Dy
+CONFIG_SYS_LOAD_ADDR=3D0x01000000
 CONFIG_OF_BOARD_SETUP=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=3Dy
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_EEPROM=3Dy
 CONFIG_CMD_GPIO=3Dy
 CONFIG_RANDOM_UUID=3Dy
+CONFIG_CMD_I2C=3Dy
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=3Dy
 CONFIG_CMD_USB=3Dy
 CONFIG_CMD_USB_MASS_STORAGE=3Dy
+CONFIG_CMD_RTC=3Dy
 CONFIG_CMD_REGULATOR=3Dy
 CONFIG_PARTITION_TYPE_GUID=3Dy
 CONFIG_OF_CONTROL=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
+CONFIG_DM_I2C=3Dy
+CONFIG_SYS_I2C_MESON=3Dy
 CONFIG_MMC_MESON_GX=3Dy
 CONFIG_MTD_UBI=3Dy
 CONFIG_PHY_REALTEK=3Dy
@@ -37,6 +43,8 @@ CONFIG_PINCTRL_MESON_AXG=3Dy
 CONFIG_DM_REGULATOR=3Dy
 CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_DM_RESET=3Dy
+CONFIG_DM_RTC=3Dy
+CONFIG_RTC_PCF8563=3Dy
 CONFIG_DEBUG_UART_ANNOUNCE=3Dy
 CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
diff --git a/configs/jethub_j80_defconfig b/configs/jethub_j80_defconfig
index 7db05af3b0..ad6bec0c43 100644
--- a/configs/jethub_j80_defconfig
+++ b/configs/jethub_j80_defconfig
@@ -12,25 +12,31 @@ CONFIG_DEBUG_UART_BASE=3D0xc81004c0
 CONFIG_DEBUG_UART_CLOCK=3D24000000
 CONFIG_IDENT_STRING=3D" jethubj80"
 CONFIG_DEBUG_UART=3Dy
+CONFIG_SYS_LOAD_ADDR=3D0x01000000
 CONFIG_OF_BOARD_SETUP=3Dy
 CONFIG_CONSOLE_MUX=3Dy
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_MISC_INIT_R=3Dy
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_IMI is not set
+CONFIG_CMD_EEPROM=3Dy
 CONFIG_CMD_ADC=3Dy
 CONFIG_CMD_GPIO=3Dy
 CONFIG_RANDOM_UUID=3Dy
+CONFIG_CMD_I2C=3Dy
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=3Dy
 CONFIG_CMD_USB=3Dy
 CONFIG_CMD_USB_MASS_STORAGE=3Dy
+CONFIG_CMD_RTC=3Dy
 CONFIG_CMD_REGULATOR=3Dy
 CONFIG_PARTITION_TYPE_GUID=3Dy
 CONFIG_OF_CONTROL=3Dy
 CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
 CONFIG_NET_RANDOM_ETHADDR=3Dy
 CONFIG_SARADC_MESON=3Dy
+CONFIG_DM_I2C=3Dy
+CONFIG_SYS_I2C_MESON=3Dy
 CONFIG_MMC_MESON_GX=3Dy
 CONFIG_MTD_UBI=3Dy
 CONFIG_PHY_MESON_GXL=3Dy
@@ -45,6 +51,8 @@ CONFIG_PINCTRL_MESON_GXL=3Dy
 CONFIG_DM_REGULATOR=3Dy
 CONFIG_DM_REGULATOR_FIXED=3Dy
 CONFIG_DM_RESET=3Dy
+CONFIG_DM_RTC=3Dy
+CONFIG_RTC_PCF8563=3Dy
 CONFIG_DEBUG_UART_ANNOUNCE=3Dy
 CONFIG_DEBUG_UART_SKIP_INIT=3Dy
 CONFIG_MESON_SERIAL=3Dy
--=20
2.30.2

