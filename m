Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web10.26194.1578856020068747280
 for <u-boot-amlogic@groups.io>;
 Sun, 12 Jan 2020 11:07:00 -0800
Received: by mail-io1-f66.google.com with SMTP id c16so7261867ioh.6
        for <u-boot-amlogic@groups.io>; Sun, 12 Jan 2020 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFSKUcoy4IMSqG7Yqvh0sJwPs2yaR8KZvcMKCpo30Zw=;
        b=TyIwuux0qgBHp2k5i+iNVOiRwFHKG9naK4F8M7MqG5J/zva43MWByjRYA8Po2jYciP
         oRQFssa+DItBbi+W/90bQJmygTNKtjQSdShuCTXlA62bxAiVHIVE34pAAYvgOAFf5VV6
         G8LsjYSG+lY6cyNu9uf2hWKeIFVSNqw2npo+w=
Return-Path: <sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/33] power-domain: Rename free() to rfree()
Date: Sun, 12 Jan 2020 12:05:56 -0700
Message-Id: <20200112120216.5.I6fda8248defd1b62c3653e578da37986cf89cc0d@changeid>
In-Reply-To: <20200112190624.79077-1-sjg@chromium.org>
References: <20200112190624.79077-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>, GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Jaehoon Chung <jh80.chung@samsung.com>, Lokesh Vutla <lokeshvutla@ti.com>, Neil Armstrong <narmstrong@baylibre.com>, Nishanth Menon <nm@ti.com>, Patrick Wildt <patrick@blueri.se>, Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Ye Li <ye.li@nxp.com>, u-boot-amlogic@groups.io
List-ID: <u-boot-amlogic@groups.io>

