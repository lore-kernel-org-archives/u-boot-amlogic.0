Received: by mail-wm1-f65.google.com with SMTP id 22so5619505wmg.2
        for <u-boot-amlogic@groups.io>; Tue, 04 Jun 2019 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmVCkw6wTHmgykieXCuFRYX2ZUiej0nj8ZYV3FCCTSg=;
        b=scsuZ6CWnYnu+8wKlek4qme7vi4htTQzNZyPT50591wtR+U75IX9Sb23zaFdJsHoF1
         V0eNvzgjin08Fas17BUfj9TPEhBTAjsZRsmAEu+HjitTTw/fXgcg1oZIUyHO6id8Ih5w
         Q1WJHn5IksOAAvYfetbLiain4dQb7hpNSV9fo2aAB1GIAXx8ThIc7B5a8rxEKHESLMUj
         aqRNBZ95iRypYoSfqWRmZ87nteW9at1aMche+JTANuRtq4P+4JOl6igLWXvXonbLDFAO
         KzhZztqsQZz/aEkRcRosm0FkJg/o2ps8bgwtgmxIemVqSjGpot0CN/m0Jh5wmh18pfM4
         eBKg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/4] pinctrl: meson-gx: fix GPIO_TEST_N and GPIOCLK_ groups
Date: Tue,  4 Jun 2019 11:04:51 +0200
Message-Id: <20190604090454.18245-2-narmstrong@baylibre.com>
In-Reply-To: <20190604090454.18245-1-narmstrong@baylibre.com>
References: <20190604090454.18245-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The GPIO_TEST_N was in the wrong pmx group table, move it back with the AO
groups, GPIODV_18 was missing, add it back, and finally the GPIOCLK_*
group names were missing.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 7 +++++--
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 22e8b055d7..59b5be6211 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -144,6 +144,7 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIODV_15, EE_OFF),
 	GPIO_GROUP(GPIODV_16, EE_OFF),
 	GPIO_GROUP(GPIODV_17, EE_OFF),
+	GPIO_GROUP(GPIODV_18, EE_OFF),
 	GPIO_GROUP(GPIODV_19, EE_OFF),
 	GPIO_GROUP(GPIODV_20, EE_OFF),
 	GPIO_GROUP(GPIODV_21, EE_OFF),
@@ -203,8 +204,6 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOCLK_2, EE_OFF),
 	GPIO_GROUP(GPIOCLK_3, EE_OFF),
 
-	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
-
 	/* Bank X */
 	GROUP(uart_tx_a,	4,	13),
 	GROUP(uart_rx_a,	4,	12),
@@ -270,6 +269,8 @@ static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
 	GPIO_GROUP(GPIOAO_12, 0),
 	GPIO_GROUP(GPIOAO_13, 0),
 
+	GPIO_GROUP(GPIO_TEST_N, 0),
+
 	/* bank AO */
 	GROUP(uart_tx_ao_b,	0,	26),
 	GROUP(uart_rx_ao_b,	0,	25),
@@ -318,6 +319,8 @@ static const char * const gpio_periphs_groups[] = {
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
 	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18", "GPIOX_19",
 	"GPIOX_20", "GPIOX_21", "GPIOX_22",
+
+	"GPIOCLK_0", "GPIOCLK_1", "GPIOCLK_2", "GPIOCLK_3",
 };
 
 static const char * const emmc_groups[] = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 1819eee4d0..5acc21b9c2 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -254,6 +254,7 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIODV_15, EE_OFF),
 	GPIO_GROUP(GPIODV_16, EE_OFF),
 	GPIO_GROUP(GPIODV_17, EE_OFF),
+	GPIO_GROUP(GPIODV_18, EE_OFF),
 	GPIO_GROUP(GPIODV_19, EE_OFF),
 	GPIO_GROUP(GPIODV_20, EE_OFF),
 	GPIO_GROUP(GPIODV_21, EE_OFF),
@@ -289,8 +290,6 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOCLK_0, EE_OFF),
 	GPIO_GROUP(GPIOCLK_1, EE_OFF),
 
-	GPIO_GROUP(GPIO_TEST_N, 0),
-
 	/* Bank X */
 	GROUP(sdio_d0,		5,	31),
 	GROUP(sdio_d1,		5,	30),
@@ -415,6 +414,8 @@ static struct meson_pmx_group meson_gxl_aobus_groups[] = {
 	GPIO_GROUP(GPIOAO_8, 0),
 	GPIO_GROUP(GPIOAO_9, 0),
 
+	GPIO_GROUP(GPIO_TEST_N, 0),
+
 	/* bank AO */
 	GROUP(uart_tx_ao_b_0,	0,	26),
 	GROUP(uart_rx_ao_b_1,	0,	25),
@@ -471,6 +472,7 @@ static const char * const gpio_periphs_groups[] = {
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
 	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18",
+	"GPIOCLK_0", "GPIOCLK_1",
 };
 
 static const char * const emmc_groups[] = {
-- 
2.21.0

