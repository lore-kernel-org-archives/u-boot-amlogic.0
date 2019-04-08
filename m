Received: by mail-wr1-f66.google.com with SMTP id p10so15186510wrq.1
        for <u-boot-amlogic@groups.io>; Mon, 08 Apr 2019 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=PqOMRL5EN2HnD8MrLOFOgh8YtuC/esyqy5cwsR/riwM=;
        b=aYqzX8NgcC6c50JMfMNVxUzkneu6jtgi34ZD5DsXNsn6bTRgStYen6hbjA3+GIXGJy
         1+dJAjG0SkK1yIKCW7/wKTEAnvFM/D7uS9h8Pd63NrD19SFMluApIvp1UxTWR0iNiL8e
         0Bvok8ZBmecm//zDSXK2gZ4Y2bP4/WI+5KSkcAWFIcXxVbtrr+/SNYNw4RA73G57nd3P
         0XaBpJHiJDM88YCRBJdLynQ6DWOCazIX1hLiVp3z+9K812EVCE7q/E2Aa2w86RvAedzv
         qHXOyjciSD40yYtWu6lehng/lKUAznG0Z2lhP6uzvG0L8FsRDmfa8RTh4Y9BYDT6DWKf
         FfEQ==
Return-Path: <glaroque@baylibre.com>
From: "Guillaume La Roque" <glaroque@baylibre.com>
Subject: [PATCH] pinctrl: meson: axg: Fix PIN and BANK offsets
Date: Mon,  8 Apr 2019 10:09:49 +0200
Message-Id: <20190408080949.3135-1-glaroque@baylibre.com>
To: narmstrong@baylibre.com, u-boot-amlogic@groups.io, u-boot@lists.denx.de
List-ID: <u-boot-amlogic@groups.io>

Periphs bank offset must be applied on all pins and
PMX bank to prevent issue in meson_pinconf_set call.
Without offset on pins when a call to pinconf is done
meson_gpio_calc_reg_and_bit return wrong offset.
To avoid breaking pmx function offset is needed in pmx bank structure too.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg.c | 358 +++++++++++-----------
 1 file changed, 179 insertions(+), 179 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 3bbbe817b4..8f23c8cef1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -17,239 +17,239 @@
 #define EE_OFF	15
 
 /* emmc */
-static const unsigned int emmc_nand_d0_pins[] = {BOOT_0};
-static const unsigned int emmc_nand_d1_pins[] = {BOOT_1};
-static const unsigned int emmc_nand_d2_pins[] = {BOOT_2};
-static const unsigned int emmc_nand_d3_pins[] = {BOOT_3};
-static const unsigned int emmc_nand_d4_pins[] = {BOOT_4};
-static const unsigned int emmc_nand_d5_pins[] = {BOOT_5};
-static const unsigned int emmc_nand_d6_pins[] = {BOOT_6};
-static const unsigned int emmc_nand_d7_pins[] = {BOOT_7};
-
-static const unsigned int emmc_clk_pins[] = {BOOT_8};
-static const unsigned int emmc_cmd_pins[] = {BOOT_10};
-static const unsigned int emmc_ds_pins[]  = {BOOT_13};
+static const unsigned int emmc_nand_d0_pins[] = { PIN(BOOT_0, EE_OFF) };
+static const unsigned int emmc_nand_d1_pins[] = { PIN(BOOT_1, EE_OFF) };
+static const unsigned int emmc_nand_d2_pins[] = { PIN(BOOT_2, EE_OFF) };
+static const unsigned int emmc_nand_d3_pins[] = { PIN(BOOT_3, EE_OFF) };
+static const unsigned int emmc_nand_d4_pins[] = { PIN(BOOT_4, EE_OFF) };
+static const unsigned int emmc_nand_d5_pins[] = { PIN(BOOT_5, EE_OFF) };
+static const unsigned int emmc_nand_d6_pins[] = { PIN(BOOT_6, EE_OFF) };
+static const unsigned int emmc_nand_d7_pins[] = { PIN(BOOT_7, EE_OFF) };
+
+static const unsigned int emmc_clk_pins[] = { PIN(BOOT_8, EE_OFF) };
+static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
+static const unsigned int emmc_ds_pins[]  = { PIN(BOOT_13, EE_OFF) };
 
 /* nand */
