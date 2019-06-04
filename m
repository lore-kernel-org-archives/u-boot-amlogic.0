Received: by mail-wr1-f68.google.com with SMTP id f9so2464106wre.12
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MizOZ1U/+oIYTgjhUSfiV4yUc0ebw7v/obq+sYXKrO8=;
        b=JGEawBpqXsNdSCxPyWGtGo+mp+GmobsXH3R/SjeLh0yJgaJbqW7nBbtEUnuvp2Cx77
         UIjy8Cu5oPhoaitzxRuAc2u8B2k/BzNVubqBOYWYEphkjQHBAKJ6geQxlCqa5Qb37Mxz
         4sJgSZqO0N7/2UAS+hc1y39Csg/jwl2jSg9scEcIqIMljYJzvwseVpPxOAS7zqS7u6Ox
         ad8CCBKn8DJIWEPCunfFHBvgsYtSt0Vc6LGOnSpaiD+VmVMh4QxNjomd3lJq0WMWPXm8
         W8nkjwekeARv0+T3/QCMMY258Fm+CL8VPKbXAJYvL4yOssv3znrgWBpkm5dRYMFmJWUu
         wPOQ==
Return-Path: <mjourdan@baylibre.com>
From: Maxime Jourdan <mjourdan@baylibre.com>
Subject: [PATCH] pinctrl: meson-gxbb: add hdmi related pins
Date: Tue,  4 Jun 2019 22:26:37 +0200
Message-Id: <20190604202637.6421-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Neil Armstrong <narmstrong@baylibre.com>, u-boot@lists.denx.de
Cc: Jerome Brunet <jbrunet@baylibre.com>, Mohammad Rasim <mohammad.rasim96@gmail.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

The GXBB pinctrl is missing pins related to HDMI, namely hot plug
detection (hpd) and I2C (sda + scl).

This fixes HDMI support for GXBB in u-boot.

Reported-by: Mohammad Rasim <mohammad.rasim96@gmail.com>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 59b5be6211..9e2e151164 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -61,6 +61,10 @@ static const unsigned int eth_txd1_pins[]	= { PIN(GPIOZ_11, EE_OFF) };
 static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
 static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
 
+static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0, EE_OFF) };
+static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1, EE_OFF) };
+static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2, EE_OFF) };
+
 static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
 static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
 static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
@@ -232,6 +236,11 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(eth_txd2,		6,	3),
 	GROUP(eth_txd3,		6,	2),
 
+	/* Bank H */
+	GROUP(hdmi_hpd,		1,	26),
+	GROUP(hdmi_sda,		1,	25),
+	GROUP(hdmi_scl,		1,	24),
+
 	/* Bank DV */
 	GROUP(uart_tx_b,	2,	29),
 	GROUP(uart_rx_b,	2,	28),
@@ -351,6 +360,14 @@ static const char * const eth_groups[] = {
 	"eth_txd0", "eth_txd1", "eth_txd2", "eth_txd3",
 };
 
+static const char * const hdmi_hpd_groups[] = {
+	"hdmi_hpd",
+};
+
+static const char * const hdmi_i2c_groups[] = {
+	"hdmi_sda", "hdmi_scl",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -383,6 +400,8 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
 	FUNCTION(eth),
+	FUNCTION(hdmi_hpd),
+	FUNCTION(hdmi_i2c),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
-- 
2.21.0

