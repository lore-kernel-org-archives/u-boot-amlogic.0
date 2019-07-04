Received: by mail-wr1-f66.google.com with SMTP id u18so6761933wru.1
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyRCC4bUtDTkFoUgDa5zYvhIk1y06EaYmyazSTdlSTw=;
        b=R5v4uKGNiPPa809Sst8jAoTzFPM7sLWUnZlI/8inilO31i4r62SjH3afwB8vB5PY3p
         PA6n4RNkA3FGyVAT76cX3x5rL2xD0i4zqwC1k6bAVt3KLMhsnarEABHrAU70yuQjuhpa
         K3Oidgaaltf/QYW8EByo2/hSb2eDZrdcGHDiFPHBloJg+o6Za7ZsjHebAkcu9tvTAwtz
         EKy8oZ5WLmKRk6FNy2/GcSt6tSs25kMW0YJYM6gAgfDQU3mq3RNtEqNuFMNlcNthaPvM
         pgsLbGdQh1It/nygq7HcfD+qdW3peHiDQHbE9CKV3CCyXHHYPdmNNa4vINT51wi0uCr+
         arVg==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 3/3] video: meson: dw-hdmi: add EDID mode filtering to only select supported modes
Date: Thu,  4 Jul 2019 15:52:08 +0200
Message-Id: <20190704135208.32104-4-narmstrong@baylibre.com>
In-Reply-To: <20190704135208.32104-1-narmstrong@baylibre.com>
References: <20190704135208.32104-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

Add support for the new mode_valid() display op to filter out unsupported
display DMT timings.

This is useful when connected to 4k displays, since we only support DMT
monitors up to 1920x1080, the 4k native timings are discarded to select
supported timings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/video/meson/meson_dw_hdmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 483c93f6b6..617f75724b 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -426,9 +426,16 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 	return ret;
 }
 
+static bool meson_dw_hdmi_mode_valid(struct udevice *dev,
+				     const struct display_timing *timing)
+{
+	return meson_venc_hdmi_supported_mode(timing);
+}
+
 static const struct dm_display_ops meson_dw_hdmi_ops = {
 	.read_edid = meson_dw_hdmi_read_edid,
 	.enable = meson_dw_hdmi_enable,
+	.mode_valid = meson_dw_hdmi_mode_valid,
 };
 
 static const struct udevice_id meson_dw_hdmi_ids[] = {
-- 
2.21.0

