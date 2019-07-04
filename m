Received: by mail-wr1-f65.google.com with SMTP id p13so6711812wru.10
        for <u-boot-amlogic@groups.io>; Thu, 04 Jul 2019 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbfQ+Jmc8Su62WVi81909SfTWTAk8T56gH/qadrUWbk=;
        b=KtWFbORVctxdgFA0sqvB5nB3eFdFhP2j3Bo8+c2GOR11xL3wm4flnMdGAScDbvoLvf
         e+eBzDJkt+xdsNPEs76Ld+s1Q7UTalW6j+5QEqGeGOACsVZ9kKTeCx3uOwzVA7benUbG
         85cttu+/eHLa/B/pRPIIx0ovBuY8+6lntl+EnN4gUmt93cMSFIkgywdxi2ASWnngF3yz
         V7ZZUURSmYaCfg6B01x3Dw/yGThCdne+oe7lUa5BFkolc1Oe31Hbjrdt2xcboU1T3+tr
         cqdCylhZUtE05XSa6/kp/J0aRI5JKFlMgrUAf7U0HdUBZTbYISOrLA+EP3t12jk4nRnL
         8zFw==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/3] edid: add edid_get_timing_validate() variant to filter out edid modes
Date: Thu,  4 Jul 2019 15:52:06 +0200
Message-Id: <20190704135208.32104-2-narmstrong@baylibre.com>
In-Reply-To: <20190704135208.32104-1-narmstrong@baylibre.com>
References: <20190704135208.32104-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: agust@denx.de
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The original edid_get_timing() function returns the first valid timing,
but on some plaforms, we could only supports a subset of the listed
monitot's navite timing.

Let's introduce a edid_get_timing_validate() adding a mode_valid callback
including a private cookie pointer.

If the callback returns false, the current timing is discared and the next
one is checked. If no valid & supported timings are found, the function
would return an error.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 common/edid.c  | 22 +++++++++++++++++++---
 include/edid.h | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/common/edid.c b/common/edid.c
index 90d1167f6e..f244d26e04 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -168,8 +168,12 @@ static bool cea_is_hdmi_vsdb_present(struct edid_cea861_info *info)
 	return false;
 }
 
-int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
-		    int *panel_bits_per_colourp)
+int edid_get_timing_validate(u8 *buf, int buf_size,
+			     struct display_timing *timing,
+			     int *panel_bits_per_colourp,
+			     bool (*mode_valid)(void *priv,
+					const struct display_timing *timing),
+			     void *mode_valid_priv)
 {
 	struct edid1_info *edid = (struct edid1_info *)buf;
 	bool timing_done;
@@ -193,7 +197,11 @@ int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
 		desc = &edid->monitor_details.descriptor[i];
 		if (desc->zero_flag_1 != 0) {
 			decode_timing((u8 *)desc, timing);
-			timing_done = true;
+			if (mode_valid)
+				timing_done = mode_valid(mode_valid_priv,
+							 timing);
+			else
+				timing_done = true;
 			break;
 		}
 	}
@@ -225,6 +233,14 @@ int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
 	return 0;
 }
 
+int edid_get_timing(u8 *buf, int buf_size, struct display_timing *timing,
+		    int *panel_bits_per_colourp)
+{
+	return edid_get_timing_validate(buf, buf_size, timing,
+					panel_bits_per_colourp, NULL, NULL);
+}
+
+
 /**
  * Snip the tailing whitespace/return of a string.
  *
diff --git a/include/edid.h b/include/edid.h
index f05d2b82f2..2562733061 100644
--- a/include/edid.h
+++ b/include/edid.h
@@ -306,6 +306,28 @@ int edid_get_ranges(struct edid1_info *edid, unsigned int *hmin,
 
 struct display_timing;
 
+/**
+ * edid_get_timing_validate() - Get basic digital display parameters with
+ * mode selection callback
+ *
+ * @param buf		Buffer containing EDID data
+ * @param buf_size	Size of buffer in bytes
+ * @param timing	Place to put preferring timing information
+ * @param panel_bits_per_colourp	Place to put the number of bits per
+ *			colour supported by the panel. This will be set to
+ *			-1 if not available
+ * @param mode_valid	Callback validating mode, returning true is mode is
+ *			supported, false otherwise.
+ * @parem valid_priv	Pointer to private data for mode_valid callback
+ * @return 0 if timings are OK, -ve on error
+ */
+int edid_get_timing_validate(u8 *buf, int buf_size,
+			     struct display_timing *timing,
+			     int *panel_bits_per_colourp,
+			     bool (*mode_valid)(void *priv,
+					const struct display_timing *timing),
+			     void *mode_valid_priv);
+
 /**
  * edid_get_timing() - Get basic digital display parameters
  *
-- 
2.21.0