-static const unsigned int nand_ce0_pins[] = {BOOT_8};
-static const unsigned int nand_ale_pins[] = {BOOT_9};
-static const unsigned int nand_cle_pins[] = {BOOT_10};
-static const unsigned int nand_wen_clk_pins[] = {BOOT_11};
-static const unsigned int nand_ren_wr_pins[] = {BOOT_12};
-static const unsigned int nand_rb0_pins[] = {BOOT_13};
+static const unsigned int nand_ce0_pins[] = { PIN(BOOT_8, EE_OFF) };
+static const unsigned int nand_ale_pins[] = { PIN(BOOT_9, EE_OFF) };
+static const unsigned int nand_cle_pins[] = { PIN(BOOT_10, EE_OFF) };
+static const unsigned int nand_wen_clk_pins[] = { PIN(BOOT_11, EE_OFF) };
+static const unsigned int nand_ren_wr_pins[] = { PIN(BOOT_12, EE_OFF) };
+static const unsigned int nand_rb0_pins[] = { PIN(BOOT_13, EE_OFF) };
 
 /* nor */
-static const unsigned int nor_hold_pins[] = {BOOT_3};
-static const unsigned int nor_d_pins[] = {BOOT_4};
-static const unsigned int nor_q_pins[] = {BOOT_5};
-static const unsigned int nor_c_pins[] = {BOOT_6};
-static const unsigned int nor_wp_pins[] = {BOOT_9};
-static const unsigned int nor_cs_pins[] = {BOOT_14};
+static const unsigned int nor_hold_pins[] = { PIN(BOOT_3, EE_OFF) };
+static const unsigned int nor_d_pins[] = { PIN(BOOT_4, EE_OFF) };
+static const unsigned int nor_q_pins[] = { PIN(BOOT_5, EE_OFF) };
+static const unsigned int nor_c_pins[] = { PIN(BOOT_6, EE_OFF) };
+static const unsigned int nor_wp_pins[] = { PIN(BOOT_9, EE_OFF) };
+static const unsigned int nor_cs_pins[] = { PIN(BOOT_14, EE_OFF) };
 
 /* sdio */
-static const unsigned int sdio_d0_pins[] = {GPIOX_0};
-static const unsigned int sdio_d1_pins[] = {GPIOX_1};
-static const unsigned int sdio_d2_pins[] = {GPIOX_2};
-static const unsigned int sdio_d3_pins[] = {GPIOX_3};
-static const unsigned int sdio_clk_pins[] = {GPIOX_4};
-static const unsigned int sdio_cmd_pins[] = {GPIOX_5};
+static const unsigned int sdio_d0_pins[] = { PIN(GPIOX_0, EE_OFF) };
+static const unsigned int sdio_d1_pins[] = { PIN(GPIOX_1, EE_OFF) };
+static const unsigned int sdio_d2_pins[] = { PIN(GPIOX_2, EE_OFF) };
+static const unsigned int sdio_d3_pins[] = { PIN(GPIOX_3, EE_OFF) };
+static const unsigned int sdio_clk_pins[] = { PIN(GPIOX_4, EE_OFF) };
+static const unsigned int sdio_cmd_pins[] = { PIN(GPIOX_5, EE_OFF) };
 
 /* spi0 */
-static const unsigned int spi0_clk_pins[] = {GPIOZ_0};
-static const unsigned int spi0_mosi_pins[] = {GPIOZ_1};
-static const unsigned int spi0_miso_pins[] = {GPIOZ_2};
-static const unsigned int spi0_ss0_pins[] = {GPIOZ_3};
-static const unsigned int spi0_ss1_pins[] = {GPIOZ_4};
-static const unsigned int spi0_ss2_pins[] = {GPIOZ_5};
+static const unsigned int spi0_clk_pins[] = { PIN(GPIOZ_0, EE_OFF) };
+static const unsigned int spi0_mosi_pins[] = { PIN(GPIOZ_1, EE_OFF) };
+static const unsigned int spi0_miso_pins[] = { PIN(GPIOZ_2, EE_OFF) };
+static const unsigned int spi0_ss0_pins[] = { PIN(GPIOZ_3, EE_OFF) };
+static const unsigned int spi0_ss1_pins[] = { PIN(GPIOZ_4, EE_OFF) };
+static const unsigned int spi0_ss2_pins[] = { PIN(GPIOZ_5, EE_OFF) };
 
 /* spi1 */
-static const unsigned int spi1_clk_x_pins[] = {GPIOX_19};
-static const unsigned int spi1_mosi_x_pins[] = {GPIOX_17};
-static const unsigned int spi1_miso_x_pins[] = {GPIOX_18};
-static const unsigned int spi1_ss0_x_pins[] = {GPIOX_16};
+static const unsigned int spi1_clk_x_pins[] = { PIN(GPIOX_19, EE_OFF) };
+static const unsigned int spi1_mosi_x_pins[] = { PIN(GPIOX_17, EE_OFF) };
+static const unsigned int spi1_miso_x_pins[] = { PIN(GPIOX_18, EE_OFF) };
+static const unsigned int spi1_ss0_x_pins[] = { PIN(GPIOX_16, EE_OFF) };
 
