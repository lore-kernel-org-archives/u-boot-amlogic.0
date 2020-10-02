Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.web11.10251.1601629545536667432
 for <u-boot-amlogic@groups.io>;
 Fri, 02 Oct 2020 02:05:46 -0700
Received: by mail-wr1-f67.google.com with SMTP id e16so940938wrm.2
        for <u-boot-amlogic@groups.io>; Fri, 02 Oct 2020 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5n1a6LAl4rG1ss+A4vM1elXk68dy2uOoIyjM7mC/xfw=;
        b=R/a7jbgAdKWg5v6NXO+LEPRd1al+DKSggQlMfsswZluCbGKzV88CedTwbJiV9vIU6x
         41CA4T3b+2AE38Z5uNwtsO77gmkuy+1Nw3Kd8CH6ACeVua9e95boqcY4kBg6cC/mAvhA
         IgzM3fszkxVfbTlpLpmf9gqCyive8IdwZwV4TlSDFEY8YXxDz1rWj96rFUolIIHR2/85
         IVDHsqHtD9IhkfYNMsQJTT0f/ZBPE8vdNrCme7ic0p45qYZ35dbDc2TnDZ6uBBtQNK/w
         fxnC/B5Y9zxtYpfgIa1xvpMhVv0YGBVQKFr/pg4qs32PFnHGFcdzn7MjQxh0YN7dbv0R
         A5UA==
Return-Path: <narmstrong@baylibre.com>
From: "Neil Armstrong" <narmstrong@baylibre.com>
Subject: [PATCH 1/2] pinctrl: meson-axg-pmx: fix gpio request
Date: Fri,  2 Oct 2020 11:05:39 +0200
Message-Id: <20201002090540.1022341-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, Neil Armstrong <narmstrong@baylibre.com>
List-ID: <u-boot-amlogic@groups.io>

The AXG pmx driver gpio request offset needs the pin base to have the
correct pin number.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
index c6cb941d0a..cfe94cf9e1 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -165,7 +165,10 @@ const struct pinctrl_ops meson_axg_pinctrl_ops = {
 static int meson_axg_gpio_request(struct udevice *dev,
 				  unsigned int offset, const char *label)
 {
-	return meson_axg_pmx_update_function(dev->parent, offset, 0);
+	struct meson_pinctrl *priv = dev_get_priv(dev->parent);
+
+	return meson_axg_pmx_update_function(dev->parent,
+					     offset + priv->data->pin_base, 0);
 }
 
 static const struct dm_gpio_ops meson_axg_gpio_ops = {
-- 
2.25.1

