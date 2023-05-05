Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
 by mx.groups.io with SMTP id smtpd.web10.26259.1683291416793571004
 for <u-boot-amlogic@groups.io>;
 Fri, 05 May 2023 05:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
	s=mail; t=1683291414;
	bh=ctEMrIL1YRJEP5NlUNrVjczTTDZDnPlSAHGyKmMLg5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ZywvvUb7tLbudeksVGRDntjoiIhS10XCCqr8WzC9LNpUIthrIT/nU6QIBV1xCbiI4
	 F9tLdY3EK8GZFRjalFX4wstAoMtjjKmFrheb0Nmthai99yQxWPcDhynzkUugPqeEWd
	 NkxcQrCgbwaOsj8nBf/ljwA0nohZrIBNHvc9BfwsLeH0893VXz1P/qqgfzlt++dJiz
	 Tj0SkKwHpnU/4KacIXW7FirxeIyAb0e7EDYYzxEuDQGSm0V2GZp27oQxipGQrmrDZV
	 WkYkiPtnDqMA0UUJPE0fL8ZCyitEkJDwo+i9mX6Ba+EsRyaOIzYhx1eF9ZCLyihxsK
	 /MbNHNJb887yA==
From: Igor Prusov <ivprusov@sberdevices.ru>
Subject: [RFC PATCH v2 4/5] pinctrl: meson: add pinctrl driver for Amlogic A1
Date: Fri, 5 May 2023 15:56:38 +0300
Message-ID: <20230505125639.3605-5-ivprusov@sberdevices.ru>
In-Reply-To: <20230505125639.3605-1-ivprusov@sberdevices.ru>
References: <20230505125639.3605-1-ivprusov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, Igor Prusov <ivprusov@sberdevices.ru>, u-boot@lists.denx.de, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

Based on Linux kernel commit:
dabad1ff85611 (pinctrl: meson: add pinctrl driver support for Meson-A1 SoC)

Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/meson/Kconfig            |   4 +
 drivers/pinctrl/meson/Makefile           |   1 +
 drivers/pinctrl/meson/pinctrl-meson-a1.c | 867 +++++++++++++++++++++++
 3 files changed, 872 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-a1.c

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index ef02087ed2..97e574330f 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -29,4 +29,8 @@ config PINCTRL_MESON_G12A
 	bool "Amlogic Meson G12a SoC pinctrl driver"
 	select PINCTRL_MESON_AXG_PMX
=20
+config PINCTRL_MESON_A1
+	bool "Amlogic Meson A1 SoC pinctrl driver"
+	select PINCTRL_MESON_AXG_PMX
+
 endif
diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefil=
e
index 80dba65e1b..8d10d027ac 100644
--- a/drivers/pinctrl/meson/Makefile
+++ b/drivers/pinctrl/meson/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_PINCTRL_MESON_GXBB)	+=3D pinctrl-meson-gxbb.o
 obj-$(CONFIG_PINCTRL_MESON_GXL)		+=3D pinctrl-meson-gxl.o
 obj-$(CONFIG_PINCTRL_MESON_AXG)		+=3D pinctrl-meson-axg.o
 obj-$(CONFIG_PINCTRL_MESON_G12A)	+=3D pinctrl-meson-g12a.o