-static const unsigned int spi1_clk_a_pins[] = {GPIOA_4};
-static const unsigned int spi1_mosi_a_pins[] = {GPIOA_2};
-static const unsigned int spi1_miso_a_pins[] = {GPIOA_3};
-static const unsigned int spi1_ss0_a_pins[] = {GPIOA_5};
-static const unsigned int spi1_ss1_pins[] = {GPIOA_6};
+static const unsigned int spi1_clk_a_pins[] = { PIN(GPIOA_4, EE_OFF) };
+static const unsigned int spi1_mosi_a_pins[] = { PIN(GPIOA_2, EE_OFF) };
+static const unsigned int spi1_miso_a_pins[] = { PIN(GPIOA_3, EE_OFF) };
+static const unsigned int spi1_ss0_a_pins[] = { PIN(GPIOA_5, EE_OFF) };
+static const unsigned int spi1_ss1_pins[] = { PIN(GPIOA_6, EE_OFF) };
 
 /* i2c0 */
-static const unsigned int i2c0_sck_pins[] = {GPIOZ_6};
-static const unsigned int i2c0_sda_pins[] = {GPIOZ_7};
+static const unsigned int i2c0_sck_pins[] = { PIN(GPIOZ_6, EE_OFF) };
+static const unsigned int i2c0_sda_pins[] = { PIN(GPIOZ_7, EE_OFF) };
 
 /* i2c1 */
-static const unsigned int i2c1_sck_z_pins[] = {GPIOZ_8};
-static const unsigned int i2c1_sda_z_pins[] = {GPIOZ_9};
+static const unsigned int i2c1_sck_z_pins[] = { PIN(GPIOZ_8, EE_OFF) };
+static const unsigned int i2c1_sda_z_pins[] = { PIN(GPIOZ_9, EE_OFF) };
 
-static const unsigned int i2c1_sck_x_pins[] = {GPIOX_16};
-static const unsigned int i2c1_sda_x_pins[] = {GPIOX_17};
+static const unsigned int i2c1_sck_x_pins[] = { PIN(GPIOX_16, EE_OFF) };
+static const unsigned int i2c1_sda_x_pins[] = { PIN(GPIOX_17, EE_OFF) };
 
 /* i2c2 */
-static const unsigned int i2c2_sck_x_pins[] = {GPIOX_18};
-static const unsigned int i2c2_sda_x_pins[] = {GPIOX_19};
+static const unsigned int i2c2_sck_x_pins[] = { PIN(GPIOX_18, EE_OFF) };
+static const unsigned int i2c2_sda_x_pins[] = { PIN(GPIOX_19, EE_OFF) };
 
-static const unsigned int i2c2_sda_a_pins[] = {GPIOA_17};
-static const unsigned int i2c2_sck_a_pins[] = {GPIOA_18};
+static const unsigned int i2c2_sda_a_pins[] = { PIN(GPIOA_17, EE_OFF) };
+static const unsigned int i2c2_sck_a_pins[] = { PIN(GPIOA_18, EE_OFF) };
 
 /* i2c3 */
-static const unsigned int i2c3_sda_a6_pins[] = {GPIOA_6};
-static const unsigned int i2c3_sck_a7_pins[] = {GPIOA_7};
+static const unsigned int i2c3_sda_a6_pins[] = { PIN(GPIOA_6, EE_OFF) };
+static const unsigned int i2c3_sck_a7_pins[] = { PIN(GPIOA_7, EE_OFF) };
 
-static const unsigned int i2c3_sda_a12_pins[] = {GPIOA_12};
-static const unsigned int i2c3_sck_a13_pins[] = {GPIOA_13};
+static const unsigned int i2c3_sda_a12_pins[] = { PIN(GPIOA_12, EE_OFF) };
+static const unsigned int i2c3_sck_a13_pins[] = { PIN(GPIOA_13, EE_OFF) };
 
-static const unsigned int i2c3_sda_a19_pins[] = {GPIOA_19};
-static const unsigned int i2c3_sck_a20_pins[] = {GPIOA_20};
+static const unsigned int i2c3_sda_a19_pins[] = { PIN(GPIOA_19, EE_OFF) };
+static const unsigned int i2c3_sck_a20_pins[] = { PIN(GPIOA_20, EE_OFF) };
 
 /* uart_a */
