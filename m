Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web12.1090.1638384227799073288
 for <u-boot-amlogic@groups.io>;
 Wed, 01 Dec 2021 10:43:47 -0800
Received: by mail-qk1-f181.google.com with SMTP id i9so32098817qki.3
        for <u-boot-amlogic@groups.io>; Wed, 01 Dec 2021 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1i5gpERchbyLnXRKL4lQvA13oaUuqiAW22ZFwpDRqu0=;
        b=mc8O+W+BJKHRvNl+3eXo4wIn5DTi1U5+PNDjRQPUaIg4xwcGV7GSCAtJgumtm1llmI
         B0XuYmjwDsFhBFu7Rg21jQkn1FhUm+QEJQd8ycldL7JF+O62PyGaps/rYoYSHSAAClW+
         W18OK+WgxKJztozQ/AkKJHkfO9eZBRWbybbuLF0DkznFnnoUDp/YOtffloyZyzXuqnVB
         k3Gn0HtWaFv5TsTBbqMDwr3KPGL9m/Rnzs+M00BrDzgXlspN2TAU+xOWKVR6uxNmQ96A
         faU+yuiRrkkzl3YFX33i6lHBRcCIIul8niakfsF6VcZZwbrPYSIDhWlzpkrXd1wO7shD
         1Z0A==
Return-Path: <seanga2@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 5/5] clk: Add clk_get_by_name_optional
Date: Wed,  1 Dec 2021 13:43:32 -0500
Message-Id: <20211201184332.2166897-6-seanga2@gmail.com>
In-Reply-To: <20211201184332.2166897-1-seanga2@gmail.com>
References: <20211201184332.2166897-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dariobin@libero.it>, Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Michal Simek <monstr@monstr.eu>, Neil Armstrong <narmstrong@baylibre.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This adds a helper function for clk_get_by_name in cases where the clock is
optional. Hopefully this helps point driver writers in the right direction.
Also convert some existing users.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/clk/clk_zynq.c  |  5 +++--
 drivers/rng/meson-rng.c |  4 ++--
 include/clk.h           | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index 18915c3e04..e80500e382 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -472,8 +472,9 @@ static int zynq_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < 2; i++) {
 		sprintf(name, "gem%d_emio_clk", i);
-		ret = clk_get_by_name(dev, name, &priv->gem_emio_clk[i]);
-		if (ret < 0 && ret != -ENODATA) {
+		ret = clk_get_by_name_optional(dev, name,
+					       &priv->gem_emio_clk[i]);
+		if (ret) {
 			dev_err(dev, "failed to get %s clock\n", name);
 			return ret;
 		}
diff --git a/drivers/rng/meson-rng.c b/drivers/rng/meson-rng.c
index 5a4f45ad5a..e0a1e8c7e0 100644
--- a/drivers/rng/meson-rng.c
+++ b/drivers/rng/meson-rng.c
@@ -91,8 +91,8 @@ static int meson_rng_of_to_plat(struct udevice *dev)
 		return -ENODEV;
 
 	/* Get optional "core" clock */
-	err = clk_get_by_name(dev, "core", &pdata->clk);
-	if (err && err != -ENODATA)
+	err = clk_get_by_name_optional(dev, "core", &pdata->clk);
+	if (err)
 		return err;
 
 	return 0;
diff --git a/include/clk.h b/include/clk.h
index 103ef16bf9..36721188d0 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -292,6 +292,30 @@ static inline int clk_release_all(struct clk *clk, int count)
 }
 #endif
 
+/**
+ * clk_get_by_name_optional() - Get/request a optional clock by name.
+ * @dev:	The client device.
+ * @name:	The name of the clock to request, within the client's list of
+ *		clocks.
+ * @clk:	A pointer to a clock struct to initialize.
+ *
+ * Behaves the same as clk_get_by_name(), except when there is no clock
+ * provider. In the latter case, return 0.
+ *
+ * Return: 0 if OK, or a negative error code.
+ */
+static inline int clk_get_by_name_optional(struct udevice *dev,
+					   const char *name, struct clk *clk)
+{
+	int ret;
+
+	ret = clk_get_by_name_optional(dev, name, clk);
+	if (ret == -ENODATA)
+		return 0;
+
+	return ret;
+}
+
 /**
  * clk_get_by_name_nodev_optional - Get/request an optinonal clock by name
  *		without a device.
-- 
2.33.0

