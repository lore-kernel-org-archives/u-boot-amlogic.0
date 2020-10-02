Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.10411.1601630175623178281
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Oct 2020 02:16:15 -0700
Received: by mail-wr1-f67.google.com with SMTP id m6so985420wrn.0
        for <u-boot-amlogic@groups.io>; Fri, 02 Oct 2020 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCa6tY0SJuY+7pxkTM1JSjuiia+vESV2fSnudmzR064=;
        b=wcMxvYZcgmKBIjEYTDU79HUN/SmI4P17bGcbbrMT8Q5e8pugN1p0rIA7rTANujbklx
         pLC1+di9EUBBZPDqSDSp0jM2iMT3/2s08oDKMzE2oQMldtvyQ72ZvXxtXI6jKCv4HoA1
         krzyBx0cF+2IsEa3AQVo0i1albGzlVeai8A+Yt/XqE5ZPWuXS/3pFfDAIINEgWeFSE20
         d35vEsMPjXudgpT+Xk/Nvu8rUJmr91ftTos3NI1llSyYg9eoH6tCUYe0nsSlCsSA8ZFM
         bMx/dfWnO/2aJHIcwy/IFTthZjqL9sVf/kolG4xdvpJLHP08sI2T4/sKByfDccXBLd+m
         +4Eg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 2/2] video: dw-mipi-dsi: permit configuring the escape clock rate
Date: Fri,  2 Oct 2020 11:16:09 +0200
Message-Id: <20201002091609.1023621-2-narmstrong@baylibre.com>
In-Reply-To: <20201002091609.1023621-1-narmstrong@baylibre.com>
References: <20201002091609.1023621-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yannick.fertre@st.com, patrick.delaunay@st.com, agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The Amlogic D-PHY in the Amlogic AXG SoC Family does support a frequency
higher than 10MHz for the TX Escape Clock, thus make the target rate
configurable.

This is based on the Linux commit [1] and adapted to the U-Boot driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[1] a328ca7e4af3 ("drm/bridge: dw-mipi-dsi: permit configuring the escape clock rate")

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/dw_mipi_dsi.c | 20 ++++++++++++++++----
 include/mipi_dsi.h          |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index 8f909a4e9f..12a55cfbec 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -483,15 +483,27 @@ static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
 
 static void dw_mipi_dsi_init_pll(struct dw_mipi_dsi *dsi)
 {
+	const struct mipi_dsi_phy_ops *phy_ops = dsi->phy_ops;
+	unsigned int esc_rate;
+	u32 esc_clk_division;
+
 	/*
 	 * The maximum permitted escape clock is 20MHz and it is derived from
-	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
+	 * lanebyteclk, which is running at "lane_mbps / 8".
+	 */
+	if (phy_ops->get_esc_clk_rate)
+		phy_ops->get_esc_clk_rate(dsi->device, &esc_rate);
+	else
+		esc_rate = 20; /* Default to 20MHz */
+
+	/*
+	 * We want:
 	 *
-	 *     (lane_mbps >> 3) / esc_clk_division < 20
+	 *     (lane_mbps >> 3) / esc_clk_division < X
 	 * which is:
-	 *     (lane_mbps >> 3) / 20 > esc_clk_division
+	 *     (lane_mbps >> 3) / X > esc_clk_division
 	 */
-	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+	esc_clk_division = (dsi->lane_mbps >> 3) / esc_rate + 1;
 
 	dsi_write(dsi, DSI_PWR_UP, RESET);
 
diff --git a/include/mipi_dsi.h b/include/mipi_dsi.h
index 55c7ab3328..4ca05f71e2 100644
--- a/include/mipi_dsi.h
+++ b/include/mipi_dsi.h
@@ -123,6 +123,7 @@ struct mipi_dsi_phy_ops {
 	void (*post_set_mode)(void *priv_data,  unsigned long mode_flags);
 	int (*get_timing)(void *priv_data, unsigned int lane_mbps,
 			  struct mipi_dsi_phy_timing *timing);
+	void (*get_esc_clk_rate)(void *priv_data, unsigned int *esc_clk_rate);
 };
 
 /**
-- 
2.25.1