-static const unsigned int uart_rts_a_pins[] = {GPIOX_11};
-static const unsigned int uart_cts_a_pins[] = {GPIOX_10};
-static const unsigned int uart_tx_a_pins[] = {GPIOX_8};
-static const unsigned int uart_rx_a_pins[] = {GPIOX_9};
+static const unsigned int uart_rts_a_pins[] = { PIN(GPIOX_11, EE_OFF) };
+static const unsigned int uart_cts_a_pins[] = { PIN(GPIOX_10, EE_OFF) };
+static const unsigned int uart_tx_a_pins[] = { PIN(GPIOX_8, EE_OFF) };
+static const unsigned int uart_rx_a_pins[] = { PIN(GPIOX_9, EE_OFF) };
 
 /* uart_b */
-static const unsigned int uart_rts_b_z_pins[] = {GPIOZ_0};
-static const unsigned int uart_cts_b_z_pins[] = {GPIOZ_1};
-static const unsigned int uart_tx_b_z_pins[] = {GPIOZ_2};
-static const unsigned int uart_rx_b_z_pins[] = {GPIOZ_3};
+static const unsigned int uart_rts_b_z_pins[] = { PIN(GPIOZ_0, EE_OFF) };
+static const unsigned int uart_cts_b_z_pins[] = { PIN(GPIOZ_1, EE_OFF) };
+static const unsigned int uart_tx_b_z_pins[] = { PIN(GPIOZ_2, EE_OFF) };
+static const unsigned int uart_rx_b_z_pins[] = { PIN(GPIOZ_3, EE_OFF) };
 
-static const unsigned int uart_rts_b_x_pins[] = {GPIOX_18};
-static const unsigned int uart_cts_b_x_pins[] = {GPIOX_19};
-static const unsigned int uart_tx_b_x_pins[] = {GPIOX_16};
-static const unsigned int uart_rx_b_x_pins[] = {GPIOX_17};
+static const unsigned int uart_rts_b_x_pins[] = { PIN(GPIOX_18, EE_OFF) };
+static const unsigned int uart_cts_b_x_pins[] = { PIN(GPIOX_19, EE_OFF) };
+static const unsigned int uart_tx_b_x_pins[] = { PIN(GPIOX_16, EE_OFF) };
+static const unsigned int uart_rx_b_x_pins[] = { PIN(GPIOX_17, EE_OFF) };
 
 /* uart_ao_b */
-static const unsigned int uart_ao_tx_b_z_pins[] = {GPIOZ_8};
-static const unsigned int uart_ao_rx_b_z_pins[] = {GPIOZ_9};
-static const unsigned int uart_ao_cts_b_z_pins[] = {GPIOZ_6};
-static const unsigned int uart_ao_rts_b_z_pins[] = {GPIOZ_7};
+static const unsigned int uart_ao_tx_b_z_pins[] = { PIN(GPIOZ_8, EE_OFF) };
+static const unsigned int uart_ao_rx_b_z_pins[] = { PIN(GPIOZ_9, EE_OFF) };
+static const unsigned int uart_ao_cts_b_z_pins[] = { PIN(GPIOZ_6, EE_OFF) };
+static const unsigned int uart_ao_rts_b_z_pins[] = { PIN(GPIOZ_7, EE_OFF) };
 
 /* pwm_a */
-static const unsigned int pwm_a_z_pins[] = {GPIOZ_5};
+static const unsigned int pwm_a_z_pins[] = { PIN(GPIOZ_5, EE_OFF) };
 
-static const unsigned int pwm_a_x18_pins[] = {GPIOX_18};
-static const unsigned int pwm_a_x20_pins[] = {GPIOX_20};
+static const unsigned int pwm_a_x18_pins[] = { PIN(GPIOX_18, EE_OFF) };
+static const unsigned int pwm_a_x20_pins[] = { PIN(GPIOX_20, EE_OFF) };
 
-static const unsigned int pwm_a_a_pins[] = {GPIOA_14};
+static const unsigned int pwm_a_a_pins[] = { PIN(GPIOA_14, EE_OFF) };
 
 /* pwm_b */
-static const unsigned int pwm_b_z_pins[] = {GPIOZ_4};
+static const unsigned int pwm_b_z_pins[] = { PIN(GPIOZ_4, EE_OFF) };
 
-static const unsigned int pwm_b_x_pins[] = {GPIOX_19};
+static const unsigned int pwm_b_x_pins[] = { PIN(GPIOX_19, EE_OFF) };
 
-static const unsigned int pwm_b_a_pins[] = {GPIOA_15};
+static const unsigned int pwm_b_a_pins[] = { PIN(GPIOA_15, EE_OFF) };
 
 /* pwm_c */