+obj-$(CONFIG_PINCTRL_MESON_A1)		+=3D pinctrl-meson-a1.o
diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/mes=
on/pinctrl-meson-a1.c
new file mode 100644
index 0000000000..30cf3bc0be
--- /dev/null
+++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
@@ -0,0 +1,867 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Qianggui Song <qianggui.song@amlogic.com>
+ * Copyright (C) 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@sberdevices.ru>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <dm/pinctrl.h>
+#include <dt-bindings/gpio/meson-a1-gpio.h>
+
+#include "pinctrl-meson.h"
+#include "pinctrl-meson-axg.h"
+
+/* psram */
+static const unsigned int psram_clkn_pins[]		=3D { GPIOP_0 };
+static const unsigned int psram_clkp_pins[]		=3D { GPIOP_1 };
+static const unsigned int psram_ce_n_pins[]		=3D { GPIOP_2 };
+static const unsigned int psram_rst_n_pins[]		=3D { GPIOP_3 };
+static const unsigned int psram_adq0_pins[]		=3D { GPIOP_4 };
+static const unsigned int psram_adq1_pins[]		=3D { GPIOP_5 };
+static const unsigned int psram_adq2_pins[]		=3D { GPIOP_6 };
+static const unsigned int psram_adq3_pins[]		=3D { GPIOP_7 };
+static const unsigned int psram_adq4_pins[]		=3D { GPIOP_8 };
+static const unsigned int psram_adq5_pins[]		=3D { GPIOP_9 };
+static const unsigned int psram_adq6_pins[]		=3D { GPIOP_10 };
+static const unsigned int psram_adq7_pins[]		=3D { GPIOP_11 };
+static const unsigned int psram_dqs_dm_pins[]		=3D { GPIOP_12 };
+
+/* sdcard */
+static const unsigned int sdcard_d0_b_pins[]		=3D { GPIOB_0 };
+static const unsigned int sdcard_d1_b_pins[]		=3D { GPIOB_1 };
+static const unsigned int sdcard_d2_b_pins[]		=3D { GPIOB_2 };
+static const unsigned int sdcard_d3_b_pins[]		=3D { GPIOB_3 };
+static const unsigned int sdcard_clk_b_pins[]		=3D { GPIOB_4 };
+static const unsigned int sdcard_cmd_b_pins[]		=3D { GPIOB_5 };
+
+static const unsigned int sdcard_d0_x_pins[]		=3D { GPIOX_0 };
+static const unsigned int sdcard_d1_x_pins[]		=3D { GPIOX_1 };
+static const unsigned int sdcard_d2_x_pins[]		=3D { GPIOX_2 };
+static const unsigned int sdcard_d3_x_pins[]		=3D { GPIOX_3 };
+static const unsigned int sdcard_clk_x_pins[]		=3D { GPIOX_4 };
+static const unsigned int sdcard_cmd_x_pins[]		=3D { GPIOX_5 };
+
+/* spif */
+static const unsigned int spif_mo_pins[]		=3D { GPIOB_0 };
+static const unsigned int spif_mi_pins[]		=3D { GPIOB_1 };
+static const unsigned int spif_wp_n_pins[]		=3D { GPIOB_2 };
+static const unsigned int spif_hold_n_pins[]		=3D { GPIOB_3 };
+static const unsigned int spif_clk_pins[]		=3D { GPIOB_4 };
+static const unsigned int spif_cs_pins[]		=3D { GPIOB_5 };
+
+/* i2c0 */
+static const unsigned int i2c0_sck_f9_pins[]		=3D { GPIOF_9 };
+static const unsigned int i2c0_sda_f10_pins[]		=3D { GPIOF_10 };
+static const unsigned int i2c0_sck_f11_pins[]		=3D { GPIOF_11 };
+static const unsigned int i2c0_sda_f12_pins[]		=3D { GPIOF_12 };
+
+/* i2c1 */
+static const unsigned int i2c1_sda_x_pins[]		=3D { GPIOX_9 };
+static const unsigned int i2c1_sck_x_pins[]		=3D { GPIOX_10 };
+static const unsigned int i2c1_sda_a_pins[]		=3D { GPIOA_10 };
+static const unsigned int i2c1_sck_a_pins[]		=3D { GPIOA_11 };
+
+/* i2c2 */
+static const unsigned int i2c2_sck_x0_pins[]		=3D { GPIOX_0 };
+static const unsigned int i2c2_sda_x1_pins[]		=3D { GPIOX_1 };
+static const unsigned int i2c2_sck_x15_pins[]		=3D { GPIOX_15 };
+static const unsigned int i2c2_sda_x16_pins[]		=3D { GPIOX_16 };
+static const unsigned int i2c2_sck_a4_pins[]		=3D { GPIOA_4 };
+static const unsigned int i2c2_sda_a5_pins[]		=3D { GPIOA_5 };
+static const unsigned int i2c2_sck_a8_pins[]		=3D { GPIOA_8 };
+static const unsigned int i2c2_sda_a9_pins[]		=3D { GPIOA_9 };
+
+/* i2c3 */
+static const unsigned int i2c3_sck_f_pins[]		=3D { GPIOF_4 };
+static const unsigned int i2c3_sda_f_pins[]		=3D { GPIOF_5 };
+static const unsigned int i2c3_sck_x_pins[]		=3D { GPIOX_11 };
+static const unsigned int i2c3_sda_x_pins[]		=3D { GPIOX_12 };
+
+/* i2c slave */
+static const unsigned int i2c_slave_sck_a_pins[]	=3D { GPIOA_10 };
+static const unsigned int i2c_slave_sda_a_pins[]	=3D { GPIOA_11 };
+static const unsigned int i2c_slave_sck_f_pins[]	=3D { GPIOF_11 };
+static const unsigned int i2c_slave_sda_f_pins[]	=3D { GPIOF_12 };
+
+/* uart_a */
+static const unsigned int uart_a_tx_pins[]		=3D { GPIOX_11 };
+static const unsigned int uart_a_rx_pins[]		=3D { GPIOX_12 };
+static const unsigned int uart_a_cts_pins[]		=3D { GPIOX_13 };
+static const unsigned int uart_a_rts_pins[]		=3D { GPIOX_14 };
+
+/* uart_b */
+static const unsigned int uart_b_tx_x_pins[]		=3D { GPIOX_7 };
+static const unsigned int uart_b_rx_x_pins[]		=3D { GPIOX_8 };
+static const unsigned int uart_b_tx_f_pins[]		=3D { GPIOF_0 };
+static const unsigned int uart_b_rx_f_pins[]		=3D { GPIOF_1 };
+
+/* uart_c */
+static const unsigned int uart_c_tx_x0_pins[]		=3D { GPIOX_0 };
+static const unsigned int uart_c_rx_x1_pins[]		=3D { GPIOX_1 };
+static const unsigned int uart_c_cts_pins[]		=3D { GPIOX_2 };
+static const unsigned int uart_c_rts_pins[]		=3D { GPIOX_3 };
+static const unsigned int uart_c_tx_x15_pins[]		=3D { GPIOX_15 };
+static const unsigned int uart_c_rx_x16_pins[]		=3D { GPIOX_16 };
+
+/* pmw_a */
+static const unsigned int pwm_a_x6_pins[]		=3D { GPIOX_6 };
+static const unsigned int pwm_a_x7_pins[]		=3D { GPIOX_7 };
+static const unsigned int pwm_a_f6_pins[]		=3D { GPIOF_6 };
+static const unsigned int pwm_a_f10_pins[]		=3D { GPIOF_10 };
+static const unsigned int pwm_a_a_pins[]		=3D { GPIOA_5 };
+
+/* pmw_b */
+static const unsigned int pwm_b_x_pins[]		=3D { GPIOX_8 };
+static const unsigned int pwm_b_f_pins[]		=3D { GPIOF_7 };
+static const unsigned int pwm_b_a_pins[]		=3D { GPIOA_11 };
+
+/* pmw_c */
+static const unsigned int pwm_c_x_pins[]		=3D { GPIOX_9 };
+static const unsigned int pwm_c_f3_pins[]		=3D { GPIOF_3 };
+static const unsigned int pwm_c_f8_pins[]		=3D { GPIOF_8 };
+static const unsigned int pwm_c_a_pins[]		=3D { GPIOA_10 };
+
+/* pwm_d */
+static const unsigned int pwm_d_x10_pins[]		=3D { GPIOX_10 };
+static const unsigned int pwm_d_x13_pins[]		=3D { GPIOX_13 };
+static const unsigned int pwm_d_x15_pins[]		=3D { GPIOX_15 };
+static const unsigned int pwm_d_f_pins[]		=3D { GPIOF_11 };
+
+/* pwm_e */
+static const unsigned int pwm_e_p_pins[]		=3D { GPIOP_3 };
+static const unsigned int pwm_e_x2_pins[]		=3D { GPIOX_2 };
+static const unsigned int pwm_e_x14_pins[]		=3D { GPIOX_14 };
+static const unsigned int pwm_e_x16_pins[]		=3D { GPIOX_16 };
+static const unsigned int pwm_e_f_pins[]		=3D { GPIOF_3 };
+static const unsigned int pwm_e_a_pins[]		=3D { GPIOA_0 };
+
+/* pwm_f */
+static const unsigned int pwm_f_b_pins[]		=3D { GPIOB_6 };
+static const unsigned int pwm_f_x_pins[]		=3D { GPIOX_3 };
+static const unsigned int pwm_f_f4_pins[]		=3D { GPIOF_4 };
+static const unsigned int pwm_f_f12_pins[]		=3D { GPIOF_12 };
+
+/* pwm_a_hiz */
+static const unsigned int pwm_a_hiz_f8_pins[]		=3D { GPIOF_8 };
+static const unsigned int pwm_a_hiz_f10_pins[]		=3D { GPIOF_10 };
+static const unsigned int pmw_a_hiz_f6_pins[]		=3D { GPIOF_6 };
+
+/* pwm_b_hiz */
+static const unsigned int pwm_b_hiz_pins[]		=3D { GPIOF_7 };
+
+/* pmw_c_hiz */
+static const unsigned int pwm_c_hiz_pins[]		=3D { GPIOF_8 };
+
+/* tdm_a */
+static const unsigned int tdm_a_dout1_pins[]		=3D { GPIOX_7 };
+static const unsigned int tdm_a_dout0_pins[]		=3D { GPIOX_8 };
+static const unsigned int tdm_a_fs_pins[]		=3D { GPIOX_9 };
+static const unsigned int tdm_a_sclk_pins[]		=3D { GPIOX_10 };
+static const unsigned int tdm_a_din1_pins[]		=3D { GPIOX_7 };
+static const unsigned int tdm_a_din0_pins[]		=3D { GPIOX_8 };
+static const unsigned int tdm_a_slv_fs_pins[]		=3D { GPIOX_9 };
+static const unsigned int tdm_a_slv_sclk_pins[]		=3D { GPIOX_10 };
+
+/* spi_a */
+static const unsigned int spi_a_mosi_x2_pins[]		=3D { GPIOX_2 };
+static const unsigned int spi_a_ss0_x3_pins[]		=3D { GPIOX_3 };
+static const unsigned int spi_a_sclk_x4_pins[]		=3D { GPIOX_4 };
+static const unsigned int spi_a_miso_x5_pins[]		=3D { GPIOX_5 };
+static const unsigned int spi_a_mosi_x7_pins[]		=3D { GPIOX_7 };
+static const unsigned int spi_a_miso_x8_pins[]		=3D { GPIOX_8 };
+static const unsigned int spi_a_ss0_x9_pins[]		=3D { GPIOX_9 };
+static const unsigned int spi_a_sclk_x10_pins[]		=3D { GPIOX_10 };
+
+static const unsigned int spi_a_mosi_a_pins[]		=3D { GPIOA_6 };
+static const unsigned int spi_a_miso_a_pins[]		=3D { GPIOA_7 };
+static const unsigned int spi_a_ss0_a_pins[]		=3D { GPIOA_8 };
+static const unsigned int spi_a_sclk_a_pins[]		=3D { GPIOA_9 };
+
+/* pdm */
+static const unsigned int pdm_din0_x_pins[]		=3D { GPIOX_7 };
+static const unsigned int pdm_din1_x_pins[]		=3D { GPIOX_8 };
+static const unsigned int pdm_din2_x_pins[]		=3D { GPIOX_9 };
+static const unsigned int pdm_dclk_x_pins[]		=3D { GPIOX_10 };
+
+static const unsigned int pdm_din2_a_pins[]		=3D { GPIOA_6 };
+static const unsigned int pdm_din1_a_pins[]		=3D { GPIOA_7 };
+static const unsigned int pdm_din0_a_pins[]		=3D { GPIOA_8 };
+static const unsigned int pdm_dclk_pins[]		=3D { GPIOA_9 };
+
+/* gen_clk */
+static const unsigned int gen_clk_x_pins[]		=3D { GPIOX_7 };
+static const unsigned int gen_clk_f8_pins[]		=3D { GPIOF_8 };
+static const unsigned int gen_clk_f10_pins[]		=3D { GPIOF_10 };
+static const unsigned int gen_clk_a_pins[]		=3D { GPIOA_11 };
+
+/* jtag_a */
+static const unsigned int jtag_a_clk_pins[]		=3D { GPIOF_4 };
+static const unsigned int jtag_a_tms_pins[]		=3D { GPIOF_5 };
+static const unsigned int jtag_a_tdi_pins[]		=3D { GPIOF_6 };
+static const unsigned int jtag_a_tdo_pins[]		=3D { GPIOF_7 };
+
+/* clk_32_in */
+static const unsigned int clk_32k_in_pins[]		=3D { GPIOF_2 };
+
+/* ir in */
+static const unsigned int remote_input_f_pins[]		=3D { GPIOF_3 };
+static const unsigned int remote_input_a_pins[]		=3D { GPIOA_11 };
+
+/* ir out */
+static const unsigned int remote_out_pins[]		=3D { GPIOF_5 };
+
+/* spdif */
+static const unsigned int spdif_in_f6_pins[]		=3D { GPIOF_6 };
+static const unsigned int spdif_in_f7_pins[]		=3D { GPIOF_7 };
+
+/* sw */
+static const unsigned int swclk_pins[]			=3D { GPIOF_4 };
+static const unsigned int swdio_pins[]			=3D { GPIOF_5 };
+
+/* clk_25 */
+static const unsigned int clk25_pins[]			=3D { GPIOF_10 };
+
+/* cec_a */
+static const unsigned int cec_a_pins[]			=3D { GPIOF_2 };
+
+/* cec_b */
+static const unsigned int cec_b_pins[]			=3D { GPIOF_2 };
+
+/* clk12_24 */
+static const unsigned int clk12_24_pins[]		=3D { GPIOF_10 };
+
+/* mclk_0 */
+static const unsigned int mclk_0_pins[]			=3D { GPIOA_0 };
+
+/* tdm_b */
+static const unsigned int tdm_b_sclk_pins[]		=3D { GPIOA_1 };
+static const unsigned int tdm_b_fs_pins[]		=3D { GPIOA_2 };
+static const unsigned int tdm_b_dout0_pins[]		=3D { GPIOA_3 };
+static const unsigned int tdm_b_dout1_pins[]		=3D { GPIOA_4 };
+static const unsigned int tdm_b_dout2_pins[]		=3D { GPIOA_5 };
+static const unsigned int tdm_b_dout3_pins[]		=3D { GPIOA_6 };
+static const unsigned int tdm_b_dout4_pins[]		=3D { GPIOA_7 };
+static const unsigned int tdm_b_dout5_pins[]		=3D { GPIOA_8 };
+static const unsigned int tdm_b_slv_sclk_pins[]		=3D { GPIOA_5 };
+static const unsigned int tdm_b_slv_fs_pins[]		=3D { GPIOA_6 };
+static const unsigned int tdm_b_din0_pins[]		=3D { GPIOA_7 };
+static const unsigned int tdm_b_din1_pins[]		=3D { GPIOA_8 };
+static const unsigned int tdm_b_din2_pins[]		=3D { GPIOA_9 };
+
+/* mclk_vad */
+static const unsigned int mclk_vad_pins[]		=3D { GPIOA_0 };
+
+/* tdm_vad */
+static const unsigned int tdm_vad_sclk_a1_pins[]	=3D { GPIOA_1 };
+static const unsigned int tdm_vad_fs_a2_pins[]		=3D { GPIOA_2 };
+static const unsigned int tdm_vad_sclk_a5_pins[]	=3D { GPIOA_5 };
+static const unsigned int tdm_vad_fs_a6_pins[]		=3D { GPIOA_6 };
+
+/* tst_out */
+static const unsigned int tst_out0_pins[]		=3D { GPIOA_0 };
+static const unsigned int tst_out1_pins[]		=3D { GPIOA_1 };
+static const unsigned int tst_out2_pins[]		=3D { GPIOA_2 };
+static const unsigned int tst_out3_pins[]		=3D { GPIOA_3 };
+static const unsigned int tst_out4_pins[]		=3D { GPIOA_4 };
+static const unsigned int tst_out5_pins[]		=3D { GPIOA_5 };
+static const unsigned int tst_out6_pins[]		=3D { GPIOA_6 };
+static const unsigned int tst_out7_pins[]		=3D { GPIOA_7 };
+static const unsigned int tst_out8_pins[]		=3D { GPIOA_8 };
+static const unsigned int tst_out9_pins[]		=3D { GPIOA_9 };
+static const unsigned int tst_out10_pins[]		=3D { GPIOA_10 };
+static const unsigned int tst_out11_pins[]		=3D { GPIOA_11 };
+
+/* mute */
+static const unsigned int mute_key_pins[]		=3D { GPIOA_4 };
+static const unsigned int mute_en_pins[]		=3D { GPIOA_5 };
+
+static struct meson_pmx_group meson_a1_periphs_groups[] =3D {
+	GPIO_GROUP(GPIOP_0, 0),
+	GPIO_GROUP(GPIOP_1, 0),
+	GPIO_GROUP(GPIOP_2, 0),
+	GPIO_GROUP(GPIOP_3, 0),
+	GPIO_GROUP(GPIOP_4, 0),
+	GPIO_GROUP(GPIOP_5, 0),
+	GPIO_GROUP(GPIOP_6, 0),
+	GPIO_GROUP(GPIOP_7, 0),
+	GPIO_GROUP(GPIOP_8, 0),
+	GPIO_GROUP(GPIOP_9, 0),
+	GPIO_GROUP(GPIOP_10, 0),
+	GPIO_GROUP(GPIOP_11, 0),
+	GPIO_GROUP(GPIOP_12, 0),
+	GPIO_GROUP(GPIOB_0, 0),
+	GPIO_GROUP(GPIOB_1, 0),
+	GPIO_GROUP(GPIOB_2, 0),
+	GPIO_GROUP(GPIOB_3, 0),
+	GPIO_GROUP(GPIOB_4, 0),
+	GPIO_GROUP(GPIOB_5, 0),
+	GPIO_GROUP(GPIOB_6, 0),
+	GPIO_GROUP(GPIOX_0, 0),
+	GPIO_GROUP(GPIOX_1, 0),
+	GPIO_GROUP(GPIOX_2, 0),
+	GPIO_GROUP(GPIOX_3, 0),
+	GPIO_GROUP(GPIOX_4, 0),
+	GPIO_GROUP(GPIOX_5, 0),
+	GPIO_GROUP(GPIOX_6, 0),
+	GPIO_GROUP(GPIOX_7, 0),
+	GPIO_GROUP(GPIOX_8, 0),
+	GPIO_GROUP(GPIOX_9, 0),
+	GPIO_GROUP(GPIOX_10, 0),
+	GPIO_GROUP(GPIOX_11, 0),
+	GPIO_GROUP(GPIOX_12, 0),
+	GPIO_GROUP(GPIOX_13, 0),
+	GPIO_GROUP(GPIOX_14, 0),
+	GPIO_GROUP(GPIOX_15, 0),
+	GPIO_GROUP(GPIOX_16, 0),
+	GPIO_GROUP(GPIOF_0, 0),
+	GPIO_GROUP(GPIOF_1, 0),
+	GPIO_GROUP(GPIOF_2, 0),
+	GPIO_GROUP(GPIOF_3, 0),
+	GPIO_GROUP(GPIOF_4, 0),
+	GPIO_GROUP(GPIOF_5, 0),
+	GPIO_GROUP(GPIOF_6, 0),
+	GPIO_GROUP(GPIOF_7, 0),
+	GPIO_GROUP(GPIOF_8, 0),
+	GPIO_GROUP(GPIOF_9, 0),
+	GPIO_GROUP(GPIOF_10, 0),
+	GPIO_GROUP(GPIOF_11, 0),
+	GPIO_GROUP(GPIOF_12, 0),
+	GPIO_GROUP(GPIOA_0, 0),
+	GPIO_GROUP(GPIOA_1, 0),
+	GPIO_GROUP(GPIOA_2, 0),
+	GPIO_GROUP(GPIOA_3, 0),
+	GPIO_GROUP(GPIOA_4, 0),
+	GPIO_GROUP(GPIOA_5, 0),
+	GPIO_GROUP(GPIOA_6, 0),
+	GPIO_GROUP(GPIOA_7, 0),
+	GPIO_GROUP(GPIOA_8, 0),
+	GPIO_GROUP(GPIOA_9, 0),
+	GPIO_GROUP(GPIOA_10, 0),
+	GPIO_GROUP(GPIOA_11, 0),
+
+	/* bank P func1 */
+	GROUP(psram_clkn,		1),
+	GROUP(psram_clkp,		1),
+	GROUP(psram_ce_n,		1),
+	GROUP(psram_rst_n,		1),
+	GROUP(psram_adq0,		1),
+	GROUP(psram_adq1,		1),
+	GROUP(psram_adq2,		1),
+	GROUP(psram_adq3,		1),
+	GROUP(psram_adq4,		1),
+	GROUP(psram_adq5,		1),
+	GROUP(psram_adq6,		1),
+	GROUP(psram_adq7,		1),
+	GROUP(psram_dqs_dm,		1),
+
+	/* bank P func2 */
+	GROUP(pwm_e_p,			2),
+
+	/* bank B func1 */
+	GROUP(spif_mo,			1),
+	GROUP(spif_mi,			1),
+	GROUP(spif_wp_n,		1),
+	GROUP(spif_hold_n,		1),
+	GROUP(spif_clk,			1),
+	GROUP(spif_cs,			1),
+	GROUP(pwm_f_b,			1),
+
+	/* bank B func2 */
+	GROUP(sdcard_d0_b,		2),
+	GROUP(sdcard_d1_b,		2),
+	GROUP(sdcard_d2_b,		2),
+	GROUP(sdcard_d3_b,		2),
+	GROUP(sdcard_clk_b,		2),
+	GROUP(sdcard_cmd_b,		2),
+
+	/* bank X func1 */
+	GROUP(sdcard_d0_x,		1),
+	GROUP(sdcard_d1_x,		1),
+	GROUP(sdcard_d2_x,		1),
+	GROUP(sdcard_d3_x,		1),
+	GROUP(sdcard_clk_x,		1),
+	GROUP(sdcard_cmd_x,		1),
+	GROUP(pwm_a_x6,			1),
+	GROUP(tdm_a_dout1,		1),
+	GROUP(tdm_a_dout0,		1),
+	GROUP(tdm_a_fs,			1),
+	GROUP(tdm_a_sclk,		1),
+	GROUP(uart_a_tx,		1),
+	GROUP(uart_a_rx,		1),
+	GROUP(uart_a_cts,		1),
+	GROUP(uart_a_rts,		1),
+	GROUP(pwm_d_x15,		1),
+	GROUP(pwm_e_x16,		1),
+
+	/* bank X func2 */
+	GROUP(i2c2_sck_x0,		2),
+	GROUP(i2c2_sda_x1,		2),
+	GROUP(spi_a_mosi_x2,		2),
+	GROUP(spi_a_ss0_x3,		2),
+	GROUP(spi_a_sclk_x4,		2),
+	GROUP(spi_a_miso_x5,		2),
+	GROUP(tdm_a_din1,		2),
+	GROUP(tdm_a_din0,		2),
+	GROUP(tdm_a_slv_fs,		2),
+	GROUP(tdm_a_slv_sclk,		2),
+	GROUP(i2c3_sck_x,		2),
+	GROUP(i2c3_sda_x,		2),
+	GROUP(pwm_d_x13,		2),
+	GROUP(pwm_e_x14,		2),
+	GROUP(i2c2_sck_x15,		2),
+	GROUP(i2c2_sda_x16,		2),
+
+	/* bank X func3 */
+	GROUP(uart_c_tx_x0,		3),
+	GROUP(uart_c_rx_x1,		3),
+	GROUP(uart_c_cts,		3),
+	GROUP(uart_c_rts,		3),
+	GROUP(pdm_din0_x,		3),
+	GROUP(pdm_din1_x,		3),
+	GROUP(pdm_din2_x,		3),
+	GROUP(pdm_dclk_x,		3),
+	GROUP(uart_c_tx_x15,		3),
+	GROUP(uart_c_rx_x16,		3),
+
+	/* bank X func4 */
+	GROUP(pwm_e_x2,			4),
+	GROUP(pwm_f_x,			4),
+	GROUP(spi_a_mosi_x7,		4),
+	GROUP(spi_a_miso_x8,		4),
+	GROUP(spi_a_ss0_x9,		4),
+	GROUP(spi_a_sclk_x10,		4),
+
+	/* bank X func5 */
+	GROUP(uart_b_tx_x,		5),
+	GROUP(uart_b_rx_x,		5),
+	GROUP(i2c1_sda_x,		5),
+	GROUP(i2c1_sck_x,		5),
+
+	/* bank X func6 */
+	GROUP(pwm_a_x7,			6),
+	GROUP(pwm_b_x,			6),
+	GROUP(pwm_c_x,			6),
+	GROUP(pwm_d_x10,		6),
+
+	/* bank X func7 */
+	GROUP(gen_clk_x,		7),
+
+	/* bank F func1 */
+	GROUP(uart_b_tx_f,		1),
+	GROUP(uart_b_rx_f,		1),
+	GROUP(remote_input_f,		1),
+	GROUP(jtag_a_clk,		1),
+	GROUP(jtag_a_tms,		1),
+	GROUP(jtag_a_tdi,		1),
+	GROUP(jtag_a_tdo,		1),
+	GROUP(gen_clk_f8,		1),
+	GROUP(pwm_a_f10,		1),
+	GROUP(i2c0_sck_f11,		1),
+	GROUP(i2c0_sda_f12,		1),
+
+	/* bank F func2 */
+	GROUP(clk_32k_in,		2),
+	GROUP(pwm_e_f,			2),
+	GROUP(pwm_f_f4,			2),
+	GROUP(remote_out,		2),
+	GROUP(spdif_in_f6,		2),
+	GROUP(spdif_in_f7,		2),
+	GROUP(pwm_a_hiz_f8,		2),
+	GROUP(pwm_a_hiz_f10,		2),
+	GROUP(pwm_d_f,			2),
+	GROUP(pwm_f_f12,		2),
+
+	/* bank F func3 */
+	GROUP(pwm_c_f3,			3),
+	GROUP(swclk,			3),
+	GROUP(swdio,			3),
+	GROUP(pwm_a_f6,			3),
+	GROUP(pwm_b_f,			3),
+	GROUP(pwm_c_f8,			3),
+	GROUP(clk25,			3),
+	GROUP(i2c_slave_sck_f,		3),
+	GROUP(i2c_slave_sda_f,		3),
+
+	/* bank F func4 */
+	GROUP(cec_a,			4),
+	GROUP(i2c3_sck_f,		4),
+	GROUP(i2c3_sda_f,		4),
+	GROUP(pmw_a_hiz_f6,		4),
+	GROUP(pwm_b_hiz,		4),
+	GROUP(pwm_c_hiz,		4),
+	GROUP(i2c0_sck_f9,		4),
+	GROUP(i2c0_sda_f10,		4),
+
+	/* bank F func5 */
+	GROUP(cec_b,			5),
+	GROUP(clk12_24,			5),
+
+	/* bank F func7 */
+	GROUP(gen_clk_f10,		7),
+
+	/* bank A func1 */
+	GROUP(mclk_0,			1),
+	GROUP(tdm_b_sclk,		1),
+	GROUP(tdm_b_fs,			1),
+	GROUP(tdm_b_dout0,		1),
+	GROUP(tdm_b_dout1,		1),
+	GROUP(tdm_b_dout2,		1),
+	GROUP(tdm_b_dout3,		1),
+	GROUP(tdm_b_dout4,		1),
+	GROUP(tdm_b_dout5,		1),
+	GROUP(remote_input_a,		1),
+
+	/* bank A func2 */
+	GROUP(pwm_e_a,			2),
+	GROUP(tdm_b_slv_sclk,		2),
+	GROUP(tdm_b_slv_fs,		2),
+	GROUP(tdm_b_din0,		2),
+	GROUP(tdm_b_din1,		2),
+	GROUP(tdm_b_din2,		2),
+	GROUP(i2c1_sda_a,		2),
+	GROUP(i2c1_sck_a,		2),
+
+	/* bank A func3 */
+	GROUP(i2c2_sck_a4,		3),
+	GROUP(i2c2_sda_a5,		3),
+	GROUP(pdm_din2_a,		3),
+	GROUP(pdm_din1_a,		3),
+	GROUP(pdm_din0_a,		3),
+	GROUP(pdm_dclk,			3),
+	GROUP(pwm_c_a,			3),
+	GROUP(pwm_b_a,			3),
+
+	/* bank A func4 */
+	GROUP(pwm_a_a,			4),
+	GROUP(spi_a_mosi_a,		4),
+	GROUP(spi_a_miso_a,		4),
+	GROUP(spi_a_ss0_a,		4),
+	GROUP(spi_a_sclk_a,		4),
+	GROUP(i2c_slave_sck_a,		4),
+	GROUP(i2c_slave_sda_a,		4),
+
+	/* bank A func5 */
+	GROUP(mclk_vad,			5),
+	GROUP(tdm_vad_sclk_a1,		5),
+	GROUP(tdm_vad_fs_a2,		5),
+	GROUP(tdm_vad_sclk_a5,		5),
+	GROUP(tdm_vad_fs_a6,		5),
+	GROUP(i2c2_sck_a8,		5),
+	GROUP(i2c2_sda_a9,		5),
+
+	/* bank A func6 */
+	GROUP(tst_out0,			6),
+	GROUP(tst_out1,			6),
+	GROUP(tst_out2,			6),
+	GROUP(tst_out3,			6),
+	GROUP(tst_out4,			6),
+	GROUP(tst_out5,			6),
+	GROUP(tst_out6,			6),
+	GROUP(tst_out7,			6),
+	GROUP(tst_out8,			6),
+	GROUP(tst_out9,			6),
+	GROUP(tst_out10,		6),
+	GROUP(tst_out11,		6),
+
+	/* bank A func7 */
+	GROUP(mute_key,			7),
+	GROUP(mute_en,			7),
+	GROUP(gen_clk_a,		7),
+};
+
+static const char * const gpio_periphs_groups[] =3D {
+	"GPIOP_0", "GPIOP_1", "GPIOP_2", "GPIOP_3", "GPIOP_4",
+	"GPIOP_5", "GPIOP_6", "GPIOP_7", "GPIOP_8", "GPIOP_9",
+	"GPIOP_10", "GPIOP_11", "GPIOP_12",
+
+	"GPIOB_0", "GPIOB_1", "GPIOB_2", "GPIOB_3", "GPIOB_4",
+	"GPIOB_5", "GPIOB_6",
+
+	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
+	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
+	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
+	"GPIOX_15", "GPIOX_16",
+
+	"GPIOF_0", "GPIOF_1", "GPIOF_2", "GPIOF_3", "GPIOF_4",
+	"GPIOF_5", "GPIOF_6", "GPIOF_7", "GPIOF_8", "GPIOF_9",
+	"GPIOF_10", "GPIOF_11", "GPIOF_12",
+
+	"GPIOA_0", "GPIOA_1", "GPIOA_2", "GPIOA_3", "GPIOA_4",
+	"GPIOA_5", "GPIOA_6", "GPIOA_7", "GPIOA_8", "GPIOA_9",
+	"GPIOA_10", "GPIOA_11",
+};
+
+static const char * const psram_groups[] =3D {
+	"psram_clkn", "psram_clkp", "psram_ce_n", "psram_rst_n", "psram_adq0",
+	"psram_adq1", "psram_adq2", "psram_adq3", "psram_adq4", "psram_adq5",
+	"psram_adq6", "psram_adq7", "psram_dqs_dm",
+};
+
+static const char * const pwm_a_groups[] =3D {
+	"pwm_a_x6", "pwm_a_x7", "pwm_a_f10", "pwm_a_f6", "pwm_a_a",
+};
+
+static const char * const pwm_b_groups[] =3D {
+	"pwm_b_x", "pwm_b_f", "pwm_b_a",
+};
+
+static const char * const pwm_c_groups[] =3D {
+	"pwm_c_x", "pwm_c_f3", "pwm_c_f8", "pwm_c_a",
+};
+
+static const char * const pwm_d_groups[] =3D {
+	"pwm_d_x15", "pwm_d_x13", "pwm_d_x10", "pwm_d_f",
+};
+
+static const char * const pwm_e_groups[] =3D {
+	"pwm_e_p", "pwm_e_x16", "pwm_e_x14", "pwm_e_x2", "pwm_e_f",
+	"pwm_e_a",
+};
+
+static const char * const pwm_f_groups[] =3D {
+	"pwm_f_b", "pwm_f_x", "pwm_f_f4", "pwm_f_f12",
+};
+
+static const char * const pwm_a_hiz_groups[] =3D {
+	"pwm_a_hiz_f8", "pwm_a_hiz_f10", "pwm_a_hiz_f6",
+};
+
+static const char * const pwm_b_hiz_groups[] =3D {
+	"pwm_b_hiz",
+};
+
+static const char * const pwm_c_hiz_groups[] =3D {
+	"pwm_c_hiz",
+};
+
+static const char * const spif_groups[] =3D {
+	"spif_mo", "spif_mi", "spif_wp_n", "spif_hold_n", "spif_clk",
+	"spif_cs",
+};
+
+static const char * const sdcard_groups[] =3D {
+	"sdcard_d0_b", "sdcard_d1_b", "sdcard_d2_b", "sdcard_d3_b",
+	"sdcard_clk_b", "sdcard_cmd_b",
+
+	"sdcard_d0_x", "sdcard_d1_x", "sdcard_d2_x", "sdcard_d3_x",
+	"sdcard_clk_x", "sdcard_cmd_x",
+};
+
+static const char * const tdm_a_groups[] =3D {
+	"tdm_a_din0", "tdm_a_din1",  "tdm_a_fs", "tdm_a_sclk",
+	"tdm_a_slv_fs", "tdm_a_slv_sclk", "tdm_a_dout0", "tdm_a_dout1",
+};
+
+static const char * const uart_a_groups[] =3D {
+	"uart_a_tx", "uart_a_rx", "uart_a_cts", "uart_a_rts",
+};
+
+static const char * const uart_b_groups[] =3D {
+	"uart_b_tx_x", "uart_b_rx_x", "uart_b_tx_f", "uart_b_rx_f",
+};
+
+static const char * const uart_c_groups[] =3D {
+	"uart_c_tx_x0", "uart_c_rx_x1", "uart_c_cts", "uart_c_rts",
+	"uart_c_tx_x15", "uart_c_rx_x16",
+};
+
+static const char * const i2c0_groups[] =3D {
+	"i2c0_sck_f11", "i2c0_sda_f12", "i2c0_sck_f9", "i2c0_sda_f10",
+};
+
+static const char * const i2c1_groups[] =3D {
+	"i2c1_sda_x", "i2c1_sck_x", "i2c1_sda_a", "i2c1_sck_a",
+};
+
+static const char * const i2c2_groups[] =3D {
+	"i2c2_sck_x0", "i2c2_sda_x1", "i2c2_sck_x15", "i2c2_sda_x16",
+	"i2c2_sck_a4", "i2c2_sda_a5", "i2c2_sck_a8", "i2c2_sda_a9",
+};
+
+static const char * const i2c3_groups[] =3D {
+	"i2c3_sck_x", "i2c3_sda_x", "i2c3_sck_f", "i2c3_sda_f",
+};
+
+static const char * const spi_a_groups[] =3D {
+	"spi_a_mosi_x2", "spi_a_ss0_x3", "spi_a_sclk_x4", "spi_a_miso_x5",
+	"spi_a_mosi_x7", "spi_a_miso_x8", "spi_a_ss0_x9", "spi_a_sclk_x10",
+
+	"spi_a_mosi_a", "spi_a_miso_a", "spi_a_ss0_a", "spi_a_sclk_a",
+};
+
+static const char * const pdm_groups[] =3D {
+	"pdm_din0_x", "pdm_din1_x", "pdm_din2_x", "pdm_dclk_x", "pdm_din2_a",
+	"pdm_din1_a", "pdm_din0_a", "pdm_dclk",
+};
+
+static const char * const gen_clk_groups[] =3D {
+	"gen_clk_x", "gen_clk_f8", "gen_clk_f10", "gen_clk_a",
+};
+
+static const char * const remote_input_groups[] =3D {
+	"remote_input_f",
+	"remote_input_a",
+};
+
+static const char * const jtag_a_groups[] =3D {
+	"jtag_a_clk", "jtag_a_tms", "jtag_a_tdi", "jtag_a_tdo",
+};
+
+static const char * const clk_32k_in_groups[] =3D {
+	"clk_32k_in",
+};
+
+static const char * const remote_out_groups[] =3D {
+	"remote_out",
+};
+
+static const char * const spdif_in_groups[] =3D {
+	"spdif_in_f6", "spdif_in_f7",
+};
+
+static const char * const sw_groups[] =3D {
+	"swclk", "swdio",
+};
+
+static const char * const clk25_groups[] =3D {
+	"clk_25",
+};
+
+static const char * const cec_a_groups[] =3D {
+	"cec_a",
+};
+
+static const char * const cec_b_groups[] =3D {
+	"cec_b",
+};
+
+static const char * const clk12_24_groups[] =3D {
+	"clk12_24",
+};
+
+static const char * const mclk_0_groups[] =3D {
+	"mclk_0",
+};
+
+static const char * const tdm_b_groups[] =3D {
+	"tdm_b_din0", "tdm_b_din1", "tdm_b_din2",
+	"tdm_b_sclk", "tdm_b_fs", "tdm_b_dout0", "tdm_b_dout1",
+	"tdm_b_dout2", "tdm_b_dout3", "tdm_b_dout4", "tdm_b_dout5",
+	"tdm_b_slv_sclk", "tdm_b_slv_fs",
+};
+
+static const char * const mclk_vad_groups[] =3D {
+	"mclk_vad",
+};
+
+static const char * const tdm_vad_groups[] =3D {
+	"tdm_vad_sclk_a1", "tdm_vad_fs_a2", "tdm_vad_sclk_a5", "tdm_vad_fs_a6",
+};
+
+static const char * const tst_out_groups[] =3D {
+	"tst_out0", "tst_out1", "tst_out2", "tst_out3",
+	"tst_out4", "tst_out5", "tst_out6", "tst_out7",
+	"tst_out8", "tst_out9", "tst_out10", "tst_out11",
+};
+
+static const char * const mute_groups[] =3D {
+	"mute_key", "mute_en",
+};
+
+static struct meson_pmx_func meson_a1_periphs_functions[] =3D {
+	FUNCTION(gpio_periphs),
+	FUNCTION(psram),
+	FUNCTION(pwm_a),
+	FUNCTION(pwm_b),
+	FUNCTION(pwm_c),
+	FUNCTION(pwm_d),
+	FUNCTION(pwm_e),
+	FUNCTION(pwm_f),
+	FUNCTION(pwm_a_hiz),
+	FUNCTION(pwm_b_hiz),
+	FUNCTION(pwm_c_hiz),
+	FUNCTION(spif),
+	FUNCTION(sdcard),
+	FUNCTION(tdm_a),
+	FUNCTION(uart_a),
+	FUNCTION(uart_b),
+	FUNCTION(uart_c),
+	FUNCTION(i2c0),
+	FUNCTION(i2c1),
+	FUNCTION(i2c2),
+	FUNCTION(i2c3),
+	FUNCTION(spi_a),
+	FUNCTION(pdm),
+	FUNCTION(gen_clk),
+	FUNCTION(remote_input),
+	FUNCTION(jtag_a),
+	FUNCTION(clk_32k_in),
+	FUNCTION(remote_out),
+	FUNCTION(spdif_in),
+	FUNCTION(sw),
+	FUNCTION(clk25),
+	FUNCTION(cec_a),
+	FUNCTION(cec_b),
+	FUNCTION(clk12_24),
+	FUNCTION(mclk_0),
+	FUNCTION(tdm_b),
+	FUNCTION(mclk_vad),
+	FUNCTION(tdm_vad),
+	FUNCTION(tst_out),
+	FUNCTION(mute),
+};
+
+static struct meson_bank meson_a1_periphs_banks[] =3D {
+	/* name      first    last       pullen    pull      dir       out       =
in        ds */
+	BANK_DS("P", GPIOP_0, GPIOP_12,  0x3,  0,  0x4,  0,  0x2,  0,  0x1,  0,  =
0x0,  0,  0x5,  0),
+	BANK_DS("B", GPIOB_0, GPIOB_6,   0x13, 0,  0x14, 0,  0x12, 0,  0x11, 0,  =
0x10, 0,  0x15, 0),
+	BANK_DS("X", GPIOX_0, GPIOX_16,  0x23, 0,  0x24, 0,  0x22, 0,  0x21, 0,  =
0x20, 0,  0x25, 0),
+	BANK_DS("F", GPIOF_0, GPIOF_12,  0x33, 0,  0x34, 0,  0x32, 0,  0x31, 0,  =
0x30, 0,  0x35, 0),
+	BANK_DS("A", GPIOA_0, GPIOA_11,  0x43, 0,  0x44, 0,  0x42, 0,  0x41, 0,  =
0x40, 0,  0x45, 0),
+};
+
+static struct meson_pmx_bank meson_a1_periphs_pmx_banks[] =3D {
+	/*  name	 first	  last      reg	 offset  */
+	BANK_PMX("P",    GPIOP_0, GPIOP_12, 0x0, 0),
+	BANK_PMX("B",    GPIOB_0, GPIOB_6,  0x2, 0),
+	BANK_PMX("X",    GPIOX_0, GPIOX_16, 0x3, 0),
+	BANK_PMX("F",    GPIOF_0, GPIOF_12, 0x6, 0),
+	BANK_PMX("A",    GPIOA_0, GPIOA_11, 0x8, 0),
+};
+
+static struct meson_axg_pmx_data meson_a1_periphs_pmx_banks_data =3D {
+	.pmx_banks	=3D meson_a1_periphs_pmx_banks,
+	.num_pmx_banks	=3D ARRAY_SIZE(meson_a1_periphs_pmx_banks),
+};
+
+static struct meson_pinctrl_data meson_a1_periphs_pinctrl_data =3D {
+	.name		=3D "periphs-banks",
+	.groups		=3D meson_a1_periphs_groups,
+	.funcs		=3D meson_a1_periphs_functions,
+	.banks		=3D meson_a1_periphs_banks,
+	.num_pins	=3D 62,
+	.num_groups	=3D ARRAY_SIZE(meson_a1_periphs_groups),
+	.num_funcs	=3D ARRAY_SIZE(meson_a1_periphs_functions),
+	.num_banks	=3D ARRAY_SIZE(meson_a1_periphs_banks),
+	.pmx_data	=3D &meson_a1_periphs_pmx_banks_data,
+};
+
+static const struct udevice_id meson_a1_pinctrl_match[] =3D {
+	{
+		.compatible =3D "amlogic,meson-a1-periphs-pinctrl",
+		.data =3D (ulong)&meson_a1_periphs_pinctrl_data,
+	},
+	{ },
+};
+
+U_BOOT_DRIVER(meson_a1_pinctrl) =3D {
+	.name	=3D "meson-a1-pinctrl",
+	.id	=3D UCLASS_PINCTRL,
+	.of_match =3D of_match_ptr(meson_a1_pinctrl_match),
+	.probe =3D meson_pinctrl_probe,
+	.priv_auto =3D sizeof(struct meson_pinctrl),
+	.ops =3D &meson_axg_pinctrl_ops,
+};
--=20
2.34.1