This function name conflicts with our desire to #define free() to
something else on sandbox. Since it deals with resources, rename it to
rfree().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/power/domain/bcm6328-power-domain.c     | 2 +-
 drivers/power/domain/imx8-power-domain-legacy.c | 2 +-
 drivers/power/domain/imx8-power-domain.c        | 2 +-
 drivers/power/domain/imx8m-power-domain.c       | 2 +-
 drivers/power/domain/meson-ee-pwrc.c            | 2 +-
 drivers/power/domain/meson-gx-pwrc-vpu.c        | 2 +-
 drivers/power/domain/mtk-power-domain.c         | 2 +-
 drivers/power/domain/power-domain-uclass.c      | 2 +-
 drivers/power/domain/sandbox-power-domain.c     | 2 +-
 drivers/power/domain/tegra186-power-domain.c    | 2 +-
 drivers/power/domain/ti-sci-power-domain.c      | 2 +-
 include/power-domain-uclass.h                   | 4 ++--
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/domain/bcm6328-power-domain.c b/drivers/power/domain/bcm6328-power-domain.c
index a90b2c83df..425451e4cd 100644
--- a/drivers/power/domain/bcm6328-power-domain.c
+++ b/drivers/power/domain/bcm6328-power-domain.c
@@ -62,7 +62,7 @@ static const struct udevice_id bcm6328_power_domain_ids[] = {
 };
 
 struct power_domain_ops bcm6328_power_domain_ops = {
-	.free = bcm6328_power_domain_free,
+	.rfree = bcm6328_power_domain_free,
 	.off = bcm6328_power_domain_off,
 	.on = bcm6328_power_domain_on,
 	.request = bcm6328_power_domain_request,
diff --git a/drivers/power/domain/imx8-power-domain-legacy.c b/drivers/power/domain/imx8-power-domain-legacy.c
index d51dbaa6c0..74fcb05c15 100644
--- a/drivers/power/domain/imx8-power-domain-legacy.c
+++ b/drivers/power/domain/imx8-power-domain-legacy.c
@@ -296,7 +296,7 @@ static const struct udevice_id imx8_power_domain_ids[] = {
 
 struct power_domain_ops imx8_power_domain_ops = {
 	.request = imx8_power_domain_request,
-	.free = imx8_power_domain_free,
+	.rfree = imx8_power_domain_free,
 	.on = imx8_power_domain_on,
 	.off = imx8_power_domain_off,
 	.of_xlate = imx8_power_domain_of_xlate,
diff --git a/drivers/power/domain/imx8-power-domain.c b/drivers/power/domain/imx8-power-domain.c
index aa768365b4..8e328f02c2 100644
--- a/drivers/power/domain/imx8-power-domain.c
+++ b/drivers/power/domain/imx8-power-domain.c
@@ -73,7 +73,7 @@ static const struct udevice_id imx8_power_domain_ids[] = {
 
 struct power_domain_ops imx8_power_domain_ops_v2 = {
 	.request = imx8_power_domain_request,
-	.free = imx8_power_domain_free,
+	.rfree = imx8_power_domain_free,
 	.on = imx8_power_domain_on,
 	.off = imx8_power_domain_off,
 };
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index 40ece9ee3f..fbfd17718b 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -121,7 +121,7 @@ static const struct udevice_id imx8m_power_domain_ids[] = {
 
 struct power_domain_ops imx8m_power_domain_ops = {
 	.request = imx8m_power_domain_request,
-	.free = imx8m_power_domain_free,
+	.rfree = imx8m_power_domain_free,
 	.on = imx8m_power_domain_on,
 	.off = imx8m_power_domain_off,
 	.of_xlate = imx8m_power_domain_of_xlate,
diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 21d4c9d4dd..7f5d13e872 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -352,7 +352,7 @@ static int meson_ee_pwrc_of_xlate(struct power_domain *power_domain,
 }
 
 struct power_domain_ops meson_ee_pwrc_ops = {
-	.free = meson_ee_pwrc_free,
+	.rfree = meson_ee_pwrc_free,
 	.off = meson_ee_pwrc_off,
 	.on = meson_ee_pwrc_on,
 	.request = meson_ee_pwrc_request,
diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
index f44e33bacb..bd69aea8dd 100644
--- a/drivers/power/domain/meson-gx-pwrc-vpu.c
+++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
@@ -269,7 +269,7 @@ static int meson_pwrc_vpu_of_xlate(struct power_domain *power_domain,
 }
 
 struct power_domain_ops meson_gx_pwrc_vpu_ops = {
-	.free = meson_pwrc_vpu_free,
+	.rfree = meson_pwrc_vpu_free,
 	.off = meson_pwrc_vpu_off,
 	.on = meson_pwrc_vpu_on,
 	.request = meson_pwrc_vpu_request,
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index c67e8804b1..992ee51947 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -390,7 +390,7 @@ static const struct udevice_id mtk_power_domain_ids[] = {
 };
 
 struct power_domain_ops mtk_power_domain_ops = {
-	.free = scpsys_power_free,
+	.rfree = scpsys_power_free,
 	.off = scpsys_power_off,
 	.on = scpsys_power_on,
 	.request = scpsys_power_request,
diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index 80df5aff50..be0a8026f6 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -87,7 +87,7 @@ int power_domain_free(struct power_domain *power_domain)
 
 	debug("%s(power_domain=%p)\n", __func__, power_domain);
 
-	return ops->free(power_domain);
+	return ops->rfree(power_domain);
 }
 
 int power_domain_on(struct power_domain *power_domain)
diff --git a/drivers/power/domain/sandbox-power-domain.c b/drivers/power/domain/sandbox-power-domain.c
index 74db2eba7e..a5ae235d53 100644
--- a/drivers/power/domain/sandbox-power-domain.c
+++ b/drivers/power/domain/sandbox-power-domain.c
@@ -75,7 +75,7 @@ static const struct udevice_id sandbox_power_domain_ids[] = {
 
 struct power_domain_ops sandbox_power_domain_ops = {
 	.request = sandbox_power_domain_request,
-	.free = sandbox_power_domain_free,
+	.rfree = sandbox_power_domain_free,
 	.on = sandbox_power_domain_on,
 	.off = sandbox_power_domain_off,
 };
diff --git a/drivers/power/domain/tegra186-power-domain.c b/drivers/power/domain/tegra186-power-domain.c
index f344558227..d2a25ca333 100644
--- a/drivers/power/domain/tegra186-power-domain.c
+++ b/drivers/power/domain/tegra186-power-domain.c
@@ -71,7 +71,7 @@ static int tegra186_power_domain_off(struct power_domain *power_domain)
 
 struct power_domain_ops tegra186_power_domain_ops = {
 	.request = tegra186_power_domain_request,
-	.free = tegra186_power_domain_free,
+	.rfree = tegra186_power_domain_free,
 	.on = tegra186_power_domain_on,
 	.off = tegra186_power_domain_off,
 };
diff --git a/drivers/power/domain/ti-sci-power-domain.c b/drivers/power/domain/ti-sci-power-domain.c
index 4c4351d2d9..b59af2b13b 100644
--- a/drivers/power/domain/ti-sci-power-domain.c
+++ b/drivers/power/domain/ti-sci-power-domain.c
@@ -120,7 +120,7 @@ static const struct udevice_id ti_sci_power_domain_of_match[] = {
 
 static struct power_domain_ops ti_sci_power_domain_ops = {
 	.request = ti_sci_power_domain_request,
-	.free = ti_sci_power_domain_free,
+	.rfree = ti_sci_power_domain_free,
 	.on = ti_sci_power_domain_on,
 	.off = ti_sci_power_domain_off,
 	.of_xlate = ti_sci_power_domain_of_xlate,
diff --git a/include/power-domain-uclass.h b/include/power-domain-uclass.h
index bd9906b2e7..acf749b38e 100644
--- a/include/power-domain-uclass.h
+++ b/include/power-domain-uclass.h
@@ -54,14 +54,14 @@ struct power_domain_ops {
 	 */
 	int (*request)(struct power_domain *power_domain);
 	/**
-	 * free - Free a previously requested power domain.
+	 * rfree - Free a previously requested power domain.
 	 *
 	 * This is the implementation of the client power_domain_free() API.
 	 *
 	 * @power_domain:	The power domain to free.
 	 * @return 0 if OK, or a negative error code.
 	 */
-	int (*free)(struct power_domain *power_domain);
+	int (*rfree)(struct power_domain *power_domain);
 	/**
 	 * on - Power on a power domain.
 	 *
-- 
2.25.0.rc1.283.g88dfdc4193-goog