-static const unsigned int pwm_c_x10_pins[] = {GPIOX_10};
-static const unsigned int pwm_c_x17_pins[] = {GPIOX_17};
+static const unsigned int pwm_c_x10_pins[] = { PIN(GPIOX_10, EE_OFF) };
+static const unsigned int pwm_c_x17_pins[] = { PIN(GPIOX_17, EE_OFF) };
 
-static const unsigned int pwm_c_a_pins[] = {GPIOA_16};
+static const unsigned int pwm_c_a_pins[] = { PIN(GPIOA_16, EE_OFF) };
 
 /* pwm_d */
-static const unsigned int pwm_d_x11_pins[] = {GPIOX_11};
-static const unsigned int pwm_d_x16_pins[] = {GPIOX_16};
+static const unsigned int pwm_d_x11_pins[] = { PIN(GPIOX_11, EE_OFF) };
+static const unsigned int pwm_d_x16_pins[] = { PIN(GPIOX_16, EE_OFF) };
 
 /* pwm_vs */
-static const unsigned int pwm_vs_pins[] = {GPIOA_0};
+static const unsigned int pwm_vs_pins[] = { PIN(GPIOA_0, EE_OFF) };
 
 /* spdif_in */
-static const unsigned int spdif_in_z_pins[] = {GPIOZ_4};
+static const unsigned int spdif_in_z_pins[] = { PIN(GPIOZ_4, EE_OFF) };
 
-static const unsigned int spdif_in_a1_pins[] = {GPIOA_1};
-static const unsigned int spdif_in_a7_pins[] = {GPIOA_7};
-static const unsigned int spdif_in_a19_pins[] = {GPIOA_19};
-static const unsigned int spdif_in_a20_pins[] = {GPIOA_20};
+static const unsigned int spdif_in_a1_pins[] = { PIN(GPIOA_1, EE_OFF) };
+static const unsigned int spdif_in_a7_pins[] = { PIN(GPIOA_7, EE_OFF) };
+static const unsigned int spdif_in_a19_pins[] = { PIN(GPIOA_19, EE_OFF) };
+static const unsigned int spdif_in_a20_pins[] = { PIN(GPIOA_20, EE_OFF) };
 
 /* spdif_out */
-static const unsigned int spdif_out_z_pins[] = {GPIOZ_5};
+static const unsigned int spdif_out_z_pins[] = { PIN(GPIOZ_5, EE_OFF) };
 
-static const unsigned int spdif_out_a1_pins[] = {GPIOA_1};
-static const unsigned int spdif_out_a11_pins[] = {GPIOA_11};
-static const unsigned int spdif_out_a19_pins[] = {GPIOA_19};
-static const unsigned int spdif_out_a20_pins[] = {GPIOA_20};
+static const unsigned int spdif_out_a1_pins[] = { PIN(GPIOA_1, EE_OFF) };
+static const unsigned int spdif_out_a11_pins[] = { PIN(GPIOA_11, EE_OFF) };
+static const unsigned int spdif_out_a19_pins[] = { PIN(GPIOA_19, EE_OFF) };
+static const unsigned int spdif_out_a20_pins[] = { PIN(GPIOA_20, EE_OFF) };
 
 /* jtag_ee */
-static const unsigned int jtag_tdo_x_pins[] = {GPIOX_0};
-static const unsigned int jtag_tdi_x_pins[] = {GPIOX_1};
-static const unsigned int jtag_clk_x_pins[] = {GPIOX_4};
-static const unsigned int jtag_tms_x_pins[] = {GPIOX_5};
+static const unsigned int jtag_tdo_x_pins[] = { PIN(GPIOX_0, EE_OFF) };
+static const unsigned int jtag_tdi_x_pins[] = { PIN(GPIOX_1, EE_OFF) };
+static const unsigned int jtag_clk_x_pins[] = { PIN(GPIOX_4, EE_OFF) };
+static const unsigned int jtag_tms_x_pins[] = { PIN(GPIOX_5, EE_OFF) };
 
 /* eth */
