Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web12.8250.1601630174400925212
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Oct 2020 02:16:14 -0700
Received: by mail-wm1-f68.google.com with SMTP id 13so897411wmf.0
        for <u-boot-amlogic@groups.io>; Fri, 02 Oct 2020 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPukpQEyerAsg6BHTZN+A1OhgaK6lDM+fEXtirWc0XY=;
        b=kQ8P9I9N8yDSBXJmuncekyq8P+sGacbS4kACNjPRX16JDkk0X5RpBMkoMYzEQ2vIKF
         XaXwc8sUKXMCIoj/xjcHYm3swjpX8uhHoMEf8NmW/2gjxxf/131oi9j5gju+0l8fntsP
         qrGQE2L6W745w3gX453dr7BEI/iuelDp4rvJW+cxx4XaTLDQUKZ68fn0ZpGBI2zEhGtq
         a49zc0SkJK023BbcgolbBrbTYHwvufIGhZdxNk/sgtzqIkE6KTERvcrZqKJQrNfHYjAw
         rUmvjuDtwnCEN70cJm14KItvpkY8uhkyluEngJ1Ek07/zvG076FrYX3x8Ke87qg7uoJd
         iRIw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] video: dw-mipi-dsi: driver-specific configuration of phy timings
Date: Fri,  2 Oct 2020 11:16:08 +0200
Message-Id: <20201002091609.1023621-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yannick.fertre@st.com, patrick.delaunay@st.com, agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The timing values for dw-dsi are often dependent on the used display and
according to Philippe Cornu will most likely also depend on the used phy
technology in the soc-specific implementation.

To solve this and allow specific implementations to define them as needed
add a new get_timing callback to phy_ops and call this from the dphy_timing
function to retrieve the necessary values for the specific mode.

This is based on the Linux commit [1] and adapted to the U-Boot driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[1] 25ed8aeb9c39 ("drm/bridge/synopsys: dsi: driver-specific configuration of phy timings")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/dw_mipi_dsi.c | 17 +++++++++++------
 include/mipi_dsi.h          | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index b7bfbb5e50..8f909a4e9f 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -643,8 +643,13 @@ static void dw_mipi_dsi_vertical_timing_config(struct dw_mipi_dsi *dsi,
 
 static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
 {
+	const struct mipi_dsi_phy_ops *phy_ops = dsi->phy_ops;
+	struct mipi_dsi_phy_timing timing = {0x40, 0x40, 0x40, 0x40};
 	u32 hw_version;
 
+	if (phy_ops->get_timing)
+		phy_ops->get_timing(dsi->device, dsi->lane_mbps, &timing);
+
 	/*
 	 * TODO dw drv improvements
 	 * data & clock lane timers should be computed according to panel
@@ -656,16 +661,16 @@ static void dw_mipi_dsi_dphy_timing_config(struct dw_mipi_dsi *dsi)
 	hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
 
 	if (hw_version >= HWVER_131) {
-		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(0x40) |
-			  PHY_LP2HS_TIME_V131(0x40));
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME_V131(timing.data_hs2lp) |
+			  PHY_LP2HS_TIME_V131(timing.data_lp2hs));
 		dsi_write(dsi, DSI_PHY_TMR_RD_CFG, MAX_RD_TIME_V131(10000));
 	} else {
-		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(0x40) |
-			  PHY_LP2HS_TIME(0x40) | MAX_RD_TIME(10000));
+		dsi_write(dsi, DSI_PHY_TMR_CFG, PHY_HS2LP_TIME(timing.data_hs2lp) |
+			  PHY_LP2HS_TIME(timing.data_lp2hs) | MAX_RD_TIME(10000));
 	}
 
-	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(0x40)
-		  | PHY_CLKLP2HS_TIME(0x40));
+	dsi_write(dsi, DSI_PHY_TMR_LPCLK_CFG, PHY_CLKHS2LP_TIME(timing.clk_hs2lp)
+		  | PHY_CLKLP2HS_TIME(timing.clk_lp2hs));
 }
 
 static void dw_mipi_dsi_dphy_interface_config(struct dw_mipi_dsi *dsi)
diff --git a/include/mipi_dsi.h b/include/mipi_dsi.h
index c8a7d3daef..55c7ab3328 100644
--- a/include/mipi_dsi.h
+++ b/include/mipi_dsi.h
@@ -96,6 +96,20 @@ struct mipi_dsi_host_ops {
 			    const struct mipi_dsi_msg *msg);
 };
 
+/**
+ * struct mipi_dsi_phy_timing - DSI host phy timings
+ * @data_hs2lp: High Speed to Low Speed Data Transition Time
+ * @data_lp2hs: Low Speed to High Speed Data Transition Time
+ * @clk_hs2lp: High Speed to Low Speed Clock Transition Time
+ * @clk_lp2hs: Low Speed to High Speed Clock Transition Time
+ */
+struct mipi_dsi_phy_timing {
+	u16 data_hs2lp;
+	u16 data_lp2hs;
+	u16 clk_hs2lp;
+	u16 clk_lp2hs;
+};
+
 /**
  * struct mipi_dsi_phy_ops - DSI host physical operations
  * @init: initialized host physical part
@@ -107,6 +121,8 @@ struct mipi_dsi_phy_ops {
 	int (*get_lane_mbps)(void *priv_data, struct display_timing *timings,
 			     u32 lanes, u32 format, unsigned int *lane_mbps);
 	void (*post_set_mode)(void *priv_data,  unsigned long mode_flags);
+	int (*get_timing)(void *priv_data, unsigned int lane_mbps,
+			  struct mipi_dsi_phy_timing *timing);
 };
 
 /**
-- 
2.25.1