-static const unsigned int eth_txd0_x_pins[] = {GPIOX_8};
-static const unsigned int eth_txd1_x_pins[] = {GPIOX_9};
-static const unsigned int eth_txen_x_pins[] = {GPIOX_10};
-static const unsigned int eth_rgmii_rx_clk_x_pins[] = {GPIOX_12};
-static const unsigned int eth_rxd0_x_pins[] = {GPIOX_13};
-static const unsigned int eth_rxd1_x_pins[] = {GPIOX_14};
-static const unsigned int eth_rx_dv_x_pins[] = {GPIOX_15};
-static const unsigned int eth_mdio_x_pins[] = {GPIOX_21};
-static const unsigned int eth_mdc_x_pins[] = {GPIOX_22};
-
-static const unsigned int eth_txd0_y_pins[] = {GPIOY_10};
-static const unsigned int eth_txd1_y_pins[] = {GPIOY_11};
-static const unsigned int eth_txen_y_pins[] = {GPIOY_9};
-static const unsigned int eth_rgmii_rx_clk_y_pins[] = {GPIOY_2};
-static const unsigned int eth_rxd0_y_pins[] = {GPIOY_4};
-static const unsigned int eth_rxd1_y_pins[] = {GPIOY_5};
-static const unsigned int eth_rx_dv_y_pins[] = {GPIOY_3};
-static const unsigned int eth_mdio_y_pins[] = {GPIOY_0};
-static const unsigned int eth_mdc_y_pins[] = {GPIOY_1};
-
-static const unsigned int eth_rxd2_rgmii_pins[] = {GPIOY_6};
-static const unsigned int eth_rxd3_rgmii_pins[] = {GPIOY_7};
-static const unsigned int eth_rgmii_tx_clk_pins[] = {GPIOY_8};
-static const unsigned int eth_txd2_rgmii_pins[] = {GPIOY_12};
-static const unsigned int eth_txd3_rgmii_pins[] = {GPIOY_13};
+static const unsigned int eth_txd0_x_pins[] = { PIN(GPIOX_8, EE_OFF) };
+static const unsigned int eth_txd1_x_pins[] = { PIN(GPIOX_9, EE_OFF) };
+static const unsigned int eth_txen_x_pins[] = { PIN(GPIOX_10, EE_OFF) };
+static const unsigned int eth_rgmii_rx_clk_x_pins[] = { PIN(GPIOX_12, EE_OFF) };
+static const unsigned int eth_rxd0_x_pins[] = { PIN(GPIOX_13, EE_OFF) };
+static const unsigned int eth_rxd1_x_pins[] = { PIN(GPIOX_14, EE_OFF) };
+static const unsigned int eth_rx_dv_x_pins[] = { PIN(GPIOX_15, EE_OFF) };
+static const unsigned int eth_mdio_x_pins[] = { PIN(GPIOX_21, EE_OFF) };
+static const unsigned int eth_mdc_x_pins[] = { PIN(GPIOX_22, EE_OFF) };
+
+static const unsigned int eth_txd0_y_pins[] = { PIN(GPIOY_10, EE_OFF) };
+static const unsigned int eth_txd1_y_pins[] = { PIN(GPIOY_11, EE_OFF) };
+static const unsigned int eth_txen_y_pins[] = { PIN(GPIOY_9, EE_OFF) };
+static const unsigned int eth_rgmii_rx_clk_y_pins[] = { PIN(GPIOY_2, EE_OFF) };
+static const unsigned int eth_rxd0_y_pins[] = { PIN(GPIOY_4, EE_OFF) };
+static const unsigned int eth_rxd1_y_pins[] = { PIN(GPIOY_5, EE_OFF) };
+static const unsigned int eth_rx_dv_y_pins[] = { PIN(GPIOY_3, EE_OFF) };
+static const unsigned int eth_mdio_y_pins[] = { PIN(GPIOY_0, EE_OFF) };
+static const unsigned int eth_mdc_y_pins[] = { PIN(GPIOY_1, EE_OFF) };
+
+static const unsigned int eth_rxd2_rgmii_pins[] = { PIN(GPIOY_6, EE_OFF) };
+static const unsigned int eth_rxd3_rgmii_pins[] = { PIN(GPIOY_7, EE_OFF) };
+static const unsigned int eth_rgmii_tx_clk_pins[] = { PIN(GPIOY_8, EE_OFF) };
+static const unsigned int eth_txd2_rgmii_pins[] = { PIN(GPIOY_12, EE_OFF) };
+static const unsigned int eth_txd3_rgmii_pins[] = { PIN(GPIOY_13, EE_OFF) };
 
 /* pdm */
-static const unsigned int pdm_dclk_a14_pins[] = {GPIOA_14};
-static const unsigned int pdm_dclk_a19_pins[] = {GPIOA_19};
-static const unsigned int pdm_din0_pins[] = {GPIOA_15};
-static const unsigned int pdm_din1_pins[] = {GPIOA_16};
-static const unsigned int pdm_din2_pins[] = {GPIOA_17};
-static const unsigned int pdm_din3_pins[] = {GPIOA_18};
+static const unsigned int pdm_dclk_a14_pins[] = { PIN(GPIOA_14, EE_OFF) };
+static const unsigned int pdm_dclk_a19_pins[] = { PIN(GPIOA_19, EE_OFF) };
+static const unsigned int pdm_din0_pins[] = { PIN(GPIOA_15, EE_OFF) };
+static const unsigned int pdm_din1_pins[] = { PIN(GPIOA_16, EE_OFF) };
+static const unsigned int pdm_din2_pins[] = { PIN(GPIOA_17, EE_OFF) };
+static const unsigned int pdm_din3_pins[] = { PIN(GPIOA_18, EE_OFF) };
 
 /* mclk */
-static const unsigned int mclk_c_pins[] = {GPIOA_0};
-static const unsigned int mclk_b_pins[] = {GPIOA_1};
+static const unsigned int mclk_c_pins[] = { PIN(GPIOA_0, EE_OFF) };
+static const unsigned int mclk_b_pins[] = { PIN(GPIOA_1, EE_OFF) };
 
 /* tdm */
-static const unsigned int tdma_sclk_pins[] = {GPIOX_12};
-static const unsigned int tdma_sclk_slv_pins[] = {GPIOX_12};
-static const unsigned int tdma_fs_pins[] = {GPIOX_13};
-static const unsigned int tdma_fs_slv_pins[] = {GPIOX_13};
-static const unsigned int tdma_din0_pins[] = {GPIOX_14};
-static const unsigned int tdma_dout0_x14_pins[] = {GPIOX_14};
-static const unsigned int tdma_dout0_x15_pins[] = {GPIOX_15};
-static const unsigned int tdma_dout1_pins[] = {GPIOX_15};
-static const unsigned int tdma_din1_pins[] = {GPIOX_15};
-
-static const unsigned int tdmc_sclk_pins[] = {GPIOA_2};
-static const unsigned int tdmc_sclk_slv_pins[] = {GPIOA_2};
-static const unsigned int tdmc_fs_pins[] = {GPIOA_3};
-static const unsigned int tdmc_fs_slv_pins[] = {GPIOA_3};
-static const unsigned int tdmc_din0_pins[] = {GPIOA_4};
-static const unsigned int tdmc_dout0_pins[] = {GPIOA_4};
-static const unsigned int tdmc_din1_pins[] = {GPIOA_5};
-static const unsigned int tdmc_dout1_pins[] = {GPIOA_5};
-static const unsigned int tdmc_din2_pins[] = {GPIOA_6};
-static const unsigned int tdmc_dout2_pins[] = {GPIOA_6};
-static const unsigned int tdmc_din3_pins[] = {GPIOA_7};
-static const unsigned int tdmc_dout3_pins[] = {GPIOA_7};
-
-static const unsigned int tdmb_sclk_pins[] = {GPIOA_8};
-static const unsigned int tdmb_sclk_slv_pins[] = {GPIOA_8};
-static const unsigned int tdmb_fs_pins[] = {GPIOA_9};
-static const unsigned int tdmb_fs_slv_pins[] = {GPIOA_9};
-static const unsigned int tdmb_din0_pins[] = {GPIOA_10};
-static const unsigned int tdmb_dout0_pins[] = {GPIOA_10};
-static const unsigned int tdmb_din1_pins[] = {GPIOA_11};
-static const unsigned int tdmb_dout1_pins[] = {GPIOA_11};
-static const unsigned int tdmb_din2_pins[] = {GPIOA_12};
-static const unsigned int tdmb_dout2_pins[] = {GPIOA_12};
-static const unsigned int tdmb_din3_pins[] = {GPIOA_13};
-static const unsigned int tdmb_dout3_pins[] = {GPIOA_13};
+static const unsigned int tdma_sclk_pins[] = { PIN(GPIOX_12, EE_OFF) };
+static const unsigned int tdma_sclk_slv_pins[] = { PIN(GPIOX_12, EE_OFF) };
+static const unsigned int tdma_fs_pins[] = { PIN(GPIOX_13, EE_OFF) };
+static const unsigned int tdma_fs_slv_pins[] = { PIN(GPIOX_13, EE_OFF) };
+static const unsigned int tdma_din0_pins[] = { PIN(GPIOX_14, EE_OFF) };
+static const unsigned int tdma_dout0_x14_pins[] = { PIN(GPIOX_14, EE_OFF) };
+static const unsigned int tdma_dout0_x15_pins[] = { PIN(GPIOX_15, EE_OFF) };
+static const unsigned int tdma_dout1_pins[] = { PIN(GPIOX_15, EE_OFF) };
+static const unsigned int tdma_din1_pins[] = { PIN(GPIOX_15, EE_OFF) };
+
+static const unsigned int tdmc_sclk_pins[] = { PIN(GPIOA_2, EE_OFF) };
+static const unsigned int tdmc_sclk_slv_pins[] = { PIN(GPIOA_2, EE_OFF) };
+static const unsigned int tdmc_fs_pins[] = { PIN(GPIOA_3, EE_OFF) };
+static const unsigned int tdmc_fs_slv_pins[] = { PIN(GPIOA_3, EE_OFF) };
+static const unsigned int tdmc_din0_pins[] = { PIN(GPIOA_4, EE_OFF) };
+static const unsigned int tdmc_dout0_pins[] = { PIN(GPIOA_4, EE_OFF) };
+static const unsigned int tdmc_din1_pins[] = { PIN(GPIOA_5, EE_OFF) };
+static const unsigned int tdmc_dout1_pins[] = { PIN(GPIOA_5, EE_OFF) };
+static const unsigned int tdmc_din2_pins[] = { PIN(GPIOA_6, EE_OFF) };
+static const unsigned int tdmc_dout2_pins[] = { PIN(GPIOA_6, EE_OFF) };
+static const unsigned int tdmc_din3_pins[] = { PIN(GPIOA_7, EE_OFF) };
+static const unsigned int tdmc_dout3_pins[] = { PIN(GPIOA_7, EE_OFF) };
+
+static const unsigned int tdmb_sclk_pins[] = { PIN(GPIOA_8, EE_OFF) };
+static const unsigned int tdmb_sclk_slv_pins[] = { PIN(GPIOA_8, EE_OFF) };
+static const unsigned int tdmb_fs_pins[] = { PIN(GPIOA_9, EE_OFF) };
+static const unsigned int tdmb_fs_slv_pins[] = { PIN(GPIOA_9, EE_OFF) };
+static const unsigned int tdmb_din0_pins[] = { PIN(GPIOA_10, EE_OFF) };
+static const unsigned int tdmb_dout0_pins[] = { PIN(GPIOA_10, EE_OFF) };
+static const unsigned int tdmb_din1_pins[] = { PIN(GPIOA_11, EE_OFF) };
+static const unsigned int tdmb_dout1_pins[] = { PIN(GPIOA_11, EE_OFF) };
+static const unsigned int tdmb_din2_pins[] = { PIN(GPIOA_12, EE_OFF) };
+static const unsigned int tdmb_dout2_pins[] = { PIN(GPIOA_12, EE_OFF) };
+static const unsigned int tdmb_din3_pins[] = { PIN(GPIOA_13, EE_OFF) };
+static const unsigned int tdmb_dout3_pins[] = { PIN(GPIOA_13, EE_OFF) };
 
 static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
@@ -907,12 +907,12 @@ static struct meson_bank meson_axg_aobus_banks[] = {
 };
 
 static struct meson_pmx_bank meson_axg_periphs_pmx_banks[] = {
-	/*	 name	 first		lask	   reg	offset  */
-	BANK_PMX("Z",	 GPIOZ_0, GPIOZ_10, 0x2, 0),
-	BANK_PMX("BOOT", BOOT_0,  BOOT_14,  0x0, 0),
-	BANK_PMX("A",	 GPIOA_0, GPIOA_20, 0xb, 0),
-	BANK_PMX("X",	 GPIOX_0, GPIOX_22, 0x4, 0),
-	BANK_PMX("Y",	 GPIOY_0, GPIOY_15, 0x8, 0),
+	/*	 name	 first			last	   	      reg  offset  */
+	BANK_PMX("Z",	 PIN(GPIOZ_0, EE_OFF),	PIN(GPIOZ_10, EE_OFF), 0x2, 0),
+	BANK_PMX("BOOT", PIN(BOOT_0, EE_OFF),	PIN(BOOT_14, EE_OFF),  0x0, 0),
+	BANK_PMX("A",	 PIN(GPIOA_0, EE_OFF),	PIN(GPIOA_20, EE_OFF), 0xb, 0),
+	BANK_PMX("X",	 PIN(GPIOX_0, EE_OFF),	PIN(GPIOX_22, EE_OFF), 0x4, 0),
+	BANK_PMX("Y",	 PIN(GPIOY_0, EE_OFF),	PIN(GPIOY_15, EE_OFF), 0x8, 0),
 };
 
 static struct meson_axg_pmx_data meson_axg_periphs_pmx_banks_data = {
@@ -931,7 +931,7 @@ static struct meson_axg_pmx_data meson_axg_aobus_pmx_banks_data = {
 
 struct meson_pinctrl_data meson_axg_periphs_pinctrl_data = {
 	.name		= "periphs-banks",
-	.pin_base	= 15,
+	.pin_base	= EE_OFF,
 	.groups		= meson_axg_periphs_groups,
 	.funcs		= meson_axg_periphs_functions,
 	.banks		= meson_axg_periphs_banks,
-- 
2.17.1

